Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C6606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ajte+QQg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E885F10FD49;
	Wed, 25 Nov 2026 15:53:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5EB10FD4C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:53:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA466462FE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A6A1F000CA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795622032;
 bh=/QyiPsXELdVcU8h8SMClaBGSEvaC+/rJrAPi6gmrO6o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Ajte+QQgdCvyL5yKctsd8Z7EZxDbaxER6jE5Vt9tSb6N3b0CuQEt0CNTjW0eR/avj
 Du27j6wgkzhwuLh8wHXreOV+jtHAMt66zyL9WY1VXZ81OVroo+AyfPIqTnG+NjbOsh
 UGsw87nP7s3YrHAgJBQG0et8fUHWVGb9cwQLk96evoW+/rFroI8OfsL4WEf2bP1QFs
 pOfBr8ZOx1olk0rcXwcmIdty5Djn8Unj9t8/VltsfQ0Zr0OJCe3ZOhU4zH7NJ3Rh5V
 V0NwbYkeRUSZ1mmVhKUa5Yxk2yQM7AvywafkSQGj5VwzcKOVh/JiVZXjZFpJ9FUc4B
 glVZcJaxFhwYA==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5c10dc41270so6343404e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:53:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEU+kecbkUOH+lO8qgbQVl8wx+LSU2GdyJnbSvoe3wJcq7ScGI4aQD0M5a09PG+ByMTOP/kg54FIg0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9g/RysDM3Mcz+hTDcps9IVvOcrWZuUreNgv8ceeeYjLsk0Aqsv
 J60MoqkQD65Ntv4/YQddjJ9Nzarz2x/1a1aoNGh0C/213pgMjXn5K8HAJtNoLVts28LbihcEhSs
 qWx8ZaO4NuaBBhhUjPVXE/jlR1n1KJVg=
X-Received: by 2002:ac2:4e07:0:b0:5c1:4f54:a6c6 with SMTP id
 2adb3069b0e04-5c1bc7cb0f6mr5811261e87.30.1795622030011; Wed, 25 Nov 2026
 07:53:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
 <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
 <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
In-Reply-To: <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 25 Nov 2026 16:53:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
X-Gm-Features: Aa3M54pn_ud7xKJ4Sp9_9mJsafRFGsiuNY-zMFg468C0_97OrWEf728wG9SLJbM
Message-ID: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Frank.Li@oss.nxp.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Ulf Hansson <ulfh@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, Hans de Goede <hansg@kernel.org>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Wu <yong.wu@mediatek.com>, 
 Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
 Marek Vasut <marex@denx.de>, Michael Tretter <m.tretter@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-arm-kernel@lists.infradead.org>, 
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-mediatek@lists.infradead.org>, 
 "open list:ARM/Rockchip SoC support:Keyword:b[Rr]ock[Cc]hipb"
 <linux-rockchip@lists.infradead.org>, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, dri-devel@lists.freedesktop.org, 
 imagination@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev, 
 linux-media@vger.kernel.org, linux-sound@vger.kernel.org, 
 sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 4:07=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Tue, Nov 17, 2026 at 6:38=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
> >
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > returns -EINVAL.  The real implementation returns:
> >   1  - device is active and its usage counter is non-zero (bumped)
> >   0  - device is not in use or not active (counter not bumped)
> >  -EINVAL - runtime PM disabled for this device
> >
> > When CONFIG_PM is not set every device is permanently "active" and
> > always considered "in use", so the stub must return 1, mirroring
> > __pm_runtime_resume() which already returns 1 in the same build.
> >
> > Returning -EINVAL breaks callers that test the return value with
> > comparisons other than "!=3D 0 / =3D=3D 0":
> >
> > drivers/gpu/drm/i915/intel_runtime_pm.c:
> >   if (intel_runtime_pm_get_if_in_use(rpm))
> >   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
> >   With -EINVAL the wrapper returns false, causing an incorrect error
> >   path in the GT fence revocation code.
> >
> > drivers/gpu/drm/xe/xe_pm.c:
> >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> >   returns false, so callers believe the device is not usable.
> >
> > drivers/gpu/drm/gma500/power.c:
> >   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
> >   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
> >
> > drivers/gpu/drm/imagination/pvr_power.c:
> >   if (pm_runtime_get_if_in_use(...) <=3D 0)
> >   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" erro=
r
> >   path instead of proceeding with the active device.
> >
> > sound/soc/sof/debug.c:
> >   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
> >   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
> >   debug accounting.
> >
> > drivers/iommu/mtk_iommu.c:
> >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
> >   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
> >
> > drivers/iommu/rockchip-iommu.c:
> >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> >   -EINVAL < 0 triggers a spurious WARNING on every call.
> >
> > drivers/media/i2c/isl7998x.c:
> >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> >   -EINVAL <=3D 0 causes the driver to always skip register programming
> >   when !CONFIG_PM.
> >
> > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> >   -EINVAL <=3D 0 prevents any debug statistics from being collected.
> >
> > Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional usag=
e count incrementation")
> > Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance a=
fter fw exception")
> > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL=
7998x")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change in v3
> > - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status b=
y sampling ISP_FLAGS_SHD")
> > selected PM at arch config
> > - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > selected PM at arch config
> > - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtim=
e PM logic")
> > guard by CONFIG_PM
> > - drop tag 727538a4bbff ("drm/imagination: Implement power management")
> > depend on PM
> > `
> > Change in v2
> > - new patches.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com=
>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: imagination@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: intel-xe@lists.freedesktop.org
> > Cc: iommu@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-rockchip@lists.infradead.org
> > Cc: linux-sound@vger.kernel.org
> > Cc: sound-open-firmware@alsa-project.org
> > Cc: imx@lists.linux.dev
> > ---
> >  include/linux/pm_runtime.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index de9e7518ecef2..1d983fe55a16a 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device=
 *dev, unsigned int delay)
> >  }
> >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> >  {
> > -       return -EINVAL;
> > +       return 1;
>
> This should be return 0, as we did not bump the usage count.

This is kind of moot because there is no usage counter.

However, the caller may always take the opportunistic "in use" path
because there are no potential costs related to it.
