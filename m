Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59347606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT7PTiun
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA4E112C07;
	Fri, 20 Nov 2026 17:33:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2907F112C07
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:33:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BD18601E1;
 Fri, 20 Nov 2026 17:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900DD1F000CF;
 Fri, 20 Nov 2026 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795195982;
 bh=O1Uk+iY46JUFa3GvZyU6iG1oiehu3jAsRgmkwJora1A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OT7PTiunEC9/ujshooSuZcqEOvvOvkx3nfCt47uDvK1dmGToJ8sNUu8DMAwZF0j16
 5Re2Jfta9nPbwQWB/FGy2SyI+DR0jbOuxeLHwNXwzHf8lGsni9uJBJ7G5NpuRvuUlV
 /yQdZHoxOt79G0Sm3LhVY6uaV11lY8bcZwn9g16ECp9YnV/rWr+ureSM+wXsRDeKV3
 oNIlIKSQpM8gjvyXwWhQ1aSd0usgtW0DdCFNyokVh9jtgM62mmyyUwx+KVXMaMiQfL
 U1BfaLQ6lCrpH805S6IFhUuqxCyHaanbTaJC1XVF/zL44pT9BmTO+Rn2BSbCezm1/u
 ntZ9VeQ0/5vOA==
Message-ID: <sashiko-outbox-225679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm: fix config dependent unused variable warning.
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-rd-mostly-v2-3-88056ede02a8@gmail.com>
References: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
 <20261120-rd-mostly-v2-3-88056ede02a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 17:33:02 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/print: __drm_printfn_dbg() ignores category under
  DYNAMIC_DEBUG
--

commit 86a692a9057b290b879237eb899a9b98e98de2c4
Author: Jim Cromie <jim.cromie@gmail.com>

drm: fix config dependent unused variable warning.

This commit removes the local category variable in __drm_printfn_dbg() and
passes p->category directly to __drm_debug_enabled() to avoid an
unused-variable warning when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy.

> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 50cdeb1b15e25..12b95901eb707 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -218,9 +218,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct =
va_format *vaf)
>  {
>  	const struct drm_device *drm =3D p->arg;
>  	const struct device *dev =3D drm ? drm->dev : NULL;
> -	enum drm_debug_category category =3D p->category;
> =20
> -	if (!__drm_debug_enabled(category))
> +	if (!__drm_debug_enabled(p->category))
>  		return;

[Severity: Medium]
Should __drm_printfn_dbg() call drm_debug_enabled(p->category) (or
drm_debug_enabled_raw(p->category)) instead of __drm_debug_enabled()?

When CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, __drm_debug_enabled() expands to
true without evaluating its argument because it assumes the callsite is
already gated by a dynamic debug descriptor via _dynamic_func_call_cls().
drm_dbg_printer() wires __drm_printfn_dbg() as a function pointer without
a dynamic debug callsite descriptor, so using __drm_debug_enabled() leaves
p->category unchecked and causes all drm_dbg_printer() messages to be
printed unconditionally even when drm.debug has that category disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-rd-mostly-=
v2-0-88056ede02a8@gmail.com?part=3D3
