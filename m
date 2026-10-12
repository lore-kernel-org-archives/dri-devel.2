Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA1CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFAD210F92B;
	Tue, 13 Oct 2026 17:48:42 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701DF10F927
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C540CC653FB
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:49:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3041260362
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:21 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
 id C386E11D7159B; Tue, 13 Oct 2026 19:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791913700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=OsSk6fybrLW7h+SuC2ZBYJe33YpZ++JFMz5eFq2VUKg=;
 b=CxL9yznrJIZDfvx06wLV5F9Dbq/Hei+KeOA0YMZcobv/QGxtZJ0WTikIce6lOCc44cPZMZ
 jevZ5gt7/Y3DuGknC0hGTIZktLN5Y3ZdecGpXN6mVOT3k2C5eYUoBFi4bAXWGP49RVyf1P
 wCJBDZMt+/wlevvfmpWOrexdZ33TvyZjbjm7N7rDiSckoj/R5RpeQOd1EQhaRD1jqIKY4K
 Qi06dABSzPZ6WwiMk79CL87PUUw6vF6G3kMn64UdAFz+0mBXTVsKCWxd8SCm2fu8pBX0Ms
 RhdS4gS9GilP2MwgK6sY9QKKrwuz/zAnklF8G/EuN4of75MHl76lWdo2j3uDFg==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253]) by 9e7fea892943 with LMTP
 id aFjoM/XuzGpsHhEAtaWaaQ (envelope-from <luca.ceresoli@bootlin.com>)
 for <luca.ceresoli@bootlin.com>; Mon, 12 Oct 2026 16:30:13 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 888F911D70CC0; 
 Mon, 12 Oct 2026 16:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791815408; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=fHD6zSsrxg7Ukx1n42kcY5qUaVBs+GhRS0EahN2FxFA=;
 b=xtIvgHpXYfpGGsRXyeI0tHz7zvmhiVQ9R3X41/ulmzClKScwiaOrzCOg3qyRTKnkavQr8A
 9/HLZtBNs12hkVPqh5251D4NU7YlBnG6/TpDHuSJjBACiCZK+xQs3ckyfgGirasopK+Yqh
 XrKenCO0HbUSQkEh93WRwcGT63m8W75o9zeTINXObRQIpDeSsDlx1j/kdOzjl1HxlmduoP
 BwepzRpfbTUkNhAXmkOqQRv1hSWuTKW9mlkzZsm7HshZqysdlZ0q76yQ0MhUtRkmvZRK77
 J8OBVo2KIEADkLH78ALqnw6bNakQ4aVDRZdVdNuRZQczC6j7nslIltR2KpK3fg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] drm: docs: mention currently recommended API instead
 of deprecated ones
Date: Mon, 12 Oct 2026 16:29:50 +0200
Message-Id: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN0QrCMAyF4VcZuTawFtTpq4gXbZpqZNaSuKGMv
 btVLz8O/GcBYxU2OHYLKM9i8igNbtMBXUO5MEpqBt/7neudx6R3jCqpLTyzvrGGwiPSyKFM1TA
 ftj7mwQ97ImiVqpzl9Xs4nf+2Kd6Ynt8srOsH0wM+aIMAAAA=
X-Change-ID: 20261012-drm-bridge-every-panel-cleanups-f952bf8287cc
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
X-TUID: eSJyxltFBzko
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: C386E11D7159B
X-Spamd-Result: default: False [2.50 / 30.00]; SUSPICIOUS_RECIPS(1.50)[];
 DATE_IN_PAST(1.00)[27]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.00)[40.79%];
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
 URIBL_BLOCKED(0.00)[ffwll.ch:email,lists.freedesktop.org:email,intel.com:email,ideasonboard.com:email,kwiboo.se:email,bootlin.com:email,bootlin.com:mid,bootlin.com:url,localhost:rdns,localhost:helo,suse.de:email,iscas.ac.cn:email,galae.net:url,gehealthcare.com:email,linaro.org:email];
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

This series replaces references to deprecated functions in the docs with
the current recommended API.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      drm/bridge: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      drm/panel: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      drm/drv: stop mentioning deprecated drm_of_find_panel_or_bridge() in docs

 drivers/gpu/drm/drm_bridge.c | 5 +++--
 drivers/gpu/drm/drm_drv.c    | 8 ++++----
 drivers/gpu/drm/drm_panel.c  | 3 +--
 3 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 73df79cceb8c01f311055a61794e229dc81546cb
change-id: 20261012-drm-bridge-every-panel-cleanups-f952bf8287cc

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

text:
Return-Path: <luca.ceresoli@bootlin.com>
Delivered-To: luca.ceresoli@bootlin.com
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id aFjoM/XuzGpsHhEAtaWaaQ
	(envelope-from <luca.ceresoli@bootlin.com>)
	for <luca.ceresoli@bootlin.com>; Mon, 12 Oct 2026 16:30:13 +0200
X-Original-To: luca.ceresoli@bootlin.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 888F911D70CC0;
	Mon, 12 Oct 2026 16:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791815408; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fHD6zSsrxg7Ukx1n42kcY5qUaVBs+GhRS0EahN2FxFA=;
	b=xtIvgHpXYfpGGsRXyeI0tHz7zvmhiVQ9R3X41/ulmzClKScwiaOrzCOg3qyRTKnkavQr8A
	9/HLZtBNs12hkVPqh5251D4NU7YlBnG6/TpDHuSJjBACiCZK+xQs3ckyfgGirasopK+Yqh
	XrKenCO0HbUSQkEh93WRwcGT63m8W75o9zeTINXObRQIpDeSsDlx1j/kdOzjl1HxlmduoP
	BwepzRpfbTUkNhAXmkOqQRv1hSWuTKW9mlkzZsm7HshZqysdlZ0q76yQ0MhUtRkmvZRK77
	J8OBVo2KIEADkLH78ALqnw6bNakQ4aVDRZdVdNuRZQczC6j7nslIltR2KpK3fg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] drm: docs: mention currently recommended API instead
 of deprecated ones
Date: Mon, 12 Oct 2026 16:29:50 +0200
Message-Id: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN0QrCMAyF4VcZuTawFtTpq4gXbZpqZNaSuKGMv
 btVLz8O/GcBYxU2OHYLKM9i8igNbtMBXUO5MEpqBt/7neudx6R3jCqpLTyzvrGGwiPSyKFM1TA
 ftj7mwQ97ImiVqpzl9Xs4nf+2Kd6Ynt8srOsH0wM+aIMAAAA=
X-Change-ID: 20261012-drm-bridge-every-panel-cleanups-f952bf8287cc
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

This series replaces references to deprecated functions in the docs with
the current recommended API.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      drm/bridge: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      drm/panel: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      drm/drv: stop mentioning deprecated drm_of_find_panel_or_bridge() in docs

 drivers/gpu/drm/drm_bridge.c | 5 +++--
 drivers/gpu/drm/drm_drv.c    | 8 ++++----
 drivers/gpu/drm/drm_panel.c  | 3 +--
 3 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 73df79cceb8c01f311055a61794e229dc81546cb
change-id: 20261012-drm-bridge-every-panel-cleanups-f952bf8287cc

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

