Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EADC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E6C10E03A;
	Thu,  9 Jul 2026 09:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XIvH2ZZU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2200410E03A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:31:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCEA343AB4;
 Thu,  9 Jul 2026 09:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867441F000E9;
 Thu,  9 Jul 2026 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783589481;
 bh=9KHmrYZezRu4RAs4+k8HZFiVAVrgezoo/srtoOSDxsI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XIvH2ZZUJGKvMiJoeXTH4jXdmExelr89UMEnbVMwUsn9ejpNv1txQ42f5+yhX54Lh
 b/V8YYd4FPzwQbQ8B+5LCezhZdeKQo2CrbU8dLF1uZDzr7U16ipzHU9IIT9nIqWoGP
 1PyBE+SjA4S+fNgMnIZ+wuCKDC1Ic4k9F28Ood+6Vzdp/j5mF53J/y8uHuFUDJ7zB+
 nwLopZgFXodEANThHAG8sZjhcS7NcxR5QVQlucOlX60hGcLVIvhH5+wR2e0bcYQAB8
 YaGPdQxsio7z11fPK/LlP5hv02+Of6b3LTBS7hqTgQcAyq+1gsczZZklOv8mDXU+FG
 T3c1dRL+XsrAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] vga_switcheroo: Add post_switch callback to
 client ops
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709092215.168172-5-tzimmermann@suse.de>
References: <20260709092215.168172-1-tzimmermann@suse.de>
 <20260709092215.168172-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 09:31:21 +0000
Message-Id: <20260709093121.867441F000E9@smtp.kernel.org>
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
- [High] Hardware failure during mux switch leaves vga_switcheroo in an unr=
ecoverable state with no active client.
--

--- Patch [4]: [PATCH v2 4/7] vga_switcheroo: Add post_switch callback to c=
lient ops ---
commit e87434614b85f1234ff64f6a0aeb8bd282739a69
Author: Thomas Zimmermann <tzimmermann@suse.de>

vga_switcheroo: Add post_switch callback to client ops

This patch adds a new post_switch callback to struct
vga_switcheroo_client_ops to notify clients about a completed output switch.
This callback is intended to replace the deprecated reprobe client operatio=
n.

> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switc=
heroo.c
> index bdf1e56ae8910..7b0af4a8aa7d0 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -746,7 +746,9 @@ static int vga_switchto_stage2(struct vga_switcheroo_=
client *new_client)

[ ... ]

>  	mutex_lock(&vgasr_priv.mux_hw_lock);
>  	ret =3D vgasr_priv.handler->switchto(new_client->id);
>  	mutex_unlock(&vgasr_priv.mux_hw_lock);
>  	if (ret)
>  		return ret;

[Severity: High]
This is a pre-existing issue, but if the hardware switch fails and returns =
an
error code here, does this leave the state machine unrecoverable?

Earlier in vga_switchto_stage2(), the active client is found and its active
flag is cleared:

drivers/gpu/vga/vga_switcheroo.c:vga_switchto_stage2() {
	active =3D find_active_client(&vgasr_priv.clients);
	if (!active)
		return 0;

	active->active =3D false;
	...

If vgasr_priv.handler->switchto() returns an error, the early return happens
without restoring active->active to true. This appears to leave the subsyst=
em
with no active client, causing subsequent calls to find_active_client() to
fail and preventing any future GPU switches until a module reload or reboot.
Should the active flag be restored on this error path?

> =20
> -	if (new_client->ops->reprobe)
> +	if (new_client->ops->post_switch)
> +		new_client->ops->post_switch(new_client->pdev);
> +	else if (new_client->ops->reprobe)
>  		new_client->ops->reprobe(new_client->pdev);
> =20
>  	if (vga_switcheroo_pwr_state(active) =3D=3D VGA_SWITCHEROO_ON)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709092215.1681=
72-1-tzimmermann@suse.de?part=3D4
