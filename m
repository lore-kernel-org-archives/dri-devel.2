Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAC0CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBBD10F1EA;
	Mon, 12 Oct 2026 15:26:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B018F10E606;
 Mon, 12 Oct 2026 15:26:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C10BB60229;
 Mon, 12 Oct 2026 15:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A23A1F0089C;
 Mon, 12 Oct 2026 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791818773;
 bh=QFgSGhogVnDaEbtz0RRgCPm0L3WQxjAx9cj/pg1PhX8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jow8sO86ScdcwHFgxfA7b7LT7RMog3hQCJOiCWYNeUUfJZ+h6IfB66H1VQjGNjA/W
 eK8z1ZKhTV4Pl04l1bIkubYWXbVA86kzgoC8XZ7z2DkeAnS2U7UNYB8LwM4HaKzolV
 BBJ3rKGaccjSBrluZQ++ACuOPEK/GLi8ETt0zF5F+jYeScyQp6sqyPEUezwpzFoitW
 0CUkujUi5KTtdCLqZjeItNEPfFF5CEjdv2kK9ajoRVfUsGIgQoql32+Sn7ySJPCLpR
 B/xgftTsEB7BAcsvniSOuYW9F9K5Lmww7oVYilmdCw1kiv5FdFaySlZxqwz5UWOFgM
 zuh2Vn20KP+bw==
Message-ID: <sashiko-outbox-168331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 1/8] drm: Move sink link rates reading helpers
 out of i915
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-feat_link_cap-v3-1-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <20261012-feat_link_cap-v3-1-7517f4aba0f3@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:26:12 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm: drm_dp_lttpr_count() negative error code evaluated as true
- [Low] drm/display: Missing <drm/display/drm_dp_tunnel.h> include in drm_d=
p_helper.c
- [Low] drm/display: API doc mismatch in drm_dp_read_edp_sink_rates()
--

commit fd61f2a21aaa6e7f861570be192ba592894c3a4d
Author: Kory Maincent <kory.maincent@bootlin.com>

drm: Move sink link rates reading helpers out of i915

