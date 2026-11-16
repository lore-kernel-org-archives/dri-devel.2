Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D80606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=u5NEm9uP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBC210F23C;
	Mon, 16 Nov 2026 15:31:48 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FE310F26C;
 Mon, 16 Nov 2026 15:31:42 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id CBD0B4BB;
 Mon, 16 Nov 2026 16:29:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794842954;
 bh=mEdGgykLNB2Omw7cxl+sjvA+5dUdNlstZtzg025H4SM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u5NEm9uPXYzEZpITU3vAG6PWDU+yJ/ZUR9lwtykQcZvUmia4ANO5bLGKFNdRerkqp
 wRbNWdsoUXMzU2lYUA4UIaS+ONcqlmgU/Cjc1gQn6ZqOuR9AdSHt0aepGReo/J6+3L
 Ol/mw3pEjmM1ctFcVrGxmj1JeKN+Kd2CdQXuP+hw=
Date: Mon, 16 Nov 2026 17:31:39 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Will Deacon <will@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 sound-open-firmware@alsa-project.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
Message-ID: <20261116153139.GB1763944@killaraus.ideasonboard.com>
References: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
 <20261116152513.2676573-2-Frank.Li@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116152513.2676573-2-Frank.Li@oss.nxp.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frank,

On Mon, Nov 16, 2026 at 10:25:11AM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> returns -EINVAL.  The real implementation returns:
>   1  - device is active and its usage counter is non-zero (bumped)
>   0  - device is not in use or not active (counter not bumped)
>  -EINVAL - runtime PM disabled for this device
> 
> When CONFIG_PM is not set every device is permanently "active" and
> always considered "in use", so the stub must return 1, mirroring
> __pm_runtime_resume() which already returns 1 in the same build.
> 
> Returning -EINVAL breaks callers that test the return value with
> comparisons other than "!= 0 / == 0":
> 
> drivers/gpu/drm/i915/intel_runtime_pm.c:
>   if (intel_runtime_pm_get_if_in_use(rpm))
>   which wraps to: ret = pm_runtime_get_if_in_use(); return ret > 0;
>   With -EINVAL the wrapper returns false, causing an incorrect error
>   path in the GT fence revocation code.
> 
> drivers/gpu/drm/xe/xe_pm.c:
>   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
>   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
>   returns false, so callers believe the device is not usable.
> 
> drivers/gpu/drm/gma500/power.c:
>   return pm_runtime_get_if_in_use(dev) == 1;
>   -EINVAL != 1, so the helper always returns false when !CONFIG_PM.
> 
> drivers/gpu/drm/imagination/pvr_power.c:
>   if (pm_runtime_get_if_in_use(...) <= 0)
>   -EINVAL <= 0 is true, so the driver always takes the "requeue" error
>   path instead of proceeding with the active device.
> 
> sound/soc/sof/debug.c:
>   if (pm_runtime_get_if_in_use(sdev->dev) == 1)
>   -EINVAL != 1, so d3_prevented is never set, corrupting exception
>   debug accounting.
> 
> drivers/iommu/mtk_iommu.c:
>   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <= 0)
>   -EINVAL <= 0 skips the TLB flush, leaving stale IOMMU mappings.
> 
> drivers/iommu/rockchip-iommu.c:
>   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
>   -EINVAL < 0 triggers a spurious WARNING on every call.
> 
> drivers/media/i2c/isl7998x.c:
>   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
>   -EINVAL <= 0 causes the driver to always skip register programming
>   when !CONFIG_PM.
> 
> drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
>   if (pm_runtime_get_if_in_use(dev) <= 0)  (two call sites)
>   -EINVAL <= 0 prevents any debug statistics from being collected.
> 
> Fixes: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime PM logic")
> Fixes: cbb6a7413b17 ("drm/xe: Introduce xe_pm_runtime_get_noresume for inner callers")
> Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> Fixes: 727538a4bbff ("drm/imagination: Implement power management")
> Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance after fw exception")
> Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> Fixes: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL7998x")
> Fixes: cbb819c363c5 ("media: rkisp1: debug: Collect input status by sampling ISP_FLAGS_SHD")

I don't think this one is right. The rkisp1 driver only runs on ARCH_MXC
and ARCH_ROCKCHIP, which select CONFIG_PM. The same may be true for some
of the other fixes tags.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v2
> - new patches.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Alessio Belle <alessio.belle@imgtec.com>
> Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Dafna Hirschfeld <dafna@fastmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Michael Tretter <m.tretter@pengutronix.de>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imagination@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-sound@vger.kernel.org
> Cc: sound-open-firmware@alsa-project.org
> Cc: imx@lists.linux.dev
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index de9e7518ecef2..1d983fe55a16a 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device *dev, unsigned int delay)
>  }
>  static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
> -	return -EINVAL;
> +	return 1;
>  }
>  static inline int pm_runtime_get_if_active(struct device *dev)
>  {

-- 
Regards,

Laurent Pinchart
