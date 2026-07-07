Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23455C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD9010E124;
	Tue,  7 Jul 2026 15:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M2zuaXHD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B585610E124
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:48:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 264D1417AF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C747D1F000E9;
 Tue,  7 Jul 2026 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439298;
 bh=ILk30MP6WmxqxZVPisrJsVbF0jSejqfAidMwvNR2FsM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M2zuaXHDNc1vbL2wplziRJjdF5mNdd/eodIuCZkYCIYJnjBxnbnHIJUNaqoQsxLLA
 ZtVaPv0NYUPUNnGRPBy3b3YFaOrUmP3A1R7qmfPgbnZ5E6QHGfRa83/n7wB+ahKYPU
 xlGUDCUgD7Iu6wb+SMD+GgcpwptQ4JDY4yozx8bwLqHILgHyw7Px+QajBJf4dly/NJ
 059zeSUYgjnAFe8LoTbPmmmTDtYG6MjdN1RV82utICPjbtpsxTHN6BfxBmRouNoLUE
 vlRMYPQlKuJQyX505PIgkx1Cmczvqi2/DcF6thPcSICS1NhNgRzjEGtDrLxwE/M17Z
 nIQnWZ/DaF2PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/37] drm/bridge: ti-tfp410: Switch to atomic bridge
 callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-22-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-22-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:48:17 +0000
Message-Id: <20260707154817.C747D1F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but there is a use-a=
fter-free vulnerability and missing cleanup of the HPD registration on the =
`tfp410_attach` error path.
--

--- Patch [22]: [PATCH v2 22/37] drm/bridge: ti-tfp410: Switch to atomic br=
idge callbacks ---
commit fb525e8e18293a40cab99e1a43c62c7f5ee18083
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: ti-tfp410: Switch to atomic bridge callbacks

This commit switches the ti-tfp410 bridge from legacy non-atomic enable and
disable callbacks to their atomic counterparts. It also adds the necessary
atomic state handlers to help remove legacy support from the DRM bridge cor=
e.

> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/=
ti-tfp410.c
> index 6f06f7b4e9926..f0a14f52aaace 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
[ ... ]
> @@ -242,8 +244,8 @@ static int tfp410_atomic_check(struct drm_bridge *bri=
dge,
>  static const struct drm_bridge_funcs tfp410_bridge_funcs =3D {
>  	.attach		=3D tfp410_attach,
>  	.detach		=3D tfp410_detach,
> -	.enable		=3D tfp410_enable,
> -	.disable	=3D tfp410_disable,

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a
use-after-free risk and missing cleanup of the HPD registration on the error
path in tfp410_attach().

When tfp410_attach() successfully registers the HPD callback on the next br=
idge,
but drm_connector_init_with_ddc() subsequently fails, it returns an error
without disabling the HPD callback:

drivers/gpu/drm/bridge/ti-tfp410.c:tfp410_attach() {
    ...
	ret =3D drm_connector_init_with_ddc(bridge->dev, &dvi->connector,
					  &tfp410_con_funcs,
					  dvi->bridge.next_bridge->type,
					  dvi->bridge.next_bridge->ddc);
	if (ret) {
		dev_err(dvi->dev, "drm_connector_init_with_ddc() failed: %d\n",
			ret);
		return ret;
	}
    ...
}

If the attachment fails, .detach() isn't called, and the next bridge might =
still
retain the HPD callback pointing to the freed dvi structure. A hardware
hotplug event could then trigger the callback and dereference the freed poi=
nter.

Should this error path deregister the HPD callback before returning?

> +	.atomic_enable =3D tfp410_enable,
> +	.atomic_disable =3D tfp410_disable,
>  	.mode_valid	=3D tfp410_mode_valid,
>  	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D22
