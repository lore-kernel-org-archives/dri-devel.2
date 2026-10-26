Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD03606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TwPeAI17
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3468810F330;
	Tue, 27 Oct 2026 09:32:12 +0000 (UTC)
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com
 [74.125.225.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBECD10E167
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:48:13 +0000 (UTC)
Received: by mail-wm2-f10.google.com with SMTP id
 5b1f17b1804b1-4a16dfb8fa6so17658425e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054892; x=1793659692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xlqP9nlXPIQC9v0fnOGYQwCTYHMQLryM+G9N3rnt/EE=;
 b=TwPeAI17uxomlpPbNip37aQGUJibMm0Qa35JOwNrsRm33pc6RGfTZLNSWkq/4adK1y
 NBbaHDl5FqvzTQWerVoSlnFQZd2nR8Q7y/HcP0JXJG4jrdtmevjEIFvFFJlmvlbJ5QCq
 0Gip/zfZt3MJIl93PN8aA2bx46s5qjlzvySGHGzNni34YEMOdAa7wvbAPzQ8J68REuFY
 ZvZTW3HdQUXE52GuSrXd41sXxg+ZWArbrjKWgNJvgNTPk6YicOChkhBXGRlvJSg2bglS
 ddp9cN1goJGWczmcXiA2BiyqPGzR5ZD+pbcnAkkbkzXA15dGzfnKD1xoMAGAsX7DhM4P
 R2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054892; x=1793659692;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xlqP9nlXPIQC9v0fnOGYQwCTYHMQLryM+G9N3rnt/EE=;
 b=Sa7XNGlV88t0SVhq1Altyzn/hZqKtSDYS01iQDUx3wnwUkMseXhVEPwvvNk9luHpRo
 BuLgW9wksj1hUhEEqx77FEIVSApDrTGOLYtFaA3f29SQHeq86hTF+zv+k78J42xl9GC1
 MiOT5qCOdFyrJ19WfiptFDeOIUyw2TTmnfttssg+lt4lPUQN+qT0crl1QO/HLurxVNn2
 nobiCCWZQ55Xz0FbeIe6fKuY4SroGNEY8y+0uU5k8MTrTLtpdpGaF8DjazDsohCaWw7j
 MdFW7ztOPg6wF2YvHpIrb5ZJKNDs3028d7QOus73zbGgQkLjZJjRqOJOOwxUkq+zhpAb
 o8+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6mdGx5vq5OAJHX+KXR8h1JAoe7iYJyRsNmPoPAHQAyR4HQIPjY4wH+1yIjuTJG3XGixoHfOO10tY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKmZw+MiFYprVYhLmDRhfgq7Ty1r+mHGxwHZP/PFomIywRvRsd/
 E/ppvq1zfJ0k1ZwvnWzlkOu80oPmav9MLctrZbuRWN/Yfgu/xcKimnxl
X-Gm-Gg: AYBFou2fzZf0DEjyDJyJ5YzuU8y6doBItrbBq4LDNgnxJeiTG7b7J1XCbw+m/9WDd1K
 GTKQnLuDlIhsp+cwLqzgsh+xjBCO82oUcR8LvKf8FNt4/Sm4j934AiprGAh48jEtRnCw11gdmuW
 kpbgo7XIiHhlFHK/kYh/ssc/RH4eAOhTlpoMpwB3aluFcePO5xbS0QpD9spzswsyWtRGD8pSoML
 xFmLJPPbDidhSKLmdTDZ8KL7gv0Y8m2Dss2Vnyczms3fQmtePGu3FS+VL/PExOxK0yNHEm1qDxD
 CXeMi2Qb22Anq5OoflxiMEv9kK8VLGloV4umYIQVCZNL2BrkQfPl3RC0e+4fnivjH5ovm90DEAL
 5rnx5sIhPeCT73Mw+eJeZ+6wO/lqIsviXAK57F2ioMqwLWZMe72FuSAT1Ifa/gV8ypxNWsMO5SD
 tXlX/vGWyFU02iXq1yNP3a+SWDmQDkiqh/oRwk+6KRcFvQr+OVF1HIR56yTkDKIu5BhkjOccqJo
 EKuI9cSy8gGGnsN52YLvnPnYeKN7z4ehBbi19TALGw5QXtDXw==
X-Received: by 2002:a05:600c:8b2c:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4a35acaa6d1mr153363505e9.27.1793054891988; 
 Mon, 26 Oct 2026 15:48:11 -0700 (PDT)
Received: from [192.168.1.12] ([31.94.68.191])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2e8f25sm224603255e9.14.2026.10.26.15.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 15:48:10 -0700 (PDT)
Message-ID: <18b5101d-c05e-45c0-a880-457bb7b9d887@gmail.com>
Date: Mon, 26 Oct 2026 22:48:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Richard Lane <richardlanedev@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH 2/3] drm/amd/display: unlock secondary tile on Apple 5K iMac
 panels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
