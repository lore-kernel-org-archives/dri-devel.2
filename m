Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFBE606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuQZ4+6W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082B710E8E3;
	Wed, 25 Nov 2026 01:04:21 +0000 (UTC)
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com
 [74.125.225.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C9210F929
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:04:15 +0000 (UTC)
Received: by mail-wr2-f10.google.com with SMTP id
 ffacd0b85a97d-4b5a3bb6f93so437410f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 17:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795568654; x=1796173454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZaAfTAhod0KsCHwch0RTwIyMPUo4/UoaPQV4KvJ97KM=;
 b=yuQZ4+6WONzAnx0SPvpprkq4dn1ZR8EgV1wEUaU/S2WfmHNOvYsSClfzL1lwUZARGe
 mwyH8lGKuAlFWp8Qdv8hHwb6joKKXjsk9QNBWzgqH27dL0uPvbfODivmJyIlF2jRGmjr
 jbXnrNgPAierh+qy2dhgCqftoZDjEtU/Ke+7ZLy+01Od6BFrViwe8RD4E7ejWnmThGAi
 fGNuSsfVE5IUFEOnzX0Hz8btaZLe6fSEabgPatp3FU/h384VwTV3SCey97t+WF6oDphh
 vj7qY4pod8DnRNGuXN4u+9n2P7ixZHikjkW3sXcBfa0bMpEkxB1G9M0tnL1ZO8Z3R1Z3
 sTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795568654; x=1796173454;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZaAfTAhod0KsCHwch0RTwIyMPUo4/UoaPQV4KvJ97KM=;
 b=kTQCr67ofbXy4wcK2AQ+YqIMltBTM7dY7FJbulCMYUAmMZiIfy2KMcSWv+BDLmkujU
 HGXmToIGwt//OjHC2pSyCe7MJi3S5wA0Uz81OUWSBlxw9/maB7XyTL1AqtiD5V8eiT+f
 MhbvGe2gB7dE686R7tFop43l04wTVfUOFB4TqouQ7OHOCw5d9n4teVPqFU0q+y5BzC7I
 axW8XRJajAsDcjwln/l1u7dzwCYExTAJDFL0cPiaG9IJlwNPWSXA5h2HeRkY87T+Pvgq
 nk7VNOYS9GB/K7ZqcEHFGEmutunW35rNVE3aw33+cWByWRPSdJSymzBZ1bkS4qeGzqsH
 ecRw==
X-Forwarded-Encrypted: i=1;
 AL+hErFKlDZAK/W/Yf3aXSGI1JjQn8FVSD0zHxN3UOEd8wWftbhNeIRUDQ7yraiF4QEQfBizQ0Aciq/9cZE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NuzMbZJ6o81yWeZw84yoLGu2DvgbMfpl4DcDleYZ32Huf+c+d
 dwK/svy4HS1ifRlSp0qaFjlZAD/wgKguGn3+7eb+zsG6VnH5nmFmZP5a
X-Gm-Gg: AZFdTZcVk2hmKW68XH/U3fxQHyLDwVXILtdNQCDKn2u4GmadvmHsHv+oWYKFh+Ce+rI
 Iz07qORAlxMJnB5XwZDcMRZ9MwpFhDtQao04Kv8sW3IlYR7Q/slVGmUj6TsWXXeHvD34Dxria0T
 QzWGA5YHXotqZKL04ysPDTqSnEhSrjnJat+HB6xn5AX2WySbpR83MGHmJz6yJ3Z2u9Tma7pBya/
 0r36yBe5moSG2MRuS2SjuK6PpBzT5aD7ZgFjxj3AmKSTrmPamYypOCpyTGT6718dyIcSq0gPuwS
 rHgNXCdlb6XJP4TPc4bE8X7x6b7Qtm6pj03j47zmtEfVft2qBI6pieqNxYuDJQAXmGdQXrMJ095
 JC4o8ylHKzcahmLy15iTOwIJeVWlhQXy60jKlCm5lXKwL1AapzZAc91FzprDBYPHkgD7s/lIC5e
 ke2/0nmfblb513GXec37xh1/AM3AEyzt3aHVvb0pSriGShHCNqy3Xrn/GcGUATRenKcgi+Bt+3P
 3ymewQzNzwp1kVKpA1OFBEYRq3MK7ZodEbfr/Btrd/8BCmxYl6EmWUfkysh4e0mWA5x9OkzuVil
 wkT2A6KICrT0QXQU1l1Cj8LlsxFAPAydt7KZ
X-Received: by 2002:a5d:6f08:0:b0:4b7:7b8d:6b20 with SMTP id
 ffacd0b85a97d-4b77b8d6b73mr5384147f8f.46.1795568653703; 
 Tue, 24 Nov 2026 17:04:13 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm31652282f8f.16.2026.11.24.17.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 17:04:12 -0800 (PST)
Message-ID: <6c7b9cdf-9562-4954-9f66-444745e430bb@gmail.com>
Date: Wed, 25 Nov 2026 01:04:10 +0000
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
Subject: [PATCH v3 2/3] drm/amd/display: unlock secondary tile on Apple 4K/5K
 iMac panels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
iMac18,3, Polaris-based iMac19,1) Retina iMacs expose their internal
panel as a 2x1 tiled display over an eDP root link and a secondary DP
link. At boot, the panel TCON operates in single-pipe mode and holds the
secondary DP link's HPD line low until unlocked via DPCD registers.

Enable native tiled detection and link training for DCE < 12 Apple 4K/5K
Retina iMac panels:
- Latch the root eDP link via DPCD 0x4F1 prior to reading its EDID in
  dm_helpers_read_local_edid() on Apple hardware (DCE < 12) so the
  TCON exposes its full DisplayID tile properties even when Apple and
  OpenCore Legacy Patcher (OCLP) EFI folders are absent.
