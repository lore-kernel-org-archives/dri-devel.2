Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2061C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87EF10F2E8;
	Thu, 13 Aug 2026 12:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CEqF0uAa";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE9C10F2E8
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786624124; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ff6sPKQIoLkd+tsGdm1JRXW+bwHeSSQhcuN34ik08TpRd4wZ106gOfyg1LOFPmZXaNHdbFMStxwmOTEXeVruN44ljjrsJPSAtIDBIt7t90XrZpidkrg0PnlhCaP+Srh/0zuUM48gFNsyJL4yHM288kXqZM1eZ1YvfUG6szkTjwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786624124;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OWGT81i7N7p+eeA3tXH8Ka3sqdztrrreSe8Soc6hWoY=; 
 b=kWswI0w0ISt9q+yASiSG6OcpMxwZ7IyzX6VouZPyZXp6QlEagYq2k9CKqVkD31wFIP81JsWPTRPUy/w0YfEfxYr7+y2ULYqOQEK6oVAaH6P+XC2KitbtJSKfFm5SuUbnvZUfBMuT55uhz8h22UBLtiZI2PahRYMSmhTtjxPgLmA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786624124; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=OWGT81i7N7p+eeA3tXH8Ka3sqdztrrreSe8Soc6hWoY=;
 b=CEqF0uAayhVFWx48Ta7utvml7ZvyovqFDB9p30N0/Q+MnA3zFnBTE3keTyAxke+H
 DOZHGJ7embQOPkQq49IA9AbSyRz5fpO6uHws2ZLxFso9FcPQ/G13GEBkUcW0M4JF7JW
 b+BA3zuiUI6OyItSY/iA8k75yyDaPYx8cCDzWuEI=
Received: by mx.zohomail.com with SMTPS id 1786624121666297.6110204761309;
 Thu, 13 Aug 2026 05:28:41 -0700 (PDT)
Date: Thu, 13 Aug 2026 13:28:35 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 08/11] drm/panfrost: Move perfcnt GPU disable sequence
 into a helper
Message-ID: <an24SCQL-OGjFwRE@sobremesa>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-8-3d692c9e98c2@collabora.com>
 <20260812114816.4d87360c@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812114816.4d87360c@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.586.17
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 12.08.2026 11:48, Boris Brezillon wrote:
> On Tue, 11 Aug 2026 22:42:17 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Just for the sake of avoiding repetition.
> > 
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 31 ++++++++++++-----------------
> >  1 file changed, 13 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index 7020c0192e18..ad1156678e91 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > @@ -35,6 +35,16 @@ struct panfrost_perfcnt {
> >  	struct completion dump_comp;
> >  };
> >  
> > +static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
> 
> I see you introduce panfrost_perfcnt_hw_enable() in patch 10, so maybe
> s/panfrost_perfcnt_gpu_disable/panfrost_perfcnt_hw_disable/ to be
> consistent.

Acked.

> > +{
> > +	gpu_write(pfdev, GPU_PERFCNT_CFG,
> > +		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> > +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> > +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> > +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> > +	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > +}
> > +
> >  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
> >  {
> >  	complete(&pfdev->perfcnt->dump_comp);
> > @@ -193,12 +203,7 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> >  	if (user != perfcnt->user)
> >  		return -EINVAL;
> >  
> > -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> > -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> > -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> > -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> > -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> > +	panfrost_perfcnt_gpu_disable(pfdev);
> >  
> >  	perfcnt->user = NULL;
> >  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> > @@ -327,12 +332,7 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
> >  	perfcnt->bosize = size;
> >  
> >  	/* Start with everything disabled. */
> > -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> > -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> > -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
> > -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
> > -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
> > -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > +	panfrost_perfcnt_gpu_disable(pfdev);
> >  
> >  	init_completion(&perfcnt->dump_comp);
> >  	mutex_init(&perfcnt->lock);
> > @@ -344,10 +344,5 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
> >  void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
> >  {
> >  	/* Disable everything before leaving. */
> > -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> > -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> > -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
> > -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
> > -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
> > -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > +	panfrost_perfcnt_gpu_disable(pfdev);
> >  }
> > 


Adrian Larumbe
