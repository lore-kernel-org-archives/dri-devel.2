Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A0CEC01A2
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713EE10E26C;
	Mon, 23 Mar 2026 08:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DjFSpqOb";
	dkim-atps=neutral
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817AE10E16B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 09:52:14 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-56a9076813bso1375657e0c.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774173133; x=1774777933; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A0z8vkkJ6J9YgqDewSEz62c0xgaFgNlFmTCBQg8J1EQ=;
 b=DjFSpqObtNRBgNRkxNlC2tOZe2NV90PDeIlEKU+3e+Yh/xMw43n2Wv7+88uz/zaeJp
 YH56fQ1+w68+AFRaSoO4botEOR5291mL2l57X88CrwMQNcgw7I5qKJxTTQyncJaZOjRg
 t+iUUydJbUOhpeboySaIEgDALlPb9iB7iDbIPCVGH9mhouaq57doh9OjI6UQonOgTgED
 JCtgsuYj01mwVziyPvrAY73AyRSt9AJIViu14SKnRgzPbOe6Tfp5RCHhtOqgNM5WmWOQ
 vX9NfmHSu0nU775hrPWmYZG7jqEAm+x96+2p0KAWSl9FmX9SAHLBi0MugO+vbpt3+Pt5
 A+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774173133; x=1774777933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0z8vkkJ6J9YgqDewSEz62c0xgaFgNlFmTCBQg8J1EQ=;
 b=sja6SVBWpf0XL3bi3l9uQPLSOZnoPJgiV2eIVOELK5XqN8UcvAGBGdxP4IFWYKN5kp
 K3e28o/JsG+uNiGwmwbMwAOzNli23/JUCovurFhV58sXKWiCl3/669bkhWVt7oP2yqMa
 hy25o4hzYFnaFgDQZJz94Y5nw3zjH6x4+7hOjJmHWXBz0aCKMN34D6TL+rxXytcb3hVy
 AEGYdV2kBwX/5BzczUPNPS1QwwyefWKxfKRANTqaiLMYAC8Tr+SbdQ6kgodHxuZG3kZR
 UwhT+0XxkGOGdzK10ILW6nQRiAs89elBBOYuabCKugFcXhfhNSXBB/lHsCiwDmKl4Vjz
 zmgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGZbAsf3ztCjVVq25bIypimlvdiOVFLxnFa5nmpUmKsq77AS208FL5zTqcHDo4zF5sIOvrZ92RDYM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHaqCKqOCjkjwN/vl7QR3NPhmTeyw9AJYrtvZrWy3l0nU2fSTg
 08rIIQHK4B5LVC0zSFdxgqytw5X2DeCKwdUX4Ogti07USzr53fcjXqVY
X-Gm-Gg: ATEYQzw0rLMq7suRQwoty7ybaDko+uzh+tD/jGjcxr1+mK3hwRIaJJQ6+9nOmG5g32x
 A8SfgVv3uAcZrrj4CpCGl3MPYOFOaXORK5BqyLtsU3cffCp7bosDFynH+JXJLsMC09BQLaO6/su
 UVNmvVGc2CIQn8f5kDuS3HKtcIUhbpJSljU8KYtuCO72Ubwzb2U/P31+UFGZVzmXVgrhTu0pJF9
 ncPQmYC9BZRCcnXmTxYdq+9YhFz4bVOQgtY0nivEVAbRQRYkxi3FQO//TPmfF9qH532+Hktj24T
 JsQxtOiVITSYjZLFpVnIR+ycpk/mKD9wLEAtwr1Qf1pPGn0jjPZi9JSVFXy70T6fTuUXXWijdpv
 BhliRaWV00u/7jh8jMVyj/uQ/FAk5kNQaa3l1bSZ2S4pgP/vqu9gHz1/ZQtr8C8GLUxQXVdnw/i
 PwnqhmfGzZeqDMSiLg65n4ftyiJuOmPk6Iu2NR0JAsMg==
X-Received: by 2002:a05:6122:2883:b0:56c:d623:896e with SMTP id
 71dfb90a1353d-56cde465491mr3635672e0c.14.1774173133123; 
 Sun, 22 Mar 2026 02:52:13 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.57.219])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56cddb94eaasm7050081e0c.8.2026.03.22.02.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 02:52:11 -0700 (PDT)
From: guilhermeivo <guilhermeivob@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: guilherme.bozi@usp.br, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 guilhermeivo <guilhermeivob@gmail.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] drm/amd/display: Fix DDC register assignment type errors
Date: Sun, 22 Mar 2026 06:51:55 -0300
Message-ID: <20260322095155.248283-1-guilhermeivob@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

Fix invalid type assignments in ddc_sh_mask.

Signed-off-by: guilhermeivo <guilhermeivob@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603221553.GzXoxzCw-lkp@intel.com/
---
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
index 1f2bc7eea82e..863177cf67e8 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
@@ -11,8 +11,8 @@ static inline void dcn_define_ddc_registers_common(
 		uint32_t en,
 		const struct ddc_registers *data_regs,
 		const struct ddc_registers *clk_regs,
-		const struct ddc_shift *shift,
-		const struct ddc_mask *mask)
+		const struct ddc_sh_mask *shift,
+		const struct ddc_sh_mask *mask)
 {
 	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
 
-- 
2.47.3

