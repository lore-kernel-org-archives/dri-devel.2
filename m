Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C22BC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C74610E088;
	Tue,  1 Sep 2026 16:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZFiH7+7";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696D010E088
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:02:27 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3a33307ecd9so10850461fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788278545; x=1788883345; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gaYk0M7nFh1XVdlzCHJZ1XzCsQtcpg7BjAPV4F6vU1c=;
 b=lZFiH7+7irylb3eJd8uzMntXu0ZUobTtGpEF+0DAPnlfEqDAJEvQzt9/RB4GBxfyJt
 zLT1BUqGLjvhAqUNB4HS5kITD/ReGOv+nTX+g/iZqq6rLxGK3R3bjnkjFlo/J8HKFP40
 Q5fZHEslKfAufcuWd6HJs4uFBCPfEmP9qw2vTVz/4v31H2Ed0to17LHunbDtMGDdG95D
 lOQSGcfA7HZCQdk2HgqGyaS7FLqrdPkDPpaUpNo2PhfqA3vGbGK4pyOqsGxFBH3O8G5S
 qO206re8bsaREpu62Cmb+29sgbit10sE1UH4WFyazxA8l2jrIwZFhxv5h2JmcSiguscY
 JjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788278545; x=1788883345;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gaYk0M7nFh1XVdlzCHJZ1XzCsQtcpg7BjAPV4F6vU1c=;
 b=hKA8j/OS5KOl2Ej+iunBWkJ22wSyZH2aZ77pzm4vvWjwDLYcsHRhXRZTervcW6r2uY
 bWbAVmz6xkgTR9rFbWR+dFbdmtG0ZlgHpmWXaKFAZ6LoG/truu9jZkyn9rD0UwEpN3ow
 mFj73tYX+b+UzFCT75MWXaOH5JnXvI/1s9CKyhrmlBzNIdiqPPv+j1Yf45RdlYt6DoIR
 gow5XicB4R8pAkQP4wBf2rIivKhJ5BI2DQ5eE7bdw80RKVgRTKKtdrGhJHYFTcCpz2O2
 r5oX43SJ1N5Neq4dH/bYOaNDzEOUHmdW2JpHVmGrjESG2ZLPFvMWUk43I7KBXb4jnIJT
 IxMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXPzvfIg3s/g2hENuaCCmaz7KV2in6AYya+h0dZ0zyImimkGhaDrPqU63UvK7MI97x8YQYvaRJqd0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ls3WJhb1QVoC4YqBH74tojrCiFrW0gaspV9frjw0X/9awbTNbw
 i97Lia102+nYGVtUfu5iczY5+mLWEtYNOWgpKncZK9DGmiQLJnoEAssE
X-Gm-Gg: AYBFou2rACJG7vmvSg8zh7gGfbLiCTdht8nhFBw06Eb6k9Me+gN9T8JW7TFri5FFmV/
 h3RO/yepeejgK1ZId2ZhFnQ+w1x2zq+Nl8wgyiqDrqU3TMgAkS79XzLwGF3cw8RBRNC7tLWuFdJ
 IoZ/6095r40oNxsko93UQos95uVdYou+iILdLbCB3FeLrxX9kbDpszYTC32tC0/cnlH6Mpqk31x
 /xNAwORenXVTSLDZCqPs7C8RZj7bMazCEBqZNRY4IQQY+HXRuQaSD0SesnO/N2l0du5mOEfRQys
 s4Z41Q9kd+hvv3ulabjm3dMVurvwSP8c7aYBDdAiVXLOPeErTdh2tNPSHj4fT7kJTp/d+xyz1l3
 ZpPW51DRpCpUMNY4qGjDjISciw9UiQ2OZ89TIPJYLpNfGJggrXPH8Xo9MqTST+Va799dJ5YQvIJ
 7kaxD3jHwj/Ole912yVsHAiw0ppI5ye/fvMLpYQaoQDbvFQErxuSxV+Jj1WKuypjWfSD6WK4fav
 hyYta57Aa1x0eis4Q==
