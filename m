Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45031CD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BD910E33A;
	Sun,  7 Jun 2026 21:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dlMmlQSJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E932D10E33A
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:46:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBBFE43D4A;
 Sun,  7 Jun 2026 21:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC8E1F00893;
 Sun,  7 Jun 2026 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780868808;
 bh=xiddp7v7kHv5ulzvu1VcmAmGBmpnEySt4jryea7eyww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dlMmlQSJG1BghQKMrqKaiecigOz1qRjudDjvXA8fvqX4In9BRwqTUDM2NzERgTVsa
 7jMCmtnuq6UWQiHrT7/FHaHqGI7Fy6YD5aWvwXqFHVOyVGJxuWQY/lpDmcJ3904r82
 Y+6zIK4t5/eirEH1fRs9f1/lvaDWuqBw2K2JNTtXShfQSDf4v0+5l0nGCSCHNBCv+u
 ehs7pHFCQVNHntbHq28PAkMZxyk3ahxK69BodmxePBWkcNQpfSOZciZSBcCx2PEFcK
 leAse93PWyGu3bLBgOO0XItncxfT8xgapUb7iQZxX3+k9PuCxz1ATOZiOwNYsDDRHg
 w0YDlD2CAUclQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] drm/connector: report out-of-band IRQ_HPD events
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260608-hpd-irq-events-v4-1-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-1-30b62b335487@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:46:48 +0000
Message-Id: <20260607214648.7EC8E1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] State machine race condition causes premature HPD (and IRQ) signal=
ing before Alt Mode configuration completes.
- [High] DisplayPort is erroneously reported as connected (with IRQ) when C=
ONFIGURE command is NAKed.
--

commit 3c420485b2e1143aa3ad7bdf4a86786959837b5a
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/connector: report out-of-band IRQ_HPD events

The DisplayPort standard defines a special kind of events called IRQ,
used to notify DP Source about the events on the Sink side. This commit
renames drm_connector_oob_hotplug_event() to drm_connector_dp_oob_status()
and extends its interface to report IRQ events to the DisplayPort Sink driv=
ers.

> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec=
/altmodes/displayport.c
> index 263a89c5f3243..ff3659b8f5a2c 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -187,9 +187,11 @@ static int dp_altmode_status_update(struct dp_altmod=
e *dp)
>  				dp->pending_irq_hpd =3D true;
>  		}
>  	} else {
> -		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> +		drm_connector_dp_oob_status(dp->connector_fwnode,
>  						hpd ? connector_status_connected :
> -						      connector_status_disconnected);
> +						      connector_status_disconnected,
> +						(hpd && irq_hpd) ? DRM_CONNECTOR_DP_IRQ_HPD :
> +								   DRM_CONNECTOR_NO_EXTRA_STATUS);

[Severity: High]
This is a pre-existing issue, but since we are modifying the hotplug
notification here, can a state machine race condition cause premature HPD
signaling before Alt Mode configuration completes?

If an Attention VDM arrives before the ACK for the DP_CMD_CONFIGURE,
dp_altmode_attention() will process it immediately because dp_altmode_work()
already set dp->state to DP_STATE_IDLE after sending the async command.

In dp_altmode_status_update(), the check for
!(con & DP_CONF_CURRENTLY(dp->data.conf)) evaluates to false because
dp->data.conf was already updated prior to sending the configure command.

Execution then falls into this else block, which calls
drm_connector_dp_oob_status() with connector_status_connected prematurely.

Does this cause DRM to begin link training before the physical MUX is
configured (which only happens in dp_altmode_notify() when the ACK arrives),
leading to a failed link and non-functional display?

>  		dp->hpd =3D hpd;
>  		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");

[ ... ]

> @@ -211,8 +213,11 @@ static int dp_altmode_configured(struct dp_altmode *=
dp)
>  	 * configuration is complete to signal HPD.
>  	 */
>  	if (dp->pending_hpd) {
> -		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> -						connector_status_connected);
> +		drm_connector_dp_oob_status(dp->connector_fwnode,
> +						connector_status_connected,
> +						dp->pending_irq_hpd ?
> +						DRM_CONNECTOR_DP_IRQ_HPD :
> +						DRM_CONNECTOR_NO_EXTRA_STATUS);

[Severity: High]
This isn't a bug introduced by this patch, but does this logic erroneously
report a connected state even when the configure command is NAKed?

When the peer NAKs the DP_CMD_CONFIGURE command, dp_altmode_vdm() handles
the NAK by resetting dp->data.conf =3D 0 and then calling dp_altmode_config=
ured().

If a prior STATUS_UPDATE VDM arrived with HPD high, dp->pending_hpd
will still be true.

Because this block checks dp->pending_hpd without verifying if the
configuration actually succeeded (for example, by checking if
dp->data.conf !=3D 0), it unconditionally calls drm_connector_dp_oob_status=
()
with connector_status_connected.

Meanwhile, dp_altmode_notify() sets the MUX to TYPEC_STATE_USB because
dp->data.conf is 0.

Could this cause DRM to attempt DP link training over an unrouted AUX
channel, resulting in repeated timeouts and desynchronized state?

>  		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
>  		dp->pending_hpd =3D false;
>  		if (dp->pending_irq_hpd) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-hpd-irq-ev=
ents-v4-0-30b62b335487@oss.qualcomm.com?part=3D1
