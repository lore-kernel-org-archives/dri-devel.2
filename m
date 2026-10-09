Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D682CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18F110E0CF;
	Fri,  9 Oct 2026 12:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="fKwdJ1yy";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCDD810FF71
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791549393;
 bh=zJnUMtE0sH0CISx9MqqvOOGAYYmvxKjdN07mJU6EPoc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fKwdJ1yyWC3TCjy69nztsAiPj9Df7HHX6pya+9DZkAsGEFi7pAH2WbERHjZEd8jlN
 8/x+lF2nCTgJCxGwBDoYCxkk6V5dzXnP8+9TN8+QwtxM2UBC+anuvSup12Nrd0j3Dm
 hzLi3wb367JKjIpNuIxULLaBZQArtPel3q0qMBjoTbfG5IS7OYuNAogIRBACLBO0LX
 Tx+SDS0qcRKeTEMe4ojzYnpQLJDSjSh3Nf7v9Tw8izxtwm9WfmsXFVlvDgXVlHD6YI
 mkZICfwYC5EePJ139iWlk1sqyLEgPhgmPvJz76bUA7USxS6mqDkdN691lCU7JHDJ2y
 f74hf0pohCxjw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j1RDw5v1gz4wTB;
 Fri, 09 Oct 2026 23:36:32 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/vmwgfx: Use get_file_active() for dmabuf->file
Date: Fri,  9 Oct 2026 13:35:55 +0100
Message-ID: <20261009123601.94079-2-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009123601.94079-1-matt@ozlabs.org>
References: <20261009123601.94079-1-matt@ozlabs.org>
MIME-Version: 1.0
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

4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
dentry_ops") moved the dmabuf .release, and broke the vmwgfx driver's
assumption that dmabuf->file would remain valid until release.
Currently, dmabuf->file can be stale after the file closes even if
.release has not yet been called, and a future commit makes
dmabuf->file become NULL instead of stale.

In preparation for that future commit, convert
get_dma_buf_unless_doomed() to use get_file_active(&dmabuf->file)
which is the safe method to access and get a reference, even when
dmabuf->file could be NULL.

Cc: stable@vger.kernel.org
Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index f9042bafdc93..9137a31eaa1a 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -471,7 +471,7 @@ void ttm_object_device_release(struct ttm_object_device **p_tdev)
  */
 static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
 {
-	return file_ref_get(&dmabuf->file->f_ref);
+	return get_file_active(&dmabuf->file) != NULL;
 }
 
 /**
-- 
2.47.3