- Pair the two internal dc_link instances during EDID quirk matching for
  DCE < 12 iMac15,1, iMac17,1, iMac18,3, and Polaris-based iMac19,1
  (identifying roles via connector_signal since panel IDs can flip
  across the two links after S3 wake). DCE >= 12 support for Vega-based
  iMac19,1, iMacPro1,1, and iMac20,x is documented as TODO.
- Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
  on the root eDP link when probing the secondary link.
- Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
  0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
- Prevent the secondary tile from entering DP_SET_POWER D3, which causes
  the TCON to drop HPD and stop responding to AUX transactions.
- Override the secondary tile's connector type to DRM_MODE_CONNECTOR_eDP
  so userspace compositors treat both tiles as a single built-in display.
- Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
  and DP_EDP_CONFIGURATION_SET (0x10A) in dm_suspend() so the TCON
  returns to single-pipe mode for the EFI boot screen across reboots.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  6 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++++++
 .../drm/amd/display/dc/link/link_detection.c  | 14 +++++++-
 .../dc/link/protocols/link_dp_capability.c    |  7 ++++
 .../display/dc/link/protocols/link_dp_phy.c   |  8 +++++
 7 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdabb4bf14da..548f975c7324 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1607,6 +1607,35 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(dm_destroy_cached_state);
 
+/*
+ * Unlatch Apple 5K panel tiles and reset DPCD state on suspend/shutdown.
+ * This returns the TCON to single-pipe mode so the EFI boot logo is not
+ * skewed on reboot.
+ */
+static void amdgpu_dm_apple5k_unlatch(struct dc *dc)
+{
+	const u8 zeros[3] = { 0 };
+
+	for (int i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (dc_link_is_apple_5k_secondary(link)) {
+			/*
+			 * Clear Boot Camp source table (0x310), eDP config
+			 * (0x10A), and secondary tile latch (0x4F1).
+			 */
+			core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
+			core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
+			core_link_write_dpcd(link, 0x4F1, zeros, 1);
+
+			/* Unlatch primary root tile */
+			core_link_write_dpcd(link->tiled_peer, 0x4F1, zeros, 1);
+
+			break;
+		}
+	}
+}
+
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1674,6 +1703,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 
+	amdgpu_dm_apple5k_unlatch(dm->dc);
+
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
 	if (dm->dc->caps.ips_support && adev->in_s0ix)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ded8e21897f1..27de7965f366 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3460,6 +3460,12 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	}
 
 	connector_type = to_drm_connector_type(link->connector_signal, link->link_id.id);
+	/*
+	 * Override Apple 5K secondary tile to eDP so compositors treat it as
+	 * built-in.
+	 */
+	if (dc_link_is_apple_5k_secondary(link))
+		connector_type = DRM_MODE_CONNECTOR_eDP;
 
 	res = drm_connector_init_with_ddc(
 			dm->ddev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9774ea33272d..db6ac803e14f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -97,6 +97,21 @@ STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 }
 EXPORT_IF_KUNIT(edid_extract_panel_id);
 
