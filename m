Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D67CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCE710E709;
	Tue, 13 Oct 2026 17:48:16 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05A210E709
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 387DCC653F9
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:49:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 97C8060362
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:04 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
 id ED2AD11D7183A; Tue, 13 Oct 2026 19:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791913684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VskafZl3EMS3eyL37u/JduD2RMDkb+58+PAofJgKdgw=;
 b=JoSTRWnswLumJqQ6J0ERITh1btt/qCGNo5Vh0gynesygURu2mkumZeaIqsNZka9z2h2DGS
 +vWImwXVRzG7KJPnWt3kcmaXrYWtGfp5CoM+d98A6YxXmqItB+dE2Ok+GUJBR0o1bQiKcd
 2TtQcKC6tTHgs10KgGtiALozMA0S1tINYA0UoUSJG9odyr717VX7XYQazcJ8cA/rKlCHrr
 blh/ws0JNZK9kwJP/0YquWqFnbeQ5VWYy4YFzTI11gf1WLqT3gIydbGkp3jV6g9VoaYI5A
 KSY5cszCZyqEJXW+jDC8nFdSXNvLw1+Y9DTyg3K0w5dNULbg8ZDd7A1FWGHSwQ==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253]) by 9e7fea892943 with LMTP
 id yKHqCgDvzGoYHxEAtaWaaQ (envelope-from <luca.ceresoli@bootlin.com>)
 for <luca.ceresoli@bootlin.com>; Mon, 12 Oct 2026 16:30:24 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D0EA11D70508; 
 Mon, 12 Oct 2026 16:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791815423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VskafZl3EMS3eyL37u/JduD2RMDkb+58+PAofJgKdgw=;
 b=vgHWBa4bLQM5FiPr3TUKfHGNQmGCbDiDpK27WlVC3ZVYr7MuDzdiQpW6DT30s7peAQC7hh
 DVL25/Y46UaNq0Roa9N9Yz8b7rltdd/tm8sUAcnw7dBQgwzLGwc61Fey7Fo2SWQkEtz03m
 uaqLfMitD6if6TCsGSZkLuUp9XzUF2BWf+lsPFqCCivonlhMlo3FJm+e52jlgGTUmOAn84
 0iHTGwsVcLRezN/R+nAnoEHsLQOlCbKC8lQUSotgraiIKFuTmKDyc0RZ9Nh6iXt2kq2XBX
 KZthhgk6i6Rpj20DW6lKf1c/yB340pBC3bPFhECPFL7HfJ7in8rZcJ0xmlzKfg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 12 Oct 2026 16:29:52 +0200
Subject: [PATCH 2/3] drm/panel: stop mentioning deprecated
 devm_drm_of_get_bridge() in docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-drm-bridge-every-panel-cleanups-v1-2-0fd272f486b6@bootlin.com>
References: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
In-Reply-To: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: ED2AD11D7183A
X-Spamd-Result: default: False [2.50 / 30.00]; SUSPICIOUS_RECIPS(1.50)[];
 DATE_IN_PAST(1.00)[27]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.00)[37.78%];
 BCC(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FORWARDED(0.00)[luca.ceresoli@bootlin.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[luca.ceresoli@bootlin.com];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:email,iscas.ac.cn:email];
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

The kernel-doc for drm_of_find_panel_or_bridge() still mentions
devm_drm_of_get_bridge() which is deprecated. Update to mention the
currently recommended API.

Link: https://lore.kernel.org/all/c1b065c8bd926708500b7c42864279e055ed95d0.camel@iscas.ac.cn/
Suggested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_panel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index c00529bfb706..8f35654c4650 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -1039,8 +1039,7 @@ EXPORT_SYMBOL(of_drm_find_panel);
  * return either the associated struct drm_panel or drm_bridge device.
  *
  * This function is deprecated and should not be used in new drivers. Use
- * of_drm_get_bridge_by_endpoint() instead when not looking for a panel, or
- * devm_drm_of_get_bridge() otherwise.
+ * of_drm_get_bridge_by_endpoint() instead.
  *
  * Returns zero if successful, or one of the standard error codes if it fails.
  */

-- 
2.56.0

