Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F9DC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB10B10F945;
	Fri,  4 Sep 2026 08:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DxtZpi1A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7999810F92D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:13:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DC5960211;
 Fri,  4 Sep 2026 08:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA951F00A3F;
 Fri,  4 Sep 2026 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788509601;
 bh=/iUlJmHB81T9vUOhmXEwDSReyIRHL0cIcR2NF3y/hCI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DxtZpi1ARUKT7KYwNYYGiEsV0KHU90GJFxyT5xrvnhs00sNEOyOcxjMThPDnlbKtz
 XHIhqDIelMT+B777gSPAx4tcLFaPUnwgfkBiXICm+3iL0E/yR9GDOLUpU6t2ndVIJO
 ciQvLtFONrjSPbaSBcGwmA+v8ODdJp+SOb1ocg9wG7RhdSFLRfOHx2Ft3M0ciEAs4L
 wMcWnGlzLAV36qZwPUpb+UygNwm3eiRnbFFClT4vP9j3/eGpsC5gRgAV1WVIg5QjOV
 BZmOOociQIAzb9D/e0s6tTONo/m18y2mkwr2QclU/6fk7ZQOcGvhZ7QGevW4358Vu/
 gZQuMc4rlLC7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] drm/imx: dc-fu: Get DPR channel
To: "Liu Ying" <victor.liu@nxp.com>
Cc: robh@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org
In-Reply-To: <20260904-imx8-dc-prefetch-v6-12-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-12-26643e3f6cb7@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:13:20 +0000
Message-Id: <20260904081320.BDA951F00A3F@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Infinite probe deferral when the optional `fsl,prg` device tree pr=
operty is absent.
- [High] dc_fu_get_dprc() incorrectly assumes successful DPRC probe and sto=
res a dangling pointer if dc_dprc_probe() previously failed.
- [High] Use-After-Free (UAF) vulnerability due to missing reference counti=
ng and device links during PRG/DPRC lookups.
- [Low] Misuse of dev_err_probe() from a component bind callback sets the d=
eferral reason on the wrong device.
--

commit 6264221c06949730f7283e2f3f3d4083c0f6d10e
Author: Liu Ying <victor.liu@nxp.com>
Subject: drm/imx: dc-fu: Get DPR channel

This commit adds a helper dc_fu_get_dprc() to get the DPR channel for a
FetchUnit. It also calls this helper from the component bind functions for
FetchLayer and FetchWarp to initialize their DPR channels.

> diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-f=
u.c
> index 2e197b3344bd1..8339f44c00919 100644
> --- a/drivers/gpu/drm/imx/dc/dc-fu.c
> +++ b/drivers/gpu/drm/imx/dc/dc-fu.c

[ ... ]

> @@ -256,3 +257,20 @@ void dc_fu_common_hw_init(struct dc_fu *fu)
>  		dc_fu_set_pixel_blend_mode(fu, i);
>  	}
>  }
> +
> +int dc_fu_get_dprc(struct dc_fu *fu)
> +{
> +	struct dc_prg *prg;
> +
> +	prg =3D dc_prg_lookup_by_phandle(fu->dev, "fsl,prg", 0);

[Severity: High]
Does this code enter an infinite probe deferral loop on hardware platforms
that do not include a PRG?

The device tree bindings define the fsl,prg property as optional. However,
if the property is entirely missing, of_parse_phandle() returns NULL, and
this unconditionally returns -EPROBE_DEFER.

Should this code distinguish between a missing property (which should be
tolerated) and a missing/unprobed device?

[Severity: High]
Is it safe to use this prg pointer without holding a reference count or
device link?

dc_prg_lookup_by_phandle() locates the prg structure under a lock but
returns it without taking a reference count (e.g., get_device()).

The unprotected pointer is used outside the lock here. If the PRG device is
concurrently removed (e.g., via DT overlay removal), the prg structure could
be freed, causing a use-after-free when we call dc_prg_get_dprc(prg) later.

> +	if (!prg)
> +		return dev_err_probe(fu->dev, -EPROBE_DEFER,
> +				     "failed to lookup PRG\n");

[Severity: Low]
Is dev_err_probe() being called on the correct device here?

This is called from the component bind callbacks dc_fl_bind() and
dc_fw_bind(), passing the component device fu->dev. Since the component has
already successfully probed and is in the bind phase, it is not on the
deferred probe list.

Does this attach the deferred probe reason to the wrong device, bypassing
the devices_deferred debugfs file and causing a minor memory leak since
driver_deferred_probe_del() will never free the string?

> +
> +	fu->dprc =3D dc_prg_get_dprc(prg);

[Severity: High]
Can this store a dangling pointer in fu->dprc if the DPRC previously failed
to probe?

In dc_dprc_probe(), dprc is allocated with devm_kzalloc() and stored in
prg->dprc. If dc_dprc_probe() subsequently fails (e.g., devm_request_irq()
fails or defers), the dprc structure is automatically freed by devres
cleanup, but prg->dprc is not reset to NULL.

When this code retrieves prg->dprc, the pointer will be non-NULL despite
pointing to freed memory. It will bypass the -EPROBE_DEFER check and store
the dangling pointer, which could lead to memory corruption when accessed by
the display pipeline.

[Severity: High]
Does storing this pointer for long-term usage require a device link?

Because the prg/dprc pointer was acquired without a reference count or
device link, the loosely coupled PRG/DPRC devices can be safely unbound
while the Fetch Unit remains active, leading to a use-after-free when the
Fetch Unit accesses fu->dprc.

> +	if (!fu->dprc)
> +		return dev_err_probe(fu->dev, -EPROBE_DEFER,
> +				     "failed to get DPR channel\n");
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-imx8-dc-pr=
efetch-v6-0-26643e3f6cb7@nxp.com?part=3D12
