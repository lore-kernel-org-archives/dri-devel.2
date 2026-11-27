Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D82606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=cOoWx8+u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97742112C16;
	Fri, 27 Nov 2026 16:44:15 +0000 (UTC)
X-Greylist: delayed 326 seconds by postgrey-1.36 at gabe;
 Fri, 27 Nov 2026 16:44:09 UTC
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091C510E696;
 Fri, 27 Nov 2026 16:44:09 +0000 (UTC)
Received: from abreu.molgen.mpg.de (g44.guest.molgen.mpg.de [141.14.220.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id BFFC64C442F971;
 Fri, 27 Nov 2026 17:43:36 +0100 (CET)
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
Subject: [PATCH 3/3] drm: panel-backlight-quirks: Add Dell XPS 9315 FHD+ panel
Date: Fri, 27 Nov 2026 17:43:29 +0100
Message-ID: <20261127164332.55148-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1795797817; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=hMzITDPGY4WIMS/pDC1S3GbvxdAxOLkqpcyo/6nyvuk=; 
 b=cOoWx8+uDzW9/EcU8/MVFlacrH3b8ksGJ4igsC0+fuQjwYuJGkeW4UqxGF8W7AQDmbd4atBhJDKN
 HI11NRgKSs0yDS/xgOFSnnmE5lXV8oZ8g8vAjhsUXWC24JkzaDpTX6ZzQH/F1dRDE5vnOVwbc6bhn6
 xt6UPT/lW+lccgdeLuin5fM1YO3CNweQVK46GKbjB60JfMF/Zh2qwJ6aGsFjtR5YpidNX9hUj9Bi8Z
 cliR8MSpq5TK8GqlurItngK4c7gf4G9dGuEpB7dB1v3jvoynxhH3Z1MIeWO+3hiwWxFgbZ1QyVek+Z
 c37E/eywWMDRKuoxuKyblZD/nB7UL2Fg==
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Dell XPS 9315 (BIOS 1.26.0, VBT BDB 253, panel_type 14) has the
same problem as the XPS 13 9310: the VBT sets the backlight minimum
level to 15/255, while the other 15 panel entries say 6/255. With GNOME
at its lowest slider position (1 % of max_brightness) the PWM duty
cycle is 6.8 %:

    $ cat /sys/class/backlight/intel_backlight/{max_brightness,brightness}
    96000
    960
    $ sudo intel_reg read 0xC8254 0xC8258    # BXT_BLC_PWM_FREQ/DUTY(0)
                                        (0x000c8254): 0x00017700
                                        (0x000c8258): 0x00001997

The panel is a Sharp LQ134N1 with a different product code
(EDID SHP 0x1548) than the one in the XPS 13 9310. Writing the duty
cycle register directly, 6.8 % is still well readable at the lowest position,
and even 1 % is a little brighter than wanted; the panel is usable
down to 0.25 %.

Add a quirk setting the minimum to 0/255 for this system and panel,
so that GNOME’s lowest position becomes 1 %. Note that the DMI product
name is "XPS 9315", without "13".

Tested on the Dell XPS 9315 (BIOS 1.26.0) with v7.4-rc4 + this series:
"[CONNECTOR:676:eDP-1] Applying panel backlight quirk, min brightness 0/255
(VBT 15/255)", GNOME lowest position gives PWM duty 960/96000 (1 %), was
6551 (6.8 %). The eye test values (0.25 % wanted) were set with intel_reg.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    
    Prepared with Claude Code (claude-opus-5-5).

 drivers/gpu/drm/drm_panel_backlight_quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 85c2ef791d116..1d959a31562e6 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -62,6 +62,15 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.panel_id = drm_edid_encode_panel_id('S', 'H', 'P', 0x14f9),
 		.quirk = { .min_brightness = 1, },
 	},
+	/* Dell XPS 9315 FHD+ panel, VBT minimum 15/255 is too bright */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "Dell Inc.",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "XPS 9315",
+		.ident.panel_id = drm_edid_encode_panel_id('S', 'H', 'P', 0x1548),
+		.quirk = { .min_brightness = 1, },
+	},
 	/* Steam Deck models */
 	{
 		.dmi_match.field = DMI_SYS_VENDOR,
-- 
2.54.0

