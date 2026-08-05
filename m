Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EB8C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F2B10ECD5;
	Wed,  5 Aug 2026 05:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BRsAFb1f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC7B10ECD5
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:52:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34835600B1;
 Wed,  5 Aug 2026 05:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B101F000E9;
 Wed,  5 Aug 2026 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785909132;
 bh=ILAL2YcP3ymOrDOlIyhbO+WT/+csTeDNUXAdDCjeuKM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BRsAFb1fzkQasKLT8gAvqycxIQ/ezXEHBI1DmzGrUbQXRjwntZHlP6qm3Vp8xD/gk
 92TpFANNbbkVNjQLaBqVcdbXiJF9OzZpHuntrxqPSaRJwgLarV3XdbRRtdN7HNwico
 /4c/IcsnSYs5G7vQ2HKk+Y696NJvnbBLHBB0RqusFdPuaMN5P2lYF2rmgATxdNuQ9q
 RK7vOJhaRcdl59PIV8RYv7ZbO1phsZw+ZvhVWKczK22eebWZs9pPFL2Ncm1p/TGXwu
 8JQm/x2DfwP6/xzp0uXxfh8KEmW8hylgzPeHFDnl+4Lg7a100lTWTRU0cG8bO+Y0l/
 Wud56z/wbOsBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] gpu: nova-core: mm: Add GpuMm centralized memory
 manager
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-pramin-split-v1-10-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-10-ff3e84a75dac@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:52:11 +0000
Message-Id: <20260805055212.18B101F000E9@smtp.kernel.org>
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
- [Medium] `pramin_mut` is missing the `pub(crate)` visibility modifier, ma=
king it private to the `mm` module.
--

--- Patch [10]: [PATCH 10/12] gpu: nova-core: mm: Add GpuMm centralized mem=
ory manager ---
commit 0abff5539341f15cd592232acd203deec02947c6
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add GpuMm centralized memory manager

This commit introduces GpuMm as a centralized GPU memory manager in the
nova-core driver. It initially owns the PRAMIN window for direct VRAM access
and provides an accessor method for use by follow-on patches. It also updat=
es
the static info parsing to compute the total FB end.

[ ... ]

> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index ef5b1cad56c31..58dce211a3373 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs

[ ... ]

> +    /// Access the [`pramin::Pramin`].
> +    fn pramin_mut(&mut self) -> &mut pramin::Pramin<'gpu> {

[Severity: Medium]
The commit message states that this provides an accessor method so follow-on
patches can reference pramin_mut() cleanly. However, without a pub(crate)
visibility modifier, won't this method be private to the mm module?

Will this prevent other modules from calling it as intended, and potentially
trigger a dead_code compiler warning?

> +        &mut self.pramin
> +    }
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-pramin-spl=
it-v1-0-ff3e84a75dac@nvidia.com?part=3D10
