Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA361C982FA
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE26310EB6A;
	Mon, 21 Sep 2026 15:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="exKmfr7o";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFBD10EB16;
 Mon, 21 Sep 2026 15:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790006063; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MGzb9I3lJG6/w4sDzPIQ6G7X83UNuPF/21AZ37wkS0cD6MZAsLDH+2RVj+GViuQApJgXnJz6kQcLZeBcCf0tCdRumo/9Xb+Sv+mWRTZPOj0j/7+dN8N+LTU7yCIqQLkfsA5w+uodald0sikSmpjZDKOkqlxasF11BqHCGECqLEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790006063;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OGTxG2oVwgVmmQXCyhauY5aLJERWACnLUbauLJungFQ=; 
 b=RDtONl1oAN8C6S/Cq55Tc1m4dhomRBMo4mf1LG9KKP7IurcK7hT377vIH9k6TLcmDr7htH9fKk2sn68KAGzMvTnXz7vWpiEmLyoXno57Lyl1lWNwffP3Rc2tcXuQMiLKYbl4d8h6a2nBfEtl7xUkScZg4j5dvDAHTY8oOos/oBM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006063; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=OGTxG2oVwgVmmQXCyhauY5aLJERWACnLUbauLJungFQ=;
 b=exKmfr7oIJcDNpqQCMBp9rrgcLlUYiMSTfS9nfwLh86y6S65UZLHp+fvhIiEWCHG
 TEEShdoUxY6van1eWLJKYcgd6yQulWugGCzWbYog1ny7I1guaz6OnP2GgXzs7aAvYnM
 t660TgiABNqt77I6LKuUOhvbTs9Dt9lx4mAyWIKk=
Received: by smtp.zohomail.com with SMTPS id 1790006061638752.154553168372;
 Mon, 21 Sep 2026 08:54:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:51 +0200
Subject: [PATCH RFC 25/25] drm/atomic: Disable VRR in helper_set_config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-25-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

The in-kernel DRM clients do not know how to deal with VRR properties.
This means that a DRM client that does, exits, and does not clean up
after itself, will leave the KMS fbdev console non-functional.

Address this by simply setting crtc_state->vrr_enabled to false in
__drm_atomic_helper_set_config.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9bb761eda59f..1d3c35f7788e 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -2051,6 +2051,8 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 
 	crtc_state->active = true;
 
+	crtc_state->vrr_enabled = false;
+
 	ret = drm_atomic_set_crtc_for_plane(primary_state, crtc);
 	if (ret != 0)
 		return ret;

-- 
2.55.0

