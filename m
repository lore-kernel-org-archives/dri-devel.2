Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBDBC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9291310E12D;
	Tue, 21 Jul 2026 12:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n2Y+dUZ5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC4610E12D;
 Tue, 21 Jul 2026 12:25:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2364343DBA;
 Tue, 21 Jul 2026 12:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259261F00A3A;
 Tue, 21 Jul 2026 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784636712;
 bh=7RIDjjRxBZsfyy8sFhNIVwR6ULTo0+knadoUpWE3dDs=;
 h=From:Subject:Date:To:Cc;
 b=n2Y+dUZ5ZiApd5hteZ2YLJQSrdVH8zQcLBuAb4bHTk6CXVO1xMyQguI3SghibRjaX
 ezVO5DJw3s95xbYVTPrfOibJoNUW5I13bZOAb/wDc/eTm62DRvsmavxd38LZzstbON
 qySD6Z1H55fkTYo8daigWZF6sSPXpzpTTGXO5MlB25G6WcvDX9jpdPfK/Zdthib53a
 17HfbRz5tZQV4SgFShc+TVfzd3sqWJsFtT65X2fUTy106pmyGc7s7u1c+6jPq7kGch
 lvVTRtV14kxiAyk9avQAojZRbPCv7Tj5ZB2bjNyuznJbw5c0zlg+pSGMkh0tfOGx4X
 IKbOS5JyV3EIA==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v4 0/2] Retrieve information about DDR from SMEM
Date: Tue, 21 Jul 2026 14:25:03 +0200
Message-Id: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33N0QrCIBSA4VcZXuc4OnVbV71HRJi6JuRcukYx9
 u65QdDF6ubAf+B8Z0LRBGsi2mcTCma00fouBdtlSLWyuxpsdWpEgXJgUOPB91bh6Iw76yCdwoK
 JklSlVJXgKJ31wTT2uZLHU+rWxsGH1/phJMv2DzYSDLhmmgNXmvO6OPgY8/tD3pR3Lk8DLeZIv
 xwCGw5NjjZSE04FKwn74RQfRwCBasMpkiMugumGVxJIueHM8/wGvJcfqEcBAAA=
X-Change-ID: 20250409-topic-smem_dramc-6467187ac865
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784636706; l=2834;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=jc3TUUzkVbI2veih/+SNxve1O/lLtYZZZpQ7NQBRsg0=;
 b=k/2EBGXWQY+ZrJyG1jMEEXXmeDHNuSjWgwmbUrX9BYrb6aiW31ei5l37R80JR/0E4JoKJd5i+
 9YT2wLHBrKcDmecl+0eO+8BwNPaseZU6XKC9JJ+A9F4RkvheGFMSZet
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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

SMEM allows the OS to retrieve information about the DDR memory.
Among that information, is a semi-magic value called 'HBB', or Highest
Bank address Bit, which multimedia drivers (for hardware like Adreno
and MDSS) must retrieve in order to program the IP blocks correctly.

This series introduces an API to retrieve that value, uses it in the
aforementioned programming sequences and exposes available DDR
frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
information can be exposed in the future, as needed.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v4:
- Rebase on top of Dmitry's cleanups to ubwc_config
- Mark and consume the shared data as little-endian
- Fix compiler optimizing out what it thinks is impossible (odd
  v3_14freq case)
- Rework qcom_ubwc_config_get_data() per discussion to not alter
  hardcoded data
- Remove some unnecessary comments and assignments
- Return -ENODATA instead of -EINVAL for out-of-sensible-range HBB
- Cosmetic/line wrapping fixups
- Drop applied drm/msm patch
- Link to v3: https://lore.kernel.org/r/20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com

Changes in v3:
- Support v6 and v7 DDRInfo (v7 is used on e.g. Hamoa)
- Handle rare cases of DDRInfo v5 with additional trailing data
- Rebase/adjust to SSoT UBWC
- Expose hbb value in debugfs
- cosmetic changes
- Link to v2: https://lore.kernel.org/r/20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com

Changes in v2:
- Avoid checking for < 0 on unsigned types
- Overwrite Adreno UBWC data to keep the data shared with userspace
  coherent with what's programmed into the hardware
- Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
  branches separately
- Pick up Bjorn's rb on patch 1
- Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-hardening@vger.kernel.org

---
Konrad Dybcio (2):
      soc: qcom: smem: Expose DDR data from SMEM
      soc: qcom: ubwc: Get HBB from SMEM

 drivers/soc/qcom/Makefile      |   3 +-
 drivers/soc/qcom/smem.c        |  14 +-
 drivers/soc/qcom/smem.h        |   9 +
 drivers/soc/qcom/smem_dramc.c  | 430 +++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/ubwc_config.c |  40 +++-
 include/linux/soc/qcom/smem.h  |   2 +
 6 files changed, 495 insertions(+), 3 deletions(-)
---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20250409-topic-smem_dramc-6467187ac865

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

