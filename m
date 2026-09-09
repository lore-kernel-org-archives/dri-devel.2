Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E63C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B08310F124;
	Wed,  9 Sep 2026 12:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fiDvocI8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E231710F124
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:43:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3F9D41ACB;
 Wed,  9 Sep 2026 12:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E0F1F00A3A;
 Wed,  9 Sep 2026 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788957800;
 bh=McxOgbs/IYxMd/U99igsleCpCIkOTCeRkF1c9YxEP20=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fiDvocI8wrgRkqWTcup0ljGSWzPHEoRuRUdPvO7mEZG32yKPLoFQg5ov091nh9ICl
 lb9T3xvzNZtHAkiH6Zxtf+9z588cM3bBcrorANBHSkZQ3VgyV2fmShwLil5fbtw3Sh
 0aC+0UnNXaqsfbGHDKNVcJKsQVysJKZciXUPPFhPXDMt8BaKycpMkyo1T+m97qw65k
 CacqNDeXJbuwqL7gQw9G8dvbCnY+N1/zHig0D0RzOkDmqPV59hRzOHaO8J9eGg/8EH
 BLzr5Ri01LjGW+X6AjDcmNl/rj55AZDRZdyEXys+8X2Abz6LGei65XSICxL5ejeh6U
 0wYyOantvy5yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/syncobj: Use scope-based cleanup for eventfd_ctx
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-efd-autofree-v1-2-c6c3c19cc702@arm.com>
References: <20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com>
 <20260909-efd-autofree-v1-2-c6c3c19cc702@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:43:19 +0000
Message-Id: <20260909124320.67E0F1F00A3A@smtp.kernel.org>
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
- [Medium] Mixing goto-based error handling with scope-based cleanup (__fre=
e) in the same function.
--

commit 991d574653fb7465f62bf99703d5af0d6fe21920
Author: Bence Csokas <bence.csokas@arm.com>

drm/syncobj: Use scope-based cleanup for eventfd_ctx

This patch modifies drm_syncobj_eventfd_ioctl() to use the scope-based
cleanup helper for eventfd_ctx, removing the explicit put calls.

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index c23a5de27effa..261d5606e8bd8 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1462,9 +1462,9 @@ int
>  drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *file_private)
>  {
> +	struct eventfd_ctx *ev_fd_ctx __free(eventfd) =3D NULL;
>  	struct drm_syncobj_eventfd *args =3D data;
>  	struct drm_syncobj *syncobj;

[ ... ]

> @@ -1502,8 +1503,6 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, v=
oid *data,
> =20
>  	return 0;
> =20
> -err_kzalloc:
> -	eventfd_ctx_put(ev_fd_ctx);
>  err_fdget:
>  	drm_syncobj_put(syncobj);
>  	return ret;

[Severity: Medium]
Does this code in drivers/gpu/drm/drm_syncobj.c:drm_syncobj_eventfd_ioctl()
mix goto-based error handling and scope-based cleanup in the same function?

The cleanup subsystem documentation in include/linux/cleanup.h states that =
for
a given routine, all resources that need a "goto" cleanup should be convert=
ed
to scope-based cleanup, or none of them should be. Mixing the two creates
confusing ownership semantics.

Could the syncobj cleanup also be converted to use __free(), or should we
stick to goto-based cleanup for both resources in this function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-efd-autofr=
ee-v1-0-c6c3c19cc702@arm.com?part=3D2
