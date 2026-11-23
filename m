Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B1606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dL1dDN+h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF36510E04C;
	Mon, 23 Nov 2026 06:09:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBA210E04C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:09:40 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN513wu3527934; Mon, 23 Nov 2026 06:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9wGn0sXGMij+JlY9Rp9ZZG
 JTs5mGiLcaipFP/YdAXnE=; b=dL1dDN+hGQzWd0xYgIpr4IUjCTBX16CJGlBvsB
 FtbDxz3iWTw7xtAMvJgoFaL4TsCQSpxrc5HedTXZTE5332x/3I0j1wuzccx30G+T
 7W/PRwRZRcnlmOCAyOMdrwYCG2dKwi0GajF/ipaCb7Fdwt0xrgSdCfxf9r6UNhB4
 m6qrSyHhSOAzlkG+jdDR1WOy0dNNmJcwzJne+pYPeTGeCweurHdyJ5YIUqQxknN1
 5vrXXqa9RUK343/9COZZ227Xui0jyDOWoImWZzqpKfyUHBP9mABU0FGs4DFQFuH6
 Xxf/lG5ObXtJ6KARmIf4tF2wP78ajirZWe9lJfyQKmjGrW1A==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j30nnwsnp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 06:09:08 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN695TO4100830; Mon, 23 Nov 2026 06:09:05 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mdsor-hyd.qualcomm.com
 [10.147.243.209])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AN6954A4100816
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 06:09:05 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4770534)
 id 286FEC0E; Mon, 23 Nov 2026 11:39:04 +0530 (+0530)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v19 0/2] Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI
 driver
Date: Mon, 23 Nov 2026 11:39:01 +0530
Message-Id: <20261123-lt9611c-v7-v19-0-1fbe2b7b5211@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH3YA2sC/3XS3WrDIBQH8FcZuV6K5xy/zq72HmMXmuia0TZb0
 oaN0nef6QbVMkEE5fjzj55zM4dpCHPz9HBuprAM8zAe0gL48aHptu7wFtqhTxsNCtTCCNvujqw
 BunYxbYxGe+zBRxWbdOBjCnH4umovr7/r+eTfQ3dchbViO8zHcfq+XreYte4PBp3DaYjWKEUOp
 CEVu+dxnjefJ7frxv1+k6Zm9RebCVhEW2wSfO8QtI8ukqkIfBOskIXASSCJ5Iy2SvdUEUDkRBk
 CRDJCYOGAdG/R1QzIDCxjAKyGl85w5xWb2lsA3gwWVBqYDJYge/Tke93XDMoNLg1KhgsdkpSWD
 KqaITMD7nLIZCiSXpITRmusGSo3VGmoZFgbOTBZE5yvGbf2AnH/L2t/QbCpb9FjBK4ZNjMQSmP
 tMMnGepaWdYR/jMvl8gNf/Zp6YgMAAA==
X-Change-ID: 20260708-lt9611c-v7-ff76b2d1bf5f
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Sunyun Yang <syyang@lontium.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795414144; l=15143;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=Dgh7KRD7NsHZHVMZDp1BzmNnHD6fQjFIYp4PKEzMU4k=;
 b=11tWdFnGvwNY0zKFNs2HisBWu+gxb5+cEK5r305stdvmt4SFSADyGgR9HeuFgOurD1Yldjvyw
 MFyRi4KJG6WCdllAWtu0bAhTu0n+pmKBUebR03HBF9ly3VOr52f3fL9
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNCBTYWx0ZWRfX9IuE7gSIchvk
 OELD/nSvLv88g/bL71vt7FkPG8uOPoM/H/ZxgC1PzQZUOJxK482vtAjVX4o/go/XugQ+/PRlL/7
 6Y4J94OTeWFlaEhvQI25LJhQOuajnwfGbvxqgIiybSFUk9ftLMFL3bvLnYRqfgrtPg57VcSSWDU
 qw6Jn3IuS0WyBEIq3AC/AYKMqVzSy9qqLy0/OYnhuAHCoPBjV7TiRd68HiIGwh34ea39aPCdjU5
 o9xpvge5tBRU7S5HoKGe99CTgT+zBnJO82tALMVSAw9yz2Izdafk2ErYTXBCUTzB0qHzjksqX9f
 mnoPmk4TNAO3QsUEzniIxMA+nM8v83ub2swMakZWR41NlRlkysaJfUTMjFZWwP3ex1RqW4cbod0
 U2r2oyN7sjDyOR+BxWtanzdAda2igW3krXS65Hq6/sP2xm/SpwrMkn8JDqCErs8U0CBnupLGxBD
 LHr8cb+vfTjzhTC2CNw==
