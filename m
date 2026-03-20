Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1028110987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C41810EB84;
	Fri, 20 Mar 2026 16:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WOBJ0DRx";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD16910EB90
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so22561565e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774024924; x=1774629724; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0atMih6wv4MrL6fuegw3RReBHe0f+0yJzxdUtx87zE=;
 b=WOBJ0DRxvoN67sUYheKOvzN8tBQ3loNoTh8q29vHOVksIBvNtY20ZuGCi3Kzl0ZPfL
 iEJY6KecPgJJDkAMZJDyAvCyFOZGElKvVo5X/9792PHnztvS0L7rEPL1hzMaTAjapnLi
 beRUA+VKowGIH91aPCYX6WdGKeQ7ctlfqXwNtEKMyNfBCT1qoN3titT4pkKXieB6rFMK
 QZOnrDIrN6f4MrJTdWOS+XnHa09XZKDa17xIL93oGjjfccrorFcruaLDfj1wo5HWCCRg
 KNpVyWFhZHpWCiDMY48BFtZ3/hyKDD6VSmzfFEGTMJg0t2Ql8Vadgx5OGB98WTxrlgit
 iKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774024924; x=1774629724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X0atMih6wv4MrL6fuegw3RReBHe0f+0yJzxdUtx87zE=;
 b=l3JXFRFpy6G5zH5omF6WHWsZe0uwR1LUW2Rn2PGkk6X4Ys/5MUTXMz3QVW0l45Gin4
 oX/gqV7NQlNUr2KU4ToV4c6bQyuhmKuJaIvOES69G+I+FBCZvSInseRSDLJzLFH30uvR
 xXwF6KvxHiD++BGsgWpMGjqJrehpRIVr9DZ7U/1hJGThKbvTyrkOowwsCf9BWdq5+LgI
 WkqS/goHg/GimpVhW4G+0WQzIbNwQTuaVZL250iqVVFkSvg4/po+nPmms7CLlFwzyLIc
 B5uX74Bpr/Vpk1kE91B8ET4jl3Y10en2mGnsJYni6Vvo7R2TaTqjQyspBk67lOc3qtcf
 KIBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSAPZyRkkx8r+VkAc7fkyZWxxei5g/6AaEk5k6WWdfl59ILqY6+NsXJ1X2dBzC0J3e5wWVYKSjFqA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQJzbdy0lcXPt4WCNGkjoeMvfxG7EeAKSIv9b67K2Sm1V30dHK
 sUWmY5z2k7QVTJjykaiJqTkpMgd2yFfQZEtvyDpujphFWAkX3pQboZgx
X-Gm-Gg: ATEYQzwULTLa5wlA4FCAS7Vg/iC0NIQSJWXCIn7Hu/H2M8DoqZrfsqkA5pa0AQdqXN3
 Z+/OjPEWA2/vyvfqQN4rIqup7JyKIZW7CD5sFn7IOJwqe724nUdRI4NdKRb2KUPQsMAwcOYkhb5
 bOpmW0LEb63ZszMe1zeRdZcGsRpKuYqmWwyZOFTnJh7wzkPWY1e0GgsyPtgcMo1a909C9gbfMnJ
 WrqdCebBNdBdBZrGx2s8nszoC1VWUTBzoxTDW3sGa7B4hSA5kgj7zUMoTCcGl8T4LrApNgbAxIX
 D24YOPbI6DbZLWNDrhYTAtkCdh3xz3AidnoXna/NGT3Vg+MT1r6vtOYOua9n67ug5bUIc+rwVHC
 cfn+4JHVTU+/lKFPO8raz5H2QtqsmsQXN/XpNtaZsTJ/tTVyFQgScX0M3YoXwOQtpgfjo/e4ESw
 z2enjXMMVy3iv85vDRbg10NUVMy5PqzYk=
X-Received: by 2002:a05:600c:c167:b0:486:fab9:a578 with SMTP id
 5b1f17b1804b1-486fedc3843mr55711415e9.11.1774024924016; 
 Fri, 20 Mar 2026 09:42:04 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:5b93:d2b1:bc5c:9231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703650sm7016575f8f.20.2026.03.20.09.42.03
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
Subject: [PATCH v2 4/4] drm/panfrost: Add GPU_PM_RT support for RZ/G3L SoC
Date: Fri, 20 Mar 2026 16:41:50 +0000
Message-ID: <20260320164158.487406-5-biju.das.jz@bp.renesas.com>
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

RZ/G3L SoC is embedded with Mali-G31 GPU system. Add GPU_PM_RT support as
it needs to be assert/deassert the reset during suspend/resume.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 711f5101aa04..3d0bdba2a474 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1156,6 +1156,7 @@ static const struct of_device_id dt_match[] = {
 	  .data = &amlogic_data, },
 	{ .compatible = "amlogic,meson-g12a-mali",
 	  .data = &amlogic_data, },
+	{ .compatible = "renesas,r9a08g046-mali", .data = &default_pm_rt_data },
 	{ .compatible = "renesas,r9a09g047-mali", .data = &default_pm_rt_data },
 	{ .compatible = "arm,mali-t604", .data = &default_data, },
 	{ .compatible = "arm,mali-t624", .data = &default_data, },
-- 
2.43.0

