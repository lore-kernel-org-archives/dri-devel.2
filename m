Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717CFC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD8910FA5C;
	Tue, 15 Sep 2026 07:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.b="fpPYsWDs";
	dkim-atps=neutral
X-Greylist: delayed 431 seconds by postgrey-1.36 at gabe;
 Tue, 15 Sep 2026 07:34:18 UTC
Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw
 [219.87.157.213])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A910410FA5B
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:in-reply-to:references:to:cc;
 bh=QrAgWkImRd7ho2JuXHNUm0qpLVkPKY3YCQcWe9zC/hg=;
 b=fpPYsWDsCrOQoow+ZbS9wjl6mhDE+Li0pXhwWMpsQ/9bgotgGmmpmcpK
 1mGug7lqOBbqEUFJEX11KRMlNWDwaXxXnqLMDlmueb7bVO/7amR402lzA
 AkgBFjk8bVKBiYpXQN6tKj0ZOD3bNt4Lk1hL8EengHuC1ncfxkbhTz1qR
 EnycwyistuU0muOC9D3KZKh6j5dpo+xiisVubbJbQkHy4B3paPtYK/MkZ
 YoWeXvv82q9+nVNzsI5yiLQHfItZiC01r+xYWX/k8/wXOGqHbRUqNy4pO
 wwHfupXsph5TPf43DNeqsPvZliZfSsgoksZjEFMscku7gi0G4SQsN5MPw Q==;
X-CSE-ConnectionGUID: b7M7O5qkRwGJPew7eezEgg==
X-CSE-MsgGUID: Ubrx7M2EQ3SreZavDRfeLg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 15 Sep 2026 15:27:04 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw
 [192.168.65.58]) by mse.ite.com.tw with ESMTP id 68F7QxjR029913;
 Tue, 15 Sep 2026 15:26:59 +0800 (+08)
 (envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.40) by CSBMAIL1.internal.ite.com.tw
 (192.168.65.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 15 Sep
 2026 15:26:59 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Subject: [PATCH v10 0/2] Add ITE IT61620 MIPI DSI to HDMI bridge driver
Date: Tue, 15 Sep 2026 15:26:28 +0800
Message-ID: <20260915-it61620-0714-v10-0-738e2a662c06@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACTzqGoC/3XQz04DIRAG8FdpOLvNzAADePI9jAeWP5aDrdndr
 Jqm7y7bRFshJnP5Jvl9TDiLOU0lzeJxdxZTWstcTscaEB52Ihz88TUNJdaFICANBtVQFkYmGK7
 Bj6pOSDmTE5W8TymXz2vf80vNhzIvp+nrWr/itv2naMUBBmkYkVWE0dmnsqR9OL3tlw+xNa100
 5Zso6lqbTlrJ1XUudfyVyOAa7TcdGRLEcgqhZ1WN03IjVZVu0g5eWOV8anT+k4TNVpX7fPIyjg
 fZfCd5h/NgBIazVUb8NmzdiRH3Wlz0xJlo8325+yRYwDJkTtt7zS1b9uqIRkggyFr7zrt7rVpt
 Nu0JCdtGF20fy+/XC7fH9Pn2ZoCAAA=
X-Change-ID: 20250714-it61620-0714-ab4ab4ceff29
In-Reply-To: <20260327-it61620-0714-v9-0-032938cb9d85@ite.com.tw>
References: <20260327-it61620-0714-v9-0-032938cb9d85@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Hermes Wu <hermes.Wu@ite.com.tw>, Kenneth
 Hung <kenneth.Hung@ite.com.tw>, Pet Weng <pet.weng@ite.com.tw>, Jau-chih
 Tseng <jau-chih.tseng@ite.com.tw>, Pin-yen Lin <treapking@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789457257; l=9375;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=s3NdJpBL2H3T34Cjcf3/iU7S/YWt1F7gDytj+EPvTfY=;
 b=YRRrJmXe09U6sh/E5peJnV366UAjl6jFEM2YrYIwVXwbs5xGI24C8In0qoEgwMUXRvtd1Z0Pl
 fLjkxVFHOLWAdV3H2lnvlnX67p91Ycs4aN5mxcM5NTHZ+53tcyH2i9j
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-Originating-IP: [192.168.72.40]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: 732AF0DB9A6B5B4AC802CD8F91F77CA42CF57B4039588DBC229065194A3180D02002:8
X-MAIL: mse.ite.com.tw 68F7QxjR029913
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

Hotplug may be provided by the next bridge (typically hdmi-connector
with hpd-gpios). If that bridge already implements OP_HPD / OP_DETECT,
this driver leaves those ops to it and only receives hpd_notify().
Otherwise it owns connector status from the chip HPD pin. That pin also
carries HDCP Ri pulses, so chip HPD IRQs are debounced before
drm_bridge_hpd_notify().

Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
---
Changes in v10:
- dt-bindings: no change since v9; keep Reviewed-by from Krzysztof
- drm/bridge: dropped Reviewed-by from Dmitry due to functional changes
  1. HDMI IRQ: test int_status1 bits, not the TX_REG_INT1 address
  2. Use pm_runtime_get_if_in_use() in the threaded IRQ to avoid
     deadlocking with disable_irq() in runtime suspend
  3. Update HDCP content-protection from work that takes
     connection_mutex (do not call the helper from IRQ / hdcp_work)
  4. Serialize DDC abort on HDCP auth fail with ddc_lock
  5. Clamp KSV FIFO reads; treat an empty FIFO as an error
  6. Include the 8 M0 bytes in the HDCP SHA-1 input length
  7. Write AVI infoframe after clearing the AVI packet, not VSIF
  8. Write A0 pattern-generator registers through tx_regmap
  9. Parse MIPI endpoint data-lanes / lane-polarities; attach DSI with
     the parsed lane count instead of a hard-coded 4
 10. Implement OP_DETECT / OP_HPD when the next bridge does not:
     detect() and edid_read() resume the chip; hpd_enable() holds
     runtime PM; HPD IRQs are debounced; power-on W1Cs latched HPD_CHG
     before enable_irq()
 11. hpd_notify() does not touch runtime PM when this driver owns OP_HPD
 12. Use devm_pm_runtime_enable(); cancel HDCP/HPD work on remove and
     let devres unwind DSI, bridge and PM (no early mutex_destroy)
 13. Switch to drm_atomic_commit / atomic_create_state
 14. Use abs_diff() for the MIPI htotal delay; drop redundant
     pm_runtime_mark_last_busy(); log pre_enable resume failures
- Link to v9: https://lore.kernel.org/r/20260327-it61620-0714-v9-0-032938cb9d85@ite.com.tw

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

 Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml |  152 ++++++++
 MAINTAINERS                                                       |    7 +
 drivers/gpu/drm/bridge/Kconfig                                    |   18 +
 drivers/gpu/drm/bridge/Makefile                                   |    1 +
 drivers/gpu/drm/bridge/ite-it61620.c                              | 2763 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 2941 insertions(+)
---
base-commit: 7d66a68c6f216b78ea22ce8a4c7f8d456c76e8ba
change-id: 20250714-it61620-0714-ab4ab4ceff29

Best regards,
-- 
Pet Weng <pet.weng@ite.com.tw>

