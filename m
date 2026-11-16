Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32740606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE/DsTj+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6A910E1F5;
	Mon, 16 Nov 2026 11:37:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FB410E1F5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:37:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCFBF403CC;
 Mon, 16 Nov 2026 11:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA3C1F000C4;
 Mon, 16 Nov 2026 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794829039;
 bh=ueIInQc4QKIr2ojhCRxCqRdUNkfPQgEM8n1d1ohthAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bE/DsTj+3RvWsprIvL9fV+wAqN2+szNZq1u438VQoTGynf3x6qWDPDMKLMens1bHQ
 m9/Qlj/au2+Z7BdJ1ctN35IgD+CnZVFgnS2vulasItxu/fQlmR7jJ+jM1aA4MEw727
 10wC3Pok2NFmcgZuD869X5w+vSyJU8gzK9K3/HdEmP0VLGFNte5waO5nU1f1nWW9hv
 W65k4Yuk5O7eqmOREKiKIFfyzv6HrZI0m3PBEKqk33DLaSS+BuO4KAcIOhi/1S+MNm
 SmZGYRsYJKUWySPq9XWTUxtEbGGODfet0zK6bgdowF/TmXVDQnrfa+pUktqlrS+bL+
 Gij5N0TgPZk2Q==
Message-ID: <sashiko-outbox-216952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/13] drm/panthor: Use a copy of suspend buffer sizes
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261116112601.3483649-11-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
 <20261116112601.3483649-11-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:37:19 +0000
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
- [Low] drm/panthor: unused variable csg_iface in panthor_group_create()
--

commit 71ef359cc5f25037d19672b0d70e07aa5a47adee
Author: Ketil Johnsen <ketil.johnsen@arm.com>

drm/panthor: Use a copy of suspend buffer sizes

This commit caches the regular and protected suspend buffer sizes from the
firmware CSG control interface during initialization and uses the cached
size when allocating the suspend buffer in panthor_group_create().

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index ca6aa6a55661a..9c78f04d4f30a 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -4058,7 +4058,7 @@ int panthor_group_create(struct drm_file *file,
>  	struct panthor_scheduler *sched =3D ptdev->scheduler;
>  	struct panthor_fw_csg_iface *csg_iface =3D panthor_fw_get_csg_iface(ptd=
ev, 0);
>  	struct panthor_group *group =3D NULL;
> -	u32 gid, i, suspend_size;
> +	u32 gid, i;
>  	int ret;
> =20
>  	if (group_args->pad)
> @@ -4109,8 +4109,8 @@ int panthor_group_create(struct drm_file *file,
>  		goto err_put_group;
>  	}
> =20
> -	suspend_size =3D csg_iface->control->suspend_size;
> -	group->suspend_buf =3D panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_=
size);
> +	group->suspend_buf =3D
> +		panthor_fw_alloc_suspend_buf_mem(ptdev, panthor_fw_suspend_size(ptdev)=
);
>  	if (IS_ERR(group->suspend_buf)) {
>  		ret =3D PTR_ERR(group->suspend_buf);
>  		group->suspend_buf =3D NULL;

[Severity: Low]
Does replacing csg_iface->control->suspend_size with
panthor_fw_suspend_size(ptdev) leave csg_iface unused in
panthor_group_create()?  That triggers a -Wunused-variable warning (and a
build failure with CONFIG_WERROR=3Dy) at this point in the series, as the
csg_iface declaration is only removed in the later commit "drm/panthor:
Protm support for groups".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116112601.3483=
649-1-ketil.johnsen@arm.com?part=3D10
