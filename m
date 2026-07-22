Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852A0C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A079E10EFE5;
	Thu, 23 Jul 2026 07:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N9PGe9DA";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DDB10EE6C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 17:47:31 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8114a4542b2so78410987b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784742451; cv=none;
 d=google.com; s=arc-20260327;
 b=PplcIUHIkP4jwKFBgItr1S/fBYcb2naLrAdzhJ5203IkG7gSECWX/O+eehg8gglThY
 N6cCJL51qCgOIjVS0IM3W+26L+ar7pATClnBDLhLuwqBLsZgfJUewFK68ef1Lum1kKdI
 1jRL8rbHXnypw8a/Fdh0NQdssPAsK1CHo19S/eMrpN06nDW9tmrXaZhqVtEqhT3o/KPF
 OWQi+45/JFRttyKt2ydz5UAG2PusDr2WGc7PuDu1Jw4f28wJmREpaDPvQPsv/XiGcCuW
 QNi/rUx3R0xxJoxPkSD9+61W19IdGyFrep6Ib2AMVVIlFc1dIFguxKSCAsqkDNf7+0J1
 HMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DqyEyXY0JqSe75MbjwLdRR9WOQt3kX/M0ZZvXr8r/mY=;
 fh=RHt77CxFI8VNyQoQZGD2p5fp2XohHPbsKAwEtyIE+Go=;
 b=TNORQ4RjtBqYxcU+/NkxE6H3HadG8eDP5NnDPUlqMysCH2Lf7YNVhi/SDSqYlCf8YX
 i9TZDa6FydVr8DxbIV2+sr3gh9a4DNHHxTZCDfY5kHjpRW7KEQDg0dm7TsbrM8baJmeg
 NXNegNNvd4lABdY45nJXG47Xozy/47KZkwaXdEo8FAzx/KIjmr0v42drhvR4xieyWGmI
 cHQMd5KGw9k91BIozK+uasZ0TPily+Otxf36cbuAIT0UllGEmfUxmJtTOhTto/dG02x0
 cDkGiv0YgpJuunJy1B0HnqCOUr2uk6UHmAEJoK2RTlOd7+ep+2HHv2r4+sXV2pDfcLaE
 sm1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784742451; x=1785347251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DqyEyXY0JqSe75MbjwLdRR9WOQt3kX/M0ZZvXr8r/mY=;
 b=N9PGe9DAJMXOulXZMDbn5zsU0VD9Yk6CJOekPXZ/WYEj+glP8TjKhg/gkqdypClDuM
 jDH8zLGCGxHdf+VqbscBEQR0zzKSgzQ7ppuCHM9Xa+HehDzii0uWqJXh8jFemJWuyaW1
 DvHcCdnPfn/Tp2s6eNO3ZEXKOHKtoNKR9m8154gLxz0nLkQHj04W+QwAQDPe48GBmkTA
 IUsPWdaMuVZc0R3q5mJLVZWguWlrYRmp6xLfsplOCiKb2DpO8KHCb4x04I9ghS0mkjdb
 3rwIZfoefkgUU6oxbWvWtyPy+dGXMCRaEu3lGJJrQsxeNY+k8JMCHBCxcIc2lAVsTZLp
 b2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784742451; x=1785347251;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DqyEyXY0JqSe75MbjwLdRR9WOQt3kX/M0ZZvXr8r/mY=;
 b=Sh4QS81iM1Rfp6fgMZ2D5ELD9HlIF4DAhLVUCfPx1i9pPQeLqF7MHSSjSUDN/9eb/3
 aN5ET+hB8bNhs1tMgbFwOPFa4WRtTN/MZ4n7qA22PyWU8WJibzG4AqyieBav2VnoeA9E
 FNak5mWsfXBzxOvr9pHTNlw0bf4v0PcTSKUi7ZSct82KqjF02AiZOfh/6aeRsap/ioTq
 YgPyNu3PD58fl5t64DAtS1ICz5K2SFBFr1syWJbqAVjBcAdJoWbRrpID+IlwHBrQHiOv
 yLMHNXptxnKPMpEp61EULqGI3esPxWOsawrIRFEo1YAcaaZAXUYw1iztaflqyo8CXBZp
 NI8w==
X-Gm-Message-State: AOJu0YzxY6tHk7ZoRToYf+Kf3T0+5WHUaroWwNe+nLEGgjZm/gTGU5oe
 9OVH0KPGZCVfBYEMSoMcpodY09/g7ohWGlqQsywdJaX4vkv4EWEUu47iGsLNcx+zohBiMzlsMgi
 0TYaO1EDhUcpYI1JZX0XgxRpWKoDpilE=
X-Gm-Gg: AR+sD13486hsjZD6/lfE5CVreY7v8EA1XmmecSXhFlq5/lUrNswKlP9Akhc/+COjfpO
 0UfRPdaqGt3V6Tlk+EwBWhE3bwQbLneyTj4HEEMFu3h/SZKp3Z/QXlcs6p7Cj+ikuhNuCG2wPGb
 qr59xqrFMz9CVV6QsgwfQGzheRkdxOazs2q+si1u7GnuFj6TzbB1oZlu1L+ffX3n3kTa/rmhTkx
 etg/J6z74+iglxPgkYxaOTDeT7Enh7POLo0uxoyzez12GanBoBCcWa1AHio9O4LILeYMpH9gead
 Rz9nqxSLsGyaStHpAeQV0HuAZVR62GJpybztX7TBJFTu/vcL
