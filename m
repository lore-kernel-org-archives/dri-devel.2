Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD584CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C1A10E68D;
	Wed,  7 Oct 2026 20:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VVdB5XXK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BKHSIN4Q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D02B10E68D
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:15:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JO2HJ3394093
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 20:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DVxSjpgvWCRV3cVfb6cpJb
 Llz9DEF2cmzcTWVM02PF8=; b=VVdB5XXKg7v2iMxZspJUuBdxxhHgPVJV02Ub60
 Fshk3kSecCakXdKY5WoNZaK6uXDgivTiRlD5n0cln5vTSQiSl0/xVNAXscO52GTb
 ctgGycOweZvHB15d/BDjuM0Fc190NWNWd6ux7n5yqWYnBwO7KCSS+B6Yp5GwV7fn
 /chLWbPfNQT30OSAjuufbxQO+klTaTblCaLBBmKSCRaHtywobtQsrHHVok4VDfOZ
 WWVsn2ZVaqAYeVmi8YkdYt9CY7nWYnRGVydLtMWVSnU6L+NQoQfcuomFGWTCjLCF
 MrlnSPs9knfGVDg+uw3jEhXmZnof9imnCE9tuHzJ+X2/RClA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8u873-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 20:15:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso8502202eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791404150; x=1792008950;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DVxSjpgvWCRV3cVfb6cpJbLlz9DEF2cmzcTWVM02PF8=;
 b=BKHSIN4QDWDQpx2/bqHlu35Cv4hWT52hgPVAHGpCGhTCEP8M2ZVrgm9NgckZ//NXRm
 jr9W3cd3lNd8IxjTHkVLcfSWOHt2WnsKA6UtleqFV3cRswYKWDg0J9dUhiEa4gRYMbnC
 aoBsOzT6pnKViWm0XGvmOqJalrcCJhe2DKzNQp7y+taJBWO1up5q/0DhugzEMbwH0Tcl
 D4G3A215P56lodsZa+3Zin/ux7SIenO5mF4Vxj4VhFJLEdPyqLNbp1rn31xBcs2ui4Q4
 v7iSZJM0MZgofZlZwyzdmyNRoKhsdiO3aTNMcu/7Konzvb63dk8M3N45wlVUaFEk0geH
 +ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404150; x=1792008950;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DVxSjpgvWCRV3cVfb6cpJbLlz9DEF2cmzcTWVM02PF8=;
 b=oVdzjTRsdOudQ74CAbUTz0GdOT94ocpf7RRAeyUKb0z/mSxSq/D4fuXelVCOUScvbk
 sQa0M0GAeKWddNfwPZEWoeXYVUc4lNIdFk6U+bJNZMjqfQIqK7J/1ldLwv47jYLGqb3A
 hvHuQXBiNEK6ntfTrADQhVifXFWMRqj/B4mh7evuUIcd6CYmXvv5944LpJ4edDBimPnW
 2QEYon+d96WAY0z3Lc1DL/sWDKMYI9NfMHwj8rSyxt40TTRNagyD1h+FWslVDqGq+GPS
 dZ/TN5P/4MIzMM1e9wc7viWoFjojYgntlbryKz5Hh270QB9bgyzJ0bBigm9ILHcPI1Uu
 lR+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuIkqHGOUSitX9ImNV8Cuy2fXauWJqXNbzwRsa8rYrhbkLeo4mpKlsIcEwsnYAplx4DOjKgj+s7hE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nApftOgrnjx36cmb67fp8+7+z/3YXzb2ECJOW4IG8OtwYy+UrW
 1VxcTYTObeUvxWD6l+fJ84sRCgYw0dv/dZFhq4VLEDkXRJNu7YkwV5tJaJrusXFMQlSgPRBeTDz
 bGrZSqXHajs8Ib74xng/yTj7sVurnXvXj3ofc9FAQl0lsCXgCmVSF6kdo2lCKVVQvyU+kXv4=
X-Gm-Gg: AYBFou0i+WvVTB32Ay3PJY3acR92w5JXnTb7Li1xUICdexsU2fuz7L4I9xRXbYaH4hc
 cdg4iNLCFeNv0Xhd1lcQCW9QIu8sBSLZwanu+0e2r0vuXjqNUQv2RpjEWZ+AbOY2sg+kJBzlzx8
 hn7AIOzvivEGZ4c7FvVemOInDcrxfOo6hh9RtfEW8oZQS6z6y9ZsCxbPbo4U6SSF/6qP9REgtTg
 lY/YhTYfB39PG8Wo+dC7b+oVAFZdQFCwiGTmR5S3T3XVt926HU0IX6rGPts2ogC0fKmW/wvZipp
 3Lq5P6rEtTc8E+0WQ3bkcfQol+RoxWOa7+wom/rbzy5TOf4NIpzwqITy/qKFmMwKWxErs/IC72V
 g5ny4xQ/rDgIpyke3JMBTB1uGPg==
