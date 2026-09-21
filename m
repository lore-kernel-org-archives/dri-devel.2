Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE2FC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197A210E1C9;
	Mon, 21 Sep 2026 08:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKJPCrQ1";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F375510E1C9
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:22:18 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so2287604b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789978938; x=1790583738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oroj33Lk2vXbfhyXWgQGSCksQ6cUFJmkYowA5JxOAlU=;
 b=fKJPCrQ1PNwuM+8ugYOSOD2bhUeEtUTrxUgH7EA/DnkCABwdPgs+3kN15UcVWrpYf0
 J1U77utuDUC0tejFpxmE2K91y9vJCM6GD8A7amiKREi/h5Ys3B0mQjPej6HE60sbCJkV
 tU/TUm2t2HKaCiqGU8rgnT8VgVEoArHsORkQDjN2RIQ9MAz/Nfy7ydFAnWzWsRnggdwm
 3MYkZla9cxJjCgzm1wODbjYe8gu6kciK040vBZI3WjBtSs4H+KDfQpPm9UQzn2PXl/5r
 nF2edWFytvGBb5wL5qNrNMpxR64Mz6hD/4SvcBZkaiWe9gyt8A6EPAEQZSbmIh8cknme
 4pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789978938; x=1790583738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oroj33Lk2vXbfhyXWgQGSCksQ6cUFJmkYowA5JxOAlU=;
 b=r2BQt4/U5BCAGF+3SDQ+ePeQOvfK3clFmOYciYYBkVqhVipfglOzJfTfQDUVNM4Qhd
 h881j4kereALRf3IqL3PAWZBlVRVmWttZHZBT+9Xjyyag8O8Xc1s/qwtf03W7Q4INduj
 znCXANlgz5CyRhXE9hq8iNe2cJo1WJ0KGsuzct3q3vH4aYuruZF2wXoCjTbrA9AVJLew
 eRrymCUMHLTi75pprn9DNNyR5Cm8mpy2M8hChWQZMaWSFWce/kWNWz+hp0zqcmNBvbjh
 AkGAEaHWbiDWXFBV19LIpBYLCzTolYbwEP9/HQWcj11EWVbRzu8+4p+cZ+DQXCOpFcP5
 cw8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/++cEhRkEQsLgwlEFPeiT+HXT5asgQRlMj93L/o+Kf91JTYN4aGb/6wtFtDAohzNCi07QrRiTjLA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kiyqXFTk9FP/Dl2lc+ZT3FY/DeAE0fLhvxQQY5/3bO41gUu3rj
 yplYOciwlGxf2sYkoz6dQSoTrxtq26r0gd+/w5Xt4rXNbLauCdBz6EPlFtXdEMauNw0=
X-Gm-Gg: AYBFou0YmPbxMK9CkAjH1+nAE94BhaRYLiJFCcezjhSMLKvYxlzzII5/QLFfXgQPo7E
 EsVWCAAQymBi4GcouH0cX6mwkqAfjBTKUZPFK/HPpEqp4FeBjzcJd8mcakwuRceJiIeehyblp/p
 mbyG5TiE7Acq2MiYMsXThu3oxDfRmF2l5EqGdwan2a4XnCnK124PfRdJyW2xcKzghzdBh3g+3A/
 6f8lqvdU5kociREQooQREo6qHiI3cqFisHesW2Bgp5M4e1unfk62Vggjkrfdl4vK3JSgKm+M0cP
 n5FdbsCVQnvw5xIGSfVPW0M4Wjfsig9/V+0GYH8s8gsvq5VhtzZIFIBoST7JtuDtU9l+uykalNi
 D6HZ4BnHgdjeznM6iWNks9kYGjcwCGfFYatTlS6Md3ZMDpx5fNPVe6DknCPZREaQqWBnUSWNJ1U
 dRhU1Vedc4bTkcrK6yR2TZUCcMCx/o9FVS460/YisY2osovoaV9Gaf2yQr9DPRgac8UA==
X-Received: by 2002:a05:6a00:893:b0:871:9e1b:8a75 with SMTP id
 d2e1a72fcca58-874dd7f8ab2mr13461980b3a.20.1789978938500; 
 Mon, 21 Sep 2026 01:22:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877aa104197sm2861748b3a.45.2026.09.21.01.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 01:22:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ulf Hansson <ulfh@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: fix runtime PM reference leak on remove
Date: Mon, 21 Sep 2026 16:22:06 +0800
Message-ID: <20260921082206.234421-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

host1x_probe() calls pm_runtime_resume_and_get() and intentionally keeps
the runtime PM usage reference for the lifetime of the driver because
host1x is not yet ready for dynamic runtime PM.

The probe error path drops this reference with
pm_runtime_put_sync_suspend(), but the remove path only calls
pm_runtime_force_suspend().

pm_runtime_force_suspend() disables runtime PM and invokes the runtime
suspend callback when necessary, but it does not decrement the runtime
PM usage counter. As a result, the reference acquired by
pm_runtime_resume_and_get() remains held after the driver is unbound.
Repeated bind and unbind cycles can therefore leave the runtime PM
usage counter increasingly unbalanced.

Drop the usage reference with pm_runtime_put_sync_suspend() before
forcing the device into suspend during removal.

This issue was found by manual code inspection.

Fixes: 6b6776e2ab8a ("gpu: host1x: Add initial runtime PM and OPP support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Replace pm_runtime_force_suspend() with pm_runtime_disable() after
    dropping the runtime PM usage reference, as suggested by Mikko Perttunen.

 drivers/gpu/host1x/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d2c64728f804..123143b2836b 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -729,7 +729,8 @@ static void host1x_remove(struct platform_device *pdev)
 	host1x_unregister(host);
 	host1x_debug_deinit(host);
 
-	pm_runtime_force_suspend(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	host1x_intr_deinit(host);
 	host1x_syncpt_deinit(host);
-- 
2.43.0

