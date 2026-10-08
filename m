Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04860CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4585910E74B;
	Thu,  8 Oct 2026 06:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZ+AobiK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OV92qCLl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AFA10E74B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:23:57 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BqF6928943
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=y4CWLeMlcNA3kcl98GrNo7
 h04JCowte9f/wMLBQFExE=; b=BZ+AobiKdWMrMA4qugJC3F5+M+m73Nwkf3Vu0+
 j8Xl7hHal4U2a5ND0lOq2sBc/dKLkZT/BQ1VJJc+pqeo3kfiwsLIf0Hda76HEYYO
 W32angPKpJX4MRl7nT21OPnJp1+Ga8nF0K+6NNRZ1F2VJhaq/ws6ew9vUHpkO3x4
 bt9OdmCLluaWLap3/Q4sQFxgNPkX0PvZJ/qRSVl8BzMyumse/dhtmndJd8PC7zha
 o+jYDQiOdMi6a6gh/qg+15Lo1l0rf6cKMhFOUc5u0iPwS/vebcJ4ITGLbcxHDw00
 A1XeQEujHaGuD6w7C7DxDb8k+COODSc8lh4tbLd6Oe8Sp4pw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2sekb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:23:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a4aa263a4aso5041616a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791440636; x=1792045436;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y4CWLeMlcNA3kcl98GrNo7h04JCowte9f/wMLBQFExE=;
 b=OV92qCLlQvvLidrSnRA46XI3XQ3Koq4AsGlEgH/EVFdZjnB9rLLTIa60OBs43lbr2o
 ZCdpiUQ+GV9lsT2wUmt+Je4RGvK4/ELayxSF6UTWreaXp1VzhcZq8EAmyqyudVgCym+n
 Hwn/MkjoLvQp1x40ub15BF1ZaU+7ccTPJbG87xoNDRLu/bqgCIYAGZty/KbEHlz+FLab
 YBwBR9KKxN1IPHQd8D+ne2MLGszjsGYhe7hF9dQNJpVwSieIETZiAMhRp6+QrGQ/17im
 wpZivAvW4dJDZJwyQS+5PzaUSplvO9OubCBDa43pnDxyMPA+Q1ja8lOFBZ4wtqcrG5/M
 Y2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791440636; x=1792045436;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y4CWLeMlcNA3kcl98GrNo7h04JCowte9f/wMLBQFExE=;
 b=aRCEGlZ3qF7pfaFJcSkXAVJ3XnwA8143GfyXGZ1vZsrT2AMUWiYOPDYgKG8hPsklJv
 b6pVaMfHMGvVZzASO835NctV0NjBiYsEsCTsgjIIUALzH44A+3e0wxRsKObG+nWNP1LB
 zdP3njqecSHd7AubrULfSShQo/tnr92JKnBhIuqZyJYoIz4lQDEVK47sYNtIFcfCYcTY
 Xk7qv1xYvJcalC807LY0ZqBh+pJfgszk9g7UpVEaIxBBxSa0s3gNbrHHx28ITbai3f4z
 R7cqaAVoWNSjCGyjyZp+CAg/T3O5rB6pdPDPsboxeD0/smTytJGDoXOg//1+IV5cBtoW
 Ra8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPsdrE54nOQaAodTVZJ5e/C67SEQF9UUe02pgjxf/hoT310qWRRMdhDiMMzRUoku8El80bUhzptyc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLDfhJGPBjl5AxXbPJjf1p7A1aPpoDtIAAS/rV8zjl8DrV31XET
 G+ddJjBzcEubMfJH130F644glyJPpY3fKOUCu8yOqivDtnNvZB4tRSmxvCbQl/HB/wQYPGhxaNf
 tunT5KA0Dv9FQtM8e/sTuEpcH53ndxp1FPb0BGGU8T/zodm4QNr47F474FyRHro5rQh29/4c=
X-Gm-Gg: AYBFou3NW/0hl7aUt2OksYKhUD981XJC16mvs4i/vF+v6yoDDU0JDFwFH9XUu4S9peS
 x+1SLgLKo6tMQ/p/gcmM3PkPKEbgo9x1LGjUXVgFsV6IQwFlIxpFsPSLSxda6OAb87PZcHj42B8
 ZWmqZqeLq4zhJB/LnU3NGmsEoYYwrdiL+8h+M9uvsUf87wjx+ggrbZKZLyITxqctVwMLwdvLjM0
 C6FAnbz546/iins+EBr5hM0CKhHzPA+/sUUg/CAi9GRN18pdGy7366cvtxZWXSrOkC8n8Ywus1K
 ZUekPHPZ7lnKKpzv5bX4uyQEZwSOrmimEJ+NH8o5QSCHgp5mX0x0C2O3VwQDlHcDNtVHKCCYiWJ
 K5DNDvIVQKaUp+TF6tHPBBPHPxCEX
