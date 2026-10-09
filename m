Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E23CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4833B10FE47;
	Fri,  9 Oct 2026 03:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cGDH3PlW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3299E10FE47
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0E8A40AE9;
 Fri,  9 Oct 2026 03:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5AA1F000FF;
 Fri,  9 Oct 2026 03:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791516886;
 bh=zCrrD7UJeHFn5AaSL61wuMA/BnAMgkgU8ds3AgoRUBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cGDH3PlWF9aDpv2LUifvr1YbFVsU0K5WjoAiR+Qt2k2j+E/Fccru2U6f3OUM2e6Za
 POZAvR+cgJxSlYjV/qMpzeod/p1VXLQfTFQrENVowEuEa1X8vpvu1/CmqmvRkUflmT
 CANq9z0fHDB8WcC0EZGnEjkxar14HF0sVIkbDvQUlwLZjkeW7l7qAdzwedJeZnNb/N
 bH58XVb5LS/+FkozQF21u2MWUfalU8Sl+jKlNLb56PXtXqGKTaAo9uzVZs2zDhoRb+
 PoKJzoyKn+5PSGgBhi7fbBm5w/rMTpudfBXWRdMNZTqFlkniZxx2KvO+r61oO4G5GB
 08cZrc9rZLg7A==
Message-ID: <sashiko-outbox-164775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/20] drm/msm/dp: Cache eDP link capabilities after
 successful discovery
To: "Xilin Wu" <sophon@radxa.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-11-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-11-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:34:46 +0000
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
- [High] drm/msm/dp: TOCTOU race in eDP detect unexpectedly powers off panel
- [High] drm/msm/dp: eDP power sequencing violation in msm_edp_bridge_detec=
t()
--

commit bb9e355f18a717e81f26745b2bb594514c2f43b0
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Cache eDP link capabilities after successful discovery

An eDP panel may be powered off during mode validation. This commit caches
eDP link capabilities after successful discovery to persist them across
disable and suspend, and discovers capabilities from connector detect before
the first modeset.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -971,6 +983,61 @@ void msm_dp_display_set_psr(struct msm_dp *msm_dp_di=
splay, bool enter)

[ ... ]

> +enum drm_connector_status msm_edp_bridge_detect(struct drm_bridge *bridg=
e,
> +						struct drm_connector *connector)
> +{

[ ... ]

> +	ret =3D pm_runtime_resume_and_get(&display->pdev->dev);
> +	if (ret < 0)
> +		goto put_panel;
> +
> +	prepared =3D panel->prepared;
> +	if (!prepared)
> +		drm_panel_prepare(panel);

[Severity: High]
Does this sequence power up the DP host and PHY before the panel is prepare=
d?

Calling pm_runtime_resume_and_get() triggers msm_dp_pm_runtime_resume(),
which for eDP initializes the DP PHY. Preparing the panel afterwards via
drm_panel_prepare() means the PHY is powered before panel VDD is applied.
Could this drive voltage onto the AUX or main link pins of an unpowered pan=
el
and violate eDP power sequencing requirements?

[Severity: High]
Can a race condition occur here if an asynchronous atomic commit starts
concurrently?

If userspace triggers a non-blocking atomic modeset, it drops locks before
committing. If userspace then immediately issues a GETCONNECTOR ioctl, this
detect function will read prepared =3D=3D false and call drm_panel_prepare(=
).

The concurrent atomic commit would then execute panel_bridge_pre_enable(),
see that the panel is already prepared, and skip its own preparation.

> +	if (!panel->prepared) {
> +		ret =3D -EIO;
> +		goto put_pm;
> +	}
> +
> +	scoped_guard(mutex, &dp->plugged_lock) {
> +		ret =3D drm_dp_read_dpcd_caps(dp->aux, dpcd);
> +		if (!ret) {
> +			dp->link->lttpr_count =3D msm_dp_display_lttpr_init(dp, dpcd);
> +			ret =3D msm_dp_panel_read_link_caps(dp->panel, connector);
> +		}
> +	}
> +
> +	if (!prepared)
> +		drm_panel_unprepare(panel);

[Severity: High]
Is it possible for this unprepare to shut down the panel while a concurrent
modeset expects it to remain powered?

Because the atomic commit might have skipped preparing the panel (since it
was already prepared by this function), this call to drm_panel_unprepare()
could power off the panel out from under the active modeset based on the
stale local 'prepared' variable.

> +put_pm:
> +	pm_runtime_put_sync(&display->pdev->dev);

[Severity: High]
Does powering down the panel before the PHY violate the eDP power-off seque=
nce?

Here drm_panel_unprepare() removes VDD before pm_runtime_put_sync() powers
down the DP host and PHY, which reverses the expected power-down order.

> +put_panel:
> +	drm_panel_put(panel);
> +	if (ret < 0)
> +		drm_dbg_dp(dp->drm_dev, "eDP capability discovery failed: %d\n", ret);
> +
> +	/* A failed AUX access does not mean the fixed panel was disconnected. =
*/
> +	return connector_status_connected;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D11
