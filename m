Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F300BCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBE510F20A;
	Mon,  8 Jun 2026 11:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RDPAYOoA";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930E010F20A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780917568; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KWD5usv1C0fTY2qWIgRJmVePHy2/J3m0gJmUb6F1/48oOBeASRIYYkRq6Ai18xWykr7fkysS5cwBnCFH4I4vO6EdJkn6de5zsq/6fG5SPs99rcdOmTHmcHdxsaWXbtuzU8DZDkZxFEh76dp7ikVINGTxhRRU96lwZJiyRyqQ3vA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780917568;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Fiq0mlSYnjDuCrPe/1XJ673qK5vnmNKxf/K7jiJ5Bak=; 
 b=Z5Y5DO4TWEsdoOBxYfxXt6Ev3SB2oFzJc2Z1iw2H48A9PxDFG3rr99RBGjFIROH1anV8dtng/8D8IeyCbh/wCop7CYhrnr1dMVYB0f+S2U/yEAx/As798dk+gyBxR1liTvBwon5LwYfeG/hvfjgqZ2y8lQYXp7aWRgDJ7yBrMWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780917568; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Fiq0mlSYnjDuCrPe/1XJ673qK5vnmNKxf/K7jiJ5Bak=;
 b=RDPAYOoAhvJNIcJVlY59FUIJT8KM8YpSpUvMZl4gserwGaCgID4a7LG7LoO5+MA+
 IPnV518yADrpGvYuXdWGWzskI7+S7YbDP6A2bpD/UQ5Fw6ZozFB3eAP5ssP3RZm/ncS
 r66wayPMF+e4rAV8FOBTKJcCjCc7og50gWsnf1kM=
Received: by mx.zohomail.com with SMTPS id 1780917565653660.7662547061447;
 Mon, 8 Jun 2026 04:19:25 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 08 Jun 2026 13:19:07 +0200
Subject: [PATCH 1/2] drm/display: hdmi: Only allow BPC values of 8, 10, 12
 and 16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hdmi-max-bpc-fix-v1-1-6e8dcebc7274@collabora.com>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
In-Reply-To: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

As per the comment in sink_supports_format_bpc(), CTA-861-F defines that
only bits-per-channel values of 8, 10, 12 and 16 are allowed for HDMI.
Allowing more than this has surprising consequences for the atomic check
phase. The HDMI state helpers may accidentally conclude that a sink
supports 11bpc if a caller asks for it.

Fix this by exiting early if the bpc value doesn't match one of those
given in the standard.

Fixes: 26ff1c38fc29 ("drm/connector: hdmi: Compute bpc and format automatically")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a331ebdd65af..8303475ec021 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -420,6 +420,16 @@ sink_supports_format_bpc(const struct drm_connector *connector,
 		return false;
 	}
 
+	switch (bpc) {
+	case 8:
+	case 10:
+	case 12:
+	case 16:
+		break;
+	default:
+		return false;
+	}
+
 	if (!info->is_hdmi &&
 	    (format != DRM_OUTPUT_COLOR_FORMAT_RGB444 || bpc != 8)) {
 		drm_dbg_kms(dev, "DVI Monitors require an RGB output at 8 bpc\n");

-- 
2.54.0

