Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F35C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A8110E0F7;
	Fri, 31 Jul 2026 18:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NtgeFNcB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B4B10E0F7
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:29:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 877D8600C3;
 Fri, 31 Jul 2026 18:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF081F00AC4;
 Fri, 31 Jul 2026 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785522574;
 bh=HBY+A5rlhzdFyquEWiYW2ZRVN2OC91gRWqsnex5DLOE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NtgeFNcBUGKfkQGB93yJSf0l24rk6sCsJ+cJGsC9Sc3pygSFgLXCvMK3ovyTdo6VQ
 tDsNyatzQAM6Pw+yNSfdbcX0JNS+H8YwFGJjfgLOevUYQgqQNgg8QdsHRTpjf/eevL
 DRgZR+cUfHTKwDX07qTRAM/6OyW+30sf9gDp02HFvqwavrw9j1QuDk4CbfDT4bHAQh
 FBd/zRUFsc96lxQ7GV1o0tcKbjPJAwOgVCcVTSkG3OT/wRilPgCdZ76hyrJDi07HBP
 ryjFb+liD8367XW5UYcO8gBQBLfUMFaWoQd7UK1XTS43aF3D8OKSnItgbshr0SGyka
 7MTvqiYyGGu9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/21] drm/bridge: synopsys: dw-dp: Use
 regmap_set_bits in dw_dp_send_sdp
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-19-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-19-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:29:32 +0000
Message-Id: <20260731182933.EAF081F00AC4@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A mutex is acquired in dw_dp_send_sdp(), which is called from the =
bridge's atomic enable path, violating atomic context rules.
--

--- Patch [19]: [PATCH v8 19/21] drm/bridge: synopsys: dw-dp: Use regmap_se=
t_bits in dw_dp_send_sdp ---
commit fbf6588f46fe1b8bc7ef347644cccb5c7a752410
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Use regmap_set_bits in dw_dp_send_sdp

This commit simplifies dw_dp_send_sdp() by making use of regmap_set_bits
instead of regmap_update_bits. No functional change is intended.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1070,14 +1070,12 @@ static int dw_dp_send_sdp(struct dw_dp *dp, struc=
t dw_dp_sdp *sdp)

[Severity: High]
Does this function sleep in an atomic context?

Looking at dw_dp_send_sdp(), it acquires a sleeping lock via
scoped_guard(mutex, &dp->sdp_lock) earlier in the function. However, this
is called from the bridge's atomic enable path:

drm_atomic_helper_commit_tail()
  -> dw_dp_bridge_atomic_enable()
    -> dw_dp_video_enable()
      -> dw_dp_send_vsc_sdp()
        -> dw_dp_send_sdp()

Can this sequence cause a kernel splat ("BUG: sleeping function called from
invalid context") or potential deadlocks when modesetting, since it executes
within drm_atomic_helper_commit_tail() where sleeping is forbidden?

>  			     FIELD_PREP(SDP_REGS, get_unaligned_le32(payload)));
> =20
>  	if (sdp->flags & DW_DP_SDP_VERTICAL_INTERVAL)
> -		regmap_update_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
> -				   EN_VERTICAL_SDP << nr,
> -				   EN_VERTICAL_SDP << nr);
> +		regmap_set_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
> +				EN_VERTICAL_SDP << nr);
> =20
>  	if (sdp->flags & DW_DP_SDP_HORIZONTAL_INTERVAL)
> -		regmap_update_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
> -				   EN_HORIZONTAL_SDP << nr,
> -				   EN_HORIZONTAL_SDP << nr);
> +		regmap_set_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
> +				EN_HORIZONTAL_SDP << nr);
> =20
>  	return nr;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D19
