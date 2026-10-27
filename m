Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F69606A327
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=ccphCd2b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB1310E366;
	Tue, 27 Oct 2026 10:34:11 +0000 (UTC)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72AB10E366
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1793097242; x=1793356442;
 bh=/sVy401gR2AeEzGop8THwUPTGkzUpgq7Tv+MYP33ejY=;
 h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ccphCd2bFbwuXaYq8iH1YhXtQ20TEAxITPlm7Up0peJw1tjrBudAeMsmU98rV5TBq
 iOUHZvT0CcOpcU2JT+5UG5/3EQAgwGOeNxxMrUK/j/naz+RLXlxQperInK70bgZbtc
 dgeRNM5cjObA9gl6uTiILuCTOfa0ka3fwD+Wu5VyxpBPEvO6Alb+njx1Afk6GZdc7J
 JJGtbfyhWtUDn/Bo1W/PRtCAp+Oc904lKniis6ZU/d5rEoicq7sfJq/JdPcnmSP21N
 Y+OkEL3qXzPWW6epwjyRcz6G75y8Bpl6tlUwPSncWO1QGFxU6X0UvEiOrVL49E7fiL
 6beMk1B/NLPsA==
X-Pm-Submission-Id: 4jDRgB1x3vz1DDWq
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v5 0/4] drm/bridge: nwl-dsi: Various fixes
Date: Tue, 27 Oct 2026 11:33:48 +0100
Message-Id: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQW7CMBAF0Ksgr+tqZpw4dlfcA7GY2AO4apMqh
 pQK5e51YAEl6vJr/vtzUVmGJFm9rS5qkDHl1Hcl1C8rFQ7c7UWnWLIiIAsNgu6+P3TMSe/SWbI
 OWLkWOLbW1aqYr0Guh0I221vOp/ZdwnEemRuHlI/98HN9OOLc+297RA3aUxM9OnaW43ov3KXza
 +g/1Tw+0p07MM+cCkcHnoFDVZvdgpsHvvxuCqfaRvbRNiS44NUDN/jMq8ItE2NoyXiEP3yapl+
 r4ut8egEAAA==
X-Change-ID: 20260710-nwl-dsi-fixes-c148b0adb685
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, imx@lists.linux.dev
Cc: Esben Haabendal <esben@geanix.com>, Frank.Li@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097237; l=3107;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=m0BPHe2DqHEKhL89dJjDFmUw11rDNI6REaVlOvyHss8=;
 b=aRY/BQFfU0aZSQufqd1D0E2EWNHAJ0nioO/HoN49yU6Elm6cH60p3M2nXElEqY5H7NumOh5bg
 IK5Rao5amWUBVEwWJASKJIjq0PnQ2W0Yh1Q7pyGzFq+4uKKqPhRlAYx
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series brings a few patches fixing horizontal sync timing, EOTP packet
behavior and hsync/vsync polarity selection when using DCSS endpoint, as
well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.

The 3rd commit ("Correct auto-insert EOTP behavior") is taken directly from
NXP vendor tree, so I have kept Author unchanged, although I have modified
the commit message. Let me know if I should change Author for that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v5:
- Add fixes tag.
- Sort header files alphabetically.
- Fixed speling mistake.
- Link to v4: https://patch.msgid.link/20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com

Changes in v4:
- Change calculation of hfp/hbp/hsa to use the raw clock rates directly to
  eliminate intermediate rounding errors.
- Drop patch 4 (will be included in follow-up patch series, together with
  a patch addressing the unblanced resource teardown and PM runtime
  underflow problems in the error path).
- Link to v3: https://patch.msgid.link/20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com

Changes in v3:
- Added Fixes and Cc: stable tags.
- Split patch 1 into two, with change of endpoint mux control in a separate
  patch.
- Fixed mux_control_try_select() state argument.
- Link to v2: https://patch.msgid.link/20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com

Changes in v2:
- Added safeguard against small horizontal sync timings, protecting against
  division by zero and integer underflow.
- Added error handling of nwl_dsi_mode_set() call.
- Link to v1: https://patch.msgid.link/20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Guido Günther <agx@sigxcpu.org>
To: Fabio Estevam <festevam@gmail.com>
To: Robert Chiras <robert.chiras@nxp.com>
To: Sam Ravnborg <sam@ravnborg.org>
To: imx@lists.linux.dev
Cc: Frank.Li@kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (3):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing

Robert Chiras (1):
      drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior

 drivers/gpu/drm/bridge/nwl-dsi.c | 87 ++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260710-nwl-dsi-fixes-c148b0adb685

Best regards,
--  
Esben Haabendal <esben@geanix.com>

