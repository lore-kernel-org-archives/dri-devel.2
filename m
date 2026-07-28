Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C8EC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2677E10E4DB;
	Tue, 28 Jul 2026 11:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ob8AeooM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AES41KT4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAAA10E4DB
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:34 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SAgQQ53673351
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tBo8wb/CRbbdQ8Ep2ufGkH
 07kOzi2UnxSVOeiMv3dFM=; b=ob8AeooM9e9rIey6uGx6NOjO0w7iHcK1jWrCSm
 94EF//pmxp96mYDbwQ0kf68sArNGB3KtxhAuCI1wtqKgT0rpkTeHYEeFMgk8SzUw
 jlIXDEDmAVSrgk4mperMbL/QFxVIOGJ6TAYRc0A4ySpQPsFfxyUJOCtItFGCc0E5
 D2uNVtN0KdJvw0cce8mQ1N3NIieBHRRLwVHC+dCJjzRXBc0lUlEEzJGSL9JshFp8
 lkE0H7VAliuMoPgelkU2l+c6i2bPe7kXZWh7hPCmRnx9jtkgQgnLb0rVU8aIgUvO
 my5KZ2U3OvNRWB26vxD92uIaYBawXm37oID3+S/9oS8Xz9yA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5ky2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cce870a060so72152825ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785236973; x=1785841773;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tBo8wb/CRbbdQ8Ep2ufGkH07kOzi2UnxSVOeiMv3dFM=;
 b=AES41KT4mUhn+LLOxLdN0SHNlN3j2fHP+RZofOrzSt55N566WfUL4xnre2nzCB0pvZ
 BI4LzBPzGp74at4MMUpc2wWZUgk+Jpl5ujGXAizspIcHVYmI/Xkruq7GSXfObppyKAzU
 92F8vaoLH72ruSrwal+MblUVgBloIJO+rwrLdt1jxtZgerCPVxHUvb57SSRyh877Ry0W
 b2Y9Ct7oJpsKRll3UdJ+iX026OiYp3rYNsbHfJsaxGxz2F4aYSYk8sxO85cfQYj3IZff
 VGrTE07oEUc6f96vwZpfIuTEN/jc+Wy3roR+GH6WXARrE/ibeyvIUJQZNdubWHw2m3/d
 NTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785236973; x=1785841773;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tBo8wb/CRbbdQ8Ep2ufGkH07kOzi2UnxSVOeiMv3dFM=;
 b=DdvTOy2ek0iYrHL4n4LfLWQQPYB5taI3ovTMltwiCxonssQVbU4iI+HSAg74mm/uwu
 SHtL3v3ALKxdiqatxJTVODb3vMA9iCGRUAb4dGdXJBdTuJ5ZVkcMGLX5T6N4Gshk8tck
 lFkjgRtzBQtMl1TJF00t8ne6ecDK8Svjlv3W7RIzbTW5KWKkh6RmBTirRdVdgLHS4kRT
 vla05CKVL8NmCwwfAy9XuAbskddtFi8Nk5oEc7Jwy06NdoYTFAxNUFfqY0V27u6jPQu4
 WQMsZUdq66n3Wo6lvNKODUd2yoKiyhBc1romH2xqZQtz019HOhnZzjs9IgGOE/zH8e8M
 t4hg==
X-Gm-Message-State: AOJu0YzUSjhG+St3oR92P0SMaWfydpcgqjHdy06z4xQRDLZmKGyL9bEX
 o/ulB7EPprQKiWrabFblxwvcnUUg2MDbnCWgsYAoX6ZsnUV+cH8Fan5NcoqfI+w6sy4fPpE4Zrr
 GfHRSOC332Jw5YGTvSjFUbpZgZFLYfMkg5UWR3IIVgi6CZ1UaKCh4COZzTpl6qOfKKxfZhlM=
