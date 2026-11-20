Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9E606A335
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1vgwAHu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194FF112B5A;
	Fri, 20 Nov 2026 14:58:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9825112B5A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:57:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E436560DF4;
 Fri, 20 Nov 2026 14:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DF01F000C0;
 Fri, 20 Nov 2026 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186677;
 bh=x/WPSxVncz2SiXf+PVx07o/EAYAzdQ5jOOBz5XwDM1U=;
 h=From:Subject:Date:To:Cc;
 b=i1vgwAHu52eoSBZ5P5zCskXNTxUk3b6Gc42levAOVJb1XLutADEl9wwsX/tSesDK5
 Riqx+mT3yYw6wH7jKgAEWm9u2RaSf/sK/5uMmDy+f7C9An9c+Ek8SJb4FrLphcQfQt
 tjJATOw4q1xpnEuUDxMW5ZH0NToLJvhorcTy/U3ZaPAg6iyP1W7J8/+hbRBcn2rIlZ
 uIpfm2tOxC1bnV+xyiOoqEuzwewEJo2bjRo9DACdEBFURVYCpEiM0SW+q2GpRQSgTd
 Lkcf4e3rY+g80Go7ycXstAt/RzhgN2FFAX3MKhzAy9OHlD1N603jc7fY8GK11BBh8e
 lWG0UkqLUcx2A==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v5 00/19] accel: ethosu: Cmd stream validation fixes
Date: Fri, 20 Nov 2026 08:57:24 -0600
Message-Id: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNy27CMBAF0F9BXmM0Hr9Z9T8QCzdMiFuUVHYSg
 VD+vTaV+gjq8mruuXNnmVKkzPabO0s0xxyHvgS93bCmC/2ZeDyVzBDQgEPLaeyGPPE2XilzIu2
 kM+QBgBXykehxKOJw/Mp5en2jZqwbtdHFPA7p9vg3i9r7Z3oWHLhUpvUUnPWieXmn1NNlN6Qzq
 9sz/mgPaqWxamuslc5qE9STlr+1W2lZtPLQEgqNzrRPWn1rAehXWlUdAmpC1NbRH70syyek2U7
 MdQEAAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The series was getting a bit long, so I split out the cmd stream 
validation fixes from the error path, close/unbind, lifetime, etc. 
fixes. It's a mixture of AI reported issues, different solutions to 
other posted issues and fixes[1] and my own fixes. It also adds U85 OFM 
transpose, resize and IFM upscaling support.

The series adds rejecting OFM transpose in cmd stream, but then a later
patch adds support for it. I did this so the rejection can be
backported, but maybe supporting OFM transpose is small enough that it
should just be backported too?

Rob

[1] https://lore.kernel.org/all/20260717061145.1478139-1-zhaoguohan@kylinos.cn

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v5:
- Drop all but cmd stream validation patches
- IFM upscaling also supported on U65
- Fix U85 shared DMA stride mode and mixed contiguous/strided U65 DMA.
  Ignore stale bounds for inactive weight and scale streams.
- Correct resize bounds for signed offsets and programmed input sizes.
- New patch to reject U85 IFM broadcasting on U65
- Fixes for handling multiple weight streams and U85 fast weights mode
- Handle accumulator size mismatch with IFM2 size and ensure ACC_FORMAT 
  is set.
- Drop "accel: ethosu: Account for kernel dilation in IFM size" which 
  wasn't correct.
- Link to v4: https://patch.msgid.link/20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org

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
Rob Herring (Arm) (19):
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
      accel: ethosu: Validate accumulator input
      accel: ethosu: Restrict dynamic IFM2 weights
      accel: ethosu: Split U65 and U85 DMA length validation
      accel: ethosu: Validate OFM transpose
      accel: ethosu: Validate resize operations
      accel: ethosu: Ensure cmd stream is multiple of 4 bytes
      accel: ethosu: Require active weight streams setup
      accel: ethosu: Support IFM upscaling
      accel: ethosu: Reject IFM broadcast on U65

 drivers/accel/ethosu/ethosu_device.h |   32 ++
 drivers/accel/ethosu/ethosu_gem.c    | 1009 +++++++++++++++++++++++++++++++---
 2 files changed, 961 insertions(+), 80 deletions(-)
---
base-commit: b4d01c788bfa50dc65ffb5fbc9db4135004c0e01
change-id: 20260827-ethosu-fixes-ee58386e9000

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>

