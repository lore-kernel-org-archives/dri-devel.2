Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BECC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A5910E357;
	Wed,  1 Jul 2026 10:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DABVRlaG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgoLZn48";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3E810E357
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:37:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8WCs680973
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qoHqC950ogxUMx6e6GrPOq
 aJXyx0r3zT5fgO4h24QqQ=; b=DABVRlaG3BOKP2ZjtYjL9MvR+gJMBxCrF8BUr/
 c9VH/lQ0+xT6XPrvo8VgEC8AbDRBAhoMY9u1ua43Q0XNmrJSZ2XAGQFcwtmBSZMn
 K+ZvQ94yMuY4HYFL5OTWuzD2KsTsFMFd6a/7uGO7EbU/N8AtF5QaPZItb+AFCfT3
 /8+huTQfYuH6406Mlzc5Rvpsw4mUI5STGT/03CVPotLPWQsY0xdfVS2tMuRDYNHH
 4Hi/cH9klZ/phkoRxEfs/hvHQS6DOPYlqJn+qYzNEArHZaVg+F+d0m3OweG5MtV+
 JZ4hXF9POXSyfW1zX0EpMXGW7gnS0/9m45QFvNc3m6Tcsadg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3skq3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:37:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so957154a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782902268; x=1783507068;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qoHqC950ogxUMx6e6GrPOqaJXyx0r3zT5fgO4h24QqQ=;
 b=kgoLZn4857HqdYRUQZcCiS0Umyw40x1ILwZbB0X+TBAor9QlYWdhavUsaqQtxycuKS
 QbhBRgB8kwErd7AwMtJXYAP+I+f0n7CJxE6dZ+Pzx44E1Llv1pf/En9vuMr1xVE8z/H5
 n1jK5u+AQWAgTw1DuytP5cmN8EnMmWQSfqnyBAUUuhOzr9lgi9/VwVWipSqawJmCM0Hj
 YlS1WiqRtH0eJnbctCWI3XL3iXqbYf021I5dmGrrbJi2bPbAtM1xBTJ1QXasHVJ2oSvw
 jkZblrGVyWRDCGYy9o84jf3mVMAgAmWXBol7hlMXQJOrBQ2nSiG0YePhuvTEVuJmBj8U
 sASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782902268; x=1783507068;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoHqC950ogxUMx6e6GrPOqaJXyx0r3zT5fgO4h24QqQ=;
 b=bjHhfjGxGN/72L0mlYDD9rhpgOxy7SnDl0DXI+rGm7Q5eropxIIN4IB4Qg5InE1J/N
 DAAKnFq3eCBrGvmXRHMyHkjR9a11SQZ+5ssFEL+8lzEBP+HKeKMJ0YXHv19EyrC4W9r9
 3oRpVaWCjquKVH4L5lr/xOkI7EEH5UL5K2pqpOWYat2WHPyp7EittPySJS41UWW61nu/
 Et3PQB7GnDivTKgDYvdQruojUWw50J0nnrLQPQovR/I73hO6SL2X+MXiUqPX/w6/eJcc
 larTuKW2XTUT0ocpjZQm9GE8QUr2MYQbmRnTgqiplTlKNFnKFWlP77iwlPK6kdguDcYk
 turg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTXV60vSaJhoChasUuwSzJd5QPCmygYczdBRGWrmsYhfvmlPlDRml0kfoUqV3euEZJqAwMmuWdKgA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYJkeTfYaklZcxzrLYb+GRFSdijhHiXmSMxIv1RSempvPk8omt
 skGo6s8BY/Ieq77lDhMHK96jWwTUJW8epgRmUyQbGDrzMMcYQOawkViUMkx48/92U1snLo8x1em
 upcQv/Vl+8+VrrHo3OrvbwW/Mz7X9RQdLcBCHjT+YlJ9oVwyR8mDWA6YnxUyxjg4ctt+2W+M=
X-Gm-Gg: AfdE7cnoeco34Lx5/7jeUzpsMKhfEEscBHZ817VoZ1ipSA8Xec4I6kj4p6zORXOpgIi
 nMg/xHiEG5RuZhrXc4k16lIlWcrRy/EaoL5rCkX59a+UB6n/zNNsQ4Nsraldz1N56VKNTcVP7h9
 FLq1ycUrXfwrr5j8I2KVHeIihBozJNkGCYADXY0yuB74gjoPlSURcpgypBtAWhC6zMIAuRQkCZO
 eZYfBkXIxfltNDZbm1S+Jqaz5jKa8rSA5rEvuC6aTIdbm2WCJjFW3Dx3mKy6Z/GXrDembWJvFgS
 xlrYb4X/qKzUjXxKiHVhWuHA6pVGuhv5bzILx4ajGly0hjEuERBmZJ1w2GU2W1MkXlnIKlsiCLa
 +dSmt4r1AanCrcuEU214qvsGwnIFbCWN+EF1i2t1g
