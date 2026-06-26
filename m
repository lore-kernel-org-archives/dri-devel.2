Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D3C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4092010E3BE;
	Fri, 26 Jun 2026 13:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f4luWlP5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2F810E3BE;
 Fri, 26 Jun 2026 13:35:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D9EB600C8;
 Fri, 26 Jun 2026 13:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EB51F000E9;
 Fri, 26 Jun 2026 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782480919;
 bh=hH510sudv5X4F+U/OA58bG3WrGtZ8R+7l3HMyghVbtg=;
 h=From:To:Cc:Subject:Date;
 b=f4luWlP5i+ZVcrnK+dhMEPLcfUOePLMCMdFRYBPCknaPjvtzi2otHqfZwIkvbh33x
 pXNuzdBZs5YCZawmsN0FF9QkhxSQSSYCUaB7nWvMdSIsV5kEZkUWrUfgxt/CFhNKLy
 XVvCBRJXEuoUnLw39y5X3EBnkfjJUDoJPt3D+tMCwcthUofJPK+Jo9TFjhccJBlQ8/
 qXu33dtpTBgpsYrxyfHSAmwjLCUhUv27vfUN5Yr2DoGSj92RriowxvqV5ATkh3xAa0
 Pf5kLN3F6D0ljD2cvthsxOltZSYyRfKKnlsLCYEEU6jzY+LuX5xHm9DKGioGCVbQwM
 JUxSbE59k0M0A==
From: Sumit Garg <sumit.garg@kernel.org>
To: andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v8 00/14] firmware: qcom: Add OP-TEE PAS service support
Date: Fri, 26 Jun 2026 19:04:20 +0530
Message-ID: <20260626133440.692849-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Qcom platforms has the legacy of using non-standard SCM calls
splintered over the various kernel drivers. These SCM calls aren't
compliant with the standard SMC calling conventions which is a
prerequisite to enable migration to the FF-A specifications from Arm.

OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
support these non-standard SCM calls. And even for newer architectures
using S-EL2 with Hafnium support, QTEE won't be able to support SCM
calls either with FF-A requirements coming in. And with both OP-TEE
and QTEE drivers well integrated in the TEE subsystem, it makes further
sense to reuse the TEE bus client drivers infrastructure.

The added benefit of TEE bus infrastructure is that there is support
for discoverable/enumerable services. With that client drivers don't
have to manually invoke a special SCM call to know the service status.

So enable the generic Peripheral Authentication Service (PAS) provided
by the firmware. It acts as the common layer with different TZ
backends plugged in whether it's an SCM implementation or a proper
TEE bus based PAS service implementation.

The TEE PAS service ABI is designed to be extensible with additional API
as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
extensions of the PAS service needed while still maintaining backwards
compatibility.

Currently OP-TEE support is being added to provide the backend PAS
service implementation which can be found as part of this PR [1].
This implementation has been tested on Kodiak/RB3Gen2 and lemans
EVK boards. In addition to that WIN/IPQ targets tested OP-TEE with
this service too. Surely the backwards compatibility is maintained and
tested for SCM backend.

Note that kernel PAS service support while running in EL2 is at parity
among OP-TEE vs QTEE. Especially the media (venus/iris) support depends
on proper IOMMU support being worked out on the PAS client end.

Patch summary:
- Patch #1: adds generic PAS service.
- Patch #2: migrates SCM backend to generic PAS service.
- Patch #3: adds TEE/OP-TEE backend for generic PAS service.
- Patch #4-#12: migrates all client drivers to generic PAS service.
- Patch #13: drops legacy PAS SCM exported APIs.

The patch-set is based on qcom tree tip [2] and can be found in git tree
here [3].

Merge strategy:

It is expected due to APIs dependency, the entire patch-set to go via
the Qcom tree. All other subsystem maintainers, it will be great if I
can get acks for the corresponding subsystem patches.

[1] https://github.com/OP-TEE/optee_os/pull/7721 (already merged)
[2] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=for-next
[3] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v8

---
Changes in v8:
- Rebased on mainline tip (no functional changes).
- Now Lemans EVK is also tested to support OP-TEE PAS here:
  https://github.com/OP-TEE/optee_os/pull/7845
