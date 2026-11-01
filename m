Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1F606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJqom64p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1694F10EBD7;
	Mon,  2 Nov 2026 08:04:11 +0000 (UTC)
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEE710EAE3
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:24:50 +0000 (UTC)
Received: by mail-wm2-f6.google.com with SMTP id
 5b1f17b1804b1-4a1d25d7d5dso11304935e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793575488; x=1794180288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QOc/+pAAVAzpsjbhDTB2SpKcdDFIk9fN2ZS/vqFolwg=;
 b=cJqom64pV7Xo22do4rvIew30msVL91bGGlHJtxokUIXzoMD2M6rYmEAAJ5xCbtAJK1
 ues82B8xrAasvy9LDg3ez3rlLiCeDrFbyqvyFoRN7238yurVuy1CPtB1g/LXMgXMe5QH
 gROxUWOHGBNMiqAGua8ceU06P5xNCH3nlZIQCV48U/6Kb25cq3cWjlbYxKRAeE+YwfT5
 TcZ0Ypu8YCcYBZy/PpDjosGq9ZRLwPe92BRt7pamvY9SSfZw97KO6LKMEB7EtU5727+8
 i+IXgnvHXKAk6CU/DbQqYMqpkrz8eFn0Hy1l45rvdTp5y9m0SM12kTWnqGJuA1mjAxbL
 h1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575488; x=1794180288;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QOc/+pAAVAzpsjbhDTB2SpKcdDFIk9fN2ZS/vqFolwg=;
 b=gdhx07+rhzH235A882cvDixdCyZszcDmDJZHvKJoLlhUB2fUAv+bVSK8whtzDudCtg
 fi0W1Brlm6RC5dyWqbpEnVtLfynz2H3oKSaHWVH9+KvlR8zQGoVe7qYuYFZaLOqWmtsb
 Hj3I/eLcwhd6thx9axZwnsheEmfzeQXwHxknEyv/dVJvVUiunzmJfqo2E9UAosBb89Bs
 evUhb4Av2qH3BTQFk9U7toPzpQZsQxD6Wea8R7mvDpiY4UM7t2sZnKKX1l+u8s21ZFnC
 lBxLQUueH+c1nPFeVdYiswy/fz+5nUNsSV9t34ftJuPzQatAelMEBIejKlV8DSTSjoi+
 tjOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3mNAJlghfkXSClcOvXVR0UTRisCoWmo94trJSjn3KpOaXbJHj331Q9ndC5kcnrI2tCJxlGthCXjs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJPD5D/URDBgW+FBYRqGZcEIFHgozkUWKbSHb9tBKkWQXrrqT+J
 TBtIwM1swTl8sQbetZ6CJDIguPrgA+XNTZVdHzA7cG9Bsft6YfgU8vjy
X-Gm-Gg: AYBFou0hfrIRklpBqP54Zc/Yf4q4wjtJBBBC6L2hSb8fs9OG9/EZBteHYXGRU87aEcb
 CTYsvt898qeU1phbymEHXXvvKDiX29MaAaHMoM66SMxgbEfWObOgOoUEANmoBaRilJz1SKHIks7
 zPk/wOEA07/lBLYIl8B+RCgccXDh1nCNN4tgxli/TDs0/jaOX5e6qXUraVLzY5M+GojeITFB4+a
 PN1IWA7V0ki8OuBk0ZEV88jsPTGAAycpgVdUZTaByUMs1ahyItoql+jYnw288FUsw/g8PrL3K06
 xZdXGIDPufIAcKmjFwMwwQetMIpx6r/ZANHqg4OaMxPMCfvk3duhEiStllbQlR0Fy1WOY1FIAyp
 7gvf6VY+fESRg2T70rqho+0HgtOAXiEtTbqBP8vYdgbdkIYT7nO209r4pSDJCxqxrUDCwEJysB3
 RTKigSQ2XKIXLrU6CQqTpKIatjExmoDdFkd9V/lHtgByUbu3QoRaTrKNCqhc6olsvkY2ASpkRb9
 ZmV9F7QbOyBP7P0FcxbGOdvKzMUBlRJi+MvHuINbx6YRbgIVKmWMNreNgjEgaz2opKBGy61yRnQ
 7s84pZTUrgQBx4/CanfaEEaIgL2JpXj7iCZD7lkFZxwhFY3AhdZ5+Wky
X-Received: by 2002:a05:600c:811a:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4ac187a6b30mr181861095e9.28.1793575488290; 
 Sun, 01 Nov 2026 15:24:48 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm341309865e9.11.2026.11.01.15.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 15:24:46 -0800 (PST)
Message-ID: <94672259-c526-4ec7-a69c-7dda8d934593@gmail.com>
Date: Sun, 1 Nov 2026 23:24:45 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v2 2/3] drm/amd/display: unlock secondary tile on Apple 5K,
 iMac panels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apple 27" 5K iMacs (2014-2019, iMac15,1 through Polaris-based iMac19,1)
