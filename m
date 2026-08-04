Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2112C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B41110E8EC;
	Tue,  4 Aug 2026 08:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iCaoLX18";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2630B10E8EC
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:30:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07AAE60A79;
 Tue,  4 Aug 2026 08:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A301F000E9;
 Tue,  4 Aug 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785832253;
 bh=9g9WJpdvyVCic1IuudqZvp/iNeX6syDlQ6cEx+tzFS8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iCaoLX18glXyCBVJ809l7OcZqTwxqebxswEi+PQUIQpVyidfisCq0cEu76dqBn1FH
 2+2WC5BKlqpzPQ7XQfpuEo9usc2UZL/agAi+ScPxIdthg0CM/CEWeI4eXFROWCZJmH
 CUNAt2XtXZ7JPI/Q9DK5trjmEmYQi+upUrWUQimZxA3q2NQRb8dtxdRResOhMCiKP5
 c168IaDqXsphsoaCHVhn6o6Oe4hpRLB3qzRlxPO7kpJXF+COp0rQC3DJeI6wwECxAI
 AvcyV24defCAR4wwZm+cSyUMw8SwVms6Ugp/Xp61BMM7WlmilfzviJLV4N+ichYF0+
 n0V3hq8NKxUTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] drm/bridge: analogix_dp: Restrict forced
 connected status only for panel endpoint
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260804081717.741404-10-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
 <20260804081717.741404-10-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:30:52 +0000
Message-Id: <20260804083053.70A301F000E9@smtp.kernel.org>
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
- [High] Missing early return in analogix_dp_bridge_detect() causes uninten=
ded hardware accesses and significant delays for panel bridges.
- [Medium] Missing drm_bridge_put() causes a reference count leak for the b=
ridge returned by drm_bridge_chain_get_last_bridge().
--

--- Patch [9]: [PATCH v2 09/10] drm/bridge: analogix_dp: Restrict forced co=
nnected status only for panel endpoint ---
commit 7e658941bfdab69a58f5d04d4acd4ae671e37ea8
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Restrict forced connected status only for panel en=
dpoint

This commit limits the unconditional connected status shortcut to cases
where the last bridge in the chain is a panel. For other cases, it relies
on analogix_dp_detect_hpd() to report accurate hotplug state.

Link: https://lore.kernel.org/all/5209243.oAaWjsssbx@diego/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 1c85ca93ee7b1..f7db5b5a3f917 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -910,8 +910,15 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge,=
 struct drm_connector *conne
>  	struct analogix_dp_device *dp =3D to_dp(bridge);
>  	enum drm_connector_status status =3D connector_status_disconnected;
> =20
> -	if (dp->plat_data->next_bridge)
> -		return connector_status_connected;
> +	/*
> +	 * Only assume connected when the bridge chain ends with a panel.
> +	 * Panel bridges lack a detect callback and historically rely on
> +	 * this shortcut. For other next bridge types (e.g., DP connector
> +	 * bridges), fall through to analogix_dp_detect_hpd() to report
> +	 * accurate hotplug state.
> +	 */
> +	if (dp->plat_data->next_bridge && dp->last_bridge_is_panel)
> +		status =3D connector_status_connected;
> =20
>  	if (!analogix_dp_detect_hpd(dp))
>  		status =3D connector_status_connected;

[Severity: High]
Does this unintentionally fall through and execute analogix_dp_detect_hpd()
even when the bridge chain ends with a panel?

Previously, analogix_dp_bridge_detect() returned early here. By just
assigning the status without returning, it looks like panel bridges will now
unconditionally execute analogix_dp_detect_hpd(). This can introduce an
unnecessary 100ms delay and unintended register/AUX writes to manually force
HPD on hardware that lacks an HPD signal.

Should there be an early return here instead of continuing execution?

[ ... ]

> @@ -938,6 +946,10 @@ static int analogix_dp_bridge_attach(struct drm_brid=
ge *bridge,
>  			dev_err(dp->dev, "failed to attach following panel or bridge (%d)\n",=
 ret);
>  			return ret;
>  		}
> +
> +		last_bridge =3D drm_bridge_chain_get_last_bridge(dp->encoder);
> +		if (drm_bridge_is_panel(last_bridge))
> +			dp->last_bridge_is_panel =3D true;
>  	}
> =20
>  	return 0;

[Severity: Medium]
Does this leak the reference to the last bridge in analogix_dp_bridge_attac=
h()?

drm_bridge_chain_get_last_bridge() increments the reference count of the
returned bridge, but it doesn't appear that drm_bridge_put() is called
before the function returns. Will this prevent proper cleanup when the
device is unbound or the module is unloaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804081717.7414=
04-1-damon.ding@rock-chips.com?part=3D9
