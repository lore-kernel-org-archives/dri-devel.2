Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121A4CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 23:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F0C10E32F;
	Sat,  3 Oct 2026 23:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ioDzNt9G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9180F10E32F
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 23:57:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F8AB60052;
 Sat,  3 Oct 2026 23:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA741F0089B;
 Sat,  3 Oct 2026 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791071867;
 bh=f2uAQrVvK8jJJ9MWt8ow/3Y9OPePiB5UMuM2BqD1eew=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ioDzNt9GyE+Pc8AFNJeEDI67EE58pvGMQecke0RwTh9TqnKU1LNNtqxmhV9QektL0
 pRNaWS6GBk2DPKivmFj5mQDaYqvInYwZicqT6H6vmDKix5Cddnwm9smaMTg1JAwitM
 /kVwWKcnZzDyq5Q11ZxoN0hJFkYgActjpXkKxwjSQpcOYN/5CHOlxkwPogGC2VPuQc
 XCK2bpKJSwP20r2O145xlvYIsRgS69dB1DNeUJZhKFFaL5KWfjx2+CfR1GepTYDHfi
 w2UgFGSuqlVwA3m30anH2FBj5z9s/+O5wMJZL+S06s8FhVpYjUDbOybbLJIEjQf7Rp
 TUDAOwDGpXPfA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] drm/nouveau/pmu/gt215: add graphics engine load
 counters
To: "Hamin Sung" <hamin@saltyming.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003234520.69573-1-hamin@saltyming.net>
References: <20261003223420.77993-1-hamin@saltyming.net>
 <20261003234520.69573-1-hamin@saltyming.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 23:57:46 +0000
Message-Id: <20261003235746.EDA741F0089B@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/nouveau/pmu: non-atomic counter read-and-reset causes PMU cy=
cle loss
--

commit b1f69f3978548eb48a40027083a2b64535b82115
Author: Hamin Sung <hamin@saltyming.net>

drm/nouveau/pmu/gt215: add graphics engine load counters

This commit adds initialization and read functions for the PDAEMON idle
counters on GT215 and related GPUs. The counters track PMU clock cycles and
graphics engine busy cycles, returning and clearing the values when read.

Link: https://envytools.readthedocs.io/en/latest/hw/pm/pdaemon/counter.html

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/pmu/gt215.c
> index 32cee21ed8585..37310a8ebe818 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c
[ ... ]
> @@ -260,6 +260,44 @@ gt215_pmu_init(struct nvkm_pmu *pmu)
> +static void
> +gt215_pmu_perfmon_read(struct nvkm_pmu *pmu, u32 *busy, u32 *total)
> +{
> +	struct nvkm_device *device =3D pmu->subdev.device;
> +
> +	*busy =3D nvkm_rd32(device, 0x10a508 + GT215_PMU_COUNTER_GR * 0x10);
> +	*total =3D nvkm_rd32(device, 0x10a508 + GT215_PMU_COUNTER_TOTAL * 0x10);
> +	nvkm_wr32(device, 0x10a508 + GT215_PMU_COUNTER_GR * 0x10, 0x80000000);
> +	nvkm_wr32(device, 0x10a508 + GT215_PMU_COUNTER_TOTAL * 0x10, 0x80000000=
);

[Severity: Medium]
Does this non-atomic counter read-and-reset sequence cause PMU cycle loss?

If a hardware interrupt or CPU preemption occurs between reading the
counters and writing the reset values, any hardware cycles that elapse
during that window are permanently lost from the statistics.

Additionally, a delay between the two reset writes can skew the intervals,
which could result in the busy count exceeding the total count.

A review of the follow-up devfreq patch shows that the caller gracefully
handles the invariant breakage:

if (total && busy <=3D total)
    ...
else
    stat->busy_time =3D stat->total_time;

This mitigates the risk of integer underflow or metrics exceeding 100%.
However, it handles the symptom rather than preventing the permanent
loss of PMU cycles during the unprotected preemption window.

> +
> +	*busy &=3D 0x7fffffff;
> +	*total &=3D 0x7fffffff;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003223420.7799=
3-1-hamin@saltyming.net?part=3D1
