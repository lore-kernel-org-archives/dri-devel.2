Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324CBC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0E110E939;
	Mon, 29 Jun 2026 14:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UJ62fmKW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E10310E937
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1D7F60008;
 Mon, 29 Jun 2026 14:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F7D1F000E9;
 Mon, 29 Jun 2026 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742634;
 bh=jKkwZ4dnPyejitN4Jc7A6//QFfR2YjYbY3TpW6qdvgI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UJ62fmKWoOi8exXVehBR7E1go9DT8lZHH7v7ThOy5eeos1sf6HZFltmH5GosUaOwg
 6U0DfKwTcNFCyAsd/etfofkWYzC/pn7mz6hN0OYEYhxvAsWuUnH3gT4qpNI3aUCfnN
 MShX2c+8/AfiTJwoRhp/PD647F6RFFKJtey2lAUTkFGPzEDUkJfyArlfVvo/W9Gn07
 1Qad4cBXS0drvwx1U8pOBzN+gE44/m3x0/mqpl2hSCIQRYZJEaWXS8BiEZs+3xb8Wo
 K4xAmE5TpdjGiWLHh+IdcQh6Vz5W9ic9+2e1Bqn293PMcviG8NTvfhlDzQyp9xXpqV
 aB78hlXi+lRSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] gpu: nova-core: avoid repeated calls to
 pci::Device::as_ref
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org
In-Reply-To: <20260629-nova-bootcontext-v4-10-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-10-5539d8469590@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:17:13 +0000
Message-Id: <20260629141714.36F7D1F000E9@smtp.kernel.org>
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
- [Low] The refactoring to use a local `Device` reference misses several `d=
ev_dbg!` macro invocations in `Gpu::new`, leaving the task incomplete and t=
he code inconsistent.
--

commit 5b411de251c3e77848e5e58356562796a1fb83fe
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: avoid repeated calls to pci::Device::as_ref

Add a local Device reference created from the pci::Device in the
Gpu constructor to avoid repeatedly calling as_ref.

> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index c04706b60ba80..663e61d0c023b 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs

[ ... ]

> @@ -372,8 +374,8 @@ pub(crate) fn new(
>                  // Obtain and display basic GPU information.
>                  let info =3D gsp_resources.gsp.get_static_info(bar)?;
>                  match info.gpu_name() {
> -                    Ok(name) =3D> dev_info!(pdev, "GPU name: {}\n", name=
),
> -                    Err(e) =3D> dev_warn!(pdev, "GPU name unavailable: {=
:?}\n", e),
> +                    Ok(name) =3D> dev_info!(dev, "GPU name: {}\n", name),
> +                    Err(e) =3D> dev_warn!(dev, "GPU name unavailable: {:=
?}\n", e),
>                  }
> =20
>                  if !info.usable_fb_regions.is_empty() {
>                      dev_dbg!(pdev, "Usable FB regions:\n");
>                      for region in &info.usable_fb_regions {
>                          dev_dbg!(pdev, "  - {:#x?}\n", region);
>                      }
> =20
>                      dev_dbg!(
>                          pdev,
>                          "Total usable VRAM: {} MiB\n",
>                          info.usable_fb_regions.iter().fold(0u64, |res, r=
egion| res
>                              .saturating_add(region.end - region.start))
>                              / u64::SZ_1M
>                      );

[Severity: Low]
This isn't a bug, but should these remaining dev_dbg!() macros also be upda=
ted
to use dev instead of pdev? Leaving them as pdev continues to implicitly
invoke .as_ref(), which this patch is trying to avoid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-nova-bootc=
ontext-v4-0-5539d8469590@nvidia.com?part=3D10
