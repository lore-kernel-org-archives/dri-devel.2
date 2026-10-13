Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EB5CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8B210F614;
	Tue, 13 Oct 2026 08:45:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B0310F605
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:45:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D469rM173800
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hm90XuSXOD/PEj13akjejZ
 9JjMmz/a4/47/QbvQQN84=; b=YKYZwFi9CecwqhxgzbRXHS3jHBHdl4WOFgiwqK
 aAndH9KLMY5kDzLETrWZk5i/z5INOGnAegeRildglOtYyFlUuH8AVX6TTt86bxOd
 iI329Jl3ihLBeQBAdi8/tvz+9ve10Jc5A5H4SIGeuc26M4x/fF9kz9mZyd3xsCG9
 S/aas/ST4ksaRDjySjySvPvirY6Z5dbFW0LqRGhdrC/kB+Fl1mQIA2X4DWNosZxB
 5DDKxa25ZBwiwX4n1IgRo+bOyhhipYVMr7JbmKJvQI9GWc1ZXg4+IEKhNhH5BZCd
 kq7PWtitmeR7eeuweNdRiQSlklfBpKL0i1wvqrd/gHB91PYA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqs240-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:45:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d5dbso3425819a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881144; x=1792485944;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hm90XuSXOD/PEj13akjejZ9JjMmz/a4/47/QbvQQN84=;
 b=AsuMQqjDp8K3Lh0VH2V0MKse31mLdqZo0ldSnRiS5IpYJA/K6htAczyhmdqxycePLg
 EHbuzFwhSzclz0TfOaNH7KhIMUn9IG7hujmEe1+WmL4FD8Rzz/7N3Jx7St4/AYiVSAzJ
 pvp5AFHxQOBRDG0UMoq0J39mfK72tA43U/3STRT6ShJD19Wa+qB07051qK7nyTUlyCug
 r/uZDVKNlsls1dl9TB5lWHO0NfED5RZazPJddlhW4hTf4y9wLakyciBkvqKBVasFbrfe
 CbOq7XAGMo00/CTWRy1MtXy7j1AoXiWvDTXZFMvioynXAUfZ0tQXtOys91aVHdPV1vU9
 l+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881144; x=1792485944;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hm90XuSXOD/PEj13akjejZ9JjMmz/a4/47/QbvQQN84=;
 b=Pp/qM6SWmvKCUSRG6CUL3fdXRo4GVUtPPkqqTu27T5NyVhfZr/yAw9CiCUIPPRFBf0
 /eMiNcx+q8bL61UTbWqrSfwe0O37AIBpAKbejlMBtsAlW3IwyKWOS4239YqQwfV6Qf8t
 vtonjwgpqelh2kDzDP5+I1yAAZhIyl0NSgnrigd+b/fNm1TDFzVcC5vhHQV1Yghgh1vw
 EsbEheMxzRVlYkplXjF4Wfd862LllUbOVQ/m7jTu/aNtuvsar8oa/iNDAy+b1Ni5GR1H
 8zF7s4sqc6YdXwA5gnGttcPv36zKPU6++5JIFEigW3U+VAcMNjViuQaqE+1Cw1JpUZz8
 k+2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYBijg4o2qSmQiOZdAmJiL1nqTdMB5BxAB7oY34OLACwqccYmPX4DhgXkSU825YhbQaQHp0vmetsg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLJH+cKESkU7aCQxvIOgvwBfpgCmhF4uxefD1VdOyKIZhfNNrZz
 7UqvrYXa40EbSBKXERkvnAq9r6VefGgWK8j/mZn9WXQfC3Gm3OoW8S75c6uL3sm1DiA66iuGw9Q
 iPE7T/PAzrmTR2tRqxoJYFtzkBuYy9QlR8KIuueo/e52wCjtGkfUApzGodMU8yW+NhHAG9O8=
X-Gm-Gg: AYBFou1MAEFVJvkkaq3e/tMFDXzHcMp7Vf/bzNvLwfL4v/bDIh9h+1PGz3Xn1aAZTB8
 hoOoH6+rqqpoBWkR9NF+s0jhviPqsdeqUs+KyFO0Wf46Ky672bk6oQK4y2FKwJwO0vN0/OpKB+Z
 215bWFrOzMGctKFGBJtz1x2+etHqmKlwg5RCSTQZW2l2QrlvSAvabyDNle8KQWMPbP3OSE6xa9j
 mzcfygu2Jg0lc7PN+MnsvXuF0GyfcHosOgjSavmDU3Xh4WwXTICmnuyr4Z1ELRaHgp9jMwCVJ/h
 E2PcJTXAf9B2C/OaoEWus8Jf9i2fdnXCz0uKbMjnpirQOE3vW4rG2X2/TcrcFvOBGPX7d1X+bIG
 CWmTmPNxua+0P2lEusCThcpB4MnrW
