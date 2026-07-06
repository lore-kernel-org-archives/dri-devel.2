Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B4C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F82010E303;
	Mon,  6 Jul 2026 14:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VANAmZxJ";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E22C10E303
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:03:13 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-471eee9b7d5so601611f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783346592; x=1783951392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hr836mBCBDsLn0BsEM+M6uBiXoTgU1y1CRSCGWjay3o=;
 b=VANAmZxJm/a9tl7S0Y//t1U81RoD1fYZNDdWR8Fiyy/kzYrkxCTKSztX6Qtz40s2pq
 fV+9UH1/S3rHxPYJOM7bohLqBW7B16Hg6bh+1Qw5Zxg/6NWUXLr2j+SCXFV9E5gDs0oU
 tt+fCd3Ujm7noRpNR8rCbEeOxvIvdqwiepykjy8692RRdpd5Eg9wqTI4/8sZWDvokrBs
 und1/jarl9tyLfpKpibMX8VL/tj/7B31/h6MmaubUZZa2fyxgrw4RUj6D+qTV01tNUq4
 UNko2IpRmjvVcdkWWWl/kSbeY6uJSyFCnzS4Vs4eLi9AzGlDVhjwS/xCRrCKG1FhUeFe
 jTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783346592; x=1783951392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hr836mBCBDsLn0BsEM+M6uBiXoTgU1y1CRSCGWjay3o=;
 b=lpgVWgOHoLYeJDFUetVFstSxswxmI570EKU9JcFNvhh4pW6KpAIZx9/n7l2NXYvmCS
 XmdbruptXJqlNoH/4CknQ+RlLLKbSz0RU7yWQBCJTVZna/LQLBT0RfpmG3qEgefI1pJy
 zvLTKM5KYeEkWVM6JxC719LnQMWC/Ww6pKDZ8ay/XMEphzGjGyyKmiUSuTqe50PLdXUv
 4ejPh/LuGE8qYiDou34s3q2AGVak6rgpK010aEmMJJ5ZXXqrYWdYUvewHC76uPUH0Tiv
 8U888ByXALcK6ey7F4gA51yAxs1MlBABFIibinjI9GR5wSJ8riWUG9P2iyJS7GU8ic9k
 gniw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg/X4r/pTyBJ0QU+UrDQUYSzVVzxLUfZZfvnn+6anS4u9WhZzX4L6wmWqLXamlAfZgSztfabCA95s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySBC2wpALeRaAb+a41YyeUToMbnbWURWHCcLESdW5lPof3DgbF
 Ljyrhu6Lvz5EmC+MV9e8i2OqIwGyjoMlAjWrq1FPgcji/nRhxlhElgyA
X-Gm-Gg: AfdE7cn5jNMnyPMeqanFXJHojy2zuzK73r5on///Vet6zZl6FEEjshscy7dVzpdhWyY
 Wg2W2ej+rnHk7jwlnHiD7nQok4jVzoq0G2C/AH8ZRkQokE2liIh3x0pvq5v4bZgEmBA644faUOH
 oixnzrWkUPd/KZRgfqV4vKWBT6+AhUdpqFhoxkINQOVcipF7lw2SpSfMU75JEsagv7BXQofuIAF
 9hFEa/RWMna2APZQMZdp2DdZccFI+fYRJ4YF8DFQ4qzA3ewtReTNqwsXDzZcBa4ZkmsPCeaKxIr
 Gpw5DNlfhDDXxpPWOVBrfoPHH+ROmH85SdKQbb7Y3ITwgcTRxCLi3ZM0YrRz5CCEmfZK40vPxOL
 UtLgHWwTKwK9C/MKT1q0yBJTM1viGi3XzgmZyk7TbIrVwtCCfKLoahqT3uHqqNb6fRo0Sl8+sVw
 bfnL6AOkFSRtu8s8HUoUbBUMcDvKh5JRPBKg7zNzv9iUCy+ZZWvK7wKnowqc0=
X-Received: by 2002:a05:6000:4612:b0:474:4525:eb32 with SMTP id
 ffacd0b85a97d-47de668eb7dmr436784f8f.11.1783346591380; 
 Mon, 06 Jul 2026 07:03:11 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:bfda:c630:e88a:7a7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d7801sm25653740f8f.16.2026.07.06.07.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:03:10 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] drm/imx: Fix ipu_plane_duplicate_state() OOM handling
Date: Mon,  6 Jul 2026 16:02:45 +0200
Message-ID: <20260706140246.41506-1-osama.abdelkader@gmail.com>
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

If kmalloc fails, with state == NULL &state->base dereference NULL
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index c7ec09e557c1..67f2da7f2b65 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -323,9 +323,10 @@ ipu_plane_duplicate_state(struct drm_plane *plane)
 		return NULL;
 
 	state = kmalloc_obj(*state);
-	if (state)
-		__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
+	if (!state)
+		return NULL;
 
+	__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
 	return &state->base;
 }
 
-- 
2.43.0

