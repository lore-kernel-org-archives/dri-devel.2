Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A633DC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E09B10E835;
	Tue, 21 Jul 2026 09:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GwpTEg2q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD6810E835
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:10:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1F1460AAA;
 Tue, 21 Jul 2026 09:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237A21F00A3A;
 Tue, 21 Jul 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784625044;
 bh=6jJ9Qvmv/vZvd4h/8834Vmz5iuP+5lhNyL1vF57V6Cs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GwpTEg2qKYSQYRKTGFRJf8ghFKHyPskInSRUvWyALZ99Ft4KydB64eTsGZ4NffX5o
 m/mWB+OrPL2UA9gXDYRC4irYSp4gTNjIPHpW5NwpKhxttMCYQnxbRc2pk5r7NjLaYS
 Wc8oPqAl9vDJlwAhoCZRGyL2PvIM86lFQ59YwFNB4+OK0gluhHd1c2SkFoTFAX0Gbh
 L82xQlA6KMo2WUZaBCuEAPY6dtpwofF+UmRzlA0SftZMdliKsOcaddI5xXRkbeVRVw
 8i3GZrzJ0ZZInqRukgQ+5kuLDM25d7Mlu+OtbdSYDWoU+OoU+S5u3pDp+qL/PCA1+T
 oK3SRIMo4MnLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-scdc-link-health-v7-3-92df1b6ad5fc@collabora.com>
References: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
 <20260721-scdc-link-health-v7-3-92df1b6ad5fc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:10:43 +0000
Message-Id: <20260721091044.237A21F00A3A@smtp.kernel.org>
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
- [High] Incorrect checksum validation range breaks 4-lane FRL error parsin=
g.
- [High] Redefinition of `SCDC_CH_LOCK_MASK` breaks TMDS lock checking for =
HDMI 2.0 sinks.
- [Medium] Stale state leakage for `rs_corrections` across debugfs reads.
- [Medium] Reserved FRL rates cause debugfs read failures and unreachable d=
ead code.
- [Medium] Concurrent debugfs reads cause a data race on `priv->state`.
--

--- Patch [3]: [PATCH v7 3/5] drm/scdc-helper: Implement parsing and printi=
ng HDMI 2.1 fields ---
commit c31217f1c2c58d659c6532a48bf298ea495b08b1
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields

HDMI 2.1 redefines previously reserved fields in SCDC for various new uses.
Implement reading and outputting these fields over debugfs.

> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/=
display/drm_scdc_helper.c
> index 5871fc101815d..7e17272d52f23 100644
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c

[ ... ]

