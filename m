Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEC1CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4EF10F1A6;
	Thu, 25 Jun 2026 08:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R2S8t7fF";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E1110F1A6
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:25:23 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5ad536cd0c6so2227225e87.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782375922; x=1782980722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOBOWB3vXJggjp/KtLxMj/oE2ncu81mEOJd6q25I4nM=;
 b=R2S8t7fFF5AwtjSkK4fYBqwHyGn/KjmMN1wrd+lwWSJpwGGd7gaN7RtMn5o/20Dwj2
 hDqGou1sQA83SVNlUXehktpCNw7L0xrS02ENNT2feiHfjV7W/3Jx19/SKJBBnkA0Y3ui
 5Bd8aiTshV8SbdkZuHqbxNwqSKTngAqanXwQ6jxsqPDkntikaB/ks2udRl9S/Jnxaf9O
 apt9pCmJp1y1vJAEsygVhLINfYpWqdUiHlFJpzIl+Xr3Ge9RkMjSGH24Rbrmviu5dO3y
 0KLt37eZPBKOff4eGhq3CZLRryeQdeJYrkwb3EhfZGkWLWGCsNt5HSkuMbKi0ovRfrb1
 r3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782375922; x=1782980722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hOBOWB3vXJggjp/KtLxMj/oE2ncu81mEOJd6q25I4nM=;
 b=Ebvec73JgiTT1qsw3HZQa1bn/WIxwvlSiQoCLXucNvlCqK69xwKfupxx4SR69Ut4jU
 9zWtpesu4LoHqWXclccW/FqWuKCdJ0mA7fb13/QeisKd+/mQ5ULzCmTmXYlINCVVv7FH
 hnqXHervVjrtCteRySYfBkewpfYSwpUOm1H6tID1pVePLh6X7GhQety6d1mimUdPowT/
 EsP+QsfsSYpPoaWJWk87I7Hvt42PcQYDJ+nsIQsC723brSYE4UKvoiGG68xBix5JydZm
 hwR2jexcM1JrXis5r4El8ddvvJbEPIIGasSaT2qaNFE46YMl7SaCWqSYTarPrpM1okQ7
 cS5Q==
X-Gm-Message-State: AOJu0YzUJnifVY8EfLReOdSUZdfnuXcmtH7qWFfYtMoxo966yV/ugbCQ
 DyjGHLnS7ej8uqD3BSFaU8eBhKIAgGtfq2LavMYxfkMuSTnG9RAxVN+a
X-Gm-Gg: AfdE7cnGTtFRTXemlM6j3dgpxXEtld7eo/MfpajcNkjGeaPnI/gMgVF8QwpbIVL27NJ
 kpc/0pjGPz/isJ5DALZbWpXpuTm31pxokE4EWi9cJiQPEsXTwa5gj9PYU4L4nkgKKMJ7fHQIveu
 Gb104ffyAr542q/kYB4awLYHuPNtdgR8fTV7XTqf+RmEDLcHSACDs31//u1O74XB221SGImUVLC
 245jLGDwIagCPdchCOSO24NVQCeN1+vL3W4toOZOg1czO7vnIWBIbKcBIwE+a28MIZDC5h4lkpw
 MGX8T2vd2mo+WdDFGdr9cGYe7JQrwgWoBP9jIHy1vRyiMBSKaHv7eANstYyoY+JdVuogVIfs39Q
 CN9jH/XQnKa5BRVqEKW7YfgiQx+aqgL8STBivoUVJBfHV4AWa1GRHsnIMfTmTkrx4ZZUZAgXih1
 RJTP9mdaRlqA8WxBm0WAiE1pOddeC/Wy/smA==
X-Received: by 2002:a05:6512:6710:b0:5ad:a51:20a8 with SMTP id
 2adb3069b0e04-5aea1f3c0a2mr475517e87.18.1782375921482; 
 Thu, 25 Jun 2026 01:25:21 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999af9f3a9sm39064081fa.7.2026.06.25.01.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:25:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] gpu/drm: bridge: tc358768: Add delay after PLL setup
Date: Thu, 25 Jun 2026 11:25:07 +0300
Message-ID: <20260625082507.57703-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625082507.57703-1-clamor95@gmail.com>
References: <20260625082507.57703-1-clamor95@gmail.com>
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

After tc358768_setup_pll() enables PLL_CKEN and the lock indicator comes
up, the DSI register sequence runs near immediately. On TF700T this
results in the bridge claiming PLL lock but producing no DSI video output:
the panel powers up, the backlight comes on, but the framebuffer is never
scanned out.

Insert a small settling delay between PLL setup and the rest of the
attach.

Suggested-by: Michele Brocco <brocco@perceptos.de>
Tested-by: Michele Brocco <brocco@perceptos.de> # TF700T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0f2820b37302..ea358c8da0e9 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -824,6 +824,9 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 		return;
 	}
 
+	/* Allow the PLL to settle */
+	mdelay(20);
+
 	drm_display_mode_to_videomode(mode, &vm);
 
 	dsiclk = priv->dsiclk;
-- 
2.53.0

