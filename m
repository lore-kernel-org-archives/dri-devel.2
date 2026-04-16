Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1D1F8D74B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B267D10E8C7;
	Thu, 16 Apr 2026 14:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PBMUFr40";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4LU79LZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A2710E8C7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9DGdB1553115
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rNPRMykv23oAwhDft151ng
 7E4mitTBeNk5CH0mktHJk=; b=PBMUFr407VWqgbuTdMP0GBXTz7g6rFFncGS5yk
 4wtoOiotvizu7uHvZctvmm/n0IBaYp/q29ZtT+Q703lM2kQDxYaJhdDJeV/lrGi2
 Cwyht5Q7jgo6+FaLMUGKu+d7cEnlxnKF91VqxQKKa2CzEZuFtQXiY1ENFXHNm+kl
 T45PbkDjxURSvEzxTudBjBrqchWd9qfdia7Y557Yl25biA2E2jQHBfzlvGedoIuW
 cvbek5Q/gpP0uzzZBAq6c/PKTyYwcHbTmtxoWYSkXruaGT4tUy0n3pPM6xrca2v9
 D5gzKWLiMxei2s0YiMoztkK9SzvwpBkGEUCydYWsnuGLutvQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn9yex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:09:58 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-651b8f743aaso7638121d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776348598; x=1776953398;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rNPRMykv23oAwhDft151ng7E4mitTBeNk5CH0mktHJk=;
 b=P4LU79LZd1r3uYycEN8GrKuOrR1xVFcwiyXtNS2RfSU0PWiBPE/Mq26amH2qCG5C/v
 DueX3A6wKRyANcfU3tMbHXlHYC6jAq9xV98PcrdvSeo7kOUUjF8MpbMRQqWf1BNCnA+f
 ronEDj1TzmYbt4BYCeKVL6dPl+pPS2wxSyKjj4a7vV5ikXiyMxu0kQA+YVw/BdTrPNvd
 D8HuttmDs8nBB6k1lxP9cfdAVnF7cWxPcjGVtkyqdbV51tGr9jJNcEKNbggLtkRB7sw3
 dHooWNTrjdTepLFNY+VkPVzP5is37drdO+WfDjsWCLfR/MxJS83hUEBFNMccJ0fwy/Fl
 9cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776348598; x=1776953398;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNPRMykv23oAwhDft151ng7E4mitTBeNk5CH0mktHJk=;
 b=pqMuGBmP+q7Y0VJ1n55xO7bejuqAZ+u/7BNlzP0zRQwVpIqwEv/1APH8cU8jo/9cYG
 mkNhDL5eQzkwGjVhBFdhL+upOxWvOs9w20i4rqNSsHYNmVs6FSkGmQ2Z/M2voT8uGcaT
 LkDEd2Jq5jgTSvQpRxzGMt2Ec1LhlGTK12jB9u9CGKMzDplqT91a+uiHXDzP9wUTiRY8
 YbGxJKNFPTYAjs/mv/KGsLCSOWVrNPMMCDvegqKBthHoyKhGE/nmfvgfNUYrdjTpU135
 vMPVW52XTEzyBUVemQirYsmt4HVwp2Zktcyr0f2Wno5ocWXdviM/xgxN3hPvJVJqT8sS
 xfLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qw7TsNllr9nNYpXfqa/t3Q0Lyisl3zbSaq5QkJ0lWmDMrGPNMAT88C1Qx7Sd0qi4olCp/xTqjMk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6CRHVAiVy3I56JCENhRv8p1SsLkHB+qqGEaS1/97kol55dvW2
 xSBBqEg4w3xacJcmQZv0n7KbcU+ObhPeBf1tuRJpyOidAhGBnuAL0708xwnAVWW6XOEzx46/xgw
 cslmz7u8jvSjWr8yQZHgS2LnOFKYYgs9yl/JFSxoW7Lvm7UFZRKbGt3Fu3V5/H2kTOpM8Elc=
X-Gm-Gg: AeBDiet54/yywhZOEk2DZ0K5qpWjAAQZSrz2q95YFG7w1/9WRcL4w57V51lM5jeODWd
 Vumn2fsvYbSzDjt2nG306rnjUKux/E+AzG59KrcawE+2/K0qrGXTmw7UjKvOfPR4KuFzn7PHIpn
 20gaynDdZjBYJrJGoE23ZwBkEVeGRlC21nlX6oc0dWbjXtwKbwgbK21N9+twvQ8wT2u0dVNY5ld
 8bucGV1i1oVPzcz2AuGdbcFl15T+ln1IWUH4U9N1HVoBuuB5fJjB41mYRH680abuAQESsYLKMj4
 R4zrQBMa2yezIer5MTafZEQ8yWI/mxwedFOpficHeMKf5IZ5kaOmpMgPAFv9G1qc5RaqPTFeD72
 sCEq6zWEVvf15OcaWbK4i1xqBC0N89SD05YZeBWuHSmtdci++JHg=
