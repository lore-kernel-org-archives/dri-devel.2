Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E86606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T52yUAsi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA06E1127E4;
	Fri, 27 Nov 2026 08:05:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C081127E3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 08:05:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EED141708;
 Fri, 27 Nov 2026 08:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D168A1F000C1;
 Fri, 27 Nov 2026 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795766749;
 bh=8O1+v6jOktcYuDLAATkSotftLGiT9Jh68Vaa5FZDE54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T52yUAsie40UKOOuK3P8slM4wpShievDHWHCxv+jYL4/ddbQ21p4bMsaJTr3qFmWk
 9W/LDhb2p1U2JUFDbqHXHXjdMbCfI0KIGoXvcFLvshHSrZSQKRHgvU9iJHmq9hRaBo
 xXw5zAK499dKwNQk1ZF48bIGGq8GeoTKpnHmwebiy750GmqlcIZrGvVuqqEdOILVNe
 cO0RLJs2yZWMdN6ybjztfX6i/eA4ysLDUpCwrC3XPY6o7Dme9qAnaKvVHd1nfUlwFU
 w8J/J25GGDRdoIwXDJBaGaXy+T9RE3u9dbB+k+lXp312ZEy2DPBOhhFOEswbdcwUog
 JeEv/6oaWp2lA==
Message-ID: <sashiko-outbox-236857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] drm/bridge: trilinear: add the DPTX hardware layer
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261127074639.277959-3-Luo.Liu@cixtech.com>
References: <20261127074639.277959-1-Luo.Liu@cixtech.com>
 <20261127074639.277959-3-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:05:48 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/bridge: trilinear: dptx_hw_dpcd_power_up/down() duplicate DP
  helpers
--

commit 4572b1c38c3025ae29ace85b65751b014caf62e2
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX hardware layer

This commit adds the register and PHY programming layer for the Trilinear
DisplayPort transmitter, including AUX transfers, DPCD capability parsing,
link training, and stream configuration.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_hw.c b/drivers/gpu/drm=
/bridge/trilinear/dptx_hw.c
> new file mode 100644
> index 0000000000000..8d8f9312d198d
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_hw.c

[ ... ]

> +static int dptx_hw_dpcd_power_up(struct dp_hw *hw,
> +				 unsigned int delay_ms)
> +{
> +	u8 value;
> +	int ret;
> +
> +	ret =3D drm_dp_dpcd_readb(&hw->aux, DP_SET_POWER, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	value =3D (value & ~DP_SET_POWER_MASK) | DP_SET_POWER_D0;
> +
> +	ret =3D drm_dp_dpcd_writeb(&hw->aux, DP_SET_POWER, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(delay_ms);
> +
> +	return 0;
> +}
> +
> +static int dptx_hw_dpcd_power_down(struct dp_hw *hw, bool hpd)
> +{
> +	u8 value;
> +	int ret;
> +
> +	if (!hpd)
> +		return 0;
> +
> +	ret =3D drm_dp_dpcd_readb(&hw->aux, DP_SET_POWER, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	value =3D (value & ~DP_SET_POWER_MASK) | DP_SET_POWER_D3;
> +
> +	ret =3D drm_dp_dpcd_writeb(&hw->aux, DP_SET_POWER, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(200, 205);
> +
> +	return 0;
> +}

[Severity: Low]
Could dptx_hw_dpcd_power_up() and dptx_hw_dpcd_power_down() use
drm_dp_link_power_up() and drm_dp_link_power_down(&hw->aux,
hw->dpcd[DP_DPCD_REV]) instead of open-coding the DP_SET_POWER
read-modify-write sequence?  Using the helpers also avoids accessing
DP_SET_POWER on DPCD v1.0 sinks where that register does not exist.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127074639.2779=
59-1-Luo.Liu@cixtech.com?part=3D2
