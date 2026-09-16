Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E07EC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955C710ED4E;
	Wed, 16 Sep 2026 18:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aO7B7iAL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB08710ED49
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:30:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 606AC43EA1;
 Wed, 16 Sep 2026 18:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C6D1F000FF;
 Wed, 16 Sep 2026 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789583428;
 bh=IzUBuV8qbT4IwZrzSCAtHle0yj8X5xuvuOIcO3lUi9Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aO7B7iALBcbvUcAuxFs00Z1aXfagU0kUPPp0AYhxrdWH4tM/zQOSRDkZwpGusP3v3
 ITWu1BH270boKZKiZOQ82aN848pRmtoMaUwiV8lCJpnW8Z6qZVXXLmZwHkdO/ES1dK
 3pX/c0wZpBALRairlryFSbggE7jCars9DzBu8sDVIljzPGtc2x31+cnapcgxIVUELs
 AIxFhO+zsm95cedhWJzKR24Iz+87pVASeYmMRPjITLPlI3cTPjjd1eeJTvTqhe172S
 P7fdTvRMGiI0BSH/wpD0abvtdVBOVnuh8LICeFc+2gvLbWTV+aF0npZf69K+1/pwnU
 RFhlSevq58OrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sun4i: Fix pdev reference leak in
 sun8i_r40_tcon_tv_set_mux()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260916182412.2091681-1-vulab@iscas.ac.cn>
References: <20260916182412.2091681-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:30:27 +0000
Message-Id: <20260916183028.17C6D1F000FF@smtp.kernel.org>
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
- [Low] drm/sun4i: misapplied patch causes build failure
--

commit 576ab0ea69ae3e401d6153bcb00f1e660850ae75
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/sun4i: Fix pdev reference leak in sun8i_r40_tcon_tv_set_mux()

This commit attempts to fix a claimed reference leak in the success path of
sun8i_r40_tcon_tv_set_mux(). However, the patch modifies the wrong function
and introduces a build failure.

Fixes: 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON")
Cc: stable@vger.kernel.org

> drm/sun4i: Fix pdev reference leak in sun8i_r40_tcon_tv_set_mux()
>=20
> of_find_device_by_node() takes a reference to the TCON TOP device
> which the error paths release, but the success path returns without
> doing so.  Drop the reference before returning success.

The commit message states it fixes a leak in sun8i_r40_tcon_tv_set_mux(),
but the patch actually modifies sun4i_tcon_init_clocks().

Looking at sun8i_r40_tcon_tv_set_mux() in the baseline, the success path
appears to fall through to the out_put_device label, which already correctly
drops the reference:

out_put_device:
        put_device(&pdev->dev);

        return ret;

Could the commit message be referencing an issue that does not exist in
this tree, or was the patch misapplied?

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index bf405a2aa3249..b5a85738876ee 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -808,6 +808,8 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>  		}
>  	}
> =20
> +	put_device(&pdev->dev);

[Severity: Low]
Does this code compile? The variable pdev is undeclared in the scope of
sun4i_tcon_init_clocks(), which causes a build failure.

> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916182412.2091=
681-1-vulab@iscas.ac.cn?part=3D1
