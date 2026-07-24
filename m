Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B42C5321C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA00F10E2EC;
	Mon, 27 Jul 2026 07:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dC91NAnF";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3D310F36E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:32:54 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso267066a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784889174; x=1785493974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N8npoSQwGZPTgzk4AH5B8xCVhVfiDXlculKLn8/8fTI=;
 b=dC91NAnFqSKo+KFDhboTVytXyuY1GNvM4ifaGmoDBT4mByMBzG2gofAXd9gYHzK929
 xu3mzVQVJnWZA9wZ4LHfCPbRRQMTxVmnpbXJz9aL6Rn9TF2S6wm3IxthFTNS+U1genL3
 B5cIKNtbPsmcoPJjGovWn3PP2N5QVFtoGw014H6jRCapBoy3VAh6hyQtlrB8K2TH9S40
 Tj3vWILBTLLHTYs3yD6s2MRja6z7l9gC5epUuM4uPMOObXuZ/b9HvDoL0nrWGbl8ynnw
 uFR3fNs6+aHeu1sr/B3eFsU/N1ouMMcufESTLe3H57I6cBaH7lpQkf44T6W0nUntpmuZ
 RjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889174; x=1785493974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N8npoSQwGZPTgzk4AH5B8xCVhVfiDXlculKLn8/8fTI=;
 b=rkWGFxGFj2F23PfHUcEVdKrTQdk7KwzDd4AvJZIxS9Vvh6b04FVdOlpWWOlggdxXnt
 7ejHQ7MnxXxh7jd0NToPJ8m+me9nZc1qTntnvp/Dnzn0GUCuMoSapk2UHB1uuc1snn0k
 Ylc3+IOH1fLjg4yDBiKHBDrSk4pDUagpHfoi6XiICwRa24fNpPQWWzcPGTkSWWoG6tu2
 Qp6O7sD3N/6aTmsLWVA2Gt78UFxSiDlV/Bk3UF2cRlsap7ZwU77rj2lffaV7woc2PkCW
 k72N1NrsJkwQRPbSS+VWWZqQTs/Y7hRbJRMZnN4xao1vHxWqdelYp4qNnUpMuf3iJN84
 SWqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYeLTpiUyAqbXRTs7jEBBo+jqGyNA03nCRgvdXNtOKCRVTLicYUwWNK4nxfH2lyjAZSAk0MCltx2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcpxgSncMUzTOB4G4DRaUifquOyKUs82uRSgZLjVgKC/ecxI6N
 Y0vpAZzaMdYCzwDk6VfvRHpaRj8INnhI5NfkNbDODe29B45ZH/TT0rY5
X-Gm-Gg: AR+sD11m86g02lY0zNgc0hBEF1pubakZ1P0qQyA+CwyYnJcoccgDBH9UJyYQuuiuxzd
 lecQFdABXVRcxl13CMJIxwovdIZjE3637XPgP17EcgVVD5w/261x+UdAjgFrGK6qNQzZ7D7eFlU
 99LCShRf1+QNxqh/CQ7C5mHp71N6yT2acqOO9su7abXiFkV7azrUaFI2R73ZNIrinSpFSumKApc
 SJGg5gnk172hAvxAqC6FmEtvNicNHgrcgNeTWYTtJ9kjyHElFH4UOspuDltG4r8mByhh8s3kifI
 M3VB5kPafD2VuJng5Jfs2QpHQcqzIwm3zKV3tLcRFWjc68DJu/k/jgW1v+tIWSi1E1p+KLq18Kz
 qW3pJZz5R2v3CIyGoXgqNKj4ji2skqbQNjZ7oPHxQr22bKVMBsnEWlJLxC147V0Hp5h2W8cTwZD
 FVf7oFecaQzyN+8p1rh1ZVtLn2BeKxRRjKI3m8SbhTw0a+2Wg4Gwpws/hyfeRvR+EEZwxc61mJr
 f389Qs3oD+Ohr+kzUKljjkGPX1OD8ED
X-Received: by 2002:a17:90b:53c4:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38ec657558amr7473973a91.10.1784889174381; 
 Fri, 24 Jul 2026 03:32:54 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f039b1d3asm1212413a91.2.2026.07.24.03.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:32:54 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, bui duc phuc <phucduc.bui@gmail.com>
Subject: [RFC PATCH] drm/bridge: adv7511: use cache_only during power down
Date: Fri, 24 Jul 2026 17:32:35 +0700
Message-ID: <20260724103235.57577-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

From: bui duc phuc <phucduc.bui@gmail.com>

adv7511_power_on() and adv7511_power_off() restore the register state
using regcache_mark_dirty() and regcache_sync(), but nothing prevents
other code paths from accessing the registers over I2C while the chip
is powered down.
Wrap the power-down window with regcache_cache_only() to prevent direct
register accesses. It is unclear whether this is necessary or whether
it could affect the CEC or packet sub-regmaps, so send this as an RFC.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

This RFC is related to the following patch series:
https://lore.kernel.org/all/20260724100803.50169-1-phucduc.bui@gmail.com/

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 3e470366bce0..49da1806797b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -323,6 +323,7 @@ static void adv7511_power_off(struct adv7511 *adv7511)
 	__adv7511_power_off(adv7511);
 	if (adv7511->info->has_dsi)
 		adv7533_dsi_power_off(adv7511);
+	regcache_cache_only(adv7511->regmap, true);
 	adv7511->powered = false;
 }
 
@@ -374,11 +375,13 @@ static void adv7511_power_on(struct adv7511 *adv7511)
 	/*
 	 * Most of the registers are reset during power down or when HPD is low.
 	 */
+	regcache_cache_only(adv7511->regmap, false);
 	ret = regcache_sync(adv7511->regmap);
 	if (ret) {
 		dev_err(&adv7511->i2c_main->dev,
 			"Failed to sync register cache: %d\n", ret);
 		__adv7511_power_off(adv7511);
+		regcache_cache_only(adv7511->regmap, true);
 		return;
 	}
 
-- 
2.43.0

