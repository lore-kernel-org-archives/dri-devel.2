Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C3CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AC210ECF8;
	Tue, 16 Jun 2026 18:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VIhvJuVh";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9F510ECF8
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781635412; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LK9kAPc9V/Ik42xg5GoqCjA9FPwfl8lTdxf6tC95Gwanuj+Pu2Rl74uLWecwnCtCs8rch83lgyCFkfFX6cWAp9o3gmTuqMbd4oRNj4b21dDv23rAjlQhETAJDXeUoYnC1T9+ZstgjK9Goq3AWrmPpLFMBr+wIPFKDhDGcm/F+MM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781635412;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DBkVn3DRoWzdS/oCYqIjq3uAT46L2V1UumcBo4zI86A=; 
 b=L4wwKQrapOWWxc6TYKb85U111YIa05cVUmyci4Ez1d9j9fdiNuZsnoMYeJ+bYIfYbM9PMKLK9nRe9iu7tCR5CvP/H2AjPr00lloXx6d8x+f6NVjOE2f1dJFeCDwj2eQj+ujONtuDtgqZMczr7kafxp6+tD1wE5/visgRcXBdl4A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781635412; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=DBkVn3DRoWzdS/oCYqIjq3uAT46L2V1UumcBo4zI86A=;
 b=VIhvJuVhvJHDIRPXzoBvH/q4UDoMkfl0eQssmKxpZRcQ9jdqlfnlvIG1r0zNs+fD
 L8HF6v6vflsGxJpC12u7WQm0j8eS83Bgj5GMWtRXnMntENvR3pJCogndU0K5RTHNxiZ
 ajXA1JJiw4+q22TDrNbUD856C68E8XjGkkCyLwl4=
Received: by mx.zohomail.com with SMTPS id 1781635410709388.82643536126614;
 Tue, 16 Jun 2026 11:43:30 -0700 (PDT)
Date: Tue, 16 Jun 2026 19:43:24 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
Subject: Re: [PATCH v2 2/7] drm/panfrost: Prevent division by 0
Message-ID: <ajGZN-2TTn7YICsn@sobremesa>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-2-57c6bd4c1655@collabora.com>
 <20260604200215.303dbc43@fedora-2.home>
 <19d76abb-baff-4249-9f17-d0460b418d56@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19d76abb-baff-4249-9f17-d0460b418d56@arm.com>
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

On 05.06.2026 11:29, Steven Price wrote:
> On 04/06/2026 19:02, Boris Brezillon wrote:
> > On Thu, 04 Jun 2026 18:35:21 +0100
> > Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> > 
> >> When updating and debug-printing devfreq stats, in the very unlikely
> >> offchance that total device time is less than 100 ns, clamp it to 0 to
> >> avoid division by 0.
> >>
> >> Reported-by: Claude <noreply@anthropic.com>
> >> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> >> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> >> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> >> ---
> >>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> >> index b51c30778811..e34de47bf43b 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> >> @@ -78,7 +78,8 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
> >>  
> >>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
> >>  		status->busy_time, status->total_time,
> >> -		status->busy_time / (status->total_time / 100),
> >> +		status->total_time >= 100 ?
> >> +			status->busy_time / (status->total_time / 100) : 0,
> > 
> > or:
> > 
> > 		status->busy_time * 100 / MAX(status->total_time, 1),
> > 
> 
> I have to admit I prefer Boris' version ;)
> 
> But either way:

Me too, I'm picking it for the next revision.

> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> >>  		status->current_frequency / 1000 / 1000);
> >>  
> >>  	return 0;
> >>
> > 

Adrian Larumbe
