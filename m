Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C37C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F52910E121;
	Wed, 26 Aug 2026 20:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BYkAFZDM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFC710E10E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 20:55:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BCF260254;
 Wed, 26 Aug 2026 20:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D840A1F00A3A;
 Wed, 26 Aug 2026 20:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787777728;
 bh=Qs09iXGa7k8skU18YGKUJjBArT/x8kI266FQsJurcQY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BYkAFZDM1U805k0Ua0180OrpDaikxmh0zE/CDU4ea+yFI8mDoUxRgim0GxSQmQw+M
 y+YYi7cE8zZMZoYoDDclxAseRmeZiVjOZWxBBQtBu3zo0GAWFPXUecvXVTmk8xkvKG
 XJ6b4dgHDth6T5Fc79W95s38qIurfPrkUTJVEeFV+Zk9NDu4wB1QJGbyfz5s6wet8I
 Xly5U1JYNdZ55a7vO0URKIrqRHGO0OlpBIoE7zaaVYaceOpZa97RTwSuIzF1UHr+6Y
 MrsCKPtcrXbO7wOxJdKTzNpqCtofEoSTGBOBgMo81r6qPuLDReuL8iPERKlJ/raExo
 kiq7ceIvVjyuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/amd/display: close DDC on I2C engine setup
 failure
To: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826204457.4666-2-neptune@imm0nv1nhtv.is-a.dev>
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826204457.4666-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826204457.4666-2-neptune@imm0nv1nhtv.is-a.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 20:55:27 +0000
Message-Id: <20260826205527.D840A1F00A3A@smtp.kernel.org>
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
- [High] Lockless access to the shared `pool->i2c_hw_buffer_in_use` flag al=
lows concurrent HW I2C engine usage across different display connectors.
--

commit e10eae8a87c1382752a4ccbab3d8554652f1a66a
Author: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>

drm/amd/display: close DDC on I2C engine setup failure

This commit ensures the DDC pins are closed and the DDC pointer is cleared =
if
I2C hardware engine setup fails. This prevents the port from becoming
permanently blocked due to the pins remaining open.

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
This isn't a bug introduced by this patch, but is it possible for concurrent
I2C transfers to bypass the pool lock and corrupt the hardware buffer?

Earlier in acquire_i2c_hw_engine(), there is a lockless check of
the shared pool state:

	if (pool->i2c_hw_buffer_in_use || !is_engine_available(dce_i2c_hw))
		return NULL;

If two different I2C adapters initiate transfers concurrently, they are
serialized locally by their per-adapter I2C bus lock, but they can enter
acquire_i2c_hw_engine() simultaneously because they share the same GPU
resource pool.

Both threads could read pool->i2c_hw_buffer_in_use as false at the same
time, proceed to acquire their respective hardware engines, and then both
update the state locklessly at the end of this function:

	pool->i2c_hw_buffer_in_use =3D true;

Could this race condition be triggered by concurrent I2C accesses via
userspace tools (like ddcutil) or simultaneous hotplug events, leading to
concurrent access and I2C payload corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826170549.2198=
5-1-neptune@imm0nv1nhtv.is-a.dev?part=3D2
