Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865D9CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F7010E58B;
	Tue, 23 Jun 2026 20:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EyQ1t7bW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF4310E58B
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:40:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2068B4429F;
 Tue, 23 Jun 2026 20:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF44B1F00A3D;
 Tue, 23 Jun 2026 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247213;
 bh=rz/Uz3MDqqp3Q062hRrjhSkgMloIHqoA66u6jsIgMVs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EyQ1t7bWONcoOiFV8j5/QofZL0Ww3DEwIGqHFfAyaWIZsOp613kVh6uT4SSFEZwTI
 P1A0FlFD57OSSn1+TSC+u1QS99j0ZNhz+ue58WwErJdkFsIEulloexLDg7fVKRBbC4
 9Xh63s9KOqi2KuwRR3K5JHgoUcLdnvfzouQVzxdA306zLuSB5GlHDrKRU5WZ+t8IFL
 UfscbAFvIQBOGqfY/KMaWafnDFdYfJKJSM8ti5Jd6jj1CBLu1O9hKmVL/HryaPFj/z
 0TcW8HiJ44x3VnflhTN05vwSgSs/On75wAN+DZElVq/gG5CjMBaHIhnT8V/egJ0p6y
 nbSvT15P7EeBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] drm/rockchip: vop2: Consolidate HDMI PHY PLL clock
 parent switch
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260617-dw-hdmi-qp-yuv-v1-4-a665cfd06d7d@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-4-a665cfd06d7d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:40:12 +0000
Message-Id: <20260623204012.BF44B1F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] Calling sleepable functions (`mutex_lock` and CCF APIs) inside an =
atomic context.
--

commit daeb5d187e2f25bcf364f65898a9cf55a75558aa
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Consolidate HDMI PHY PLL clock parent switch

This commit refactors the DCLK parent switch logic for HDMI0 and HDMI1
PHY PLLs. It consolidates duplicated clk_get_parent() and clk_set_parent()
calls into a single shared code path based on the active HDMI endpoint.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
[ ... ]
> @@ -1932,42 +1932,34 @@ static void vop2_crtc_atomic_enable(struct drm_cr=
tc *crtc,
[ ... ]
> +		if (pll_hdmiphy) {
> +			if (!vp->dclk_src)
> +				vp->dclk_src =3D clk_get_parent(vp->dclk);
> +
> +			ret =3D clk_set_parent(vp->dclk, pll_hdmiphy);

[Severity: High]
This is a pre-existing issue, but does calling clk_set_parent() here
result in a sleep inside an atomic context?

The vop2_crtc_atomic_enable() function executes as a CRTC atomic enable
callback, which runs in an atomic context where sleeping is forbidden.

Both clk_set_parent() and clk_prepare_enable() (called earlier in this
function) acquire sleepable mutexes, and vop2_lock() internally calls
mutex_lock(). Can this lead to kernel warnings or potential deadlocks
during the atomic commit phase?

> +			if (ret < 0)
> +				drm_warn(vop2->drm,
> +					 "Failed to switch DCLK to HDMI PHY PLL: %d\n",
> +					 ret);
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-dw-hdmi-qp=
-yuv-v1-0-a665cfd06d7d@collabora.com?part=3D4
