Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86495C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575DF10EA2F;
	Tue, 18 Aug 2026 08:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VsBni/9g";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FFD10E44D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:06:48 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so2825501f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787040407; x=1787645207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdfM282bTwDxgzUYhlGJdjRXvx9tdxayiYRVrgHSBtk=;
 b=VsBni/9gCdGfBZgesvugQWDF/Lz+AbgEh/q8flRLqONCtmR7+Rc84ZxldNbrmJhMUz
 EMWu2/AxWG1uxlLdnQ/+puKMZh/BiYuEGnswsvuR5TLh4pZghZT/2YOnJPpCpKr2veBN
 hITCmCtmLSO2Sbnxyq/ozVygmfRyuupvK+Tp8KjS/CYb1Y8fAqGGE8QeJiJWLIhTUDB0
 qmcojyeVyc/tU1fXkAhpdqGgxGEhRC/IhZLBe3P2TQg5dxL4viNarPlR9/vtyaljGWfK
 Rzlf7HDlP8BhOFSykKVfrHzj0eh3rZN/e7VmPz7NAWx9SWvmtU4xsHDqK0QLuwhWCcN8
 J0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040407; x=1787645207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FdfM282bTwDxgzUYhlGJdjRXvx9tdxayiYRVrgHSBtk=;
 b=AkzrU8/trrPLet1z+GAIjMhWcvXyaOgStOPoNtGomgTEl5DgjRYxvHkan0YcO+VgaA
 sdhKywVZb12XU49CTUKfWDwQdY3tvzOpJKoZBpjYZPLtl664OsnZK7Gwgt8QwwbAdPVM
 7TY/KZwIV6dYEeWAIh0PI1xuyfJatVY+BZ5H9RMh7eMcFQDAKrphYGUDpRxk0Xoi+MQf
 b/BiFTvz33YElTzqSHZxAjN5nDU/vxsdyIpv2s2upbR6yrnH8ffgoAAYTaKp8xNDtA+c
 yw+vowh7Rd/XhnV5880AQASuaaMpIluuD5YSeJTkeL1i4p683G8zL6oZz18kWL68UVxb
 ImiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqb6Q59fxkPBFFXZvu3A+X8Bqzih9gI0NvCiU2X0DlYt2Mst52tpZdBKA+7c3ZgAA1a5orpyH8l1O4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQz9GImCLgwb6pJBrQU7UREfFXRsJCJBGVNhgsb8nLl+nXRGee
 TLCu1b+2WPxLeLyRRz8hYaJG4zSF9DEU8O5xnwYbgrjKl/Z2rj+zbrb3
X-Gm-Gg: AR+sD12ci1XWr60fCymaQ1yCQ9yq2VKbt1ql5Plz3t9wxITsa31aRRlhZnngvHgSqFJ
 1/0B0yIy9rX+UIGbMmKPOVnlwnzTYKu10jdYCzSOt3djNO8oWIUKAfCO/iY4oETsacKbUyFoOkM
 4Y877WvsIKfLdryqExRtxy4rehE2m3ksnD9UOa+bbLNaEXnnw0YO5o/iwn1B5z0K67OHBKC6Lk4
 tCHCr+DHdXKmFoGUiUjvFAnjCyDWihWj+jM2Q5BaOIaAxTmBpExlrf/HH4jraEwZ0TtcSwXqAil
 reXM8dvTCo5YxluLpTiHkEQYTDPqLQtXWh//4w74/imOJpt7rpOpsJ+UHALrabFpE5rpPq1dqc0
 w4mDX1QxeeN344sI2OZywNTm39UmnwpjeYXgt7Niyri5oAfHvxGpHFp82NrQDhYwaAxjV8AiIVH
 pyabPnoikgtrWOzOJQmXn2OzaLhNSGirAAMl5gDLhgcFPQVtBFFWuqiNUAk5I+ap6ZTIpz12312
 ac=
X-Received: by 2002:a05:6000:41f7:b0:482:aa2a:52f6 with SMTP id
 ffacd0b85a97d-482aa2a5496mr7478849f8f.1.1787040407150; 
 Tue, 18 Aug 2026 01:06:47 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10367223f8f.9.2026.08.18.01.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:46 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v4 3/6] drm/ssd130x: Constify ssd130x_write_data() 'values'
 parameter
Date: Tue, 18 Aug 2026 11:06:23 +0300
Message-ID: <20260818080626.30430-4-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818080626.30430-1-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
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

At no point does ssd130x_write_data() change the bytes it receives via
the 'values' parameter. Constify the parameter so const-qualified
buffers pass through without casting away const.

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 1110aa63d066..a229d7a87da0 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -252,7 +252,7 @@ static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 /*
  * Helper to write data (SSD13XX_DATA) to the device.
  */
-static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
+static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values, int count)
 {
 	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
 }
-- 
2.55.0

