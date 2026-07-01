Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE40C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5693210EC75;
	Wed,  1 Jul 2026 17:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Kj03ffkF";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615A410E3EB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:05:44 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so6039305e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782925543; x=1783530343;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wswMVKIXyDkyPIt8Lte8A6zKftNJ6+VttcmMWxl5NiI=;
 b=Kj03ffkFzgqEnvvlFiybcAMsfF2mVHF7oSsCOjvbppnnkyfMaSK++5BvVWmrYhdE0I
 Yab/3aLs2+ka0VyeewIzhd/kOVuGb/KmoKslm20fEUCKntzrETVVBw9ggqOONTVFjmx/
 dwszqEBx6khEOT/Y6x7US1/nwBjBJ9vXAbgToBqueiqHG3Xt0TbqI07uHodcrN/qocwL
 qjQW0egXTJPCgJnFj3HgQsOZyOSCM3mupp7d4p9WNESUiquq7MHRh+MT5m07Y+DIH6WJ
 1CSn9nC+VeqQCbFdVb2i98drBVhM/RU731VyLcPrNu37fnMPwov/eX8sW/oSOXo03haq
 cP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782925543; x=1783530343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wswMVKIXyDkyPIt8Lte8A6zKftNJ6+VttcmMWxl5NiI=;
 b=cJ/g8irJF+9DP0QELbSAmScAWHtrouhIslG15wx0jxnh1t0zOGAtZ5/FFsgPWoI2PH
 ZjwvUB4rLL+GZNzEpfxJOIhUTqcortwsmrGWesau5v6s3FEvx/OwWiRRMa412DPd8PNT
 EQ3LNnHQkwb6jXMRF/iQjx6MpU5HUJua50L5U7QzTQd8ZQr3XiZ1aMXPV3ffgsymRLZy
 vbO22+OGO3b/Ju4I6LDDOHXP6bV8OWbF80QkP2A6Jy5Ha8ZUq3LreisdB4SORbuyxVzy
 IUxfpF+XFBAuocJ+MEPnyvm0GpVk5rcMmIC/yQ7nMrZe7y9vwew87Gv+pV0yePbhWA7W
 yd3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Tb4Q+/r8akAB5PsbOYaYlYjXNFARuA1R4icNBci03VooEXMIBzje57U9vEvSDyUg8dJKe+AErzzQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQR+uWEmpLiuVHP9ax6anSQhQ0Gndj2XrdcDqVxkuJpCEEtLzm
 +Js1fm+z5luLkEeLeid3vpK87hNhe0z4wkwBlrsAHn4gnlVUtWTz7kcvnGRUCiKwG7Q=
X-Gm-Gg: AfdE7clv1k9K4zyyCUxBc4uf0ZGnaYRmv7Gm7hnhSnKvZSHoYMfvDVivw2XiLBngPe6
 93/JL8Ppa6TPrsP2DSYkf9B78S8qAsHOzfmxtATkurEYnmT/uW8mqo9z60BS5fmlsvF26fWvAB0
 nXWy0Oqi/IOII92IcK1qzZ20T/UDKe1/qmyk2qRjYgaazFzl9cCC5/ISj48xMgtEnLUoXTIqugC
 mv2EwmSzg5sXuvVXpx3IWrNCJZfxcRxJ4fv10z2XCdv9AZVSW1FFyWT2TPcgPVSE22EnUXpz0Ww
 QGCRnPHKdfKfygq2VAZGKk8nOkVme1jPY1pRjAsK7PrQx33yWR0bsfv5hKSymMWBmfBLayHNO7O
 PqjYw5quuHzqR91UIwFkIY/hjYJZrNRhcMg7gb83IttMp1h6xslqGpnDcChvFLZPgOfbHawSqfJ
 MrvsouCz7yzaEEA0LkXNSnK9EcUFBRlreiKlhe9Iann63m6U/MFQoCdm51motYgomWJ7UoJEbZT
 BZ2
X-Received: by 2002:a05:600c:63c9:b0:493:bc80:69f with SMTP id
 5b1f17b1804b1-493c2b85658mr30786155e9.19.1782925542795; 
 Wed, 01 Jul 2026 10:05:42 -0700 (PDT)
Received: from localhost
 (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-477de3dd53fsm1210419f8f.37.2026.07.01.10.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:05:42 -0700 (PDT)
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
Subject: [PATCH v1 4/4] drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id
 arrays
Date: Wed,  1 Jul 2026 19:05:22 +0200
Message-ID: <7f9d4a239c76b6bb384048ea5591a21ed87d9b0e.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=0q1aVpO7t7+n6WZEaQyJdycCY7xEiMVwH6qz19u0bq8=;
 b=owGbwMvMwMXY3/A7olbonx/jabUkhixXjxtTJ/x9kq8pr3fnV8O9Lu9MyfSC3qnHGt4cWms4y
 /F/84fmTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmEiXOwbDh6t5X01XsfhqZ
 nD08SfaFg0h2l3JhiOO99/dnOMQUX7cs7y+v5ZDUtLpeePH4X/UdGQtW7rJc4R213cFVIr3qdDX
 /7LafCk1B791kFnEtstsa2b57c98+xvz3WuULF5dlGE30NmYQ+z45pcYj4krELjvHlyJuzEp3dr
 vOdW4xFf/x9V2G03lT115P727tWt8v5VPz42pdziRwrnO8vnptuPcTY15Pvg85T7XmR7lmOIt3S
 Ipde5Yr0r+NcXHEbMWowq2u0rOv2kee/ff5AvPZ3gmHfjgb7+OMTfvh9MRie7TW5Wyz0FSuvjv3
 tN+Fbdxt9cKZK3nlhz6vgrObU7Sriu/sbL76tDRr3zcbAA==
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

It matches the usual coding style to have the MODULE_DEVICE_TABLE macro
directly after the respective arrays.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index e3f41336a831..6a28048f687b 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -52,6 +52,7 @@ static const struct pci_device_id hv_drm_pci_tbl[] = {
 	},
 	{ /* end of list */ }
 };
+MODULE_DEVICE_TABLE(pci, hv_drm_pci_tbl);
 
 /*
  * PCI stub to support gen1 VM.
@@ -219,6 +220,7 @@ static const struct hv_vmbus_device_id hv_drm_vmbus_tbl[] = {
 	{HV_SYNTHVID_GUID},
 	{}
 };
+MODULE_DEVICE_TABLE(vmbus, hv_drm_vmbus_tbl);
 
 static struct hv_driver hv_drm_hv_driver = {
 	.name = KBUILD_MODNAME,
@@ -260,8 +262,6 @@ static void __exit hv_drm_exit(void)
 module_init(hv_drm_init);
 module_exit(hv_drm_exit);
 
-MODULE_DEVICE_TABLE(pci, hv_drm_pci_tbl);
-MODULE_DEVICE_TABLE(vmbus, hv_drm_vmbus_tbl);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Deepak Rawat <drawat.floss@gmail.com>");
 MODULE_DESCRIPTION("DRM driver for Hyper-V synthetic video device");
-- 
2.55.0.11.g153666a7d9bb

