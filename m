Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F210C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8511B10E3EB;
	Wed,  1 Jul 2026 17:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="BapJZe9B";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D8510E3EB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:05:42 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-472326ca506so703610f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782925541; x=1783530341;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvMe6A/UgVrym2bRYUnF2aCflCH0pJThY0gdvMKUcgc=;
 b=BapJZe9BMc6ts6ICPMZ+WbocKLhTmJuypInEOXIWyYxHexyFhvVc5pspN8/SUbKx8i
 EXyOQ4T+Zbx9EtI+h7QfDo5T/bjRTKL0mC9PEgxzpRuuQ6vs9uwtIU/60iWj/J5jSgKz
 bzJvhG1Nk5UCzqu9GFJEB/c9a++t2Qnyh/W+i2cmjhRlfyoulmT6WWn5XBpOclQ/bJn6
 aPOAg4Q3NCE/sNbTcLwCLv5gp3T6BTey4j+KxGQIeRuFFP6rWZbQGcI4Rn/cG5eWK99s
 Wq2raXE4KNb/JXaOQ6y67praULXKx3CxGvmE2Cv2fmsf0PaZu7HZI+PTbR2cGbxIcuvL
 w5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782925541; x=1783530341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvMe6A/UgVrym2bRYUnF2aCflCH0pJThY0gdvMKUcgc=;
 b=Gd6um72kX+vNIW+VcU5Mw5HONPFFosflez5RZ0uje8h1h3Xe82DVcFjamXvgHvt9lN
 Re5srPr6DLEo6ZeJwOau5WkYyXvWkihICU157fo3/7CCzx85/E9qvE3PHypL+ntMJ/jQ
 uHQYOqDubPJwgDGo+PZ9fYDFu9+Lj870Y412LhDXISfEM1Y967ts5NSdU9t77ZD1ZXij
 uFrt4CLCDrSO3RZMd5hCZ4Czs8ry6CERMi90QWcefzN20rL0v9LEavgXuVRV+gjny8NS
 Cf7jN4NHZ9B8PVH3hgSPkCBEyngCamJdfjjLrt4tHX4Yh+R0fFRUVjMTo/BNJq9OTKRt
 Rn1g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8DaMPcasi6q9ejeQZiQLEpRfDCqVIL9WGSeuxdHKBRXlI1GP2QLnfOfBf6MnlY/dEqEmJuAstUoA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzyj3wp/IluRW0w6rmFbcEgK2Cg4SKjfoIkYTW/tyePv0NFjDWy
 jnx1kerUh0Di3xgsZ5/rX92K4O2EtspBsYqg5hMgzGQ++LquZfHodiI4ijPINjIIBbk=
X-Gm-Gg: AfdE7ckVOuTO4tq1X++XURF3GFG60fzZqc0UPE/QXZOv1IPXPe5zmAE29yYZRFD0oGb
 zE15RIj9yNMTu0jeKYHNPa/9unXoWP0t/0DcLTCFzgFcqYKqZLCapNKNdqxoYDlLDYzv+tAWuAZ
 YsRbL+AfxrgjzyhRdwwVaRQfy+74RVb/sjRTYX2erLrPx23dpthiy5oNEstKyFovCEAmK+b5ReP
 6fkGO7SSJXAhk8HBa0DAeuM/eMkEatPi5sTt7BYpqOomKEZzkQfwTXs0ehJTzADwkLmTqgUewlF
 ItvMTbkINSLgjomi6ZF0HgVOOHG/eB9iHde1MIll+uD3SXDqMK4391pKD5cEXtTs1fbgi6MAGbP
 8Y9aelgO/0MqHp1jUmTAJwuzIvWwl5vxbMohcDjhG4OryZEAqjCT3V35KIIcpODZnFDHk3Rks17
 lvqGRvziS7edeD1jRczuriQum+E8ZJ67qjVY3tfVu9/T9WLEVc/iet69u+g2sGAZ7T+bC0H6g97
 PZf
X-Received: by 2002:a05:6000:25e3:b0:475:f0f0:9eec with SMTP id
 ffacd0b85a97d-4775ac9f5a1mr3984906f8f.49.1782925541284; 
 Wed, 01 Jul 2026 10:05:41 -0700 (PDT)
Received: from localhost
 (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-477db3dbb79sm1334344f8f.2.2026.07.01.10.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:05:40 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] drm/hyperv: Drop useless empty remove callback
Date: Wed,  1 Jul 2026 19:05:21 +0200
Message-ID: <8a85b5f4a5ed8ec35b5a213423d4be40e34f9cb9.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=fUoDHGx0vIkRkk7bgRX+e2vp2YXY3RA6x0vlWQS8YwE=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjWB9MX8EzJiYV20ypG8q4ZDwRP5fPJyrHEQ
 K+R6HWFg9aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVI1gAKCRCPgPtYfRL+
 TsuzB/wLTW0/yBRqnX/rTnGSm2/wzLrOc1svn/RdtcUCCJqJJzoUpA0vstagpmv7W4YnUc9LGd7
 Hau4gP9XyAG8CPZKqFmp+oQTm88dXMrM/Qjy2OTvns3CA19E4DqZNQ9vL33gsAYJPvh79+snr9a
 hbVrK5asZIuftv9GiRBDYxyVZuWmHYGVNoxzNzFDS7H0g9mj9JQ58eKQrcUv2JLhZ+in6mkw6Nu
 CHi+E21bFzIKBdKj/f9njge+6nU66Q84o1QQgggkaonc3bkrMrnpn/e5/g3SkIp0zgtKjWTDY/l
 s4tpFj4e/dCWYBnwFf0z8eWtcYT5921cDp+PtzW7bwr5p2LT
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Having an empty remove callback is equivalent to no remove callback.
(The only minor difference is that with an empty remove callback
pm_runtime_get_sync() and pm_runtime_put_noidle() are called.)

Drop this useless function.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index e766d87b7a9d..e3f41336a831 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -45,10 +45,6 @@ static int hv_drm_pci_probe(struct pci_dev *pdev,
 	return 0;
 }
 
-static void hv_drm_pci_remove(struct pci_dev *pdev)
-{
-}
-
 static const struct pci_device_id hv_drm_pci_tbl[] = {
 	{
 		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
@@ -64,7 +60,6 @@ static struct pci_driver hv_drm_pci_driver = {
 	.name =		KBUILD_MODNAME,
 	.id_table =	hv_drm_pci_tbl,
 	.probe =	hv_drm_pci_probe,
-	.remove =	hv_drm_pci_remove,
 };
 
 static int hv_drm_setup_vram(struct hv_drm_device *hv,
-- 
2.55.0.11.g153666a7d9bb

