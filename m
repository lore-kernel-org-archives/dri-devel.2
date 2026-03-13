Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D888106FD85
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B451810EADF;
	Fri, 13 Mar 2026 06:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rlUK1MS8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43DB10E02F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:16:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 12B1060132;
 Fri, 13 Mar 2026 06:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB0F0C19424;
 Fri, 13 Mar 2026 06:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773382594;
 bh=XWEtQoEWbgR9DYbHJTmOros7zGhTGpjR1QrZ2m7Srtk=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=rlUK1MS8QVpSh8MrfJnClqMEwRineO5Ha46eZQzXiePMIAGDXl/EcJwi1Wnqft2dq
 92kei49n1waW5MIlyLucVptsI9uZDnFkND2jnBU67yMHn3BazkUGsFbrCOBH6KvGjQ
 V9O8OUPQwy64FTm50Bp2n7xGPrbd/hM0d8qXX33uxACBQIeTgaoQ1j5qbt0v6Ie9CB
 ces3kLAY2fn+S2Gbej+FrYE44HOBsCOz/QcwZvGKxwPnujsKAXEq1T8b5LLQHU1S9p
 RRJCCFN3d4JB+8x459AjfF+ta1eDElnIz8G2Y4CbqKkridbe6Z3GYGEPoFf52QVJ5B
 vdfFxDQz0uqiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7F106FD87;
 Fri, 13 Mar 2026 06:16:34 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Subject: [PATCH v3 0/2] Add ITE IT6162 MIPI DSI to HDMI bridge driver
Date: Fri, 13 Mar 2026 14:15:59 +0800
Message-Id: <20260313-upstream-6162-v3-0-8497fb7c4406@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+rs2kC/3WMyw6CMBBFf4XM2pI+YkFX/IdxQaeDdMEjba0aw
 r9b2BhNXJ6be84CgbyjAOdiAU/JBTeNGdShAOzb8UbM2cwgudRcSsXuc4ie2oFpoSVT1VFQVds
 OWwvZmT117rn3LtfMvQtx8q89n8S2/islwTgjg6g1ohEdNS5SidNQxgdsqSQ/uuKnX11m3ZKxR
 mNd58OXvq7rG/ItMMnqAAAA
X-Change-ID: 20260223-upstream-6162-3751e78dfcad
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, 
 Hermes Wu <Hermes.Wu@ite.com.tw>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382593; l=4723;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=XWEtQoEWbgR9DYbHJTmOros7zGhTGpjR1QrZ2m7Srtk=;
 b=uP8QKB5VDZeROLOXuvqlvgiBqvNrVKhxnQmw14JAT6W4irAv4LgsFfXwkQNa0RP84ng3kyH61
 8NVCrkAkPw1Cl0UFjDdYYPuZ5azfpImj8RUmpjs4OrvqSV/USEXuHY3
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
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
Reply-To: Hermes.wu@ite.com.tw
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This patch series adds support for the ITE IT6162 MIPI DSI to HDMI
bridge chip. The IT6162 is an I2C-controlled bridge that receives MIPI
DSI input and outputs HDMI signals.

The device supports the following configurations:
  - Single MIPI DSI input: up to 4K @ 30Hz
  - Dual MIPI DSI input (combined): up to 4K @ 60Hz

This series introduces:
  - dt-bindings: Add YAML binding document for ITE IT6162
  - drm/bridge: Add ITE IT6162 MIPI DSI to HDMI bridge driver

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
Changes in v3:
- Documentation/devicetree/bindings/display/bridge/ite,it6162.yaml:  
  * Fix lane-polarities: remove $ref redefinition, allow via video-interfaces.yaml
  * Improve ite,support-hdcp description to clarify FW-based HDCP behavior
  * Remove descriptions repeating schema constraints
  * Remove stray comment in ports required section
  * Fix data-lanes spacing in example: <1 2 3 4>
  * Add missing newline at end of file
  * Add missing change log  that Reviewed-by tag was removed when V1->V2