X-Received: by 2002:a05:690c:8682:20b0:81e:fbcd:7d4e with SMTP id
 00721157ae682-81efbcd7e35mr51040237b3.61.1784742450753; Wed, 22 Jul 2026
 10:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-3-talesam@gmail.com>
In-Reply-To: <20260722004654.744249-3-talesam@gmail.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Wed, 22 Jul 2026 14:47:19 -0300
X-Gm-Features: AUfX_my-jgFvbpUDqbV1ZVXtVfIKfbU_nfDTNsOZjvrFekX-HMD68_L4t8dE_CI
Message-ID: <CAHBRX4E9OY-A+Wi_EL0b6DQ0vFchoOkUoXzrCk_JyGYty+xmfw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/xe/mcr: Sanitize steering semaphore on GT
 resume
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Thanks for the review.

The call site mirrors i915, where intel_gt_mcr_lock_sanitize() is also
only called on the resume path (intel_gt_resume_early(), its only
caller). The "driver load/resume" wording comes from i915's hardware
team note about when the forced release is *safe*, not about where it
is required.

Empirically the failure mode is resume-only: across dozens of cold
boots on two ARL machines the probe-time stall never reproduced (boot
firmware hands the semaphore over released; it is the suspend cycle
that leaves it held). That said, dding a sanitize call early in the
load path would be harmless per the same safety note - happy to do
that in a v2 if preferred.

Em ter., 21 de jul. de 2026 =C3=A0s 21:47, Tales A. Mendon=C3=A7a
<talesam@gmail.com> escreveu:
>
> The MCR steering semaphore can be left in a held state after a suspend
> cycle. The first MCR access after resume then stalls until the
> semaphore wait times out and logs:
>
>   Tile0: GT1: hardware MCR steering semaphore timed out
>
> as observed on an Arrow Lake-P system resuming from s2idle. Recovery
> currently only happens because mcr_unlock() releases the semaphore
> unconditionally.
>
> i915 addresses the same issue in intel_gt_resume_early() via
> intel_gt_mcr_lock_sanitize(), noting that the hardware team confirmed
> that forcibly releasing the semaphore is safe during driver
> load/resume because no other agents acquire it at that time.
>
> Port that to xe: release the steering semaphore at the start of
> xe_gt_resume(), before the first MCR access performed by
> do_gt_restart().
>
> Signed-off-by: Tales A. Mendon=C3=A7a <talesam@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_gt.c     |  7 +++++++
>  drivers/gpu/drm/xe/xe_gt_mcr.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_gt_mcr.h |  1 +
>  3 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> index dfdacc0f6de..c61f3d9fc9a 100644
> --- a/drivers/gpu/drm/xe/xe_gt.c
> +++ b/drivers/gpu/drm/xe/xe_gt.c
> @@ -1068,6 +1068,13 @@ int xe_gt_resume(struct xe_gt *gt)
>                 return -ETIMEDOUT;
>         }
>
> +       /*
> +        * The MCR steering semaphore may be left held across a suspend
> +        * cycle; release it before the first MCR access below so that
> +        * mcr_lock() does not stall until the semaphore wait times out.
> +        */
> +       xe_gt_mcr_lock_sanitize(gt);
> +
>         err =3D do_gt_restart(gt);
>         if (err)
>                 return err;
> diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mc=
r.c
> index e1e3c0688dc..3934d0de717 100644
> --- a/drivers/gpu/drm/xe/xe_gt_mcr.c
> +++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
> @@ -750,6 +750,28 @@ static void mcr_unlock(struct xe_gt *gt, unsigned in=
t fw_ref) __releases(&gt->mc
>         }
>  }
>
> +/**
> + * xe_gt_mcr_lock_sanitize - Release the hardware MCR steering semaphore
> + * @gt: GT structure
> + *
> + * The MCR steering semaphore can be left in a held state after a suspen=
d
> + * cycle, in which case the first MCR access after resume stalls until t=
he
> + * semaphore wait times out.  Forcibly release the semaphore during driv=
er
> + * load/resume; this is safe because no other agents acquire the semapho=
re
> + * during the load/resume process, mirroring i915's
> + * intel_gt_mcr_lock_sanitize().
> + */
> +void xe_gt_mcr_lock_sanitize(struct xe_gt *gt)
> +{
> +       if (IS_SRIOV_VF(gt_to_xe(gt)))
> +               return;
> +
> +       lockdep_assert_not_held(&gt->mcr_lock);
> +
> +       if (GRAPHICS_VERx100(gt_to_xe(gt)) >=3D 1270)
> +               xe_mmio_write32(&gt->mmio, STEER_SEMAPHORE, 0x1);
> +}
> +
>  /*
>   * Access a register with specific MCR steering
>   *
> diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.h b/drivers/gpu/drm/xe/xe_gt_mc=
r.h
> index 75374662f10..162f54075cf 100644
> --- a/drivers/gpu/drm/xe/xe_gt_mcr.h
> +++ b/drivers/gpu/drm/xe/xe_gt_mcr.h
> @@ -16,6 +16,7 @@ void xe_gt_mcr_init_early(struct xe_gt *gt);
>  void xe_gt_mcr_init(struct xe_gt *gt);
>
>  void xe_gt_mcr_set_implicit_defaults(struct xe_gt *gt);
> +void xe_gt_mcr_lock_sanitize(struct xe_gt *gt);
>
>  u32 xe_gt_mcr_unicast_read(struct xe_gt *gt, struct xe_reg_mcr mcr_reg,
>                            int group, int instance);
> --
> 2.55.0
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
