Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBC9C4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E56010E76C;
	Thu, 16 Jul 2026 11:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/bnXPlM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXyuIrLM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FFE10E76C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:31:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G9rc0D2415881
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/csOB3IHDeDXkiTczOZcj6
 MDYX9BkplsXgPZmPpF1VQ=; b=Q/bnXPlM52BNyrKjh/pbgi7GiaeVviqx0TBEzT
 TUp1fDIg7ZfPRr/UAm4QUtfZxfScsES5BERKiEmRcR2AR+PqBtFFvYdH2HJ7gHGG
 mLVRUeY3FYNGfesL7WsvaaEZScbZYgkuBV6ERrlEoPXw2/XQhzUGC6Y4S5NyaIzn
 eQt7geZwHjTZ9fn01XCU5wbJ7o2uxGAgK1WXKuc7fZtmw8JD+HzYcpGPXXcuBR2/
 5UWN3A99EZR0todHXcUvq6fcFicc4Fj1HMDvcNlHgQHONaUg3/kLtIXgpXBsnVcE
 D1c/uFmesR6WwiIOrxgpTU84MHV8A7Cy1dACDQ2kdEMXyqXg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feve1rmp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:31:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381ed6616f7so10134174a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784201479; x=1784806279;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/csOB3IHDeDXkiTczOZcj6MDYX9BkplsXgPZmPpF1VQ=;
 b=UXyuIrLMdhLIaanEwlhBrTH2mb9Rpd6AjXQUYQM4h/9zPqc8AP/7fRoQQVn1efSKal
 fHRyrWmi4eUAnJyIaYeVcj5iXgew1mxXSiurUzh2IbkOJRKQtkbK2e/7RrYsehO/CzYq
 LCo7H8YMmx0/CrR9hqiA7+uHe8C4q+OsLgt+DOJfABVcn1TjHfQBniiJT4UiiLgbQ0Qf
 a2RETbeB1dOiCZXQrJWwZiGeZh2eWb5PL//SSnST/f57BHfwfRszn5KHS/TuX0DCoSxU
 IZRY6tV7MNMHOiB4MdliRc6FEd+YuyyoSpBK7zmqcdfZKlOEua9nEeuVXgu+IFSSJJQQ
 nOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784201479; x=1784806279;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/csOB3IHDeDXkiTczOZcj6MDYX9BkplsXgPZmPpF1VQ=;
 b=TBqX85dzZ0d4ysbSN9fNaVC232hCrKXbfB8uqP97u7oLjnngf0OQF1lT2WMRUkzN1I
 0cyLduqkUuJMgMfI+PFW6CGFEnkuhJHZrAGILmcO5Dk8WHrez/bPH7891DVPIwImTeri
 EPZFSzQHn2QgAZaL7rTRtXzvQimmppAWewNNvvzfX5uESEx3hMH+Yv9Sp3vyHRJViDdN
 j9ZmCKd04Bj1nOAAhid5dpqpbqasUps3d9UXELoq2UnT6I3cg8VY7SAwwesk2IRPBr6v
 cGmWaX7lzmYdjhxNcIju+0jMmjl71J3qpLdYiW6qtSdH3BbNLabKTYGqfTvuz/WzuC3F
 Lt+g==
X-Gm-Message-State: AOJu0YzQuk3NP8MvAMPMjmLLl+vvV2+tYj/+D8qJLkxr0o65RE4vbpTR
 uS6n0xHyTiCAvibocUEStud4Tca7TMYaEQndLWGg+BbOSzUOlLvI+02VXBBL96gpBlGx6gLvJXE
 PLMBjgLVVLcqhGM73PNoTQOZJ7ArBjkuqIOQ0eAV4/skpRDNA4HqTJNqhRCZ4KN3uI62hA3E=
