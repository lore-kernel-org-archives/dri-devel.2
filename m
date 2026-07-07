Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48A5C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB3110ED78;
	Tue,  7 Jul 2026 14:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZLyco0oJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F8C10ED6B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B46960018;
 Tue,  7 Jul 2026 14:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3351F00A3A;
 Tue,  7 Jul 2026 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433567;
 bh=C8z4TkRdiQXYLPL88m6Ex7t8du1pcozUfYQ+YyBPPW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZLyco0oJ71xyyL/PvSSdVYCXuEO/fpxgamdCCfMeAAA03KakvFnpzwzP265VDz5bk
 l0ufmNVRnTTN1oHkS1/FR+aQRRJZpd/Rmj7A5+CXmoXrWvgYNCUCzZ2JXaxiibH6aF
 zUa8iC6T8KaDWVZEnDdEAvtEILDRFdpE8nXr9/bIrMt9fart82J6Gm5CeAH78pyv+m
 22/aSl/RTLu3YOQC7EpfawF7gaqMEQSyNI3Y0x9hYdDML1OlOWONhJqRGZpTTkorK0
 5hQaFzj+GVEjbc4Td5LwsW7AFiGurZz0GCukrDRMmDf2BZUYtYgif/X1YcMJPTKD6o
 8uBSqADqHAwQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] vga_switcheroo: Add pre_switch callback to client
 ops
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707135724.247562-4-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
 <20260707135724.247562-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:47 +0000
Message-Id: <20260707141247.8C3351F00A3A@smtp.kernel.org>
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

New issues:
- [Low] Duplicate and conflicting kernel-doc entry for `@gpu_bound` instead=
 of `@pre_switch`.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but if the hardware =
mux switch fails, the active client is permanently marked as inactive, brea=
king the vga_switcheroo state machine.
--

--- Patch [3]: [PATCH 03/10] vga_switcheroo: Add pre_switch callback to cli=
ent ops ---
commit 5537cd5fab2c2375821fd4433e71171511ada8ff
Author: Thomas Zimmermann <tzimmermann@suse.de>

vga_switcheroo: Add pre_switch callback to client ops

This commit adds a pre_switch callback to vga_switcheroo_client_ops to
inform clients about upcoming output switches, replacing the hard-coded
fb_switch_outputs() call.

> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switc=
heroo.c
> index 22cf52b78b755..bdf1e56ae8910 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -733,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switcheroo=
_client *new_client)
>  	if (!active->driver_power_control)
>  		set_audio_state(active->id, VGA_SWITCHEROO_OFF);
> =20
> +	if (new_client->ops->pre_switch)
> +		new_client->ops->pre_switch(new_client->pdev);
>  #if defined(CONFIG_FB)
> -	if (new_client->fb_info)
> +	else if (new_client->fb_info)
>  		fb_switch_outputs(new_client->fb_info);
>  #endif
> =20

[Severity: High]
This is a pre-existing issue, but does vga_switchto_stage2() leave the
state machine corrupted if the hardware mux switch fails?

Earlier in vga_switchto_stage2(), the active client is marked as inactive:

	active->active =3D false;

If the handler's switchto() callback fails shortly after this patch's
hunk:

	ret =3D vgasr_priv.handler->switchto(new_client->id);
	mutex_unlock(&vgasr_priv.mux_hw_lock);
	if (ret)
		return ret;

Will returning early here leave the original active client permanently
marked as inactive? Since find_active_client() relies on this flag, it
appears subsequent switch commands would silently abort because they
can no longer find an active client. Should the active flag be restored
in this error path?

> diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switchero=
o.h
> index 7e6ac0114d556..d2ce30d8b6f78 100644
> --- a/include/linux/vga_switcheroo.h
> +++ b/include/linux/vga_switcheroo.h
> @@ -127,23 +127,29 @@ struct vga_switcheroo_handler {
>   * @set_gpu_state: do the equivalent of suspend/resume for the card.
>   * 	Mandatory. This should not cut power to the discrete GPU,
>   * 	which is the job of the handler
> + * @gpu_bound: Optional. Called before switching the outputs to the devi=
ce.

[Severity: Low]
This isn't a bug, but should this be named @pre_switch instead of
@gpu_bound?=20

It looks like @gpu_bound is already defined further down in this struct's
documentation, and this new description matches the purpose of the new
pre_switch callback.

>   * @reprobe: poll outputs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135724.2475=
62-1-tzimmermann@suse.de?part=3D3
