Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9A6C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A38F10E6A8;
	Thu,  9 Jul 2026 10:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MkZeryl4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0297E10E6A8
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:55:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2167A600C3;
 Thu,  9 Jul 2026 10:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9881F000E9;
 Thu,  9 Jul 2026 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594541;
 bh=tf9oZZKqSghvS3L8/u3qi7e6/W2zTuEntclukppiZA0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MkZeryl46GovW7lLV7wOWw0Z6glrjgkXLzJ8t0+RixHqgRL9c36uDh5Tki1cXIthL
 YBlVAV53A8VCgTu7s3uwB3VYDBw8i75hFL8L9R54E1vi8vznjlt9u+P6P1iaa7eLVm
 Vnq/IWh7C32yXcanqZsce6A2nqx/PnuSxZUOvsMztlo0K0MYIGki+qBlMhHgwSsq5S
 2iwNgMEWo5IGU/lpZ99UwDp96GU2pKQWXAFegwYYhQqdq1nM44i+/QS/XfbAMT3Iq0
 szEY/VLzlgOOhH/J0W0BNwMZ4vIEQ55R7kRYNX4TvqftMdzFHr9xGZNl2G2pkeJqFc
 ituXFAZ8LFdgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] drm/mediatek: mtk_dp: Use PHY API for PHY
 power sequences
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260709100617.42583-7-angelogioacchino.delregno@collabora.com>
References: <20260709100617.42583-1-angelogioacchino.delregno@collabora.com>
 <20260709100617.42583-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:55:41 +0000
Message-Id: <20260709105541.7C9881F000E9@smtp.kernel.org>
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
- [High] Race condition during driver removal allows the HPD interrupt to r=
e-arm a deleted timer, causing a Use-After-Free.
--

--- Patch [6]: [PATCH v2 06/11] drm/mediatek: mtk_dp: Use PHY API for PHY p=
ower sequences ---
commit 7b2bea0e460b138dc02e659a05248e8bd5c96d86
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

    drm/mediatek: mtk_dp: Use PHY API for PHY power sequences
   =20
    The PHY driver has gained support for .power_on() and .power_off()
    callbacks. This commit updates the driver to use the API provided
    phy_power_on() and phy_power_off() functions instead of writing into
    PHY registers from this driver.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 5c73572d153b5..b4cb1996a3314 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
during driver removal that could lead to a Use-After-Free?

In mtk_dp_remove(), the driver deletes the debounce_timer but does not disa=
ble
the device-managed hardware IRQ:

drivers/gpu/drm/mediatek/mtk_dp.c:mtk_dp_remove() {
	...
	if (mtk_dp->data->bridge_type !=3D DRM_MODE_CONNECTOR_eDP)
		timer_delete_sync(&mtk_dp->debounce_timer);
}

If an HPD interrupt fires between mtk_dp_remove() returning and the devres
cleanup phase that frees the IRQ, the interrupt handler executes and can
re-arm the timer:

drivers/gpu/drm/mediatek/mtk_dp.c:mtk_dp_hpd_event_thread() {
	...
	if (status & MTK_DP_THREAD_CABLE_STATE_CHG) {
		...
		if (!mtk_dp->train_info.cable_plugged_in) {
			...
			mod_timer(&mtk_dp->debounce_timer,
				  jiffies + msecs_to_jiffies(100) - 1);
		}
	...
}

Shortly after, devres frees the mtk_dp structure. When this re-armed timer
subsequently expires, could it access the freed mtk_dp memory and cause
memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709100617.4258=
3-1-angelogioacchino.delregno@collabora.com?part=3D6
