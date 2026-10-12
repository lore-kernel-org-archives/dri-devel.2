Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70490CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6605810F2C3;
	Mon, 12 Oct 2026 18:18:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF9A10F2B9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHvHhs2197366
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=sTqXbDBaN0X4bkIx38SwJs
 II48e9h6LTI2mEy3hMK1Q=; b=OknDlfrlObentLs+cznOacfmAGE93PVTWIMoMq
 EIaOnYHhtgmlPL7eT7yl/zjnIANRhnrabjNXfpdmP+bYqLPHVuXoQm9QqnTGxUU5
 fFYilA3YmAcd318LFmb4+RPpu0ltnDMPhBYFVlFrCRZPTKq2sjNKWkliTnOvHcfZ
 0aaa8iLD31bvsDUg3wGItFjKFQqLd47+jdbHtIAc8rJnv0VPjzBAOiI4pSRXcUaL
 uwvrT3O6/rSTfwwCmdYDDK00PiixNDdp9bBk99URUFAiNUT5fJ3aNSVwYxM+ZXej
 NxW8sL9rvP90Haqt1HCQIU/0BrFKiJWN4OaVIwMzO3cdkATA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ktjyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso3809489eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791829092; x=1792433892;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sTqXbDBaN0X4bkIx38SwJsII48e9h6LTI2mEy3hMK1Q=;
 b=A3tDrtwRPZCm6Coe5L6sq9JC+1fQB6jaf6JQa+Ae5AaMZDFtnBb+jtGluOGVYLCFYc
 zVwOncs0PEe4eMUOj1TCIiD6Dj1fJLE22LU3R5y1mWLfe74hUp5sfd3PS7HaagySAZ5g
 KkH5e8sJqBmRIdEUX94QY2ILy++RQv06uAyhsGPgRz0rKRzeQF4WTHvD1PUtjeprdi9Z
 fSo+vAXOzU5pMcwD2znxVcnXOv/lo2Lepwgc2xNLJPZ0Y5Dk3F4vIOrO7sUwSc2t2Aqj
 CASLvwbqfjKTR4d6vKU0k2Lhw7BM3HRnEZc/P6f7iZeniUpdaoHU+z0XSC90kSu7DJmu
 vK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791829092; x=1792433892;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sTqXbDBaN0X4bkIx38SwJsII48e9h6LTI2mEy3hMK1Q=;
 b=dYNOopeEX5QURfzgBkFf0BsosTghzx91Nh8g2jiE074Q5T1cZev+82ctkDxx4p4GU1
 fxDPClvUWafKtnHjo0ghrbSjxgVjHzm4tMfmM8AFGeK4az/05+D8F77bUAj6WUj5uiKQ
 f56+yuBtUAdzB4EfIWThDRM4OocoDlXCKJIKYs2qZaKTADE1dEHfHi5U8KrVx2AQk2Jq
 nbyCE7qJWPM5Wvj+FtiTOBZFdff7CSdYqVrYWc0zFaEwxRWIlD+YHQYnLNM94BFZZyR/
 84d+soJMfceOpCKZMbaVbgJVP7uIIBoiIbZexI5GoJohWMocoLNFaIez536PcH0IQM9e
 +oWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiOOgYvcnC56e9q/MySBnJ69P5FqiWtIwaF4nH+cXpmknwe2SH6xqRb5MQR3LR2zcLQvEpn9HkX5k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYgF8pkoj1Br9uEuljkOS0/HEeerXryulQS0GLK0hosUdrIN28
 mvP+Vj9NLKHKtRFnuk1Gf1ROpgx+v8uBPSgwZ4sdU8+vsa8MrLpMxbsIdYVIlSxi0wWMd3ciwoo
 pyFKjERh3XUdAomFPkaaBxs9ku/KXXRIrb8ss62OBGQ0DvGjv0mk5bsfdqJgkTZmbyuK3+KU=
