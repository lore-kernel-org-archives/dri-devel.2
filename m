Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9B606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=comlore-com.20260707.gappssmtp.com header.i=@comlore-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VmeFi2/B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F1211208D;
	Thu, 29 Oct 2026 08:05:03 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0ADC10E78A
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 05:23:24 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-91c11468b5fso18365146d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 22:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793251403; cv=none;
 d=google.com; s=arc-20260327;
 b=Y4fQGl+Y9Q/WtJ/e4B46Rxb2i/H6kfEk+NE8fwAsVmxIvwCnGjdztCjmGDDrLLAWVS
 gGezEPIRFsVLAIM37NK0Xscqu50iDNIB6P8UexUjNr+yEmq5xPU50M4HZKkpb28nxZA1
 Xb7OY3ihEYJ3uFL3pIQEtOxceKGcd4cKZDT7yFykwyJkZyi8RGpBX89k6RtkyhTtiv3F
 n8H1Aa4fKYT2ROjMm0UVg4FZfegxiUziE0+f74mTHT1X5120o4nFA9R0DQChPKdlX2wt
 LLUJWjwFISxitKJSQQRn1YfQHK1YV1CDXupzRkubZCBWFkuncXgmwqSStbVXjqYsUclk
 Vhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=3Lg+FgJV09tVnv78E8W4PKyxu20xSS1d1mIdbRMTE4Q=;
 fh=Vjrz/t1aVe9Lo5numsjvVP4rGCpx9bez6uWlHvXT/tY=;
 b=VWLFT5s3v4m65AYt6VxLWjgjLwtf3pRHlgfq3aAFY1fLRqRK4a7Mksvl755Xg2yORX
 AVoGd55ZJ7C6WW5z4M+uMLGTGQkf9q3TjKHBHKhr6V6sluUqMZqxJI3t//OyHKfGhxdA
 AH2Vc/01PvOJVc3ukCXiiFAQJyhiRCR50QkBmm+xJzln9VuDCQowyzh7CMnmaemhyAyp
 MpqQKRtIhQTx3OTYZ2gsLMASsP5Cg8bbCRXGrWRiCCqexpHeZTcMFwAA4xoUS6GKS6ir
 0mkS1jubsvM/o7hChayRd6Te8yBavTU+ECvDmxdVxZkKz2ZUBsfdMKf4NHYIwlbJpa+z
 SR6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=comlore-com.20260707.gappssmtp.com; s=20260707; t=1793251403; x=1793856203;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Lg+FgJV09tVnv78E8W4PKyxu20xSS1d1mIdbRMTE4Q=;
 b=VmeFi2/B8AMEBZ6ox06nh85Gq3mWe9woZlNP0WKWibHvTyGLNM+3yort5EGi4KsyeX
 pA70WCDPOntPNS9xaUpVoWWF68JFp4eRKbmh2VsADvbL35VCsveutK1mbtLpDJgjUDY/
 C/Kejy2StpoLQpFRAGpfeG4jUrRVky3iG1SNfLg3GI2X6DtQxlgolpVgt+MgSGpSc5Uk
 0BymlXkmhzT61kIIm+5YnLQ+htzTPhWcVmVeWg0ICQur13XfwaJoOa4VKwonyHZk8b5B
 tTsCa2I5s+o82NBvJe6OCuZbgrYtAdK/iX5AE3O382lNois+T7MKVNAIvrDNHatP772s
 AlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793251403; x=1793856203;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3Lg+FgJV09tVnv78E8W4PKyxu20xSS1d1mIdbRMTE4Q=;
 b=fJ7mXes/AoiRw23cDfKGGo2rJZVlFdFyzSK0XUWMNVRgzRroop7y+b1PQ2vxfpK9yL
 1/z9GpmRZVmki8PRCbaGGmGjTv3hqRy2n1qD9D3KR+XVD7BpBPiiBiTR+mswsq/feoGi
 X3qMpMtE2bjq6cLLFyxk9Ytx22ksYWaV4r6sdeVNh9DUh7/a827hi1JAIQdgik2QEd9R
 G7TI9ihy55VbR4t2P9Fwo25JnXevG10QN4yQUwIQGE6eDsDZcA8QJebLcZCmzmIKPvMC
 WnvSY/UYIzKAULJkDsJ2OQSACqEOIZUwRLyCl0TiB3kiJWmdkcO1BWMD7yNN3FFt+5rr
 bVuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgMMfvRWCx7r68kEYnPfcE9SpCYlD3xYd83GAL3etlrOhyVO38OcifruUl6SuCfMAn5MWDHyqZ7mk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJBFqJHFTncdu+k+WagRbXbH9KTbszo9ZWZ9jrETw9Iq6G1kImI
 GwTfahu2tnwmCOV5iw7Upbr6esoxvwzJ+lRriVFEmu+kqXKhhs/aM/hvINhdjoO74F7BL4eoUs6
 OnNShz2RKQI5Ns4Wi/tc5uIdU0LSNIy/UOFSMMrMS
