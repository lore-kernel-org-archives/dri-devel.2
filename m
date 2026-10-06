Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32850CA5FFF
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 19:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F16210E3C6;
	Tue,  6 Oct 2026 19:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="sz3xgxAO";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00ECF10E3C6
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791314147;
 bh=hpl97+ku9fipOaiPOPhX4/9bl6wOTB5ubcj+qYtRS40=;
 h=Date:From:To:Subject:Cc:From;
 b=sz3xgxAO1/OyAXR5gzHkfii1Hzxo4EH9gOxnOmdBRJKHiDROvpMYYui3ujA/HfCj7
 GEJkfEzR0YM0x8W3XwmkE2+WQlagh5Fsen7yXnYD6lPJDQp3OXsJiCRqstWbPqWa5y
 JzkmweQQc3CdnnQv76uNS93gmbu9T9M0y2nmWCQynVV6YwTq0wPPS0GtnpHNsYygtG
 13QPp5UbrwJUp9nzhNwCVknRhFp/nETplXtlICHNZ7Ink2y1MBtCXUPkhKD65jsuxK
 gbTWB04UKVcc+xzZ1sFtTdQU8ptMamTtUx/bxPNZVVyz8qccWBGJKldy1QW+j2oi6R
 T03H9gEUTFX3g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hzmDs3Fksz4w2b;
 Wed, 07 Oct 2026 06:15:41 +1100 (AEDT)
Message-ID: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
Date: Tue, 6 Oct 2026 20:15:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH] dma-buf: Annul dmabuf->file on file release
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The dmabuf release path is split between file and dentry release:
dma_buf_file_release() is called shortly before the file is freed, and
dma_buf_release() calls an exporter's dmabuf->ops->release when the
dentry is freed.  However, the dentry can outlive the file (for
example, if opened with O_PATH), meaning .release might be called some
time after the file is freed.

This presents a window, when closing a DMABUF file, in which
dmabuf->file points to freed memory yet .release op has not yet been
called.

For VFIO, if a buffer's .release has not been called it's considered
still active and subject to move/cleanup.  If so, it attempts to
get_file_active() on dmabuf->file: a file close with dentry held open
will call this function with a stale pointer, a UAF.

To make this pattern safe, set dmabuf->file to NULL in
dma_buf_file_release() to reflect that the associated file is now dead
even if the DMABUF is not yet gone.  A get_file_active() ... fput()
sequence concurrent with a file close will only execute as one of:

  - Gets the file before file_ref_put() (dmabuf->file valid)
  - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
  - Observes dmabuf->file = NULL (no file)

Originally, drivers could assume dmabuf->file was valid until .release
was called from fops->release.  This assumption was no longer valid
after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
dentry_ops"), which moved the callback to the dentry release (by which
point the file might have been freed).  With this commit, drivers must
still consider that dmabuf->file could be NULL before .release.

Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---

Hi,

This issue was found (by Claude Opus 5.5) in the context of VFIO's
DMABUF export path.  VFIO iterates live DMABUFs with a
get_file_active()/fput() block, which now becomes safe if the file is
closed (and memory freed!) yet DMABUF .release hasn't yet occurred.

However, there are a couple of other places that directly use
dmabuf->file and seem able to race a closing file (i.e. without holding
the file reference)?  If this is so, they'd be a UAF today; with this
patch that goes away, but instead of a stale pointer dmabuf->file could
be NULL:

1. drivers/gpu/drm/vmwgfx/ttm_object.c:get_dma_buf_unless_doomed()

  file_ref_get(&dmabuf->file->f_ref); on a non-refcounted DMABUF

The commit message of 90ee6ed776c0 ("fs: port files to file_ref") hints
this might be more subtle than replacing it with a get_file() variant
(so as to accept a NULL file *).

2. drivers/gpu/drm/i915/gvt/dmabuf.c:intel_vgpu_get_dmabuf()

  gvt_dbg_dpy(... file_count(dmabuf->file) ...);


Respective vmwgfx & i915 maintainers, what is your view?
Or, indeed, if anyone sees any other questionable uses of dmabuf->file.

Thanks,


Matt


  drivers/dma-buf/dma-buf.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 4c9add51f9ef..726639130477 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -193,11 +193,15 @@ static void dma_buf_release(struct dentry *dentry)
  
  static int dma_buf_file_release(struct inode *inode, struct file *file)
  {
+	struct dma_buf *dmabuf = file->private_data;
+
  	if (!is_dma_buf_file(file))
  		return -EINVAL;
  
-	__dma_buf_list_del(file->private_data);
+	__dma_buf_list_del(dmabuf);
  
+	/* Must be observed by __get_file_rcu() before file_free() */
+	smp_store_mb(dmabuf->file, NULL);
  	return 0;
  }
  
-- 
2.47.3

