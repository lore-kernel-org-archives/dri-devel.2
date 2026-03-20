Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABE10987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83C310EB8F;
	Fri, 20 Mar 2026 16:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T8vu+wfJ";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1262110EB8B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:05 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so15900315e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774024923; x=1774629723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uiCTexBrx4dMD1Q5L1o5FxLTDC5BhBtXi4Vo6qoAUg=;
 b=T8vu+wfJNK1DXD49oCQPwZzDuqFc0Mw8l0MeeoAmgDWhbtnmEfn1vUGcLERIPJSw/v
 yCkQZv124NSaMpFTm+Ld7kT604npharKSY49XC2RICm5hpuNz+Z6fO5ieSVJBO5n8lNY
 eZEMy3uVcusP34L/3JsDKZF/E3n1eRMxu6QXOZCYqb0/PHVRlzpymskHB+YmqqRqCsC9
 PpghrTBZMEuSOZAgPnpw7Q7otsKzAF5iOwCU6+KKYdVOJu8V03RsLKw+2P4ryCDwfHup
 eLVaMrZMgsLwD7aI6ARVJvbtikhUKNHfo/bQZiQDw/wuM8shT+OMKtTo13dFgn8lsJO8
 KGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774024923; x=1774629723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7uiCTexBrx4dMD1Q5L1o5FxLTDC5BhBtXi4Vo6qoAUg=;
 b=L71ivox6V32LTBksLdn2BiIJu/F/Orr3f/bC0AsUHwz6bk+GH7spPncSQA4MsbYVVt
 YYXMctFhOpnlkBFr8T0NDWb8SkLXdVEZ0x2evnqvoUehVg0+DqIzi380TEQQ3FDhX1GW
 mYzqNEx5iS8PXrQsn+AlqnQpq6yO7x7tJZJdTSY+uQ8gVHU2lT/KYeK8hvAkLC7z0mEk
 TTleYZmyXfFSOf8EISTrGpp7eY7exX2nZTb7wObcEa8kRMU0jp7XMjaB78SioWF9utzu
 t8sMvE3pFEcnek4UL20U7pSh5YYYitT9rMq6gCMUF6EdIUzTwuZjXNOEyRd5CpcqgopK
 WoDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa8OGvkmDTGs4CeHs0R/4rDK2RYG6ylxaHH5CbqKox090+e4I191i2hwk8T6QzqcD87MvCLAxfuJw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3NbkBTeR+9mfaBkavnla+e/FHaZ1YSopezDliJqh9lxAJamsL
 1lEdF3DcTW4zrepMih7Ea2Xel6E28dLzEgYqBq+GhzgrvWsLYu/E3K7r
X-Gm-Gg: ATEYQzzt+wQ3Km748qQJOm+OFrOSuPaCwlyV/qMx69ydDDTG1OpvdOuNKIwY6zZxfC/
 rlDEwMbEJzG/gHNK919eYZzyPJ/BSd6N4VybX7uQ/0XcOZvOBKIROC/GQUylr9Zt23D9JZJEM26
 cbuF71AJUXl6SpjvMnQCOys0iR8CGm8ggr8z2/HSMbctI19HYhJyrsp1N1ooXaT3vWoEr8jC2Vn
 KLgS3G1EO4237VusVGO4Nze6qz7YisW5cA7a+/bW1ygC/eRjgAfsNpZx0DXrvbkT0h4fVbxiqXz
 YUih7boWiGbVJMU1gQmwtbXXlH8oUuDZeeZNDLz5Umnv/K2S/nFOGAhDTwa/cnEOAiyT2OdAfNl
 ESlxYm16AkDGn8IGTF01olVa5xeVaFeft8Gor5IK9/in1YWKCZWmKFAOUKQWmoxrXtAzqjRuTRL
 MigfHbEOyjwxGDAfWO8jNa/u40hDRi1Go=
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id
 5b1f17b1804b1-486fedb2545mr63880305e9.11.1774024923408; 
 Fri, 20 Mar 2026 09:42:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:5b93:d2b1:bc5c:9231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703650sm7016575f8f.20.2026.03.20.09.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 09:42:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/4] drm/panfrost: Add bus_ace optional clock support for
 RZ/G2L
Date: Fri, 20 Mar 2026 16:41:49 +0000
Message-ID: <20260320164158.487406-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

On RZ/G2L SoCs, the GPU MMU requires a bus_ace clock to operate correctly.
Without it, unbind/bind cycles leave the GPU non-operational, manifesting
as an AS_ACTIVE bit stuck and a soft reset timeout falling back to hard
reset. Add bus_ace_clock as an optional clock, wiring it into init/fini,
and the runtime suspend/resume paths alongside the existing optional
bus_clock.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped duplicate err assignment
 * Changed the format string of dev_err to "%d" and simplify the dev_err()
   line by using err rather than the same PTR_ERR().
 * Collected tag
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 01e702a0b2f0..7fed22d555a5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -70,8 +70,21 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 			goto disable_clock;
 	}
 
+	pfdev->bus_ace_clock = devm_clk_get_optional(pfdev->base.dev, "bus_ace");
+	if (IS_ERR(pfdev->bus_ace_clock)) {
+		err = PTR_ERR(pfdev->bus_ace_clock);
+		dev_err(pfdev->base.dev, "get bus_ace_clock failed %d\n", err);
+		goto disable_bus_clock;
+	}
+
+	err = clk_prepare_enable(pfdev->bus_ace_clock);
+	if (err)
+		goto disable_bus_clock;
+
 	return 0;
 
+disable_bus_clock:
+	clk_disable_unprepare(pfdev->bus_clock);
 disable_clock:
 	clk_disable_unprepare(pfdev->clock);
 
@@ -80,6 +93,7 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 
 static void panfrost_clk_fini(struct panfrost_device *pfdev)
 {
+	clk_disable_unprepare(pfdev->bus_ace_clock);
 	clk_disable_unprepare(pfdev->bus_clock);
 	clk_disable_unprepare(pfdev->clock);
 }
@@ -432,6 +446,10 @@ static int panfrost_device_runtime_resume(struct device *dev)
 		ret = clk_enable(pfdev->bus_clock);
 		if (ret)
 			goto err_bus_clk;
+
+		ret = clk_enable(pfdev->bus_ace_clock);
+		if (ret)
+			goto err_bus_ace_clk;
 	}
 
 	panfrost_device_reset(pfdev, true);
@@ -439,6 +457,9 @@ static int panfrost_device_runtime_resume(struct device *dev)
 
 	return 0;
 
+err_bus_ace_clk:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
+		clk_disable(pfdev->bus_clock);
 err_bus_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
 		clk_disable(pfdev->clock);
@@ -462,6 +483,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 	panfrost_gpu_power_off(pfdev);
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
+		clk_disable(pfdev->bus_ace_clock);
 		clk_disable(pfdev->bus_clock);
 		clk_disable(pfdev->clock);
 		reset_control_assert(pfdev->rstc);
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 0f3992412205..ec55c136b1b6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -136,6 +136,7 @@ struct panfrost_device {
 	void __iomem *iomem;
 	struct clk *clock;
 	struct clk *bus_clock;
+	struct clk *bus_ace_clock;
 	struct regulator_bulk_data *regulators;
 	struct reset_control *rstc;
 	/* pm_domains for devices with more than one. */
-- 
2.43.0

