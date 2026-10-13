Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E55CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B60F10E8D3;
	Tue, 13 Oct 2026 14:59:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4344710E8D3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:58:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6A5443B48
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2721F000FF;
 Tue, 13 Oct 2026 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791903534;
 bh=soFU+qXa0/ORPPu9drT6BB+vJBeOanASsxCKHGvltzc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ACkLY39Zu4orqPJL1n+JAZomNQbxs/iPkqWfeksAkQ0qT8jGcMWVr5ZJXEMAM9qdS
 5quIUDGck1qI+vR8W6+CYZStaJLnWICmg2q2YmMCr3YoCTS89xkVHHqzv3MXGQTNaJ
 qWOWUDky7+zvs1fQu0TsMGPEd8HwxRPgyR3qSEJH6noNLcYRbZoFjpmipiSYqo35E0
 3kRL45nw8LAWwVibF1+VzQyAsU9sH8fqYEgsa3/tuadiGoC7B31uFaH0OZRTM77qFb
 /1ig+FkdP/w6VCYKYHY0WvfZmw/y3Ki34yDDuSQc6IhpeYAHBn8iViN4EVFr0hcTWG
 lcc/237AKL1VA==
Message-ID: <sashiko-outbox-169954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/nouveau/tegra: Keep the fuse clock enabled
 while the GPU is powered
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013145210.103565-3-sashal@kernel.org>
References: <20261013145210.103565-1-sashal@kernel.org>
 <20261013145210.103565-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:58:54 +0000
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
- [Medium] nouveau: tegra: clk_fuse leak on power_down failure
--

commit 4446c1485fff0b05a5e79c1e4d70e14c4beda300
Author: Sasha Levin <sashal@kernel.org>

    drm/nouveau/tegra: Keep the fuse clock enabled while the GPU is powered

This commit modifies nouveau's Tegra power management sequence to keep the
fuse clock enabled while the GPU is powered. This resolves an issue where
the GM20B GPU would fail to initialize on some boots.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers=
/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> index 3c8d0878891ad..31f8eaa9d6509 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c

[ ... ]

> @@ -95,6 +100,8 @@ nvkm_device_tegra_power_down(struct nvkm_device_tegra =
*tdev)
>  			return ret;
>  	}
> =20
> +	clk_disable_unprepare(tdev->clk_fuse);
> +
>  	return 0;
>  }

[Severity: Medium]
Does this code leak the clk_fuse enable and prepare counts if
regulator_disable() fails?

If regulator_disable() fails and returns an error, the function immediately
returns early. Because the new clk_disable_unprepare() call is positioned
at the very end of this function, it is skipped entirely on this error path.

Since callers like nvkm_device_tegra_dtor() ignore the return value of
nvkm_device_tegra_power_down() and proceed to free the device structure,
would this result in a permanent resource leak where the clk_fuse's prepare
and enable counts are never decremented?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013145210.1035=
65-1-sashal@kernel.org?part=3D3
