Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B0C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C36310E415;
	Tue,  1 Sep 2026 19:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bYZ25HnO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6B210E415
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:18:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03B3E60237;
 Tue,  1 Sep 2026 19:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F491F00A3A;
 Tue,  1 Sep 2026 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788290304;
 bh=pN0RiYFZOB+ZMTLH70p1B2FHAsDm3t8qBiAAjgafg8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bYZ25HnO90M/Bdeea5nFMPJq9VRja0a6X4eSU4qhr5MOD4FchULWXHkY6lDhZtT2F
 tzoahHCvkWXRCufp0vHbAK8uSZ+I+lXR1KX6ui8TCtRolfZMGdqPPoiNyiBMH5tojU
 sy4MAwCKnNFeey/SFv+CBfnFdRd9hHaXgr717GdjCpyR1Hoi6m045qFVIpm9SASlME
 Eq6CDR8jHkMZiw3M4paHfJd/Yk6sv3Gg7j9q5SqCFeyvadzfyC52nuF7XdjIF5sbkd
 7F5wBb+4gZA2wkCIvPBzxqhv1oBHyKgP3PT86E8d8yq6RzmUTRlMI81o5I5ThVM0Bf
 U1FDD32+JA1NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/74] drm/display: hdmi: Add HDMI 2.0 scrambling
 management helpers
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-10-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-10-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:18:24 +0000
Message-Id: <20260901191824.80F491F00A3A@smtp.kernel.org>
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
- [High] HDMI scrambling lifecycle helpers introduce sleeping functions int=
o atomic display paths.
- [Medium] Logic error in SCDC scrambling status monitor: the delayed work =
item stops scheduling itself, violating the intended periodic monitoring.
--

commit eedf8ebd00133222505fd96065a3aa6dbeefff8d
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi: Add HDMI 2.0 scrambling management helpers

This commit introduces helpers to manage the full lifecycle of HDMI 2.0
SCDC scrambling on both source and sink sides. It includes configuration
of scrambling, high TMDS clock ratios, and a delayed work item to
monitor and restore the sink's scrambling status.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/=
display/drm_hdmi_helper.c
> index 5cb0b033b1713..bf1c7963b984b 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
[ ... ]
> +static int drm_connector_hdmi_try_scrambling_setup(struct drm_connector =
*connector)
> +{
> +	bool done;
> +
> +	done =3D drm_scdc_set_high_tmds_clock_ratio(connector, true);
> +	if (!done)
> +		return -EIO;

[Severity: High]
Since drm_connector_hdmi_enable_scrambling() might be called from atomic
commit paths (like CRTC atomic enable), is it safe to call
drm_scdc_set_high_tmds_clock_ratio() here?

Looking at drm_scdc_set_high_tmds_clock_ratio() in drm_scdc_helper.c, it
uses a sleeping wait:

    usleep_range(1000, 2000);

Could this lead to sleeping in atomic context warnings or deadlocks if
reached during an atomic display update?

[Severity: Medium]
If drm_scdc_set_high_tmds_clock_ratio() or drm_scdc_set_scrambling() fail d=
ue
to a transient DDC error, we return -EIO early here and bypass the
schedule_delayed_work() call below.

Does this inadvertently stop the periodic monitoring from retrying the setup
later?

> +
> +	done =3D drm_scdc_set_scrambling(connector, true);
> +	if (!done)
> +		return -EIO;
> +
> +	if (READ_ONCE(connector->hdmi.scrambler_enabled))
> +		schedule_delayed_work(&connector->hdmi.scdc_work,
> +				      msecs_to_jiffies(DRM_HDMI_SCDC_POLL_DELAY_MS));
> +
> +	return 0;
> +}
> +
> +static void drm_connector_hdmi_scdc_work(struct work_struct *work)
> +{
[ ... ]
> +	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
> +	    !drm_scdc_get_scrambling_status(connector))
> +		drm_connector_hdmi_try_scrambling_setup(connector);
> +}

[Severity: Medium]
If the sink scrambling status is healthy (drm_scdc_get_scrambling_status()
returns true), this function exits without rescheduling itself.

Does this mean the periodic work item stops monitoring the SCDC status
entirely after the first successful check? The commit message mentions a
periodic work item that monitors the status and retries when lost, but it
appears the loop breaks as soon as the sink is in a good state.

[ ... ]
> +int drm_connector_hdmi_disable_scrambling(struct drm_connector *connecto=
r)
> +{
[ ... ]
> +	/*
> +	 * A driver may force scrambler_enabled at init to trigger a disable
> +	 * at boot (e.g. vc4), bypassing the enable path that sets up the work
> +	 * item. Only cancel it once it has actually been initialized.
> +	 */
> +	if (hdmi->scdc_work_initialized)
> +		cancel_delayed_work_sync(&hdmi->scdc_work);

[Severity: High]
If drm_connector_hdmi_disable_scrambling() is invoked from an atomic
context (e.g., during CRTC or encoder atomic disable callbacks), could
calling cancel_delayed_work_sync() cause a sleep in atomic context?

Since cancel_delayed_work_sync() can block waiting for the work to finish,
this might cause system instability if called while holding spinlocks or
from a non-preemptible path.

> +
> +	if (connector->ddc &&
> +	    connector->status =3D=3D connector_status_connected &&
> +	    drm_scdc_sink_supports_scrambling(connector)) {
> +		drm_scdc_set_scrambling(connector, false);
> +		drm_scdc_set_high_tmds_clock_ratio(connector, false);
> +	}
> +
> +	return hdmi->funcs->scrambler_disable(connector);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D10