X-Gm-Gg: AfdE7clJ7BuukDDlSqqrn9K9It/M4zkbykVDMR0KprHtv+I4pEoQzskgRhEaZSPGjiy
 ewdTLu87MCnYtQg9bXeosrsqUTJPw9gDZvUDXrVl8isFTzjedFTfv9sTbprRm/vOw06v7B/Apel
 89gdvqDHY/aMcx5pn1EWy0sRx37bmdpSUD4POHhDUnHr/ZTIT5LxnxWFFGi9UFptczsO732uZwD
 8SxKI+5BR7MpzJze7tRVjT1XH76JRVD1UExop+w/UXs/cOsBVKFKBeTJWrVoHyyZJ5p4ZodDW51
 Q4Xs1dzMFCyyrxj7GtgMKDOTwGLssislQRJNH06ZEEwaTdGqh0U13jPSMCNRiPmh1o24qe/58qp
 30i+mDXcoFKZPSSdKm4AdLAsFpw==
X-Received: by 2002:a17:90b:3905:b0:387:e0db:3d90 with SMTP id
 98e67ed59e1d1-38e2a0b5d8amr7226881a91.43.1784201478464; 
 Thu, 16 Jul 2026 04:31:18 -0700 (PDT)
X-Received: by 2002:a17:90b:3905:b0:387:e0db:3d90 with SMTP id
 98e67ed59e1d1-38e2a0b5d8amr7226837a91.43.1784201477875; 
 Thu, 16 Jul 2026 04:31:17 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6f0dcdsm9720262eec.31.2026.07.16.04.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:31:17 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Subject: [PATCH v7 0/2] Subject: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
Date: Thu, 16 Jul 2026 17:01:08 +0530
Message-Id: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzAWGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3ZwSSzNDw2TdMnPdtDRzsySjFMOkNNM0JaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAK4l2WpuAAAA
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDExOCBTYWx0ZWRfXxppMwlvOcik9
 3lt3Qvk5UNem2PPAX1zC5EBalBAxpRzodDCWEgmmijgM8465KI688GACPIl0ZChItzIHtjKE0ru
 EE+Pga9HaNAoCfm042qaslwmf5QjGEQMhT+2VU7Qy/3gJEEc2c8kWBMPf2cXwD3NJNnsWlGSNHs
 6IySMmU0YjZBXv0cVewUC0M8NlaSJMlMzHOaxim5o5WG5UwsJRWqD0Qhqo4CTKon/vNR91bTCXv
 5M/IL15dXTwujeFOc0poyCvmmM8fPFBILog+Xuly5R3eH6rUgft40nzHmLiWLeS6stb+8Q7ADsw
 AVXdhPTGgYZEhWeF0Hsry95qxMMc7cmHSiFfTtrTmSdqZ0d2YSm9FX87Aqe4Ub6sUw6M2y305zv
 BtErzUrKv+dUoI3UncsOXeXiLspYKDLXV6/1ujaCv+ULD814VUbSR+V7x1wU+Ic7FOXXOC3mo0Q
 OFdrTA3O0ZdgG/WYUsw==
X-Authority-Analysis: v=2.4 cv=DvpmPm/+ c=1 sm=1 tr=0 ts=6a58c107 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=uFMGIqzs9byGSK33UbsA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: P9CTldCG1UR_TXbfmN59FapB0eC4LiUO
X-Proofpoint-ORIG-GUID: P9CTldCG1UR_TXbfmN59FapB0eC4LiUO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDExOCBTYWx0ZWRfX0SX+G/eYLt35
 HaILIyNS9mSQa/qkwnrlk5ulN71RaJuN8sINKh2P4lRooV+FQ0x1k8mKIvO/jlnhixGYFfJRm3T
 OhClOQKSBv7isID+bhgVo9H+he22E9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160118
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
      drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI DSI to HDMI driver

 .../bindings/display/bridge/lontium,lt9611.yaml    |    8 +-
 MAINTAINERS                                        |    7 +
 drivers/gpu/drm/bridge/Kconfig                     |   18 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1293 ++++++++++++++++++++
 5 files changed, 1325 insertions(+), 2 deletions(-)
---
base-commit: 34e27b90552acf21bd73aac395667c8aae6da480
change-id: 20260708-lt9611c-v7-ff76b2d1bf5f

Best regards,
--  
Mohit Dsor <mdsor@oss.qualcomm.com>

