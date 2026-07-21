Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42477C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C09D10E757;
	Tue, 21 Jul 2026 13:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="D92vjr+P";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8165710E757
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:02:52 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so328732666b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 06:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638971; cv=none;
 d=google.com; s=arc-20260327;
 b=m6ZNnUfj3SGuFJ1h9+sDd9iC/bTWP/e9Wu78xE8jAqyE9ptLy5XfAptlx3XQ1phpPR
 NXBPYVYlM7L7ilWwcRMwv+ZNbotvztkepOQEOkUBl2Ua3va/BxiFvJPx6BvGy2h27fYA
 KE3PRdHKVtEJaTFTPKAaq8DFZBR4S0xx44joTyH6lCK17eY2evHZBetoRPurG4fkpEp0
 dnd0LP9FUNIqhBFg7rIA4/FqRxXt6KhUETJ/eWJdoB+lXXu6fJPFZp3U+MdpBqS3eibi
 xJXvj0yJV/8dUJeRSQp6d28ojo74mATO2XdlDSVLiFdILZjYNt1yDZzSxA3W94hLfs+z
 DXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
 fh=bus96T2Bx0/xvuDDv2Z1PXk6Ad77r1vDPyPyEi17F8w=;
 b=gvmAa8OqDNOTJjo12qbUPsPNgL6Fa+J7nBLfZMGKhU6S5Cq28lL66nXwn/NL0jTyLC
 1E9TgYWBhX5+W0RsbkvGeh0ufHCVhbnoN4ADItlx+Qh0zLQ/r0VgwKQn/q1ScXUzV8pN
 6soqpL9tay8k9RBjXpoC+vNL1R+P44+04htcu+J2Fyioii/20rkPHuYsK20FH/jfHcws
 HAaB5Afs3t2IiuYJMnCz4spDRrx9fFN+pA6LcgA0mCm/Wjh3soUTSWcBhJfOa+K+IIsh
 I8/lkQ4LJuzzhbgMD4Oh2pWrvEbQ0PdcsYbIbJoAhOc7HTUFy2qwR9nMWA/c0/3AZu3n
 cHXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784638971; x=1785243771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
 b=D92vjr+PHixeMJjQ+KYu95p0PzHSlXnBi4ewYyb8b4Yq2zpHhiG7hjezwucf9jHlMH
 00m1f9hWWB7lOKiPbeNnJrents6QbLAZ94U635efWc35Ao0Egd50OlKrNKRnWpCIqUJD
 FP8s+CBY9HH/ACUx0kDUUZtdvpdo+wDrNer4Xe9nYR2ewNQ4nUv3UGVqcfun/B7zEVqF
 3MYdYg1unV2WKbUE3S+jLL7w/FySrq9bak3rTCOtJqbzlgW95VRaBCGW6r+FjvWBR4Zh
 o+cIKhi6sfsqwBenyb/ItgUMRFHUwgQuTAClAqk8CxdnKl969OKC5A9gdIKRpBoWx+gG
 a7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784638971; x=1785243771;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
 b=cwY7jxoH8sADTbpyA2ZOibsDE8rLRqQdQR3AVVfp9TASUQKYBD7tpexUiwVQI/JO0g
 ltLRBB2VR1RFGlJ6G3j6otvBvv6JtXkayBkN5Cvir0fPrKuGP8o+bJ2ZtHwshHY6tVpr
 50JnFLf8dwmGbrCh9HocPTlb3wMqZd3VQi76wvrcXGrPu8RtGT5n9EGdtTnA6zBWBmaW
 Sa6Z7z5S0YSrg/TSfooDwWyq/LdVmW+QF5E5EJSDis4oTblCrr8bbJ02W1oEoHmWhYIu
 YGafljqBroeA7MOP3MFY/j+tovYnZ7J/gsZomqDOTgb4vXHr6N9dFaI3y24+2bZ2hHPH
 179w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhwCQQ8JSMYZKH6T54kMyzkWI7W8j4QfgOf0rZ9GcMxfeQBOc/eDpEtJgVSEbQnkidPhiHAeXLFUk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgD/DIv3v9gVKukk1gVqIDgN8DpRGn9QnMT6vrAPBkndzwVpwD
 8wgDjOpH4jk8om5pAL8FNAYxVLl8zbuFzlllpIC4cPKOnCNB7i0/+Y8+Lixd2aNGM10EEV+o5dS
 OuV2aEvSkRQ5cuHvdfVus7nizHiPo1wpVJYf/F8nl4g==
X-Gm-Gg: AR+sD12TZWF4jWfV8AUS+adUGdQ5XwotyG6Xv37HBUA40PyqA6o9OsPwxAZrWhlHMgj
 15SsXbp5QUlsDeM98dfjhhlSPMla8RJkb1QUWzXAtBLS3eyD9tCRT9jaqPOiIzn9hs6AM9jjWbE
 53DliKzQinU9Az1+pivrh3lKrldUxjWjdJfOlnledrpzsxyWlBc38VWmsaHTzWzAEo7b/E8Zc9I
 fc8jDnTTnTqGCD5TYSf88kDKW7u9aAzYsbf2wrnIpUAIdbrT4HXFyLOvhNF2ZgPwO8oW9zLhOon
 p+4E9RUqkDSk5rhggg==
X-Received: by 2002:a17:906:ee81:b0:c12:34ed:e0fe with SMTP id
 a640c23a62f3a-c16b486b059mr764236766b.60.1784638970824; Tue, 21 Jul 2026
 06:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
 <20260718031146.3368811-7-gahing@gahingwoo.com>
