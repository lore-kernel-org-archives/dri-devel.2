Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C2C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDCC10E49C;
	Thu, 17 Sep 2026 12:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UkREv0UO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E95210E49C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:56:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DBE74064D;
 Thu, 17 Sep 2026 12:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C866B1F000FF;
 Thu, 17 Sep 2026 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789649760;
 bh=ARTES/B4eq/Syx/NjK0Zh4KiZ4vH4iNpxWin/dsBLkg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UkREv0UO98gXITD8VIjenz49ouOjFKMjZOaYcBHXF6fkHwicYU90xdpzXA4F39yXc
 Nren9t7U9T81RCUdYDJyHLKaniYqv2QxFuezh4sXqD91nno3qJg7N+LlVuA89Rmljn
 gmLs4TOlvdHDNkbAtlpBhQtHpmi3tAR3L3aIQ/VMK3xhk1/CRY3t6YGqF0sht6OcXH
 W/IbQt6Df921uyNTfEGb/ifEuHZU3jCd4ekgJg8Dw9ecZAm8Ygqq7xqUSmvkp+KiXA
 fk5N+QmjjWPrfb0aSRYQk82gmhuz3tlkVzaHiHjTRa5HD7QlcPgMzTOKZHepPoP1Eg
 Q2nHtqYoce11g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/msm/dp: allow eDP sinks without DP_SINK_COUNT
To: "Vivek Kumar" <vk092kumar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917124706.421107-1-vk092kumar@gmail.com>
References: <20260917124706.421107-1-vk092kumar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 12:55:59 +0000
Message-Id: <20260917125559.C866B1F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: eDP exemption missing in msm_dp_panel_read_link_caps a=
nd error code swallowed
--

commit 7281f0c6a3afd650cbe36bf532b8b56ce312bf5e
Author: Vivek Kumar <vk092kumar@gmail.com>

drm/msm/dp: allow eDP sinks without DP_SINK_COUNT

Some eDP sinks, especially fixed-format eDP-to-HDMI bridge chips with
no downstream AUX-capable panel behind them, do not report a non-zero
DP_SINK_COUNT even though they participate normally in DPCD capability
exchange and link training.

Treating sink_count =3D=3D 0 as a permanent disconnect is valid for external
DisplayPort, but it breaks eDP probe/enable paths in
msm_dp_display_prepare_link().

> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp=
_link.c
> index 34a91e194a124..bf08b5b18097d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -725,6 +725,16 @@ static int msm_dp_link_parse_sink_status_field(struc=
t msm_dp_link_private *link)
>  		DRM_ERROR("DP parse sink count failed\n");
>  		return ret;
>  	}
> +
> +	/*
> +	 * Some eDP sinks do not report a valid sink count, even though they
> +	 * otherwise participate in link training and DPCD capability exchange.
> +	 * Treat a zero raw count as a valid non-zero placeholder so we do not
> +	 * misclassify the link as disconnected on eDP.
> +	 */
> +	if (msm_dp_aux_is_edp(link->aux) && ret =3D=3D 0)
> +		ret =3D 1;
> +
>  	link->msm_dp_link.sink_count =3D ret;

[Severity: High]
Does this patch miss a similar check in msm_dp_panel_read_link_caps()?

Looking at drivers/gpu/drm/msm/dp/dp_panel.c, there is another check for the
sink count that will still return -ENOTCONN for these eDP branch devices:

drivers/gpu/drm/msm/dp/dp_panel.c:msm_dp_panel_read_link_caps() {
	...
	count =3D drm_dp_read_sink_count(panel->aux);
	if (!count) {
		panel->link->sink_count =3D 0;
		return -ENOTCONN;
	}
	...
}

Because this duplicate check aborts the connection process, eDP-to-HDMI
bridges reporting a zero sink count will still be broken, negating the
purpose of this patch.

Additionally, could the check in msm_dp_panel_read_link_caps() be
swallowing negative error codes? Since it only checks if (!count), a
negative error code (like -EIO or -ETIMEDOUT) from drm_dp_read_sink_count()
will evaluate to false, skipping the error block and allowing the code to
continue with an invalid state instead of handling the error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917124706.4211=
07-1-vk092kumar@gmail.com?part=3D1
