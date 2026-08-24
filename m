Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6563C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2F810E413;
	Mon, 24 Aug 2026 14:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqrtBBE0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXyF9eYi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2D010E413
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:06:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCus5j3613396
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NrVp1848b5yws/YHQ7GLPr
 aflTdUrlMYStP7mRmwfwk=; b=HqrtBBE0cV2HHlyFOmWhjqg5PgMfVR1x/YsMj9
 any+/pIvokvRqukYMlSM/dVWzdmcfP3OiDuHkryc849QnFwjx2Nkq3Js6j16Ri2I
 Sc1wuPDVXojn6IFPjY5FZxEXC46Bjf0plPBcxDzw9RKyGadP1ojEiXqIWkPOIM2q
 aTq6x7GxSNLzqdYwtBa6+TTuxM0Dwn0HpLHEY0w1EKgvaFacpTC8CSoAgTA0BOH+
 1dLh5jlSiL8SWQDfxWNhvsgMJj+MmCA1rsZlQx4tZlhk/hcvnT91Vc3PSGV7gL52
 0AR0JyqQWOlVpBbnN1gmU97Z4nGfedHKcheFC80fckBcXClA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk1f4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:06:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc132709c76so5310624a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787580398; x=1788185198;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NrVp1848b5yws/YHQ7GLPraflTdUrlMYStP7mRmwfwk=;
 b=UXyF9eYiQWpHsp5m9PYWqv2TbMhNTXLJhGP8gWNxrYsQLMwWbqPXI8vBAxjRPItY1Y
 oCs7mauHKBz5tENkTBeLLna5e+qJxJRQLxo4GgFctvApt6kK2/TAbSxs+RZ2cs+V9sMo
 gKpaFpufA+X6uADmrovUqXceWibuQ9wRcdF7Dgdr4ePycUM+CDbBt1eZ2GY6IqDUDj6r
 i/xTZV8pA86DV32C0R9vGd2Py5DMMAftYrDs5RCr51vHlMibXzXhWq4kwbyjaz8OE7WI
 B3/JlKW+WoiGuiyO0tkhblJ3e23HH5BE/q8U4ySLWQj9VYOiLSOYQzP8YYaNlk6VjH4V
 7EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580398; x=1788185198;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NrVp1848b5yws/YHQ7GLPraflTdUrlMYStP7mRmwfwk=;
 b=TRqVPyF1dsltxhv7f3Vr2/w/sbPE0O2N7Q6pJe1UsA+yl2dHcO4tesgxuUvfAFP/X8
 i0ZYunVxuo4mw4OFqSAkqarttJxRSmS43jyTtdKg2ffpQVHG70I7gvTIEBGwf6eWzQEK
 Wgl2EbcwJcIEWKL69zujS4SKpT/ddNSO/CaLI6GEFLcJBpSuSor4UXHPAQn2eHd2bXDB
 zLH7F/SbcY43aZ1jJ4lQ8waVGv/Q8/Zs7ONathEqeuWideN/3tSyHDyv51/FQVO+9lKc
 KyUaTtSTJSzRJiNNo0qSLfYAtsl3NwV7G8VWRb9UZlg9xIR0AdIvhyESu2zBl1sIp2fR
 w61g==
X-Gm-Message-State: AFuF++lVZVyeY3BRQeiVKjccp068l63EP33ouumW3fnW3awXykxcsaGD
 +8WSZkteYGjhRXlnJ0Rr4hIvxC74EYGGYbuZiTWih3gIxcWvMyEHGOMz/7idG8VSC/HA6oGAU/L
 Vy437ucTmsYYB99vWxMf/M7wb7M5clHiCxjq7c9FRmiiQegS7E9HIjB3+N1QMSQCBWjB7ShI=