X-Gm-Gg: AYBFou3VRc0EbUmyys4QxDxY1+deZ63rOmdOmgBXrCni/aERUwy9yV6mYTuuOWipRU0
 KFvxTfMFplqCnBEK1slH3MZWsItoSeiOho0Y51OQgMr3/H3dofGowPqBZHo2KfB7hdYq1Kq7Exf
 JBCOGmdcbuqdsk9I/sw7AwZsIhZVaISBtAoBLyfDDIIoc9JHiXfxvNA780gFUQuf9AZb42FH5Fu
 LCRFqidxdvomKNgzJCJw4YcZ4lia/JKoub5QVHGuoCN+ySdHSumb6qMgQf7Da3k+iaYPrSg2X3B
 Gg6P8OpWpIRRN92joiFI4+1Y0HpOQgmf+pEpNZPPJsWwtmlLToo3sWHpt323aThwhlCiWkkBFCR
 kfZGHfAA4U56ADRnHBxq83lhjd92nGCb2sBRIfAoqfFcd916oRneNP95f
X-Received: by 2002:a05:6214:238d:b0:914:47db:4640 with SMTP id
 6a1803df08f44-91c7cf96bb5mr75175836d6.19.1793251403564; Wed, 28 Oct 2026
 22:23:23 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 29 Oct 2026 00:23:22 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 28 Oct 2026 22:23:06 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Wed, 28 Oct 2026 22:20:28 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Wed, 28 Oct 2026 22:14:21 -0700
From: Ted Bullock <tbullock@comlore.com>
Date: Thu, 29 Oct 2026 00:23:22 -0500
X-Gm-Features: AclHuK_tNNj08QVgFsStypVC3FMQXg1t9_UmaQA8dmxpz6COnH-A2PgFV31jkL4
Message-ID: <CAMwFX_CpeF-K1-9R38Fscu7EghETOOV5FmJvd=8No7YhapvL1w@mail.gmail.com>
Subject: [RFC PATCH] drm/radeon: UVD GTT corruption and RV6xx coverage
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, airlied@gmail.com, simona@ffwll.ch, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I investigated video corruption on my older iMac7,1 (RV610/M74,
device ID 1002:94c8).

When the decoder was reading compressed video from system memory while
the GPU was drawing, it would corrupt video frames. Moving the input
to VRAM allowed frames to decode correctly. Disabling graphics draws
also stopped the corruption.

Here is a proposal to keep UVD buffers in VRAM for this family of
devices, as the driver already does for some other chips. The patch
covers RV610, RV620, RV630, RV635 and RV670. These chips share the
RV6xx decoder path and legacy R600 firmware, so I think they are
likely to have the same hardware requirements. Someone with the
other hardware would need to verify that.

I tested this on Debian.

I used Codex to help with the investigation, testing and patch.

Signed-off-by: Ted Bullock <tbullock@comlore.com>
---
 drivers/gpu/drm/radeon/radeon_cs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c
b/drivers/gpu/drm/radeon/radeon_cs.c
index 2db819a..9bfd3ea 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -125,11 +125,16 @@ static int radeon_cs_parser_relocs(struct
radeon_cs_parser *p)

 		/* The first reloc of an UVD job is the msg and that must be in
 		 * VRAM, the second reloc is the DPB and for WMV that must be in
-		 * VRAM as well. Also put everything into VRAM on AGP cards and older
-		 * IGP chips to avoid image corruptions
+		 * VRAM as well. Also put everything into VRAM on RV6xx, AGP cards
+		 * and older IGP chips to avoid image corruptions
 		 */
 		if (p->ring == R600_RING_TYPE_UVD_INDEX &&
 		    (i <= 0 || pci_find_capability(p->rdev->pdev, PCI_CAP_ID_AGP) ||
+		     p->rdev->family == CHIP_RV610 ||
+		     p->rdev->family == CHIP_RV620 ||
+		     p->rdev->family == CHIP_RV630 ||
+		     p->rdev->family == CHIP_RV635 ||
+		     p->rdev->family == CHIP_RV670 ||
 		     p->rdev->family == CHIP_RS780 ||
 		     p->rdev->family == CHIP_RS880)) {