In-Reply-To: <20260718031146.3368811-7-gahing@gahingwoo.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 21 Jul 2026 17:02:36 +0400
X-Gm-Features: AUfX_mybR4TJcD7UtKT7vkslJHd83avKACirSY-Al4DoJE_V_nYHHDDfXmU2CdM
Message-ID: <CAKTNdwHL2Z3h-FN7LLPshz5B0duiMw_pyfe=VG4UDhfm8igZ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/8] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
 ogabbay@kernel.org, chaoyi.chen@rock-chips.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Jiaxing,

On Sat, Jul 18, 2026 at 7:11=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Add RK3576 support to the rocket DRM accelerator driver (used with the
> Mesa Teflon TFLite delegate).  Per-SoC differences are selected by new
> of_device_id match data (struct rocket_soc_data) so the RK3588 path stays
> unchanged:
>
>   - match rockchip,rk3576-rknn-core; iterate its nodes at probe
>   - RK3576 takes six clocks (adds the CBUF domain ACLK/HCLK_RKNN_CBUF):
>     the CNA fills the CBUF and CORE reads from it, so the compute path
>     stalls without them.  RK3588 keeps its four clocks.
>   - RK3576 requests one reset (srst_a); its BIU reset (srst_h) is driven
>     from the power domain.  RK3588 keeps both.
>   - RK3576 spans two power domains (PD_NPU0 + PD_NPU1) and attaches the
>     list explicitly; RK3588 is single-domain and keeps the driver-core
>     auto-attach.
>   - RK3576 has no maskable completion interrupt (PC_DONE is read-only in
>     INTERRUPT_MASK), so it polls PC_DONE via an hrtimer; RK3588 keeps the
>     DPU completion IRQ.
>   - guard rocket_job_timedout() MMIO behind pm_runtime_active()
>
> Tested on a Radxa ROCK 4D: the NPU probes, powers on, brings up its
> IOMMUs and runs submitted jobs to completion.  Full multi-layer inference
> is not yet correct on this SoC (only the first operation per power sessio=
n
> produces valid output); see the cover letter.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_core.c   |  39 +++++++-
>  drivers/accel/rocket/rocket_core.h   |  22 ++++-
>  drivers/accel/rocket/rocket_device.c |   4 +
>  drivers/accel/rocket/rocket_drv.c    |  22 ++++-
>  drivers/accel/rocket/rocket_job.c    | 127 +++++++++++++++++++++++++--
>  5 files changed, 200 insertions(+), 14 deletions(-)

[...]

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f96..ce3f7c92e 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/rocket_accel.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/platform_device.h>
> @@ -20,6 +21,16 @@
>
>  #define JOB_TIMEOUT_MS 500
>
> +/*
> + * RK3576: INTERRUPT_MASK bits 28-29 are read-only (hardware rejects the=
 write),
> + * so the PC_DONE completion signal cannot be routed to the GIC via the =
normal
> + * interrupt-mask path.  We poll OPERATION_ENABLE every RK3576_POLL_INTE=
RVAL_NS
> + * instead of waiting for a completion IRQ.
> + */
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_0  0x10000000u
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_1  0x20000000u
> +#define RK3576_POLL_INTERVAL_NS  1000000LL  /* 1 ms */
> +
>  static struct rocket_job *
>  to_rocket_job(struct drm_sched_job *sched_job)
>  {
> @@ -137,8 +148,24 @@ static void rocket_job_hw_submit(struct rocket_core =
*core, struct rocket_job *jo
>         rocket_pc_writel(core, REGISTER_AMOUNTS,
>                          PC_REGISTER_AMOUNTS_PC_DATA_AMOUNT((task->regcmd=
_count + 1) / 2 - 1));
>
> -       rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | =
PC_INTERRUPT_MASK_DPU_1);
> -       rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 =
| PC_INTERRUPT_CLEAR_DPU_1);
> +       if (core->soc->poll_completion) {
> +               /*
> +                * RK3576: PC_DONE (bits 28-29) is read-only in INTERRUPT=
_MASK, so
> +                * it cannot be routed to the GIC; enable the DMA-error i=
nterrupts
> +                * and poll PC_DONE via the hrtimer started below.
> +                */
> +               rocket_pc_writel(core, INTERRUPT_MASK,
> +                                PC_INTERRUPT_MASK_DMA_READ_ERROR |
> +                                PC_INTERRUPT_MASK_DMA_WRITE_ERROR);
> +               rocket_pc_writel(core, INTERRUPT_CLEAR,
> +                                PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
> +                                PC_INTERRUPT_MASK_RK3576_PC_DONE_1);
> +       } else {
> +               rocket_pc_writel(core, INTERRUPT_MASK,
> +                                PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_M=
ASK_DPU_1);
> +               rocket_pc_writel(core, INTERRUPT_CLEAR,
> +                                PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_=
CLEAR_DPU_1);
> +       }

This whole polled-interrupt part looks very suspicious. Does the
vendor stack do the same thing?

It's hard to believe Rockchip would release performance-critical and
hype-heavy silicon which can't properly raise the most often triggered
interrupt in its critical path, so there must be something else going
on here.

One theory could be that the interrupt bits are not "read-only" per
se, but rather gated inactive by some internal hardware state which
must be cleared before jobs are submitted (e.g. some buffers not
drained, or init sequence not completed, or voltages/frequencies not
set, or memory mappings not written out, ...). If so, this same
hardware state (or something related to it) may well be the cause of
your observed "first (forced) job completes, others don't".

Best regards,
Alexey
