Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC92C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0D110E962;
	Tue, 25 Aug 2026 08:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kDHyzltw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A83810E958
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BC9B601E0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E9D1F000E9;
 Tue, 25 Aug 2026 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787645435;
 bh=dDxI6cGBJEEaxsRYJms8F347NoZjQCxJuwPde0SsPNg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kDHyzltwWq75VsgOMTnnarhK9IGdGt5NvcX1hTLCi7uTgaK6SJWDQXAm2C6UfMOoR
 mIk7TtVYhJ3Ou2U1ejOhbR7Pj3VzN+p68jT4XZ8WtMRbKhSYjlHx+AwBahMr4TgZQI
 Plf73jpWlZszq9hzLdfPSFLjvQ4wE9/7CR4Ftc3O91nb6AGkr9ThcDzxqlqE1wJRQg
 sx2vi7ilyCH547+BHuzAZXreAu4R9zDWWxxEclVsyiaXmsCLYa+kpX6VpUbWO6z9k3
 2RBDWx/cY7Rgy7f3bk0WQiPQjoHp/ft39hnCQPrZXrQl6+VuantljY5PNlQ9jtPgDJ
 Rb+hh5ztts5yw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/12] drm/fabric: implement query netlink operations
To: "Konstantin Sinyuk" <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <fea1fb8ce49d7b673a0ccd9e950cdc0fc0565c68.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <fea1fb8ce49d7b673a0ccd9e950cdc0fc0565c68.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:10:34 +0000
Message-Id: <20260825081035.17E9D1F000E9@smtp.kernel.org>
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
- [High] Ambiguity check bypass in endpoint resolution when busname is prov=
ided.
--

--- Patch [3]: [RFC PATCH 03/12] drm/fabric: implement query netlink operat=
ions ---
commit ec7b295b3219dced2d6c1d65d7829fa5aa0283c3
Author: Konstantin Sinyuk <ksinyuk@kernel.org>
Subject: drm/fabric: implement query netlink operations

This commit registers the drm-fabric Generic Netlink family and connects
read-only query commands to the core object model. It supports single-object
lookup and multipart dumps for fabrics, endpoints, and ports.

> diff --git a/drivers/gpu/drm/fabric/drm_fabric_netlink.c b/drivers/gpu/dr=
m/fabric/drm_fabric_netlink.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/fabric/drm_fabric_netlink.c

[ ... ]

> +/* Identified by core-assigned id, or by bus + dev name. */
> +static struct drm_fabric_endpoint *
> +drm_fabric_resolve_endpoint(struct genl_info *info)
> +{
> +	struct nlattr **attrs =3D info->attrs;
> +	const char *devname =3D NULL;
> +	const char *busname =3D NULL;
> +	struct drm_fabric_endpoint *ep;
> +
> +	lockdep_assert_held(&drm_fabric_lock);
> +
> +	if (attrs[DRM_FABRIC_A_DEV_NAME])
> +		devname =3D nla_data(attrs[DRM_FABRIC_A_DEV_NAME]);
> +	if (attrs[DRM_FABRIC_A_BUS_NAME])
> +		busname =3D nla_data(attrs[DRM_FABRIC_A_BUS_NAME]);

[ ... ]

> +	if (!devname)
> +		return ERR_PTR(-EINVAL);
> +
> +	ep =3D drm_fabric_endpoint_find_by_dev_name(devname, busname);

[Severity: High]
Does this lookup bypass the ambiguity check when both devname and busname a=
re
provided?

Looking at drm_fabric_endpoint_find_by_dev_name() in drm_fabric.c:

drm_fabric_endpoint_find_by_dev_name() {
    ...
    xa_for_each(&drm_fabric_ep_xa, idx, ep) {
        if (strcmp(dev_name(ep->parent), devname))
            continue;

        if (busname) {
            if (strcmp(dev_bus_name(ep->parent), busname))
                continue;
            return ep;
        }
    ...
}

When busname is matched, the loop immediately returns the first matched
endpoint instead of assigning it to the match variable and continuing the
loop. If multiple endpoints are registered by the same physical device
(sharing the exact same devname and busname), could this cause userspace
queries to silently succeed and operate on the wrong endpoint instead of
returning an ambiguity error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787552412.gi=
t.ksinyuk@kernel.org?part=3D3
