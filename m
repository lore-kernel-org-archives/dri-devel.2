Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62203606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM15GLLP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27D01123C5;
	Thu, 29 Oct 2026 15:19:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CD511239C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:19:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC161605C4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784F11F01816;
 Thu, 29 Oct 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793287138;
 bh=/47TzYWIWFbIHqOl8PbnuufAHS3Hiupg9xsLYxHpH3k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PM15GLLPCySVtuMYKvK4VbcoPm5/sAEmd+N3L/s0QFLcqFD6Us1cK0L7grlxu1OED
 kALlnFFMheIUyyJut4xw5fDtCcyU1F6qTjApbIwDqYZJ5zwe5a8L/gImxPJ+DYKvef
 MCzK6l8qWiD8qL2yve+M3l095/uyVAj2n+8URsePwwRvj/8W9WAsfTEjQAiuutTGvd
 irYXFjiKvcAanY9rFtrx5Lt1j/ui+mDfDtNl/NRB+f2wZ/8aeNu4B40dQSulTMw5+0
 P1veHMJdnIL7TaaPPsOhfXR1fGcyqNwGnsorzNVyPmtl/BT6fpFwR1zGFW/+dZMQCn
 tzCyWXCtTHVOA==
Message-ID: <sashiko-outbox-189592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 30/31] accel: ethosu: Require active weight streams
 setup
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-30-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-30-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:18:58 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] accel: ethosu: skip inactive streams in buffer_size() when lengt=
h was set
--

commit 11fbe055c6b0770ecac837f4b9d39668ea40786d
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Require active weight streams setup

This commit requires every active weight or scale stream to be explicitly
configured or disabled with a zero length, deriving the active stream count
from the NPU configuration on U85 and from NPU_SET_PARALLEL_MODE on U65.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 1935440fb815b..21458aacfcad6 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

> @@ -767,19 +768,45 @@ static int calc_sizes_resize(struct drm_device *dde=
v,
>  	return 0;
>  }
> =20
> +static int weight_streams(struct ethosu_device *edev, struct cmd_state *=
st,
> +			  u8 *streams)
> +{
> +	if (ethosu_is_u65(edev)) {
> +		if (FIELD_GET(CONFIG_MACS_PER_CC_MASK, edev->npu_info.config) =3D=3D
> +		    NPU_MACS_PER_CC_256) {
> +			*streams =3D 1;
> +			return 0;
> +		}
> +
> +		if (!cmd_state_reg_is_set(st, NPU_SET_PARALLEL_MODE))
> +			return -EINVAL;
> +
> +		*streams =3D st->parallel_mode + 1;
> +	} else {
> +		*streams =3D 1 << FIELD_GET(CONFIG_NUM_WD_MASK,
> +					   edev->npu_info.config);
> +	}
> +
> +	return 0;
> +}
> +
>  static int buffer_size(struct ethosu_validated_cmdstream_info *info,
>  		       struct cmd_state *st, struct buffer *buf, s8 region,
> -		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
> +		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool can_omit)
>  {
>  	u64 end;
>  	bool base_set =3D cmd_state_reg_is_set(st, base_cmd);
>  	bool length_set =3D cmd_state_reg_is_set(st, length_cmd);
> =20
> -	if (optional && !base_set && !length_set)
> +	if (can_omit && !length_set)
>  		return 0;

[Severity: Medium]
Should buffer_size() return 0 whenever can_omit is true, regardless of
whether length_set is true?

On Ethos-U65 with 512 MACs/cc, weight_streams() computes the active stream
count per operation from st->parallel_mode (*streams =3D st->parallel_mode =
+ 1).

If an operation in a command stream runs with NPU_SET_PARALLEL_MODE set to 1
(streams =3D=3D 2), it configures NPU_SET_WEIGHT1_BASE / NPU_SET_WEIGHT1_LE=
NGTH
and NPU_SET_SCALE1_BASE / NPU_SET_SCALE1_LENGTH. In
ethosu_gem_cmdstream_copy_and_validate(), cmd_state_set_reg() sets the
corresponding bits in the cumulative st.cmd1 bitmap (which is never cleared
during the command stream) and populates st.weight[1] and st.scale[1].

If a subsequent operation in the same command stream switches to
NPU_SET_PARALLEL_MODE =3D 0 (streams =3D=3D 1) and changes NPU_SET_WEIGHT_R=
EGION or
NPU_SET_SCALE_REGION (for example, to SRAM or a smaller buffer), stream 1 is
inactive and calc_sizes() passes can_omit =3D (streams < 2) as true:

calc_sizes()
	buffer_size(info, st, &st->weight[1], st->weight[0].region,
		    NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT1_BASE,
		    NPU_SET_WEIGHT1_LENGTH, streams < 2)

	buffer_size(info, st, &st->scale[1], st->scale[0].region,
		    NPU_SET_SCALE_REGION, NPU_SET_SCALE1_BASE,
		    NPU_SET_SCALE1_LENGTH, streams < 2)

Because length_set remains true in st.cmd1 from the earlier operation,
buffer_size() will not return early at "if (can_omit && !length_set)". Will
this charge the stale st->weight[1] and st->scale[1] bounds against the new
operation's st->weight[0].region and st->scale[0].region, inflating
info->region_size[region] and causing valid job submissions to be rejected =
in
ethosu_ioctl_submit_job()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D30
