Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953C0CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED67610E849;
	Tue, 16 Jun 2026 06:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ANqxB3rb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC6410E840
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 06:29:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 985CF601E1;
 Tue, 16 Jun 2026 06:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3261F000E9;
 Tue, 16 Jun 2026 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781591395;
 bh=GaGnbuaHmanJqEhAvcvvUfMWra7s0De1/R491K0mhgk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ANqxB3rb2+yOlZ2LRI8DstAyw3DYa9XWFt5jeL/50cK5arAIzEDfFfZZHpVdOCfvc
 MUR2Kx9NnN+v5fhAuS7NRiV8zOI0jgr7gw/bHKO+hnGRvO3M+93PYzUKbfD1l6y/Ja
 NgBxHE+1AGnewNyAjN1hTlULdKQjV1fQmE1ofa6VplwiRd/hIHbG3qEnyhzn+Xa253
 TwZdYUUg81lpmV7oZS01IW3epy5NGKxo3xx7hyQEsFMZQB1oWmOLciKCPMFA/aAQzG
 ltk6Y2eI/zACsJhYwT1ABcdp29N4c1Map5xFYeBvHLdKatkXlAmgh78fTDYWgPSRWI
 F6UwH3+ndp2/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616062008.3533989-1-lizhi.hou@amd.com>
References: <20260616062008.3533989-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:29:54 +0000
Message-Id: <20260616062955.3B3261F000E9@smtp.kernel.org>
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
- [High] Mixing `goto` and `guard()` causes undefined behavior/build error
--

commit e82723d9f7a656583eeaed6e8880da6e23ecb6df
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Prevent PM resume deadlock in hwctx_sync_debug_bo()

This commit reorders amdxdna_pm_resume_get() to execute before acquiring
xdna->dev_lock. This prevents a potential deadlock that occurs if the
device is suspended during the callback.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 855da8c79a1cd..20e2fd096c913 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -412,16 +412,25 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_clie=
nt *client, u32 debug_bo_hdl)
>  	if (!gobj)
>  		return -EINVAL;
> =20
> +	ret =3D amdxdna_pm_resume_get(xdna);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
> +		goto put_obj;
> +	}
> +
>  	abo =3D to_xdna_obj(gobj);
>  	guard(mutex)(&xdna->dev_lock);

[Severity: High]
Does jumping forward over the guard(mutex) declaration with the goto put_obj
statement above trigger a compilation error?

Jumping over a variable initialized with __attribute__((cleanup)) is usually
rejected by modern compilers. If a compiler allowed it, the destructor would
execute at the end of the function using uninitialized stack memory for the
lock pointer, causing a kernel panic.

Additionally, include/linux/cleanup.h notes that mixing goto-based error
handling and scope-based cleanups in the same function should be avoided to
prevent issues like this.

>  	hwctx =3D xa_load(&client->hwctx_xa, abo->assigned_hwctx);
>  	if (!hwctx) {
>  		ret =3D -EINVAL;
> -		goto put_obj;
> +		goto suspend_put;
>  	}
> =20
>  	ret =3D xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, debug_bo_hdl);
> =20
> +suspend_put:
> +	amdxdna_pm_suspend_put(xdna);
> +
>  put_obj:
>  	drm_gem_object_put(gobj);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616062008.3533=
989-1-lizhi.hou@amd.com?part=3D1
