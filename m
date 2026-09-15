Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E35DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57ED10F825;
	Tue, 15 Sep 2026 01:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AyF6qQwP";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BFAF10F825
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 01:26:19 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-52fb76bcb1eso31546081cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789435578; x=1790040378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g87KMiRFdAPY30cDz1iKQzMln28+sYX6puXQlGcxBvE=;
 b=AyF6qQwPgW/G6yhdDwaaKFjtbyJ2D66bPSiaaVqbu0VeXPwMk2hJgaWYgMroPaQMjH
 LKRc5UgWUTMSg9Ru44pJ/O/oztrp0+u2m62fYjtd9js5VD3jDll4a9HXHyu6gtbiwo96
 hkO/fg9qgkUJrNc5fTM/21Pfi2lGLcGZIdIKGzygqc706wiplAc7tKaOwrWWYgvk2THd
 svDXthf89riA/b9lW3pSx0b4pKHtBGzRqx1S0kywdS6FEha1wiSb5ncvJF/U8I67kbpw
 9FN+juOT6MBa6j6+PdMUWkDTbYXQEAOARqZiTmZ3cawjaZS504Wgccp97EMlkYrkAZvg
 MNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789435578; x=1790040378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g87KMiRFdAPY30cDz1iKQzMln28+sYX6puXQlGcxBvE=;
 b=IxUiuokBLKI6nMm3LbKv3dLBTjjeOnFj2nc+YQyuVbyizf8cdtZynaQdDq07E60cwr
 UkdPBg1Vx/eH5+qFjj5X3wRHU9T8RxZPE1hhb8HpAEeK5RaYoFxRu2kQW15B3LvgQxCT
 DN6lDojQGXsiCwfjfPDqBSpkN/uJGr3IbiTf/yhD54HqIEHKtHIALVejiNk9tIIxPyHP
 2Hfsr2VaP5WPgxqJoKqrvw+6f860ARR/V37gzSStrBv5zsQ3gJSvtmJ5YJddaKXS0nVM
 yCeFY1JzB5jbBj+lsR+CfWrqDTnO3poNSh8hc9CSmXAZQk3z+WePuAqsLiOlTZFPL3oO
 nPRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1zTpaBq2G7LTTTIjtDESs9GWHxSSeQTXtg5pgq1cKfdiCTHNQz36hUvJ9W9w5O1hz4jjekkV2+Qk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kCTk6RrigQx3IN83gsTrqQnSff5AvYYL9hmYGvTefxF+tIt79a
 aZz/3B01NHl+u4Fzo9pWvx9dT8vl+WVuhc4ipn2inzg/QSQuT401K+w=
X-Gm-Gg: AYBFou14eV1UtpP2AJ3KztjFbuicPf1AeXEx9jwMIACsxlg1vZpKWctZZIxhNuZwqL0
 kLkhLhdTm0mnVyA4zO9IM3AolFP1JOZWozSbmopMbw+/qAxu1fTb829PPPLPMw4zCur6Fs4Yqvg
 NLKo34vPhgnOqGCbKCNnRYktQG/D7ShfaRtGXVpEWrFoRW2voZ7dZ0u7eqaOqzXv+MM+I3oHEW+
 YcJkrm/WCfu53WXi2UGBn3D1qOph18mf7Caw2zTrDfnxfBrs49mGT4gJ2DwyTOJT4E+8nPBDYhW
 o/0wBwbG9i34POu8Ci8UsUttqvWXpk6JKygGraj2p300/Q76NDVTUz0tRHjfbJ6hDNZFDQoI4Zi
 Tz2e8DVqMHHVrdq9g0ViKNCxLenQqkTEfxguUvjYApVb7pCNsbz8ICwsXNywF1STfnrsZ5qtvbK
 DBGNXPXs5ugV0FhaeuIs8unioC1uqzzxrfzGx5ROM3keZSf5dQnM8tT2CaMx140m4FqzFA+yycr
 DDsE+IkQql2jvSpdkAtS9TjenhMYcdmnrg0TWggtQ4d0+oURnyb4MOfXl4VNCo8mbzAh3CpmkT+
 TnGraPAGjysasD31H7vCQp3weEmzqPZ/6PvRRguO4Vn19/UDZLqUSJH54LBXGxp8R3pD9w==
X-Received: by 2002:a05:622a:941:20b0:531:dca:2e91 with SMTP id
 d75a77b69052e-5310dca3544mr52831701cf.30.1789435577831; 
 Mon, 14 Sep 2026 18:26:17 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu.
 [104.39.213.233]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5310cbf288dsm33662361cf.1.2026.09.14.18.26.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Sep 2026 18:26:16 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] drm/gma500: unwind resources on backlight init failure
Date: Mon, 14 Sep 2026 21:26:08 -0400
Message-ID: <20260915012608.65663-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

psb_driver_load() initializes KMS polling before it attempts to initialize
backlight support. If gma_backlight_init() fails, the function returns
directly and skips psb_driver_unload(), leaving the resources allocated
earlier in probe, including KMS polling, active.

Simply using out_err is not safe: a failed backlight_device_register()
leaves an error pointer in backlight_device, which gma_backlight_exit()
would pass to backlight_device_unregister().

Move backlight cleanup to psb_device_release(), which is registered only
after successful backlight initialization, and use out_err on backlight
initialization failure. This unwinds the earlier resources without trying
to unregister a failed backlight device. Normal device release and failure
to register the managed release action retain the existing cleanup order.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Move backlight cleanup to the managed release callback so the probe
  error path cannot unregister an ERR_PTR, addressing Patrik's feedback.

 drivers/gpu/drm/gma500/psb_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f535..c4cc4bf5f4 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -170,7 +170,6 @@ static void psb_driver_unload(struct drm_device *dev)
 
 	/* TODO: Kill vblank etc here */
 
-	gma_backlight_exit(dev);
 	psb_modeset_cleanup(dev);
 
 	gma_irq_uninstall(dev);
@@ -227,6 +226,7 @@ static void psb_device_release(void *data)
 {
 	struct drm_device *dev = data;
 
+	gma_backlight_exit(dev);
 	psb_driver_unload(dev);
 }
 
@@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (ret)
-		return ret;
+		goto out_err;
 	psb_intel_opregion_enable_asle(dev);
 
 	return devm_add_action_or_reset(dev->dev, psb_device_release, dev);
-- 
2.47.1
