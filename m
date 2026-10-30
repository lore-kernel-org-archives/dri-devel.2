Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11169606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9D85x++
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F2210E87F;
	Fri, 30 Oct 2026 08:37:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547E411268D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:37:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2350641FC1;
 Fri, 30 Oct 2026 08:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF3C1F000C1;
 Fri, 30 Oct 2026 08:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793349446;
 bh=LPJfuPSRvmCX8ZOKueslTeteQVQleL+NB+Sdt0+TBn0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F9D85x++AMSICtZceoWvIv2mQQ7SlGsIlnyArV6aTmeTbUgPyLYJ82+4Ev1VkoNjn
 lhQBWOC45j5z+qo11+OQIFyPrg4Ifa8X57Mpdgv2QgKSxRp8dy8zo0fbqqT72TvW/p
 0I8EWOt1Yvrpuzu2sFlXpBUpu2HQ8lRm0SXRcg9SnMl83FrYK7DUus9LFX4O3mGH4j
 q9VRZLpQduakKOd9U2K4PF95NZEl6rJpXQkKVPn4WY6wd7VuZSpSDmYjrNbeO7zDFJ
 UnuBplm9Isp3lv3r7TAcoHkznNBbLectIgEDNV8iGjwok8BXGsfvvsgWXv+5obwj+f
 XKZffZKY57Tsg==
Message-ID: <sashiko-outbox-190700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix runtime PM refcount leak
 in set_bridge()
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030082820.1457-1-laixiangwu@cmss.chinamobile.com>
References: <20261030082820.1457-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 08:37:25 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/bridge: analogix_dp: dead error check on analogix_dp_init_an=
alog_func()
--

commit 84ec40424622aaaaa038f462b132aaae0d50ac8c
Author: laixiangwu <laixiangwu@cmss.chinamobile.com>

drm/bridge: analogix_dp: Fix runtime PM refcount leak in set_bridge()

This commit changes the error path after analogix_dp_init_analog_func() in
analogix_dp_set_bridge() to jump to out_dp_init so pm_runtime_put_sync() is
called on failure.

>     drm/bridge: analogix_dp: Fix runtime PM refcount leak in set_bridge()
>    =20
>     analogix_dp_set_bridge() calls pm_runtime_get_sync() to power up the
>     DP core, but if the subsequent analogix_dp_init_analog_func() fails it
>     returns the error directly, without the matching pm_runtime_put_sync(=
).
>     The two other error paths in the function already jump to the
>     out_dp_init label, which drops the reference.
>    =20
>     Every failed bridge enable therefore increments the runtime PM usage
>     counter, and repeated failures (e.g. during hotplug storms) prevent
>     the device from ever runtime suspending again.
>    =20
>     Jump to out_dp_init like the other error paths so the runtime PM
>     reference is released.
>    =20
>     Fixes: 3efe2ace7f5b ("drm/bridge: analogix_dp: move basic controller =
init into runtime PM")
>     Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
>=20
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 6df6963740d2c..c9c1375a93182 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -998,7 +998,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_=
device *dp)
> =20
>  	ret =3D analogix_dp_init_analog_func(dp);
>  	if (ret)
> -		return ret;
> +		goto out_dp_init;

[Severity: Medium]
Can analogix_dp_init_analog_func() actually fail here?

In commit 917c8d192ba6ad ("drm/bridge: analogix_dp: don't wait for PLL lock
too early"), which landed in the same series as commit 3efe2ace7f5b, the PLL
lock polling loop and the only error return (-ETIMEDOUT) were removed from
analogix_dp_init_analog_func() in
drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:

int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
{
	u32 reg;

	analogix_dp_set_analog_power_down(dp, POWER_ALL, 0);

	reg =3D PLL_LOCK_CHG;
	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_1);

	reg =3D readl(dp->reg_base + ANALOGIX_DP_DEBUG_CTL);
	reg &=3D ~(F_PLL_LOCK | PLL_LOCK_CTRL);
	writel(reg, dp->reg_base + ANALOGIX_DP_DEBUG_CTL);

	/* Power up PLL */
	analogix_dp_set_pll_power_down(dp, 0);

	/* Enable Serdes FIFO function and Link symbol clock domain module */
	reg =3D readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
	reg &=3D ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N
		| AUX_FUNC_EN_N);
	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
	return 0;
}

Because analogix_dp_init_analog_func() only performs register reads/writes
and void helper calls, it unconditionally returns 0, while the two functions
in analogix_dp_set_bridge() that can fail at runtime
(analogix_dp_detect_hpd() and analogix_dp_commit()) already jump to
out_dp_init.

Since this error branch is unreachable and no runtime PM refcount leak can
occur, would it be better to change analogix_dp_init_analog_func() in
drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c and
drivers/gpu/drm/bridge/analogix/analogix_dp_core.h to return void (matching
analogix_dp_init_dp() and the other analogix_dp_init_*() helpers) and drop
the dead error check in analogix_dp_set_bridge()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030082820.1457=
-1-laixiangwu@cmss.chinamobile.com?part=3D1