- Drop Kodiak DT patch as it is carried independently by Mukesh here:
  https://lore.kernel.org/lkml/20260624063952.2242702-1-mukesh.ojha@oss.qualcomm.com/
- Regarding Sashiko comments, I have already replied in v6 the ones that
  don't apply but in v7 I got the same comments again. Specific context
  reasoning which Shashiko ignores:
    - ABI contract between Linux and TZ
    - No support for multiple concurrent backends
    - The TZ backend doesn’t detach during the entire boot cycle

Changes in v7:
- Rebased to qcom tree (for-next branch) tip.
- Merged patch #5 and #7 due to build dependency.
- Disabled modem for kodiak EL2 as it isn't tested yet.
- Fix an issue found out by sashiko-bot for patch #4.

Changes in v6:
- Rebased to v7.1-rc4 tag.
- Patch #14: fixed ret error print.
- Add Kconfig descriptions for PAS symbols such that they are visible
  in menuconfig to update.

Changes in v5:
- Incorporated misc. comments from Mukesh.
- Split up patch #11 into 2 to add an independent commit for passing
  proper PAS ID to set_remote_state API.
- Picked up tags.

Changes in v4:
- Incorporate misc. comments on patch #4.
- Picked up an ack for patch #10.
- Clarify in cover letter about state of media support.

Changes in v3:
- Incorporated some style and misc. comments for patch #2, #3 and #4.
- Add QCOM_PAS Kconfig dependency for various subsystems.
- Switch from pseudo TA to proper TA invoke commands.

Changes in v2:
- Fixed kernel doc warnings.
- Polish commit message and comments for patch #2.
- Pass proper PAS ID in set_remote_state API for media firmware drivers.
- Added Maintainer entry and dropped MODULE_AUTHOR.

Sumit Garg (14):
  firmware: qcom: Add a generic PAS service
  firmware: qcom_scm: Migrate to generic PAS service
  firmware: qcom: Add a PAS TEE service
  remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
  remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
  remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
  remoteproc: qcom: Select QCOM_PAS generic service
  drm/msm: Switch to generic PAS TZ APIs
  media: qcom: Switch to generic PAS TZ APIs
  media: qcom: Pass proper PAS ID to set_remote_state API
  net: ipa: Switch to generic PAS TZ APIs
  wifi: ath12k: Switch to generic PAS TZ APIs
  firmware: qcom_scm: Remove SCM PAS wrappers
  MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service

 MAINTAINERS                                   |   9 +
 drivers/firmware/qcom/Kconfig                 |  21 +-
 drivers/firmware/qcom/Makefile                |   2 +
 drivers/firmware/qcom/qcom_pas.c              | 291 +++++++++++
 drivers/firmware/qcom/qcom_pas.h              |  50 ++
 drivers/firmware/qcom/qcom_pas_tee.c          | 477 ++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c              | 302 ++++-------
 drivers/gpu/drm/msm/Kconfig                   |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
 drivers/media/platform/qcom/iris/Kconfig      |  27 +-
 .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
 drivers/media/platform/qcom/venus/Kconfig     |   1 +
 drivers/media/platform/qcom/venus/firmware.c  |  11 +-
 drivers/net/ipa/Kconfig                       |   2 +-
 drivers/net/ipa/ipa_main.c                    |  13 +-
 drivers/net/wireless/ath/ath12k/Kconfig       |   2 +-
 drivers/net/wireless/ath/ath12k/ahb.c         |  10 +-
 drivers/remoteproc/Kconfig                    |   4 +-
 drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
 drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
 drivers/remoteproc/qcom_wcnss.c               |  12 +-
 drivers/soc/qcom/mdt_loader.c                 |  12 +-
 include/linux/firmware/qcom/qcom_pas.h        |  43 ++
 include/linux/firmware/qcom/qcom_scm.h        |  29 --
 include/linux/soc/qcom/mdt_loader.h           |   6 +-
 26 files changed, 1084 insertions(+), 321 deletions(-)
 create mode 100644 drivers/firmware/qcom/qcom_pas.c
 create mode 100644 drivers/firmware/qcom/qcom_pas.h
 create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
 create mode 100644 include/linux/firmware/qcom/qcom_pas.h

-- 
2.53.0