X-Gm-Gg: AYBFou2rjrDFYrrSGV3dtQeMYIDOPcfKCfYQsSrVQ4R3BHBgLGGOKMvqSCAkEnRdYTk
 hvUnEvMueWni//h/g6YTAiu4c893PVURWIIvXgwEEftJ5Pjgy5/zRD3r4XdMJlCM23CBVMlf+zt
 ACs1NoS1gDiXnYZwftPk27+Wjdlb00yaXl+5dnixRVlOFxC6a8n0r7L4OYvKIQ1Y0C9CH/1t0sL
 /HzEJ+redCC1GaHhbX7Q7aehLNl1Wsl0Ydkez5+r0gqe83S5rS6pHk3C6KcYoSap+R8bgnnSF7F
 9qgZAifHuwqBjz9PDdTb2BosFDHD5IE38cjaj1bqGdyzGGyxnsRig1cJGblvSssAAunslsbfWGP
 sWjATK0w4MQZbb+ZfTWTG4R/bfZP/
X-Received: by 2002:a05:7301:71a4:b0:35a:4ad6:d215 with SMTP id
 5a478bee46e88-35a4ae61ed4mr5464314eec.22.1791829091436; 
 Mon, 12 Oct 2026 11:18:11 -0700 (PDT)
X-Received: by 2002:a05:7301:71a4:b0:35a:4ad6:d215 with SMTP id
 5a478bee46e88-35a4ae61ed4mr5464273eec.22.1791829090664; 
 Mon, 12 Oct 2026 11:18:10 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm22827311eec.31.2026.10.12.11.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:18:10 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Subject: [PATCH v8 0/7] Qualcomm Sahara protocol enhancements
Date: Mon, 12 Oct 2026 23:47:58 +0530
Message-Id: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYkzWoC/33Q20oDMRAG4FcpuXaXyXGSXvkeIiWbpG6w3dRkX
 ZXSdzdb0PbCCMPAH8g3w5xJCTmGQrabM8lhiSWmqQb9sCFutNNL6KKvmTBgCjhgV+xos92dcpq
 TS4fdFD52C+uUYloKRO72SOrnUw77+HmFn55rHmOZU/66zlno+rqSEjSTFKhhqmdUgZSio91rL
 GPKoR/sPNvHVEr/9m4PLh2PfW1k5Rb2Q/y7VS3omPEOhR5kMK6h8TuNQlPjVTNGBCsG8NL6hib
 uNdPURNUEWo+Gg0bFGpq8aYKqpiarpmwY9gAyiKF1N3XTEGhTU1XjFjVXzAkUtKHhr0YBdFPD9
 W7gGerBV0z8oV0ul29sE9kZjAIAAA==
X-Change-ID: 20260307-sahara_protocol_new_v2-662854773cf7
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791829086; l=7588;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=qQxpGCkmBrmToTnrtmzbPTnehdVr0DjcnfRo6PenOlw=;
 b=OCH5LUoUMuR+rabisWG4JgRmhP8Hx4wi2B0l45JwGA8FIu29L7ZCuZvTgPSL+iTUqOvpx7SS9
 uyCpYvJ70mVAQATZc5q08wd2WiFYnKOQ82nvqzRa24GxAGiSbYIVBqr
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX+7WQZCTilnQZ
 Z5Zd7pculXzSUBSf77AtxLLngd5W04M0QgkjqJCOdl3IfCieltL0KROtspcOtx1066zwBGRA0XA
 vJS6MnFAxI85KAUiGiye0QXam9Odwr8wCUU/UFaBU7UY9cV06qAhVUL4+Or67DLlJx5YHbRnlwN
 Yao7X4NE8X3O2KUBxWnrOg3a/Aa8MqLTBdxgBd/wk/gwsQqLPz8Gde/0vIdDsh+/jg6Wskvl9Kh
 J/sMI4/7cdvIhbxiEOU/CPtB4PATIjPZ/VGLVjeyErjyZtW8ywofU0i9dFJ+nCOcsNDbp6oauSk
 YV84XhqkuqJr7bwfO9nPXsr15xk70sQNA1mb0uSOl51tHbCJ5IMbme8PtMaJ0oD9BCtMZVO7fIm
 Lw4E/nmAchEBv0nplP1S7iVdTSAMTVKlD6L+lPCd8RuOrIWgcZJWzBBQALz984Hg1KibYiaDx1p
 Kn0NIHf7oXslI2R3wqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX1BQw86ojyi0f
 kLLzMSCvGrJExm1afzlbQ0etxMPOfkI8s6uIa4T4S7MFjxLZe1taLPPCwbIScfA+nYWb0DCo6ah
 83hd+riuH21fC6MwlbaFCyf1k2xho9I=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd2464 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TZsl4NGrXgOhBUOoEegA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Om0ObWBvLc8_rWwGZCzy8qmMkKdBN4pA
