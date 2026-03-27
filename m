Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078B710BA435
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBF610ECAB;
	Fri, 27 Mar 2026 08:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.b="cP20A1Lu";
	dkim-atps=neutral
Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw
 [219.87.157.213])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA2310EC68
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=J/6jSXJFKjZg6gI1bN4x+Wi/J2J4hL6BRqJ9VRuuXUc=;
 b=cP20A1Luap44VcNbJnRQFpabsPbzf5H5Sfk7U9Azzh9dwYhnIV8S7Nx3
 00yRBCISUoqAqKGvq9IYkwsu2/uTo4KGlc4uv4po2R6E+GhVsEitthe3a
 g0UqNy59CgRORp3OeWFx8uVNu6o74bTIc046nerdiylsfB8sc8RcgnN+y
 ELhI2QnS2oPK45XcYhrxqEAghhM6wwdLSBnmiiOC/3pjfCxHg4wBVS7v2
 71/PfQRSMNuOlBTUFl9GADRQk9rcVaIDefpjEyj7DbF1MxMd95nv0e/qT
 F7B3y1bkHIZHH2Ix7qoqvhzgltg6tgt5badd5FXhCbQ2Om6+F99iw01qO Q==;
X-CSE-ConnectionGUID: s15ahRV3TIiqxjBXlqKxpQ==
X-CSE-MsgGUID: WEJ1k5v9RTKcryjjmhublw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 27 Mar 2026 15:55:22 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL2.internal.ite.com.tw
 [192.168.65.41]) by mse.ite.com.tw with ESMTP id 62R81PAO009254;
 Fri, 27 Mar 2026 16:01:25 +0800 (+08)
 (envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.40) by CSBMAIL2.internal.ite.com.tw
 (192.168.65.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 27 Mar
 2026 16:01:25 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Subject: [PATCH v9 0/2] Add ITE IT61620 MIPI DSI to HDMI bridge driver
Date: Fri, 27 Mar 2026 16:02:51 +0800
Message-ID: <20260327-it61620-0714-v9-0-032938cb9d85@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKs5xmkC/3XQwUrEMBAG4FdZcrbLzCSZJJ58D/GQNombg1tpS
 1WWvrtpQbumCHP5B75/YG5ijEOOo3g83cQQ5zzm/lqCeziJ7uKvr7HJoWRBQBoMqiZPjEzQbMG
 3qkwXUyInCnkfYsqfW93zS8mXPE798LW1z7hu/ymasYFGGkZkFaB19ilP8dz1b+fpQ6xNM+3ak
 q00Fa0tJ+2kCjodtfzVCOAqLVcd2FIAskrhQatdE3KlVdEuUIreWGV8PGh9p4kqrYv2qWVlnA+
 y8wfNP5oBJVSaizbgk2ftSLb6oM2uJcpKm/Xn7JFDB5IDH7S901TftkVDNEAGu6S9+6OXZfkGL
 Uhf6lsCAAA=
X-Change-ID: 20250714-it61620-0714-ab4ab4ceff29
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Hermes Wu <hermes.Wu@ite.com.tw>, Kenneth
 Hung <kenneth.Hung@ite.com.tw>, Pet Weng <pet.weng@ite.com.tw>, Jau-chih
 Tseng <jau-chih.tseng@ite.com.tw>, Pin-yen Lin <treapking@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774598579; l=7183;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=zG68uUA4koKHgrul6EbZod76re4ddBftj58JyadzkT4=;
 b=pzIQ356oELSZptuuhQmo8K3CVY2uxR6OZGMAOg5UzaFThGbxp1UCPWyg7f5Eqsb6snb+zt/oC
 p0SgjVI/SnBDS2CihcVcZllhMsMLo5qiwes2IQogUEd97dmciNVM9mo
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-Originating-IP: [192.168.72.40]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL2.internal.ite.com.tw (192.168.65.41)
X-TM-SNTS-SMTP: 31B1BAA8014DF8715D1DD96C52D3BD9F8BC5F8F20CCEF521AAFE74AD6C7D951C2002:8
X-MAIL: mse.ite.com.tw 62R81PAO009254
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

This patch series adds support for the ITE IT61620 MIPI DSI to HDMI 
bridge chip.

The IT61620 is an I2C-controlled bridge that receives MIPI DSI input 
and outputs HDMI signals. A single-port MIPI DSI input is converted to 
an HDMI 1.4 output. This series introduces:
- A device tree binding YAML file describing the hardware
- A new DRM bridge driver implementing the basic functionality

Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
---
Changes in v9:
- Fix commit message wrapping to follow kernel style
- Run checkpatch.pl and address reported issues
- Restore Reviewed-by from Krzysztof as the change is non-functional
- Link to v8: https://lore.kernel.org/r/20260320-it61620-0714-v8-0-0e70271cf5a9@ite.com.tw

Changes in v8:
- dt-binding:
 1. Clarify the hardware differences between IT6162 and IT61620 in the
    description (IT61620 is single-port and lacks an internal MCU). 	[Krzysztof]
 2. Dropped Reviewed-by from Krzysztof due to description changes.
- Call drm_atomic_helper_connector_hdmi_clear_audio_infoframe() in audio
  shutdown path								[Dmitry]
- Link to v7: https://lore.kernel.org/r/20260313-it61620-0714-v7-0-36a16dc036d6@ite.com.tw

Changes in v7:
- The dt-bindings were previously reviewed by Krzysztof Kozlowski.
- drm/bridge:								[Dmitry]
 1. drop redundant register access wrappers and use regmap APIs directly
 2. use drm_dbg_kms() instead of drm_dbg() when printing display timing information
 3. use drm_display_mode directly for video timing
 4. add helper for writing 16-bit timing registers
 5. simplify HDMI interrupt handling
 6. add mono audio support
 7. program audio parameters directly
 8. inline audio infoframe disable logic
- MAINTAINERS: squash to driver patch					[Dmitry]
- Link to v6: https://lore.kernel.org/r/20260130-it61620-0714-v6-0-70afa65923b5@ite.com.tw

Changes in v6:
- In patch 1								[Luca] 
 1. Fix a typo in the commit message.
 2. Remove redundant assignment of bridge.funcs, which is already set by 
    devm_drm_bridge_alloc().
- Link to v5: https://lore.kernel.org/r/20251222-it61620-0714-v5-0-afb6479ad3ca@ite.com.tw

Changes in v5:
- Fix dt_binding_check errors by adding missing unevaluatedProperties constraints
  for port and endpoint nodes in the device tree binding.		[Rob]
- Link to v4: https://lore.kernel.org/r/20251216-it61620-0714-v4-0-9d2fea7847ae@ite.com.tw

Changes in v4:
- In patch 1								[Krzysztof]
 1. Remove redundant "description" fields from interrupts and regulators
 2. Drop pinctrl-names and pinctrl-0; driver does not require them
 3. Remove port/endpoint properties already covered by video interfaces schema
 4. Fix example indentation to 4 spaces for readability
- In patch 2								[Jani]
 1. Use connector->display_info from DRM helper instead of parsing EDID manually
- In patch 2								[Dmitry]
 1. Remove redundant powered check in reg access
 2. Use TMDS character rate instead of pixel clock for N/CTS
 3. Use consistent lowercase naming for tmds.
 4. Use test_bit() instead of custom bit-test helper
 5. Use tmds_char_rate_valid instead of custom mode_valid
 6. Use custom EDID read instead of DDC bus for segment handling
 7. Drop redundant atomic feature check
 8. Pass flags directly to drm_bridge_attach()
 9. Check DRM_BRIDGE_ATTACH_NO_CONNECTOR flag before drm_bridge_attach()
 10. Short-circuit HPD update if connector status unchanged
 11. Remove unnecessary NULL check for connector state
 12. Rename cached_edid to edid since it's no longer cached
 13. Remove redundant sample rate checks; rely on hdmi-codec validation
 14. Remove unsupported 18-bit audio sample size; rely on hdmi-codec
 15. Remove unnecessary fmt switch; rely on hdmi-codec defaults
 16. Check and propagate errors from it61620_audio_update_hw_params instead of
     ignoring them
- In patch 3								[Krzysztof]
 1. Remove unnecessary T: field pointing to git; subsystem already defines it
- Link to v3: https://lore.kernel.org/r/20251009-it61620-0714-v3-0-5d682d028441@ite.com.tw

Changes in v3:
- Wrapped description lines to comply with 80-character line length limit
  in patch 1.								[Rob]
- Renamed node from "it61620@58" to "bridge@58" in patch 1.		[Rob]
- Add port@2 for I2S audio input in patch 1.				[Dmitry]
- Updated the Kconfig dependency from CRYPTO and CRYPTO_HASH to 
  CRYPTO_LIB_SHA1 in patch 2.						[Eric]
- In patch 2								[Dmitry]
 1. Audio and InfoFrame
   - Rename audfmt to i2s_input_format for clarity.
   - Remove unused infoframe[HDMI_INFOFRAME_SIZE(AUDIO)].
 2. Platform data and structure
   - Drop platform data usage; migrate members into struct it61620
 3. Code organization
   - Reorder functions to avoid the need for forward declarations.
   - Add static inline to small helper functions
     (e.g. bridge_to_it61620()).
 4. HDCP handling
   - Make HDCP enable/disable conditional on conn_state->content_protection.
   - Report authentication result using drm_hdcp_update_content_protection().
 5. Error handling
   - Replace manual error path with dev_err_probe().
 6. Power management
   - Inline suspend/resume callbacks.
   - Use DEFINE_RUNTIME_DEV_PM_OPS() instead of explicit struct definition.
 7. Bridge callbacks
   - Drop empty bridge_detach().
   - Inline it61620_bridge_mode_valid().
 8. EDID handling
   - Remove unnecessary cached EDID duplication.
 9. Mode set and pixel clock
   - Move mode handling to atomic_enable().
   - Keep only pixelclock for future N/CTS audio calculations.
 10. Logging
    - Replace noisy drm_err() calls with drm_dbg().
 11. InfoFrame support
    - Add support for SPD and Vendor InfoFrames.
- Link to v2: https://lore.kernel.org/r/20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw

Changes in v2:
- Call the sha1() library function instead of using the crypto_shash
  "sha1" in patch 2.
- Rewrite it61620_hdmi_ddc_wait() with readx_poll_timeout() in patch 2.	[Pin-yen]
- Rewrite it61620_hdmi_hdcp_wait_ksv_list() with readx_poll_timeout() in
  patch 2.
- Replace interrupts-extended with interrupts in patch 1.		[Rob]
- Replace dsi-lanes with the standard property data-lanes from the graph
  binding.								[Rob]
- Replace "#/$defs/port-base" with "#/properties/port" in patch 1.	[Rob]
- Drop unused labels and "hdmi" for the node name.			[Rob]
- Drop status in patch 1.						[Rob]
- Link to v1: https://lore.kernel.org/r/20250714-it61620-0714-v1-0-3761164d0b98@ite.com.tw

---
Pet Weng (2):
      dt-bindings: display: Add ITE IT61620 MIPI DSI to HDMI bridge
      drm/bridge: Add ITE IT61620 MIPI DSI to HDMI bridge driver

 .../bindings/display/bridge/ite,it61620.yaml       |  152 ++
 MAINTAINERS                                        |    7 +
 drivers/gpu/drm/bridge/Kconfig                     |   18 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/ite-it61620.c               | 2592 ++++++++++++++++++++
 5 files changed, 2770 insertions(+)
---
base-commit: a42c0d615ad29e3e11b1c91f677bcabcb5dc8e13
change-id: 20250714-it61620-0714-ab4ab4ceff29

Best regards,
-- 
Pet Weng <pet.weng@ite.com.tw>