X-Proofpoint-ORIG-GUID: u1TJDFYLgr36F2D3ZQb-DuZuxxOHU3P_
X-Authority-Analysis: v=2.4 cv=LITz05W9 c=1 sm=1 tr=0 ts=6b03d884 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8 a=e5mUnYsNAAAA:8
 a=1L3HTKCstn_gZtgeR3sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=RuZk68QooNbwfxovefhk:22 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNCBTYWx0ZWRfX1wFtLF2s1cAF
 3xZdeAEBSxn/QuqYykXlyJ25ZQhK64rbBfNsCsLvFvVa0k8d3ClaLOvOQFYWQR9nptNBg2eaCZq
 rie+GErYYqToHnZ3vU3/FiWbpvlyCTc=
X-Proofpoint-GUID: u1TJDFYLgr36F2D3ZQb-DuZuxxOHU3P_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230024
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces:
  - A device tree binding YAML file describing the hardware
  - A new DRM bridge driver implementing the basic functionality

  LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
  mipi dsi and output hdmi, differences in hardware features:
  - LT9611C: supports 1-port mipi dsi to hdmi 1.4
  - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
  - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0

Changes in v19:
- Remove unused includes: media-bus-format.h, drm_probe_helper.h,
  drm_hdmi_audio_helper.h
- Add LT9611C_MIN_TMDS_RATE define to replace 25000000 magic number
- Move lt9611c_regulator_init() and lt9611c_attach_dsi() to just before
  probe to make clear they are probe-only helpers using devm
- Fold lt9611c_dual_port_enable() into lt9611c_video_setup(): eliminate
  the race window between the two separate mutex acquisitions
- Extract lt9611c_detect_hpd() helper with msleep_ms parameter; simplify
  lt9611c_hpd_work() and lt9611c_bridge_detect() to call it
- Rename lt9611c_read_version() to lt9611c_read_fw_version() for clarity
- Use __free(device_node) in lt9611c_parse_dt() and probe; remove
  err_put_nodes and err_put_dsi1 goto labels
- Fix fw_version < 0 error path: propagate actual errno instead of
  -EOPNOTSUPP; use dev_err_probe()
- Extract lt9611c_check_firmware(): move fw version read and upgrade retry
  into its own function, eliminating the goto-based loop in probe
- Log errno in "failed to read new fw version" warning
- Link to v18: https://lore.kernel.org/all/20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com/

Changes in v18:
- Fix commit message: add hardware feature list and driver capabilities
  description that was missing.
- Rename lt9611c_wren/lt9611c_wrdi to lt9611c_wr_enable/lt9611c_wr_disable
  for clarity.
- Replace heap allocation for CRC with incremental computation over
  fw->data followed by padding bytes, avoiding a full FW_SIZE buffer.
- Use total_size instead of FW_SIZE - 1 in lt9611c_write_crc call.
- Make total_size const.
- Improve HPD delay comment: explain 200 ms is empirically required for
  MCU debounce after interrupt.
- Use ARRAY_SIZE() instead of hardcoded 2 in devm_regulator_bulk_get.
- Move guard(mutex) in lt9611c_video_setup to just before the MCU command
  instead of before timing struct setup.
- Add NULL check in firmware_store and firmware_show to guard against
  access before i2c_set_clientdata() is called in probe.
- Add inline comments for MCU register addresses 0xe085.
- Fix double blank line in lt9611c_read_write_flow.
- Link to v17: https://lore.kernel.org/lkml/20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com/

