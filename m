Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC144C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 19:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE7310F46A;
	Thu,  2 Jul 2026 19:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rDKoRyEk";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9AE10F598
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 19:14:17 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so3847082a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783019655; cv=none;
 d=google.com; s=arc-20260327;
 b=F8d2oi5fnyucKj6ctVg6h9h5tmL9HTi62Y+FiZo1jVfbqTwSYSqN97z4w6MTdbxDpD
 l1EPd9RRrbUgf2s47B/W3tAU6nxUqyvgrw9anFHEmwk79DolO0EaXaOLJFAyWTQLMwJw
 1PzTClRrkN6LLDnvHJnZaKizE2fRthJ2eh31dZp4PNCmqfq1Y5ZQz59XZgE1NT6KQLZD
 1BThzTTlkaz9K28kAbqEenwrTWuK1x+/u01k18gbZla0sUz60F8Y8og37TGkFefBURk8
 kkPO28DtH98q2NzHF0rSqDSE4GqGhpnSnIG0RNbU1ODTzGqM0pT7jG62pMeWfTXtrVUW
 zoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dfas/91RHw7TRgs4MMexcFlE2KWowDBMjBihd9aSOjU=;
 fh=wu/KqRLrqM5gZaGKUGc9ivli/WN4WRuE8U1sZry+MeU=;
 b=gyS0oXvZfR/e5venntHLd3zCRGcioPARK1HqTuYfjji3PZNLvkqnvTMeNVzhjnYjf+
 sOP4r/k2xoIpFxIPqylt3n1Seb/RwYUCNUDg7Rke1577xIfAk356hX0SlOGXvkzqIV2k
 xjgHwMFVwBsLePza21SVV/jo8rhzn34eNlSdA4n4lcWwAbvnftk72DxarYIHqpEj0cTb
 KijKaV8bjIdLipnqFtFOYVzmW1x3Keap0e9jnCAcrPlYx/gXzE9kk4cDfKxEtroKHzhh
 8eWW8m7JMrjiAHXQO9X8SrE6T/cMDVYERmE3zCgWHtw7tqauFupx9hBPM6icrRP61djA
 jo6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783019655; x=1783624455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dfas/91RHw7TRgs4MMexcFlE2KWowDBMjBihd9aSOjU=;
 b=rDKoRyEkBZ0EvF6mRBxuSUxiFgA1W8HjqG8szVZvJB7SrbVmsvH/JJgXS2/Bnpx9ru
 ZlMMe622Ld1sT51YkUyXeSd35cTzp8vgNkln9fdvLUhXeQjVH8GEfuLjCsxQF37QPHUO
 dVLLzMdKDn+2sHp6/JpijrFRCr4B3eZU5XMn0DuZaklsJrjJqkrxFoVW/rCqDvcj7TU5
 vDngnq31rbC9ZSvLD19a6XlT9aCd0XJijdMpmz6+9U47k9oQ2UX+6oUlNttOTzGC8RbX
 t6VYVpjac2O8KxOp1zn9jqpHcq/4mBLyLbZlqkpqaY2k5dL1+khiZdJjpMn4jNqr2rZb
 +Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783019655; x=1783624455;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dfas/91RHw7TRgs4MMexcFlE2KWowDBMjBihd9aSOjU=;
 b=OIAE7xR0NrjXDprsP+xl+UT4twoFuhPGt7RoWvcz8MXBv73mWOzSjD9VB2GuQlom0i
 +7EDVB+kaT7H8r9EriwC6SBiPL10riM2oIkDSbBFLLqle1jWJYJn1tAsMwtqlb3AzEVm
 BEJ0i2Xex9R6seCpyxrHMxF7GOayN+3JHOCrAtXL93I7u2wd4tpC8SdtsVBzCtOE82fA
 J2wVlpGgV8PlGV4MIVgjA2kkmn4OyjoIcO+qIoeHCO8/UjS4T5MYpSBRwt2cLMUv2Qke
 oTxS3fxjTJO5g4L4BY9b3pazzj//mHdHFcSTkwx8jIjPfdCMOG17WdYMKKoa80gp7FR9
 BDdw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqmg9igaT7215on/6o73ZKz65OGgTe8lzAnDNMA9RwrmtNuEWMytwZjEKLOiS3++WEDdR09pUlwFSk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOrMuwsrbARGQ5YEDs8yBD2KpWqd7nWQalW+J5ZiBHuEIK5sMA
 rrs/cJ+pb9gUfCaqhKAUe1hVHpyLARtrq8wUeZ41E9u4cqw7C8l4yFy95ySubDwlSLSr0zXvhjE
 6o60wHl9vaux8tV+lz+18duSGLLMQWYtKBiDd4mq5yg==