X-Received: by 2002:a17:90b:35d1:b0:37f:ce2e:32ea with SMTP id
 98e67ed59e1d1-380aa184bcfmr1270483a91.19.1782902268258; 
 Wed, 01 Jul 2026 03:37:48 -0700 (PDT)
X-Received: by 2002:a17:90b:35d1:b0:37f:ce2e:32ea with SMTP id
 98e67ed59e1d1-380aa184bcfmr1270450a91.19.1782902267757; 
 Wed, 01 Jul 2026 03:37:47 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095bc8a2asm765251a91.0.2026.07.01.03.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:37:47 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Subject: [PATCH v6 0/7] Qualcomm Sahara protocol enhancements
Date: Wed, 01 Jul 2026 16:07:34 +0530
Message-Id: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7tRGoC/33Q22rEIBAG4FdZvK5hNB7iXvU9SgkTNY10N241T
 VuWvHvNQule1IIM/APzzeCVZJ+Cz+R4uJLk15BDnEtQDwdiJ5xfPA2uZMKBK2hB04wTJuwvKS7
 RxlM/+49+5VQp3kmhdWtHTcrwJfkxfN7gp+eSp5CXmL5ue1a2d3dSQsclA2a4ajhTIKWgjL6GP
 MXkmwGXBR9jzs3bO55sPJ+bUsjOrfyH+Peq8oBy46wW3SC9sRWtvdMYVLW2aMYIj2IAJ9FVNHG
 vmaomiiY0Om1a6LTiFU3+aoKpqiaLptAPI4D0Yvjr37Zt+wZo4bhx8AEAAA==
X-Change-ID: 20260307-sahara_protocol_new_v2-662854773cf7
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782902263; l=6830;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=vy+N8rR/U3qscov4uu/VMgbY2M3N108yYGXpT3iP1dI=;
 b=ikt7MflyMLirUid2ofbzcKYtIKTCIMEFBHlq8QGgBLAIzEvneHdRYEHTDka40K5f1qslKFZIi
 5Aae5ntG34tB7ttQ2xfesFlbOyFmO08H/35HV/LmzUepNkrPKBLvDr4
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: sbWerbelQXLu4CxeIzuWutx_x1xIQUMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfXzRCtUfhGFVEF
 +kSoTV01nCVwuQHYDcQTrI3wLjKjHxNbE9UcCTcZoB6qQxGxiDeGHYmGD9jQqwzxFb0eb88deGc
 PMjcSl1gIwr3WeEZYei26Q35HhqtGRjmm9oq9fhw4Vyc0goTTWtj3SmY4APJg+vnAb2xScLUl9J
 xgHvCF0uO8SRx6xb2q9MDuSt4p4gsM78w/9PUKAZ3dh1wbacHPefWxkFYiUY43LxImMAF9Yac8X
 AJy/SI9TwTcNfGJQTYfXOF6lRf5nb82EUxsUHRZ1QwHUQ4XccO5UVVoBsZwr+/vUYUrAvX6MDdN
 SfR7W3/qUUVWVHzZQ48ka4JhevAdHOfjDwvNryWQPhB7FKHBGkVznu4f/sDOWwpJFd685KfB02a
 htERvkv1hIVyBByCYJxEi4xDBv13/AHSmDDvC/EXoRtzx5cPd8Bw8fX5fy36CCC79jRNscwf8hy
 A8C3jiWStFPVClsPPNg==
X-Proofpoint-ORIG-GUID: sbWerbelQXLu4CxeIzuWutx_x1xIQUMj
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a44edfd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LaHGMCMnodEAC_t7lLYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX8bcrK21Q/SLo
 3EnTq3sCbWHZ1QlJqx552IyuHO8TwwGQSvvG4c3p+xzTfY+r3eJHtmUvCGL1Cf+STntc0YHRNTg
 O1K5i/R0iAigK7WN83T7l1KG0QXjRlQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010111
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
 drivers/bus/mhi/Kconfig                            |    1 +
 drivers/bus/mhi/host/Makefile                      |    1 +
 drivers/bus/mhi/host/clients/Kconfig               |    5 +
 drivers/bus/mhi/host/clients/Makefile              |    1 +
 drivers/bus/mhi/host/clients/sahara/Kconfig        |   15 +
 drivers/bus/mhi/host/clients/sahara/Makefile       |    2 +
 .../qaic => bus/mhi/host/clients/sahara}/sahara.c  |  516 ++++++--
 drivers/bus/mhi/host/pci_generic.c                 |   45 +
 include/linux/mhi.h                                |   17 +
 17 files changed, 1856 insertions(+), 92 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260307-sahara_protocol_new_v2-662854773cf7

Best regards,
-- 
Kishore Batta <kishore.batta@oss.qualcomm.com>