X-Gm-Gg: AR+sD13VyEMKbzP0Y1fjSdAhyvH7t1ZQmTWJWCX9ZfnRzU8Xi8/tvnhQxoBLhWhLohe
 NqBlW44+I+cufPjsciP/3FarBruDvwkvtLaYClduZYPMZHsOtJm6z5B9EwCtw+qjiw+0WXnUa3X
 QDlF0xZTlDB1LYvZmoTT5vbinwOUKvcIopETP4K8s9Ibu3KZX4JGJtDT+qsmpG1pjx2HNNl2Q6r
 S3on+Owyo7XGyPmtA8jlxRfVHOarnQZ44EcZ9xUJFvZlT+lLFMpR34qwmgmwF+lefuKQOZWS7T3
 XCxoUtiV2VZxy+NflGX5n+YYrCaEqXsecQeUzjdMclwTLC6C9Z6gPJH6TiCm9GsL/rf7om9Ak0y
 Z4nJblh6Iz3iBlnvVta4EAVsktg==
X-Received: by 2002:a05:6a00:4c98:b0:84f:dc19:b77d with SMTP id
 d2e1a72fcca58-851fa011e87mr47775181b3a.12.1787580397752; 
 Mon, 24 Aug 2026 07:06:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c98:b0:84f:dc19:b77d with SMTP id
 d2e1a72fcca58-851fa011e87mr47775002b3a.12.1787580397105; 
 Mon, 24 Aug 2026 07:06:37 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f17f7d6sm2146599b3a.61.2026.08.24.07.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:06:36 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v11 0/2] Subject: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
Date: Mon, 24 Aug 2026 19:36:26 +0530
Message-Id: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOJPjGoC/3XO2wrCMAwA0F+RPltp2vUyn/wP8aFXrajTdRZF9
 u92KriBQggkJCd5oOTb6BNazh6o9Tmm2JxKATCfIbvTp63H0ZUGooQKIonCh64WABZniUOQwlA
 HJvCAysK59SHeXtp6867T1ey97QZhmNjF1DXt/XUuy2HuA4MYwyUIlpwzDZVkPNhVk9LictUH2
 xyPi5LQ4Gc1EujktayKYJymIEzQgck/Qv0VFKkmQl0EVlGmpVBcOPZHADImpk8AKYb3NdHAhFN
 U/zD6vn8Cn710XoYBAAA=
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
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: NZPtYxRdCRA8PDlZPZ3Y9pD8jmyBNVva
X-Proofpoint-GUID: NZPtYxRdCRA8PDlZPZ3Y9pD8jmyBNVva
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfXzKn36X80040+
 RfNsMbNKMCdk5tCKlQRy30NZ3P2CEs4bSjVvRfFoRtVJhEdwLcxQIFl+ubRUsr514LOWwVbNIVy
 wEM7XIuu34YrEiQ4fnW8OQoAzhG87VI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfXx8Pdc4deEjPL
 thM5Gm1e/qLsTz376s5+8RYZCwMOpm+Py9Vk1Cmz+kEtZeokGio3ocUWs/KHjYMOKlF8VM6UOZN
 Y6NUKcKFD/B9qz/WLEjpdnDJAfPPdIlT0znaJwr2J38UHJvr5pG18/Q6RS74Fr48FXc5J2P3QGz
 r9sorXdDp/+PKt6Xut43idxbovkL+jytuKIC2IMjEdknWsD0aemNNFDrbK2rjMAbhGFfI1VSS5C
 RcEDRoMXkJFa+kFCGdAsx9xG1Ve6UmZXFVBPdY6xhNXbQluplxTIBAaFwCysr8Sn+JeIe2mRKWI
 7AJrgFi5YQLBNUkWo2hLz90DzJZJgsch9GF2rp4kuypT6lRa953Ds4rBAaa3c/lQUqSaaqnSzo3
 FfuBR3C8EeU1OSI0qbB72BOfRZnaoYvMIsMmB8xuX/hrXXwPcXKZXcdfAK22mRGMGVSzeQ+4xTp
 EY2Egy+wQRZdk1RrLqw==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c4fee cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8
 a=e5mUnYsNAAAA:8 a=zeht-xdHoPxp13dTMxwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=RuZk68QooNbwfxovefhk:22 a=cvBusfyB2V15izCimMoJ:22
 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118
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