X-Received: by 2002:a05:651c:249:b0:3a2:feaf:6f9b with SMTP id
 38308e7fff4ca-3a301b3f563mr71991631fa.7.1788278543702; 
 Tue, 01 Sep 2026 09:02:23 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a34ad24618sm439901fa.32.2026.09.01.09.02.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Sep 2026 09:02:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3] drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts()
 helper for audio N/CTS
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
Date: Tue, 1 Sep 2026 20:02:06 +0400
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E90466E4-C36C-4276-AA44-E40D90E48B2D@gmail.com>
References: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
To: Simon Wright <simon@symple.nz>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> On 21 May 2026, at 11:36=E2=80=AFam, Simon Wright <simon@symple.nz> =
wrote:
>=20
> dw_hdmi_qp_set_sample_rate() open-coded its own N and CTS lookup
> tables and search/compute helpers, but it lacked the out-of-table
> CTS fallback needed by strict HDMI sinks at TMDS rates not in the
> table.  The original LG G3 OLED audio mute (linux-rockchip 070633)
> was caused by dw_hdmi_qp_find_cts() returning 0 at 185.625 MHz,
> leaving AUDPKT_ACR_CTS_OVR_EN clear and falling back to the
> controller's internal CTS auto-measurement, which produces incorrect
> timing on the wire at out-of-table rates.
>=20
> The shared drm_hdmi_acr_get_n_cts() helper in
> drivers/gpu/drm/display/drm_hdmi_helper.c already implements the
> correct behaviour: it has the HDMI 1.4b spec N/CTS tables, and for
> TMDS rates not in the table it computes CTS =3D (TMDS * N) / (128 * =
Fs)
> inline (the canonical HDMI spec formula).  It is already used by
> drivers/gpu/drm/msm/hdmi/hdmi_audio.c.
>=20
> Convert dw_hdmi_qp_set_sample_rate() to call the helper.  This
> removes ~200 lines of open-coded tables and search functions
> (dw_hdmi_qp_find_n, _compute_n, _find_cts, _audio_math_diff,
> _match_tmds_n_table, common_tmds_n_table[], common_tmds_cts_table[])
> and fixes the strict-sink audio mute as a side effect of using the
> helper's complete N+CTS path.
>=20
> Tested on R76S (RK3576) running Linux 7.0.1, against the LG G3 OLED
> (the sink that originally reported the mute in linux-rockchip
> 070633) at four TMDS rates spanning HDMI 1.4 and HDMI 2.0:
>=20
>  TMDS         Mode              Audio with v3
>  148.5 MHz    1080p60   8-bit   plays
>  185.625 MHz  1080p60  10-bit   plays
>  297 MHz      1080p100  8-bit   plays
>  594 MHz      3840p60   8-bit   plays
>=20
> Without this change, the LG G3 mutes audio at 185.625, 297, and
> 594 MHz (every rate outside dw-hdmi-qp's open-coded CTS table,
> which contained only 148.5 MHz and below).  With this change,
> drm_hdmi_acr_get_n_cts() supplies the correct CTS at every rate --
> table-canonical at 148.5 / 297 / 594 MHz, and computed via the
> HDMI 1.4b formula at 185.625 MHz.  The 148.5 MHz row is a
> regression check confirming the in-table path is unchanged.
>=20
> The Kogan KALED43XU9210STA (a permissive HDMI 2.0 sink that plays
> audio at all rates with or without this change) was used as a
> no-regression control: audio plays at 594 MHz with v3 loaded.
>=20
> The open-coded N table in dw-hdmi-qp included optimised N values
> for some TMDS rates that are not in the helper's table (e.g.
> various non-CEA rates between 28-162 MHz).  For those rates the
> helper's fallback returns N =3D 128 * Fs / 1000, which is the same
> value dw_hdmi_qp_compute_n() returned when no table optimisation
> was needed; no audio regression has been observed at the rates
> tested above.
>=20
> Reported-by: Simon Wright <simon@symple.nz>
> Closes: =
https://lore.kernel.org/linux-rockchip/ME3P282MB21960D9D68BFF520316BDFCEA8=
3E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM/
> Suggested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Simon Wright <simon@symple.nz>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Simon Wright <simon@symple.nz>
> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

