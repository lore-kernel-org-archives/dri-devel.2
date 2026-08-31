Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE10C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E10110E167;
	Mon, 31 Aug 2026 07:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="rC735Pkb";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62C810E167
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:20:21 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-936dfd009d1so416712885a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 00:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788160820; cv=none;
 d=google.com; s=arc-20260327;
 b=nwqrRB8bOvDMFMLtuSDLCnMoHfXjaMC6YgXppmQD9E94RqwhIuIzX6bbqUJor0hJBY
 0UBCVKyv0jPpD30mMtITajhNqeFAf+jFaiRY6YA2RHxWxoFQpdW3/1E//BZWDLf0ZuAU
 7uqW0DiNLjJRNfBU+GYloOEJLpZsWo0bHIOKlAbwmQXdCpCFhfv363U1RnWrn4VTN2iU
 Z3fLQX27eSgLs1BUOYyapo7hpxMaC5qQKtb+N5YUxkhVTIFk5atKpOEmoDNj3WVAkk83
 nJLuS2T6eJz+DDHtm1b77+CuXr947V2r7+MmzUMN/S7Pjyag7pMuHG8PMvrac8RF3DMY
 10Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bFWfbb/gIctZHoo0CDVoZsBSY4wt/NAsN/U4bJzB5KM=;
 fh=DONzrOtbUOnoydYtBzDLsTJfOj4e4r8aI4NqMFUP+MY=;
 b=icbKCeKqfx5yqz7TKkAQJFhj/KwrJ11uqmUggHqew95IEwkIn1JekZzrVMedw+k4ja
 jBtQnu/k2nSEdEaOT4votuX66DKvOvrGd5MVBhRgG787OeR1G51ZkKuRy+/A3Oo593Oc
 R4CZpoo7fK210U4rQHOdUaZUSJpjvnSzGX2y1Z2F5o59u3WF/cwxnwLQzbKMwoUHQjAq
 I1SsixOAPD5zFzbk+V/6wElLJVxOm22JBBndE1AnaPL0I4OoSFFIWu2mSUOgnCXiTqGF
 uj2ZWxAjoCCZSPNmHA6w0MDfrB2vo0BWHSA6ubyX4HcX8M2LBhqJch5G20qrLXARL2Fb
 Ec9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1788160820;
 x=1788765620; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bFWfbb/gIctZHoo0CDVoZsBSY4wt/NAsN/U4bJzB5KM=;
 b=rC735PkbOm1TIfRAmYco2ZaxeMK68BPbb18DhqDIwa2Yp7Cbu3S9AMRIxqb2X1oXce
 ZJRPJjjCVCssv/njf7FjS84hO/njjeW++MOpfZp7JzK+xVMmHKV+W9S9I/A01dqfsoeT
 8UrsWO6m/TStMTe3XiGrTIMq7L3Oj56kd7q8Vo8iTB6yikWMaFrtYdq/LSog9WBHk3bi
 qhGWY4WAgHYaEidoU7OzkVjIzR1/c07JhXDOCY+vlqrucji173OArSSZAtWmQU3yM9S8
 jXmwG9292MeFp5pfJPdQENMnuDwhgiC70ZA0fT2XJaAgWzyUucpxWolxD7ZsUYCyav3D
 41EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788160820; x=1788765620;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bFWfbb/gIctZHoo0CDVoZsBSY4wt/NAsN/U4bJzB5KM=;
 b=R94YOv56gFYY6+QDawkbsyRwoR3VSGtGRcW1bta5RaEgxhXvN6TVJXpmmU59fSRUR8
 P3GMU+Lw68GNix/W7CtVSnFPWh/H2LmPsSpEW4F4sLpxuhDYYeRfre47hthrIBlzgkGP
 ZRE3pdHaf+I/faXd+YyDOu/2Y9TPYNZYoXgMF7rDgL/BmnsaSN4rnXuW+AsV9fBygVWr
 5JbKXH6ANtYTrCSV0GSMWSPiJeoeVX5DamJMbMsWyFJ4DO7qPkDLd5HTkqR35zAYi4rA
 yCcPEZLGWMLvQ8ba6ioLcv4CI6QV2Gs0yeEWjiw+4/oUqlYxOnle54wCxOgST+Sow3iT
 wBgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDAWU6697MEFWDl6H80WH0fGyniwlMN5UhUQKxDjXKH2EHXk6a2+LosBEomI/73u8QQk036xpZI+A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kTHE+9m7QVOdOlAq6cLG+LWOgkVxHChrTQlB5sb3ywx8YdW4+p
 TlsWYFzhoBs6Vu/l7UZmQ6zUTgSdxjs89HR9Zyeu2s8n42+nymLNVHe1W4HafWVNGQDoiu3FmMg
 /Pu30P5IW6B7vpi0L7TaU8i40Nf2gVa1nsiYCLFQXPA==
