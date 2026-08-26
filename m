Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8583DC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95E410E352;
	Wed, 26 Aug 2026 21:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FHnrgG+R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDB710E352
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F6624376F;
 Wed, 26 Aug 2026 21:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417241F000E9;
 Wed, 26 Aug 2026 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787779648;
 bh=v8pLp2KbkV7B004I+LWwcHpMdwMCOZheIy1heArNOjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FHnrgG+R1jF2Q5d8vicBUM5hZPaZXTXxQ2D1JG9oro3+ooJRCx7o7Fcqsm4dC+Bq+
 fwRgV0PFWhNfFECGBvLcB+lJ/hsf5J2iEZltcyjtCZ7aOE0nIjRVWl+cLHZkhCWYuJ
 n/jLhOtr51lIxmKBRjr4cgnHKwGMaAgMSByEijbnXaPxXqRgIyt82QOpbWg132y9Re
 Fv07WoGwWsmVUmH/6xi5ybcmzulI5qdF5Pkz0HAzIu6tnZNOAqTG8UXWT988ah73QM
 GLjxLN9OH5FXa7qAORIrZ/0xN8O6dcTLRI3ipKUMzI2cLjgancsf2yYUrYSI5ackDY
 CU4RYh24pagUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/16] drm/panfrost: Add warning messages to fatal
 error conditions
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-9-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-9-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:27:27 +0000
Message-Id: <20260826212728.417241F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unconditional hardware register access after pm_runtime_get_sync()=
 fails causes a bus fault.
--

commit 21c994e3f1ed58edbfb0311aa1649d2c75eb0938
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add warning messages to fatal error conditions

This commit adds warning messages to device removal if it fails to take a PM
reference, and to the PM suspend path if it still reports inflight jobs.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index f6066aef47666..ee4c468b882d4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c

[ ... ]

> @@ -367,7 +368,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> -	pm_runtime_get_sync(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);

[Severity: High]
This is a pre-existing issue, but if pm_runtime_get_sync() fails (for examp=
le,=20
due to a regulator or clock enable failure during runtime resume), the devi=
ce=20
remains unclocked and unpowered.

If execution continues unconditionally, subsequent teardown sequences like
panfrost_device_disable_hw(pfdev) and panfrost_perfcnt_fini(pfdev) will
attempt to write to MMIO registers (such as GPU_PERFCNT_CFG). On ARM platfo=
rms,
writing to MMIO registers of an unpowered or unclocked device typically tri=
ggers
a synchronous external abort and a kernel panic.

Would it be safer to handle the resource acquisition failure by skipping the
hardware-accessing teardown steps when the power on fails?

>  	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D9
