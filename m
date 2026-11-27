Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0354606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=TasBawW0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9E210E605;
	Fri, 27 Nov 2026 16:40:18 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D4310E605
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:40:12 +0000 (UTC)
Received: from abreu.molgen.mpg.de (g44.guest.molgen.mpg.de [141.14.220.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id ED4CC4C442F95E;
 Fri, 27 Nov 2026 17:38:04 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm: panel-backlight-quirks: Add Dell XPS 13 9310 FHD+
 panel
Date: Fri, 27 Nov 2026 17:37:46 +0100
Message-ID: <20261127163752.54806-3-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127163752.54806-1-pmenzel@molgen.mpg.de>
References: <20261127163752.54806-1-pmenzel@molgen.mpg.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1795797485; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=j7TDyDQvi4Sz29HnmKxiqMl7kx9/s5Sqkt3Odi2jpUU=; 
 b=TasBawW0rdUvlR0p/K7lg+NZCu6ZCi36j2s57J4Sg4mhXYgip0yeazFPv0If1jcQdRbCViO6QUJm
 Q3t2GvKbk148Q46Me5gTaC7FtfuCZKTn4hfu++iFgt2t3A0gJXBJYoshB6x5yZMWLaK5o+z4wBBT4O
 akvDnj99V4rPIkLKIecf1q+/nE2ZSXpJ7Q4HFSyXjS+6n14WXbAclrDKcO95gyDhDDP1hJM3dCfCyR
 rRfINHZC7K8mb8a7MKAEjJZBWO3/0Lz9+FV6UNok/uRBszUjjqhmKhHjxnqbRrJJYCSgPXO9TXtIIs
 YssGwi1vcaIt3PbNQYWH383tZMG1Kj8Q==
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VBT of the Dell XPS 13 9310 (BIOS 3.17.0, BDB 240, panel_type 2)
sets the backlight minimum level to 15/255, so i915 maps brightness 1
to a PWM duty cycle of 5.9 %. With GNOME, which does not go below 1 %
of max_brightness, the lowest slider position gives 6.8 %, which is
still too bright in a dark room:

    $ cat /sys/class/backlight/intel_backlight/{max_brightness,brightness}
    96000
    960
    $ sudo intel_reg read 0xC8258    # BXT_BLC_PWM_DUTY(0)
                                        (0x000c8258): 0x00001997

    6551 = 5647 + 960 * (96000 - 5647) / 96000, with 5647 = 15/255 * 96000

Writing the duty cycle register directly shows that the panel, a Sharp
LQ134N1 (EDID SHP 0x14f9), is well readable at 1 % (960/96000).

Add a quirk setting the minimum to 0/255 for this system and panel, so
that brightness maps linearly onto the PWM duty cycle, and GNOME’s
lowest position becomes 1 %. Other XPS 13 9310 panels (UHD+, OLED) were
not tested, so match the panel ID as well.

Tested on the Dell XPS 13 9310 (BIOS 3.17.0) with v7.4-rc1 and v7.4-rc4
based kernels: GNOME lowest position gives PWM duty 960/96000 (1 %),
was 6551 (6.8 %).

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    
    Prepared with Claude Code (claude-opus-5-5).

 drivers/gpu/drm/drm_panel_backlight_quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index dcb91e12bac6b..85c2ef791d116 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -53,6 +53,15 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.name = "NE135A1M-NY1",
 		.quirk = { .min_brightness = 1, },
 	},
+	/* Dell XPS 13 9310 FHD+ panel, VBT minimum 15/255 is too bright */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "Dell Inc.",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "XPS 13 9310",
+		.ident.panel_id = drm_edid_encode_panel_id('S', 'H', 'P', 0x14f9),
+		.quirk = { .min_brightness = 1, },
+	},
 	/* Steam Deck models */
 	{
 		.dmi_match.field = DMI_SYS_VENDOR,
-- 
2.54.0