- drivers/gpu/drm/bridge/ite-it6162.c:
  * Fix OFFSET_VERSION_H register offset from 0x03 to 0x05
  * Add MIPI_PORT_EN_MASK macro combining MIPI_PORT1_EN_MASK and MIPI_PORT0_EN_MASK
  * Rename HDCP enums: NO_HDCP -> HDCP_DISABLE, NO_HDCP_STATE -> HDCP_STATE_IDLE,
    AUTH_DONE -> HDCP_STATE_AUTH_DONE, AUTH_FAIL -> HDCP_STATE_AUTH_FAIL
  * Rename it6162_infoblock_complete() to it6162_wait_command_complete()
  * Rename it6162_infoblock_host_set() to it6162_infoblock_trigger() 
  * Remove it6162_infoblock_mipi_config() and it6162_infoblock_write_msg()
    wrappers, inline into it6162_reset_init() and
    it6162_mipi_set_video_timing() respectively
  * Remove it6162_set_default_config() wrapper, inline into
    it6162_reset_init()  
  * Fix typo: hdcp_encyption -> hdcp_encryption
  * Fix typo: it6162_hdcp_read_infomation -> it6162_hdcp_read_information
  * Remove dev_err_probe() usage outside of probe path
  * Remove verbose success-path dev_info/dev_dbg logging throughout
  * Replace __func__ usage in error messages with descriptive strings
  * Fix double error printing in probe for it6162_init_pdata failure path
  * Fix uninitialized variable warning: initialize cp_status to
    DRM_MODE_CONTENT_PROTECTION_DESIRED at declaration; move
    drm_hdcp_update_content_protection() inside the state-change block
  * Fix audio sample width mapping: case 20 now maps to WORD_LENGTH_20BIT,
    case 24 to WORD_LENGTH_24BIT
  * Remove stray drm_dbg("it6162_bridge_atomic_disable") call
  * Remove drm_dbg() calls from it6162_display_mode_to_settings()
  * Drop unused struct it6162 * parameter from it6162_avi_to_video_setting()
    and it6162_display_mode_to_settings()
  * Fold it6162_set_default_config() body directly into it6162_reset_init(),
    removing the wrapper
  * it6162_infoblock_request_data(): split command complete polling and
    buffer status check into two steps; use wait_event_timeout() for
    data_buf_sts since it is updated asynchronously by the interrupt
    handler; add wait_queue_head_t data_buf_wait to struct it6162 and
    wake_up() in interrupt handler

- Link to v2: https://lore.kernel.org/r/20260309-upstream-6162-v2-0-debdb6c88030@ite.com.tw

Changes in v2:
- dt-bindings:
  * Drop Reviewed-by tag due to below changes
  * Add property "ite,spport-hdcp" to enable HDCP
  * Add property "lane-polarities" and "clock-noncontinuous" for DSI
    setting

- drm/bridge:
  * Drop unused element in struct it6162
  * Remove regmap wrappers
  * Use FIELD_PREP for bitfield operations
  * Update HDCP status with drm_hdcp_update_content_protection()
  * Add AVI, AUDIO, and SPD infoframe control
  * Remove conversion from drm_display_mode to videomode
  * Fix regulator/gpio error handling in it6162_init_pdata() to return proper error codes

- MAINTAINERS
  * squash to driver patch

- Link to v1: https://lore.kernel.org/r/20260223-upstream-6162-v1-0-ebcc66ccb1fe@ite.com.tw

---
Hermes Wu (2):
      dt-bindings: display: bridge: Add ITE IT6162 MIPI DSI to HDMI bridge
      drm/bridge: Add ITE IT6162 MIPI DSI to HDMI bridge driver

 .../bindings/display/bridge/ite,it6162.yaml        |  178 +++
 MAINTAINERS                                        |    7 +
 drivers/gpu/drm/bridge/Kconfig                     |   17 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/ite-it6162.c                | 1631 ++++++++++++++++++++
 5 files changed, 1834 insertions(+)
---
base-commit: 2622649ad6cdbb3e77bfafc8c0fe686090b77f70
change-id: 20260223-upstream-6162-3751e78dfcad

Best regards,
-- 
Hermes Wu <Hermes.wu@ite.com.tw>


