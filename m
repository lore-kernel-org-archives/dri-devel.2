Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A105C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C4B10E0AD;
	Tue,  4 Aug 2026 12:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZkaPIum";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHQ0rYZO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A24C10E0AD
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:40:33 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CXP8J3617664
 for <dri-devel@lists.freedesktop.org>; Tue, 4 Aug 2026 12:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QgwILuoTnuZi4CibSzN4AE
 YxtmfoZ0O9WdoWHDZh/bw=; b=bZkaPIumObOSDicLnZy6lX/UopjP9h2tNh/gb5
 f5ydcTbwbvVp/F0ky0F6PpZaPuafbgRkT0Jcabi3/rGAgiQEZ1F5T+ENT32KL1WG
 EZrHnZbBqrZUfH4wxcHp8f8QsI0mc8u4OLmHWoXuDIPZ1pXMH415aFAfhQAjSXJv
 H1eDosmeLWA/CptvJDRxRqtasWeO3hbq9bkMiL13Fc80UphB5i9TFdQITcdX+rPF
 /qa8BEVnKrVPygqOfWi60lx+v1pLbrKzng8mMPgbJ0dF8VGaySFg7Rbf3QORX+r9
 fvgSpfTO86HyCrhwryTJ/N5yXv9d2382j76MW8IRLHBhl1uQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu7272c73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 12:40:31 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4a43d32fa9fso6168827b6e.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785847231; x=1786452031;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QgwILuoTnuZi4CibSzN4AEYxtmfoZ0O9WdoWHDZh/bw=;
 b=XHQ0rYZOJKlyBVqL20Xcd3q4oTzm6z1ThsXQELPwXrxqBAAPQQE0ZVJdY0cMk9sayG
 XAjwSCiUCOmX3laqmbt4nK9KeXPE+Jv5NRC7Ej0oCLL9qbXZ0EmUnaA/e9UaRgzsXqOU
 t1UTh0ZwehQAatxCp5TTsDcdhnmVlMxTOvkZTCH8A5rrtAmYkVh8BqrwODPveYVZx5+6
 HZL7aCZ2KXehjPcrhH3vVG+dInC9vAU7zgj3IwOr4B/bChulmvtNhcWIr+/kV0GXTHXj
 sBQi0wuHS+uA1W3lFkU2y7Eoz9MO+z2A4SRjsJY58Kw0ZDvGkjgceh+HJwI4A7vGFx7f
 HklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785847231; x=1786452031;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QgwILuoTnuZi4CibSzN4AEYxtmfoZ0O9WdoWHDZh/bw=;
 b=had9VqYFd1J4A58lp+uVW3mkuGDRKYbo82AYp9pI3HkiLLCNBH3yNsJYOLVQmjkLFh
 CwZ932MOxLllaIOTIjmm6cqmlhQkpo6Oh4jFGB7XGx06xzeSgInTxx+04K10SnXYh50I
 rKa3lsfLoWrHHqeFrQb6nXe6tghr7W+LrGPUg4EcFRQBdcEO0bceQpWmODFSDZM7jI1D
 lic0vc+sdWbvhxrcG3Wvi1/Ydu5Rr8JPS6WtUH/Sa8qVt2TbYor2y0Bp1FSPT48nnAIm
 eIX2FHbnQDlLTfP2gMoJrr2q3AlWrX+YdVBTi0SaoeH7ayX24aesmt1jST7to1aape9x
 MQUg==
X-Gm-Message-State: AOJu0Ywe+8MKxDFOhnyWgfaDeDWjRV2rkdRmXMejp9R5ORbY7/RrWBj2
 JTy1dVrLLPvGZ3z/wPYu2KT73EIyjQ8TPl7IWkk79+cHYH5ENWFHfCK8ZyvWHNrHiSHOqelVtQn
 jtUDjmiEvLrP+gYu2pb7KngOODgzgmEEqJGQhR2TghUgstrf7tB5oncB9XcO/pipzcq5/iX4=
X-Gm-Gg: AR+sD12zFXGJ79GK47xirVFlNpMsLiWf7dXz/0emYfO8IWe+Jdd8lu9zwjffSuITdt1
 qGRK5qQkmfSc3E1M9xylBDmZNdHl2hxWrD2SEa7sH0iH4Y3q/FT1R0mZAgqCM4qSyUTIWo0hp+I
 7Pt671C1mxZCCQcwNdZaEQ9CJxLBSU381RBoUDU0yV4C08IYZORv7L4Oekqm+7v14UruucZAZ5u
 IGghZ5Fqekji0BgpqQz3Uch0DPrSpm/u2grZJXtjSdTZoyVawvza9SRdLQIX+o5C0CiU+/T3Flz
 zvGHR0YMYJbtnDpU3/ig7511srs9aNou32QKrl8cdDhLnn3P8+cV7CFCRRKgCYXDGYsAGviNLWj
 vqG/Sd41xOXJIk84qw5nFfZyEUg==
