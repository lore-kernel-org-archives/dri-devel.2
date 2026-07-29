Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3F6C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F391410E1BE;
	Wed, 29 Jul 2026 05:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DGrpKhUt";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390D510E1BE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:31:21 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-51c0c45c580so3919331cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785303080; x=1785907880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLm9SWgFFlilgJjrWi7UDhw1Z9Vj6CQojSd23FGvUyc=;
 b=DGrpKhUtlzrvRIaxpNdJkQW4lc52ro9wuQ3Z+Fps4fgNa/1D8ELEQJhVcTtvIg5iI4
 L20vAIK82sUarcLnNWLvFVbsr3MJvg5ArbQDoUJCHynFtaUDXCbGuqZZcRT/L5vb5wY0
 +/VH6YeEpaYsCcJIaHPM19NCY1XxFJ4haIq80QQwGjjWtDelp62dU4wpILmrEhH8wicG
 EvcEVwg5+d4rKPDju0goFoeWoSJ2EQwKA8v8Pr9wzufVLQ6YxDa0p4Uo4rYQS4Q5+34V
 iRZ87anfxum9RncUiOgI2XeODW8YZPJDc7L+czFSUe2n3OPMcGxxOuO6hmoXGC/kIjhQ
 /DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785303080; x=1785907880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hLm9SWgFFlilgJjrWi7UDhw1Z9Vj6CQojSd23FGvUyc=;
 b=exRGNYoCz0Jy58scJOwhY5C6068i2JSt4FC1wL9WdsACEY7izxzBsxklpYY5DeMfPn
 AieYOs/4sopzyouGEUR9nnTBbwMgH9F1Q+Rhk1/rSKz/w2vuydqDQQtY8fP2wIguzzBp
 J0IucZ62+SBy3vWBpeJUOKgEdzk90oFAhQXP8adfI+LPza5NwWBnrnyAY92Vp+I95qHA
 S8G/HvtmycIQb5Qfc+mZzx++G1wrrCMjzYziYb/KIWzpFwP3jJfTWVCAt3gvtQ4Oms7e
 cTMYTII7zjiAVVzrqmBe5SKavbWjyBrush/LmT0NDYLcLH06g5cFkXksrtsE7ijtxLpO
 0UQg==
X-Gm-Message-State: AOJu0Yxg/S5kjQCS6d4gxLIV9fA4nrFMUZtMMhN/vG8RGpu9O++LHMzV
 HyxWubGKvpwyBoZ8qomt30AuJ8vxkJj3fDawuW6gGCXeWOoyecC6dnXT
X-Gm-Gg: AR+sD10YOhnEocbo74kL4u0GDqYTwPljxCbdhWtPkrCXC2mQSEswV/Ipj3HLjGOKRCu
 pReZ0mMFTh+2mvL4WoKitBytT3FPdbT2MbW2NUipiyNKIpIgipUJNcyHPm2yboO90ja8rTCKHAv
 CpW12bmU2UkTGg6OPqt4paa2vXiuaLv34wQrjGlIlvmG6p//BrrV3gAAcpOa/U7XyfwMNqaveUQ
 WW1s2YE9NtCAvxaJu6hNEVm4Q0DW+r690K8Ks6th2Exw7IGLhmtGn6Fp8y9HmkBC22eWDLBptAu
 5X6DARr2pof95TN1IUNjp7f7HRcSymPicRvvwMGOAzllfhIXVGQ5zoH6VRjb7TpnqX5qRus6yNM
 x3Uoz5XQDgTwx7sklglLRt92KldAO4JvmwImbuSDaYPamV6wZaM3ost+72a0oZErO+dX/X7Ot62
 EBOCX7jm7+AxFRDEnznaB26ZyzBeGzNIp61BT1bW6Y9/yS/aFcd+M8bR6p1G0=
X-Received: by 2002:a05:622a:5292:b0:51a:8c9c:7f52 with SMTP id
 d75a77b69052e-529d71475ffmr44443851cf.69.1785303080150; 
 Tue, 28 Jul 2026 22:31:20 -0700 (PDT)
Received: from thinker ([65.195.2.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2b1a1ddsm12592861cf.5.2026.07.28.22.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 22:31:19 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 2/2] drm/ssd130x: Add per-family update backlight logic
Date: Wed, 29 Jul 2026 08:30:54 +0300
Message-ID: <20260729053054.29374-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729053054.29374-1-amit.barzilai22@gmail.com>
References: <20260729053054.29374-1-amit.barzilai22@gmail.com>
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

ssd130x_update_bl() runs for every SSD13xx panel, but it only works for
SSD130x and SSD132x: it writes the single global SSD13XX_CONTRAST (0x81)
command, which those two families expose.  SSD133x has no such command --
it has three per-channel contrast registers (CONTRAST_A/B/C) that must be
scaled together -- so ssd130x_update_bl() has no effect on it.

Make backlight_ops.update_status a per-family choice.  SSD130x and SSD132x
keep ssd130x_update_bl() because they share the SSD13XX_CONTRAST interface,
while SSD133x gets ssd133x_update_bl(), which drives the three channels
through ssd133x_set_contrast().

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index f49e5245b216..0b0fc6fe3df2 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1711,8 +1711,25 @@ static int ssd130x_update_bl(struct backlight_device *bdev)
 	return 0;
 }
 
-static const struct backlight_ops ssd130xfb_bl_ops = {
-	.update_status	= ssd130x_update_bl,
+static int ssd133x_update_bl(struct backlight_device *bdev)
+{
+	struct ssd130x_device *ssd130x = bl_get_data(bdev);
+
+	ssd130x->contrast = backlight_get_brightness(bdev);
+
+	return ssd133x_set_contrast(ssd130x, ssd130x->contrast);
+}
+
+static const struct backlight_ops ssd130xfb_bl_ops[] = {
+	[SSD130X_FAMILY] = {
+		.update_status	= ssd130x_update_bl,
+	},
+	[SSD132X_FAMILY] = {
+		.update_status	= ssd130x_update_bl,
+	},
+	[SSD133X_FAMILY] = {
+		.update_status	= ssd133x_update_bl,
+	},
 };
 
 static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
@@ -1919,7 +1936,8 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 		return ERR_PTR(ret);
 
 	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
-					    &ssd130xfb_bl_ops, NULL);
+					    &ssd130xfb_bl_ops[ssd130x->device_info->family_id],
+					    NULL);
 	if (IS_ERR(bl))
 		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
 					     "Unable to register backlight device\n"));
-- 
2.55.0