Changes in v17:
- Add dual DSI port enable: introduce lt9611c_dual_port_enable() which
  sends the MCU command to enable dual DSI input mode on LT9611UXD/EX
  chips. Called from lt9611c_bridge_atomic_enable() after video_setup
  when two DSI hosts are connected. Add bool dual_dsi to struct lt9611c,
  set at parse_dt when secondary DSI port is found.
- Link to v16: https://lore.kernel.org/lkml/20260916-lt9611c-v7-v16-0-c65042fcd245@oss.qualcomm.com/

Changes in v16:
- Fix interrupt clear sequence: write BIT(0) to assert clear then 0x00
  to deassert, instead of writing irq_status & ~BIT(0) which could
  inadvertently toggle other pending interrupt bits
- Fix suspend error recovery path: add msleep(400) before re-enabling
  IRQ after reset GPIO deassert, matching the delay in lt9611c_reset()
  to allow MCU to initialize before interrupts are enabled
- Link to v15: https://lore.kernel.org/all/20260915-lt9611c-v7-v15-0-88f9e9387eab@oss.qualcomm.com/

Changes in v15:
- Fix firmware flash corruption: poll for flash WIP (write-in-progress)
  bit to clear after each lt9611c_sram_to_flash() call in both
  lt9611c_write_data() and lt9611c_write_crc(), preventing SRAM from
  being overwritten while the SPI flash controller is still programming
- Fix missing infoframe flush during modeset: call
  drm_atomic_helper_connector_hdmi_update_infoframes() at the end of
  lt9611c_bridge_atomic_enable() to ensure AVI and other infoframes are
  transmitted after video setup
- Fix data race on fw_version: annotate concurrent read in
  firmware_show() with READ_ONCE and write in firmware_store() with
  WRITE_ONCE
- Link to v14: https://lore.kernel.org/dri-devel/20260913-lt9611c-v7-v14-0-534b43a07662@oss.qualcomm.com/

Changes in v14:
- Fix device node leak: redirect GPIO and regulator init failure paths
  to err_put_nodes label instead of returning directly, ensuring
  dsi0_node and dsi1_node are always released via of_node_put()
- Link to v13: https://lore.kernel.org/dri-devel/20260909-lt9611c-v7-v13-0-aec234483725@oss.qualcomm.com/

Changes in v13:
- Fix double-free of dsi0_node/dsi1_node: remove __free(device_node) which
  is prohibited when mixed with goto; use explicit of_node_put in all exit
  paths
- Fix const and named initializers for i2c_device_id table
- Link to v12: https://lore.kernel.org/lkml/20260903-lt9611c-v7-v12-0-9414d2b3bd6d@oss.qualcomm.com/

Changes in v12:
- Fix audio deadlock in lt9611c_hdmi_audio_prepare: release mcu_lock before
  calling drm_atomic_helper_connector_hdmi_update_audio_infoframe which
  re-enters the driver via lt9611c_hdmi_write_audio_infoframe
- Move lock acquisition from lt9611c_write_infoframe/lt9611c_clear_infoframe
  helpers to individual bridge callbacks; add lockdep_assert_held in helpers
- Remove unused includes: platform_device.h, drm_drv.h, drm_print.h, drm_of.h,
  unaligned.h
- Remove DRM_PANEL_BRIDGE from Kconfig (unused)
- Fix copyright: (c) -> (C) for Qualcomm line
- Remove dsi0_node, dsi1_node, dsi0, dsi1 from struct lt9611c; make them
  local to probe using __free(device_node) and local dsi pointer
- Replace chip_type/max_tmds_rate fields with single cdata pointer in struct
- Fix sysfs NULL dereference race: move i2c_set_clientdata to top of probe
- Fix concurrent crc8_populate_msb: move to module_init
- Fix i2c_device_id: remove vendor prefix (was a workaround for NULL driver_data)
- Replace timing_data byte array with named struct using __be16 fields
- Rename page to npages in lt9611c_write_data
- Move loop-local variables inside loop in lt9611c_write_data
- Add DRM_BRIDGE_ATTACH_NO_CONNECTOR check in bridge_attach
- Use sizeof(timing_data) instead of ARRAY_SIZE
- Move regulator_bulk_enable inside lt9611c_regulator_init
- Various nits: comment spacing, blank lines, variable initialization
- Link to v11: https://lore.kernel.org/dri-devel/20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com/

