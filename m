Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB47C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 03:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B10F10F13D;
	Fri, 31 Jul 2026 03:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKJMXrpP";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE4210F13D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 03:50:21 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso840714b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785469821; x=1786074621; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7tYOD5U8LDUg8wCJBQnEN76SNLP+kaPUCqH1WdlMtmg=;
 b=DKJMXrpPKnHwDw9V5gsjrYiHcDTcyy8CjhJqdGxs+FCVqVjS5BKqSKKv47tcryUT46
 lYYs9Kw33HI9Vk9y0KaRtp4sFPg0e69mNxqULDqy2Wl5ioZrKhoRN7AVjvpOoFK0B/kX
 GQ1VPO3iW4eIZHv1PQ9uIqvqB/9V/RDYimqGMo7SzfBJNgn/quhhYNJaVyscAV/3ZOcC
 epN92sgX9prtEWES+rDblXsBaKrsaYXTkJZk+3TzUaRE/Cah/8jqsv3C2PtchZcfxp2x
 g7zdxTbWcEmhtzGjgwrTYlA/57gyn7y2Apq7PMQN1MxaH6L2WW6nSZGG5kc8eJYGqOtm
 ttLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785469821; x=1786074621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7tYOD5U8LDUg8wCJBQnEN76SNLP+kaPUCqH1WdlMtmg=;
 b=SGyjPNoXxejvE+3a866QfHkGbKwTJESN8TM9uE3qjV2Gu+abvzW08jnKABCk6jlqwr
 A6JewDiOtZ0MRxmjEObFEQ3v2REZmxW+vq9AK4zFkx3giDOxhyueWceFOHS0FjfLjcuO
 LZtquxGAWkTVbbkmfIDatN3Tv+g35Q67J4hJ6+pR1V7RwzitWPKD0af8rxtPPzgiLEzA
 /SQrMP/CYmd/PiJc3kEDq98s9h7NWRBOrAbeBCWmn2eSx/XvvgPxOpPAY/sVqJPWyq6y
 L+HevwV+5z27Hzx7U7Gd4mFcdnc8WKhfBeySK6rXm+6a10btY/JruW5s6LVLSKb+1wnY
 Z0Pg==
X-Gm-Message-State: AOJu0YwvV2a9lYD6Fi4oJpdo6Q5E0dzy7kAMglJJask8zuGgDPKuUbiC
 x9wlBnJ4yFNTmmO+hum6EBmkcKv5V0+9w1cBEPIIJn51AlWD47faWNVn
X-Gm-Gg: AR+sD13nJ+i1BeXjsVh2vGL9gNVYXEr5Oh8PIHAZ2jdSykHI9jO5lGxqTawahEZX/Sg
 w9Ydl6lQRs9sNnXYvl7l3OQ+P8LYzcfdmkRFztJz3vmkKTYI2/GTpp2F2RGLH4wTyVtEzI0Q81L
 EN4uwpi4sZ2zUEKKM6ZjxFCrs1luBKFfJHoERNVJ7leGyOKIJr4DjnhOp/yBCA+S7wntqCPYE62
 qdMLiaAYLeTHOAFF9Amr0JwG1ffQCYulfuP1vTuDv1YL3vb+7Ekkv/F8DExHuuJ/yT5vxxi+GbN
 a06OqJJaD6OVCrBO9f9PaAiHaMidXtrO0LMqmHeKqHq9GSq6cluA3DLLwan0CUBXNWP438GT80O
 7ZhhrCrV7Ak/6n1fCBLJsq1leIeuaZmEUKIA+PE+2+MA+jiBlWQK1WpnEmX4/JCK9bTYwbwf7xM
 Ho7NnCCPe4Jb/P8Jc5YMPkv1ARFAL1ibB6W5Zpbwi9uxP++MUGPU2pRoPUgB8K2RbtnWpxgZi+A
 p79JoYKCuwZenCwlfwg6gX3IXI705BI0QhXf6QyU/pM7MfQ
X-Received: by 2002:a05:6a00:21d6:b0:848:4424:2b8e with SMTP id
 d2e1a72fcca58-84ed6bb1f0emr357100b3a.3.1785469820826; 
 Thu, 30 Jul 2026 20:50:20 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ed57cdc73sm175536b3a.17.2026.07.30.20.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 20:50:20 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Fri, 31 Jul 2026 11:50:12 +0800
Subject: [PATCH 1/3] drm/tiny: ssd16xx: send data entry mode on SSD1677
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ssd16xx-pixpaper-rpi5-v1-1-18ffc0dbf59a@gmail.com>
References: <20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com>
In-Reply-To: <20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com>
To: Devarsh Thakkar <devarsht@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Wig Cheng <onlywig@gmail.com>, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785469814; l=1869;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=z4d3np2g+THf1c9somcqqrQkcckofgb5yQUArwNmmUM=;
 b=ZHvlavtb2PXsG30FrKwInPAf+syvaRliRE+chki3jtDlXAFJSPPPyqo8nC38PDQdpjFCWHybx
 REL+PRsP2qHBQkXvMYuxXYYEvy5flrePsG3+HuHRvUlvId//qdRmgfS
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

skip_data_entry_mode assumes the SSD1677 scan direction is fixed in
hardware, so command 0x11 is never issued.  But ssd16xx_fb_dirty()
programs a reversed RAM window - end before start, address counter at
(max, max) - for the 90 and 180 degree orientations, and that only works
if the data entry mode was switched to the matching decrement direction.
Without it the counter runs past the end of the window and the pixel data
never reaches the visible RAM, while fb_dirty(), display_update() and the
BUSY wait all report success.

Drop the flag so hw_init() programs the orientation-dependent mode as it
does for the other controllers.

Tested on a Mayqueen PIXPAPER 4.26m (SSD1677, 800x480): rotation 180 now
renders correctly, which also shows that 0x11 does take effect on this
controller.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/ssd16xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ssd16xx.c b/drivers/gpu/drm/tiny/ssd16xx.c
index 50710fd66a70c011d1cf9d56a4bd53a93aee41b6..02a28c0e07085e35d5210b6e20c214b163ede88f 100644
--- a/drivers/gpu/drm/tiny/ssd16xx.c
+++ b/drivers/gpu/drm/tiny/ssd16xx.c
@@ -507,7 +507,6 @@ static const struct ssd16xx_controller_config ssd16xx_controller_configs[] = {
 		 * SSD1677 datasheet but BIT(3) semantics are undocumented;
 		 * included here pending hardware verification.
 		 * skip_sw_reset: SSD1677 uses GPIO reset; 0x12 is not needed.
-		 * skip_data_entry_mode: scan direction fixed by the controller.
 		 */
 		.max_width  = 960,
 		.max_height = 680,
@@ -526,7 +525,6 @@ static const struct ssd16xx_controller_config ssd16xx_controller_configs[] = {
 		},
 		.ctrl2_load_temp_lut     = SSD1683_CTRL2_LOAD_TEMP_LUT,
 		.skip_sw_reset           = true,
-		.skip_data_entry_mode    = true,
 	},
 };
 

-- 
2.34.1