X-Received: by 2002:a17:90b:48c1:b0:3a7:e126:4980 with SMTP id
 98e67ed59e1d1-3ab3a79c42amr9217790a91.43.1791881144256; 
 Tue, 13 Oct 2026 01:45:44 -0700 (PDT)
X-Received: by 2002:a17:90b:48c1:b0:3a7:e126:4980 with SMTP id
 98e67ed59e1d1-3ab3a79c42amr9217757a91.43.1791881143688; 
 Tue, 13 Oct 2026 01:45:43 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5384721a12.31.2026.10.13.01.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:45:43 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Subject: [PATCH v9 0/7] Qualcomm Sahara protocol enhancements
Date: Tue, 13 Oct 2026 14:15:31 +0530
Message-Id: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvvzWoC/33Q20oDMRAG4FcpuXaXyeQwiVe+h0jJJqm7aJuar
 KtS+u5mC9peGCEM/APzZZgTKzFPsbD7zYnluExlSoca7N2G+dEdnmM3hZoZAmoQQF1xo8tue8x
 pTj69bg/xY7tgpzUaJYmE3xGrw8ccd9PnBX58qnmcypzy1+Wfha/dlVRgUHHgFnWPXINSsuPdy
 1TGlGM/uHl2D6mU/u3dvfq03/e1sJVb8If4d6v6oEMbPEkzqGh9QxM3GoemJqpmrYxODhCUCw1
 N3mq2qcmqSXKBrABDGhuaumqS66amqqZdHHYAKsqhdTd91Qh4U9NVE46M0OglSd7Q6FfjAKap0
 Xo3CEhmCBWTDc3caBybmqla5GiFDYjW/bXb+Xz+BmUHfnbaAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791881139; l=7797;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=rrKEbuNDjPAq4STCm2KriONXpsF5cCQEo9OyC6ZSkxU=;
 b=Y9oWS8XdzV++hBjq5f4GLgWvgDXLVF58H6pXOC8+FOQHE95pl1ws1xC1/GapAMPhDhBWzz8ni
 bAU1170HubdC5AtF96L6SnfcW5e+pdQvhTlwxT9qsY87sWokzun8o45
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: UneVOTTl2KzGjVLbTXTn5mDt04f_sSgj
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6acdefb9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TZsl4NGrXgOhBUOoEegA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfXy+5wrG2vG7ag
 ti3zU60CG/kCcX/sTy7A0JfnEvvzmUqEjaHonVt7dZTE63+QPnDp8M5iIeVo7g/riSu6cgeS1/F
 3l1cHuVSQU6vkPcNs+o9swVGyscsYxI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfXzNKumbdc8Okm
 USBpbVvlBwbx3ESSzZd5y9+mHndMer9GQOUbepXbsWbeSNSDgDI6QRQdOrJo2IwYIuJFdVfktAS
 FzYstYY8LQrWHxd3SNNuBWqTyXehnqTdSq+L/bINU9Q97WdpZRZTm2X3S41MJgchpXdRLyaH09R
 /iNs40aAqbpU6g7ACTTUzjqvWQxS3XwByKu3A+YeK0IkeLZLk5aoROcUoR/6NAV3FxTv5Xznrgb
 tLODthuyQEjRiQZNmhpY7O/qcbkpFOeDmZLk54ZhaT365NxcXG2F/k2M71Nk6Fk1kL2OVuZcXg7
 O0U0O6e70B5CSJQwcf01vIQkgEaXG8WzzPwFJdrIkakj+MDEyB6P1LtuPiDDcg/b+uFq79pP7si
 n/eLYkrTOMP+RE8BzaBqNbg6iqEy/+4fEkpa5ckSwAjNifusKWU4U8+2NxzPr9PMzoOzvQ6IVKo
 YaFgglOLNMfPe8fBFcg==
X-Proofpoint-ORIG-GUID: UneVOTTl2KzGjVLbTXTn5mDt04f_sSgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130034
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
Changes in v9:
- Removed the unnecessary linux/mod_devicetable.h include from the Sahara driver.
- Link to v8: https://lore.kernel.org/r/20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com

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
 .../qaic => bus/mhi/host/clients/sahara}/sahara.c  |  514 ++++++--
 drivers/bus/mhi/host/pci_generic.c                 |   41 +
 include/linux/mhi.h                                |   17 +
 16 files changed, 1851 insertions(+), 92 deletions(-)
---
base-commit: 0b1883ca75c0005ab5ca52c7bc1a26329bc39746
change-id: 20260307-sahara_protocol_new_v2-662854773cf7

Best regards,
-- 
Kishore Batta <kishore.batta@oss.qualcomm.com>