X-Received: by 2002:a17:90b:3ec9:b0:3a7:82ef:bcdd with SMTP id
 98e67ed59e1d1-3a8a1b941e5mr3942982a91.41.1791440636366; 
 Wed, 07 Oct 2026 23:23:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec9:b0:3a7:82ef:bcdd with SMTP id
 98e67ed59e1d1-3a8a1b941e5mr3942968a91.41.1791440635818; 
 Wed, 07 Oct 2026 23:23:55 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9ff7ab034sm2767618a91.4.2026.10.07.23.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 23:23:55 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Subject: [PATCH v7 0/7] Qualcomm Sahara protocol enhancements
Date: Thu, 08 Oct 2026 11:53:44 +0530
Message-Id: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPA2x2oC/33QwWrEIBAG4FdZPNcw6qixp75HKcEY00h341bTt
 GXJu9cslN1DLcjAPzDfDF5I9in4TB4PF5L8GnKIcwn64UDcZOdXT8NQMuHAFQjQNNvJJtudU1y
 ii8du9p/dyqlSvJWotXCjJmX4nPwYvq7w80vJU8hLTN/XPSvbuzspoeWSATNcNZwpkBIpo28hT
 zH5prfLYp9izs37hz26eDo1pZCdW/kv8e9V5QHlZnAa21564yqauNMYVDVRNGPQW+xhkHaoaHi
 vmaqGRUNtB20EtFrxiiZvGjJV1WTRlPX9CCA99rV/UzdNA6tqqmjC6lYo7lAj+0Pbtu0HOstLM
 j4CAAA=
X-Change-ID: 20260307-sahara_protocol_new_v2-662854773cf7
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791440631; l=7357;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=jd9PcWpk1n8AimGZ1zhzk4oE5h4on7nfC13PGzWnQ1U=;
 b=m2McEMgDVVDvpL5ULKigxlctq5baEg4zKzJmwQ37k14b60fQvG1FIXoE81I4mmUeVyXOWwc1f
 fpO5TLNAF9HAS+UFOwq3rw+EOTXd9FN+DHNWGJGF6qaq1RspLSvo3F5
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNSBTYWx0ZWRfX/+KxzsqJ2R2B
 W1+2Bw/2613wl+/zVQfkeP+rfP+dywuOP3O9aUvUgL9cXMVSDkD0dRY6gvqZHMEOWrSRqerH4VY
 6AEqErwalCz48Ms3oLdI53LeaKkVIsg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNSBTYWx0ZWRfX2e1dNd4iGgwz
 jolg4fzhypZ8+XurLBtvmJCBOi07qOcCPckGrY6urU9WoxYzRay2oDRnu9mzQt9Gc/JNgloq/Hn
 0vHeI7Luiqhpo8kLdezu6hqNd73KXryeo78LXZr/qyLKqDxPnCq2X4ohQ15WGTnjd7T6terznIs
 rZ91nxuPfdRhmx5sc8vVIeqRHtNvwX9Iqd4xwC9rd2wnSWD3+FU2MINia9n7BQMExh/HYQxgOBB
 unEqCMZ6TTG7QK7mjAsXyaODrJ2cnC6ni92ydIN5THId0P753JE+Ju36/+jPXydQKPfMore/en5
 /rxggFSj7V6MhseemCxeJ0fJHSY1I2dVWanQdYSgFFPNZjMVMm9gvQZMNlWs3B2nS0yTzNCCgTf
 +XSSmJs5SnPnwNXSZUbvmx53PgotoSwzpZx+STQvueQ6P4yEsnIy95zsyRMMRj2BXVY9uoiQj1l
 jD2vccCFRIIZaQnkrxg==
X-Proofpoint-ORIG-GUID: rRgBV2q6FyKFXd4ogU9AM4lrzxv38zyp
X-Proofpoint-GUID: rRgBV2q6FyKFXd4ogU9AM4lrzxv38zyp
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac736fd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TZsl4NGrXgOhBUOoEegA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080025
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
 .../qaic => bus/mhi/host/clients/sahara}/sahara.c  |  513 ++++++--
 drivers/bus/mhi/host/pci_generic.c                 |   41 +
 include/linux/mhi.h                                |   17 +
 17 files changed, 1850 insertions(+), 91 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260307-sahara_protocol_new_v2-662854773cf7

Best regards,
-- 
Kishore Batta <kishore.batta@oss.qualcomm.com>