X-Gm-Gg: AR+sD10cYnu/Xh2ZDNoUuotBjVLvtSnrhgc9XRWdBc17AP2eGmurjIgeWXhxAh7hrsZ
 ACqPR2shVkpNI9Y5+dEhrwcjp+Ru4xAM/QnwM+LQ+hRk7oGMYfzuGpqLrf7Fa+RNELhhFz+y4dt
 1KrAI+E5klCFMKPvsfJbEur94q03k7h/mOZY4Nr3xqlDQrQd5q1VnQ2Z7RRvpjkKetVCTzyf4JT
 36UUa+7JCrBM/Lyr6Cg4dC8pn8TaTh/sLYCFkprZg7kNh1AW2r2nk7rME5rq7okX5tb5bp745TZ
 ye8DV8zZUX0U1e4Du8ezhtGsLXoTfeJU5re2T9T1+OAI
X-Received: by 2002:a05:620a:1d02:b0:939:619:c6eb with SMTP id
 af79cd13be357-93936c7a141mr714176285a.8.1788160820472; Mon, 31 Aug 2026
 00:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260831040804.24111-1-gahing@gahingwoo.com>
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 31 Aug 2026 09:20:09 +0200
X-Gm-Features: AcwNN1Uwr5NzEhJ7J-T4GkpAbcQEn3hzAH0qQngAbR_wX7Qh73vwn6zU-qNzhjg
Message-ID: <CAPsqS2TGXOCOL8BzaJ4NaJqtuKid7vhRdJq-80ngGxhNN_UWCw@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org, 
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com, 
 royalnet026@gmail.com, u.kleine-koenig@baylibre.com, 
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
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

