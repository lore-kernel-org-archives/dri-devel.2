Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18398606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIgwOcU3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AAF10E4BE;
	Thu, 29 Oct 2026 13:36:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0585510E4BE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B243E437D1;
 Thu, 29 Oct 2026 13:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0B21F01825;
 Thu, 29 Oct 2026 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280973;
 bh=YtfL+KmftQRDXEG9A8HUqiME9C/gwzCOqzjr/edIS24=;
 h=From:Subject:Date:To:Cc;
 b=eIgwOcU3gB+Hc4pdOPgG15AfCe1PRg0nfjyKQTDpssmi+NxAG2p5+hZt7uT0OUptZ
 iaFjSQKHUfVvPJmS1YXSxwa63dZb3S21cnjjR6RLvDfqK4fU0nElGB1H++8IrMa3my
 hL1LsqhO5IOriepu4EEAPfQSTHrNIVDgDwtCIAnY3kugJ9Ml6Qpv8SyHSKzZom2TL7
 b1+td4/Zs+LoaDiwpmjaoJyvnvcNfY8hHA6hbJpFpZQ3yaX9K41GoBOeT0n0zSQyUE
 UsVHfmuOWu4JdAQujlXmHzNXkLe4VEEunM4HxUIMQ++8kmDHApU+dGCzDFzebK0+aq
 kz99gzT+CGCuw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v4 00/31] accel: ethosu: Another batch of fixes
Date: Thu, 29 Oct 2026 08:35:47 -0500
Message-Id: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ7CIBAF4KsY1mIoUH5ceQ/jotahRU0x0BJN0
 7sLdaHWuHyZ970ZUQBvIaDtakQeog3WdSnw9QrVbdU1gO0pZUQJFURRiaFvXRiwsXcIGKBUTAn
 QhBCUyM3DfEhif3jlMBzPUPd5IzdaG3rnH/O/WOTen+lYYIIZF0ZDpaQu6t0FfAfXjfMNytuRv
 rUmfKFp1lJIyZQsRcV/NPvUaqFZ0lwTA7QoqRLmS0/T9AQJMHZaNwEAAA==
X-Change-ID: 20260827-ethosu-fixes-ee58386e9000
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.16-dev
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is another series of fixes to the ethosu driver. It's mostly probe 
error paths and cmd stream validation fixes. It's a mixture of 
AI reported issues, different solutions to other posted issues and 
fixes[1] and my own fixes. The last 2 patches are additional operation 
support.

The series adds rejecting OFM tranpose in cmd stream, but then a later 
patch adds support for it. I did this so the rejection can be 
backported, but maybe supporting OFM transpose is small enough that it 
should just be backported too?

Sashiko keeps raising issues about IRQs, but the h/w only generates an 
interrupt if a job was submitted. The scenarios sashiko talks about are 
not possible.

Rob

[1] https://lore.kernel.org/all/20260717061145.1478139-1-zhaoguohan@kylinos.cn

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v4:
- More patches added for existing issues raised by Sashiko in v3 and 
  local runs
- Combined the 2 patches for unknown cmds and unhandled parameters into  
  one patch 
- Link to v3: https://patch.msgid.link/20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org

Changes in v3:
- Address Sashiko comments
- Another runtime-PM fix for driver remove()
- Add a fix for NHCWB16 bounds calculation
- Link to v2: https://patch.msgid.link/20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org

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
Rob Herring (Arm) (31):
      accel: ethosu: Suspend after initialization
      accel: ethosu: Ensure suspended on removal
      accel: ethosu: Fix probe error cleanup
      accel: ethosu: Disable clocks on PM setup failure
      accel: ethosu: Quiesce jobs before scheduler teardown
      accel: ethosu: Fix runtime PM get error handling
      accel: ethosu: Limit perfmon counters to UAPI
      accel: ethosu: Serialize job completion
      accel: ethosu: Guard operations after unplug
      accel: ethosu: Keep scheduler after unplug
      accel: ethosu: Clear SRAM before submission
      accel: ethosu: Validate timeout command offset
      accel: ethosu: Prevent command stream export
      accel: ethosu: Move DMA mode to src/dst struct
      accel: ethosu: Track command stream register setup
      accel: ethosu: Factor buffer bounds checks
      accel: ethosu: Fix NHCWB16 bounds calculation
      accel: ethosu: Validate secondary streams
      accel: ethosu: Reject unsupported commands and params
      accel: ethosu: Validate all feature map tiles
      accel: ethosu: Account for feature map element size
      accel: ethosu: Validate convolution parameter
      accel: ethosu: Account for kernel dilation in IFM size
      accel: ethosu: Validate accumulator input
      accel: ethosu: Restrict dynamic IFM2 weights
      accel: ethosu: Split U65 and U85 DMA length validation
      accel: ethosu: Validate OFM transpose
      accel: ethosu: Validate resize operations
      accel: ethosu: Ensure cmd stream is multiple of 4 bytes
      accel: ethosu: Require active weight streams setup
      accel: ethosu: Support U85 IFM upscaling

 drivers/accel/ethosu/ethosu_device.h  |  40 ++
 drivers/accel/ethosu/ethosu_drv.c     |  56 +-
 drivers/accel/ethosu/ethosu_drv.h     |   6 +
 drivers/accel/ethosu/ethosu_gem.c     | 951 +++++++++++++++++++++++++++++++---
 drivers/accel/ethosu/ethosu_job.c     | 236 +++++++--
 drivers/accel/ethosu/ethosu_job.h     |   5 +-
 drivers/accel/ethosu/ethosu_perfmon.c | 123 +++--
 7 files changed, 1236 insertions(+), 181 deletions(-)
---
base-commit: 9a96e169c9267af918d28fb291df948d83112807
change-id: 20260827-ethosu-fixes-ee58386e9000

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>

