Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FBBCD8C8E
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E3910E09A;
	Sun,  7 Jun 2026 14:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZ9GKgD5";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3FB10E851
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:37:23 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-372b4330deeso142710a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780774642; x=1781379442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12eLhWVfpwHYLYN15DRe0OIyN1EdLOmH+Na3mRMbdAE=;
 b=nZ9GKgD5YB4X5FLGuV8Ykduif3/okrTON21JlINCoakOevPijOsA+iNtYOMOhHmrVu
 Gr9UdMHSjmmu5qRIJDdSwN8OZs50WpiKbGQauE8k5IyO8PaRpWOb5Ipg4MnNYlv+xwxW
 /fBVX4crTG6xtniFwYBYV/giw+qxcBXZXug4G2oA044w36p4R7qVVwXBZi3Z+LvAzEWV
 TxlY8gVRY2NNjiBM4pXZ+osBjUCucS3COR9QJiMOgkPwpzLoAc/KPtNqY53Ck719BjRX
 XBANpbqh40Tdvn+aDEeai4Fyozrw2qufY6/vi1nVL32lB9kHLY73ObaZkvdOgnas2ER8
 5L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780774642; x=1781379442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=12eLhWVfpwHYLYN15DRe0OIyN1EdLOmH+Na3mRMbdAE=;
 b=isl2ARJhTvKQ+L2DvC61mlW/EkPEgQDmvT94Tr3XaCuY4gpX0jACPeLEJDcEj+/im0
 XCvN5Mq5fmeVXdjlBFylWLaX7I2dRB55vVnZy3VS8iQzQZfWxJkoDveWy0c110kHDrdG
 DfqjEJLO7xeF4HZSCyRuHc9gLc+NycTUoI6vo0vjXrINOiJnxDrsHEH6N4tFcSV8P4o2
 PBClHIRWTQ8m+HJhfZ404UNfF93oKELMoAyQUJ2uA6Ysdj1KYKJBNva9bI9tf1pp6FEh
 tckC0d3rxYVpKoMGw1J9rCeVl2e0tzv4TL8MjnZuvUeyb2cogm02jgUGVcujuncQwzA4
 80Cw==
X-Gm-Message-State: AOJu0Yw3J8UjQeB02R7Ror6nrovbX0l7SBSwWX9Gl6lxUUbml2oKvDAn
 MfjCj1hdVfq3dsg9hsh8mdEASGsRuDTJTkW+V3OH8elA+F26qGKAJ5DbyGRGKQ==
X-Gm-Gg: Acq92OEHeWiRSmKHUKxWFxGk3s2oiUfp6mCJmOc6aZzGTOnTSqa0uPSM903YNHBjyEA
 pLq1CRYQjIMY7bRAe7k2YQ8yTazjdOdlYCKeQGxY1yBZAkWteM2q6/OUPPB0hJUraSga2gHn2Vm
 x4VEd4BS4HI4OC5rorDpu+hixd9F/LXVXXLGg8i0QPBG1pBzM6FxtkzuWMwBIrshxemR+0C1YrW
 BxubHQz55GZmUC/QbodPCE4yX4a48L1EHutzsI20QTCViCU/4S9c1UAFpvjxv6sjTyOvJsQsuEx
 epsK6SdeOQNR9Z7xBwGig2hN6gpu/lHGDUg/5tbRWSjAic8YKnmxpRgLABeEYgOW75pWJTxSMRp
 O27FE8HyHh7JuG1yfiFVGA+IbmoVVL+orwjkD5mGehsDJ/EwTcKe2yvwo3mcscnv7c8V5U2JrpH
 ilFZnAS739hfHlMBY1fWSz07Cyff8XqNSWxlcyF+qL8EqNabKnxhlnt/P6l9fjAAEmzLl9tQZ19
 FMoowZz+0ohf6nn2fGIPXowrmsJYYyZFcr0NbLbOT7lUHb0Q5f0vQ==
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id
 98e67ed59e1d1-370eee03facmr9646707a91.8.1780774642539; 
 Sat, 06 Jun 2026 12:37:22 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2409:40c1:400d:d07e:31c5:fce9:e168:2f2f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37135861581sm3003643a91.2.2026.06.06.12.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 12:37:22 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, robert.foss@linaro.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/bridge: ti-tfp410: replace deprecated DRM_INFO macro
Date: Sun,  7 Jun 2026 01:06:16 +0530
Message-ID: <20260606193625.24465-3-piyushpatle228@gmail.com>
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

Replace DRM_INFO() with device-aware drm_info() using connector->dev.

No functional changes.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 3b6b0e92cf89..1ebb2da1b789 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -55,7 +55,7 @@ static int tfp410_get_modes(struct drm_connector *connector)
 	if (dvi->bridge.next_bridge->ops & DRM_BRIDGE_OP_EDID) {
 		drm_edid = drm_bridge_edid_read(dvi->bridge.next_bridge, connector);
 		if (!drm_edid)
-			DRM_INFO("EDID read failed. Fallback to standard modes\n");
+			drm_info(connector->dev, "EDID read failed. Fallback to standard modes\n");
 	} else {
 		drm_edid = NULL;
 	}
-- 
2.43.0

