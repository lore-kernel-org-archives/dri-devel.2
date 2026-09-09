Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7600EC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4ACF10F034;
	Wed,  9 Sep 2026 09:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8SwJ3kG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A07010F02E;
 Wed,  9 Sep 2026 09:09:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1259E40245;
 Wed,  9 Sep 2026 09:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D6A1F00A3D;
 Wed,  9 Sep 2026 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788944949;
 bh=lQ7U3JSSSlXb34w9324YOXzUWElJofA5u0fHhesgvSk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G8SwJ3kGu9YpEvsr/hzsOnD4uy9Ek3QHx5Y8IkzO3cNQW6SFuaJoLDNrGk8W6EQ4G
 OdA+keGYRsJHv8LbYiW8IlexG3uf1z8ZQIHEzHQ5YHQCQMvkI37LR5+E/1aFJkbIsQ
 EkYS6NAEoUchA/sl7GJKEjPFn6sX+GrvhFRENdlGkpj1Wm/hDkogJjiAzDEoUNsPuV
 FZSFscSOYR0hKcqZDV9Te/fsAZZQfj0c8bp8MBWe9U+cqo1YBrBSYbGMs1BucgKreI
 SAuSVeFtp7bwmdm81Vc9kV0zbhSArJ5z4FaUwZOx2XiqLDQprs3H40wwz8D1T229oA
 pZE5Th8a8kjsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/14] drm/panic: Do not use un-escaped URL as format
 string
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 gary@garyguo.net, intel-gfx@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com, "Eugenio
 Perez" <eperezma@redhat.com>, imx@lists.linux.dev,
 virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org
In-Reply-To: <20260909085826.64529-2-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:09:07 +0000
Message-Id: <20260909090908.43D6A1F00A3D@smtp.kernel.org>
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
- [High] NULL pointer dereference in the DRM panic handler via `utsname()` =
if the system panics during task exit.
--

commit 5f4f34c2248e13bf1786a1ff3cbb5f0cbb86fc3d
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Do not use un-escaped URL as format string

This commit replaces the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in
snprintf() with a %s conversion specifier. This change avoids a potential
vulnerability from a crafted URL string.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index e576c4791861d..ba21df4be3380 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -658,7 +658,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
>  	char *kmsg;
>  	int max_qr_data_size, url_len;
> =20
> -	url_len =3D snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_=
URL "?a=3D%s&v=3D%s&z=3D",
> +	url_len =3D snprintf(url, sizeof(url), "%s?a=3D%s&v=3D%s&z=3D",
> +			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
>  			   utsname()->machine, utsname()->release);

[Severity: High]
This is a pre-existing issue, but can dereferencing utsname() here cause a
NULL pointer dereference if the system panics during task exit?

The utsname() macro expands to (&current->nsproxy->uts_ns->name). If a panic
occurs while the current task is exiting (for example, after
exit_task_namespaces() has set current->nsproxy to NULL), dereferencing
current->nsproxy will cause a nested oops.=20

This would abort the panic screen rendering and prevent the QR code or kmsg
from being displayed, defeating the purpose of the DRM panic handler.

Would it be safer to use init_utsname() instead of utsname() here in
drm_panic_get_qr_code_url(), similar to how the standard kernel panic and d=
ump
code handles this edge case?

> =20
>  	max_qr_data_size =3D drm_panic_qr_max_data_size(panic_qr_version, url_l=
en);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D1
