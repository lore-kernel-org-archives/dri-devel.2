Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA60CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E2F10F08A;
	Wed, 20 May 2026 14:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="REVwmVsF";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 866E910E157
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrxzAdgBYytRoIJpGeZZBDTthna9I+jFkH7rD3Jxpxs=;
 b=REVwmVsFg7suV2rT28BhLmG4YS+9/3WqRtVg1Qmw28jpfJdT/4XGXB4zzH/clVHQiopwAt
 cJpLl4pAvXrHg/ohcr0slPkFwCTqz9GftunuMtcPxhvuk0gqSVinznZXJ5zIh9E/TFVPpp
 mVQLZAAUhP6YALStHIVlf3gULHPRWEU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-N4BzkP8BPW65Z-huOPMRSA-1; Wed, 20 May 2026 10:44:38 -0400
X-MC-Unique: N4BzkP8BPW65Z-huOPMRSA-1
X-Mimecast-MFC-AGG-ID: N4BzkP8BPW65Z-huOPMRSA_1779288277
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48feb029961so28480845e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288277; x=1779893077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrxzAdgBYytRoIJpGeZZBDTthna9I+jFkH7rD3Jxpxs=;
 b=pQ/sA99f2BmgAsMKESGl6NztB5nDYBiAwGSvyLvbunFVybzqwRkBqJGAupmv6Qmj8f
 0UopaH07NAxc/W9txkfMaEwl+7p7+2cQwOxv2hiTACjymY7ltNXAy1x5mlRvJMRW9CrT
 dK/Se5kTxXXJp+06hxuuxVbbH02G6dgNRdjtDDCDMREcsj84OgpvqkCZtKFPn7NSGj08
 ogkii3HAnjFJ7xVBsYWJX3ulKmSAMobBBDWoK/6hEtSHGDAotxrtWDX5R31/pjm4gpmD
 RiD00KXMvwIs9btxS0JbajGMzvs68FNbyEqLIAHlXQaVvWjMiOBUZvv13T/E0yl1n665
 pn+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9jwfYHCR2+hMvI3zpPdzYa8B5BlxqqN2K6s6Qf26/vUYhG/ZS1ficoEgsKdEJ17OunQeA0f4BKvA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztbJMw3LwWFx0zp6ky3KsH5I1QQFfI6NyGI7lkV9O0VGtZs+s1
 rhZQvJJr0/wPhh6bQGXyT4QJVvTN6cvBLSoqSia80tZZsMLIuwuJtSWLz0DNDuKL/LyTWMCe7r7
 urddFZyFRmKtL2J/m4NTcYJSpPgJRDh61Tf/herHnuFEmIZcxp27b8Rw+Bn8JQ1PEtu3kow==
X-Gm-Gg: Acq92OGpC1Hdr7QI2cPera0wSMGbWZo+2rvoEI6h5csVeV3Wn7Tz41q3cLObXF42wPn
 3ZCGGoh5DDsKj3xcLrHCrUtNBFE1251CVGVuqstjUihwZoDLIXFjWEMl15biumxzXY3/FwK4h7s
 1cUpXexFkAyc1i53KanV8SjdFTBWcZneQ3+WjjrjOG2TjeclpHdX0IcXpK9MRSFR80CynyFDC2f
 HKcnADGfnd/DHWRdF5LCaWPSSwVvXlEikzkX2siLKxPwTiQm3KV1CHfsbasKIz9PyNSJ1LvANKT
 zCAPWl69Yf3JWbvNPWdZBnuMbdItEy1UDZdvqjRMsSW+SV22uK9ITsToIjp27TyJ3Kcv6epIXBl
 F9Lf7vk00T81zT+EO8iaT4gIPXbtjhdHNpxtUovjC6vxcnQo=
X-Received: by 2002:a05:600c:350b:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48ff3346102mr294157485e9.19.1779288276924; 
 Wed, 20 May 2026 07:44:36 -0700 (PDT)
X-Received: by 2002:a05:600c:350b:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48ff3346102mr294156915e9.19.1779288276391; 
 Wed, 20 May 2026 07:44:36 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3acf7sm55247030f8f.12.2026.05.20.07.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chris Morgan <macromorgan@hotmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniels@collabora.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/8] drm/bridge: dw-hdmi-qp: Use the common TMDS char rate
 constant
Date: Wed, 20 May 2026 16:43:39 +0200
Message-ID: <20260520144424.1633354-4-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VN3ER2NkZR1mCpP-thO5kZJDzVg0jfIz15S7f6RJB0Q_1779288277
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Replace the driver local HDMI14_MAX_TMDSCLK define with the shared
constant defined in the <linux/hdmi.h> header.

The local define incorrectly referenced HDMI 1.4, but the 340 MHz
maximum TMDS character rate was actually introduced in HDMI 1.3.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 0dbb12743609..1c214a8e6dc2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -38,8 +38,6 @@
 #define DDC_CI_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
-#define HDMI14_MAX_TMDSCLK	340000000
-
 #define SCRAMB_POLL_DELAY_MS	3000
 
 /*
@@ -835,9 +833,9 @@ dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
 	/*
 	 * TODO: when hdmi->no_hpd is 1 we must not support modes that
 	 * require scrambling, including every mode with a clock above
-	 * HDMI14_MAX_TMDSCLK.
+	 * HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ.
 	 */
-	if (rate > HDMI14_MAX_TMDSCLK) {
+	if (rate > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ) {
 		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
 		return MODE_CLOCK_HIGH;
 	}
-- 
2.54.0

