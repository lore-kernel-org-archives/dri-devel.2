Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8019C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E14C10E856;
	Mon, 10 Aug 2026 13:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R4LJj0vZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CFC10E860
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:26:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B32E840A2E;
 Mon, 10 Aug 2026 13:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768151F000E9;
 Mon, 10 Aug 2026 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786368382;
 bh=4kfaYTwTR2CaM74GWI1fKz4DKeV2269fesgwXFIirZE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R4LJj0vZWYBflhfd68VM9mlj0hssVJmQ1I4Qr2cJtVcOCv/UTeIKpWX8RWnLtXdDs
 OCBYAHC3Q776+45q2Hp/T3IP5R7ltsi/y9fpzKyrMeyQwpIHWPg/tu5TE+phYT962c
 dtj4a5BTrfD/89b9CB5ox+UDitrhfb3miHJKRDdUNIpVdagZ5T2svghmYDTYDh1Zw1
 zeg7wTsJvhFFef2W5QxgUyfhp9NsSazfvv+DnB6K/7R+xsvhINIgNTiNINbtgE9UZn
 aZtHmLrHKk4Xcoy5loainy3Qbz8eE2i++bVjXhgXIJqy+RIrbF3UKJDSNtivdm16FA
 n2oE/zODtvSnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] drm: bridge: cdns-mhdp8546: use consumer API for
 getting PHY bus width
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810131314.452865-3-vladimir.oltean@nxp.com>
References: <20260810131314.452865-1-vladimir.oltean@nxp.com>
 <20260810131314.452865-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:26:21 +0000
Message-Id: <20260810132622.768151F000E9@smtp.kernel.org>
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
- [Medium] The patch replaces direct access to `phy->attrs.bus_width` with =
a consumer API to prepare for `struct phy` becoming opaque, but fails to re=
place the direct access to `phy->attrs.max_link_rate` just a few lines belo=
w.
--

--- Patch [2]: [PATCH v9 2/2] drm: bridge: cdns-mhdp8546: use consumer API =
for getting PHY bus width ---
commit ecf7ebc5abfe88e7d5e12ae439973da7de3f9c25
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width

This commit updates the driver to use the phy_get_bus_width() API instead
of directly accessing phy->attrs.bus_width. This is being done because the
definition of struct phy will soon be hidden from consumers.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index c99151fdaf03d..796c64cb18e77 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1300,7 +1300,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mh=
dp_device *mhdp)
> =20
>  	/* Get source capabilities based on PHY attributes */
> =20
> -	mhdp->host.lanes_cnt =3D mhdp->phy->attrs.bus_width;
> +	mhdp->host.lanes_cnt =3D phy_get_bus_width(mhdp->phy);
>  	if (!mhdp->host.lanes_cnt)
>  		mhdp->host.lanes_cnt =3D 4;
> =20

[Severity: Medium]
Since the goal is to stop accessing the phy attributes directly because str=
uct
phy will be hidden, does this also need to replace the access to max_link_r=
ate
just a few lines down?

In cdns_mhdp_fill_host_caps():

	mhdp->host.lanes_cnt =3D phy_get_bus_width(mhdp->phy);
	if (!mhdp->host.lanes_cnt)
		mhdp->host.lanes_cnt =3D 4;

	link_rate =3D mhdp->phy->attrs.max_link_rate;

If struct phy becomes opaque, won't this remaining direct access to
max_link_rate still cause a build failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810131314.4528=
65-1-vladimir.oltean@nxp.com?part=3D2