X-Received: by 2002:a05:6808:4fe8:b0:4a4:adaf:5570 with SMTP id
 5614622812f47-4af5dfb3ddcmr22809551b6e.4.1785847231047; 
 Tue, 04 Aug 2026 05:40:31 -0700 (PDT)
X-Received: by 2002:a05:6808:4fe8:b0:4a4:adaf:5570 with SMTP id
 5614622812f47-4af5dfb3ddcmr22809518b6e.4.1785847230502; 
 Tue, 04 Aug 2026 05:40:30 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58f7238bsm8204962b6e.18.2026.08.04.05.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:40:29 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v9 0/2] Subject: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
Date: Tue, 04 Aug 2026 18:10:13 +0530
Message-Id: <20260804-lt9611c-v7-v9-0-3423a76856d3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK3dcWoC/23OUQvCIBAH8K8SPudQl7r11PeIHtRpM7ZZukkx9
 t3T1cOC4Dj4w93vbgZBe6sDOO5m4HW0wbohhXq/A6oVw1VD26QMCCIMcVTBbqwZxgpGDo3hTJI
 GS0MNSAt3r419rtj58slhkjetxizkidaG0fnXei3yPPeFMdvCqRDklJYCH3hJjTq5EIrHJDrl+
 r5IDWQ/VhuB/LwWqyTIRhDMpBGm5H+EZVneuEHOov8AAAA=
X-Change-ID: 20260708-lt9611c-v7-ff76b2d1bf5f
To: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
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
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwMCBTYWx0ZWRfXzWVRJWsiMG2s
 IDpjpwb2vqKo/i1c8PmV+YRIbYfU3FTVu7OMI/P5JIfYGF2BrXsOyH5oaRHuqjhXsEVsMNZkqeD
 GJ/zB4CiXlltjDD7IdKcaKn4QvsUvjI=
X-Authority-Analysis: v=2.4 cv=Z6Lc2nRA c=1 sm=1 tr=0 ts=6a71ddbf cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=kbNwjhMloW2tGLXrOAkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: fMmLjgqk6_z6Qwo3Qlb37KDcne5a4Alo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwMCBTYWx0ZWRfX8pQR/W88V6fq
 BDtLgwcgLmFyVaxwj7NQjRDst1lNi/iAbnHK2DqyFPc+p+5YT1JwcZLp+LyJlDu/SoTPomiKkQn
 PHtJxfqKxsbdpoVsJARSbiWBmaegO7o2vfQMS+NuQu0bFyzv+rpAJjxiomV/sef5TMMPwE7Ad+O
 efxEjxlLuvvv7xfTTp7Y+gZCQ1MSzlx2mdzBJAUZZBZDLuq07P3+v3c9gMgPrUhY2cx43EyQLlb
 oevTjajPGb6gZ5fTPSM0/JegkavSrzw//RhnUUSOKxVFKMQzYowp9xFq4HnaLlZJFlsXYynsm1R
 GUs+g2i0sT/TiRuQSmuwqji5QVA/2r+DMOVVmfnEdTc1FyahWxHpB5kW+4fDNYa35AUhl7FJTkH
 Mumjli6o2ixfrOd3r2aaTOPCh9iyXPmzNT7rqmPjwKZbdl8ce7xq8uLJ/d2ZEIBVGSsz6z4wRzQ
 B4MWiqmFytdGjZaE+Pg==
X-Proofpoint-ORIG-GUID: fMmLjgqk6_z6Qwo3Qlb37KDcne5a4Alo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040100
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

This series introduces:
  - A device tree binding YAML file describing the hardware
  - A new DRM bridge driver implementing the basic functionality

  LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
  mipi dsi and output hdmi, differences in hardware features:
  - LT9611C: supports 1-port mipi dsi to hdmi 1.4
  - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
  - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0

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
---
Sunyun Yang (2):
      dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
      drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

 Documentation/ABI/testing/sysfs-lontium-firmware   |   10 +
 .../bindings/display/bridge/lontium,lt9611.yaml    |   18 +-
 drivers/gpu/drm/bridge/Kconfig                     |   18 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1263 ++++++++++++++++++++
 5 files changed, 1308 insertions(+), 2 deletions(-)
---
base-commit: 34e27b90552acf21bd73aac395667c8aae6da480
change-id: 20260708-lt9611c-v7-ff76b2d1bf5f

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

