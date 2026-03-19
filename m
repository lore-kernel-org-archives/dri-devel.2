Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9578E1075261
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C200010E850;
	Thu, 19 Mar 2026 06:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="firpyqFS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qbw8SOZb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2E510E850
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:31:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5Y92n2690169
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=4gHVFKmZF26QFBdmoRuyj1
 Gtmi6IBytdod9bWmmIVOM=; b=firpyqFS/aujfGShxzNEgMg4KFaL59ToVcaAwh
 7C9Oa9z7pyx1aUeSGEVyCJZlX6rxgjnx5TQNaN7zLVCpHep2bIEGpxvvpKr38iZM
 47ppjhomVGsIXUnir9w0vv1/chBUztEWSfjb7ODsjbPA4jEx3acXtIjCPF8aGdVv
 0giRNjFxfAoYOFOnjWBGsl6T1CiGrnQBrDEtiyCWSzQ/JW0CV/C4W8Ciq+pVo+zY
 OQgvRZGDUC5hWvqL2uQ87b/33AqEQZVMMu8g8AYcSFyZ8umP/mp/AGFPa1Flak4b
 3t8znMFPMwxvZjc2c03Q42hfQ8LdIjzAHkLTFyLcsPk3nGrQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytxyucbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:31:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b064884a7cso31172585ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901907; x=1774506707;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4gHVFKmZF26QFBdmoRuyj1Gtmi6IBytdod9bWmmIVOM=;
 b=Qbw8SOZbj3QvKIop1ZC/HdjsjR+E915idVqjKGvtuCkcBnjuOg9DM+aPO0a75ahr/z
 1n33BGGqMN/yySCd44X4qF+HoKoIQO11o4lhEwv0kxlpkzLuWg2hQEKu67oGFlU/MfOP
 BtH8S2q/SXxZC2quJY9dXtsbrUWs3QeTJWrIfyzTiP5BWsR4D1NX1i4ppPWy6JR1Ws9b
 Dtb+sMJVc6tBOMD4Ghiq5Md5w9ZZfPO+lCazwJExMcU/lOL2UjC14mZ5co+WVlwexvqJ
 Ej7YBWOaIQUgmalQJAmsi7Ar4RMG0w5C/cdeSjILHYB9ebmmPHKl55XRqGWGgsvyZVRF
 zjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901907; x=1774506707;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gHVFKmZF26QFBdmoRuyj1Gtmi6IBytdod9bWmmIVOM=;
 b=lSBO8b5NvI23Tw4QIL3nx2AMRFHoKlHz3//iDFpohYGIV4xnD1pSnfXUx1abTZxrGx
 gVP6iMpPnMMfRhw5SY/xKnChIB6vw/YuJoXaTyT4i7JDfHhljmvsWXR4wIKSGsLPTLIE
 BQjs9q8KSH0MNfhrIr1FB+LIx6VRPVq0QNQslLvsT7ynbZzznA3dgTUhsnV/RF0xkdO1
 CXiuHy5QlvPdDU6jn6PcOHMRp9sstNS/kngSt4w9wRPCa4HsY3PA6kDfHTkh4SmRROzR
 LExU2ChmzllySLIQ1IZX8zS2sOY7Hn1IoyDRvT2OE7VAWrbS5ANcDjE76qIL2PKFHDoj
 0lzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnJ3MyABvx75SRJT78R3A70Kf4PLnF/6L0bKXvswigyr2IXljqclXoqtO5LcnXnSGcEd7i4fe1CwA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yys4UjmH1IbSFnqE1pH5/zATY2dPy5CTDOCPLXKEMchauDpjIKW
 JIekFOD7m4Q6spnlwuqm6DQQAyS/SJqNCKF3bO4sMXz+ySs+wvMBw9UkIrNlJpcIDvZQBfYjdr7
 pGv+f7xyvtmKwsXqan1sh5Ywc0FbMNbJ5aI7++S4finS7vIy4M0SGUSSRUNhIgO1G8FQBdk4=
X-Gm-Gg: ATEYQzwjs0i2Ragi1eC+i6/NR3c1EQLuKJu6rKfGGXXhLNu7Ppht4ua87PIqSwKwBUg
 v/O0aTiiYyFl8pV6MaqHbpGMKGduCvNFURSP8YGMbxGDATOPobMVkqqFf1HqiXysCWIvvBKgTB4
 vYvdxHpL5YgIEH4I6+H59Z/iALc/VQy3MTwDO64jAYvBTHX4R4+7MDrXH54wMxfJYK+2fuMIFHf
 yJWfQB5JKF0UXzyf2ycBkrMrqoZyKhnFcq6e//1/WDoQOjgFMKJkDkUl/5SHpY/HftPZcEYlaIL
 IS2uTrfzbVV7sYWRD0UxuRtK/g2YiAy2ldUEdA9ZL7qDly4qNgVb53pteVyst/WV5d3YS4OA166
 RQtUxytYjuSx1BwOCgVXsTTkgrymaizfcvXm8chFrOlDVoxAJ124=
