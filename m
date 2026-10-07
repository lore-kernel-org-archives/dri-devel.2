Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675D8CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967F810E4D2;
	Wed,  7 Oct 2026 14:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="lMQEKyHw";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5759810E483
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791383388;
 bh=Frpe7KmlVXJrC4zHZSKF2Mb/ze/JwniZ8DHdvKQpV94=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lMQEKyHwZiapfiOzmHPYvVqwZG1khVfN0a7UrqVgeGec+b+1BU/f8EdP3fmelmMRo
 RdsTbHThPjUk0Ky1DUexTowrEmt9aATSh9FOL2f0zGfyqG/78z6Bk3nqqV3qO1wSXY
 tPHcPef9IVXHvtT1RUWizsSgqfSffpN793poi2WKGZ9YOStBZBmxssEgpGcn0+9Hy9
 5PIsini3bi46sitQYR9NYf2YnM/FI+6J72fE2F3d3/WbWB72OekHX9L6ZZ+xIk7iBC
 u8VSWEdjtYsF3x3l/Bbqea8pPc/JXJR14wxZ/n+Bbm9ULloSmKTERY71pa1ArmkNcO
 t08CXZBMNCZKg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j0FrP3sN6z4w2b;
 Thu, 08 Oct 2026 01:29:41 +1100 (AEDT)
Message-ID: <af2e03ca-718e-40c9-b604-8035eb8f30bd@ozlabs.org>
Date: Wed, 7 Oct 2026 15:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Annul dmabuf->file on file release
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>
References: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
 <7e8b332d-04a9-418a-95f4-de3cbd8b8a33@amd.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <7e8b332d-04a9-418a-95f4-de3cbd8b8a33@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Christian,

On 07/10/2026 08:51, Christian König wrote:
> Hi Matt,
> 
> On 10/6/26 21:15, Matt Evans wrote:
>> The dmabuf release path is split between file and dentry release:
>> dma_buf_file_release() is called shortly before the file is freed, and
>> dma_buf_release() calls an exporter's dmabuf->ops->release when the
>> dentry is freed.  However, the dentry can outlive the file (for
>> example, if opened with O_PATH), meaning .release might be called some
>> time after the file is freed.
>>
>> This presents a window, when closing a DMABUF file, in which
>> dmabuf->file points to freed memory yet .release op has not yet been
>> called.
>>
>> For VFIO, if a buffer's .release has not been called it's considered
>> still active and subject to move/cleanup.  If so, it attempts to
>> get_file_active() on dmabuf->file: a file close with dentry held open
>> will call this function with a stale pointer, a UAF.
>>
>> To make this pattern safe, set dmabuf->file to NULL in
>> dma_buf_file_release() to reflect that the associated file is now dead
>> even if the DMABUF is not yet gone.  A get_file_active() ... fput()
>> sequence concurrent with a file close will only execute as one of:
>>
>>  - Gets the file before file_ref_put() (dmabuf->file valid)
>>  - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
>>  - Observes dmabuf->file = NULL (no file)
>>
>> Originally, drivers could assume dmabuf->file was valid until .release
>> was called from fops->release.  This assumption was no longer valid
>> after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
>> dentry_ops"), which moved the callback to the dentry release (by which
>> point the file might have been freed).  With this commit, drivers must
>> still consider that dmabuf->file could be NULL before .release.
> 
> Oh well, really good catch. And that problem is wider than this.
>> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> We seriously need a CC: stable here.

I knew I forgot something :(
 >> ---
>>
>> Hi,
>>
>> This issue was found (by Claude Opus 5.5) in the context of VFIO's
>> DMABUF export path.  VFIO iterates live DMABUFs with a
>> get_file_active()/fput() block, which now becomes safe if the file is
>> closed (and memory freed!) yet DMABUF .release hasn't yet occurred.
>>
>> However, there are a couple of other places that directly use
>> dmabuf->file and seem able to race a closing file (i.e. without holding
>> the file reference)?  If this is so, they'd be a UAF today; with this
>> patch that goes away, but instead of a stale pointer dmabuf->file could
>> be NULL:
>>
>> 1. drivers/gpu/drm/vmwgfx/ttm_object.c:get_dma_buf_unless_doomed()
>>
>>  file_ref_get(&dmabuf->file->f_ref); on a non-refcounted DMABUF
>>
>> The commit message of 90ee6ed776c0 ("fs: port files to file_ref") hints
>> this might be more subtle than replacing it with a get_file() variant
>> (so as to accept a NULL file *).
>>
>> 2. drivers/gpu/drm/i915/gvt/dmabuf.c:intel_vgpu_get_dmabuf()
>>
>>  gvt_dbg_dpy(... file_count(dmabuf->file) ...);
>>
>>
>> Respective vmwgfx & i915 maintainers, what is your view?
>> Or, indeed, if anyone sees any other questionable uses of dmabuf->file.
> 
> *sigh* we had multiple occasions suggesting to add a dma_buf_get_rcu()/active() because exporters wanted to keep their DMA-buf on linked lists or other container structures.
> 
> That was always rejected because the DMA-buf framework had never guaranteed that such things work correctly exactly because of those lifetime issues here. In other words nobody thought that through and document what should happen when etc...
> 
> So the use cases in vmgfx and i915 are just the tip of the iceberg :)

Yay :)

> My suggestion is to get this patch reviewed and backported first and then come up with a dma_buf_get_active() function including documentation and comments and test case to make sure that this feature works *and* keeps working.
> 
> One minor comment below, apart from that the patch itself looks good to me.

This makes sense to me, thank you for the context also.

Just to make sure I thoroughly understand, do you envisage a 
dma_buf_get_active() to take both a reference on a dmabuf and its 
corresponding dmabuf->file so such users can move to a pattern of get-
test-use-put on the file portion too?  Sorry if it's a silly question, 
I'm not sure what to search for.

>>  drivers/dma-buf/dma-buf.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 4c9add51f9ef..726639130477 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -193,11 +193,15 @@ static void dma_buf_release(struct dentry *dentry)
>>  
>>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>>  {
>> +    struct dma_buf *dmabuf = file->private_data;
>> +
>>      if (!is_dma_buf_file(file))
>>          return -EINVAL;
> 
> I would do the casting only after the check.
> 
> On the other hand this function is a callback of the file_operations so checking if file->ops is really pointing to the file operations is completely superfluous.
> 
> So if you want to remove the check instead I'm perfectly fine with that as well.

I had given the unfamiliar code the benefit of the doubt, but this did 
look a bit suspect!  Will do, thanks.


Matt

PS: I should've mentioned that Alex Mastro has kindly built a reproducer 
using a VFIO DMABUF export and dentry-held-open scenario.  KASAN will 
detect the UAF:

 https://github.com/opsound/vfio-dmabuf-lab/blob/main/tests/vfio_dmabuf_opath_uaf_test.c

> 
> Regards,
> Christian.
> 
>>  
>> -    __dma_buf_list_del(file->private_data);
>> +    __dma_buf_list_del(dmabuf);
>>  
>> +    /* Must be observed by __get_file_rcu() before file_free() */
>> +    smp_store_mb(dmabuf->file, NULL);
>>      return 0;
>>  }
>>  
> 

