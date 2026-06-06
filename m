Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F2FCD8C8E
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3617110E2A3;
	Sun,  7 Jun 2026 14:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="skSI/T5T";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C392010E851
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:37:29 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso3068209a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780774649; x=1781379449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQBJh/iJOaCrS0mMGmtXZzIHxdYRGa4D9XMK65Th3j0=;
 b=skSI/T5TVIB2LckSQhciuqzFirtp1pIBgPj32G1blVoKVHcv/NcUWs1GzAmLO/Zeeq
 Hc8t2WXqa3SS4VHGfumidPlH1H7ilrpyZhNKJcSXRth2mHRm0z92ZmkwTrTbZkuwCuIW
 u7ghX7JG1p92txHgm8zsPuI1n7TgUUOmktJm29gAy8iejGfMKA1Iz/afZibPkH92YD07
 8vYcCd+Amk26ljRmTedCBqkolvJrQ1hN7vtRiLyqNFcP/0eXm21kTkIGlLAGXxcQQeam
 cxN9yhTCF4swChaI+7wEeakVeH/HFymnJ3pfd067ipUasQUUaC43KucXhojf12L3ensb
 tOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780774649; x=1781379449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xQBJh/iJOaCrS0mMGmtXZzIHxdYRGa4D9XMK65Th3j0=;
 b=fRQhI00XDufrzAzBxqitFdv32uhzCGVgEgz7m1V2NBC+NRKXDjHCUoX0GqfDNrTQsC
 JDuEkweFvN7WxC8ZEC4I7WmLfrjIps3Mheq5eoe7jhUZu3Sh91eBhAMPn9xltsDjZHy0
 3g+zTbFvkgYsbMR5lkSHpieolfdUy5dG2Szz9JbAZ3UKbuGCvlgSZgTIcoCgVU4Bf9QK
 z6ss+HJ3uO2FXwTHWfeaqUg2US2lBhRnIjMPa8BlOPAoEgZKNHaPO8kMoaEUnA8HuS1g
 ZucLQebSXq/z4KocuT66+JXd8GsoTCojdFYj62kEPNA7EmfoioSX9MZmdYLSN1ABBVVL
 9uNg==
X-Gm-Message-State: AOJu0YyM/RtK9v5H1csLEUpn+7T3dvJditUcQXNBwPEe1otF0/xaw6Zb
 6c5pkwfZ+8MDygKS64W2j3c/++LvfgAeKflqLHYfpy5YSV9YjjY4tWtaM3Qw5A==
X-Gm-Gg: Acq92OEO4B6okS8iPIrSMJJ/EbSGlJNHQMV6daCyP3XuCDrtFbIPBksv6H9h1eDtZKG
 owarWgAbmQteYEz3vcFMVQ6hqGbdLKrIGKoZjdzqOrNRMxgcLsDoPU8eot+ubbUYZvFVT1T66cc
 QkvnJjC4e0dVlx9KNhaiwX4Vd67iOE1/GMBjYyUy03KD+M6jSRtTKr7WKyVS/zb14x6YJc4tTt8
 LsF2XUFxDahZlClb6vwV1JI7GV/WYGEw5JRu1hOhOJYwBhG5NkulDASw0gm78lD+XWM0eLEOg7v
 HUGeUixrSFBHLioOLRZ2zE10FWYq5b+1+cPl0QtX2EZBdGL90bYXX8Wo2mUps+MXrSs0GAfFha6
 WpCpMnmK5BZ73reg/R5ZDE/zALhNlHNUe2p2/OaqiwOkTC5MJWvhtVkMedJpixTrBJVN+0NVatp
 /GuW1CcsZ2TWd7QIJrgkeb6lkcSuDE/1ikC2WeONc6Eyd8NuTc332pYoMjJ4NEg7x2YUA88yj18
 LBlGN4D5SGFZN5joMpvZZrnkpnIpR8vezN2r1O4ZRyeA1dfCCRnAbURZf6OEj2s
X-Received: by 2002:a17:90b:268b:b0:36b:a4c6:da96 with SMTP id
 98e67ed59e1d1-370f1c03a01mr9346214a91.25.1780774649177; 
 Sat, 06 Jun 2026 12:37:29 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2409:40c1:400d:d07e:31c5:fce9:e168:2f2f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37135861581sm3003643a91.2.2026.06.06.12.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 12:37:28 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, robert.foss@linaro.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/bridge: chrontel-ch7033: replace deprecated DRM_ERROR
 macro
Date: Sun,  7 Jun 2026 01:06:17 +0530
Message-ID: <20260606193625.24465-4-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606193625.24465-1-piyushpatle228@gmail.com>
References: <20260606193625.24465-1-piyushpatle228@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

Replace DRM_ERROR() with device-aware drm_err() using bridge->dev.

No functional changes.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 54d49d4882c8..0e845f789f2e 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -302,7 +302,7 @@ static int ch7033_bridge_attach(struct drm_bridge *bridge,
 					  priv->next_bridge->type,
 					  priv->next_bridge->ddc);
 	if (ret) {
-		DRM_ERROR("Failed to initialize connector\n");
+		drm_err(bridge->dev, "Failed to initialize connector\n");
 		return ret;
 	}
 
-- 
2.43.0