expose their internal 5120x2880 panel as a 2x1 tiled display over an eDP
root link and a secondary DP link. At boot, the panel TCON operates in
single-pipe mode and holds the secondary DP link's HPD line low until
unlocked via DPCD registers.

Enable native tiled detection and link training for DCE < 12 Apple 5K
panels:
- Point the secondary DP dc_link to the root eDP dc_link (apple_5k_peer)
  during EDID quirk matching on DCE < 12 iMac15,1, iMac17,1, iMac18,3,
  and Polaris-based iMac19,1 (checking connector_signal since panel IDs
  can flip across the two links after S3 wake). DCE >= 12 support for
  Vega-based iMac19,1, iMacPro1,1, and iMac20,x is documented as TODO.
- Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
  on the root eDP link when probing the secondary link, allowing the
  secondary link to read its EDID and populate DRM's DisplayID tile
  properties (has_tile, tile_group, and tile_is_single_monitor).
- Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
  0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
- Prevent the secondary tile from entering DP_SET_POWER D3, which causes
  the TCON to drop HPD and stop responding to AUX transactions.
- Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
  and DP_EDP_CONFIGURATION_SET (0x10A) in dm_suspend() so the TCON
  returns to single-pipe mode for the EFI boot screen across reboots.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/link/link_detection.c  |  7 +++++-
 .../dc/link/protocols/link_dp_capability.c    |  4 ++++
 .../display/dc/link/protocols/link_dp_phy.c   |  3 +++
 6 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdabb4bf14da..74cd88d8d580 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1607,6 +1607,23 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(dm_destroy_cached_state);
 
+static void amdgpu_dm_apple5k_unlatch(struct dc *dc)
+{
+	const u8 zeros[3] = { 0 };
+
+	for (int i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (link->apple_5k_peer) {
+			core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
+			core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
+			core_link_write_dpcd(link, 0x4F1, zeros, 1);
+			core_link_write_dpcd(link->apple_5k_peer, 0x4F1, zeros, 1);
+			break;
+		}
+	}
+}
+
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1674,6 +1691,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 
+	amdgpu_dm_apple5k_unlatch(dm->dc);
+
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
 	if (dm->dc->caps.ips_support && adev->in_s0ix)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9774ea33272d..532748127f72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -173,6 +173,28 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
 		edid_caps->panel_patch.force_freesync_min_hz = 60;
 		break;
+	/*
+	 * Workaround for Apple 27" 5K iMacs which expose a 2x1 tiled internal
+	 * panel over an eDP root link and a secondary DP link. Point the
+	 * secondary link to the root link to latch/unlatch the TCON via DPCD,
+	 * checking connector_signal as panel IDs can flip after wake.
+	 * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
+	 * iMac18,3 (AE11/12), iMac19,1 (AE25/26); TODO (DCE >= 12): iMac19,1
+	 * Vega, iMacPro1,1 (AE1D/1E), iMac20,x (AE31/32).
+	 */
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
+		if (link->connector_signal == SIGNAL_TYPE_EDP &&
+		    link->ctx->dce_version < DCE_VERSION_12_0 &&
+		    (link->link_index ^ 1) < link->dc->link_count)
+			link->dc->links[link->link_index ^ 1]->apple_5k_peer = link;
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f4fefa7c9ab8..aa1a9eea99d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2003,6 +2003,7 @@ struct dc_scratch_space {
 	bool skip_implict_edp_power_control;
 	bool forced_psr_active;
 	enum backlight_control_type backlight_control_type;
+	struct dc_link *apple_5k_peer;
 };
 
 struct dc {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index b4546f93af0c..47755f8b9c3e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -218,7 +218,7 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 			 * we assume signal is DVI; it could be corrected
 			 * to HDMI after dongle detection
 			 */
-			if (!dm_helpers_is_dp_sink_present(link))
+			if (!link->apple_5k_peer && !dm_helpers_is_dp_sink_present(link))
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		}
 		break;
@@ -1625,6 +1625,11 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		}
 	}
 
+	if (*type == dc_connection_none && link->apple_5k_peer) {
+		core_link_write_dpcd(link->apple_5k_peer, 0x4F1, &(const uint8_t){1}, 1);
+		*type = dc_connection_single;
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ad1a499b0d9d..d646b156c90b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1496,6 +1496,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 				link->dc->vendor_signature.data.raw,
 				sizeof(link->dc->vendor_signature.data.raw));
 	}
+
+	if (link->apple_5k_peer)
+		core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
+				     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
 }
 
 void dpcd_write_cable_id_to_dprx(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 49521ac4b0e8..56fe2710ee2c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -50,6 +50,9 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
 	if (link->sync_lt_in_progress)
 		return;
 
+	if (!on && link->apple_5k_peer)
+		return;
+
 	core_link_write_dpcd(link, DP_SET_POWER, &state,
 						 sizeof(state));
 
-- 
2.55.0
