Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9E7C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 08:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1662F10E237;
	Sat,  8 Aug 2026 08:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EaqHH5o1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E1uLGZJ5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12C010E237
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 08:08:01 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6787W1Bs3063168
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 08:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Sk5Ui4nZg3wkKrrJGKKN4k
 B/D6QSevk0exnTdJ4qwFw=; b=EaqHH5o1NwEf4C1UZgMMCNs4r08B9oYEXpu3pP
 kRSw3NCN3QFVtsSmZKJI7iUCk4FKimxUWX2KiSGv7PJ/bM5ptTCSLUW9vkK2l7lO
 z2MigRAYmzibX+/NZSqnpmmV3LUKFwlNt92sVw3PxR88ys7MDnSWzib/ah6zi1/y
 /8k3+sbhpgg8mb4Sbb/ddeSwIC68F66vqHyfcCo76+dx5V3wZ5j00X4+MhRiu/N0
 tu7oc7jIL8gbgkCVEHaX3hVxrow8PBhxV53P+K/WVOJLl/DmtF5N6lw5j8lM1vjp
 2R8MCp/hldiX2gUHWllYaHj3HAC9suzeDJs3sIbUM4OJr71g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9g9tw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 08:08:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so312760a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786176480; x=1786781280;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sk5Ui4nZg3wkKrrJGKKN4kB/D6QSevk0exnTdJ4qwFw=;
 b=E1uLGZJ5rT/SaSf0zTLEil/5+q4veMnwBr98ncZGxFVtY0tqSmew+UleVfZh2yL1YI
 aIur3bHHk6AYZRs5tjLIV5fA1C+ani8hQ6Jjl6drQEcSwOglsnsMeynHb4LdsGzYaY8M
 Eoo838qjQBdM5lkQcNaPSptxAIETVg25pmQbC6ngJmh5xxBy9yq5fYojlOlZY49qqiGC
 jhB0RqMwB2UkggRW0UIl7mGCaYrkxhT5c3KnfyzfMKHTWh62ZmeZBDLyc9y2IKT2XyjJ
 XK87xCfRTGjVAWsnxXLeo+bEZgvBezTsRFtTJL0N00zHTEI34TjNAraWbelI0wEpjfvN
 xb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786176480; x=1786781280;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sk5Ui4nZg3wkKrrJGKKN4kB/D6QSevk0exnTdJ4qwFw=;
 b=lHM9CMY3A9vBzVzY4daKDTIcqKoqfAqsxCssNQX+AMWBZdO2uWp7/2NQlIfpVglfW4
 bdeVNuzn8YyI/ABtVnAaF8WVZo/oJaqUBKP37e5T8amTxkYpKoO3ZMwDP2xh7ax/X7KW
 KYuY6exb03FWlEu1qczjmRJS/vS4c0x3s3+4MWcsWd1D9YvioRZ9uqgVRQJBBVc6RWdM
 zsIqj1RrRaLR2VN8nCmJ7JZXrkXQ2Q1PI1xpeuKADs8xKcS4WdhbtQB8KIl6KBzgVkK7
 Kvi/rN+RxXBPu9EvHD35u3YDmpeibLR4P0tXAgmYAvqtaMGplVyVe8bh6/3CWOd0E2Mh
 jKVw==
X-Gm-Message-State: AOJu0Yzk0uN66KNWELvOxjWzuiyEGbHyPQAqZwvrieDDEZkwphrxempz
 Baxi8WD6Jqc7K+YB/pwxg/mZlKnvtsP2FE/sAGi5wCfjONfLcfsAOHXWgvNNPEofkjf1IIggEzY
 apRPzIp56KP9C1LXUJ/GvSuD03xFv6kgZIcAzmzUWamBMDD80XMIOAVp13GzVRWt4cBF/6Ew=
X-Gm-Gg: AR+sD13/K3R6IzgTeaDIMTA77Nu28I/2lBiVSdbDw9ZazRwUY5zgUMmtuACsui+Q94U
 +/y2dwRemaBs8v7O2Fe2c2OrlrS2j5extrpSzHno5vyxJ0PPUWAKtE0X9oJRRkCrps4v0a7DNVH
 mblCo3MRuRo7lxfTikG32TZ8c6efL/9UtjK49cGK468BKkmMFkwG9raLzlEQoCFu9xx3pXYNETW
 IVn38SUdLI8wNuZiVZdQwdbhj2pNwsIinnUSPmDW0qEBd+iE7W4rvdKZmxN1mRjMBfd9z1wRqqZ
 etiYIorQ+oVFIFzUgdX6danLttmAO2+Vi5fMTDG9cnHFMlnIfv7FQuVH8LWEdSG0ARe9lEBwm77
 5d3J7vxtjuWVvjSiTY5WPS5Qm7g==
