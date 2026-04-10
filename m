Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CBAF45A0F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 21:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FC510E9D7;
	Fri, 10 Apr 2026 21:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d+CYjvE/";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC85310E9D2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 21:28:22 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43b8e8e7432so2229129f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775856501; x=1776461301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3wqhCT2PYrW184+42077Vlk22WDYcJROXdpI32jLbM=;
 b=d+CYjvE/e6Zfgwmb7d20gR8TosEk2Au8EJrUIrzeKApMLWIa97XnE3tEbbC+su1m3O
 38o4sDt2euV7yxTT2vPshQtaP/eraZdNH9LfWiey6qbAcaPKJWcnagaNwJReEyUeVcmw
 cJM8w9aYP+jLRT7cL8G+V7XdkBgYo5VvLbaSAdHrxFrZTHZ+8vNqfZaSrnwPxRZXwWMG
 bf97EpN4RJBVnAFcN5SUx5Ii2Pu6IW0jJdKWL5+fRdhfki9x6rg9pVhbTd9ShWZe1BFq
 4kUwFdirR4YHObl1cG2TkKHF97JVRkrdwnDevVd3hYN9HkzeYbvZmAuBZvboaes67Tuf
 SdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775856501; x=1776461301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3wqhCT2PYrW184+42077Vlk22WDYcJROXdpI32jLbM=;
 b=AMg5t+q8gOZOgeB1T1fFJyA1FDWpq61vh+AAgLx73QbRJEzy8ed+IiJa8zjmWVwup+
 aRxsD12slnulPeY7d+7QtJzD6+pxQfxowHkFfiQWm7CsYPzHAi872UCN3y6WImyAboGm
 mOrI8PCsdPUHmw5SKMGCatfg/7Og32k3ZfuqD5tCyQORrIhdhYpMpjzMnmAvn+Nxa8mi
 56RkII37fvyJiKMDeRnFham9V59opazB8oXqzpLE7mgHZjDhA/Z0RBmqVqL6bwzU5GOm
 jaOIMA6Qyf4MnbEeI2dbj1qzkBP0NV+NXJy/BzpWw5eLcy+7nwEsoMq7NIFwb8EpN/bE
 ovnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnpVXTwaAVx70udy4EsPNFMYSyQ1qmnyE+rNPkz442ySyGcDFgD4OixbuB4aaJxgMI79S4obiCtnc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYJSUbQBAgbjRltPpm9mRd4LdiCs7KPw69UUBGZ/OYRv8C3Eng
 FzudkN5OyvH5hD8S3R+smAoWL35RbF33yhyZ2cDWnnXwhw955F2VSYpc
X-Gm-Gg: AeBDies4MfExiR4RmvuqLDB8bwFYnhS2dX6MqLEvmEeml9/dH30GvyQ1eJ3Lmi+eL2l
 ZhW4TAKGJ8ow7z9SBK4cWcO3Km7y19FJ9sfFwc679bu2Rl9/uKPEE30yt6vr42AuTJ/lXAiuRri
 CenVGxoxkOaUnXNKU4YvZwsbsiZFS1Van+vS07aeYjpgWdyPG6fOuVnFBWm1H3v540LC0bZjSl8
 M8qKXIOGcxZyEBjbjOVHoi764lfdqBRTM2LzXsB4l02LGjR0HDYaQjzQHvtb+RzxCFGo1B8+j9O
 B8wwYoj2zkbgt0xodOYdXXaxD/PfW5Sqc0sja7PYtp3qgRTW7h7Nt7fJOCO7j7HJq+VbKz4ypIQ
 27rRX6IzJgAl1NScDer2jzT011XZYzZXkNgcCAB/bywAU2FxT4zQzOffRG2lQBokSb0WgfNZprt
 sxDo6nqHEkDn/H6bMcWinPEgwlJaZEjtbsHNxhrCIEh1OLzXeJ4DJKCyeDzyg=
X-Received: by 2002:a05:6000:2489:b0:43b:8f04:2ee1 with SMTP id
 ffacd0b85a97d-43d642c4ee9mr6929982f8f.27.1775856501227; 
 Fri, 10 Apr 2026 14:28:21 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:d356:742:cb75:6153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50015sm11205992f8f.27.2026.04.10.14.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 14:28:20 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 2/3] drm/exynos: remove bridge when component_add fails
Date: Fri, 10 Apr 2026 23:27:58 +0200
Message-ID: <20260410212801.413827-3-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410212801.413827-2-osama.abdelkader@gmail.com>
References: <20260410212801.413827-2-osama.abdelkader@gmail.com>
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

when component_add fails in exynos_mic_probe remove drm
bridge before return

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 29a8366513fa..5e771b236bf0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -437,6 +437,7 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 err_pm:
 	pm_runtime_disable(dev);
+	drm_bridge_remove(&mic->bridge);
 err:
 	return ret;
 }
-- 
2.43.0

