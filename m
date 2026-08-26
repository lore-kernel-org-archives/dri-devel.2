Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEFCC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6F110EDEB;
	Wed, 26 Aug 2026 19:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J5c9IVnr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8827C10EDEB
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 19:48:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78695601E9;
 Wed, 26 Aug 2026 19:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0362C1F000E9;
 Wed, 26 Aug 2026 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787773722;
 bh=UdJU2ZfdTHzLDjBgTfwcXxgJGwDRctAFfJERRW58dtQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J5c9IVnr+86/WVnLX33/u97ViWVd9rZPstsy5Xw1LQcd1cprfoJisES9d5ohO+YVd
 A8d1nBHhlNC6B8NhjPSUnQlywv7xRmBKyvet5Boe3AJ5VUZKArldYySs8MSRSx3asf
 d4kPAqcRauyoaFjsb5Ju3wMHK3Vu6OKHHOK0/IsRQE75LHr7OCD8ybGXRr6G0633np
 xm2DNzjezqx6HyuVbSm5JyU9G/MzbFGi4An9hkNlpN0x+FCFQCGEt5VlfiqDmaQLW+
 wTr1UiPoTBpRXV7orJQg/bfczxt84NTJ6eH0Cb5tFtdjTDAEPbHJ+RkM/Zg5AiI5vD
 yC9GFG9QZH9gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: close DDC on I2C engine setup failure
To: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826193602.6441-2-neptune@imm0nv1nhtv.is-a.dev>
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826193602.6441-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826193602.6441-2-neptune@imm0nv1nhtv.is-a.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 19:48:41 +0000
Message-Id: <20260826194842.0362C1F000E9@smtp.kernel.org>
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
- [High] Lockless read-modify-write of the shared `pool->i2c_hw_buffer_in_u=
se` flag allows concurrent access to hardware I2C resources.
--

commit 12dc016e9bb9b2e123aaf512011f08b0b29e4bd1
Author: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>

drm/amd/display: close DDC on I2C engine setup failure

acquire_i2c_hw_engine() opens the DDC pins before setting up the
hardware engine. If setup_engine() fails, the error path releases the
engine but leaves the DDC pins open and the engine's DDC pointer set.

> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gp=
u/drm/amd/display/dc/dce/dce_i2c_hw.c
> index 05892ab4529f6..e7a05494abab0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> @@ -485,6 +485,8 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
> =20
>  	if (!setup_engine(dce_i2c_hw)) {
>  		release_engine(dce_i2c_hw);
> +		dal_ddc_close(dce_i2c_hw->ddc);
> +		dce_i2c_hw->ddc =3D NULL;
>  		return NULL;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does this lockless read-modify-write of t=
he
shared pool->i2c_hw_buffer_in_use flag allow concurrent access to hardware =
I2C
resources?

In drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c:acquire_i2c_hw_engine(),
there is an initial lockless check:

    if (pool->i2c_hw_buffer_in_use || !is_engine_available(dce_i2c_hw))
        return NULL;

And shortly after this diff hunk, it sets the flag:

    pool->i2c_hw_buffer_in_use =3D true;

Since amdgpu_dm_i2c_xfer() is called by the Linux I2C core, it serializes
operations per-adapter (per port). However, different DDC ports have differ=
ent
adapters and can run concurrently. If they call dc_submit_i2c() ->
dce_i2c_submit_command() -> acquire_i2c_hw_engine() without taking a
driver-wide lock to serialize access across the single shared resource_pool,
both threads can read false and bypass the exclusion.

This could lead to hardware I2C data corruption or engine lockups.
Furthermore, one thread could clear the flag prematurely in
dce_i2c_submit_command_hw() while the other is still active, corrupting the
state machine and allowing a third thread to incorrectly enter. Userspace c=
an
trigger this trivially by opening multiple /dev/i2c-* nodes for different A=
MD
display ports and issuing I2C transactions simultaneously.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826193602.6441=
-1-neptune@imm0nv1nhtv.is-a.dev?part=3D2
