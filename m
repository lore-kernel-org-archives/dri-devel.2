Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730E1CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D3511A5E1;
	Fri,  5 Jun 2026 08:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xkw8A051";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F27611A5DF
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:45:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12939444C2;
 Fri,  5 Jun 2026 08:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C005E1F0089A;
 Fri,  5 Jun 2026 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780649129;
 bh=tRz0nmz0KGYbNtaJn1e04HvtluffhwzDHKyVPs68PE8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xkw8A0514cORYk+PjSzMr9IsQrTmI2Xbaspa4V3ZHFZqUlAQsSdvqwn7xBcQ+ZlIF
 9e3WK6p+R3XGxBDR7biktd7yujONCC6q+K/yHTYL5JfcieHT5jju5YO0rDiLzZGXs9
 8qa4m9DyBq97CmAXKLZ0CfwLXyJYqT0i16PmRuEZfVilwrq0uOomikjG3CPFi3+No/
 rspDyuEfSsnSqhGfOx6b7zsQI1ninadPB1ZBuZN9n3xbush1lo2JlyekYAmBGEIAvz
 bSpugTFM5HBE4s9hOJzvoMGDLuzaedCudeDiPlvYQtd1FDmFAe5yn0J5MJItJKboDO
 8LqDfelhZomdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH POC v4 6/6] gpu: drm: nova: demonstrate interaction with
 nova-core
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org
In-Reply-To: <20260605-nova-exports-v4-6-e948c287407c@nvidia.com>
References: <20260605-nova-exports-v4-6-e948c287407c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:45:29 +0000
Message-Id: <20260605084529.C005E1F0089A@smtp.kernel.org>
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
- [Low] The external crate import `nova_core::driver::AuxData` is placed af=
ter local `crate::` imports.
--

commit 11d167edf5ebf94c9cb9d05943e976e68fe80753
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: drm: nova: demonstrate interaction with nova-core

This commit exports a few items from nova-core and uses them from nova-drm
to print the chipset of the GPU being probed. It also adds some documentati=
on
items to satisfy Clippy.

> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver=
.rs
> index 48933d86ddda9..de1ad7032b6c3 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -9,12 +9,15 @@
>          ioctl, //
>      },
>      prelude::*,
> -    sync::aref::ARef, //
> +    sync::aref::ARef,
> +    types::ForLt, //
>  };
> =20
>  use crate::file::File;
>  use crate::gem::NovaObject;
> =20
> +use nova_core::driver::AuxData;

[Severity: Low]
This isn't a bug, but should the external crate import be placed before the
local crate imports to follow the kernel vertical import style? The Rust
subsystem coding guidelines mention grouping external crate imports above l=
ocal
ones.

> +
>  pub(crate) struct NovaDriver;
> =20
>  pub(crate) struct Nova {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-nova-expor=
ts-v4-0-e948c287407c@nvidia.com?part=3D6
