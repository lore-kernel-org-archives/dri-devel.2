Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3B3CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 16:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0330910E220;
	Sat, 20 Jun 2026 16:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h4cxiC1F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A902010E220;
 Sat, 20 Jun 2026 16:06:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 764D7601E4;
 Sat, 20 Jun 2026 16:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23571C2BCB0;
 Sat, 20 Jun 2026 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781971579;
 bh=Bx59nTsOfQo0ZUj0MupvH98dYQC18dvp3P+S04h02Zk=;
 h=From:Date:Subject:To:Cc:References:In-Reply-To:Reply-To:From;
 b=h4cxiC1FPtkLPq1PO9s1IwkgCKRXo4ivE2+HgzNs7L/msyWk3R6c6/ZVgpuMQ5HdO
 C0QsarlmwmyHcmGaRXWHJ9WPNyAXOzryYMUcdW/o0tmA6ujb68SyN/UWNsVaWBDThe
 st8+QNdQWVph0PfDVpdeZJ1HYdCJNudrfvDrrk/3Iij4Junv5CX5xUT09LvflO6LQb
 dwX/nUx7mT0juYwVAggi+qy4MbmNPFbnJqOv0jF08UwziZ17QB/ZUm0z1tjwS3abRl
 Wu1END37f46BEPBa3c6FZX2hwR3/E8jZjqNXwuVcAWE+XxOGQqcNKktNM0gJ0msvpX
 dd1sqmRl2IJ+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B0CDB46B;
 Sat, 20 Jun 2026 16:06:19 +0000 (UTC)
From: Stephen via B4 Relay <devnull+stevester.codes.gmail.com@kernel.org>
Date: Sat, 20 Jun 2026 10:06:20 -0600
Subject: [PATCH RFC 2/3] drm/amd/display: quirk CH7218 DP DSC support bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-ch7218-rfc-v1-b4-v1-2-3412debf44b6@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Stephen <stevester.codes@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
References: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
In-Reply-To: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781971578; l=2578;
 i=stevester.codes@gmail.com; s=ch7218-rfc; h=from:subject:message-id;
 bh=Wc9ztP52gNTYdJ4wsmOM8HQQjA0R6jvwruxjJM/wHLQ=;
 b=3Jkb/AMcaFdC1OEyapnfvht+r4QwOtzefWW3+l4LHe978HIZxHkJjlptDjog0QkBQ66v1m8ae
 S9EbYCQLM6aCqJj2w9CKI9TLeBspAEP9/7ToLIIYdGfX1A2/cYXK01O
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

Some CH7218 firmware clears DP_DSC_SUPPORT at DPCD 0x060 while
returning a populated DSC decoder capability block. Without the support
bit, AMDGPU rejects DSC on the DP side and cannot validate high-bandwidth
RGB modes that require DSC over the DP link.

For the malformed CH7218 PCON only, set the DSC support bit after
verifying that the DSC capability block contains non-zero decoder data.
Do not infer DSC support for other devices and do not synthesize DSC
passthrough support.

Signed-off-by: Stephen <stevester.codes@gmail.com>
---
 .../display/dc/link/protocols/link_dp_capability.c   | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index c2b48abfe7e6..ad4fb94281a8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1183,6 +1183,25 @@ static void apply_ch7218_pcon_caps_quirk(struct dc_link *link)
 	link->dpcd_caps.dongle_caps.extendedCapValid = true;
 }
 
+static void apply_ch7218_dsc_caps_quirk(struct dc_link *link)
+{
+	struct dpcd_dsc_capabilities *dsc_caps = &link->dpcd_caps.dsc_caps;
+
+	if (!is_ch7218_pcon(link) ||
+	    dsc_caps->dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
+	    (!dsc_caps->dsc_basic_caps.raw[DP_DSC_REV - DP_DSC_SUPPORT] &&
+	     !dsc_caps->dsc_basic_caps.raw[DP_DSC_SLICE_CAP_1 - DP_DSC_SUPPORT] &&
+	     !dsc_caps->dsc_basic_caps.raw[DP_DSC_MAX_BITS_PER_PIXEL_LOW - DP_DSC_SUPPORT]))
+		return;
+
+	/*
+	 * Some CH7218 firmware clears DP_DSC_SUPPORT while returning a populated
+	 * DSC decoder capability block. Do not infer DSC support for other
+	 * devices and do not enable DSC passthrough here.
+	 */
+	dsc_caps->dsc_basic_caps.fields.dsc_support.DSC_SUPPORT = true;
+}
+
 static void get_active_converter_info(
 	uint8_t data, struct dc_link *link)
 {
@@ -2068,6 +2087,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 				link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				sizeof(link->dpcd_caps.dsc_caps.dsc_basic_caps.raw));
 		if (status == DC_OK) {
+			apply_ch7218_dsc_caps_quirk(link);
 			is_fec_supported = link->dpcd_caps.fec_cap.bits.FEC_CAPABLE;
 			is_dsc_basic_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT;
 			is_dsc_passthrough_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT;

-- 
2.54.0


