Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE625CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3870510FEF5;
	Fri,  9 Oct 2026 07:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="BB7h6WZ2";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0295710E94A
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 19:13:15 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-33fb4680717so2079328eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1791486794; x=1792091594;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mdYp5F0mgTxGu/EPWqlstTXyTWY/Kq4qdM3AvQLOhGc=;
 b=BB7h6WZ2UlQFHGqw23sMVKMZvLj1cdpOhGvVlugw8tbenZmuZZvBZL+DghJNfH7yOl
 pl4fry6z2a3GwdJUDtfvcc1L92NM3ompaxwey3tIyd2+xY1+gMCwrh/8VCpsK+Y3SrX8
 /UhxLeejq09edcKdA29B2CGSrwkFHtn+UXmh9Q4VJnFsAMLW3KUkuHG+k8dD95Omkk3K
 rBD9XSWHsW9Gv1B38ADjxAd+gR4BGYCr7MPLNUoHPWQTmKGxqNlZIBq2RwxDzSo7m+uf
 CTNaZPa5rH9dw4Sp2otiKPmKdSYL6oz7GeXaIpU+yhp/rQ4gIuierB7Wye/0or7h1/YA
 GwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486794; x=1792091594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mdYp5F0mgTxGu/EPWqlstTXyTWY/Kq4qdM3AvQLOhGc=;
 b=Qs/BOW6UBVkIxkV7KCN8RsDuJx0Odj/1Ab+yJGXw/Um///pFsoi2I0dDLiJP8aCWeD
 rf464W1Ir39NzlcvUvmySpe48e5PgzPQrt3USj0aFq0P5bd42Qv3dWeNEkl+h6Ep16lX
 ZUEKCOPoS4pf2QWbz3b2097xqcIZS/OGtxCIewGAhUCc0SiHv4DFtOo2UQlfoIlXfosK
 v/Hzj+SoN8TtW/Y3Uui5pqQk5FsFQ49xr9AjtxhBEebQxfj+f9v86NFXQnfp9aKKjnMG
 MfxVzUmSh3aQ+nLpLvj6NQWPix0WW+WcYuvATFmwZx7h5Qvn7MpHZwNs4zP6WfMLOcGv
 BJJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtKwmaOXInzS5DfD53RrvHvbxR8NKpqX4YMjjnrktA0YgYy1FEohPj1CZNVVHhGg/lptqu1Umpews=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLilZ7SGLArI+QU2yWSf/qS+gNxm5pysk51JikzWfzfqlEdaiy5
 KZE8wvjRSb1K3wGd1faCGdaGaFI0tbsRgFSYRpYnq32fQAIQqB1utUYtfZuH5ay5UjdZl69ONAA
 J+1GxrXAVSg==
X-Gm-Gg: AYBFou12fEhIdMgPMfyTHw3uqCiZHOwyi483xjQvnv0Kmo2TPIDtWEE9d9jZ+o55ANw
 SDZwp0FhoB7cCA2rK3IzdpPjnNp8AQvSnWMTSF9klR1+7SEcmsf/GSOmPC9zyWm6X7mKdlPbzcV
 ZnbBP3vBMO56q8CKhczij95Nz50J3eSws7h+WKNKgg92pVDRsAK+PqjEs3GlTMWuJ9AK0+u/NWl
 j6k4grKaU3rmgn0E1kgBPVbL4QDaR9r8Nxlp72SxSeU5igRXKz529rFXNmJNHC8CWQyCnFaU37/
 736VaIiHI62acNYES+AGs+OHrSstR3SjgUFI8jmbKqP7dUw/V8P0HCxqqNjDwxnqneXjSqZNuAR
 Dqmb15mTscCyZMvOYt3WIc5Z+Gyd3jGvxMrFVSX92f2jWiKEibYGenYpvMuvuDii8rBhoioVNXp
 r5eWc6nxBETkJljRY3VXF94EiyS827ywC8IxwoWtQytlI1YLhmpSVEQ0lV0z+AKG8Zd0QM8CKad
 69n/JnTnjT9O+wJeNoFwWOBrRHD1yETZdhhmSbyZI0b0P62EEzLXmkwzZnoSp+S2bWYGPA=
X-Received: by 2002:a05:693c:414b:20b0:351:1cc6:995e with SMTP id
 5a478bee46e88-3515dbea38fmr8630903eec.5.1791486794211; 
 Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 12:13:13 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Helge Deller <deller@gmx.de>, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] fbdev: hyperv_fb: Simplify hvfb_putmem
Date: Thu,  8 Oct 2026 15:13:04 -0400
Message-ID: <20261008191309.98263-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191309.98263-1-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit f5e728a50bb17336a20803dde488515b833ecd1d ]

The device object required in 'hvfb_release_phymem' function
for 'dma_free_coherent' can also be obtained from the 'info'
pointer, making 'hdev' parameter in 'hvfb_putmem' redundant.
Remove the unnecessary 'hdev' argument from 'hvfb_putmem'.

[ Backport to 6.6.y: Pass info->device through the target's
  hvfb_release_phymem() helper and remove the now-redundant hdev
  argument from each hvfb_putmem() call. ]

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1740845791-19977-2-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1740845791-19977-2-git-send-email-ssengar@linux.microsoft.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This is the prerequisite needed for the CVE-2025-21976 backport. Makes
hvfb_putmem() derive the device from fb_info, which permits the following
fix to move framebuffer-memory release into fb_destroy() and honor
outstanding open references.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 drivers/video/fbdev/hyperv_fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 80e8ec36b7db..80e6d9682179 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -973,7 +973,7 @@ static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
 }
 
 /* Release contiguous physical memory */
-static void hvfb_release_phymem(struct hv_device *hdev,
+static void hvfb_release_phymem(struct device *device,
 				phys_addr_t paddr, unsigned int size)
 {
 	unsigned int order = get_order(size);
@@ -981,7 +981,7 @@ static void hvfb_release_phymem(struct hv_device *hdev,
 	if (order <= MAX_ORDER)
 		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
 	else
-		dma_free_coherent(&hdev->device,
+		dma_free_coherent(device,
 				  round_up(size, PAGE_SIZE),
 				  phys_to_virt(paddr),
 				  paddr);
@@ -1100,7 +1100,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 }
 
 /* Release the framebuffer */
-static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
+static void hvfb_putmem(struct fb_info *info)
 {
 	struct hvfb_par *par = info->par;
 
@@ -1109,7 +1109,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
-		hvfb_release_phymem(hdev, info->fix.smem_start,
+		hvfb_release_phymem(info->device, info->fix.smem_start,
 				    screen_fb_size);
 	}
 
@@ -1223,7 +1223,7 @@ static int hvfb_probe(struct hv_device *hdev,
 
 error:
 	fb_deferred_io_cleanup(info);
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 error2:
 	vmbus_close(hdev->channel);
 error1:
@@ -1252,7 +1252,7 @@ static void hvfb_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 	framebuffer_release(info);
 }
 
-- 
2.39.5
