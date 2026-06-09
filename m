Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F6CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2865010E42B;
	Tue,  9 Jun 2026 17:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BaDcphe4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956B610E42B
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:37:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AC3360218;
 Tue,  9 Jun 2026 17:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEC91F00893;
 Tue,  9 Jun 2026 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781026649;
 bh=YVthOhY5zQFQSWwQu3RokbHh6XrYwDrHyv/FDJb/Dr0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BaDcphe4niGxCVgzM4Hs+yo4Yg2BmG8quWgLliy6Le4aodXdGVFikz60P6RX/10Bk
 Off+yoKB8HDRyd6cwbSILX/LC0qQ0+4SHPOb26YdtHafqGeZTkhmEj1drnfWYBOobB
 gWoHAeS/mJAOpSgenpvTF0HNy0DKz7uas3f5fyjiadkF10Dw4oXdCqV1iw6yG2lKor
 W2z6nYv5Pd86VJt/1wodYyDGdtZ0Jbhy/yEox5StD5Q1yyUiq5kkWfKxAlNmlvqarK
 MHsnAXugXJWCKWU72D4TY9bWuWQrD2exhdNqPnAdsVU46NwDG0i5xeu8iQ3WmOdOPb
 rYhsVRooFQ7zQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/8] drm/vkms/colorop: Update to new pipeline API
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609171941.169104-6-John.Harrison@Igalia.com>
References: <20260609171941.169104-6-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:37:29 +0000
Message-Id: <20260609173729.AAEC91F00893@smtp.kernel.org>
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
- [High] Unchecked kasprintf return value may lead to a NULL pointer derefe=
rence when setting up the color pipeline property.
--

commit e64dca02dc85f9d02e8990c56f98c1559490b722
Author: John Harrison <John.Harrison@Igalia.com>

drm/vkms/colorop: Update to new pipeline API
   =20
Switch to using the new method for building colorop pipelines.

> diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/v=
kms_colorop.c
> index 071f3a8d2e7c4..ecb4fd56eb8cc 100644
> --- a/drivers/gpu/drm/vkms/vkms_colorop.c
> +++ b/drivers/gpu/drm/vkms/vkms_colorop.c
[ ... ]
> @@ -93,7 +95,7 @@ static int vkms_initialize_color_pipeline(struct drm_pl=
ane *plane, struct drm_pr
>  	if (ret)
>  		goto cleanup;
> =20
> -	drm_colorop_set_next_property(ops[i - 1], ops[i]);
> +	drm_colorop_add_to_pipeline(ops[0], ops[i]);
> =20
>  	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.=
id);
> =20

[Severity: High]
This is a pre-existing issue, but does this kasprintf() need a NULL check?

If kasprintf() fails to allocate memory, it returns NULL. Since
vkms_initialize_color_pipeline() then unconditionally returns 0 (success), =
the
caller vkms_initialize_colorops() will pass this NULL string down to
drm_plane_create_color_pipeline_property(). This is ultimately passed to
drm_property_add_enum(), where calling strlen() on the NULL name will cause=
 a
NULL pointer dereference.

Should this allocation be checked and routed to the cleanup path on failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609171941.1691=
04-1-John.Harrison@Igalia.com?part=3D5