X-Received: by 2002:a17:903:11c7:b0:2ae:483f:b23c with SMTP id
 d9443c01a7336-2b06e40408emr60423995ad.36.1773901906984; 
 Wed, 18 Mar 2026 23:31:46 -0700 (PDT)
X-Received: by 2002:a17:903:11c7:b0:2ae:483f:b23c with SMTP id
 d9443c01a7336-2b06e40408emr60423875ad.36.1773901906445; 
 Wed, 18 Mar 2026 23:31:46 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:31:46 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Subject: [PATCH v4 0/9] Qualcomm Sahara protocol enhancements.
Date: Thu, 19 Mar 2026 12:01:40 +0530
Message-Id: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEyYu2kC/33O22rDMAwG4Fcpvp6DrfgQ96rvUUpQHHUxa+PWz
 rKWknefUxjsYh0IwS/QJz1YphQos+3mwRLNIYc4lqDeNswPOL4TD33JDAQYUQvLMw6YsL2kOEU
 fT+1IX+0M3BhotLK29kfLyvIl0THcnvD+UPIQ8hTT/Xlnlut0JbVoQEshHZgKpBFaKy75R8hDT
 FR1OE24izlX1088+Xg+V6WxlZvhh/j3q1KCg+u9VU2nyfkXWv1Lk+KlVhfNOUWoOtFr7P/QlmX
 5Bkk7gVtUAQAA
X-Change-ID: 20260307-sahara_protocol_new_v2-662854773cf7
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=5830;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=eYzkZ3XRoWualdOLvHSF4ej1vq1IaANvIq+gf8oCGpw=;
 b=PWgBBhIxmBKr9lbh/++fnvWRXX8OMtVafmqbTE8ToPCX3FklnIt8Bnn3E/DHUl97pB/l9RKhu
 B8C1X35ATdtDVHW7b+M1L16M1gcwnXGNwslJvZGBkEJGxaA4XUwvRuG
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: SfA795_X94Rr-YUh6NTJgMPJH21zbOiS
X-Authority-Analysis: v=2.4 cv=FKAWBuos c=1 sm=1 tr=0 ts=69bb9853 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lG-yCPvlEGbsawO-O7cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfX0n8c+9dWeV8G
 ITmAlC4DLNTLiGXBoV4003Lm0mshCZlMxSvS/zESkWuhWMR6A/aNhHJIK5rwy5UH8o83dVX2QxU
 8r1vde/KAVvzVUg6YpeZe7jrTFdvdKUHJB2UHZypeylOe95t1DRhih05/5VHa00Jy/goPxUSS0X
 Fh9pU6VVjJNx+OvAGyLQp7fjenkAUuXSDWhBOAHpE2kq2TF7pxpLdXtp9xtMcANNcSmOBnPYfPR
 9VR2DiKrM2YKK5rEoZdTGHv6DuN0s78gtF+Qv5TqPKFhIANGZHUrOduhKwMYNgfJoLHApncQdR+
 eA89UcFXnCKbmm0EvSjJh+RD/Tvso8BL8OspOYPmMS869YfLIC3d7pv4Y063BUS5wFwbk6WsrKT
 eM4pYzCY15YzS/5BFqS8+ol9oWSx/MBH33VaCHGSkOM+4dPc9nw4rqRW+Rtubn6QUCUdrhuWhFO
 9l8xpWCMHWGrDgRtorg==
X-Proofpoint-ORIG-GUID: SfA795_X94Rr-YUh6NTJgMPJH21zbOiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190049
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

Hi All,

This series reworks the Sahara protocol driver to make it reusable for
multiple MHI based devices and adds support for capturing, restoring and
exposing DDR training data using the Sahara command mode.

The Sahara protocol is transported over the MHI bus and is used by multiple
flashless devices to transfer firmware images, retrieve memory dumps and
exchange command mode data during early boot. However, the current
implementation lives under the QAIC accelerator driver and contains
device-specific assumptions that limit reuse.

Some MHI devices (for example, QDU100) expose the sahara protocol directly
on a "SAHARA" MHI channel and rely on command mode to exchange DDR training
data with the host. The existing driver does not bind to such devices and
ignores Sahara command mode packets, causing training data to be dropped.

