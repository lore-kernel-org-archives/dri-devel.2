Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100AECD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743BA10E84B;
	Mon, 18 May 2026 19:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="T5vLYGeh";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A593010E84B
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133694; bh=fkGNzPgLT1Dz0z6nTFi2No6Ifen2fpOCha4Dk4M3oxg=;
 b=T5vLYGehIzCZM1S/x8LHz5E128F+A/DKHRYd3dtREEkDbJVm5aaj2Azzc8r4e1SyOASLn8WOr
 TvOXrsP9zgdHVl3SKOP4na2loL8bpZ2lx2gwEEuNTkMsfqWLUfI8SzZdTXxHebRqkSJHEhF8p+n
 18Oh7Xl5RxQs+Xi+m7HkrR1u441C8CVVh4Niyr5Gg/6mWVv1nGhv//zn43IyYSNB7YbCLlJ/y1h
 Gw5insWH64VCtP8X940I40dKnFIbJ52LM+t1U8v1wXydadnOuWSRpbkQP9F+pFCcORNPuY9M4WA
 qgL/njx1yEAoTIIMicMULmeqKLfzdG/Gp+bnytvliH7g==
X-Forward-Email-ID: 6a0b6cf1b74b0ebd362eee3b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org
Subject: [PATCH 02/13] drm/meson: dw-hdmi: Protect from possible NULL pointer
 dereference
Date: Mon, 18 May 2026 19:47:30 +0000
Message-ID: <20260518194744.2483580-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518194744.2483580-1-jonas@kwiboo.se>
References: <20260518194744.2483580-1-jonas@kwiboo.se>
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

The IRQ handler can be called at any time after the call to
devm_request_threaded_irq() completes, even before dw_hdmi->bridge has
been assigned later in meson_dw_hdmi_bind().

Protect from a possible NULL pointer dereference in IRQ handler by only
calling drm_helper_hpd_irq_event() when bridge has been assigned.

Fixes: e67f6037ae1b ("drm/meson: split out encoder from meson_dw_hdmi")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
I only observed this NULL pointer dereference one time, without being
able to reliably re-create a similar timing scenario. I still think this
is an issue that possible could happen and likely should be fixed.

Note that patches later in this series will fully replace this change.
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 993f6d5d4b29..eafe7daf6ff1 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -520,7 +520,8 @@ static irqreturn_t dw_hdmi_top_thread_irq(int irq, void *dev_id)
 	u32 stat = dw_hdmi->irq_stat;
 
 	/* HPD Events */
-	if (stat & (HDMITX_TOP_INTR_HPD_RISE | HDMITX_TOP_INTR_HPD_FALL)) {
+	if (stat & (HDMITX_TOP_INTR_HPD_RISE | HDMITX_TOP_INTR_HPD_FALL) &&
+	    dw_hdmi->bridge) {
 		bool hpd_connected = false;
 
 		if (stat & HDMITX_TOP_INTR_HPD_RISE)
-- 
2.54.0