> -static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter=
[3])
> +static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter=
[4],
> +					 unsigned int num_lanes)
>  {
> +	u8 end_reg;
>  	u8 sum =3D 0;
>  	int i;
> =20
> -	for (i =3D SCDC_ERR_DET_0_L; i <=3D SCDC_ERR_DET_CHECKSUM ; i++)
> +	switch (num_lanes) {
> +	case 3:
> +		end_reg =3D SCDC_ERR_DET_CHECKSUM;
> +		break;
> +	case 4:
> +		end_reg =3D SCDC_ERR_DET_3_H;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D SCDC_ERR_DET_0_L; i <=3D end_reg; i++)
>  		sum =3D wrapping_add(u8, sum, scdc[i]);

[Severity: High]
Does this break the checksum validation for 4-lane FRL links?

The standard HDMI checksum is designed to sum registers 0x50 through 0x56
(SCDC_ERR_DET_CHECKSUM) to zero.

By extending the loop's end_reg to SCDC_ERR_DET_3_H (0x58) for 4-lane mode,
won't this incorporate non-checksum data into the sum and incorrectly return
-EPROTO whenever Lane 3 has errors or its valid bit is set?

[ ... ]

> @@ -356,11 +423,26 @@ int drm_scdc_read_state(struct drm_connector *conne=
ctor, struct drm_scdc_state *
> =20
>  	state->scrambling_detected =3D buf[SCDC_SCRAMBLER_STATUS] & SCDC_SCRAMB=
LING_STATUS;
> =20
> +	state->rate =3D FIELD_GET(SCDC_FRL_RATE, buf[SCDC_CONFIG_1]);
> +	num_lanes =3D drm_scdc_num_frl_lanes(state->rate);
> +	if (num_lanes < 0)
> +		return num_lanes;

[Severity: Medium]
If a sink reports a reserved FRL rate (between 7 and 15), does this cause
debugfs reads to fail entirely?

drm_scdc_num_frl_lanes() returns -EINVAL for these reserved rates, causing
drm_scdc_read_state() to immediately abort. This makes the reserved rate
strings in drm_scdc_frl_rate_str() unreachable dead code.

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
> +
>  	return 0;
>  }

[Severity: Medium]
Does this leak stale state across debugfs reads?

If a 4-lane link transitions to a state where the RS channel valid bit is
cleared, or if it drops to 3 lanes, the missing else branch here leaves the
old rs_corrections value intact.

Since the state struct is reused across reads, could this expose stale
correction counts to userspace?

[ ... ]

> @@ -406,6 +488,8 @@ static int scdc_status_show(struct seq_file *m, void =
*data)
>  {
>  	struct scdc_debugfs_priv *priv =3D m->private;
>  	struct drm_scdc_state *st =3D &priv->state;
>  	struct drm_connector *connector =3D priv->connector;
>  	struct drm_scdc *scdc =3D &connector->display_info.hdmi.scdc;
>  	int i, ret;
> =20
>  	drm_connector_get(connector);
> =20
>  	if (connector->status !=3D connector_status_connected) {
>  		ret =3D -ENODEV;
>  		goto err_conn_put;
>  	}
> =20
>  	if (scdc->supported) {
>  		ret =3D drm_scdc_read_state(connector, st);

[Severity: Medium]
Can concurrent debugfs reads cause a data race on the shared state structur=
e?

Multiple threads reading the scdc_status debugfs file share the same private
context. Calling drm_scdc_read_state() mutates the shared I2C buffer
(state->scdc) and its bitfields directly without serialization, which could
corrupt I2C reads and mangle the debugfs output.

[ ... ]

> diff --git a/include/drm/display/drm_scdc.h b/include/drm/display/drm_scd=
c.h
> index 3d58f37e8ed8e..7f0b05b2f2800 100644
> --- a/include/drm/display/drm_scdc.h
> +++ b/include/drm/display/drm_scdc.h
> @@ -46,14 +48,25 @@
>  #define SCDC_CONFIG_0 0x30
>  #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
> =20
> +#define SCDC_CONFIG_1 0x31
> +#define  SCDC_FRL_RATE   0x0f
> +#define  SCDC_FFE_LEVELS 0xf0
> +
>  #define SCDC_STATUS_FLAGS_0 0x40
> +#define  SCDC_DSC_FAIL (1 << 7)
> +#define  SCDC_FLT_READY (1 << 6)
> +#define  SCDC_LN3_LOCK (1 << 4)
>  #define  SCDC_CH2_LOCK (1 << 3)
>  #define  SCDC_CH1_LOCK (1 << 2)
>  #define  SCDC_CH0_LOCK (1 << 1)
> -#define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_LOC=
K)
> +#define  SCDC_CH_LOCK_MASK (SCDC_LN3_LOCK | SCDC_CH2_LOCK | SCDC_CH1_LOC=
K | \
> +			    SCDC_CH0_LOCK)

[Severity: High]
Can this redefinition break TMDS lock checking for HDMI 2.0 sinks?

Since HDMI 2.0 sinks only have 3 lanes, the SCDC_LN3_LOCK bit will always
be 0. Existing drivers performing an equality check against this mask
will systematically fail to detect the lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-scdc-link-=
health-v7-0-92df1b6ad5fc@collabora.com?part=3D3
