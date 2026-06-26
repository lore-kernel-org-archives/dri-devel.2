Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01F4C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4791610E302;
	Fri, 26 Jun 2026 15:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WwT0RstN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABC810E302
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:10:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DA7442E56;
 Fri, 26 Jun 2026 15:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7BD1F000E9;
 Fri, 26 Jun 2026 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486658;
 bh=jVcR1pkxoxSKmAHB2mhltyvCJy6OuCMldqt9yVmC6/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WwT0RstNq4mQOAiaAEbMOzm4vA0s/11khYWcFHt9e6tdaNnnVegOoGHUtGzweH02M
 Oeg/QoDI4d7+RXv/G9GUfLP+l3qmQhaQAnEHDOtElCs1sKvo6iVb5s05F4o7+sO9F3
 rn3DxUDS2SmyHUgVTu5XAadX9cA0EF1HX57XczM0yhRb3Ba7IqfP8/zEz/5hmNp7We
 Kq2jfTGxTMg0PMEmeqa1RRKoSxUoxhD8EZHbDaW2qRO/qukdoMgTx/HMqySssZdgXC
 XOuClGb7+Wu4POH3PjhHXh6aQyrbf3uCFSHAObMjz5+bNFdD4BufDTluKs4wV8aX4P
 VRBZqjQ85aIqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/nouveau: nvkm_ucgrp_new: nvkm_cgrp_new failure
 leaks ucgrp   object and engine reference
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626144717.49109-1-vulab@iscas.ac.cn>
References: <20260626144717.49109-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:10:57 +0000
Message-Id: <20260626151058.2C7BD1F000E9@smtp.kernel.org>
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
- [Low] The patch adds redundant cleanup code based on a false premise, vio=
lating the Nouveau object lifecycle design.
--

commit bc4fa3965bb025027291bc92ec2fa2ec144efd31
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/nouveau: nvkm_ucgrp_new: nvkm_cgrp_new failure leaks ucgrp object =
and engine reference

This commit attempts to fix a purported resource leak in nvkm_ucgrp_new()
by adding an explicit call to nvkm_object_del() when nvkm_cgrp_new() fails.

>     The caller ignores *pobject on error, so the ucgrp object and its eng=
ine
>     reference are permanently leaked.

Is this description of the caller's behavior accurate?

The core framework caller, nvkm_ioctl_new(), appears to correctly capture
the object pointer and invoke nvkm_object_del() when the constructor
returns an error code. Since *pobject is assigned before the failure in
nvkm_ucgrp_new(), does a leak actually occur here?

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
> index dfa3c7dbdf348..7d11b92f946ba 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
> @@ -113,8 +113,10 @@ nvkm_ucgrp_new(struct nvkm_fifo *fifo, const struct =
nvkm_oclass *oclass, void *a
>  	*pobject =3D &ucgrp->object;
> =20
>  	ret =3D nvkm_cgrp_new(runl, args->v0.name, vmm, true, &ucgrp->cgrp);
> -	if (ret)
> +	if (ret) {
> +		nvkm_object_del(pobject);

[Severity: Low]
Does adding this explicit cleanup conflict with the subsystem's centralized=
=20
object lifecycle design?

Because the framework caller handles the cleanup of partially constructed=20
objects when an error is returned, is this manual call to nvkm_object_del()
redundant?

>  		goto done;
> +	}
> =20
>  	/* Return channel group info to caller. */
>  	args->v0.cgid =3D ucgrp->cgrp->id;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626144717.4910=
9-1-vulab@iscas.ac.cn?part=3D1
