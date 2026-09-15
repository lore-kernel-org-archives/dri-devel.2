Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3186C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD16310F48A;
	Tue, 15 Sep 2026 12:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPUVo7Z0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcGm8KKm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BBF10F48A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:34:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9hPbe3742093
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5+Q9z1SHFz7rPhcIkD8tCS
 0dzfm1a6dljgTqC1lcmRI=; b=dPUVo7Z0Txupa5cNN/wz1bJyMhoZ6roC/gIUdp
 ZWrd0wgkTAzKZ/tL9vULkOSET1ZRwM+mbYVRd//85j8xkvzzkiwPIrbBOueQDJ+t
 elnXjjPJJiR3K7YIILqg3iELUPca60nPhqaruDfuLX4k75DAyk36t27kdgXbgtrd
 NFTOR44ZvG6emPl5KVs+7hg8GctJiirQAANWN1Ww7wOhsikC1/1MOAs9fOsOayPm
 NJ3Y/LxCAP1HDPpnzi3VcW0bIMPnLWiwZ+FThdcjW+z6x/EJNOOofcIRkdm+w+E5
 dszvhDeFmJ1OMfHQrDSJicAywVoVlDDeC1pHmckEI6zkTJcA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux1rby-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:34:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8632fdf67dfso1287396b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789475647; x=1790080447;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5+Q9z1SHFz7rPhcIkD8tCS0dzfm1a6dljgTqC1lcmRI=;
 b=hcGm8KKmYSuBfCUqXkBc+XVnTzore7Bn4dd8u8xNfV2cWwc3tkS9ErU1aZInxFvvCC
 eZHT1zIL4fe7WTFIOOrymE2EF5M17mr6yI9LSTj846sdHMKks1pEiZO5JZ5J1ZBN4Fux
 4s/DmoB2swPug0a+SLbSOwyYIVWdN568adbsArkqly8M/OwlRC7YEy/DQAho3IGXbrqZ
 K7ELbvcUp54jN9plAmqBglfghAHBYazoWPEIG4Yx8Qpm0Opoz6ePAYdCTP8ZRyBEsEGB
 IbUNnOzn7sYhlidXLrQf/wd4qXIuxG04/+YCDbHEApydVleduXPDIUze/HO0EbSzP2wX
 L79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789475647; x=1790080447;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5+Q9z1SHFz7rPhcIkD8tCS0dzfm1a6dljgTqC1lcmRI=;
 b=UDjv0G2bvyOQcsPN35g6rPoHML8t6ilEtihpqt6ilA0PIALEJehW5W31F8EC+gpzPt
 1WivioA8dJpaaT63ID92QyiUSrW2LAHnP3f7rczi/cgQ0X/vPEOiq6x4y1ci7uNmiTPw
 EpkKpP0UiDDFQra9eZLLlZKALzb7/R883J0HBf6iMC2oSsQ8ra95fNlHv/4RZMb/K04w
 MS5oKgUTO/a9TYHNqaMWsulCBAp47mC9wtES8wJL5PNsLfcdvKAuUXRKhB1RzJ2IXasE
 nTeNzNv9sJCS5VgIpn88ig7GbO5Th0IDbl+BgqfvJPYZqvSQbArrMr+m6FtTrlFuzYZL
 UZqg==
X-Gm-Message-State: AFuF++kSMf8cytA0bDRt8brTB9e9E6sy3DLB8PJ6Y1bac+dHUHEDQQcC
 bu3/TgSF/ICg980UcspPyRmRz/iH1uPC5adbFQ9NTj7MJZierowHU9+sd1tuiwem2+0EDOiE01w
 NN5V++CdSNuGUm29EnaX37/Esqp/ScNoM8bIcA/9qYYFeWmqz3Cxldobhhk5bm5DIBr+auqA=
X-Gm-Gg: AYBFou1iGA+bedk5uGjG9juJZtIZAfdNzUJlLekjluqw6MvKOpgc6Npf5jdOzV4UbFO
 3JDZi1Fx+OLK5eFYCMbmk/hzulT68wANrGCi+Lzkw4j0I+70ntan1ogDk3fiXwsfEzrx1uDUdSR
 4mmp84Z32RZyziJYUxN/A4V70hbs29utYuKs9Ey3vgWtTu8qROzOa1D64teXsKf8VtDvz94W5Uu
 X+jOldQpQQppfTQ/etrXHrtxQVYbHFrfy5YThfGTlkhfeNkXL6ftNNxesfHqHCRm7bxOdd2kZlM
 fTmihe5QwV3I7z2XSsD9ZiPL9EU4JO5mKnfbfqF2pyS3dPdgCF0jqG/uS3NRozne2oturEqhyXt
 UjIIFsGt5Pgi4shdVzM0uD8+Pgg==
