Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EEEC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42B510E46F;
	Wed, 22 Jul 2026 09:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kG7bzYXB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0164D10E27F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:38:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF6804041B;
 Wed, 22 Jul 2026 09:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8EE1F000E9;
 Wed, 22 Jul 2026 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784713085;
 bh=F2SfVmy+hyTnV5dxuMzPK29YlbcjBY1KQpkCBp/tsfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kG7bzYXBzUJXNeqnxuDbLo7+6WkqwP/kDRuj32ljknmd9lvTp3kNEiHRbr/Xd2gj5
 Z4PWGdR2RTTcOUGMTh80dkwGEma4Qk8v53qNaKlHOkqAER4cQ4L/wsysMbjuq37fwh
 5YZZH6CSqD0VZn6aB/LlB8m+iYF1op63tVMHHBkzqrhG/ICHLw7TFeGBKglMuJO4jv
 6cUPbxFyWreaLz3WKaeV6y8PQU/i2+PRTmoOOjUUKnJc/1SGkG78c14fddTiut8yxz
 HMsWcWj0W1xocNceZLsqOc+cmt7IQJMO7QZDGbzgas0vAHqIcUNt4rIMxWF+AsXOFJ
 5QRO9U3X8rGVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260722-scdc-link-health-v8-3-cd1dacbb85d9@collabora.com>
References: <20260722-scdc-link-health-v8-0-cd1dacbb85d9@collabora.com>
 <20260722-scdc-link-health-v8-3-cd1dacbb85d9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:38:04 +0000
Message-Id: <20260722093805.6C8EE1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Reed-Solomon (RS) corrections are incorrectly restricted to 4-la=
ne FRL configurations.

Pre-existing issues:
- [High] Missing lock release (deadlock) in scdc_status_show error path.
--

--- Patch [3]: [PATCH v8 3/5] drm/scdc-helper: Implement parsing and printi=
ng HDMI 2.1 fields ---
commit a8f03be96ae72bbee1ab3aab07506aef81f2031e
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

    drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
   =20
    HDMI 2.1 redefines previously reserved fields in SCDC for various new
    uses. No version check needs to be performed, as an HDMI 2.0 sink's
    reserved SCDC fields are well-defined to be 0, and any zero-ness of
    these fields for an HDMI 2.0 sink is not a surprise for SCDC parsers for
    HDMI 2.1.
   =20
    Implement reading and outputting these fields over debugfs.

> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/=
display/drm_scdc_helper.c
> index 97256b272329a..73d46de33ab55 100644
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
[ ... ]
> @@ -350,11 +417,26 @@ int drm_scdc_read_state(struct drm_connector *conne=
ctor, struct drm_scdc_state *
> =20
>  	state->scrambling_detected =3D buf[SCDC_SCRAMBLER_STATUS] & SCDC_SCRAMB=
LING_STATUS;
> =20
> +	state->rate =3D FIELD_GET(SCDC_FRL_RATE, buf[SCDC_CONFIG_1]);
> +	num_lanes =3D drm_scdc_num_frl_lanes(state->rate);
> +	if (num_lanes < 0)
> +		return num_lanes;
> +	if (!num_lanes)
> +		num_lanes =3D 3;
> +
> +	state->ffe_levels =3D FIELD_GET(SCDC_FFE_LEVELS, buf[SCDC_CONFIG_1]);
> +
>  	drm_scdc_parse_status0_flags(buf[SCDC_STATUS_FLAGS_0], &state->stf);
> -	ret =3D drm_scdc_parse_error_counters(buf, state->error_count);
> +	drm_scdc_parse_status1_2_flags(buf[SCDC_STATUS_FLAGS_1],
> +				       buf[SCDC_STATUS_FLAGS_2], &state->stf);
> +	ret =3D drm_scdc_parse_error_counters(buf, state->error_count, num_lane=
s);
>  	if (ret)
>  		return ret;
> =20
> +	if (num_lanes =3D=3D 4 && (buf[SCDC_ERR_DET_RS_H] & SCDC_CHANNEL_VALID))
> +		state->rs_corrections =3D (buf[SCDC_ERR_DET_RS_H] & ~SCDC_CHANNEL_VALI=
D) << 8 |
> +					buf[SCDC_ERR_DET_RS_L];

[Severity: Medium]
Since HDMI 2.1 Fixed Rate Link (FRL) uses Reed-Solomon Forward Error
Correction for both 3-lane and 4-lane configurations, is it intentional
to only read RS corrections when num_lanes =3D=3D 4?

Valid RS correction data for 3-lane FRL links (e.g., 3 Gbps and 6 Gbps on
3 lanes) seems to be silently ignored here.

> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_scdc_read_state);
> @@ -416,6 +498,8 @@ static int scdc_status_show(struct seq_file *m, void =
*data)

[Severity: High]
This is a pre-existing issue, but could the early exit for a disconnected
connector create a deadlock in this function?

When a connector is disconnected, the code jumps to err_conn_put:

	ret =3D mutex_lock_interruptible(&connector->dev->mode_config.mutex);
	if (ret)
		goto err_conn_put;

	if (connector->status !=3D connector_status_connected) {
		ret =3D -ENODEV;
		goto err_conn_put;
	}

But the err_conn_put label skips err_unlock:

err_unlock:
	mutex_unlock(&connector->dev->mode_config.mutex);
err_conn_put:
	drm_connector_put(connector);

Does this leave mode_config.mutex permanently locked?

> =20
>  	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
>  	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
> +	scdc_print_str(m, "FRL Rate", drm_scdc_frl_rate_str(st->rate));
> +	scdc_print_dec(m, "FFE Levels", st->ffe_levels);
> =20
>  	if (st->tmds_bclk_x40)
> @@ -426,10 +510,19 @@ static int scdc_status_show(struct seq_file *m, voi=
d *data)
>  	scdc_print_flag(m, "Channel 0 Locked", st->stf.ch0_locked);
>  	scdc_print_flag(m, "Channel 1 Locked", st->stf.ch1_locked);
>  	scdc_print_flag(m, "Channel 2 Locked", st->stf.ch2_locked);
> +	if (drm_scdc_num_frl_lanes(st->rate) =3D=3D 4)
> +		scdc_print_flag(m, "Lane 3 Locked", st->stf.ln3_locked);
> +
> +	scdc_print_flag(m, "Sink Ready For Link Training", st->stf.flt_ready);
> +	scdc_print_flag(m, "Sink Failed To Decode DSC", st->stf.dsc_fail);
> =20
>  	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
>  	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
>  	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
> +	if (drm_scdc_num_frl_lanes(st->rate) =3D=3D 4) {
> +		scdc_print_dec(m, "Lane 3 Errors", st->error_count[3]);
> +		scdc_print_dec(m, "Reed-Solomon Corrections", st->rs_corrections);

[Severity: Medium]
Similarly here, shouldn't Reed-Solomon corrections also be printed for 3-la=
ne
FRL configurations?

> +	}
> =20
>  	kfree(st);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-scdc-link-=
health-v8-0-cd1dacbb85d9@collabora.com?part=3D3
