Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145B6CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 15:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA2E10E295;
	Tue,  6 Oct 2026 15:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AUq3R75T";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C5810E295
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 15:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791299387; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hfl6Pb9TWg96s3MNFkW7Oln/piZmXE6HLkwTFINszKTxjtyj2HSO+Sayn4yOh61urndhE07WjRuHy+1x9ZVz7VOgZzR4vO6AVAKYQ9Be38WvAi5tHi6Z1ZV/4K1/gDvqQT/2uTbld70kaQ/1oIeBIpETP0z2fQ4IiMuAUIQaHW4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791299387;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vchKlw0oPu4/T9op3iicQOsXwyXtZm1YnhCzMrpelZ8=; 
 b=hHhjbZKq3Kgd4G3dWMDaWD/3LRTc+YX3GCqYtq9KZecTn58JgFqbkt1o2SZb14r4MWx6j5zrO8OlX7L2VeLkMmbibqKEfnc3XnREQCFbyaC/UJ9CFnQXMUH9UMsOzmIPWC5b6wiHbaKK0BMcPGaY883g1KC4pjOZcosdl26uxsw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791299387; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=vchKlw0oPu4/T9op3iicQOsXwyXtZm1YnhCzMrpelZ8=;
 b=AUq3R75TpcJXek13rBy6pg7JQmbMn1X7+Juae6ZdxUXMCjfmLC0BpW8c6s5M3Oq/
 LEZL68TC2zBicALp6CzSHz2AcG2tahNSGd3YUCwC+UF7HEXAe+B48eK/Y/o+rq7SRlx
 zatgsZ73vm0agFg3m4hvhD7/c+vLmOcfcffHFfxE=
Received: by smtp.zohomail.com with SMTPS id 1791299386430341.413130039174;
 Tue, 6 Oct 2026 08:09:46 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 09/15] drm/panfrost: Add warning messages to fatal
 error conditions
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <2ea16821-fcd8-4f35-b371-7c7e57f76e7c@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-9-62beb08de207@collabora.com>
 <2ea16821-fcd8-4f35-b371-7c7e57f76e7c@arm.com>
Date: Tue, 06 Oct 2026 16:09:40 +0100
Message-Id: <179129938072.1018806.14660127756555690690.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4034;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=/359jzaga1q2flPdc665gmmTDhhWSRi9NJm4hn7GQNw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxQ80W+6riWXlL7Lnulw1qR5GZHk/R7c0H2cXo
 siCVo85wi+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasUPNAAKCRAOJn5M7lND
 PaiWDACV+IKNA/V2NgbdzN1Dj41QFt7Dt9Gq5KjmnFRbTcHti2H664QF7XtZPiRq7vNWtUuycWL
 wlgklToVdjW5wmK68j/dEcrf2UK146Mo+xhRtJa4ezJRTMz7uRtAC0ZLrIDPV1q2yuZQdn+Qd3p
 hLyaRUAqpdJ1e5lOcYDzOGB+1C8jbA4L491qiauxQCrhlPZ32zLB+PkFgqXNfsdW22Gan+v26zT
 EigAmdfwfLPboDxCNjspLo5orU1WJEG2tso4sK3PXLO/7iCXGa6qop5Zpp+kRgi4Se4/o0enxUa
 eCz+/V9UaTfMH5qIeImO7AcyvCkYyUBjH2HNMSEgMZTCJxXtpZXtpBBqsErvHw/enQdBCxMyEXj
 ZEFeY/yKJVN8Num529CNzXSrz1R69oJDc+dojJ0wqzbE+LO7rTr2uDn+oIkRUsnMgWItoOFD9SA
 7Ued9iw/MKLPNuPTj5woQ4WWNWS7bWbty3d55jWn030gmQSuSCOnJYJeM8WM7s4Lo/hb8=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-10-02 15:59:20+01:00, Steven Price wrote:
> On 29/09/2026 04:44, Adrián Larumbe wrote:
> 
> > Rather than just failing silently, let's warn the user of device remove not
> > being able to take an PM reference or the PM suspend path still reporting
> > inflight jobs. Neither situation should ever happen.
> > 
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index c6bf3d0663df..09a5752a3f40 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <drm/drm_drv.h>
> > +#include <drm/drm_print.h>
> >  
> >  #include "panfrost_device.h"
> >  #include "panfrost_devfreq.h"
> > @@ -357,7 +358,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  
> >  void panfrost_device_fini(struct panfrost_device *pfdev)
> >  {
> > -	pm_runtime_get_sync(pfdev->base.dev);
> > +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
> 
> This seems fine.
> 
> >  	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> >  	pm_runtime_disable(pfdev->base.dev);
> > @@ -516,7 +517,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
> >  {
> >  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> >  
> > -	if (!panfrost_jm_is_idle(pfdev))
> > +	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
> 
> I'm a bit wary that this might be something that user space can trigger.
> My AI says:
> 
> The runtime-suspend WARN can be reached by ordinary userspace job
> submissions. The DRM scheduler increments credit_count before calling
> Panfrost’s job runner (drivers/gpu/drm/scheduler/sched_main.c:1044).
> Panfrost takes the job’s PM reference later in hardware submission
> (drivers/gpu/drm/panfrost/panfrost_job.c:213). If autosuspend runs in
> that interval, the new WARN
> (drivers/gpu/drm/panfrost/panfrost_device.c:525) sees the credit and
> fires, even though this is a timing race rather than a broken job.
> Repeated submissions near the autosuspend boundary could therefore
> produce repeated stack traces. The PM core treats the resulting -EBUSY
> as a transient failure.
> 
> Now I have to admit I don't trust it that much - but I'd want a
> convincing argument on why panfrost_jm_is_idle() will never be false here.

You're right. I was in the belief that autosuspend kicking in was proof of no
inflight or pending jobs present in the scheduler queues, so I came to treat
this check as things having gone awry.

I guess its value lies in the ability of the PM runtime suspend handler
to cancel itself at an autosuspend event, like you said.

However, it just made me wonder: what would happen in the event that autosuspend
kicks in and runs panfrost_device_runtime_suspend() right at the same time that
a scheduler job is picked up by drm_sched_run_job_work(), but hasn't yet reached
the statement where it does an atomic increment on the credit_count? I guess
nothing, because panfrost_job_hw_submit() is getting a PM reference before
accessing any HW registers, and that should take care of dealing with any
ongoing autosuspend events.

In that case I'll just delete that warning. However, I'd say it's bad practice
to have DRM drivers access the internal state of the DRM scheduler. At present,
only Panfrost and Etnaviv poke it in their RPM suspend handlers, and I've been
wondering whether we should get rid of this check altogether, or else maybe ask
the scheduler maintainers whether it makes sense to have a non-racy way to
query the presence of pending jobs in their queues?

> Thanks,
> Steve