X-Gm-Gg: AR+sD11GdqDfvD8Xxliq/yGPjefOGeSMVFdWMWYMwczfF5/+CQEHxWmukTtI2idT1rt
 9v/r+VnNv+wNroRi52zpEO57FTG1WXrHLDP94nBisyO4wl6IEgA7C8oEmyS/+gMoQ+yPMu0S/xM
 Fi3yfQ6EcwfJIUUBbm20w2Se2YnZYNjuIhYEvU+k7mNwzV10JA3jdaXw2YU2h9Apv/Zn4p2WnX6
 xpToHOmQuEm4VEKQVgWX+Pc8jFdPLsjle60Ob6MHgPC8P2AtEMVZHFYjgdSTmpAyirqxPEVGdPY
 QKKUmpphhZRR543BQXIB0IYId4Sji3O0mCxP9l+bM4wntWGbFsOHYJuMr/JdJGakrVMsreJT6sc
 rjuHGp2bPvYOJrdVI0PczsmW47g==
X-Received: by 2002:a17:902:f64a:b0:2ca:53e9:1277 with SMTP id
 d9443c01a7336-2d015a2e99cmr23508735ad.1.1785236972966; 
 Tue, 28 Jul 2026 04:09:32 -0700 (PDT)
X-Received: by 2002:a17:902:f64a:b0:2ca:53e9:1277 with SMTP id
 d9443c01a7336-2d015a2e99cmr23508085ad.1.1785236972475; 
 Tue, 28 Jul 2026 04:09:32 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7bc4f4sm50292145ad.39.2026.07.28.04.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:09:32 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v8 0/2] Subject: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
Date: Tue, 28 Jul 2026 16:39:17 +0530
Message-Id: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN2NaGoC/02NQQ6CMBBFr0JmbUkLtkVX3sOwKKWVGqDagUZDu
 LsFXZhMfvKS/98sgCY4g3DOFggmOnR+TFAdMtCdGm+GuDYxFLQQVNKK9NNJMKZJlMRaKZqiZY3
 lFtLgEYx1r112rb+Mc3M3etoMW6NzOPnw3r9FufV+Yib+xekokZyXih1lya2+eMT8Oate+2HIU
 0C9rusH6aFcsb0AAAA=
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
 Mohit Dsor <mdsor@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5OCBTYWx0ZWRfX598kuYTpiLRe
 fjC/ADYiHhNYTJmahk0S1tAQIGhCPzogXcH6GZBUKV9aRRsksVSBbm3sIt5U1qvQ6VGuXSpssg0
 V3YZNFoosjku+IQeVl8qXzRbY3vn+9E=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a688ded cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=6-6V_qJyiyBno9EwSaUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5OCBTYWx0ZWRfX4vnYsjRDawpf
 /Gu+MZcboI0JX3O2OUZglwGNqXiqdJVWqzRbbzmkyiYv5ARA/AM7c7Fw69MkeQTL9nvaB9yG6MT
 +CydgbKIrJ/BRqgjPXxm8aWHkFXWkVfRor12cObk+HDifPiJer+NvO63zW4fud3DzMt2Bu2Asne
 RYGFhU7f+tLgRqem5OP9GPg8xRxk2sG1VGFwpxqW5Q84RPlw5O0nP2QC5NLwMcbzjUZdEhjFgFS
 +LaWanev64XMR2smfDJF9JuAtHfZu14nPyEp7T74k08X45x6n1CHgN9PKHIRMPtR3nTfUuMm+KD
 UsKTgL0dU5UF1qI+oT8pDlC3OcbKl/gROoQRe8wUjIigf9O/dVIjqgJl9ircW2j7XR5GNciPS1F
 8iCtERgA37msZOuuTXj8zWk2Zo1zKgfWbMuIOj2x5/RUBt8ab+U5zozVTFkUrKPQ/csimmxicbt
 YZyaz7fb3SqTiuYc+Og==
X-Proofpoint-ORIG-GUID: 1i9ZXBjCrWOCU3u1tuBDM1aXN-NAhLrn
X-Proofpoint-GUID: 1i9ZXBjCrWOCU3u1tuBDM1aXN-NAhLrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280098
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
Sunyun Yang (2):
      dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
      drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

 .../ABI/testing/sysfs-driver-lontium-lt9611c       |   11 +
 .../bindings/display/bridge/lontium,lt9611.yaml    |    8 +-
 drivers/gpu/drm/bridge/Kconfig                     |   17 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1344 ++++++++++++++++++++
 5 files changed, 1379 insertions(+), 2 deletions(-)
---
base-commit: 34e27b90552acf21bd73aac395667c8aae6da480
change-id: 20260708-lt9611c-v7-ff76b2d1bf5f

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