X-Gm-Gg: AfdE7ckXrlhhMgvYUwIaSl1H5SHf/bToFxGpdtcMf2MtuCSP7u8dksan1Rp4hQLP+1a
 WQFRk7DvfYbk0ZZlwgpqOSaZJoet+qEaCUoDRYFlaJEOdWMA27YrSs0jityIsWcfRSXRnU19Af8
 +sd6OknI3+/EybAsMiYe11wYc4AaLD8SRmEe/M/jS0I+YYINsO/SQ0cQwyFE5hU+Hr8OCEwmWet
 f6/1nqx+MWJJSkWHYDL1MOj1DsUmp8Q+JJFDdvEHvAq+sY1GxbuwcowgOsy5ir+MUW26iv75U4T
 vF6SEJpO7V/ghQ9VJ9r+Zi3MePij6s4=
X-Received: by 2002:a05:6402:42c6:b0:695:f580:a66f with SMTP id
 4fb4d7f45d1cf-698a2cda40dmr3064278a12.21.1783019655273; Thu, 02 Jul 2026
 12:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 2 Jul 2026 13:14:03 -0600
X-Gm-Features: AVVi8CeXvNLFBEH_Z9SIZx0oNo56nh0xA5WRLgXhkbS1U9sxKdwz3gfEHooCZ0g
Message-ID: <CANLsYkyFJ+CbUJpwWAy28KHvmNz6rJRtM5KrEzHjyAha-7grTQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS service support
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-media@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, 
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, 
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, 
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, 
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
 jjohnson@kernel.org, trilokkumar.soni@oss.qualcomm.com, 
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, 
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, 
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, 
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, 
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, 
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hey Sumit - nice hearing from you...

Is there some kind of overarching design harminisation between what
you are proposing here and what Arnaud posted back in April [1] ?

[1]. https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfi=
rmware.org/thread/VMKTRATYUFWL2TP7NHN5KJ37MSVZZMPK/

