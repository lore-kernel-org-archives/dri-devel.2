Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45196C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F71A10E078;
	Mon, 21 Sep 2026 15:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="VEQ3WRT9";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2B810E8B0;
 Mon, 21 Sep 2026 15:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005939; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dL8QWo0f+z20HLw9HXd7aGFStuR/k/6l/FzgRHplWzXjfpgtJuClsAOR1DZ512xYHu8NCCcCazC2nApnrzpzPNhdvceP+z1X78p38mpx60wgUMZkUI/Ao4mFSgQSZWorMd1ffR8UsjM1jflS2DFrKLxXRt8gVLx0LlB0uhVfp8U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005939;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hVfhbzvE6GURebcBrX2O4AYlNWe76f6ylBqD+StMY7g=; 
 b=HJFIqM47xYTMuV3pj9MXTVTK4CKFU/hv8W2mvG3UieaVb+Aop621PPBOBihh5WJDCUee+UI0PKD4Gv+dDnq8qmUosBaFflQN+2gn0bkgxMK+bpL9G6r40GTtnFb5uxzfQKdVT490HXiNrokbN+diPmvlgRv9vnVIZdseXXec0h8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005939; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=hVfhbzvE6GURebcBrX2O4AYlNWe76f6ylBqD+StMY7g=;
 b=VEQ3WRT9ZruGE+auQHYNi5JDxIAHiWLc38gvCVDu8IEpeZkhjV7guYnBbNvapKlB
 kuVL8L0Gg64ALMxnI3i58j7hSNJD8ia9h5AwssgPQFL5iEcXmYjvii55IRXKLDqb4Mb
 eUk+zgTbkKwFy7EiaiQoctyHlhWRtM0LJzTWf/Vg=
Received: by smtp.zohomail.com with SMTPS id 1790005938404198.15695800259266; 
 Mon, 21 Sep 2026 08:52:18 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:29 +0200
Subject: [PATCH RFC 03/25] drm/atomic-helper: Set mode_changed on
 vrr_enabled change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
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

A change in whether VRR is enabled or not on a CRTC will be of interest
to any VRR implementation, as they may need to recalculate certain
internal state in response. So far, this was handled ad-hoc in the
drivers that implement VRR.

Handle this in the common DRM atomic core by setting the mode_changed
flag when this occurs. The rationale for using mode_changed is that VRR
is deeply intertwined with the current mode with regards to its timing.
Consequently, any component that cares about a mode change is likely
also going to care about VRR being enabled/disabled.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a..0664d5779282 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -694,6 +694,12 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			new_crtc_state->active_changed = true;
 		}
 
+		if (old_crtc_state->vrr_enabled != new_crtc_state->vrr_enabled) {
+			drm_dbg_atomic(dev, "[CRTC:%d:%s] VRR changed\n",
+				       crtc->base.id, crtc->name);
+			new_crtc_state->mode_changed = true;
+		}
+
 		if (new_crtc_state->enable != has_connectors) {
 			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch (%d/%d)\n",
 				       crtc->base.id, crtc->name,

-- 
2.55.0