X-Proofpoint-ORIG-GUID: Om0ObWBvLc8_rWwGZCzy8qmMkKdBN4pA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120072
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
      drivers/bus/mhi/host/clients directory.
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
Changes in v8:
- Rebased the series onto the current mhi-next branch so that it applies
  cleanly.
- Resolved conflicts with the MHI host client loopback driver and retained
  the existing Sahara functionality without functional changes.

Changes in v7:
- Addressed review feedback by correcting documentation punctuation and
  removing an unrelated formatting-only change.
- Passed the QDU100 Sahara firmware mapping through struct mhi_pci_dev_info
  instead of selecting it with a device-specific conditional in PCI probe.
- Clarified the userspace persistence filename for captured DDR training data:
  qcom/<fw_folder>/mdmddr_0x<serial_no>.mbn.
- Link to v6: https://lore.kernel.org/r/20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com

Changes in v6:
- Used BIN_ATTR_RO() instead of struct bin_attribute.
- Link to v5: https://lore.kernel.org/r/20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com

Changes in v5:
- Sahara protocol documentation is moved to Documentation/mhi/ directory.
- Sahara driver is now moved to drivers/bus/mhi/host/clients/ directory.
- Squashed v4 patch 3 with v4 patch 5.
- Squashed v4 patch 9 with v4 patch 8.
- Firmware image tables are now moved to respective MHI controller files.
- Removed redundant if-else conditions when loading DDR training data image.
- Corrected commit subjects and messages.
- Removed Sahara variant structure and introduced mhi_sahara_fw_table structure.
- Link to v4: https://lore.kernel.org/r/20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com

Changes in v4:
- Updated the series based on review feedback.
- Link to v3: https://lore.kernel.org/r/20260310-sahara_protocol_new_v2-v3-0-994ea4b0d5ad@oss.qualcomm.com
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
Kishore Batta (7):
      Add documentation for Sahara protocol
      bus: mhi: Move Sahara protocol driver under MHI host client drivers
      bus: mhi: Centralize Sahara firmware image table selection at probe time
      bus: mhi: Add QDU100 Sahara variant and firmware fallback
      bus: mhi: Load DDR training data using device serial number
      bus: mhi: Capture DDR training data via command mode
      bus: mhi: Expose DDR training data via controller sysfs

 .../ABI/testing/sysfs-bus-mhi-ddr_training_data    |   19 +
 Documentation/mhi/index.rst                        |    1 +
 Documentation/mhi/sahara_protocol.rst              | 1241 ++++++++++++++++++++
 drivers/accel/qaic/Kconfig                         |    1 +
 drivers/accel/qaic/Makefile                        |    3 +-
 drivers/accel/qaic/mhi_controller.c                |   61 +
 drivers/accel/qaic/qaic_drv.c                      |    9 -
 drivers/accel/qaic/sahara.h                        |   10 -
 drivers/bus/mhi/host/Makefile                      |    2 +-
 drivers/bus/mhi/host/clients/Kconfig               |    6 +
 drivers/bus/mhi/host/clients/Makefile              |    1 +
 drivers/bus/mhi/host/clients/sahara/Kconfig        |   15 +
 drivers/bus/mhi/host/clients/sahara/Makefile       |    2 +
 .../qaic => bus/mhi/host/clients/sahara}/sahara.c  |  515 ++++++--
 drivers/bus/mhi/host/pci_generic.c                 |   41 +
 include/linux/mhi.h                                |   17 +
 16 files changed, 1852 insertions(+), 92 deletions(-)
---
base-commit: 0b1883ca75c0005ab5ca52c7bc1a26329bc39746
change-id: 20260307-sahara_protocol_new_v2-662854773cf7

Best regards,
-- 
Kishore Batta <kishore.batta@oss.qualcomm.com>

