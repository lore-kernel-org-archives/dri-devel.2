Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C45C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D5E10E892;
	Wed, 26 Aug 2026 17:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oq3Ww+Vx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B01510E17C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:21:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 029AA41FA6;
 Wed, 26 Aug 2026 17:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0231F000E9;
 Wed, 26 Aug 2026 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787764916;
 bh=AK8P/mrcdVKDrokAc7WkCMbV53gcnEr2q6mpYYsp+Jk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oq3Ww+VxXhS1ovsu2f0IMcxCavVHgd1D7znYDwMce1P0bp1WSzHjtUpk465ZEgTjk
 uL0Ujoh4XJ22k7pEkcZKT43fWPagusTyUbj5f8UXGF4SwwEX4Z7dIbgvoK3k71VJxl
 wiflwHP2kRTEi1PuTGjYIP2VHSayYwHB+QUcjkSSuNxqIK5QdiAicNCWSZDyECF1Y3
 ManJgAE05Q2m6zHLGO9O/oKE+WVtiagEa2viCvvMcD78sBegp8yeeGPG+TPA4wDVTK
 3eNMOBCChtKT/RTBU0tYTHHDGtXhtxPDTOhvEP6vXuw5JNLBO4Zi+C23o2c5F75CtA
 /kC1trZSUL6Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fall back to software I2C on hardware
 engine failure
To: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:21:56 +0000
Message-Id: <20260826172156.AE0231F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Pre-existing resource leak in acquire_i2c_hw_engine leaves DDC pin=
 permanently open on setup failure.
- [High] TOCTOU race on shared I2C hardware buffer flag `i2c_hw_buffer_in_u=
se` bypasses global mutual exclusion.
--

commit 715340ad0a0bb4f4ee8ee30d4c2c692856bedacf
Author: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>

drm/amd/display: fall back to software I2C on hardware engine failure

This commit implements a fallback mechanism to the bit-banging software I2C
engine when the hardware engine fails to complete longer transfers. It retr=
ies
the transfer on the software engine instead of outright failing, which reso=
lves
EDID read failures on DCE6/Oland hardware.

> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_i2c.c
> index f5261e8d76785..238c17e6f51db 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
> @@ -72,9 +72,16 @@ bool dce_i2c_submit_command(
> =20
>  	dce_i2c_hw =3D acquire_i2c_hw_engine(pool, ddc);

[Severity: High]
This isn't a bug introduced by this patch, but does acquire_i2c_hw_engine()
leak the DDC pin on setup failure?

In acquire_i2c_hw_engine(), dal_ddc_open() is called successfully, but if
the hardware engine is busy (e.g., locked by DMCU), setup_engine() returns
false. The error path then calls release_engine() without calling
dal_ddc_close():

    if (!setup_engine(dce_i2c_hw)) {
        release_engine(dce_i2c_hw);
        return NULL;
    }

This leaves the pin leaked in the opened state. As a result, subsequent cal=
ls
to dal_ddc_open() will return GPIO_RESULT_ALREADY_OPENED, which breaks all
future I2C transfers (and display hotplug/EDID detection) on that port until
reboot. Is there a missing dal_ddc_close() here?

[Severity: High]
This is a pre-existing issue, but does acquire_i2c_hw_engine() have a TOCTOU
race on the shared pool->i2c_hw_buffer_in_use flag?

The function checks and sets pool->i2c_hw_buffer_in_use without a global
lock:

    if (pool->i2c_hw_buffer_in_use || !is_engine_available(dce_i2c_hw))
        return NULL;
    ...
    pool->i2c_hw_buffer_in_use =3D true;

Because I2C adapter locks in amdgpu_dm_i2c_xfer() are per-connector,
concurrent I2C transfers on different display connectors can execute
acquire_i2c_hw_engine() simultaneously. Both threads can read
pool->i2c_hw_buffer_in_use as false, proceed to configure their respective
hardware engines concurrently, and set the flag to true. Can this bypass
global mutual exclusion and cause hardware timeouts or corrupted I2C
transactions?

> -	if (dce_i2c_hw)
> -		return dce_i2c_submit_command_hw(pool, ddc, cmd, dce_i2c_hw);
> +	if (dce_i2c_hw && dce_i2c_submit_command_hw(pool, ddc, cmd, dce_i2c_hw))
> +		return true;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826170549.2198=
5-1-neptune@imm0nv1nhtv.is-a.dev?part=3D1