- Point the secondary DP dc_link to the root eDP dc_link
  (apple_tcon_peer) during EDID quirk matching on DCE < 12 iMac15,1
  (AE01/02), iMac17,1 (AE05/06), iMac18,3 (AE11/12), iMac18,2/19,2
  (AE19/1A), and Polaris-based iMac19,1 (AE25/26), checking
  connector_signal since panel IDs can flip across the two links after
  S3 wake. DCE >= 12 support for Vega-based iMac19,1, iMacPro1,1, and
  iMac20,x is documented as TODO.
- Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
  on the root eDP link when probing the secondary link, allowing the
  secondary link to read its EDID and populate DRM's DisplayID tile
  properties (has_tile, tile_group, and tile_is_single_monitor).
- Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
  0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
- Prevent the secondary tile from entering DP_SET_POWER D3, which causes
  the TCON to drop HPD and stop responding to AUX transactions.
- Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
  and DP_EDP_CONFIGURATION_SET (0x10A) in amdgpu_dm_apple_tcon_unlatch()
  during dm_suspend() so the TCON returns to single-pipe mode for the
  EFI boot screen across reboots.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
 .../dc/link/protocols/link_dp_capability.c    |  4 +++
 .../display/dc/link/protocols/link_dp_phy.c   |  3 ++
 6 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3d2201285888..6275a585593c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1610,6 +1610,23 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(dm_destroy_cached_state);
 
+static void amdgpu_dm_apple_imac_unlatch(struct dc *dc)
+{
+	const u8 zeros[3] = { 0 };
+
+	for (int i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (link->apple_imac_peer) {
+			core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
+			core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
+			core_link_write_dpcd(link, 0x4F1, zeros, 1);
+			core_link_write_dpcd(link->apple_imac_peer, 0x4F1, zeros, 1);
+			break;
+		}
+	}
+}
+
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1677,6 +1694,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 
+	amdgpu_dm_apple_imac_unlatch(dm->dc);
+
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
 	if (dm->dc->caps.ips_support && adev->in_s0ix)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6192c0f6086d..e30450415462 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
+#include <linux/dmi.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_probe_helper.h>
@@ -173,6 +174,30 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
 		edid_caps->panel_patch.force_freesync_min_hz = 60;
 		break;
+	/*
+	 * Workaround for Apple 21.5" 4K and 27" 5K iMacs which expose a 2x1
+	 * tiled internal panel over an eDP root link and a secondary DP link.
+	 * Point the secondary link to the root link to latch/unlatch the TCON
+	 * via DPCD, checking connector_signal as panel IDs can flip after wake.
+	 * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
+	 * iMac18,3 (AE11/12), iMac18,2/19,2 (AE19/1A), iMac19,1 (AE25/26);
+	 * TODO (DCE >= 12): iMac19,1/19,2 Vega, iMacPro1,1 (AE1D/1E), iMac20,x (AE31/32, AE35/36).
+	 */
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE19):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE1A):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
+		if (link->connector_signal == SIGNAL_TYPE_EDP &&
+		    link->ctx->dce_version < DCE_VERSION_12_0 &&
+		    (link->link_index ^ 1) < link->dc->link_count)
+			link->dc->links[link->link_index ^ 1]->apple_imac_peer = link;
+		break;
 	default:
 		return;
 	}
@@ -1299,6 +1324,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	if (link->dc->hwss.prepare_ddc)
 		link->dc->hwss.prepare_ddc(link);
 
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->ctx->dce_version < DCE_VERSION_12_0 &&
+	    dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
+		const char *product = dmi_get_system_info(DMI_PRODUCT_NAME);
+
+		if (product && str_has_prefix(product, "iMac"))
+			dm_helpers_dp_write_dpcd(ctx, link, 0x4F1, &(const uint8_t){1}, 1);
+	}
+
 	dm_helpers_wait_for_edid_ready(link, ddc);
 
 	/* some dongles read edid incorrectly the first time,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8471dcfe24fd..bd3857267331 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2018,6 +2018,7 @@ struct dc_scratch_space {
 	bool skip_implict_edp_power_control;
 	bool forced_psr_active;
 	enum backlight_control_type backlight_control_type;
+	struct dc_link *apple_imac_peer;
 };
 
 struct dc {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 5b257f003f13..02c6e5874c16 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -218,7 +218,7 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 			 * we assume signal is DVI; it could be corrected
 			 * to HDMI after dongle detection
 			 */
-			if (!dm_helpers_is_dp_sink_present(link))
+			if (!link->apple_imac_peer && !dm_helpers_is_dp_sink_present(link))
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		}
 		break;
@@ -1651,6 +1651,11 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		}
 	}
 
+	if (*type == dc_connection_none && link->apple_imac_peer) {
+		core_link_write_dpcd(link->apple_imac_peer, 0x4F1, &(const uint8_t){1}, 1);
+		*type = dc_connection_single;
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index c487c5b87dfd..74954702c5a9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1496,6 +1496,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 				link->dc->vendor_signature.data.raw,
 				sizeof(link->dc->vendor_signature.data.raw));
 	}
+
+	if (link->apple_imac_peer)
+		core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
+				     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
 }
 
 void dpcd_write_cable_id_to_dprx(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 49521ac4b0e8..f051fe6c060c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -50,6 +50,9 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
 	if (link->sync_lt_in_progress)
 		return;
 
+	if (!on && link->apple_imac_peer)
+		return;
+
 	core_link_write_dpcd(link, DP_SET_POWER, &state,
 						 sizeof(state));
 
-- 
2.55.0