X-Received: by 2002:a05:701b:4590:10b0:159:125a:f863 with SMTP id
 a92af1059eb24-162041de528mr3180491c88.10.1791404149670; 
 Wed, 07 Oct 2026 13:15:49 -0700 (PDT)
X-Received: by 2002:a05:701b:4590:10b0:159:125a:f863 with SMTP id
 a92af1059eb24-162041de528mr3180413c88.10.1791404148349; 
 Wed, 07 Oct 2026 13:15:48 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16168f586f8sm10627380c88.13.2026.10.07.13.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:15:47 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v17 0/2] Subject: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
Date: Thu, 08 Oct 2026 01:45:16 +0530
Message-Id: <20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFSoxmoC/3XQ20oDMRAG4FcpuXZLJpOjV76HeJGjXWm7umkXp
 fTdzVahiRgIAxMmX37mQnKcx5jJ4+ZC5riMeZyOpQH1sCF+Z4+vcRhDuSCMMkkV1cP+ZCSAHxY
 1pKSkYwFcEomUB+9zTOPnTXt++enz2b1Ff1qFdWI35tM0f92+W9Q69wuDrOFy6KCEQAtcoUj+a
 cp5+3G2ez8dDttSyOovuhJYE23RRXDBMpAu2YSqI5i7oClvBFME5AytklrIgB0BaE20IYAWI0Z
 DLaAMmtmeAZXB2hgAq+G4VcY7YVRvF8DuhqHYGqwYhgMPzKELMvQMrA3TGlgMGz1DzjUqJnoGr
 wz4k4MXQyB3HC1VUrKeIWpDtIYohtbJRINaRev+Ma7X6zeyvI7j2gIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791404141; l=12877;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=Y4k8m9nJxhfgYsWMIcGPOMD+Bd0Jr9dzNJj86Pz5GzA=;
 b=0W3XolbajnglS7tEs3imOGr7R+ooiJOhwVO3DQl8OpW3m0uq1Zq7d1l43h6gQnlgmV3J+sbyZ
 5lMKcLAKtgrDSBc13Q6kjaNB/2p2zcWT3X0QCByHSQ0krvSRAiDzk5h
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfX2EvVWUjXs3sm
 SAGABlJVO91mTNJcbBvqDyvrPD884vc+56ZIpM9DIjDErglQqJ9G3l2tlPccop0xN5pyQYQJtRp
 WJvQssMPGmjuZQbtGLCZeoKZuMOHhYE=
X-Proofpoint-ORIG-GUID: UsTZKKVectSxs4wSn6j1KguMF2EqMGxr
X-Proofpoint-GUID: UsTZKKVectSxs4wSn6j1KguMF2EqMGxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfX/IOTOTG2DB7o
 rRpzw9WpHmcBEze6QGKdHKWrtooRfOvs/wymHJAj5WXwACmGFRvmGGtbwZt48sxMeEpRUbUYaxr
 E8Djq9k1YyLdO+B+94kRpU0Rs1FCDc4tvKSv0T5XXDyH8O6IX4I6HoMUmCqO8jjI2P1UDWRGNCq
 4uDPEZ4EzZDQUQhbh3j0jjS2FwsADYuUVn8TECLDnZAME6ImyZadDeCSXOv5BDiVczB3eVeLFkM
 ziZnL+j2xoAANbas7cdTdmBbfXMzh46s5yUQwiHN1S8m9f1h4BoI050qDBzgzFVqjhLqDn19mYZ
 ZaoWhRDtOC0aT/Yhe2Kr9APZ9MKNfoDYxonxdVHQ0R4ZGcobCHEkvY2egJ64kSotxbWhqeu7CFF
 sjup1uXccIcj3SsAeWColLy09mxGLmola73sJjC06H0Et6whOPGkp+V325+tRWuqBpWqGrdKzGV
 PlvhXG1+fPdgmWTsZzw==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac6a87a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8
 a=e5mUnYsNAAAA:8 a=IOFIWVTARERmE0tqbhIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=RuZk68QooNbwfxovefhk:22 a=cvBusfyB2V15izCimMoJ:22
 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070080
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
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1360 ++++++++++++++++++++
 5 files changed, 1404 insertions(+), 2 deletions(-)
---
base-commit: 79c96000962a163ad4c3c15537bf49159132843c
change-id: 20260708-lt9611c-v7-ff76b2d1bf5f

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

