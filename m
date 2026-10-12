Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30340CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2B610E3EA;
	Mon, 12 Oct 2026 04:49:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8748A10EC90;
 Mon, 12 Oct 2026 04:49:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4361B4038C;
 Mon, 12 Oct 2026 04:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD331F0089B;
 Mon, 12 Oct 2026 04:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780556;
 bh=FlP+Q6VPAQ89l/+LmvP/RFTKGX26aBUD8bgnc7amopY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IDH4srskOwuBtHqjyZMev0Qn3ux9qEvs4+bND0+eRXWLfaCE6D+rWndp13aNfyzj4
 gIY/CSRvKYu4GwhdjCdIX6le/I0WRRQHTLpWwtzqlUhVE5hLKE7pu5J3eXmAYCtWyT
 /SreizbegX9CrGUaczubk6Vvxo1m5H7gn5A2Ur9Vvm3LnBQSZ1KrbTd9l7vtEa5JA3
 WSnTJItaHkWRkiaBwtnD4bTmyec/YV4PS0Au7QsvsgNQleoWgu2dIbdgddNF0BELAE
 PqaY4bCF3RE7hqWk6YCkJkcEh7ExmsaUniFIZughtOrpkbtbr27a6NwmnYT2JXYlzh
 8d4ii8cFnGfSg==
Message-ID: <sashiko-outbox-167630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/56] drm/i915/hdmi: Add functions for FRL training
 state machine
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-15-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-15-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:49:16 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm: missing read-modify-write in intel_hdmi_train_lanes overwrite=
s hardware state
- [High] drm: usleep_range() called in atomic context via read_poll_timeout=
 during FRL training
- [High] drm: lockless traversal of global encoder_list during FRL polling
- [High] drm/i915/hdmi: FRL link training pattern overwritten with 0 (NO_LT=
P) on FFE change
- [Low] drm: un-undef'd macro 'done' pollutes file scope in intel_hdmi.c
--

commit 786a188382d5678ef07d3ee398364ffb41065e98
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Add functions for FRL training state machine

This commit adds the FRL link training state machine and helpers to drive it
with an HDMI FRL sink over SCDC. It prepares for LTS:2, trains lanes in
LTS:3, completes training in LTS:P, and falls back to legacy TMDS in LTS:L.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index 692480311c745..47d10ae0b07fd 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -3523,3 +3523,304 @@ void intel_hdmi_prepare_for_frl_mode(const struct=
 intel_crtc_state *crtc_state)
> =20
>  	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf=
);
>  }
> +
> +static int is_flt_ready(struct intel_encoder *encoder)
> +{
> +	struct intel_display *display =3D to_intel_display(encoder);
> +	struct i2c_adapter *adapter =3D
> +		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));

[Severity: High]
Does this code perform an unsafe lockless traversal of the global encoder
list?

The intel_hdmi_ddc_pin() function calls get_encoder_by_ddc_pin(), which
uses for_each_intel_encoder() to iterate over the global encoder list. This
is called repeatedly from the read_poll_timeout() loop in
intel_hdmi_frl_prepare_lts2().

Since this runs during the asynchronous atomic commit tail where the modeset
locks (like connection_mutex) are not held, could this list traversal race
against concurrent MST hotplugs adding or removing encoders? Resolving the
DDC pin adapter once before the polling loop might avoid both the locking
issue and the overhead of an O(N) traversal inside a high-frequency polling
loop.