X-Received: by 2002:a17:90a:ec86:b0:390:b3c5:e2c9 with SMTP id
 98e67ed59e1d1-392846fd57fmr1780380a91.17.1786176479736; 
 Sat, 08 Aug 2026 01:07:59 -0700 (PDT)
X-Received: by 2002:a17:90a:ec86:b0:390:b3c5:e2c9 with SMTP id
 98e67ed59e1d1-392846fd57fmr1780354a91.17.1786176479218; 
 Sat, 08 Aug 2026 01:07:59 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2c714sm7497465a91.10.2026.08.08.01.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 01:07:58 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v10 0/2] Subject: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
Date: Sat, 08 Aug 2026 13:37:49 +0530
Message-Id: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANXjdmoC/3XO2wrCMAwA0F+RPtvRy3qZT/6H+NCrVtRpO4sy9
 u92U3CCQggkJCfpQXIxuARWix5El0MK7bkUGC0XwOzVeedgsKUBCCIcCSThsWs4xgZmAb0XXBO
 LtWcelIVLdD7cJ22zfdXppg/OdKMwTuxD6tr4mM5lMc69YczncAkEBWNU4VpQ5s26Tam63tTRt
 KdTVRIY/SxnAvl6LcsiaKsI5torT8UfofkIEtVfQlMEWhOqBJeMW/pDGIbhCR2dWatCAQAA
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
 venkata.valluru@oss.qualcomm.com, vishnu.saini@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786176472; l=8700;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=Fjxr2GAzlm8AhbKBg7HjaqAi8WIvKtQmk9yk8SJh9ss=;
 b=YeLxGUKwkmOYCftPvNR8mH8Q0H65k1RkDPC3PKBAZU/LDrMLwnQdCNHlnd9j0VU+/KnPUh2hp
 bm0BIUwp2v2D6Be822I1koGgLSjnKkM3aDDOxE5nxeGx4Zy2RfTC2FX
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a76e3e0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8
 a=e5mUnYsNAAAA:8 a=zeht-xdHoPxp13dTMxwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=RuZk68QooNbwfxovefhk:22 a=cvBusfyB2V15izCimMoJ:22
 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: TGPn7TvpBgxgk9dBhMHG3Zet3rlKyVTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA2NSBTYWx0ZWRfXwUk3+xWu14dw
 gbBdLAf4yywsEs4+EecIiaqD1oQSP78mIdk5c+7SdyEeKySF2NdqtS1zr2xVqKIzE+jB4CTcoG5
 7kwYPj5LHINWqXUV8NJxh8Wz/yt7iEG/BYWa1WmQqDY+vAOdW/6pt520fi7WWDFsgpKsyRMC8QW
 svMH7Nl+GGayX+HjOHtsHPmdaDceZhQeUOURbqevVGl0f6O4lxHEFdMrTQMlsyT3nuexBNvhSS2
 JsUd0iNWt7c45gKleGZAHZxY8J/4tGFBizMMnkibHakOfCeTrhx00uLrHFnzb74q+eeuejYjPe/
 vSlaJI2ydP4X3/Ni5eQnxpNuok8Z2JIrgIO39DFYRtqvA66OSY/lTv/U+QZ98fPbLIqGxNVNyDv
 RIhmZ6fn0ccLf/3zs5WXpMZH/BoMeiVnkHw86bS5XpFw4ngC6ZzUKok9juuIXtOd/JO2x0pXWu0
 8QcHM0svPV8khrbE1dA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA2NSBTYWx0ZWRfX7lhOoNmaEn3D
 UALKkZwwEBwPg6GhpBh/rl3m9ZL5o0eYRwqv+WD3jDIauMCJmNOkjhH6NhYF3WMzRb5WNE3vgF/
 7lphQM7PNQ8jGN9lbLFHBN7CS+ER9gs=
X-Proofpoint-GUID: TGPn7TvpBgxgk9dBhMHG3Zet3rlKyVTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080065
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
 drivers/gpu/drm/bridge/Kconfig                     |   18 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1283 ++++++++++++++++++++
 5 files changed, 1328 insertions(+), 2 deletions(-)
---
base-commit: 34e27b90552acf21bd73aac395667c8aae6da480
change-id: 20260708-lt9611c-v7-ff76b2d1bf5f

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

