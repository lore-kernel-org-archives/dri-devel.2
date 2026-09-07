Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BFEC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490D110E7FF;
	Mon,  7 Sep 2026 13:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LEhVFVMr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4360810E7ED
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:14:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D28360AB5;
 Mon,  7 Sep 2026 13:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BEF1F00A3A;
 Mon,  7 Sep 2026 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788786860;
 bh=2216s4LpMjIDaFkGg/AlViLLu3u0ALlmyLC/moqAUnE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LEhVFVMrgR2haoazxJQbmb3eVyDsyqB5odcShdB7g5XenvoZmkmvYkdMNXFpcsXD2
 Po/QhbFRNXq4BAV42uufuBZ5oyWkOIREwll7wQS6K9RwQ16auEHDm1/QmcaJ/yDdsL
 v7dYcwmZh4PsOhVYcNz6sjAo6TWADbitoN1cMzF1FWl7wIljNihqtlOrACEW+WmtMv
 yS8O4I5KItrEYGt0VReKNPfvu5G0AJafUGj6Kge8QWlRZz+3YS6JqITYaklEDdH/ah
 EA0lKNe6m+UwEBtYwSc7mtGQTPwJYzCOKdDvfAjP7tRsFQdojZ/+eB09Cgz3bDWw7t
 xEZKkMRlF99vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-2-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
 <20260907-drm-msm-hdmi-fixes-before-eliza-v2-2-b097cf1eac77@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 13:14:19 +0000
Message-Id: <20260907131419.D9BEF1F00A3A@smtp.kernel.org>
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
- [High] Imprecise abort (kernel panic) in .atomic_post_disable() due to un=
clocked MMIO access after a failure in .atomic_pre_enable().
--

commit 4f4c185244ef7ea6a900e7c373d8e29c18ab92a6
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

    drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enab=
le()
   =20
    Properly handle power up failures during .atomic_pre_enable() by
    aborting the .atomic_pre_enable() to avoid accessing registers why
    blocks did not bring up.  Otherwise this could lead to imprecise aborts
    when accessing MMIO while entire power domain is off.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index 157f19bd90b4e..db85400e574e4 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
[ ... ]
> @@ -287,13 +294,18 @@ static void msm_hdmi_bridge_atomic_pre_enable(struc=
t drm_bridge *bridge,
> =20
>  	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);
> =20
> -	mutex_lock(&hdmi->state_mutex);
> -	if (!hdmi->power_on) {
> -		msm_hdmi_phy_resource_enable(phy);
> -		msm_hdmi_power_on(bridge);
> -		hdmi->power_on =3D true;
> +	scoped_guard(mutex, &hdmi->state_mutex) {
> +		if (!hdmi->power_on) {
> +			if (msm_hdmi_phy_resource_enable(phy))
> +				return;
> +
> +			if (msm_hdmi_power_on(bridge)) {
> +				msm_hdmi_phy_resource_disable(phy);
> +				return;
> +			}
> +			hdmi->power_on =3D true;
> +		}
>  	}

[Severity: High]
Does this early return cause an imprecise abort during atomic_post_disable(=
)?

Since atomic_pre_enable() returns void, the DRM core will consider the state
committed even if it returns early here. This leaves hdmi->power_on =3D fal=
se
and the PHY clocks and PM domain powered off.

When the pipeline is later disabled, msm_hdmi_bridge_atomic_post_disable()
will execute:

drivers/gpu/drm/msm/hdmi/hdmi_bridge.c:msm_hdmi_bridge_atomic_post_disable(=
) {
    ...
    /* Keep the HDMI enabled if the HPD is enabled */
    mutex_lock(&hdmi->state_mutex);
    msm_hdmi_set_mode(hdmi, hdmi->hpd_enabled);

    msm_hdmi_phy_powerdown(phy);

    if (hdmi->power_on) {
    ...
}

Because msm_hdmi_set_mode() and msm_hdmi_phy_powerdown() are called
unconditionally outside the if (hdmi->power_on) block, won't they write to
MMIO registers while the power domain is off, causing an access fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-drm-msm-hd=
mi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com?part=3D2