X-Received: by 2002:a53:d014:0:b0:651:b2a3:89da with SMTP id
 956f58d0204a3-651b2a38b94mr17457931d50.7.1776348597872; 
 Thu, 16 Apr 2026 07:09:57 -0700 (PDT)
X-Received: by 2002:a53:d014:0:b0:651:b2a3:89da with SMTP id
 956f58d0204a3-651b2a38b94mr17457864d50.7.1776348597209; 
 Thu, 16 Apr 2026 07:09:57 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-652e47ba4a3sm2084691d50.17.2026.04.16.07.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:09:56 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Subject: [PATCH v5 0/7] Qualcomm Sahara protocol enhancements
Date: Thu, 16 Apr 2026 19:39:41 +0530
Message-Id: <20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXt4GkC/33O22rDMAwG4Fcpvp6DrPgQ72rvMUZQbHcxa+POz
 rKNknefUxj0YhkIwS/QJ11ZCTmGwh4PV5bDEktMUw3q4cDcSNNr4NHXzBBQQwuGFxopU3/JaU4
 unfopfPYLcq2xU9KY1h0Nq8uXHI7x6wY/v9Q8xjKn/H27s4htupEKOlQChEXdoNCglOSCv8Uyp
 hyageaZnlIpzfsHnVw6n5va2MYt+Ev8+1Ut4Gi9M7IbVLBuR2vvNAG7Wls1a2UgOYBX5Hc0ea/
 ZXU1WTRryxrbQGY1/aOu6/gBxLZRqogEAAA==
X-Change-ID: 20260307-sahara_protocol_new_v2-662854773cf7
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776348592; l=6650;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=/Z6SDET1n3uQ4yQOhMtBc7Or9vHHgat2+LcqDfWcUsU=;
 b=W0MiP0aNjz1nYn0XUijDKZ3QITvkUlAWn+R/TUYqW1+rxK2Bf04BICw+hyCuXrFnpR1qA/CcY
 CGYkV71ytdVC5QvVa8pQbgVNR7pIya3kC/hlsl42PvBMkUNtQYcLDa7
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-ORIG-GUID: 0DAxcW-NpIeez1v3HgfAxQNsFBZVYmNF
X-Proofpoint-GUID: 0DAxcW-NpIeez1v3HgfAxQNsFBZVYmNF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEzNSBTYWx0ZWRfX2hWWz3T7M0Tq
 Cals5pV0AlUTztrIdJJrSTlIaCwCScaP62DBYqsK+xoc+TOZFV6SNyrtS1GT5XGAPe5oLz3YeYj
 Fe8APqddFKeq/IfN9AbgyDlRJXxxqyMJRcvhJJMBVKHvX4NZnl4dHIGQK1lje4A4WdGvIAtjSCI
 jFGnAyrWpQtUjPbTue7lVKfhHK3KyLeJga7iWsobpwovEzQykZ12WiMq+83yMH+EhWlFLe1f7Kk
 OpV0giub6xs8Hy5ujxy9DFXEfese04H/xgOWWCFJNPJzeNwFqZG2B2MNgGPx5w1dQHN0dygb2lD
 WtX2iGYyFKUarDYDO6cwRknuPIcO8nDVQsVKsgNGALR00lp3H3AIuJyKbtfqHH7OhY0bs77NGWR
 jgss6QnMv61OFlXS3XJ9N/rHpHm++1V5kyEcvyquVKhjekRoVX/OMVUWeIu8Ub2ttIYqY4t/Ban
 hwxv2Y+wenMVTcnRuNQ==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e0edb6 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LaHGMCMnodEAC_t7lLYA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160135
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
 .../qaic => bus/mhi/host/clients/sahara}/sahara.c  |  523 +++++++--
 drivers/bus/mhi/host/pci_generic.c                 |   45 +
 include/linux/mhi.h                                |   17 +
 17 files changed, 1863 insertions(+), 92 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260307-sahara_protocol_new_v2-662854773cf7

Best regards,
-- 
Kishore Batta <kishore.batta@oss.qualcomm.com>

