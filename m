Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9075EC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4FC10EE37;
	Fri, 31 Jul 2026 18:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VP3dMfCQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A778310EE37
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:09:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41F6140102;
 Fri, 31 Jul 2026 18:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15061F00AC4;
 Fri, 31 Jul 2026 18:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785521370;
 bh=ojNdvUhX5+FIN9OpIb23oVh1d3WS9iHSbY+Myk4Z0fo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VP3dMfCQ5higcPpPwWBIHN+uEvf0EqJ8qpzDth/AsoP5ZCwZws3Twv8dJOsCd7ZhL
 uJhxhGsUmIM7qdwU+TNxs3bUIp8dN4asUj01+55Zit0jjmO+NNDctslgEQOQOrSp9i
 FYtEyZ536hrizCO54b6im/KDmqCchZJ27IW1g3twmSDFrnwRCMXj/bdUxlE8lqayg7
 BdreMCc0DA4MDUCKSxvyarJOL3i2eyd5E5XDXYQvO/7HO+AE+hJnXKDawt5p2el4L2
 SKJf3BcY9mMPE9p8yEoo/Ra8RLYmiIT6/0humH35zXL/qZYIs4cOHTzLuNGHTP4BUA
 czW1S05SpAldA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/21] drm/bridge: synopsys: dw-dp: Drop useless
 reservation of first slot
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-17-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-17-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:09:29 +0000
Message-Id: <20260731180929.E15061F00AC4@smtp.kernel.org>
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
- [Critical] Missing bounds check and integer underflow in DP AUX read allo=
ws a malicious DP sink to overflow the kernel stack.

Pre-existing issues:
- [High] Infinite loop in `dw_dp_link_clock_recovery()` triggered by oscill=
ating sink requests.
--

--- Patch [17]: [PATCH v8 17/21] drm/bridge: synopsys: dw-dp: Drop useless =
reservation of first slot ---
commit 1a405fda22c71ea438c7181332eedd3948880f18
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Drop useless reservation of first slot

This commit drops the useless reservation of the first SDP slot in the
atomic_enable code. It resolves a potential race condition with audio SDP
reservation once that feature is added.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 4d4af6a388b19..193816126e44e 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1697,9 +1697,6 @@ static void dw_dp_bridge_atomic_enable(struct drm_b=
ridge *bridge,
>  		return;
>  	}
> =20
> -	scoped_guard(mutex, &dp->sdp_lock)
> -		set_bit(0, dp->sdp_reg_bank);
> -
>  	ret =3D dw_dp_link_enable(dp);
>  	if (ret < 0) {
>  		dev_err(dp->dev, "failed to enable link: %d\n", ret);

[ ... ]

> static int dw_dp_link_clock_recovery(struct dw_dp *dp)
> {
[ ... ]
> 	for (;;) {
[ ... ]
> 		adj_changed =3D dw_dp_link_get_adjustments(link, status);
> 		if (!adj_changed)
> 			tries++;
> 		else
> 			tries =3D 0;
>=20
> 		if (tries =3D=3D 5)
> 			break;
> 	}
>=20
> 	return 0;
> }

[Severity: High]
This is a pre-existing issue, but does this code allow an infinite loop if a
non-compliant DP sink continuously alternates its requested voltage or
pre-emphasis levels?

Since there is no hard iteration limit, if the sink changes requests without
achieving clock recovery, adj_changed remains true and resets tries to 0.

Could this trap the kernel thread executing the atomic commit in an infinite
loop, leading to a permanent hung task?

[ ... ]

> @@ -1513,7 +1513,7 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux=
 *aux,
>  		if (msg->request & DP_AUX_I2C_READ) {
>  			size_t count =3D FIELD_GET(AUX_BYTES_READ, value) - 1;
> =20
> -			if (count !=3D msg->size)
> +			if (!count)
>  				return -EBUSY;
> =20
>  			ret =3D dw_dp_aux_read_data(dp, msg->buffer, count);

[Severity: Critical]
Does this change remove the bounds check against msg->size, introducing an
integer underflow and a potential buffer overflow?

If the hardware reports 0 bytes read, count =3D 0 - 1 underflows to SIZE_MA=
X.
This would cause !count to evaluate to false and dw_dp_aux_read_data() to
execute an effectively infinite write loop.

Even without underflow, if the hardware reports a size larger than msg->siz=
e,
could it write past the end of msg->buffer?

Since msg->buffer is frequently allocated on the stack by the DRM core for
small reads, this might grant an external device the ability to corrupt
kernel stack memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D17
