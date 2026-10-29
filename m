Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C765606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=BmClByXM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30488112470;
	Thu, 29 Oct 2026 17:18:50 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8760A10E152
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:23:18 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-93f36c18b75so128673885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1793290997; x=1793895797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pmMAA3zxsaH8NpSbi674z9mZNWB0uLuDo+2Mdyd35Hs=;
 b=BmClByXMe+4JnMzrht5BHgz+v7LH6Gv2XBhV4/LdyvT1YZDhZpvbKmA6GVBYCSuvQZ
 RoRkxxsHfC7v/WiXY+PZ91AAsYfHfZXkosUpQ9rsAIAi93DWvDzXtkswdzASW1a35hRx
 +l+q2KKwbd895l9abcSEgYvk3UxUGdnpgUeZKmh0bDssCyVzth4Y7J+0bCIFSyZVzwmA
 F0qnykpamk2RW/tFHMtIJqXOqJec7NZ4bwzTK3PBUzLY893dLQKZCoHTagekVpEorTWu
 M3QfKa24Sfc1eRisH1lyCXCnK0T2DrrwWtmWs4H1z00fnOx7+6wTzFXSltLlmzbPjp3B
 JPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290997; x=1793895797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pmMAA3zxsaH8NpSbi674z9mZNWB0uLuDo+2Mdyd35Hs=;
 b=WiyUolpnr5odRkVYDakax3dK+hU6MCJpkBNWY2wo2DdKRq5SWD2pMDT4WwQ/DfzTrF
 HrQI9r00QLrjN1ksK6bLSscJcwoByYteDGS/lf78nt578FVm98c5+xSy9zFrsTOHT2Ka
 Kjn5ErJFb7KFVNEK6yUZkPhMT9wZpLfYwUkTkF4K2dDa2oqJ7wHJys/IIheX4wtmemM1
 JQkEAc/153uY6/rjycIT22upmXeTlvcYeXpoIe3uHvwtOVI9L/63i84XliB7xpTXp1cO
 zCEZgsZf9jjeBkTlA7NHMlwIuOKOWg35xGttukuGG0V39JsC9pvKltHPhdl0YcpNqlhW
 6PPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxv4+fkubK+Sdz+mn0tSju7wtFLDA+7G3Mvda5e2hBmqt62YAxweFuPvSQdIRBtOL4X+TMm7CQvIR4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIVvecEpHE1pS8DNm1Qmxi5CvqCXOdaUTiYg2s4BcshhRrLVb3V
 mKzXO9MZdkqk1dQtpCbKDiW1y4b6H1hS+RNboLPlaKXcdeq3Loc/Ow660ID+eiB48Q==
X-Gm-Gg: AYBFou0OBvKjtzPqXl1UzQNP/YfoMhqXhpsgKm6pUZQZf5uNaJ/CeI+WRx85j30hRNX
 pZlH3zW/cNd57UedY69yjOYbIv2dskeD9AiN5lJnQV39dx8Z7CwLMSXWiv/GkB85o21mzsWqf46
 S+wDiuTf7Ofz/uqzq3rcWXuTdkNIKvuT3AVL+oufvbFK7z/27Q3abPZ6j1fAYdh6pVESFmn5Nw4
 /fPk2yuILLYc1fGFLTOGNYT32IJO0DRpBmbrCl/KvVFNFKS3stkAB7bUSxnQyjXxBqctHMJLaAp
 +ZWkdXxF7Y8NV+weN80HqHD8xHwbAxpb6rxVyrjSvR64WyvHKlrVLwGlJhAcvvR/qDRya9oInMG
 O6eh4VfoGJHiLNwZ3XbDmCS3tWDRf2PhzFzGgm6/UWnwp4W06t0FphJtIu0wkjYSAbrA13IlymO
 +RFVLH9wuMADET0nivogT9JxPuzXA90q61bzXmFcldnC2WEPBfjfCza70jDafJN+ryei43mID+j
 Gh4Cq4u3WRBO4WwoDYHdjI3QykyyFzMm8LSx+/dAE6XmQgjaSov4GS7jYFrTqcXVAcoes57wTxJ
 qnKknU/VD/gjo15MmWeqYfshBH6ZvPPVD4dCYug5HF45y52fucyw
X-Received: by 2002:a05:620a:1a10:b0:93a:9ef5:d370 with SMTP id
 af79cd13be357-9440893885amr892995885a.1.1793290997148; 
 Thu, 29 Oct 2026 09:23:17 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a771c9sm1565150285a.34.2026.10.29.09.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:23:16 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: x86@kernel.org
Cc: mario.limonciello@amd.com, tzimmermann@suse.de, aaron.ma@canonical.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] x86/video: Preserve the default VGA fallback for legacy modes
Date: Thu, 29 Oct 2026 12:23:11 -0400
Message-ID: <20261029162311.3389523-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:17:59 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
without screen info") made video_is_primary_device() rely exclusively
on screen_info resources whenever any are available.

However, screen_info_resources() also returns legacy I/O and memory
ranges for VGA text modes. These ranges are not PCI BARs, so the resource
lookup fails and the default VGA fallback is skipped.

On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA loses its DRM
boot_display attribute and fbcon leaves the console on VKMS. This can
be checked with:

    cat /sys/class/drm/card1/boot_display
    stty -F /dev/tty1 size

Without the fix, boot_display is missing and tty1 is 48 rows by 128
columns. With it, boot_display contains 1 and tty1 is 50 rows by 160
columns.

Use resource-based selection only for linear framebuffers. Fall back to
vga_default_device() for legacy display modes, while keeping EFI and
VESA framebuffer ownership authoritative.

Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() without screen info")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested in QEMU/KVM with identical KASAN configs: SeaBIOS VGA text mode
(with and without VKMS), VESA, and OVMF with one and two virtual GPUs.
All 26 guest-only helper checks pass, including EFI/VESA framebuffer
ownership, missing framebuffer resources, and addresses above 4 GiB.
Also build-tested x86-32 with/without CONFIG_SCREEN_INFO, and x86-64
without CONFIG_SCREEN_INFO.

 arch/x86/video/video-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 8ed82fff7638..b8f83346dfe8 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
 
 #ifdef CONFIG_SCREEN_INFO
 	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
-	if (numres > 0) {
+	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
 		for (i = 0; i < numres; ++i) {
 			if (!(res[i].flags & IORESOURCE_MEM))
 				continue;

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.53.0