The commit moves sink link rates reading helpers from i915 into generic DRM
helpers for reuse. It leaves Intel-specific quirks in the driver.

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index e623ccb4c1d8a..8ef096a0138e4 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
[ ... ]
> @@ -4912,3 +4912,240 @@ int drm_dp_max_dprx_data_rate(int max_link_rate, =
int max_lanes)
[ ... ]
> +#if IS_ENABLED(CONFIG_DRM_DISPLAY_DP_TUNNEL)
> +
> +static u8 drm_dprx_128b132b_link_rates(const struct drm_dp_tunnel *tunne=
l,
> +				       u8 uhbr_rates)
> +{
> +	if (!drm_dp_tunnel_bw_alloc_is_enabled(tunnel))

[Severity: Low]
Does this code build correctly when CONFIG_DRM_DISPLAY_DP_TUNNEL is enabled?

The patch adds calls to drm_dp_tunnel_bw_alloc_is_enabled(),
drm_dp_tunnel_128b132b_dprx_rates(), and drm_dp_tunnel_128b132b_supported()=
 in
drm_dp_helper.c. These are defined in <drm/display/drm_dp_tunnel.h>.

However, neither drm_dp_helper.c nor its included headers appear to include
this header, which could result in implicit function declaration errors.

> +		return uhbr_rates;
> +
> +	static_assert(DP_TUNNELING_10GBPS_PER_LANE_SUPPORT =3D=3D DP_UHBR10 &&
> +		      DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT =3D=3D DP_UHBR13_5 &&
> +		      DP_TUNNELING_20GBPS_PER_LANE_SUPPORT =3D=3D DP_UHBR20);
> +
> +	return drm_dp_tunnel_128b132b_dprx_rates(tunnel);
> +}
[ ... ]
> +static int
> +drm_dp_get_128b132b_link_rates(const u8 lttpr_common_caps[DP_LTTPR_COMMO=
N_CAP_SIZE],
> +			       const struct drm_dp_tunnel *tunnel,
> +			       u8 uhbr_rates,
> +			       int link_rates[DP_MAX_128B132B_SUPPORTED_RATES])
> +{
> +	int i =3D 0;
> +
> +	if (tunnel)
> +		uhbr_rates =3D drm_dprx_128b132b_link_rates(tunnel, uhbr_rates);
> +
> +	if (drm_dp_lttpr_count(lttpr_common_caps)) {

[Severity: Medium]
Will this evaluate negative error codes as a positive repeater count?

drm_dp_lttpr_count() can return negative error codes (like -EINVAL or -ERAN=
GE)
for invalid DPCD LTTPR counts. This condition evaluates those negative erro=
rs as
true, falsely assuming a repeater is present.

If the DPCD revision lttpr_common_caps[0] is < 0x20, the else branch execut=
es
and clears uhbr_rates =3D 0, wrongly discarding the sink's supported UHBR r=
ates.

> +		/* We have a repeater */
> +		if (lttpr_common_caps[0] >=3D 0x20 &&
> +		    dp_lttpr_common_cap(lttpr_common_caps,
> +					DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER) &
> +		    DP_PHY_REPEATER_128B132B_SUPPORTED) {
[ ... ]
> +int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
> +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> +				const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
> +				const struct drm_dp_desc *desc,
> +				const struct drm_dp_tunnel *tunnel,
> +				int sink_rates[DP_MAX_SUPPORTED_RATES])
> +{
[ ... ]
> +	/*
> +	 * Sink rates for 128b/132b. If set, sink should support all 8b/10b
> +	 * rates and 10 Gbps.
> +	 */
> +	if (drm_dprx_supports_128b132b(tunnel, dpcd))
> +		i +=3D drm_dp_get_128b132b_link_rates(lttpr_common_caps,
> +						    tunnel,
> +						    uhbr_rates,
> +						    &sink_rates[i]);

[Severity: Medium]
Could this result in a NULL pointer dereference inside
drm_dp_get_128b132b_link_rates()?

Earlier in drm_dp_read_dpcd_sink_rates(), lttpr_common_caps is allowed to be
NULL:

	if (lttpr_common_caps)
		max_lttpr_rate =3D drm_dp_lttpr_max_link_rate(lttpr_common_caps);

However, it is passed blindly to drm_dp_get_128b132b_link_rates() here. If a
caller passes a NULL lttpr_common_caps, drm_dp_lttpr_count() will attempt to
access it, triggering a NULL pointer dereference.

> +
> +	return i;
> +}
> +EXPORT_SYMBOL_GPL(drm_dp_read_dpcd_sink_rates);
> +
> +/**
> + * drm_dp_read_edp_sink_rates() - read the sink rates from the eDP DPCD
[ ... ]
> +int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
> +			       int sink_rates[DP_MAX_SUPPORTED_RATES])
> +{
> +	int num_sink_rates;
> +
> +	if (edp_dpcd_rev < DP_EDP_14)
> +		return 0;
> +
> +	num_sink_rates =3D drm_dp_read_dpcd_supported_link_rates(aux, sink_rate=
s);
> +	if (num_sink_rates < 0) {
> +		drm_dbg_kms(aux->drm_dev,
> +			    "%s: Unable to read eDP supported link rates (%d)\n",
> +			    aux->name, num_sink_rates);
> +		return 0;

[Severity: Low]
Does this implementation match its API documentation?

The kernel-doc for drm_dp_read_edp_sink_rates() explicitly states:
"Returns: The number of supported sink rates, 0 if the sink does not support
the DP_SUPPORTED_LINK_RATES register, negative error code otherwise."

However, this implementation traps the negative error code internally and
explicitly returns 0 on failure. This creates a confusing API contract for
drivers using this newly exported helper.

> +	}
> +
> +	return num_sink_rates;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-feat_link_=
cap-v3-0-7517f4aba0f3@bootlin.com?part=3D1
