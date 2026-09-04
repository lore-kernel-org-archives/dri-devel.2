Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB2C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA0E10E618;
	Sat,  5 Sep 2026 15:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XNGzsRCL";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E2910E14E
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:26:52 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so1042125a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788524812; x=1789129612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XCWnmnyrXvFMshF1SLGpbxtR/Lc6PeZ58jpBs90dY2o=;
 b=XNGzsRCL7hA99Q7gI4sEwVjcKFOXqADJ/uC52Y8IWNPVIvqS6OHEQdjH2leVmiACYU
 c7gg9D9RqW5AqHQPaF26K+pI6hr69EHnUmuSKrdM1pfgXlgKN+TglgNr2nitSBsst4Dd
 uWtPRAS6zk0JUpxBcnj6AjCtgN2g+QC+IUglJfIP7t1+7R53mgNtsW3LS52Ves56qaFh
 IhtGwKZHbEi6Bnkxo00tZH/a2j6v/IWB8Ecq8YHB3hgFjLGHnLljh3EmuGBuSA+MFx2K
 Si7ERmSfexZiS7Slm5tsBn/pjys3+xpNEhW7hrz86D8SpWDU32cPnToQDQnwokRblWbs
 mbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524812; x=1789129612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XCWnmnyrXvFMshF1SLGpbxtR/Lc6PeZ58jpBs90dY2o=;
 b=a3Ev/zpA9aHdykGYtkXd8MtZ1OeYlwbPCcGrfzk8gEHkffeDUiXfExJ4auwEcQLBM3
 UYR6UVRiT7t9NO8TJMZfikX+Ns+RoB9VRr0aVNTNwQA3AVk7ZEFyoiAnA06HCPq6H1k1
 m9PZoR2znsgFAj0n4KY1M5SHfHQGY8DlSsQtU7TVwLFf1dY1orWPhuIdT1mSVbc/MiXc
 cuADXDhi9QH7nvFK4/ViMNg2uoROq8ap3SN5mJZfuGbLSFPd0p/Oy1vznwlRMLihrm8L
 NbJrXSnVpHq+b5+JUmZeHsPE72Fml8UtPVR+PbpW/b60OGeoCSxsD5YAgaSE0t46+/gY
 7jdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0nCRc92NDGytzetWOZCGqADdvqnWjzEMgWTI9TTDM36NDpxACVuBju+h3fxy3KIKjWQwxS4Km3M4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgAqowWz6jahy+hRfrclnNX3QmtNG2GeVPAlYms5NsBhZ88u0T
 5wzDfzXYWSgy10n+iXo9Wgf93um+PRP8HtCf57QY0zQ2zKw3xQOUeAoP
X-Gm-Gg: AYBFou2euXi+PNUs34KeGhI4tblHGHKcxIn87+HmNSam/HXWMRyD0Dqy1lw2rptrwko
 2UW4lYugH8i8O5F1qwRH0jtl4d5Urb6yAKlLBWYrmeg1/edbZwoZTfRHXcfdN/BgtoJ7yXuAxIM
 zSTHBaK8a2Rz0EJ6tJjSx0UYSGh9SswQfA4FC6jR/ujQnf742yqNCoP6Hqa4fmB9BMwfTo3xiXw
 JbKC+uZNZD5zvoNdPXMD3uDTw3rnkctD+duKt1F5N9ZJh1XJlliwZLnNTNFHQ0QGRKvXMNskG3s
 FVq1oQvdkkddM00htKbtnLe/rn1gmvexXNM8lDmZPNKcIT4vk6H1fjJd3lsKEnU8i+I4AuqXU1F
 EfRcuhlGEh+UwUE2twlFUyBHP2BZCcFbIeifkoxHTFfjM1n5ZZMQVxQYBXVEWOsWXIpYhshv08K
 E5XNXA2IePnx5yM2k7SMXRos77pnn2MNtHWKrCXKtVkx2bD1lqcoVoor+P6r6zT3tGayrSwjCRf
 U7B8G1oX81MiHilOq4FnvGR//A=
X-Received: by 2002:a17:90b:2e46:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-39b08653554mr16574087a91.19.1788524811722; 
 Fri, 04 Sep 2026 05:26:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbf1feesm6626601eec.26.2026.09.04.05.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:26:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Linus Walleij <linusw@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: fix typos in comments
Date: Fri,  4 Sep 2026 17:56:44 +0530
Message-ID: <20260904122646.32558-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/video/backlight/ili9320.c          | 2 +-
 drivers/video/backlight/ktd253-backlight.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
index 2df96a882119..d2f094dd7fc3 100644
--- a/drivers/video/backlight/ili9320.c
+++ b/drivers/video/backlight/ili9320.c
@@ -30,7 +30,7 @@ static inline int ili9320_write_spi(struct ili9320 *ili,
 	unsigned char *addr = spi->buffer_addr;
 	unsigned char *data = spi->buffer_data;
 
-	/* spi message consits of:
+	/* spi message consists of:
 	 * first byte: ID and operation
 	 */
 
diff --git a/drivers/video/backlight/ktd253-backlight.c b/drivers/video/backlight/ktd253-backlight.c
index 327b4ee75254..f2c5527d02e0 100644
--- a/drivers/video/backlight/ktd253-backlight.c
+++ b/drivers/video/backlight/ktd253-backlight.c
@@ -53,7 +53,7 @@ static int ktd253_backlight_stepdown(struct ktd253_backlight *ktd253)
 	 *
 	 * Architectures do not always support ndelay() and we will get a few us
 	 * instead. If we get to a critical time limit an interrupt has likely
-	 * occured in the low part of the loop and we need to restart from the
+	 * occurred in the low part of the loop and we need to restart from the
 	 * top so we have the backlight in a known state.
 	 */
 	u64 ns;
-- 
2.48.1