+/*
+ * Pairs the two internal hardware links driving the Apple 5K panel,
+ * allowing the driver to synchronize both tiles as a single display.
+ */
+static void dm_helpers_wire_tiled_peer(struct dc_link *link)
+{
+	u32 peer_index = link->link_index ^ 1;
+
+	if (link->ctx->dce_version < DCE_VERSION_12_0 &&
+	    peer_index < link->dc->link_count) {
+		link->tiled_peer = link->dc->links[peer_index];
+		link->tiled_peer->tiled_peer = link;
+	}
+}
+
 STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 			      struct dc_edid_caps *edid_caps)
 {
@@ -173,6 +188,25 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
 		edid_caps->panel_patch.force_freesync_min_hz = 60;
 		break;
+	/*
+	 * Workaround for Apple 27" 5K iMacs which expose a 2x1 tiled internal
+	 * panel over an eDP root link and a secondary DP link. Wire the peer
+	 * links to latch and synchronize both tiles, using connector_signal
+	 * for role assignment as panel IDs can flip after wake.
+	 * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
+	 * iMac18,3 (AE11/12), iMac19,1 (AE25/26); TODO (DCE >= 12): iMac19,1
+	 * Vega (AE25/26), iMacPro1,1 (AE1D/1E), iMac20,x (AE31/32).
+	 */
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
+		dm_helpers_wire_tiled_peer(link);
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f4fefa7c9ab8..498c11c0616f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2003,6 +2003,12 @@ struct dc_scratch_space {
 	bool skip_implict_edp_power_control;
 	bool forced_psr_active;
 	enum backlight_control_type backlight_control_type;
+
+	/*
+	 * Partner link for dual-tile Apple 5K panels, wired during EDID quirk
+	 * matching.
+	 */
+	struct dc_link *tiled_peer;
 };
 
 struct dc {
@@ -3172,6 +3178,12 @@ struct dc_sink {
 
 void dc_sink_retain(struct dc_sink *sink);
 void dc_sink_release(struct dc_sink *sink);
+/* Helper to identify secondary (DP) tile of the Apple 5K panel. */
+static inline bool dc_link_is_apple_5k_secondary(const struct dc_link *link)
+{
+	return link && link->tiled_peer &&
+	       link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT;
+}
 
 struct dc_sink_init_data {
 	enum signal_type sink_signal;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index b4546f93af0c..25662ed3e612 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -218,7 +218,8 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 			 * we assume signal is DVI; it could be corrected
 			 * to HDMI after dongle detection
 			 */
-			if (!dm_helpers_is_dp_sink_present(link))
+			if (!dc_link_is_apple_5k_secondary(link) &&
+			    !dm_helpers_is_dp_sink_present(link))
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		}
 		break;
@@ -1625,6 +1626,17 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		}
 	}
 
+	/*
+	 * Internal tiled DP secondary reports HPD low until latched. Latch
+	 * the secondary tile via the root eDP link's DPCD (0x4F1) and force a
+	 * single-sink connection.
+	 */
+	if (*type == dc_connection_none &&
+	    dc_link_is_apple_5k_secondary(link)) {
+		core_link_write_dpcd(link->tiled_peer, 0x4F1, &(const uint8_t){1}, 1);
+		*type = dc_connection_single;
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ad1a499b0d9d..15f223e48091 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1496,6 +1496,13 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 				link->dc->vendor_signature.data.raw,
 				sizeof(link->dc->vendor_signature.data.raw));
 	}
+	/*
+	 * Write the 3-byte Boot Camp source table (0x310) required to unlock
+	 * the secondary tile.
+	 */
+	if (dc_link_is_apple_5k_secondary(link))
+		core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
+				     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
 }
 
 void dpcd_write_cable_id_to_dprx(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 49521ac4b0e8..abac117d0514 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -50,6 +50,14 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
 	if (link->sync_lt_in_progress)
 		return;
 
+	/*
+	 * Prevent Apple 5K secondary tile from entering D3 power-down.
+	 * Powering it off causes the TCON to drop HPD and stop responding to
+	 * AUX.
+	 */
+	if (!on && dc_link_is_apple_5k_secondary(link))
+		return;
+
 	core_link_write_dpcd(link, DP_SET_POWER, &state,
 						 sizeof(state));
 
-- 
2.55.0
