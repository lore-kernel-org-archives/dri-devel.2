Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6408BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D179610F454;
	Thu,  9 Jul 2026 09:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PpKKdwHT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D727110F454
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:32:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E7C941A61;
 Thu,  9 Jul 2026 09:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540B11F000E9;
 Thu,  9 Jul 2026 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783589576;
 bh=U9peSXbQvR6qvGty5Ue4KPqPVYkWTvSy7EkJmXroXkc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PpKKdwHTEllus/JypscZ6N75Mk00PUgjM4SOyuV05FbkD40VNMdmMf1S8tTR9nxZ+
 t3L4gQroiAuRHBPH8CI7H4AVdxTCcbiMSWkjrb1vpmmKN78AQroKxoM0eFw8eTdd/T
 sbWUJoXogxw+xqWvyyEJBB9MGJ1VohSfJxbVFUQdYWzw7G+lTaM+FJO6rHx4tVSMA6
 F8y0IlD0wOe8ctBqkOVjjTly0jTi0UJTGOFe9UYVduETVt79vCE4xj+R5EhoCWi+26
 wUUr6KE9Z+1GIAzylqKUdv2jG56tEk0PP4jVwuxZcVDzC2wgCZCyPNUDjJiEbtc+E0
 L4KX1TgStArkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] vga-switcheroo: Remove unused interfaces
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709092215.168172-8-tzimmermann@suse.de>
References: <20260709092215.168172-1-tzimmermann@suse.de>
 <20260709092215.168172-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 09:32:56 +0000
Message-Id: <20260709093256.540B11F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but `vga_switchto_st=
age2()` leaves the switcheroo system permanently disabled if the hardware s=
witch handler fails. The active client's state is not restored, permanently=
 corrupting the subsystem's state machine.
--

--- Patch [7]: [PATCH v2 7/7] vga-switcheroo: Remove unused interfaces ---
commit ef7b188cece6d285e2c3384cc1c77c0b8424b231
Author: Thomas Zimmermann <tzimmermann@suse.de>

vga-switcheroo: Remove unused interfaces

This commit removes unused interfaces that implemented pre_switch and
post_switch functionality. It specifically removes
vga_switcheroo_client_fb_set() and the reprobe callback from client ops,
cleaning up obsolete code referencing fbdev.

> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switc=
heroo.c
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c

[ ... ]

> @@ -735,10 +712,6 @@ static int vga_switchto_stage2(struct vga_switcheroo=
_client *new_client)
> =20
>  	if (new_client->ops->pre_switch)
>  		new_client->ops->pre_switch(new_client->pdev);
> -#if defined(CONFIG_FB)
> -	else if (new_client->fb_info)
> -		fb_switch_outputs(new_client->fb_info);
> -#endif
> =20
>  	mutex_lock(&vgasr_priv.mux_hw_lock);
>  	ret =3D vgasr_priv.handler->switchto(new_client->id);
>  	mutex_unlock(&vgasr_priv.mux_hw_lock);
>  	if (ret)
>  		return ret;

[Severity: High]
This is a pre-existing issue, but does this error path leave the switcheroo
system permanently disabled if the hardware switch handler fails?

Earlier in vga_switchto_stage2(), the active client is marked inactive
(active->active =3D false) and the audio state might be set to OFF. If
vgasr_priv.handler->switchto() fails, the code returns early without restor=
ing
active->active.

Because the active state is not restored, will find_active_client()
subsequently return NULL, causing future switch requests to silently abort
and leaving the subsystem in a corrupted state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709092215.1681=
72-1-tzimmermann@suse.de?part=3D7
