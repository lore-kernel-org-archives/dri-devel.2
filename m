Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE7EC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB5510F27D;
	Fri, 28 Aug 2026 07:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FcU1IPDF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4670710F27D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:02:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EDE0843558;
 Fri, 28 Aug 2026 07:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849DA1F000E9;
 Fri, 28 Aug 2026 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787900565;
 bh=+a7GdgOMcJk4X7XMTFSPz6+85imM70GdNDcQ+KGn58Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FcU1IPDFQf3cdDn17NBQNRySPzDmDFwTSvUFTZKcNGHFIYNolpaEOluT+hrzzvA0x
 zslhFCpa6LFwU0VdQb/C2aAJ6x43uJXIgJjQFjnv6pbJBt9Z8UGA9KVVD33meDHY+H
 nDPrnN7XbhVZ0qeUBxwPcPWoiIDRzRMQrAbkjigE+T7rMDiA1RcxLf0k1jae6noJrs
 Y/bDHeRHk7u8W2cMWQ3F7aEB1LyVzfRntypCdmD1G7+1Rp56K2g8NrtQAZVKUm7BlQ
 PPAytgg2C5L5HVMg9eS6/4Xg5BJGYDbu5tMvTIa5URK6c2Slf6EVNiXIs+jdupWOws
 tZnWfwyAT4dLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] drm/bridge: analogix_dp: Add support for
 optional data-lanes mapping
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260828065153.590802-6-damon.ding@rock-chips.com>
References: <20260828065153.590802-1-damon.ding@rock-chips.com>
 <20260828065153.590802-6-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 07:02:45 +0000
Message-Id: <20260828070245.849DA1F000E9@smtp.kernel.org>
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
- [High] Incorrect hardware lane mapping due to logic-to-physical vs physic=
al-to-logic mismatch, effectively programming the inverse of the intended m=
apping.
--

commit 83b65668f019b59b41d7d71bc5a8a34dd644922a
Author: Damon Ding <damon.ding@rock-chips.com>
drm/bridge: analogix_dp: Add support for optional data-lanes mapping

This commit parses the optional 'data-lanes' device tree property to support
custom physical lane mapping configurations. If no valid configuration is
found, it automatically falls back to a default lane map.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index ea8401293a23a..c1344a3f013ab 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c

[ ... ]

> @@ -48,16 +48,15 @@ void analogix_dp_stop_video(struct analogix_dp_device=
 *dp)
>  	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
>  }
> =20
> -void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
> +void analogix_dp_lane_mapping(struct analogix_dp_device *dp)
>  {
> +	u32 *lane_map =3D dp->video_info.lane_map;
>  	u32 reg;
> =20
> -	if (enable)
> -		reg =3D LANE3_MAP_LOGIC_LANE_0 | LANE2_MAP_LOGIC_LANE_1 |
> -		      LANE1_MAP_LOGIC_LANE_2 | LANE0_MAP_LOGIC_LANE_3;
> -	else
> -		reg =3D LANE3_MAP_LOGIC_LANE_3 | LANE2_MAP_LOGIC_LANE_2 |
> -		      LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;
> +	reg =3D lane_map[0] << LANE0_MAP_SHIFT;
> +	reg |=3D lane_map[1] << LANE1_MAP_SHIFT;
> +	reg |=3D lane_map[2] << LANE2_MAP_SHIFT;
> +	reg |=3D lane_map[3] << LANE3_MAP_SHIFT;

[Severity: High]
Does this logic unintentionally program the inverse of the intended lane=20
mapping?

The data-lanes device tree property specifies the physical lane for each
logical lane, where lane_map[logical_index] =3D physical_index. However, the
ANALOGIX_DP_LANE_MAP register is structured to select a logical lane for ea=
ch
physical lane.

In analogix_dp_lane_mapping(), the code uses the logical lane index to
select the shift mask (e.g., LANE0_MAP_SHIFT) and assigns the physical lane
index (lane_map[0]) as the value. This configures physical lane 0 to output
logical lane lane_map[0], which results in the inverse of the intended mapp=
ing
when an asymmetric configuration is used.

Would it be more appropriate to write the logical lane index into the shift
corresponding to the physical lane? For example, by doing something like:

    reg |=3D logical_index << (lane_map[logical_index] * 2);

> =20
>  	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_MAP);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828065153.5908=
02-1-damon.ding@rock-chips.com?part=3D5
