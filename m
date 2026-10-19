Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA13606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7VEPr79
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A808010E45E;
	Mon, 19 Oct 2026 21:32:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8231710E45E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D02342B27;
 Mon, 19 Oct 2026 21:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08FD1F000C4;
 Mon, 19 Oct 2026 21:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792445555;
 bh=9OcFbVag/FzKGgBjOFYPG6g00PSytS5iMG3sHfxdxl4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i7VEPr79C8yPzgS+1UlyFBjRrITeZB5XxrL0e7a43UHZUsA5+L1f8o37YQ6Tt0UWp
 PF2lvDwXNjVTMIxq3PapytDS45WcwhBOkQFgfIBEClSiBe/SesSXGMwGC+tVoTmcPF
 mXeH4oVX7CFrZI2BqYKacVVEmVeYGkZuk6pc0E+MUQ5DbCAj+pRVzthOmjIY7Jzzxa
 dW6rjOv9IHMq2eS/1c94wD2YJO6A4uQdTn01ucTZrZ3QCSDu6p2OTmk4gYWQxvlfEy
 LujyVM6winsQThsDw/N3X+Ty7Dl8qmSE+j5aA3szRcIsQag2Sj5u0c9cnxBqElQGem
 Mh+Lag03VbsWw==
Message-ID: <sashiko-outbox-178261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/nova: require explicit opt-in to unstable uAPI
To: "Danilo Krummrich" <dakr@kernel.org>, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 jhubbard@nvidia.com, apopple@nvidia.com, ecourtney@nvidia.com,
 lyude@redhat.com, kherbst@redhat.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019212535.88390-4-dakr@kernel.org>
References: <20261019212535.88390-1-dakr@kernel.org>
 <20261019212535.88390-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:32:33 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/nova: missing kernel-parameters.txt entry for acknowledge_unsta=
ble_uapi
--

commit 77a1b4c686914a70a5ae235e8e03b1e3542d6c45
Author: Danilo Krummrich <dakr@kernel.org>

drm/nova: require explicit opt-in to unstable uAPI

This commit adds the acknowledge_unstable_uapi module parameter to
nova-drm to require users to explicitly opt in to the unstable uAPI before
enabling the driver, and taints the kernel when enabled.

> diff --git a/drivers/gpu/drm/nova/Kconfig b/drivers/gpu/drm/nova/Kconfig
> index ba16c74401f8f..2cb62517b2f9b 100644
> --- a/drivers/gpu/drm/nova/Kconfig
> +++ b/drivers/gpu/drm/nova/Kconfig
> @@ -12,6 +12,15 @@ config DRM_NOVA
>  	  Choose this if you want to build the Nova DRM driver for Nvidia
>  	  GSP-based GPUs.
> =20
> -	  This driver is work in progress and may not be functional.
> +	  This driver is under active upstream development and may not be
> +	  functional. Its uAPI is intended to be developed upstream alongside
> +	  the driver and is not yet stable. It may change incompatibly during
> +	  development.
> +
> +	  Loading requires the acknowledge_unstable_uapi=3D1 module parameter, =
or
> +	  nova-drm.acknowledge_unstable_uapi=3D1 on the kernel command line when
> +	  built in.
> +
> +	  Enabling the driver taints the kernel.
> =20
>  	  If M is selected, the module will be called nova-drm.
> diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova/nova.rs
> index 1fd454c7e0dfb..ad68f6e1a613b 100644
> --- a/drivers/gpu/drm/nova/nova.rs
> +++ b/drivers/gpu/drm/nova/nova.rs

[ ... ]

> -kernel::module_auxiliary_driver! {
> -    type: NovaDriver,
> +module! {
> +    type: NovaModule,
>      name: "nova-drm",
>      authors: ["Danilo Krummrich"],
>      description: "Nova GPU driver",
>      license: "GPL v2",
> +    params: {
> +        acknowledge_unstable_uapi: bool {
> +            default: false,
> +            description: "Acknowledge that Nova and its uAPI are under a=
ctive upstream development \
> +                          and the uAPI may change incompatibly; enable t=
he driver (taints kernel)",
> +        },
> +    },
> +}
> +
> +#[pin_data]
> +struct NovaModule {
> +    #[pin]
> +    _driver: Registration<auxiliary::Adapter<NovaDriver>>,
> +}
> +
> +impl NovaModule {
> +    fn check_unstable_uapi() -> Result {
> +        pr_warn!("Nova and its uAPI are under active upstream developmen=
t\n");
> +
> +        if !module_parameters::acknowledge_unstable_uapi.value() {
> +            pr_err!("Driver disabled: Nova's uAPI is unstable and may ch=
ange incompatibly\n");
> +            pr_info!("Set nova-drm.acknowledge_unstable_uapi=3D1 to enab=
le (taints kernel)\n");

[Severity: Low]
Since NovaModule defines the acknowledge_unstable_uapi parameter in
drivers/gpu/drm/nova/nova.rs and both DRM_NOVA in
drivers/gpu/drm/nova/Kconfig and NovaModule::check_unstable_uapi()
instruct users to pass nova-drm.acknowledge_unstable_uapi=3D1 on the kernel
command line when built in, should this parameter also be documented in
Documentation/admin-guide/kernel-parameters.txt?

> +            return Err(EPERM);
> +        }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019212535.8839=
0-1-dakr@kernel.org?part=3D3
