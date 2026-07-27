Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEE1C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6066010E4B3;
	Mon, 27 Jul 2026 18:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OjqpPLKC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC4A10E4B3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4B7E60008;
 Mon, 27 Jul 2026 18:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486341F00A3A;
 Mon, 27 Jul 2026 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785175343;
 bh=K8zEr3AxMcgSAUm/+5vtKr9k/VqrcIho0XSG3y4CtH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OjqpPLKCrOd1fvCus0AeWXLeGWP2ozG0XtHkTRa1ncnN/hYxt58HxGXQxPRm7RisO
 Jcx8M1g6acWlDl9a2VPPfZxMeT0r+KiD1FsIeo8Uz4qOzjTz20q1pw8sqGwMMQ7ryB
 6MnUDzZW946WNnbu60/xaUbVjJWCxpNTS7QNVqJyT1Qk5sLd/OwOak6pfAZY15bK2e
 2WHoh9YcDbSley7HCy/8TI7HDYqI87uNIrOAhYjCvPX9Po5YNnC4OXn5Uu0/qj4u16
 f73svDgBnPfjawRnv3HWcxcpY5iQ7Coh8K/ydBIht1vcnsKTbz3XKzoaNZUOdghkpx
 xCSyAjQJQ+f7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drm/nouveau/gsp/r570: Set GcOff = 1 in fbsr
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727175246.642071-3-lyude@redhat.com>
References: <20260727175246.642071-1-lyude@redhat.com>
 <20260727175246.642071-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:02:22 +0000
Message-Id: <20260727180223.486341F00A3A@smtp.kernel.org>
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
- [Medium] The commit title states 'Set GcOff =3D 1' but the patch implemen=
tation sets it to 0.
--

--- Patch [2]: [PATCH v4 2/3] drm/nouveau/gsp/r570: Set GcOff =3D 1 in fbsr=
 ---
commit d069cc762363e23906149f0e5723b3c8cac473a5
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Set GcOff =3D 1 in fbsr

This commit modifies the GcOff state setting during FBSR initialization.
It disables GcOff to prevent GSP from saving and restoring buffers that
need to be reinitialized on resume, working around runtime PM issues.

> drm/nouveau/gsp/r570: Set GcOff =3D 1 in fbsr

[Severity: Medium]
Is the commit title incorrect? The commit message explains that disabling
GcOff improves stability, and the code in r570_fbsr_init() explicitly sets
bEnteringGcoffState to 0 instead of 1.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
[ ... ]
> @@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *s=
gt, u64 size)
>  	ctrl->hClient =3D gsp->internal.client.object.handle;
>  	ctrl->hSysMem =3D memlist.handle;
>  	ctrl->sysmemAddrOfSuspendResumeData =3D gsp->sr.meta.addr;
> -	ctrl->bEnteringGcoffState =3D 1;
> +	ctrl->bEnteringGcoffState =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727175246.6420=
71-1-lyude@redhat.com?part=3D2
