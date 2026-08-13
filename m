Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C04C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BF210E42B;
	Thu, 13 Aug 2026 14:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pm/4Kdgk";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2316C10E42B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:40:54 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4995df974b3so2455e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786632052; x=1787236852; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zfgCd9JZmx1G3JenYZxMpetacJxXe9R/CJ7kBOkKzAo=;
 b=Pm/4Kdgkn0J7VIc0jn9JazOE2ujn+2kMQes/eZVa6523gWActXjjbMZhkTwzJl/gmh
 TFPVUAd/qv6RXouLQ5lfPyNCfI9pGoUENRS/IefajqsjiSkorCeamUMKghf7ZgWwMwfo
 vX6IegQM3/gL6B8jKVOJb0EW1goKDh9oGciccOVclC0IJDT9xo4L/i942JkKhKaeuLjy
 HV8AfkTJUP8v2aBh5p42tlxPwBgSdo/Xk6mH/C/3zrSk0FLyRibtGu/ndKHLu5aBb872
 FDT2gNJwjd4nl9kwChwh4W2Pbr1+KvBOQFZ5waagNyJxFlnEnmT6keGy8utfrlV1uT3t
 swIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786632052; x=1787236852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zfgCd9JZmx1G3JenYZxMpetacJxXe9R/CJ7kBOkKzAo=;
 b=r7UUhkkoLhmt0bOBjw5rWONzmawAgmkMVF+NJ5p9fIZ5RW8kOhINhM89Ho9eCECJhM
 Xq4+9yHXFZF8UxeI3m0UiR1j9GKwEdBhOfblfUFe4IZxBEiRiGKyRi9lZ3mSwg+R/NLJ
 Z+VQObnvIBd0LpEboypa6BLLyuDWAv0AOYvGnro2GJ0etT3fiE5Eim0n9j7zxjPi448t
 wiPoctLBIHTjzJRuJq0t8zvM8IVPA9CLGeG5bfMZLvS1Azm3+f89Br9d9MqVBLig7XRS
 LlDgDKywU73ngZX1qBcEM35eIkXqRV65PEQ0LohcuckJ8aElDD0Z/AfLMCNF0T5CGfqL
 Ahzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpC2jgrPlo5TTkPXTTfqZHBc1Ub56M8k5d7zwhCvdMgOXOzinSv0U10qI2uVbHYjnWn42tU0IjhFIM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWl7b109y7aetDkYQBJQLlLiULcwUyqHF0BmHbh+K5Wbcy+Wb7
 1ypJLkwvN20MtIgouaAr8MpXeOxJzbXNPrjYEfp5EuPFYja19wPgZHcU
X-Gm-Gg: AR+sD13derTpetng+rnh6v5VeI5C4Vk7PFxcgvSuTLyAxBlNxIAAZBoVQnP573XP1LX
 iSjHG4rf7Z6hf17Nw9WrYyXbRqsymIe7+tFNBY1x3BYMQ7rl+T1yZsnJHNg9WfrfDHxWwlUe40s
 u7vEeUzo9V+MaV8rT3a348WqMTpfAqbeefoa+2chxouocThhil5jSqlh7Q2bUGrp5jTw/tpM3gu
 MhVJcHcpoAhaLhZZfStKz5j5KcOh2fiQ00/aZSfw+v4HU30bkjLq+2ys49R5n8CfvTnzcS2kcV+
 naie6R7GJbZ173CZxLb1tCdbXchTJc4DwrFtVNraTZ7a3uAqFapEkiTwZ44QTyTNB7oLQ9FIYNq
 oR4lzLBybo1ZB8tdWXaQW8+Ya6r7BrQ5pCdUsWcWHYE7mYZYZTYKk4MrII0R9Rlq/4ys3r26Lrs
 0EjM+VfSgHcDuUV9lVSh4pTHG3ofkpIhTU3r1CoauP5uctD++KJaayn5U7F7B5A5MYZGLTRMO0H
 gcqxpI4DSVLs0DlWkzP8uRsePK10FDwPkpO0Po/2IYis/08xJZCJ75gvs3pSBOoMbcI1OOegBjk
 C4lt
X-Received: by 2002:a05:600c:3ba2:b0:498:8e6:d463 with SMTP id
 5b1f17b1804b1-49982617b0emr35862875e9.1.1786632052215; 
 Thu, 13 Aug 2026 07:40:52 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B911C00AE6C52CFC8961284.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:1c00:ae6c:52cf:c896:1284])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b58700sm66426445e9.9.2026.08.13.07.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:40:51 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marius Dinu <m95d+git@psihoexpert.ro>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 0/2] drm/rockchip: Add missing DRM_BRIDGE_CONNECTOR selects
Date: Thu, 13 Aug 2026 16:40:17 +0200
Message-ID: <20260813144019.12089-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
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

While testing the dw-dp v11 series I noticed that ROCKCHIP_DW_DP does
not select DRM_BRIDGE_CONNECTOR although dw_dp-rockchip.c calls
drm_bridge_connector_init(), and Sebastian suggested handling this
independently of that series [1].

The ROCKCHIP_DW_DP gap was in fact found before: Marius Dinu posted
the same one-liner in March [2] and dropped it when the failure
stopped reproducing in his build. The failure is
configuration-dependent - any other enabled option that selects
DRM_BRIDGE_CONNECTOR masks it - so it can come and go with unrelated
config changes. It still reproduces on current drm-misc-next.

A sweep over drivers/gpu/drm/rockchip found eight callers of
drm_bridge_connector_init(). Five options already select it,
ROCKCHIP_INNO_HDMI gets it through its DRM_INNO_HDMI core option, and
two are left with a latent link failure: ROCKCHIP_DW_DP and
ROCKCHIP_RK3066_HDMI. The rk3066 case additionally needs
DRM_DISPLAY_HELPER, whose module carries the bridge-connector code.

Both failures were reproduced on drm-misc-next (d85a5e9dfb42) with an
arm64 allnoconfig-based configuration enabling only DRM_ROCKCHIP plus
the option in question; with the fixes applied both configurations
link cleanly, and an arm64 defconfig re-run shows no new Kconfig
warnings. Both issues are present in released kernels: the rk3066 one
since v6.16, the dw_dp one since v6.18.

[1] https://lore.kernel.org/r/aneNCDU12OzG99UX@venus
[2] https://lore.kernel.org/r/20260319155051.1944-1-m95d+git@psihoexpert.ro

Igor Paunovic (2):
  drm/rockchip: dw_dp: Select DRM_BRIDGE_CONNECTOR
  drm/rockchip: rk3066_hdmi: Add missing Kconfig selects

 drivers/gpu/drm/rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0

