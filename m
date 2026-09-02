Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A245AC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE42C10F29B;
	Wed,  2 Sep 2026 15:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Wh/yA8SF";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5E010F29B
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363870; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OWT1YYZABAerOTh+jzu0k8iaN9v8Og8FncEjuqttEXC/UEuFJj5kx94D2fLxESjWPSFjyGbzL4qzErIDIxIdAC6UL9lToIvShqI52MAWo/IY+Dh7ogzCuH1Ie+6Yexbx09vZyBzamOqgw7kdAKS1fAOhnl0NQhCEA7vC6UqAQ9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363870;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eXZEOAAIetS6kmWERLBgnbpo/ZWjgV0pKHwgudsmi04=; 
 b=MGO/kcUZ2J1J9vOt10X+R798scJsjgWukPddTUtDe0xxb6+L+ma8fVRkzuGDsrS5fvq8GYyM3yGkil91vUVWQSWOR7ZqH5V6glcFOUZMcBXyWyq5ZJ/CAVxy6z/B0fRIwe7z7F3kcmIDbdVUTfRQohfSE1dXxTOHNxeotjlxzfA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363870; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=eXZEOAAIetS6kmWERLBgnbpo/ZWjgV0pKHwgudsmi04=;
 b=Wh/yA8SFD3XrBhWONSdIU1nn5X/fzwdQPKnQ5aSn2BAK6vc0ifDZcpLdEaaGdIm6
 k/Gu45D3rXkEoFmbjc+5RRp16uakpgWu1SrO4avOVpm/WjiVGiKec19NW1urEAHP7bP
 O2hYMmggSJl2KEKRCgMha80fERO6Ow+EJVUM5sX8=
Received: by mx.zohomail.com with SMTPS id 1788363869728911.8953475750875;
 Wed, 2 Sep 2026 08:44:29 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:44:24 +0100
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
Subject: Re: [PATCH v7 14/17] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
Message-ID: <aphEMSV5NGlldxBQ@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-14-72a13b2c125d@collabora.com>
 <20260901153732.7c4def61@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901153732.7c4def61@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.352.18
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

On 01.09.2026 15:37, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:54 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > If the GPU and CPU are fully coherent, then there's no need to flush the
> > GPU caches after a perfcnt sample is made available.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index ffc77121070e..b3f71d7fd82a 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > @@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
> >  
> >  void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
> >  {
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> > +	if (pfdev->features.selected_coherency != COHERENCY_ACE)
> 
> I think ACE_LITE would allow us to skip the flush to, so

I thought ACE_LITE means the GPU can snoop CPU caches but not the other way round, so at the end of a
sample, we still have to flush GPU caches for the CPU to see counter data.

> 	if (pfdev->features.selected_coherency == COHERENCY_NONE)
> 
> > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> > +	else
> > +		complete(&pfdev->perfcnt->dump_comp);
> >  }
> >  
> >  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> > 

Adrian Larumbe