On Mon, Aug 31, 2026 at 6:08=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Based on Igor Paunovic's "[PATCH v2] accel/rocket: request the core
> clocks by name", as v6 through v9 were.
>
>   https://lore.kernel.org/linux-rockchip/20260729130743.128876-1-royalnet=
026@gmail.com/
>
> Tested on a Radxa ROCK 4D, on next-20260814. The tree is byte identical
> to v9, so that is the same test rather than a new one.
>
> This adds the RK3576 NPU to accel/rocket, which today supports RK3588
> only. The RK3576 carries two cores of the same RKNN block, wired up
> differently. Two extra convolution buffer clocks, two power domains per
> core, one reset rather than two, no NPU SRAM rail, and a PC_TASK_CON
> that packs the task number into sixteen bits rather than twelve.
>
> What changed since v9
>
> No code. Every patch's diff is byte identical to its v9 counterpart, and
> below the --- the only change anywhere is 5/13's git note. Above it, six
> commit messages each gained one trailer line and nothing else. Six tags,
> that note, and the base-commit trailers back where v8 had them.
>
> The note first, because v9's cover letter said 5/13 carried it and the
> posted mail did not. Rob Herring's bot asked on v8 for the dependency to
> be recorded in the patch rather than only in the letter, v9 said it was
> there, and it was not: my send script never passed --notes. Igor
> Paunovic noticed while applying the series and said so before v10 rather
> than after, and he had the cause right. Nothing was lost in a rebase;
> the flag was missing. The script now regenerates with --notes and
> refuses to send unless exactly one patch carries a Notes block.
>
> Igor also ran the 19 August protocol again on v9 as posted, on RK3588,
> an Orange Pi 5 Plus with all three cores bound, PROVE_LOCKING=3Dy and
> DEBUG_ATOMIC_SLEEP=3Dy, and a local test-only patch lowering
> JOB_TIMEOUT_MS to 2 ms so healthy jobs cross the timeout. Two passes per
> kernel at console loglevel 8 and 4, serial captured on a second machine.
>
>   v9, two passes         12 and 11 induced resets, all recovered,
>                          48 of 48 within 1 on both, including the
>                          inference after a forced autosuspend and
>                          resume. No MMU faults, no lockdep hits,
>                          nothing on the console.
>
>   without 1 and 2/13,    8, 10, 12, 8 and 15 induced resets, all
>   five runs in the       recovered. Four runs clean. In the
>   same session           remaining one the inference after autosuspend
>                          reported success and returned a constant
>                          buffer, all 48 output channels at 0x80,
>                          which is not this model's output zero
>                          point, while the CPU reference varied
>                          normally. Zero kernel messages, zero
>                          lockdep hits, nothing on the console.
>
>   1, 2 and 3/13 only,    13 and 13 induced resets, all recovered,
>   two passes             oracle 48 of 48 throughout, including after a
>                          forced autosuspend and resume. On the 1+2 arm
>                          a round that ends in a timeout leaves the
>                          affected core runtime-active even through a
>                          forced autosuspend; with 3/13 applied the same
>                          sequence leaves all three cores suspended.
>                          That arm is where 3/13's Tested-by comes from.
>
> A job that signals completion while its output buffer is never written
> is the silent form of the race 1/13 and 2/13 close, and across 102
> induced resets in nine runs that day it appeared only on the arm without
> them. It is a better statement of what those two patches are for than
> anything my own logs have caught, which has always been the loud form:
> a message, a wrong answer, something to look at.
>
> The tags, and where each came from:
>
>   02/13  Tested-by: Igor Paunovic   # RK3588, three cores, induced
>                                     # reset, differential base,
>                                     # JOB_TIMEOUT_MS=3D2
>   03/13  Tested-by: Igor Paunovic   # RK3588, three cores, induced
>                                     # reset, JOB_TIMEOUT_MS=3D2
>   06/13  Acked-by: Conor Dooley
>   07/13  Acked-by: Conor Dooley
>   08/13  Reviewed-by: Abel Vesa
>   09/13  Reviewed-by: Abel Vesa
>
> The two Tested-by comments are not the same string, and that is how they
> were given. 1/13, 4/13 and 5/13 keep the tags they had; Igor checked befo=
re
> testing that 1/13 is byte identical to v8 1/12 up to the base-commit
> trailer and 4/13 identical to v8 3/12, so those tags still describe what
> was tested.
>
> The bindings are unchanged since v9, where dt_binding_check was clean on
> all three with dtschema 2026.6 and yamllint 1.38.0, and CHECK_DTBS was
> clean on all 13 rk3576 and all 48 rk3588 dtbs.
>
> Two things I raised in v9 and would still rather hear about than guess
> at. 8/13 does three things: it adds the settle delay, renames a macro,
> and gives RK3576_PD_NPU a regulator, which also makes every RK3576 board
> force that domain off at probe. I asked whether it wants splitting;
> Abel Vesa's Reviewed-by may be the answer, but nobody has said so, and I
> would rather split it than have it merged on my silence. And 12/13 gives
> each core both NPU domains, which is the description that has been
> tested here rather than the topology; if it should be one domain per
> core, 5/13's minItems has to change with it. That one has had no reply
> at all.
>
> Nothing else moved.
>
> Jiaxing Hu (13):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain/rockchip: add optional per-domain power-on settle delay
>   pmdomain/rockchip: cycle optional power-domain resets on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
>   arm64: dts: rockchip: rk3576-rock-4d: enable NPU
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 +++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 ++++++-
>  .../power/rockchip,power-controller.yaml      |   8 ++
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  13 ++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  82 +++++++++++-
>  drivers/accel/rocket/rocket_core.c            |  28 ++++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  28 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 119 ++++++++++++++----
>  drivers/pmdomain/rockchip/pm-domains.c        |  75 +++++++----
>  12 files changed, 385 insertions(+), 63 deletions(-)
>
>
> base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
> prerequisite-patch-id: 46ebb679e93d3d25393e8cbf8fc3c955bcc01bd4

Hi Jiaxing,

I want to get soon to review this and the other pending rocket series,
and in the meantime something that could help this moving would be to
get a review from Sashiko.

As you can see in [0], Sashiko is not reviewing this series because it
doesn't not understand yet prerequisite-patch-id. Can you please
resubmit the series with Igor's (presumably) patches bundled in it?

[0] https://sashiko.dev/#/patchset/20260831040804.24111-1-gahing%40gahingwo=
o.com

Thanks,

Tomeu
