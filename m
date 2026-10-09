Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2109ECA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785E21120C1;
	Fri,  9 Oct 2026 12:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nan+1v9G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B351120C1
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:00:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5FA2403F4;
 Fri,  9 Oct 2026 12:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D18E1F000FF;
 Fri,  9 Oct 2026 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791547240;
 bh=OX3YUHatPcL3Kz3o3unLGo9ozOKPQHAwI4BjyvNipr4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nan+1v9GfcDzwbjKkKvdZpLuxZZI5nvplgjMolY5AAMavE4APwElO7iuLj9QRD34y
 f2t7sEz58ls5rAdhx/HOjwMVJCJdt3SZOEswcXnZhnNr6PokY9EOEjGcoq6K7VktFJ
 /OJ2zRTMvO5QXKknmR+Ul2cyUo5VY/WmRdNIH86Lbv3/SWJu1BdLla35p1BzMmEt3B
 2shR1sUwhkWfRTdVlrPLrfzRKS5xPSkUCSP8Qeulj3ot7m3qFgX/aOiUxUcnH4zoqf
 EoRMsiTKVZenJffrUPpqKapS5SJVkTvGpTnVd0gcj7nutrxFtmtvWKkWxzxLnJYT6m
 t3+wwe4LcDWaw==
Message-ID: <sashiko-outbox-165460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
To: liupeng <liupeng01@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20261009115151.13877-1-liupeng01@kylinos.cn>
References: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
 <20261009115151.13877-1-liupeng01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:00:40 +0000
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

> In nouveau_debugfs_init(), if nvif_object_ctor() fails, the previously
> allocated drm->debugfs is leaked because the function returns the
> error code directly.
>=20
> In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
> the allocated hwmon structure is leaked because the function returns
> the error code directly.
>=20
> Fix both by freeing the allocated memory and clearing the pointer on
> the error paths.
>=20
> Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for debu=
gfs")
> Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything except the hw=
mon interfaces to THERM")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: liupeng <liupeng01@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009115151.1387=
7-1-liupeng01@kylinos.cn?part=3D1

