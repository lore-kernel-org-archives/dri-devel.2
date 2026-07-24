Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD66C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF5010F25D;
	Fri, 24 Jul 2026 00:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jvynWntB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FCD10F25D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:08:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E6544361E;
 Fri, 24 Jul 2026 00:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0A11F000E9;
 Fri, 24 Jul 2026 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784851705;
 bh=S2IoASVP1juVBMSMsDLb0+ugKx8tAWD9DQwcmyvI8n0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jvynWntBRdcBxBYf9oYyM7g/KosnKaTdPWzsCpkCZ1N7dPOA/pZ606E6i8gJcFB5V
 9HDL67yg35dcexIyPiYy2q00XEH5fG/T7UiT+wrUwZaFNX2PzBEhAJDYwiUrFrAeNf
 6u2tktqxyxlGTac9AqGVUZFx8IY0sQUzCc1m/PYxnJaogJznKNPthShuqCmBpOD3eU
 wqwaCe9zWX8R2UP/wTcs10TAD+JPgr0XVmLWZZP2+wmqQzDuFKjxEo+j4EFuBIWEd9
 uxl9ag2O+TZeWKthYNcVrGcoapeeTEBEIgNdt3/rYRJ58lk2uuNlW1VuSEN0Ybije2
 s/8vHijUqb39A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] drm/panfrost: Prevent division by 0
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-2-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-2-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:08:24 +0000
Message-Id: <20260724000824.DC0A11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Multiplication of `status->busy_time` by 100 overflows the 32-bi=
t `unsigned long` type on 32-bit architectures, leading to completely incor=
rect utilization percentages in the debug output.
- [Medium] Meaningful code and commit message mismatch regarding the clampi=
ng logic.
--

--- Patch [2]: [PATCH v3 02/13] drm/panfrost: Prevent division by 0 ---
commit 5fb0fa4b6ede9db49d32560487844d56d5235d47
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Prevent division by 0
   =20
When updating and debug-printing devfreq stats, in the very unlikely
offchance that total device time is less than 100 ns, clamp it to 0 to
avoid division by 0.

[Severity: Medium]
The commit message says "clamp it to 0 to avoid division by 0". Is this
description accurate? Clamping a divisor to 0 would guarantee a division
by zero, and the actual code clamps the minimum value to 1 instead of 0.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index b51c307788110..0fe81d259274e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,7 +78,7 @@ static int panfrost_devfreq_get_dev_status(struct devic=
e *dev,
> =20
>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>  		status->busy_time, status->total_time,
> -		status->busy_time / (status->total_time / 100),
> +		status->busy_time * 100 / MAX(status->total_time, 1),

[Severity: Medium]
Will this multiplication overflow on 32-bit architectures?

Because `status->busy_time` is in nanoseconds, a fully busy GPU over a typi=
cal
50ms devfreq polling interval results in 50,000,000 ns. Multiplying this by=
 100
yields 5,000,000,000, which exceeds ULONG_MAX (4,294,967,295) on 32-bit sys=
tems
and would wrap around, reporting a roughly 14% utilization instead of 100%.

>  		status->current_frequency / 1000 / 1000);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D2