[ ... ]
> +static bool
> +intel_hdmi_frl_prepare_lts2(struct intel_encoder *encoder,
> +			    int frl_rate, int frl_lanes,
> +			    int ffe_level)
> +{
> +#define TIMEOUT_FLT_READY_MS 250
> +	struct intel_display *display =3D to_intel_display(encoder);
> +	struct i2c_adapter *adapter =3D
> +		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
> +	int flt_ready;
> +	int ret;
> +
> +	if (!frl_rate || !frl_lanes)
> +		return false;
> +
> +	ret =3D read_poll_timeout(is_flt_ready, flt_ready,
> +				flt_ready, 1000,
> +				TIMEOUT_FLT_READY_MS * USEC_PER_MSEC,
> +				false, encoder);

[Severity: High]
Could this polling loop cause system instability by sleeping in atomic
context?

The read_poll_timeout() macro expands to a loop invoking usleep_range()
because a non-zero sleep duration (1000) is passed. Because
intel_hdmi_start_frl() is called within the encoder atomic enable or
pre_enable path, sleeping is strictly forbidden. Should this use a
non-sleeping delay such as read_poll_timeout_atomic() with udelay instead?

[ ... ]
> +static enum frl_lt_status
> +intel_hdmi_train_lanes(struct intel_encoder *encoder,
> +		       const struct intel_crtc_state *crtc_state,
> +		       int ffe_level)
> +{
> +	struct intel_display *display =3D to_intel_display(encoder);
> +	enum transcoder trans =3D crtc_state->cpu_transcoder;
> +	int num_lanes =3D crtc_state->frl.required_lanes;
> +	enum drm_scdc_frl_ltp ltp[4];
> +	u32 write_buf =3D 0;
> +	int update_flags;
> +	int lane;
[ ... ]
> +	for (lane =3D 0; lane < num_lanes; lane++) {
> +		if (ltp[lane] =3D=3D SCDC_FRL_LTP3)
> +			continue;
> +
> +		if (ltp[lane] >=3D SCDC_FRL_LTP1 && ltp[lane] <=3D SCDC_FRL_LTP8)
> +			write_buf |=3D TRANS_HDMI_FRL_LTP(ltp[lane], lane);
> +
> +		/* #TODO handle FFE change */
> +		else if (ltp[lane] =3D=3D SCDC_FRL_CHNG_FFE)
> +			continue;
> +	}
> +
> +	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf=
);

[Severity: High]
Will this direct overwrite unintentionally clear the link training pattern =
for
lanes undergoing an FFE change?

Because write_buf is initialized to 0, if any lane requires an FFE change
(SCDC_FRL_CHNG_FFE) or LTP3, the loop continues without setting bits for
that lane. Using intel_de_write() will then directly overwrite the entire
multi-field TRANS_HDMI_FRL_TRAIN register, forcing 0 (SCDC_FRL_NO_LTP) into
those skipped lanes.

The HDMI specification requires the source to preserve the current link
training pattern while adjusting FFE levels. Does this need a
read-modify-write sequence to ensure the hardware state of untouched lanes
is properly preserved?

[ ... ]
> +static enum frl_lt_status
> +intel_hdmi_frl_train_lts3(struct intel_encoder *encoder,
> +			  const struct intel_crtc_state *crtc_state,
> +			  int ffe_level)
> +{
> +#define FLT_TIMEOUT_MS 200
> +	struct intel_display *display =3D to_intel_display(encoder);
> +	enum frl_lt_status status;
> +	enum transcoder trans =3D crtc_state->cpu_transcoder;
> +	u32 buf;
> +
> +	buf =3D intel_de_read(display, TRANS_HDMI_FRL_CFG(display, trans));
> +	intel_de_write(display, TRANS_HDMI_FRL_CFG(display, trans),
> +		       buf | TRANS_HDMI_FRL_ENABLE);
> +
> +#define done (status !=3D FRL_TRAIN_CONTINUE)
> +	status =3D FRL_TRAIN_CONTINUE;
> +	read_poll_timeout(intel_hdmi_train_lanes, status,
> +			  done,
> +			  1000, FLT_TIMEOUT_MS * USEC_PER_MSEC,
> +			  false, encoder, crtc_state, ffe_level);

[Severity: Low]
This isn't a severe bug, but does the done macro need to be undefined?

Because C macros do not have block scope, defining done here without a
corresponding #undef pollutes the file scope of intel_hdmi.c. This might
cause confusing compilation errors if subsequent code uses the common word
done as a variable or struct member.

[Severity: High]
As noted above with intel_hdmi_frl_prepare_lts2(), this read_poll_timeout()
call also passes a 1000 microsecond sleep duration. This will invoke
usleep_range() while inside an atomic encoder callback. Does this need to be
changed to a non-sleeping polling function to avoid scheduling while atomic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D14