On Thu, 2 Jul 2026 at 05:59, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
>
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
>
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
>
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
>
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
>
> Currently OP-TEE support is being added to provide the backend PAS
> service implementation which can be found as part of this PR [1].
> This implementation has been tested on Kodiak/RB3Gen2 and lemans
> EVK boards. In addition to that WIN/IPQ targets tested OP-TEE with
> this service too. Surely the backwards compatibility is maintained and
> tested for SCM backend.
>
> Note that kernel PAS service support while running in EL2 is at parity
> among OP-TEE vs QTEE. Especially the media (venus/iris) support depends
> on proper IOMMU support being worked out on the PAS client end.
>
> Patch summary:
> - Patch #1: adds generic PAS service.
> - Patch #2: migrates SCM backend to generic PAS service.
> - Patch #3: adds TEE/OP-TEE backend for generic PAS service.
> - Patch #4-#12: migrates all client drivers to generic PAS service.
> - Patch #13: drops legacy PAS SCM exported APIs.
>
> The patch-set is based on v7.2-rc1 and can be found in git tree
> here [2].
>
> Merge strategy:
>
> It is expected due to APIs dependency, the entire patch-set to go via
> the Qcom tree. All other subsystem maintainers, it will be great if I
> can get acks for the corresponding subsystem patches.
>
> [1] https://github.com/OP-TEE/optee_os/pull/7721 (already merged)
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/=
log/?h=3Dqcom-pas-v9
>
> ---
> Changes in v9:
> - Rebased to 7.2-rc1.
> - Enable SCM backend similar to TEE if ARCH_QCOM is set.
> - Address misc. comments from Konrad.
> - Add checks for corner cases (although not reachable as per OP-TEE ABI)
>   reported by Shashiko on patch #3.
> - Picked up review tags from Konrad.
>
> Changes in v8:
> - Rebased on mainline tip (no functional changes).
> - Now Lemans EVK is also tested to support OP-TEE PAS here:
>   https://github.com/OP-TEE/optee_os/pull/7845
> - Drop Kodiak DT patch as it is carried independently by Mukesh here:
>   https://lore.kernel.org/lkml/20260624063952.2242702-1-mukesh.ojha@oss.q=
ualcomm.com/
> - Regarding Sashiko comments, I have already replied in v6 the ones that
>   don't apply but in v7 I got the same comments again. Specific context
>   reasoning which Shashiko ignores:
>     - ABI contract between Linux and TZ
>     - No support for multiple concurrent backends
>     - The TZ backend doesn=E2=80=99t detach during the entire boot cycle
>
> Changes in v7:
> - Rebased to qcom tree (for-next branch) tip.
> - Merged patch #5 and #7 due to build dependency.
> - Disabled modem for kodiak EL2 as it isn't tested yet.
> - Fix an issue found out by sashiko-bot for patch #4.
>
> Changes in v6:
> - Rebased to v7.1-rc4 tag.
> - Patch #14: fixed ret error print.
> - Add Kconfig descriptions for PAS symbols such that they are visible
>   in menuconfig to update.
>
> Changes in v5:
> - Incorporated misc. comments from Mukesh.
> - Split up patch #11 into 2 to add an independent commit for passing
>   proper PAS ID to set_remote_state API.
> - Picked up tags.
>
> Changes in v4:
> - Incorporate misc. comments on patch #4.
> - Picked up an ack for patch #10.
> - Clarify in cover letter about state of media support.
>
> Changes in v3:
> - Incorporated some style and misc. comments for patch #2, #3 and #4.
> - Add QCOM_PAS Kconfig dependency for various subsystems.
> - Switch from pseudo TA to proper TA invoke commands.
>
> Changes in v2:
> - Fixed kernel doc warnings.
> - Polish commit message and comments for patch #2.
> - Pass proper PAS ID in set_remote_state API for media firmware drivers.
> - Added Maintainer entry and dropped MODULE_AUTHOR.
>
> Sumit Garg (14):
>   firmware: qcom: Add a generic PAS service
>   firmware: qcom_scm: Migrate to generic PAS service
>   firmware: qcom: Add a PAS TEE service
>   remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
>   remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
>   remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
>   remoteproc: qcom: Select QCOM_PAS generic service
>   drm/msm: Switch to generic PAS TZ APIs
>   media: qcom: Switch to generic PAS TZ APIs
>   media: qcom: Pass proper PAS ID to set_remote_state API
>   net: ipa: Switch to generic PAS TZ APIs
>   wifi: ath12k: Switch to generic PAS TZ APIs
>   firmware: qcom_scm: Remove SCM PAS wrappers
>   MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
>
>  MAINTAINERS                                   |   9 +
>  drivers/firmware/qcom/Kconfig                 |  22 +-
>  drivers/firmware/qcom/Makefile                |   2 +
>  drivers/firmware/qcom/qcom_pas.c              | 299 +++++++++++
>  drivers/firmware/qcom/qcom_pas.h              |  50 ++
>  drivers/firmware/qcom/qcom_pas_tee.c          | 479 ++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.c              | 302 ++++-------
>  drivers/gpu/drm/msm/Kconfig                   |   1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
>  drivers/media/platform/qcom/iris/Kconfig      |  27 +-
>  .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
>  drivers/media/platform/qcom/venus/Kconfig     |   1 +
>  drivers/media/platform/qcom/venus/firmware.c  |  11 +-
>  drivers/net/ipa/Kconfig                       |   2 +-
>  drivers/net/ipa/ipa_main.c                    |  13 +-
>  drivers/net/wireless/ath/ath12k/Kconfig       |   2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c         |  10 +-
>  drivers/remoteproc/Kconfig                    |   4 +-
>  drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
>  drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
>  drivers/remoteproc/qcom_wcnss.c               |  12 +-
>  drivers/soc/qcom/mdt_loader.c                 |  12 +-
>  include/linux/firmware/qcom/qcom_pas.h        |  43 ++
>  include/linux/firmware/qcom/qcom_scm.h        |  29 --
>  include/linux/soc/qcom/mdt_loader.h           |   6 +-
>  26 files changed, 1095 insertions(+), 321 deletions(-)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
>
> --
> 2.53.0
>
