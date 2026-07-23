Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB7EC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E667910F242;
	Thu, 23 Jul 2026 22:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gYLpG8Di";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F5F10F242
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:34:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA91A4050A;
 Thu, 23 Jul 2026 22:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5F21F000E9;
 Thu, 23 Jul 2026 22:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784846059;
 bh=QlbJX5mQ02oqQKJvelC0JLCr/Y5xuwr8U78FZbaMwok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gYLpG8DiiSlMkFziacj9DcCmx35TPt+J3+MZtqMUNn1r7+uQx8TEyGq5PGrlbYbMm
 BOHgFdtxPQc16mORV1s0nf9Yvn0UPVtKhCP0n9N+TRP5WhKcVupom4BPhDG23xp4+j
 8Uy3lN9JpQXgillrpg3hx7CqTaDlLWlIWRxWZH/JfV1eaw6QUt3E3xcibh7UXGNicJ
 6RI53aV1kxMdkHnwBanHFxNwYaHPHkV6Uf49JWFqajHPz8KMQhQulqZ0GsXbofMj67
 oODz6k9Qk8Ns1jRu0tZp99mzD1DPU2Kx4u6ZvoFmXdKit1rsXJVq+BgxgWkEwz6Vt4
 QOlg0rTbUGIFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/15] drm/bridge: synopsys: dw-dp: Fix incorrect
 resource lifetimes in bind callback
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-1-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v5-1-9445c2e87441@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:34:19 +0000
Message-Id: <20260723223419.6F5F21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancel_work_sync(&dp->hpd_work) in dw_dp_unbind leads to u=
se-after-free
- [High] Missing reinit_completion() in AUX transfer function causes stale =
completion state
--

--- Patch [1]: [PATCH v5 01/15] drm/bridge: synopsys: dw-dp: Fix incorrect =
resource lifetimes in bind callback ---
commit f51b82393e0acdef468182d74c204f63a5e111ae
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callb=
ack

Currently the Synopsys DesignWare DP controller driver's bind function
requests lots of resources using device managed functions. These are
free'd on driver removal instead of at unbind time. Fix this discrepancy
by introducing a new probe helper function and moving over most of the
early resource acquisitions.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 3445c82e6f50e..368e1f85e6253 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> +	dp->aux.transfer =3D dw_dp_aux_transfer;

[Severity: High]
This isn't a bug introduced by this patch, but does the AUX transfer functi=
on
need a call to reinit_completion()?

Looking at dw_dp_aux_transfer() in drivers/gpu/drm/bridge/synopsys/dw-dp.c,
it waits for completion like this:

	regmap_write(dp->regmap, DW_DP_AUX_CMD, value);
	status =3D wait_for_completion_timeout(&dp->complete, timeout);

If a previous transfer times out and the hardware interrupt eventually arri=
ves
late, it can leave dp->complete.done greater than zero. When the next trans=
fer
is initiated, wait_for_completion_timeout() could consume the leftover
completion and return immediately without waiting for the new transfer to
finish, causing it to read garbage DPCD data.

> +	ret =3D drm_dp_aux_register(&dp->aux);

[ ... ]

> +void dw_dp_unbind(struct dw_dp *dp)
> +{
> +	disable_irq(dp->irq);
>  	phy_exit(dp->phy);
> +	drm_dp_aux_unregister(&dp->aux);
> +	drm_bridge_remove(&dp->bridge);
>  }

[Severity: High]
This is a pre-existing issue, but does dw_dp_unbind() in
drivers/gpu/drm/bridge/synopsys/dw-dp.c need to call
cancel_work_sync(&dp->hpd_work) to prevent a use-after-free?

If a hotplug event occurs when the driver is being unbound, the IRQ handler
might schedule dp->hpd_work. The disable_irq() call here waits for the IRQ
handler to finish but does not cancel pending workqueue items. After the
driver unbinds and the devm-managed dp structure is freed, the workqueue
could execute dw_dp_hpd_work() and access the freed dp structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v5-0-9445c2e87441@collabora.com?part=3D1
