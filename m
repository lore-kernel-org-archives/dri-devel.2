Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B0C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB2E10E577;
	Fri, 14 Aug 2026 13:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aw8fxvEb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF28310E571
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:54:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE88260A59;
 Fri, 14 Aug 2026 13:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933051F00A3A;
 Fri, 14 Aug 2026 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786715654;
 bh=d9izvf+KOBuPDyUo1qt8IyzEAGLABtlL0r8o+V6Js6Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Aw8fxvEbL7DL9oEwXGQVSyQDcT13elOvrekx3eBWjvDlOjnWl1unU8KbgYmpeR1y/
 h92smOBBHjMZ890zCC+WGZXTN0nPlna8Pz58Tjx0IwsBhI96fQ7IOceMSg4/Yr5R7p
 TgbYeE4k4CS7zmH8HD1elycntIOOWYrWdc9QVz9OKau4EPIRxS8TwlYNSxB+176CcY
 B+HbFsjxRtom3KGPA2BqKU6+8/LeN4gFobbJcWSFr7+XAuRtuUGuBr+8fZ3vVwKd1r
 3ecGzBSCz0o7z0UXE81KP+AUNFN/w9g5ttMaTrRLiEq1jVRyZvLebnRX+dhU4adpKf
 E93iRHg5U+lGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] component: Release match data on add failure
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814134132.1387952-1-ruoyuw560@gmail.com>
References: <20260814134132.1387952-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:54:14 +0000
Message-Id: <20260814135414.933051F00A3A@smtp.kernel.org>
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
- [High] `component_master_add_with_match()` blindly dereferences the `matc=
h` parameter without checking if it is an `ERR_PTR`, leading to a kernel pa=
nic.
--

--- Patch [1]: [PATCH] component: Release match data on add failure ---
commit c4097bf086b1fb54cc12acc0308e520336458718
Author: Ruoyu Wang <ruoyuw560@gmail.com>

component: Release match data on add failure

component_match_add_release() accepts a release callback so callers can
transfer ownership of resources held by the match data. However,
__component_match_add() returns without invoking that callback when the
match is already an error pointer or when allocating the match or its
array fails.

> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index 655d68deb590c..2b455d7499926 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -388,14 +388,14 @@ static void __component_match_add(struct device *pa=
rent,
>  	struct component_match *match =3D *matchptr;
> =20
>  	if (IS_ERR(match))
> -		return;
> +		goto err_release;
> =20
>  	if (!match) {
>  		match =3D devres_alloc(devm_component_match_release,
>  				     sizeof(*match), GFP_KERNEL);
>  		if (!match) {
>  			*matchptr =3D ERR_PTR(-ENOMEM);
> -			return;
> +			goto err_release;

[Severity: High]
This is a pre-existing issue, but if __component_match_add() fails here and
sets *matchptr to ERR_PTR(-ENOMEM), could this result in a kernel panic
later?

Callers such as drm_of_component_probe() in drivers/gpu/drm/drm_of.c often
pass the resulting match pointer directly to
component_master_add_with_match() without checking IS_ERR(match):

drivers/gpu/drm/drm_of.c:drm_of_component_probe() {
    ...
    return component_master_add_with_match(dev, m_ops, match);
}

component_master_add_with_match() then appears to blindly dereference the
pointer:

drivers/base/component.c:component_master_add_with_match() {
    ...
    ret =3D component_match_realloc(match, match->num);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814134132.1387=
952-1-ruoyuw560@gmail.com?part=3D1
