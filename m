Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA16C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DB610E3DA;
	Mon, 21 Sep 2026 16:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DZ/cGskp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D89C10E3DA
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:13:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E9C060120;
 Mon, 21 Sep 2026 16:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA67C1F000FF;
 Mon, 21 Sep 2026 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007218;
 bh=kWycQo4lM37PmR9oSUCMti9DpXfU2bQjMV2vOrsgPIc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DZ/cGskp9qP7sif3jWgYjtpBsE5g8LpqH5pKoAe9Rw65YQXjVal3MDOuLrgRcaKRA
 +d3VgoMijtsqcweC2HFh4kS4//Vw/scPY8V0yDj+lj89/1BXyI3YzOMm//CEeYql1l
 faINk9IG56IJlmXokgcvIIpnWab8l/X0Hh0Va3eZ7AaJS4r1CoxfhueZsWujPeDIlJ
 Cvk5SdrMQjC10F0d+KMWOVc3wZ6aQawyIKL9/oww37f5IQ+XLu2dwGhezFxhuF0Mrp
 MyMlSGfsskUm/D9OzMT3RYwKcOauBORYoijCPbya3j2Z8ZgWs1BivdU8jxCJcXWzFx
 E4nFcALJ62O6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:13:37 +0000
Message-Id: <20260921161337.CA67C1F000FF@smtp.kernel.org>
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
- [Medium] drm: VTEM infoframe not cleared when switching to non-VRR sink
--

commit 5a4e1a050c5d27ea6b13e207c2d853adeb273ef9
Author: Derek Foreman <derek.foreman@collabora.com>

drm/connector: hdmi: Add VTEM EMP generation

This commit adds VTEM EMP generation to enable variable refresh rate
signalling over HDMI. The infoframes are generated if the sink supports VRR.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index d555483996874..33d0c94916430 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
[ ... ]
> @@ -1494,6 +1548,12 @@ int drm_atomic_helper_connector_hdmi_update_infofr=
ames(struct drm_connector *con
>  			goto out;
>  	}
> =20
> +	if (info->hdmi.vrr_capable)
> +		ret =3D write_or_clear_infoframe(connector,
> +					&funcs->vtem, "VTEM",
> +					&old_conn_state->hdmi.infoframes.vtem,
> +					&new_conn_state->hdmi.infoframes.vtem);
> +
>  out:
>  	mutex_unlock(&connector->hdmi.infoframes.lock);
>  	return ret;

[Severity: Medium]
What happens if a VRR-capable sink is disconnected and replaced by a non-VRR
sink?

If info->hdmi.vrr_capable becomes false, the guard in
drm_atomic_helper_connector_hdmi_update_infoframes() evaluates to false and
skips write_or_clear_infoframe() for VTEM.

This means the hardware is never commanded to clear the VTEM infoframe via
funcs->clear_infoframe(), leading to stale VTEM packets being continuously
transmitted to a sink that does not support them.

Could this cause a hardware state mismatch and potential compliance issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D6
