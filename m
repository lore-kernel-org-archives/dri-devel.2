Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95326CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF8F10E13A;
	Mon, 12 Oct 2026 04:36:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C3510E13A;
 Mon, 12 Oct 2026 04:36:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88F51601FA;
 Mon, 12 Oct 2026 04:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BC21F0089B;
 Mon, 12 Oct 2026 04:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779805;
 bh=i6GVeJDQWzYnqch3bOHaZWUPxEBxXj60nwSeHquejJA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jjOsHKBE+rVwekLM2EU8qTQnItjGUIBqyzWaGe0tQ9Rn8CXc0JOumjjnaoRwldERV
 sTL8MIkKQEYnbnagdNZggBn/5rqMTufjHuBoSZ5jZBNALu9fLqGCl6LfQF07cqdBBY
 DxAyYv7Wh/8gg9geW3JzZfuIm+A3l9SwcQBRN23CdeA+9CWOTlIAk/n3torWY31xPV
 h+Q9HfzvfFXiJXZ6Jud1n8djjppIEUqWoBj2kvJdwsQorQQVxRVXDOqiHGVYNY5jI9
 Wo9WlvDQXUsz+hc7pIIK0Ti2uvS7UpsG+ctaxgA+TyilB7+JkOq9mZhbci4ye6Vlng
 NiC/NhwagGJyA==
Message-ID: <sashiko-outbox-167615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/56] drm/i915/hdmi: Add new data members for FRL
 configuration
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-3-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-3-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:36:44 +0000
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
- [High] drm: NULL pointer dereference in intel_bios_hdmi_max_frl_rate() vi=
a devdata
- [Medium] drm/i915: FRL rate incorrectly clamped to 0 when VBT specifies p=
latform limit
--

commit 7ad38de828b7ee44dcbd47b61d9385aa21e165af
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Add new data members for FRL configuration

This commit adds new members to crtc_state and intel_hdmi to identify
FRL-supporting HDMI sinks. It also tracks the FRL training information
after a successful link training.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index b6fa1a1558b82..69534eea78a15 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -2545,6 +2547,38 @@ intel_hdmi_dp_dual_mode_detect(struct drm_connecto=
r *_connector)
>  	}
>  }
> =20
> +static void
> +intel_hdmi_reset_frl_config(struct intel_hdmi *intel_hdmi)
> +{
> +	intel_hdmi->frl.trained =3D false;
> +	intel_hdmi->frl.lanes =3D 0;
> +	intel_hdmi->frl.rate_gbps =3D 0;
> +	intel_hdmi->frl.ffe_level =3D 0;
> +}
> +
> +static void
> +intel_hdmi_init_frl_config(struct intel_connector *connector)
> +{
> +	struct intel_hdmi *intel_hdmi =3D intel_attached_hdmi(connector);
> +	struct intel_encoder *encoder =3D &hdmi_to_dig_port(intel_hdmi)->base;
> +	int max_src_frl_rate =3D
> +		DIV_ROUND_UP(intel_bios_hdmi_max_frl_rate(encoder->devdata), 1000000) =
* 4;

[Severity: High]
Is there a risk of a NULL pointer dereference here?

When intel_hdmi_set_edid() detects a digital display, it calls
intel_hdmi_init_frl_config() which unconditionally evaluates encoder->devda=
ta
in the call to intel_bios_hdmi_max_frl_rate().

However, the devdata field in struct intel_encoder is documented as:
/* VBT information for this encoder (may be NULL for older platforms) */

If devdata is NULL, intel_bios_hdmi_max_frl_rate() will immediately
dereference it:

int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data *devd=
ata)
{
	struct intel_display *display =3D devdata->display;
    ...

Could this cause a crash upon connecting an HDMI display on platforms that
lack VBT port data?

> +	int max_sink_dsc_frl_rate =3D
> +		intel_hdmi_sink_dsc_max_frl_rate(&connector->base);
> +	int max_sink_frl_rate =3D
> +		intel_hdmi_sink_max_frl_rate(&connector->base);
> +
> +	intel_hdmi->has_sink_hdmi_21 =3D max_sink_frl_rate > 0;
> +
> +	intel_hdmi->max_frl_rate =3D min(max_sink_frl_rate,
> +				       max_src_frl_rate);

[Severity: Medium]
Does this clamp the maximum FRL rate to 0 Gbps for capable platforms?

When the VBT specifies HDMI_MAX_FRL_RATE_PLATFORM, or when no limit is
provided for platforms other than Meteorlake, intel_bios_hdmi_max_frl_rate()
returns 0.

This 0 value is converted to a max_src_frl_rate of 0, which is then passed
into this min() assignment. As a result, intel_hdmi->max_frl_rate becomes 0.

Will this unintentionally disable FRL on capable platforms that rely on the
default platform limit?

> +
> +	intel_hdmi->max_dsc_frl_rate =3D min(max_sink_dsc_frl_rate,
> +					   max_src_frl_rate);
> +
> +	intel_hdmi_reset_frl_config(intel_hdmi);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D2
