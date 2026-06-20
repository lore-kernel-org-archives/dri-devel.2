Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0DCDB46F
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 16:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D4B10E22C;
	Sat, 20 Jun 2026 16:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hhv4RI6D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B7310E224;
 Sat, 20 Jun 2026 16:06:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 60665601E3;
 Sat, 20 Jun 2026 16:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 124D1C2BCB7;
 Sat, 20 Jun 2026 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781971579;
 bh=oQDp/iVxP2L33GYJjkOAVTDBvPk5XRvIgJQynX8l43I=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Hhv4RI6DwA4Qke0XKpYtCpU6Zmfhmet8osY0GqhqJRMcyvoPwHUBKDapvk0rP9kUm
 RZXBmqPCUc34q+hLVY6HS5nG9kpaQ5qFAA56e18QyJNW9ADSYwMCeUsXTlb7za+KnJ
 Ny3aynLdZV5yt757srZudBFgXRw/hloIog4fNy7YP2kCGPSZOKyWecV9dW4yja8rkd
 5HLOPzIjv4htaBdWTWGV85NAfdAxAigwZXVUWFT/2IJTrX4NcBmAw2Zovw9VAj4n3e
 SH5O8gUHJ8jqXTwmUXLJIngPcWpYK0jq7fWCem2BvDXZh4bgzlv6sJt/3XKwHIof02
 8/9IyLYN3Yirg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EB840CD98E4;
 Sat, 20 Jun 2026 16:06:18 +0000 (UTC)
From: Stephen via B4 Relay <devnull+stevester.codes.gmail.com@kernel.org>
Date: Sat, 20 Jun 2026 10:06:19 -0600
Subject: [PATCH RFC 1/3] drm/amd/display: quirk malformed CH7218 PCON topology
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Stephen <stevester.codes@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781971578; l=4344;
 i=stevester.codes@gmail.com; s=ch7218-rfc; h=from:subject:message-id;
 bh=jeGNZJ9+o/AHn9lk6MUcdhMGJQEt2lPQ9MdS1Ws/0rk=;
 b=ashBtRxYlhnhRo1J1cKCvKoDCNUKcm/GSSLJzVdHb0bTs2DEyf8TDex8vsyJXd5N4KMWxP1OL
 IMbTk2tOT6JCeix/HJpj0hJLXBKtOSpBd8QJr+OkHiR3Cf1Qn1yfzvD
X-Developer-Key: i=stevester.codes@gmail.com; a=ed25519;
 pk=3Y74rGwtdwPNG9fzfw+7DSf/KWLeW8BsYVkyhPcx5pY=
X-Endpoint-Received: by B4 Relay for stevester.codes@gmail.com/ch7218-rfc
 with auth_id=834
X-Original-From: Stephen <stevester.codes@gmail.com>
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
Reply-To: stevester.codes@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Stephen <stevester.codes@gmail.com>

Some Chrontel CH7218 DP-to-HDMI 2.1 adapters expose a branch
device ID of 0x2b02f0 and branch name CH7218, but report no
downstream port at DPCD 0x005 and report the detailed downstream
port at 0x080 as DP.

This leaves AMDGPU treating the link as non-HDMI and bypasses the
PCON capability path.

When this malformed runtime state is detected, classify the link as a
DP-HDMI converter and restore the documented converter ceilings needed
by the existing PCON path: 12 bpc, 48 Gbps FRL, and YCbCr passthrough
capability. This does not program the PCON or synthesize source-control
FRL state.

Signed-off-by: Stephen <stevester.codes@gmail.com>
---
 .../display/dc/link/protocols/link_dp_capability.c | 47 ++++++++++++++++++++--
 .../drm/amd/display/include/ddc_service_types.h    |  1 +
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 47abb4066709..c2b48abfe7e6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1158,6 +1158,31 @@ static void read_and_intersect_post_frl_lt_status(
 	}
 }
 
+static bool is_ch7218_pcon(const struct dc_link *link)
+{
+	return link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_2B02F0 &&
+		!memcmp(link->dpcd_caps.branch_dev_name, "CH7218",
+			sizeof(link->dpcd_caps.branch_dev_name));
+}
+
+static void apply_ch7218_pcon_caps_quirk(struct dc_link *link)
+{
+	if (!link->dc->caps.dp_hdmi21_pcon_support)
+		return;
+
+	/*
+	 * Some CH7218 firmware reports no downstream port, or reports the
+	 * detailed downstream port as DP, while the device identity and EDID
+	 * describe a DP-to-HDMI 2.1 PCON. Restore only the documented converter
+	 * capability ceilings here; do not touch the PCON link state.
+	 */
+	link->dpcd_caps.dongle_caps.dp_hdmi_max_bpc = 12;
+	link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps = 48000000;
+	link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr422_pass_through = true;
+	link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr420_pass_through = true;
+	link->dpcd_caps.dongle_caps.extendedCapValid = true;
+}
+
 static void get_active_converter_info(
 	uint8_t data, struct dc_link *link)
 {
@@ -1166,10 +1191,19 @@ static void get_active_converter_info(
 
 	/* decode converter info*/
 	if (!ds_port.fields.PORT_PRESENT) {
-		link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
+		if (is_ch7218_pcon(link)) {
+			link->dpcd_caps.is_branch_dev = true;
+			link->dpcd_caps.dongle_type =
+				DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+			link->dpcd_caps.dongle_caps.dongle_type =
+				link->dpcd_caps.dongle_type;
+			apply_ch7218_pcon_caps_quirk(link);
+		} else {
+			link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
+			link->dpcd_caps.is_branch_dev = false;
+		}
 		set_dongle_type(link->ddc,
 				link->dpcd_caps.dongle_type);
-		link->dpcd_caps.is_branch_dev = false;
 		return;
 	}
 
@@ -1200,7 +1234,14 @@ static void get_active_converter_info(
 			switch (port_caps->bits.DWN_STRM_PORTX_TYPE) {
 			/*Handle DP case as DONGLE_NONE*/
 			case DOWN_STREAM_DETAILED_DP:
-				link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
+				link->dpcd_caps.dongle_type = is_ch7218_pcon(link) ?
+					DISPLAY_DONGLE_DP_HDMI_CONVERTER :
+					DISPLAY_DONGLE_NONE;
+				link->dpcd_caps.dongle_caps.dongle_type =
+					link->dpcd_caps.dongle_type;
+				if (link->dpcd_caps.dongle_type ==
+						DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+					apply_ch7218_pcon_caps_quirk(link);
 				break;
 			case DOWN_STREAM_DETAILED_VGA:
 				link->dpcd_caps.dongle_type =
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 53210e3aa0e0..4164f8a5ae56 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -37,6 +37,7 @@
 #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
 #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
 #define DP_BRANCH_DEVICE_ID_001FF2 0x001FF2
+#define DP_BRANCH_DEVICE_ID_2B02F0 0x2B02F0
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 

-- 
2.54.0


