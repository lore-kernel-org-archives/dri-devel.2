Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41922C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2338410E220;
	Sat,  5 Sep 2026 00:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="akehnKhJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B7110E220
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:43:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B7AE44798;
 Sat,  5 Sep 2026 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257B81F00A3D;
 Sat,  5 Sep 2026 00:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569021;
 bh=qbbRnGZHv554hURoONAoGhOQATKlzf//UmJVmXKjiKI=;
 h=From:Subject:Date:To:Cc;
 b=akehnKhJQx/pohIHSILweujurCorVVzR4LUWm/9wf5pingxJAYDEsN+rAm+F2vjMn
 PhKHItU4M/NWzrThcAEvvDge3tqV2PjlJ5I2B3Ln0/smmFKVGq/EDibqtsKXbJ0w7Q
 vPwK17ZLu/9163jKLvm6upqlsq1uXlZPYFeD99dDl0UzWSZGXKSrabAhmt6fp52J3I
 Z2X/KpptDwIVg63bILn/YncfmiInTY0EOtamrusRaEzKaR39pJHsy44bfnu2pogu35
 ZaRMyeS/qpfyuv+nkULZRfV+PAcYRlvhjnFhokO/Gy1Q99MnDKPJwQF76FR/ihmkQc
 TYowbzWQpe9fA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v2 00/19] accel: ethosu: Another batch of fixes
Date: Fri, 04 Sep 2026 19:43:19 -0500
Message-Id: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBREr0L+2ppSFIor72FYYB2galrTD0RDu
 Lstrl2+zLyZhRjBgumULRQwW7beRVC7jMzQuh7C3iKTkqqUWlUC4+B5Ep19gwVw1IUuUUspKSq
 vgC2IxqX5MU/XO8yYNlJjsDz68Nn+5jz1/kzPuZCiOJRdjVZXdW7ODwSH596Hnpp1Xb+wzA3ru
 wAAAA==
X-Change-ID: 20260827-ethosu-fixes-ee58386e9000
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

This is another series of fixes to the ethosu driver. It's mostly probe 
error paths and cmd stream validation fixes. It's a mixture of 
AI reported issues, different solutions to other posted issues and 
fixes[1] and my own fixes. The last 2 patches are additional operation 
support.

The series adds rejecting OFM tranpose in cmd stream, but then 
the next to last patch adds support for it. I did this so the rejection 
can be backported, but maybe supporting OFM transpose is small enough 
that it should just be backported too?

Rob

[1] https://lore.kernel.org/all/20260717061145.1478139-1-zhaoguohan@kylinos.cn

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v2:
- Dropped first 5 patches which are already applied
- Patches 11-17 and 19 are new patches with more cmd stream validation
- Add fix to diable clocks on PM setup failure
- Rework the runtime-PM to suspend after initialization and before 
  drm_dev_register(). This simplifies the error clean-up in probe.
- Handle quiescing jobs before scheduler teardown
- Rework the cmd stream register initialization tracking to use a bitmap 
  of registers instead of relying on initial state values.
- Handle U85 DMA 2D/3D modes correctly
- Link to v1: https://patch.msgid.link/20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org

---
Rob Herring (Arm) (19):
      accel: ethosu: Suspend after initialization
      accel: ethosu: Fix probe error cleanup
      accel: ethosu: Disable clocks on PM setup failure
      accel: ethosu: Quiesce jobs before scheduler teardown
      accel: ethosu: Move DMA mode to src/dst struct
      accel: ethosu: Track command stream register setup
      accel: ethosu: Factor buffer bounds checks
      accel: ethosu: Validate secondary streams
      accel: ethosu: Reject unsupported commands
      accel: ethosu: Validate all feature map tiles
      accel: ethosu: Account for feature map element size
      accel: ethosu: Validate convolution parameter
      accel: ethosu: Account for kernel dilation in IFM size
      accel: ethosu: Reject reserved command encodings
      accel: ethosu: Validate accumulator input
      accel: ethosu: Restrict dynamic IFM2 weights
      accel: ethosu: Split U65 and U85 DMA length validation
      accel: ethosu: Validate OFM transpose
      accel: ethosu: Validate resize operations

 drivers/accel/ethosu/ethosu_device.h |  23 +
 drivers/accel/ethosu/ethosu_drv.c    |  23 +-
 drivers/accel/ethosu/ethosu_drv.h    |   2 +
 drivers/accel/ethosu/ethosu_gem.c    | 813 +++++++++++++++++++++++++++++++----
 drivers/accel/ethosu/ethosu_job.c    |  28 +-
 5 files changed, 798 insertions(+), 91 deletions(-)
---
base-commit: 2b39d680c9e0fb4d625f2916980977622e84248c
change-id: 20260827-ethosu-fixes-ee58386e9000

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>

