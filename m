Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF167606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=fWghMTVl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD0010F329;
	Tue,  3 Nov 2026 03:16:52 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2C710F329
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 03:16:45 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-8b0d63f60bcso30067327b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 19:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1793675804; x=1794280604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uOhm+s54EJ0EX2fxqNGDmYUe9ErMHJfnCFUvypWfkgk=;
 b=fWghMTVlJHEVfDJyWOgejLzFXToR16BihJE7uAMnOBAA2N5wbHvK0ggbXbcSZ4COAh
 MlY+Rnjcie6CN2kDTE5Q5/gU4GbDiOMuH4etHdzMqXotE0+Fv3+d+PNpFgtykwfEKkU6
 7eOSvclRTqH3rXmPr7gQNO5vEbwRDxW9gZnx+J4Z5Y8DI2mwKqZD0hAb+M8RWAugUysf
 0mv9g2IlRqnDPajL/BvqRP/ipv8kpTOLBmvbHyV/61xEq7M1MoDUoBMq9zISbgOzes6D
 QtMNYFJDpUoZ1HvnX2qV6JuPnTLgzsEuA5m530o+jPUrGYNMgR49hRUFkWByQosAfXOe
 qIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793675804; x=1794280604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOhm+s54EJ0EX2fxqNGDmYUe9ErMHJfnCFUvypWfkgk=;
 b=S0/mfZT5OXj1I7UVxc5UlQB8FvIt9ImSZZvt54n5XHm/6ypVDFPm0BDoNDZ2PArt1C
 CHMcPTk/sZsllNHOJM3cf33zj68bws93byzLJCnuYrXJEuFrdTlHVNZZAZbDA+TLNR2i
 A4vpk2xUI+Vz5fcWHyPQHkH1haFq5H/O0thxqp2cyj18c0g05ZEmxinDmvaKsfBLrBNT
 ZGukVUomlphOwemJkeyaegtiaNJ3W7JCALPORRQbxyi8UDhDEgheWFguEqLXtXsPmPBX
 AWvTz7LdVV/AwOnAsI/4uBM6i85DPbbg8pI12+PwEpv0aMy/xK3tlWSEzqR5tZ5HVNtx
 jgZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByiTjIZdaJOPgAbpW+7lhA8Yp9ziFbVEFbIjEyvXorwFql0c7zd/3VetyItq1vI7DLu8Rs5CtTqF1U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+vGjLEbU3uwXUKQGH6tr1wrO4lpaDy3zxv270PnCgN0B+WR1Os
 S/3JhghwuvP0e/UijtF+M3dEtCKUMlfQa01qc/UWlD1tk1YAxdYbTIDOlkcRMKJZXw==
X-Gm-Gg: AYBFou3fMnMfOkBOWHwwUZXZJFPDDwOSiroYWsOc+3S5QTt0MVMd7Tj1jzkPQORyT03
 bUs4BX95eE7IcZXnIyAqe0cpQCgYHp3wpAcLepgA/nNCbU0cbIktnl15RzfkbFJb1gdreV1hwr6
 hKIERlHgT9CXdFBQDdDJxCXP4wvpwzZ7eB7ZCs4Mt2KUNnUTE5uXvkD2sjLOHFCA9aB1HE48rCG
 ut2f824aS2dcaFdbim12B5gWXXzFiURqsp1RWfqTLC8Mr/g0wfEKs+8vrwYa4flhvMJt3881bKd
 XM+a+LLfeTEA9VvkzGVIe/BW7ALW5FgbCWZjNt5itgJENLp3NB2oNz+frtESC7BEeNwKlwMJ06R
 Rcaajf2cLZ8BMCvPapANvbCf7Rm6jfV78zC2CUI3f7nJs9DX2Ue9FPyXomtAwtXB1nIxhNvafaI
 63EY9kvZpck8H33ugxZRgNMO8DVqfw7xOSVKxP17hvtTzLgOqt33x1h2u7u+eGEZvwblT0uOrCY
 XlazaMzRGo0yMdHab7911QUbFmbRO6GAB0qsFY4IkverWpHj34mzUaV43DQKlf9SBno0EMXAtDO
 iruWWp4bWMg4l+JXsWvQ3HbYvM32vXBSMr7MsCSbLMaUn/IKEQE=
X-Received: by 2002:a05:690c:c4e5:b0:8b0:cfe6:29db with SMTP id
 00721157ae682-8b2b65945f0mr85196617b3.5.1793675804207; 
 Mon, 02 Nov 2026 19:16:44 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b7123febsm64624997b3.14.2026.11.02.19.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 19:16:43 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: x86@kernel.org
Cc: bp@alien8.de, mario.limonciello@amd.com, superm1@kernel.org,
 tzimmermann@suse.de, aaron.ma@canonical.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] x86/video: Preserve the default VGA fallback for legacy
 modes
Date: Mon,  2 Nov 2026 22:16:30 -0500
Message-ID: <20261103031630.2085194-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
ranges for VGA text modes. These ranges are not PCI BARs, so
pci_find_resource() does not find them and the default VGA fallback is
skipped. As a result, no device is primary in VGA text mode.

On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA (bochs) loses
its DRM boot_display attribute. VKMS registers fb0 and bochs registers
fb1. VKMS is not a PCI device, so it is not primary either. With no
primary device, fbcon keeps the console on fb0 and never remaps it to
bochs. This can be checked with:

    cat /sys/class/drm/card1/boot_display
    stty -F /dev/tty1 size

Without the fix, boot_display is missing and tty1 is 48 rows by 128
columns. With it, boot_display contains 1 and tty1 is 50 rows by 160
columns. VKMS only makes the console part visible. Without VKMS, tty1
has the same size with and without the fix, but boot_display is still
missing without it.

Use resource-based selection only for linear framebuffers. Fall back to
vga_default_device() for legacy display modes, while keeping EFI and
VESA framebuffer ownership authoritative.

Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() without screen info")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Explain in the commit message why no device is primary in text mode
  and what VKMS shows (Boris, Thomas).
- Add the Reviewed-by tags. No code change.
- v1: https://lore.kernel.org/all/20261029162311.3389523-1-hengyul@cs.unc.edu/

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

