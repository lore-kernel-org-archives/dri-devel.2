Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C895AC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146E010EF04;
	Tue,  1 Sep 2026 20:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JTSb/fYa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F95310EEF5
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:04:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95119600D9;
 Tue,  1 Sep 2026 20:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4701F000E9;
 Tue,  1 Sep 2026 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788293082;
 bh=cJloyuWHKcw/HNGDuggL0oxneerXzgLVXBr2u6wjswM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JTSb/fYaGDQVrD8G9CtwtsW5Y/Ost95PLHAZT08c1CZAwSBDVthLDNrac622ePvfk
 qbYVVq6vpwRhRBBGnoB/MYtXXIIjbxW++V2Nuykn/+wUOH/2jHKnemG+2N4dEgiwfw
 aSUm7IikkcXcPY2q7I5jdv6J5rGRM5ZUtsXT2sAdTfSL7AnzuIqKu9DwZXm28r5X17
 41oC70As2XUhTf03HsCpz33L3S7RRYCwqnv9Ku32PtSaxmbXGdVSoANa0LvYDdQf8z
 pmi/Ntrjf1sLk0eZHXjxDTly3jpHEeAQrrKXAMKqJu99QSwrOeyExmyRqBZGMBWldY
 ThkSgtetWYXJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rockchip: analogix_dp: bound endpoint name formatting
To: "Yudi Yang" <2000jedi@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901195511.2761251-1-2000jedi@gmail.com>
References: <20260901195511.2761251-1-2000jedi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 20:04:41 +0000
Message-Id: <20260901200442.1F4701F000E9@smtp.kernel.org>
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
- [High] Potential Use-After-Free when accessing `endpoint.local_node` afte=
r its reference count has been dropped.
--

commit fc6c7cf47483df3837bf09097a92c40c4a5aed65
Author: Yudi Yang <2000jedi@gmail.com>

drm/rockchip: analogix_dp: bound endpoint name formatting

This commit modifies rockchip_dp_drm_encoder_enable() to use snprintf()
instead of sprintf() when formatting a device tree path into a stack
buffer. This prevents potential buffer overflows from sufficiently long
device tree paths.

> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gp=
u/drm/rockchip/analogix_dp-rockchip.c
> index 587e60232ec7c..efd5a98e80bd2 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -241,10 +241,11 @@ static void rockchip_dp_drm_encoder_enable(struct d=
rm_encoder *encoder,
>  				of_graph_get_remote_port(endpoint.local_node);

[Severity: High]
This isn't a bug introduced by this patch, but does this code use
endpoint.local_node after its reference count has been dropped?

In rockchip_dp_drm_encoder_enable(), drm_of_encoder_active_endpoint() is
called, which internally calls of_graph_parse_endpoint(). This sets
endpoint->local_node without acquiring a reference and then explicitly
drops its reference by calling of_node_put(ep) before returning.

This leaves endpoint.local_node as a dangling pointer, which is then
passed to of_graph_get_remote_port() here (and earlier to
of_graph_get_remote_port_parent()).=20

Could this result in a Use-After-Free if the device tree node is dynamically
freed?

> =20
>  			of_property_read_u32(remote_port, "reg", &port_id);
> -			sprintf(name, "%s vp%d", remote_port_parent->full_name, port_id);
> +			snprintf(name, sizeof(name), "%s vp%d",
> +				 remote_port_parent->full_name, port_id);
>  		} else {
> -			sprintf(name, "%s %s",
> -				remote_port_parent->full_name, endpoint.id ? "vopl" : "vopb");
> +			snprintf(name, sizeof(name), "%s %s",
> +				 remote_port_parent->full_name, endpoint.id ? "vopl" : "vopb");
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901195511.2761=
251-1-2000jedi@gmail.com?part=3D1
