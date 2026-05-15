Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFCACD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 11:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C7110E42D;
	Fri, 15 May 2026 11:46:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7088210E417
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 11:46:58 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=ratatoskr.trumtrar.info)
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <s.trumtrar@pengutronix.de>)
 id 1wNr05-0000OE-Ch; Fri, 15 May 2026 13:46:41 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 0/2] Add NEC LCD Technologies NL6448BC33-70C Panel Support
Date: Fri, 15 May 2026 13:46:31 +0200
Message-Id: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-0-74ab0baa1817@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcHB2oC/5WOSw6CMBRFt0I69pmWIqAj92EY9POEZ7BtWiAYw
 t4FXIHDk5zccxeWMBImdssWFnGiRN5tkJ8yZjrlWgSyG7Oc5yW/CAlTBQIGH8hAUA57SPQOPYL
 ry6KotZESjCxRSi1qpQXbhkLEJ81H5NH8OI36hWbYl3ejozT4+DleTGL3/gpOAjhctS10ZTkqw
 +8BXTsO0TuazxZZs67rFzjkJB/rAAAA
X-Change-ID: 20260513-v7-1-topic-panel-simple-nl6448bc33-c36e33b18ab1
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=WDn+yDrscg25DqUiY9rRUTgBd3tw3cvdhJdYzWJx1TY=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQxY7+3zF/RvTRF7vnvFRwWx5XI7z0QN2Tf/X527ti9BdO
 iMg8df+jlIWBjEuBlkxRRaVhRV8oh4fPCOniXDBzGFlAhnCwMUpABPxEWNkmKq6aUN/bE9qkavg
 hemi8o07Zxbu8xa5feuwY5Pk0oATXxj+R15/ccFR7rXi5igmpgWF5gFPV8ta78pf+9TGKe3voeZ
 cDgA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

Add support for the above mentioned LCD panel from NEC.

---
Changes in v2:
- fix .size settings
- set connector_type
- Include feedback from Sashiko AI review: https://sashiko.dev/#/patchset/20260513-v7-1-topic-panel-simple-nl6448bc33-v1-0-9bd4b7d0eac0@pengutronix.de?part=2
- Link to v1: https://patch.msgid.link/20260513-v7-1-topic-panel-simple-nl6448bc33-v1-0-9bd4b7d0eac0@pengutronix.de

To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Steffen Trumtrar (2):
      dt-bindings: display: simple: Add NEC NL6448BC33-70C panel
      drm/panel: simple: add NEC NL6448BC33-70C

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260513-v7-1-topic-panel-simple-nl6448bc33-c36e33b18ab1

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

