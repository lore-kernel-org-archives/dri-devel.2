Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418A606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoylnmEN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334E6112665;
	Thu, 22 Oct 2026 13:35:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DDC11265E;
 Thu, 22 Oct 2026 13:35:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD13843F44;
 Thu, 22 Oct 2026 13:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532D61F000C7;
 Thu, 22 Oct 2026 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792676122;
 bh=PlLBVTPI7eZpeRaDmVkEiCpkiEZhzAXhcueo3GF4oYY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VoylnmEN3jSLZ2B+1hKBAGmav+2Aoy4D7B1edUtItSmEaNhplhLoiX/maHXguwL13
 wJFbnanOSM2eoKenoXausGL9ftaW1z8WuARShfCOPIfYjaZ/K4f6mP688LL8saW279
 DPA2nHhStBHFmNDO/hfjSh/h1j/bkn/+BsgoxC5QGEF4WMdTA0JcLFC/b1K/tuEkWW
 VZ9M0S1MyAUFI947CY2Cy1ntjH0+3zcrbBMmsWICmTAEIYWZ/DMOEf5fs30W/k6Grd
 VjQ1dMyjKglEdy4yWhVgoNzEED1AhLmI+uLc4egKxWMQBbMQYPnpET4SINQz5++dhQ
 07tvdvpsdBwUA==
Message-ID: <sashiko-outbox-181548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] drm/msm: dp: handle the IRQ_HPD events reported
 by USB-C
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261022-hpd-irq-events-v6-7-337ea3ddaa62@oss.qualcomm.com>
References: <20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com>
 <20261022-hpd-irq-events-v6-7-337ea3ddaa62@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 13:35:21 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dp: missing closing brace in msm_dp_bridge_hpd_notify()
--

commit 42034f570d120654d6aa4e06b9c582eb06cb2f5f
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: dp: handle the IRQ_HPD events reported by USB-C

This commit updates msm_dp_bridge_hpd_notify() to handle out-of-band
DRM_CONNECTOR_DP_IRQ_HPD events in addition to ISR_IRQ_HPD_PULSE_COUNT
link status pulses.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index ce919a26fba28..6a8b3b8e1fe7f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1566,11 +1566,13 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *=
bridge,
>  		if (hpd_link_status =3D=3D ISR_HPD_REPLUG_COUNT) {
>  			msm_dp_hpd_unplug_handle(dp);
>  			msm_dp_hpd_plug_handle(dp);
> -		} else if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT) {
> -			msm_dp_irq_hpd_handle(dp);
>  		} else {
>  			msm_dp_hpd_plug_handle(dp);
>  		}
> +
> +		if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT ||
> +		    event =3D=3D DRM_CONNECTOR_DP_IRQ_HPD) {
> +			msm_dp_irq_hpd_handle(dp);
>  	} else {
>  		msm_dp_hpd_unplug_handle(dp);
>  	}

[Severity: High]
Is a closing brace missing for the new if statement in
msm_dp_bridge_hpd_notify() in drivers/gpu/drm/msm/dp/dp_display.c?

The check for ISR_IRQ_HPD_PULSE_COUNT or DRM_CONNECTOR_DP_IRQ_HPD opens a
block with a brace before calling msm_dp_irq_hpd_handle(dp), but does not
close it before the following else branch:

	if (status =3D=3D connector_status_connected) {
		...
		if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT ||
		    event =3D=3D DRM_CONNECTOR_DP_IRQ_HPD) {
			msm_dp_irq_hpd_handle(dp);
	} else {
		msm_dp_hpd_unplug_handle(dp);
	}

Because the block is not closed, the else branch pairs with the inner
if statement instead of the outer status =3D=3D connector_status_connected =
check,
and the function body of msm_dp_bridge_hpd_notify() remains unclosed at the
end of the file, causing a build failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-hpd-irq-ev=
ents-v6-0-337ea3ddaa62@oss.qualcomm.com?part=3D7
