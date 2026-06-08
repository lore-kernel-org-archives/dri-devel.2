Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563E5CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 01:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F17210EBDB;
	Mon,  8 Jun 2026 01:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cfQn6aMH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4724910EBDB
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 01:24:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 682F960018;
 Mon,  8 Jun 2026 01:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C8F1F00893;
 Mon,  8 Jun 2026 01:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780881878;
 bh=vFm+1YYibw9mO2cCAqJAlSQ/L3G8/UEYDLnrwBbQ3I4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cfQn6aMH6X5OwTBlBVFDKiB7sDctP6GEAWF/tH86Ncy7qUTuOZ5skwnSSDZwIckNT
 LMr3Fxrrhxw1lPP8+wIpmAwdCDrUSkEI3Yu+LUOjDZ6OwAFlpd1BB2eiTas+YKzPCJ
 qJDFvTrIhDD2TdzmmSRyavBy57GjKKUQpg9bWy7JUNocNSUaItXVI++okpj9uXHUkz
 J6ZOAQUWZVjwuTZPfrCznGjtNszZXV8GLpmWL0yBBGgJdq20Dxt8w30ZXaeZKx4U4z
 DHrrOu4mSYBWuABNjA+IwlD+lrahfYEm/3sGQMm/4ELIrgaR0oZT1gZFQD9567bVJs
 BQPMchsTTrkTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: fix refcount leak in
 vmw_resource_do_validate()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608011503.102981-1-vulab@iscas.ac.cn>
References: <20260608011503.102981-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:24:37 +0000
Message-Id: <20260608012437.F0C8F1F00893@smtp.kernel.org>
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
- [High] Jumping to out_bind_failed on dirty_alloc failure destroys the har=
dware resource without detaching the guest memory (MOB), leading to state d=
esynchronization and invalid hardware commands (-1 ID) being sent to the hy=
pervisor.
--

commit 176a58de892da45c4d3d22e924894efcb6a1de37
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/vmwgfx: fix refcount leak in vmw_resource_do_validate()

This patch attempts to fix a refcount leak in vmw_resource_do_validate()
by jumping to out_bind_failed when func->dirty_alloc() fails, which calls
func->destroy() to balance the resource reference.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/v=
mwgfx/vmwgfx_resource.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
> @@ -402,7 +402,7 @@ static int vmw_resource_do_validate(struct vmw_resour=
ce *res,
>  		if (res->guest_memory_bo->dirty && !res->dirty) {
>  			ret =3D func->dirty_alloc(res);
>  			if (ret)
> -				return ret;
> +				goto out_bind_failed;

[Severity: High]
Does jumping to out_bind_failed here destroy the hardware resource without
detaching the guest memory (MOB)?

If func->dirty_alloc() fails, jumping to out_bind_failed calls
func->destroy(res), which destroys the hardware resource and sets
res->id =3D -1. However, since the MOB was already attached earlier in the
function, skipping func->unbind() and vmw_resource_mob_detach() leaves the
software state out of sync, as vmw_resource_mob_attached(res) remains true.

When the resource is later evicted or released, routines like
vmw_resource_release() or vmw_resource_do_evict() will see the MOB is still
attached and call func->unbind(res).

For example, vmw_gb_surface_unbind() will then use the destroyed res->id
(-1), sending an invalid command (sid =3D 0xffffffff) to the hypervisor:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_unbind() {
    ...
    cmd3->header.id =3D SVGA_3D_CMD_BIND_GB_SURFACE;
    cmd3->header.size =3D sizeof(cmd3->body);
    cmd3->body.sid =3D res->id;
    cmd3->body.mobid =3D SVGA3D_INVALID_ID;
    ...
}

>  		} else if (!res->guest_memory_bo->dirty && res->dirty) {
>  			func->dirty_free(res);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608011503.1029=
81-1-vulab@iscas.ac.cn?part=3D1
