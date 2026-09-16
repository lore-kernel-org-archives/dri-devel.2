Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4750DC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B7A10E32B;
	Wed, 16 Sep 2026 10:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QsJ9r1QE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822CE10E32B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:13:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0644660234;
 Wed, 16 Sep 2026 10:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A1C1F000FF;
 Wed, 16 Sep 2026 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789553585;
 bh=h+NwlS7B4UM6+qxPyzfslof0EuOmbBrsfO0RE4as1IU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QsJ9r1QEUa7E1n5PYvdIVW8YBSNqDNzx1f3md2mptt35xzN50shCu74WlPQMbP1Ez
 D/UxzsteP4sNmPTZURkNmolsJTsN0fNG4xHImt0AnzoD23SXybqdSwms56WfNzflrh
 4Obb9qqlqyB7chrq52wwMVUKt06bGdITTb5O/jifQigZW3CpqtwjEivvcGG/HySYDZ
 AumnwzdO7tluA1IbUPngGQI8SdgTvdWCaWbhl3e4HEs0aAN5Po1Q7A/0lKNDyv2h9A
 65nGOGjGNFggu5RqJJ31shlGL3BSkc10OF2XPbUC2i1Ck7gWLCnB6rl+6oLVETc6AI
 sxkMgo2NDON+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Fix runtime PM leak in
 cdns_dsi_bridge_atomic_pre_enable()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916100405.2012604-1-vulab@iscas.ac.cn>
References: <20260916100405.2012604-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:13:05 +0000
Message-Id: <20260916101305.90A1C1F000FF@smtp.kernel.org>
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
- [Medium] drm/cdns-dsi: double pm_runtime_put() causes usage counter under=
flow
--

commit 863c1242b6ff6841137bcc0956d0095317384036
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/bridge: cdns-dsi: Fix runtime PM leak in cdns_dsi_bridge_atomic_pre_ena=
ble()

This commit attempts to fix a runtime PM leak when pm_runtime_get_sync() fa=
ils
by adding a call to pm_runtime_put_noidle(). The function then returns earl=
y.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu=
/drm/bridge/cadence/cdns-dsi-core.c
> index c3e466ded84ab..dcf7d3e409815 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -733,8 +733,10 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct=
 drm_bridge *bridge,
>  	 * enable their streams.
>  	 */
> =20
> -	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
> +	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0)) {
> +		pm_runtime_put_noidle(dsi->base.dev);

[Severity: Medium]
Will this lead to a double-put of the runtime PM reference?

Since cdns_dsi_bridge_atomic_pre_enable() returns void, the DRM core is
unaware that the bridge failed to enable. The atomic commit continues norma=
lly,
and when the bridge is later disabled, cdns_dsi_bridge_atomic_post_disable()
is called unconditionally.

If we look at cdns_dsi_bridge_atomic_post_disable(), it executes a second p=
ut
during teardown:

static void cdns_dsi_bridge_atomic_post_disable(...)
{
	...
	pm_runtime_put(dsi->base.dev);
}

Wouldn't this decrement the usage count again and cause a runtime PM usage
counter underflow?

>  		return;
> +	}
> =20
>  	new_bridge_state =3D drm_atomic_get_new_bridge_state(state, bridge);
>  	if (WARN_ON(!new_bridge_state))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916100405.2012=
604-1-vulab@iscas.ac.cn?part=3D1