This series addresses these issues by relocating the Sahara driver to the
MHI subsystem, centralizing device specific configuration and adding command
mode handling for DDR training data.

Overview of the changes in this series -
1. Move Sahara under the MHI subsystem:
   a. Relocate the sahara protocol driver from QAIC accelerator tree to
      drivers/bus/mhi.
   b. Register Sahara as an independent MHI protocol driver.

2. Generalize device matching and configuration
   a. Allow the driver to bind to devices exposing the protocol on a
      SAHARA MHI channel.
   b. Centralize firmware image table selection at probe time using a variant
      table, instead of scattered conditionals.
   c. Preserve existing behavior on AIC devices.

3. Add QDU100 firmware image table support
   a. Add a QDU100 image table and select it based on the matched MHI channel.
   b. No separate client driver or registration mechanism is required.

4. Add Sahara command mode support for DDR training.
   a. Handle command mode packets(CMD_READY, EXECUTE, EXECUTE_DATA).
   b. Query supported commands and retrieve DDR training data from the device.
   c. Allocate receive buffers based on the reported payload size and copy
      raw data from the MHI DL.
   d. Store training data in controller-scoped memory using devres so it
      survives sahara channel teardown.

5. Expose DDR training data to userspace
   a. Add a read-only binary sysfs attribute under the MHI controller device.
   b. The attribute reads directly from controller-scoped storage and remains
      available after the Sahara channel device is removed.
   c. Cleanup is handled automatically via device-managed resources.

6. Document the sysfs ABI
   a. Add ABI documentation describing the DDR training data sysfs node.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20260310-sahara_protocol_new_v2-v3-0-994ea4b0d5ad@oss.qualcomm.com

Changes in v3:
- Dropped the explicit image table entry for the boot critical image ID and
  added a generic image ID based firmware lookup fallback.
- Link to v2: https://lore.kernel.org/r/20260307-sahara_protocol_new_v2-v2-0-29dc748b5e9c@oss.qualcomm.com

Changes in v2:
- Rebased onto latest linux-next tip.
- Reworked commit messages to clearly start with the problem being solved and
  end with a technical description of the change.
- Moved the Sahara driver to drivers/bus/mhi instead of drivers/soc/qcom,
  reflecting that its an MHI protocol driver rather than a SoC specific driver.
- Removed client side image table registration and consolidated firmware
  selection directly in the sahara driver using a probe-time variant
  mechanism.
- Ensured each patch is self-contained and does not break the build or runtime
  behavior at any intermediate point.
- Simplified state handling and lifetime management to avoid duplicated state
  tracking and ad-hoc cleanup.
- Updated sysfs handling to use controller-scoped devres and avoid one-shot
  reads or manual teardown.
- Link to v1: https://lore.kernel.org/r/20250825101926.2160554-1-kishore.batta@oss.qualcomm.com

---
Kishore Batta (9):
      Add documentation for Sahara protocol.
      bus: mhi: Move sahara protocol driver under drivers/bus/mhi
      bus: mhi: Match devices exposing the protocol on the SAHARA channel
      bus: mhi: Centralize firmware image table selection at probe time
      bus: mhi: Add QDU100 variant and image_id firmware fallback
      bus: mhi: Load DDR training data using per-device serial number
      bus: mhi: Capture DDR training data using command mode
      bus: mhi: Expose DDR training data via controller sysfs
      Documentation: ABI: Add sysfs ABI documentation for DDR training data

 .../ABI/testing/sysfs-bus-mhi-ddr_training_data    |   19 +
 Documentation/sahara/index.rst                     |   14 +
 Documentation/sahara/sahara_protocol.rst           | 1241 ++++++++++++++++++++
 drivers/accel/qaic/Kconfig                         |    1 +
 drivers/accel/qaic/Makefile                        |    3 +-
 drivers/accel/qaic/qaic_drv.c                      |   11 +-
 drivers/bus/mhi/Kconfig                            |    1 +
 drivers/bus/mhi/Makefile                           |    3 +
 drivers/bus/mhi/sahara/Kconfig                     |   18 +
 drivers/bus/mhi/sahara/Makefile                    |    2 +
 drivers/{accel/qaic => bus/mhi/sahara}/sahara.c    |  601 +++++++++-
 {drivers/accel/qaic => include/linux}/sahara.h     |    0
 12 files changed, 1869 insertions(+), 45 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260307-sahara_protocol_new_v2-662854773cf7

Best regards,
-- 
Kishore Batta <kishore.batta@oss.qualcomm.com>

