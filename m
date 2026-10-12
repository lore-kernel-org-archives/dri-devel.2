Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5609CCC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D8D10E8B9;
	Tue, 13 Oct 2026 17:58:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370FB10E8B9
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:58:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E933FC653F6
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:49:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 54A0460362
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:31 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
 id 9C90111D7188E; Tue, 13 Oct 2026 19:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791913710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WqTRuxy4JCbeUVmltZ7TumMmhfcU2SDhW7r+G3YaiPw=;
 b=YlmioIGcbRnygoCb6zo9cksVBqMaNs380a/kBkPzMI9e/5Awjj7VTU3WGxWGUliD/CH88C
 lu6V55X50eEX76eo3nvOahh8madyZK0pGDUSE7665nV1xRyAqi3m5ITWkwIkZRLFEAuQWy
 CEHhe9Bzf1E0iZEJ9Kb9ZNlqyeaYBq/pIn84mmojGdxp/lXcAELM2a3n4hFw3iFqsVrmzi
 nDO8ZHlOdbl4zBYSws/N+NrDkk+J0wusA5rXq4A9OwBzOoYTwKlBttx0wTJdsnavFpAn/F
 7ELFFqa7eod1Mox+J0mVTVG0MvMYI6xGRejI5Hmi4huQIsExNv2lxQAHXL6aGw==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253]) by 9e7fea892943 with LMTP
 id AM3UEsD4zGrDjREAtaWaaQ (envelope-from <kory.maincent@bootlin.com>)
 for <kory.maincent@bootlin.com>; Mon, 12 Oct 2026 17:12:00 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CF73911D70C32; 
 Mon, 12 Oct 2026 17:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791817917; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WqTRuxy4JCbeUVmltZ7TumMmhfcU2SDhW7r+G3YaiPw=;
 b=G5ut7oNHjVKVIx50wI9DjoIKDf7EaY9AeJjHYHX0+KaBnubMvRVbjCIPJ8BuPVcKd85Ywr
 IakX/TO8DcCGyoVbrugimLOGUmJcZkx1xrxqaVbTr2F+fACcS9BCrDbkMKHDDPO4TghOyM
 rsnzbI528489igc5MNAC1DNLs3ylb/jzUvdifqWpqFgcO3dTZtej5lTKFRxgCawRmA0Y/S
 ji/K/pY2N7T++W/0koUKS68wV0m7mTifJPnefQn5DstO2JEFaOUABTmdvAP9TZadTDepIq
 cSHtd3plN3poUO/yX3y6FQW6WOq+ZBTUWuFGrX5HgY9CqMmB6B5/a0TcGnH4hQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 12 Oct 2026 17:10:59 +0200
Subject: [PATCH RFC v3 4/8] drm/i915/display/dp: Read DPCD DSC capabilities
 in any case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-feat_link_cap-v3-4-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
In-Reply-To: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 9C90111D7188E
X-Spamd-Result: default: False [2.48 / 30.00]; SUSPICIOUS_RECIPS(1.50)[];
 DATE_IN_PAST(1.00)[26]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.02)[50.23%];
 BCC(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FORWARDED(0.00)[kory.maincent@bootlin.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[35]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,intel.com,ursulin.net,linaro.org,ideasonboard.com,kwiboo.se,bootlin.com,pengutronix.de,collabora.com];
 MID_RHS_MATCH_FROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[kory.maincent@bootlin.com];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:email];
 MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
 RECEIVED_HELO_LOCALHOST(0.00)[]; NEURAL_HAM(-0.00)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]
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

In preparation for the support of reporting the sink capabilities we
need to read the DSC sink capabilities even if the source does not
support it.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Change in v3:
- New patch
---
 drivers/gpu/drm/i915/display/intel_dp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 830fe6eda17d7..b769723a1c0fd 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4521,12 +4521,7 @@ static void intel_edp_get_dsc_sink_cap(u8 edp_dpcd_rev, struct intel_connector *
 static void
 intel_dp_detect_dsc_caps(struct intel_dp *intel_dp, struct intel_connector *connector)
 {
-	struct intel_display *display = to_intel_display(intel_dp);
-
 	/* Read DP Sink DSC Cap DPCD regs for DP v1.4 */
-	if (!HAS_DSC(display))
-		return;
-
 	if (intel_dp_is_edp(intel_dp))
 		intel_edp_get_dsc_sink_cap(intel_dp->edp_dpcd[0],
 					   connector);

-- 
2.43.0

