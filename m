Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221C7CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5975610E091;
	Fri, 19 Jun 2026 14:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jb0Asoqh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD6610F635
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:37:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32FAB601E1;
 Fri, 19 Jun 2026 14:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88D91F000E9;
 Fri, 19 Jun 2026 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781879823;
 bh=h2FzwHhMPtR6/FhcSa+UrMEyx65Xd3xhVypjHOd0/D0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jb0AsoqhkCKhewrhx98DNBdwmkWTwaW4NMAAul2jTNTqR+z5WRWGv2e9yeq1mpKmk
 UMRX0s5X1/a2A/aiyH27rlk7I79CCtpJsjcj8Z3HO4VCJRTnII9l0O0mefaI39ODV+
 fD4C3TBFqIinKIxXxjnyKwSwdWe9c209grd2dIiDHtM7VoiTYoCPItRJG/IhRIAqYi
 UlCMkByoNaPgXt8aTmCJCOKhO/kiD2oas2L/Utu6jejd+i1pyH691eyp3llAqunLKj
 PR+0LGnYc8I6uNhLolRw+7GjT4cg93aWScxjLvrdOdzwTH4gqY08BvfGxz9QdPPNBT
 hg7eKEfsNZ/dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 2/4] drm/i915/display/dp: Adopt dp_connector
 helpers to expose link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619-feat_link_cap-v2-2-a3dec4c02ad9@bootlin.com>
References: <20260619-feat_link_cap-v2-0-a3dec4c02ad9@bootlin.com>
 <20260619-feat_link_cap-v2-2-a3dec4c02ad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 14:37:03 +0000
Message-Id: <20260619143703.B88D91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Kernel panic in drm_connector_cleanup() due to an uninitialize=
d connector when kmemdup_array fails.
- [High] Calling DRM DP helpers from atomic commit tail violates locking co=
ntracts and introduces a data race.
- [Medium] The current negotiated link parameters are incorrectly reported =
as the maximum link parameters.
- [Medium] The source maximum lane count capability is incorrectly hardcode=
d to 4, misrepresenting actual port capabilities.
- [Medium] The return value of drm_connector_dp_init_with_ddc() is ignored,=
 potentially leaving the connector with missing source capabilities on allo=
cation failure.
- [Medium] The failure path for the rates allocation misses the cleanup for=
 intel_dp_aux_init(), leaking resources.
--

commit 77ebe85e37823b9a8f351840bfca5631c84a3dac
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/i915/display/dp: Adopt dp_connector helpers to expose link training sta=
te

This commit switches the i915 DP connector initialization to use
drm_connector_dp_init_with_ddc() to provide source link capabilities.
It also adds intel_dp_report_link_train() to collect and expose
negotiated link parameters via the DRM DP helpers.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 5c3e816b01352..5f934257771a7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c

[ ... ]

> @@ -7174,10 +7178,12 @@ intel_dp_init_connector(struct intel_digital_port=
 *dig_port,
>  			struct intel_connector *connector)
>  {

[ ... ]

> +	intel_dp_set_source_rates(intel_dp);
> +	link_caps.nlanes =3D 4;

[Severity: Medium]
Is it intentional to hardcode the maximum lane count to 4 here?

Some digital encoder ports may be restricted to 1 or 2 lanes depending on
the hardware platform or Type-C port configuration. The actual capability
is stored in dig_port->max_lanes. Hardcoding this to 4 might misrepresent
the actual port capabilities.

> +	link_caps.nlink_rates =3D intel_dp->num_source_rates;
> +	rates =3D kmemdup_array(intel_dp->source_rates, intel_dp->num_source_ra=
tes,
> +			      sizeof(*rates), GFP_KERNEL);
> +	if (!rates)
> +		goto fail;

[Severity: Critical]
Does this error path trigger a NULL pointer dereference?

At this point in the initialization, drm_connector_dp_init_with_ddc()
hasn't been called yet, so connector->base.dev is still NULL.

The jump to the fail label calls drm_connector_cleanup(&connector->base).
This function unconditionally dereferences the device pointer, which will
cause a kernel panic.

[Severity: Medium]
Does this error path also leak the resources allocated by intel_dp_aux_init=
()
earlier in this function?

The direct jump to the fail label bypasses the intel_dp_aux_fini(intel_dp)
call, which means the aux channel name allocation and the PM QoS request
will permanently leak.

> +
> +	link_caps.link_rates =3D rates;
> +	link_caps.dsc =3D HAS_DSC(display);
> +
> +	drm_connector_dp_init_with_ddc(dev, &connector->base, &intel_dp_connect=
or_funcs,
> +				       &link_caps, type, &intel_dp->aux.ddc);

[Severity: Medium]
Should we check the return value here?

drm_connector_dp_init_with_ddc() can fail with -ENOMEM when allocating the
link capabilities array internally. If it fails, the connector will proceed
partially initialized without its source capabilities.

> +	kfree(rates);
> +
>  	drm_connector_helper_add(&connector->base, &intel_dp_connector_helper_f=
uncs);

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driv=
ers/gpu/drm/i915/display/intel_dp_link_training.c
> index 54c585c59b900..aaa6eba058af5 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -1116,6 +1116,18 @@ intel_dp_128b132b_intra_hop(struct intel_dp *intel=
_dp,
>  	return sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION ? 1 : 0;
>  }
> =20
> +static void intel_dp_report_link_train(struct intel_dp *intel_dp)
> +{
> +	struct intel_connector *connector =3D intel_dp->attached_connector;
> +
> +	drm_dp_set_max_link_params(&connector->base, intel_dp->link_rate,
> +				   intel_dp->lane_count);

[Severity: Medium]
Should this report the architectural maximums instead of the currently
negotiated parameters?

intel_dp->link_rate and intel_dp->lane_count reflect the current link
configuration, which might have been downgraded due to training failures
or signal degradation. The hardware maximum capabilities are stored in
intel_dp->link.max_rate and intel_dp->link.max_lane_count.

[Severity: High]
Can this helper be safely called from this context?

drm_dp_set_max_link_params() and drm_dp_set_cur_link_params() both require
the connection_mutex to be held. However, intel_dp_stop_link_train()
(which calls this) executes during the hardware enable phase (commit_tail).

For non-blocking commits, this runs asynchronously in a workqueue after
the modeset locks have already been released. This will trigger a lockdep
warning and could race against concurrent userspace sysfs readers.

> +
> +	drm_dp_set_cur_link_params(&connector->base, intel_dp->link_rate,
> +				   intel_dp->lane_count,
> +				   connector->dp.dsc_decompression_enabled);
> +}

[ ... ]

> @@ -1652,6 +1667,8 @@ void intel_dp_start_link_train(struct intel_atomic_=
state *state,
>  	 */
>  	int lttpr_count;
> =20
> +	drm_dp_sink_set_link_caps(&intel_dp->attached_connector->base, &intel_d=
p->aux);

[Severity: High]
Similar to the helpers above, drm_dp_sink_set_link_caps() explicitly warns
if the connection_mutex is not locked.

Since intel_dp_start_link_train() is executed from the asynchronous
commit_tail for non-blocking commits, the modeset locks are already
released. Can this cause a lockdep warning and data race during asynchronous
commits?

> +
>  	intel_hpd_block(encoder);
> =20
>  	lttpr_count =3D intel_dp_init_lttpr_and_dprx_caps(intel_dp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-feat_link_=
cap-v2-0-a3dec4c02ad9@bootlin.com?part=3D2
