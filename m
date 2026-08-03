Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49DCC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C600A10E760;
	Mon,  3 Aug 2026 18:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SMsQDEi5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5DD10E760
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:25:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FE2843E51;
 Mon,  3 Aug 2026 18:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605441F000E9;
 Mon,  3 Aug 2026 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785781556;
 bh=Lg4Ei7T3x4PiumiOJaM6qKthCJPOhQgQiLuVjJMpNHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SMsQDEi5IZpmZMKEhP1GgZo84mhcGNlwMCZp/xaMPf54ayUmVRt3u8ad9GWLlWUTL
 7AqKjDYV4icgFWe29YIVK9ZkoChZaGpcQvOiwgL5Gb5T7KYj9opHD+vFpY3KGqih9w
 XAjdlAYVPsuHfQOceLVmTyTUNpwqS0l6IpNJXxDcTRN0YRRu6wUEF2v4VDqeeV+AvV
 4DzP4m+mLOJ/Wu6LT/KTw2HunXvhpakXzM0ZvUem99E/+5z4Sc/UNpqTI5xKKF78/T
 7+q/4PMe8jmKzABaRhvjwncKEVEFscjXtmiZ9YqOMv+3L4Zc4rZovwRidenmXwywJ/
 /h8g8+Ro9Vfiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/22] drm/bridge: synopsys: dw-dp: Fix error
 handling in dw_dp_link_enable()
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-3-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-3-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:25:54 +0000
Message-Id: <20260803182555.605441F000E9@smtp.kernel.org>
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

New issues:
- [High] The patch introduces a double-free bug by adding error path cleanu=
ps (`phy_power_off()` and `drm_dp_link_power_down()`) in `dw_dp_link_enable=
()`. Because `atomic_enable` returns `void` and cannot abort a commit, the =
DRM core unconditionally invokes `atomic_disable` later, executing a second=
 cleanup.

Pre-existing issues:
- [High] A preexisting bug where `phy_power_off()` is called on atomic disa=
ble even if `phy_power_on()` failed in `dw_dp_link_enable()`, corrupting th=
e PHY power state and regulator counts.
--

--- Patch [3]: [PATCH v9 03/22] drm/bridge: synopsys: dw-dp: Fix error hand=
ling in dw_dp_link_enable() ---
commit 37d17812be83d5554aca9b8d15486591d59db100
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Fix error handling in dw_dp_link_enable()

This commit adds missing error handling in dw_dp_link_enable(), which
failed to release resources it already requested before hitting an error.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 06997208945ed..e332d66b80571 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1636,10 +1636,19 @@ static int dw_dp_link_enable(struct dw_dp *dp)
> =20

[Severity: High]
This is a pre-existing issue, but does the same unbalanced power state
happen if phy_power_on() fails?

Looking at dw_dp_link_enable(), which executes just before this hunk:

    ret =3D phy_power_on(dp->phy);
    if (ret)
        return ret;

If phy_power_on() fails, we return early. However, because atomic_enable()
returns void and cannot abort a commit, the DRM core will still
unconditionally call dw_dp_link_disable() later:

dw_dp_link_disable() {
    ...
    phy_power_off(dp->phy);
}

Will this unconditional cleanup drop the phy power count to -1, permanently
breaking subsequent power on attempts because the next phy_power_on()
will only increment the count to 0 and skip hardware initialization?

>  	ret =3D drm_dp_link_power_up(&dp->aux, dp->link.revision);
>  	if (ret < 0)
> -		return ret;
> +		goto err_phy_power_off;
> =20
>  	ret =3D dw_dp_link_train(dp);
> +	if (ret < 0)
> +		goto err_link_power_down;
> +
> +	return 0;
> +
> +err_link_power_down:
> +	drm_dp_link_power_down(&dp->aux, dp->link.revision);
> =20
> +err_phy_power_off:
> +	phy_power_off(dp->phy);

[Severity: High]
Will this explicit rollback result in phy_power_off() being called twice?

Since the DRM core will unconditionally invoke atomic_disable() later
when the commit fails, dw_dp_link_disable() will execute and perform
its own cleanup:

dw_dp_link_disable() {
    ...
    if (dw_dp_hpd_detect(dp))
        drm_dp_link_power_down(&dp->aux, dp->link.revision);
    ...
    phy_power_off(dp->phy);
}

Doing the cleanup here in the error path means these functions will be
called a second time.

Can this double cleanup cause the phy power count to drop to -1, resulting
in the same permanent breakage of the display pipeline described above?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D3
