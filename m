Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0194C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E9910E343;
	Wed,  1 Jul 2026 17:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="dyeYN2GT";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86BC10E1E6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:05:39 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47248615e4dso908849f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782925538; x=1783530338;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFKScLlM0EIeDGkHczxDlJgqlt4gTY+6Wm9Zxks25pI=;
 b=dyeYN2GTS5j52BGo5Tr8Ow3Cjnj59lJhL+ntkQKGgeJBsDPgHq2qv9G1cIlv6A75uH
 hZBTVtkReO6E32YnAfEMywl7a25McAzrve/g5LNZWIOc5oTXs11mRg+N/taF2ZEG/N6s
 amISDmlimDAbHKFyylN3+ZLP/KooSpFGhi6dXIOcz3+j2jD/U6LBxl/XWOC/R6zbjspG
 mBGu5/UsF2e7u9Bvnhnk0KYCs5Gcv+c00bhynfl+FuggdAcIdz1kIx+HzFbZHRGRuOt/
 RLVvcO2SqTer1mMQy+dEccdFohf5mTvFzjtqyITXrRcHvV4lhS8DgptklpIm7E19W/zg
 kUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782925538; x=1783530338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MFKScLlM0EIeDGkHczxDlJgqlt4gTY+6Wm9Zxks25pI=;
 b=gMXuGqSIxMO2K8BSxLxOfdlynfdJqP4H8VB988l5kPBKOaEimvre1FdvnbhNVm7uH+
 nbo7N+luPayaw31lflsX7f4IoSABCXRPCsKFehDZvS7AqVg7lWR5JDsEwudIR6vqABNc
 nQPlgdTmRXFo1pqv3ex3HlhVPTznPeLoajI3z8By+OoEf3UwkOEzKN1icqq0BzowIjQk
 cZ9RGleIpU/vx4n9Fka0Q2WojQUtPqfSlYhZ9fyH22fVIDPMNa6BT6yFAmsXtF5i0GXN
 UlK0G7SIGkajT5qDBQiTeRDRJr4SmD4R2kEJZDfvFA1PSPUhwd3gIeE5bbj2DqA4SpXp
 LkzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jw+CaEJcoMBvkrL3pBROD0NeIMAy4XB7uvAuxT2H28r68dZXp6sUU6y0LX7Rv0cegk6pEYmQJ51w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP7yqy7cZXsbDhvqoG+yoFvc3Fk/J0GqqoqHPXBRLIRs9UItMY
 pqq0xsXE00LCozNGCFnr3Yk5bWHO1CwCNg1ubS2BsM0JEVoLW4A4nHIa0GBkg63py4Y=
X-Gm-Gg: AfdE7cltv3yRru5GSJK6u5/N+SDoWGJ155QBWaJ6kaUPhJfOlAd7VJqWoGWKV1DjaaF
 defR2420RKf//0HN/2z4SiFuIliKGVx8NbdbIUZCn4TMG/vUOBpF3+kkicya4GDKsNTpL8qHEGA
 YSnjdTMXdGp0kCtaAho21bgdKmIvmZbjzDhj08UcywX3uyzi1ANIyqQV8hlVrH1i8h2Tdj0SpIe
 M45bZQjEsYNwRnXokbpFBPkqth3S4qvo8rgNI80XWFzYJgrqWJyCGKg+aq0oiVoAfFmQseQcqfG
 USZZdC4DFMfSHc6VR4JpEH7tg1em7Cj6yzsezeI0OsZw5yEIlR9txFy2/o7p5fP000mgYW9pugZ
 QD7W9eCLMhNdCQIhEHCoffkIThWL+hSQP74njM4XLGhuHGzKglnZIUUB/3yMpp5+qc3y6eJO/yE
 n2BLCq3g6UxhAWioXR/WGCt5kxxDg1DybMFfDo0r6RDDhF1bSY7cqBgAdlMn2RFnre2TMubxxTz
 g1y
X-Received: by 2002:a05:600c:8715:b0:493:bed7:6d7c with SMTP id
 5b1f17b1804b1-493c2b8943dmr36997375e9.25.1782925538055; 
 Wed, 01 Jul 2026 10:05:38 -0700 (PDT)
Received: from localhost
 (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-477de3dd0b1sm1205357f8f.35.2026.07.01.10.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:05:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] drm/hyperv: Unregister pci driver in error path before
 module unload
Date: Wed,  1 Jul 2026 19:05:19 +0200
Message-ID: <4b7dbf00ce4ff664b7d5dd74b2f39d8d87c1ade9.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=v/yH1n/HDX+2d9l00KBsbf8zLWh3O2lf6A71bneiqvY=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjRj7fAruikQOdl4/UoTdt8wwXniHBJuknaa
 WzXEG04KxKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVI0QAKCRCPgPtYfRL+
 Tjs0CACxUT4WY9YoaXx0ruBhzpUNkISAvGOj92mNYvd8ovA3nMPRJBz20DZW240WRsJi5UFVkJY
 ixPDFhGYCtKl77PofmtiJ8Z52HKWovLU2hQTaar416FasDwJZUs3NOpo2/qs8j9Au0IwGggs7Cd
 /NQgiyJQoD8V9mUF3g3y3YaMtXVlXnil5a1qSAtdJpBcd8V6GVyeo9UhBIkrsGe/blyoDTbqbGz
 1bG8K3HgvHX9LUPVxwHWEnarO4HpcfU6FJLmS4CFKuu3+OHgprLd+ySp/oq0acVwM9x5RqCPI9r
 zX8Si5KWjXJPl4uUR3kjPuV1UDCN0cJNqjgLUnVaeqQFgOuY
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

The pci driver must not kept registered if the module is unloaded after
vmbus_driver_register() fails. So check the return value of
vmbus_driver_register() and unregister the pci driver on failure.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 20f35c48c0b8..2e75fb793495 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -249,7 +249,11 @@ static int __init hv_drm_init(void)
 	if (ret != 0)
 		return ret;
 
-	return vmbus_driver_register(&hv_drm_hv_driver);
+	ret = vmbus_driver_register(&hv_drm_hv_driver);
+	if (ret)
+		pci_unregister_driver(&hv_drm_pci_driver);
+
+	return ret;
 }
 
 static void __exit hv_drm_exit(void)
-- 
2.55.0.11.g153666a7d9bb