Changes in v11:
- Fix firmware path: use "Lontium/lt9611c_fw.bin" to match linux-firmware layout
- Link to v10: https://lore.kernel.org/dri-devel/20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com/

Changes in v10:
- Fix lt9611c_block_erase: check return value of read_poll_timeout to avoid writing to un-erased flash
- Fix NULL dereference: check i2c_get_match_data() return value before dereferencing
- Fix irq handler: return IRQ_NONE when BIT(0) is not set
- Fix devm_drm_bridge_add: check and propagate error return
- Fix use-after-free in remove: call disable_irq() before cancel_work_sync()
- Fix bridge/regulator ordering in remove: use drm_bridge_add/drm_bridge_remove explicitly so bridge is unregistered before regulators are disabled
- Promote firmware upgrade success log from dev_dbg to dev_info
- Link to v9: https://lore.kernel.org/lkml/20260804-lt9611c-v7-v9-0-3423a76856d3@oss.qualcomm.com/

Changes in v9:
- Use regmap_bulk_write for 4-byte header write in read_write_flow
- Replace while(1) loop with read_poll_timeout in lt9611c_block_erase; read_flash_reg_status now returns unsigned int
- Fix unchecked regmap_read in lt9611c_upgrade_result; return -EIO on CRC mismatch
- Add struct lt9611c_chip_data with chip_type and max_tmds_rate; fix i2c_device_id table driver_data to use chip data pointers
- Use put_unaligned_be16() to replace manual high/low byte splits in lt9611c_video_setup
- Extract lt9611c_write_infoframe() and lt9611c_clear_infoframe() helpers; consolidate 6 infoframe functions into 2 helpers
- Remove lt9611c_hdmi_audio_startup and its bridge_funcs entry
- Remove hpd_enable callback from bridge_funcs
- Fix scoped_guard(mutex) deadlock in audio_prepare: release lock before calling drm_atomic_helper_connector_hdmi_update_audio_infoframe()
- Fix probe order: lt9611c_reset() before enable_irq()
- Fix remove(): remove disable_irq() (IRQ is devm_request_threaded_irq-managed)
- Fix bridge_suspend() unwind: on regulator_bulk_disable failure, de-assert reset and re-enable IRQ
- Move devm_drm_bridge_add to after both DSI attaches; remove cancel_work_sync from err_remove_bridge label
- Move request_firmware outside mcu_lock in lt9611c_firmware_upgrade; lock only wraps hardware access
- Re-read lt9611c->fw_version after successful firmware_store upgrade
- Rename ocm_lock to mcu_lock throughout
- Use goto err_put_dsi1 to eliminate duplicate DSI cleanup in probe error path
- Fix mcu_lock comment to correctly describe what it protects
- dt-binding: add if:then: block to disallow port@1 when compatible is lontium,lt9611c
- Rename sysfs ABI doc to sysfs-driver-lontium; rename sysfs attribute from lt9611c_firmware to firmware
- Kconfig: add I2C to depends on to satisfy REGMAP_I2C dependency
- Link to v8: https://lore.kernel.org/lkml/20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com/

  Changes in v8:
  - Refactor lt9611c_read_write_flow() to take a struct lt9611c_cmd parameter with an embedded struct lt9611c_cmd_hdr (func,
  type, seq, sep) and optional data payload, eliminating raw byte arrays at call sites
  - Add LT9611C_CMD_HDR_SIZE, LT9611C_EDID_BUF_SIZE constants to replace magic numbers
  - Use container_of_const() in bridge_to_lt9611c_const()
  - Remove obvious /*read only*/ comment
  - Use unsigned long cast instead of uintptr_t for chip type initialization
  - Replace memset + memcpy with memcpy + memset for CRC buffer preparation
  - Add ABI documentation for lt9611c_firmware sysfs attribute
  - Fix Kconfig help text to proper prose within line limits
  - Add disable_irq() before cancel_work_sync() in lt9611c_remove()
  - Add cancel_work_sync() in lt9611c_bridge_suspend()
  - Inline lt9611c_gpio_init() into probe
  - Use of_drm_get_bridge_by_endpoint() instead of drm_of_find_panel_or_bridge() + drm_bridge_get()
  - Return error if LT9611C (single DSI only) is configured with dual DSI in device tree
  - Move HPD status read_write_flow call from IRQ handler to lt9611c_hpd_work workqueue
  - Removed second lt9611_reset call from probe as not needed
  - Add struct lt9611c_rsp symmetric to struct lt9611c_cmd — both embed struct lt9611c_cmd_hdr
  - Link to v7: https://lore.kernel.org/lkml/20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com/

  Changes in v7:
  - Use i2c_get_match_data() for chip type initialization
  - Implement hdmi_write_hdmi_infoframe/hdmi_clear_hdmi_infoframe
  - Use drm_atomic_commit in bridge callbacks
  - Removing redundant lt9611c_reset() call and cleanup in probe error
    path
  - Populate bridge.vendor and bridge.product
  - implement hpd_enable callback
  - fix DT parsing and bridge refcount
  - Removed pre_enable and post_disable callbacks, it was affecting hpd
    as regulator was disabled
  - Changed reset gpio enablement and lt9611c_reset api.
  - Link to v6: https://lore.kernel.org/all/20260508134009.4582-1-syyang@lontium.com/

  Changes in v6:
  - dt-binding:
   1. sorted the compatible list alphabetically.                     [Dmitry]
  - Link to v5: https://lore.kernel.org/lkml/20260507024214.97708-1-syyang@lontium.com/

  Changes in v5:
  - drm/bridge:
   1. use #define FW_FILE "Lontium/lt9611c_fw.bin" to match linux-firmware    [Dmitry]
   2. add atomic state management
  - Link to v4: https://lore.kernel.org/lkml/20260506095100.78998-1-syyang@lontium.com/

  Changes in v4:
  - dt-binding:
   1. fix commit message                                                    [Krzysztof]
  - drm/bridge:
   1. use lt9611c_fw.bin                                                     [Dmitry]
   3. use enum lt9611_chip_type
   4. remove *fw from the lt9611c struct
   5. use read_poll_timeout and -ETIMEDOUT
   6. replace mutex_lock with guard(mutex) in some places
   7. switch to ARRAY_SIZE instead of specifying lengths directly
   8. use dev_err_probe
   9. add clear functions for AVI and audio infoframes
   10. add DRM_BRIDGE_OP_HDMI and remove .hpd_notify
   11. replace "GPL v2" with "GPL"
  - Link to v3: https://lore.kernel.org/lkml/20260420061644.1251070-1-syyang@lontium.com/

  Changes in v3:
  - dt-binding:
   1. lt9611c(ex/uxd) content merged into lontium,lt9611.yaml
  - drm/bridge:
   1. Drop the licence text, only use SPDX header
   2. Sort the headers
   3. Use library functions for crc8
   4. Use paged writes as implemented for LT9611C(EX/UXD)
   5. Use HDMI audio helpers
   6. Replace devm_kzalloc with devm_drm_bridge_alloc
   7. Remove extra kthread
  - Link to v1: https://lore.kernel.org/lkml/20250903123825.1721443-1-syyang@lontium.com/

  Changes in v2:
   1. Forget modify code, operation error, Please disregard this submit.

  Changes in v1:
  - dt-binding:
   1. Submit the first version of the code.
  - drm/bridge:
   1. Submit the first version of the code.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Sunyun Yang (2):
      dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
      drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

 Documentation/ABI/testing/sysfs-lontium-firmware   |   10 +
 .../bindings/display/bridge/lontium,lt9611.yaml    |   18 +-
 drivers/gpu/drm/bridge/Kconfig                     |   17 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1406 ++++++++++++++++++++
 5 files changed, 1450 insertions(+), 2 deletions(-)
---
base-commit: ebdae09876325cb00da572d82ded6c7253c409fa
change-id: 20260708-lt9611c-v7-ff76b2d1bf5f

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