This resolved no HDMI audio on a Radxa Rock4D (RK3576) board using
Linux 7.2.1 while connected to an LG 64B7V (via Marantz AVR), so:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

> ---
> Changes in v3:
>  - Switch to drm_hdmi_acr_get_n_cts() helper as suggested by Jonas
>    Karlman, instead of adding the cts-from-N fallback inline.
>    Removes ~200 lines of open-coded N/CTS tables and search code,
>    and brings dw-hdmi-qp in line with msm/hdmi.
>  - Re-tested on the LG G3 OLED (the sink that originally reported
>    the mute) at all four TMDS rates (148.5 / 185.625 / 297 / 594
>    MHz); audio plays at every rate.  v3 has not been re-tested on
>    the LG C4 OLED or TCL 75P7K QLED that v2 included; those sinks
>    are expected to behave the same as G3 since the helper returns
>    spec-canonical HDMI 1.4b values.
>  - Also addresses a do_div() divisor-type style issue flagged by
>    sashiko's automated review of v2 (the offending line is removed
>    by the helper switch).
>  - Add Suggested-by: Jonas Karlman.
>  - Rebased onto current drm-misc-next.
>=20
> Changes in v2:
>  - Resend after v1 was mailer-mangled and unapplyable (reported by
>    Luca Ceresoli).
>  - Body split into shorter paragraphs for readability per Luca's
>    review.
>  - Original LG G3 report (linux-rockchip 070633) moved from inline
>    prose to a Closes: trailer paired with Reported-by:, per
>    Documentation/process/submitting-patches.rst.
>  - Add Assisted-by: trailer per
>    Documentation/process/coding-assistants.rst.
>=20
> v2: =
https://lore.kernel.org/linux-rockchip/00a34a82-213b-4b03-801c-3c10b163d64=
3@symple.nz/
> v1: =
https://lore.kernel.org/linux-rockchip/92aa4191-2a2a-41e3-badb-c0a5b1fbb95=
7@symple.nz/
>=20
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 209 +------------------
> 1 file changed, 1 insertion(+), 208 deletions(-)
>=20
>=20
> base-commit: a48bbcc7ac739e93562d6148c6fa504c2e9f22f8
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c =
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index 0dbb1274360..4e745e2c97b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -42,88 +42,6 @@
>=20
> #define SCRAMB_POLL_DELAY_MS 3000
>=20
> -/*
> - * Unless otherwise noted, entries in this table are 100% =
optimization.
> - * Values can be obtained from dw_hdmi_qp_compute_n() but that =
function is
> - * slow so we pre-compute values we expect to see.
> - *
> - * The values for TMDS 25175, 25200, 27000, 54000, 74250 and 148500 =
kHz are
> - * the recommended N values specified in the Audio chapter of the =
HDMI
> - * specification.
> - */
> -static const struct dw_hdmi_audio_tmds_n {
> - unsigned long tmds;
> - unsigned int n_32k;
> - unsigned int n_44k1;
> - unsigned int n_48k;
> -} common_tmds_n_table[] =3D {
> - { .tmds =3D 25175000,  .n_32k =3D 4576,  .n_44k1 =3D 7007,  .n_48k =3D=
 6864, },
> - { .tmds =3D 25200000,  .n_32k =3D 4096,  .n_44k1 =3D 6272,  .n_48k =3D=
 6144, },
> - { .tmds =3D 27000000,  .n_32k =3D 4096,  .n_44k1 =3D 6272,  .n_48k =3D=
 6144, },
> - { .tmds =3D 28320000,  .n_32k =3D 4096,  .n_44k1 =3D 5586,  .n_48k =3D=
 6144, },
> - { .tmds =3D 30240000,  .n_32k =3D 4096,  .n_44k1 =3D 5642,  .n_48k =3D=
 6144, },
> - { .tmds =3D 31500000,  .n_32k =3D 4096,  .n_44k1 =3D 5600,  .n_48k =3D=
 6144, },
> - { .tmds =3D 32000000,  .n_32k =3D 4096,  .n_44k1 =3D 5733,  .n_48k =3D=
 6144, },
> - { .tmds =3D 33750000,  .n_32k =3D 4096,  .n_44k1 =3D 6272,  .n_48k =3D=
 6144, },
> - { .tmds =3D 36000000,  .n_32k =3D 4096,  .n_44k1 =3D 5684,  .n_48k =3D=
 6144, },
> - { .tmds =3D 40000000,  .n_32k =3D 4096,  .n_44k1 =3D 5733,  .n_48k =3D=
 6144, },
> - { .tmds =3D 49500000,  .n_32k =3D 4096,  .n_44k1 =3D 5488,  .n_48k =3D=
 6144, },
> - { .tmds =3D 50000000,  .n_32k =3D 4096,  .n_44k1 =3D 5292,  .n_48k =3D=
 6144, },
> - { .tmds =3D 54000000,  .n_32k =3D 4096,  .n_44k1 =3D 6272,  .n_48k =3D=
 6144, },
> - { .tmds =3D 65000000,  .n_32k =3D 4096,  .n_44k1 =3D 7056,  .n_48k =3D=
 6144, },
> - { .tmds =3D 68250000,  .n_32k =3D 4096,  .n_44k1 =3D 5376,  .n_48k =3D=
 6144, },
> - { .tmds =3D 71000000,  .n_32k =3D 4096,  .n_44k1 =3D 7056,  .n_48k =3D=
 6144, },
> - { .tmds =3D 72000000,  .n_32k =3D 4096,  .n_44k1 =3D 5635,  .n_48k =3D=
 6144, },
> - { .tmds =3D 73250000,  .n_32k =3D 11648, .n_44k1 =3D 14112, .n_48k =3D=
 6144, },
> - { .tmds =3D 74250000,  .n_32k =3D 4096,  .n_44k1 =3D 6272,  .n_48k =3D=
 6144, },
> - { .tmds =3D 75000000,  .n_32k =3D 4096,  .n_44k1 =3D 5880,  .n_48k =3D=
 6144, },
> - { .tmds =3D 78750000,  .n_32k =3D 4096,  .n_44k1 =3D 5600,  .n_48k =3D=
 6144, },
> - { .tmds =3D 78800000,  .n_32k =3D 4096,  .n_44k1 =3D 5292,  .n_48k =3D=
 6144, },
> - { .tmds =3D 79500000,  .n_32k =3D 4096,  .n_44k1 =3D 4704,  .n_48k =3D=
 6144, },
> - { .tmds =3D 83500000,  .n_32k =3D 4096,  .n_44k1 =3D 7056,  .n_48k =3D=
 6144, },
> - { .tmds =3D 85500000,  .n_32k =3D 4096,  .n_44k1 =3D 5488,  .n_48k =3D=
 6144, },
> - { .tmds =3D 88750000,  .n_32k =3D 4096,  .n_44k1 =3D 14112, .n_48k =3D=
 6144, },
> - { .tmds =3D 97750000,  .n_32k =3D 4096,  .n_44k1 =3D 14112, .n_48k =3D=
 6144, },
> - { .tmds =3D 101000000, .n_32k =3D 4096,  .n_44k1 =3D 7056,  .n_48k =3D=
 6144, },
> - { .tmds =3D 106500000, .n_32k =3D 4096,  .n_44k1 =3D 4704,  .n_48k =3D=
 6144, },
> - { .tmds =3D 108000000, .n_32k =3D 4096,  .n_44k1 =3D 5684,  .n_48k =3D=
 6144, },
> - { .tmds =3D 115500000, .n_32k =3D 4096,  .n_44k1 =3D 5712,  .n_48k =3D=
 6144, },
> - { .tmds =3D 119000000, .n_32k =3D 4096,  .n_44k1 =3D 5544,  .n_48k =3D=
 6144, },
> - { .tmds =3D 135000000, .n_32k =3D 4096,  .n_44k1 =3D 5488,  .n_48k =3D=
 6144, },
> - { .tmds =3D 146250000, .n_32k =3D 11648, .n_44k1 =3D 6272,  .n_48k =3D=
 6144, },
> - { .tmds =3D 148500000, .n_32k =3D 4096,  .n_44k1 =3D 6272,  .n_48k =3D=
 6144, },
> - { .tmds =3D 154000000, .n_32k =3D 4096,  .n_44k1 =3D 5544,  .n_48k =3D=
 6144, },
> - { .tmds =3D 162000000, .n_32k =3D 4096,  .n_44k1 =3D 5684,  .n_48k =3D=
 6144, },
> -
> - /* For 297 MHz+ HDMI spec have some other rule for setting N */
> - { .tmds =3D 297000000, .n_32k =3D 3073,  .n_44k1 =3D 4704,  .n_48k =3D=
 5120, },
> - { .tmds =3D 594000000, .n_32k =3D 3073,  .n_44k1 =3D 9408,  .n_48k =3D=
 10240,},
> -
> - /* End of table */
> - { .tmds =3D 0,         .n_32k =3D 0,     .n_44k1 =3D 0,     .n_48k =3D=
 0,    },
> -};
> -
> -/*
> - * These are the CTS values as recommended in the Audio chapter of =
the HDMI
> - * specification.
> - */
> -static const struct dw_hdmi_audio_tmds_cts {
> - unsigned long tmds;
> - unsigned int cts_32k;
> - unsigned int cts_44k1;
> - unsigned int cts_48k;
> -} common_tmds_cts_table[] =3D {
> - { .tmds =3D 25175000,  .cts_32k =3D 28125,  .cts_44k1 =3D 31250,  =
.cts_48k =3D 28125,  },
> - { .tmds =3D 25200000,  .cts_32k =3D 25200,  .cts_44k1 =3D 28000,  =
.cts_48k =3D 25200,  },
> - { .tmds =3D 27000000,  .cts_32k =3D 27000,  .cts_44k1 =3D 30000,  =
.cts_48k =3D 27000,  },
> - { .tmds =3D 54000000,  .cts_32k =3D 54000,  .cts_44k1 =3D 60000,  =
.cts_48k =3D 54000,  },
> - { .tmds =3D 74250000,  .cts_32k =3D 74250,  .cts_44k1 =3D 82500,  =
.cts_48k =3D 74250,  },
> - { .tmds =3D 148500000, .cts_32k =3D 148500, .cts_44k1 =3D 165000, =
.cts_48k =3D 148500, },
> -
> - /* End of table */
> - { .tmds =3D 0,         .cts_32k =3D 0,      .cts_44k1 =3D 0,      =
.cts_48k =3D 0,      },
> -};
> -
> struct dw_hdmi_qp_i2c {
> struct i2c_adapter adap;
>=20
> @@ -215,130 +133,6 @@ static void dw_hdmi_qp_set_cts_n(struct =
dw_hdmi_qp *hdmi, unsigned int cts,
>       AUDPKT_ACR_CONTROL1);
> }
>=20
> -static int dw_hdmi_qp_match_tmds_n_table(struct dw_hdmi_qp *hdmi,
> - unsigned long pixel_clk,
> - unsigned long freq)
> -{
> - const struct dw_hdmi_audio_tmds_n *tmds_n =3D NULL;
> - int i;
> -
> - for (i =3D 0; common_tmds_n_table[i].tmds !=3D 0; i++) {
> - if (pixel_clk =3D=3D common_tmds_n_table[i].tmds) {
> - tmds_n =3D &common_tmds_n_table[i];
> - break;
> - }
> - }
> -
> - if (!tmds_n)
> - return -ENOENT;
> -
> - switch (freq) {
> - case 32000:
> - return tmds_n->n_32k;
> - case 44100:
> - case 88200:
> - case 176400:
> - return (freq / 44100) * tmds_n->n_44k1;
> - case 48000:
> - case 96000:
> - case 192000:
> - return (freq / 48000) * tmds_n->n_48k;
> - default:
> - return -ENOENT;
> - }
> -}
> -
> -static u32 dw_hdmi_qp_audio_math_diff(unsigned int freq, unsigned int =
n,
> -      unsigned int pixel_clk)
> -{
> - u64 cts =3D mul_u32_u32(pixel_clk, n);
> -
> - return do_div(cts, 128 * freq);
> -}
> -
> -static unsigned int dw_hdmi_qp_compute_n(struct dw_hdmi_qp *hdmi,
> - unsigned long pixel_clk,
> - unsigned long freq)
> -{
> - unsigned int min_n =3D DIV_ROUND_UP((128 * freq), 1500);
> - unsigned int max_n =3D (128 * freq) / 300;
> - unsigned int ideal_n =3D (128 * freq) / 1000;
> - unsigned int best_n_distance =3D ideal_n;
> - unsigned int best_n =3D 0;
> - u64 best_diff =3D U64_MAX;
> - int n;
> -
> - /* If the ideal N could satisfy the audio math, then just take it */
> - if (dw_hdmi_qp_audio_math_diff(freq, ideal_n, pixel_clk) =3D=3D 0)
> - return ideal_n;
> -
> - for (n =3D min_n; n <=3D max_n; n++) {
> - u64 diff =3D dw_hdmi_qp_audio_math_diff(freq, n, pixel_clk);
> -
> - if (diff < best_diff ||
> -    (diff =3D=3D best_diff && abs(n - ideal_n) < best_n_distance)) {
> - best_n =3D n;
> - best_diff =3D diff;
> - best_n_distance =3D abs(best_n - ideal_n);
> - }
> -
> - /*
> - * The best N already satisfy the audio math, and also be
> - * the closest value to ideal N, so just cut the loop.
> - */
> - if (best_diff =3D=3D 0 && (abs(n - ideal_n) > best_n_distance))
> - break;
> - }
> -
> - return best_n;
> -}
> -
> -static unsigned int dw_hdmi_qp_find_n(struct dw_hdmi_qp *hdmi, =
unsigned long pixel_clk,
> -      unsigned long sample_rate)
> -{
> - int n =3D dw_hdmi_qp_match_tmds_n_table(hdmi, pixel_clk, =
sample_rate);
> -
> - if (n > 0)
> - return n;
> -
> - dev_warn(hdmi->dev, "Rate %lu missing; compute N dynamically\n",
> - pixel_clk);
> -
> - return dw_hdmi_qp_compute_n(hdmi, pixel_clk, sample_rate);
> -}
> -
> -static unsigned int dw_hdmi_qp_find_cts(struct dw_hdmi_qp *hdmi, =
unsigned long pixel_clk,
> - unsigned long sample_rate)
> -{
> - const struct dw_hdmi_audio_tmds_cts *tmds_cts =3D NULL;
> - int i;
> -
> - for (i =3D 0; common_tmds_cts_table[i].tmds !=3D 0; i++) {
> - if (pixel_clk =3D=3D common_tmds_cts_table[i].tmds) {
> - tmds_cts =3D &common_tmds_cts_table[i];
> - break;
> - }
> - }
> -
> - if (!tmds_cts)
> - return 0;
> -
> - switch (sample_rate) {
> - case 32000:
> - return tmds_cts->cts_32k;
> - case 44100:
> - case 88200:
> - case 176400:
> - return tmds_cts->cts_44k1;
> - case 48000:
> - case 96000:
> - case 192000:
> - return tmds_cts->cts_48k;
> - default:
> - return -ENOENT;
> - }
> -}
> -
> static void dw_hdmi_qp_set_audio_interface(struct dw_hdmi_qp *hdmi,
>   struct hdmi_codec_daifmt *fmt,
>   struct hdmi_codec_params *hparms)
> @@ -458,8 +252,7 @@ static void dw_hdmi_qp_set_sample_rate(struct =
dw_hdmi_qp *hdmi, unsigned long lo
> {
> unsigned int n, cts;
>=20
> - n =3D dw_hdmi_qp_find_n(hdmi, tmds_char_rate, sample_rate);
> - cts =3D dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate);
> + drm_hdmi_acr_get_n_cts(tmds_char_rate, sample_rate, &n, &cts);
>=20
> dw_hdmi_qp_set_cts_n(hdmi, cts, n);
> }