X-Received: by 2002:a05:6a00:138c:b0:869:31b1:4ce3 with SMTP id
 d2e1a72fcca58-87089e0a240mr4394788b3a.9.1789475646788; 
 Tue, 15 Sep 2026 05:34:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:138c:b0:869:31b1:4ce3 with SMTP id
 d2e1a72fcca58-87089e0a240mr4394726b3a.9.1789475646256; 
 Tue, 15 Sep 2026 05:34:06 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b287c481asm6509975b3a.11.2026.09.15.05.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:34:05 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v15 0/2] Subject: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
Date: Tue, 15 Sep 2026 18:03:49 +0530
Message-Id: <20260915-lt9611c-v7-v15-0-88f9e9387eab@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC07qWoC/3XQ22rDMAwG4Fcpvl6KJfm4q73H2IWPa0bbbHEaN
 krefU43aDIWMAIZ+fOPrqykvk2FPe6urE9jW9ruXBuQDzsWDu78mpo21guGHBXX3DTHwSqA0Iy
 6yVkrjxF8lpnVB+99yu3nTXt++enLxb+lMMzCPHFoy9D1X7fvRj3P/cKglnA9vNFSkgOhSebw1
 JWy/7i4Y+hOp30tbPZHsxBwFW00VfDRISifXSa9Idi7YLhYCbYKJJCcVkaqSBsC8CWxDgG8Gil
 Z7oBUNOi2DFgYuI4BMBteOG2Dl1Zv7QLwblhOawOrYQWIiJ58VHHLoKVh1wZVw6WAJIQhjXLLE
 AsD/uQQ1ZAkvCDHtVL4jzFN0zf1015DlgIAAA==
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789475639; l=11899;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=4SkTtHszFYstwmVIzBU0UuKl4Jxbiy3WBXXp0NOB4s4=;
 b=af1FAIUJpA50YrOZRyaDgU7EQKHQERAhNRciAMmr4MGKbhm0asVlKCgsUG+89a0NVs8GXMG3J
 Jap4IuuMKevAIVd7mQ+P3k/7f4Jv/0iqAgWZ00wlXJ+uXt13puyiGz1
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4MiBTYWx0ZWRfX/d0Xd8BmLjwZ
 n5xVsvXVCGWBXu8PziD/DE4baLHKe6DK8RHgEhPiHsnQwKbhK6J0J5MWQkR8Tc0wW/WFPBXBDD1
 C4D5QsqlSGsQmdAaclvteGUdAsCME4FgYgfYBfnCUOb9MkhU0bk79NiQK76fH3caAhFvfzt1JN9
 UWlTrQSAXBAhW1sEiOdKW2uHCpbTigQg195OZZcUiL7oNu6mAoJk1zYbxQ0P1/TX2M8r8qthe1A
 i/E4xh9L4rmF2AgpOb7xMK79aKhncp2nLI6+Xv2mUBa7QNCLfgQBqdczjmQgoeBEdbqqjgaI5M2
 OH2JKsYUu5mgwxClFVvJcP65Yzyw8aZ1gzQe2a0pl//zCBb8DasCoXbESmY1DzswwnafNXzY6PU
 s9hRfPX4LalCG6mpxaPx+qZzLclRSZhPK921ULwvQVFEfZn9Ia+cEWKsca/XtrVyktVpQcRJ/la
 LAhr07dEJEr97qSZeDA==
X-Proofpoint-ORIG-GUID: GJZSPXbjSTpTlF6oy1Ooh0zZzo9ie_Gy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4MiBTYWx0ZWRfX6yQe6u/sUGfa
 NGm1jfL2GBrgCgVMTFv5/9c/mCDWri1T3ICy+YF1BEjtiarAGlO+dr37cTxkbTlOOYSKFbZ/7Nh
 EbaSHxXpvd+kd+cF9TbRbAanQGc536Y=
X-Proofpoint-GUID: GJZSPXbjSTpTlF6oy1Ooh0zZzo9ie_Gy
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa93b3f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8
 a=e5mUnYsNAAAA:8 a=sRBEl6AxHTXEX1kRPDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=RuZk68QooNbwfxovefhk:22 a=cvBusfyB2V15izCimMoJ:22
 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150182
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
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1319 ++++++++++++++++++++
 5 files changed, 1363 insertions(+), 2 deletions(-)
---
base-commit: 4c8afdaa990f1a4d49e1dd5a640348ce5451a86a
change-id: 20260708-lt9611c-v7-ff76b2d1bf5f

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

