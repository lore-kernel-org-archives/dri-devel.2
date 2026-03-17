Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F00BFED9E4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B704310E587;
	Tue, 17 Mar 2026 16:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M1lXcAGl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422B410E587;
 Tue, 17 Mar 2026 16:06:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E62C6416A8;
 Tue, 17 Mar 2026 16:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8A4C19424;
 Tue, 17 Mar 2026 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773763567;
 bh=qC9PeLqfe8qNJHkcVgrneGSMbdKEuQfm8pJUYS6bj08=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=M1lXcAGlcjnnczZdsajXeyav1UDJ4fcFCl/A+Y5OWKYv/lLDNUebzp80Sf1omlvF5
 dltmhe3zXdNQDUKijwRqO/krkQeG5Uc39Du8Q8s2DDeZVLisLB3qPYgFmE8cgQKDTK
 b9iImCquwo9M2lTIHtrZPsH9gACuuSR+LB/N2VYytedQNGXrwLzfwT8tSlWHmJE3SW
 5TQNjt72mBoAUI3M69PwKTlv1Ufl92zXI+PHnQiV/ekbTxmx3JmHlk3gSqvsG7L8lx
 D1RvPTd04QQnFuu+FufeVB26khTnj2UwM3Cy8cUwplGOl7g+g5B5qWCvJ+TdMePa9N
 852ZfIDDPxFwA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 17:06:04 +0100
Message-Id: <DH56PG8GLW4X.2QMHJ91J9D29N@kernel.org>
Subject: Re: [PATCH v2 1/2] gpu: nova: rename drivers to use kebab-case
 convention
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Ching-Chun Huang" <jserv@ccns.ncku.edu.tw>, "Chia-Ping Tsai"
 <chia7712@gmail.com>, "Timur Tabi" <ttabi@nvidia.com>
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
 <20260316120820.2117081-2-yphbchou0911@gmail.com>
In-Reply-To: <20260316120820.2117081-2-yphbchou0911@gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon Mar 16, 2026 at 1:08 PM CET, Cheng-Yang Chou wrote:
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver=
.rs
> index b1af0a099551..e3de04f358f0 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -32,11 +32,11 @@ pub(crate) struct NovaData {
>      major: 0,
>      minor: 0,
>      patchlevel: 0,
> -    name: c"nova",
> -    desc: c"Nvidia Graphics",
> +    name: c"nova-drm",
> +    desc: c"NVIDIA Graphics and Compute",
>  };

Can you please move this into the second patch. Additionally, in the second
patch, please only keep the Kconfig change and use the following in the
Makefile.

	obj-$(CONFIG_DRM_NOVA) +=3D nova-drm.o
	nova-drm-y :=3D nova.o

I.e. keep the directory and filenames as they are.

We can use the same trick for nova-core, so we get nova-core.ko and nova-dr=
m.ko.

Thanks,
Danilo

> =20
> -const NOVA_CORE_MODULE_NAME: &CStr =3D c"NovaCore";
> +const NOVA_CORE_MODULE_NAME: &CStr =3D c"nova-core";
>  const AUXILIARY_NAME: &CStr =3D c"nova-drm";
> =20
>  kernel::auxiliary_device_table!(
> diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova/nova.rs
> index 8893e58ee0db..1fd454c7e0df 100644
> --- a/drivers/gpu/drm/nova/nova.rs
> +++ b/drivers/gpu/drm/nova/nova.rs
> @@ -10,7 +10,7 @@
> =20
>  kernel::module_auxiliary_driver! {
>      type: NovaDriver,
> -    name: "Nova",
> +    name: "nova-drm",
>      authors: ["Danilo Krummrich"],
>      description: "Nova GPU driver",
>      license: "GPL v2",
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/n=
ova_core.rs
> index c1121e7c64c5..90e98380687b 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -22,7 +22,7 @@
> =20
>  kernel::module_pci_driver! {
>      type: driver::NovaCore,
> -    name: "NovaCore",
> +    name: "nova-core",
>      authors: ["Danilo Krummrich"],
>      description: "Nova Core GPU driver",
>      license: "GPL v2",
> --=20
> 2.48.1

