Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFF5C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634CB10E958;
	Tue, 25 Aug 2026 08:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ed8+zWXD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8776C10E958
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 710FC404E6
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FAD1F000E9;
 Tue, 25 Aug 2026 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787645437;
 bh=TjpbPpD6U5uNFz7Inino+IbmrVu/JCur2CR/t44V+C4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ed8+zWXDBayrzji07AcLgaaYKL4uzbzMJSQW0UM24MVuR3rhPEP/V2R6amen3KSot
 Ny5PUlmms7K9XmJVFpdWqByMSRajZszHt4rVUcSV2DXu5BG7J5toUJObHoTZzKMqG8
 UQ/xQNuqzqVFEYBUaUZ9ZtIQouSFTBMnmIKPokJrVqy/E9AATI11KcG513XpFbp0O8
 e1Mc2Sqw/ElowtATu+IkSYWP8+UGf9fBm1ILu870mlGmzvaw3xmNgd7imm0Pzqora+
 XZLQKDEZ89U/fdJ1FUSMtnehPjRZAMmn5NJ/0XqRvwosT8iqLDTAfRicIKef0FSH5N
 lbZ9kVRSeCo+w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/12] drm/fabric: add core object model and
 provider API
To: "Konstantin Sinyuk" <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <83513555d01ea2ccc426020c97afee78d0376288.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <83513555d01ea2ccc426020c97afee78d0376288.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:10:36 +0000
Message-Id: <20260825081037.27FAD1F000E9@smtp.kernel.org>
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
- [Medium] drm_fabric_endpoint_find_by_dev_name() skips ambiguity checking =
when busname is provided.
--

--- Patch [1]: [RFC PATCH 01/12] drm/fabric: add core object model and prov=
ider API ---
commit a52787ad8ee51af45c9fca91640883affafd66ca
Author: Ilia Levi <ilia.levi@intel.com>

drm/fabric: add core object model and provider API

This commit introduces a common DRM object model for interconnect fabrics,
endpoints, ports, and peers. It provides a registry and a provider API to
manage object identities, relationships, and lifetimes under a central lock.

> diff --git a/drivers/gpu/drm/fabric/drm_fabric.c b/drivers/gpu/drm/fabric=
/drm_fabric.c
> new file mode 100644
> index 0000000000000..8769d7bdcde1f
> --- /dev/null
> +++ b/drivers/gpu/drm/fabric/drm_fabric.c

[ ... ]

> +/*
> + * Returns NULL if no endpoint matches, or ERR_PTR(-EINVAL) if @devname =
is
> + * ambiguous across buses and @busname does not disambiguate it.
> + */
> +struct drm_fabric_endpoint *
> +drm_fabric_endpoint_find_by_dev_name(const char *devname, const char *bu=
sname)
> +{
> +	struct drm_fabric_endpoint *match =3D NULL;
> +	struct drm_fabric_endpoint *ep;
> +	unsigned long idx;
> +
> +	lockdep_assert_held(&drm_fabric_lock);
> +	xa_for_each(&drm_fabric_ep_xa, idx, ep) {
> +		if (strcmp(dev_name(ep->parent), devname))
> +			continue;
> +
> +		if (busname) {
> +			if (strcmp(dev_bus_name(ep->parent), busname))
> +				continue;
> +			return ep;

[Severity: Medium]
Does this early return bypass the ambiguity check if a single parent device
registers multiple endpoints?=20

When a busname is provided, this path returns the very first matching endpo=
int
it finds. If a device matching both the devname and busname has registered
multiple endpoints, this silently resolves to the first one instead of
rejecting the ambiguous lookup with ERR_PTR(-EINVAL).=20

The code block just below this handles the ambiguity correctly when busname
is not provided. Should the busname path also continue checking the rest of
the xarray to ensure only one match exists?

> +		}
> +
> +		if (match)
> +			return ERR_PTR(-EINVAL);
> +
> +		match =3D ep;
> +	}
> +
> +	return match;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787552412.gi=
t.ksinyuk@kernel.org?part=3D1
