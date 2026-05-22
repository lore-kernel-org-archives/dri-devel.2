Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCCECD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 19:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CA310F74A;
	Fri, 22 May 2026 19:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="L3PtDnxi";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709B610F746;
 Fri, 22 May 2026 19:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779478117; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bUnjR9RRephCY7vRAiM3oKixGGbONj2e1+pAaxl+KNNqaHCLOozOo0xeJKuRFHdxqJcILAniOFIf2D8YQPi0bwIQp/PCfUak1AIHqN7hbyqr0sXIFd0jj8XSrAtag6kaQgnutvmdfhPFSZHq2rL6mP1uFCYlj7IW2uBIuuWq+Ow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779478117;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kdK2nHySgc3zBfwVd6vMFTAdGAtMoPuZ+ZgiD7Ye2w8=; 
 b=VfxHbLiENwS2sM7gOsUfVokWMro1IR4KpNrNxWw1o0lFlVmpMTqyD9Kha8jfAHVnuny6nYm1M8OfCTyDESRS6JqJXYU3tmlciMcKIe2a1+LCzRYViv5oYP9rKnnkxIYpBYEuxl5JODB6KeW6xHmV5AWjTD1KBgzXTjeWPYh+SmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779478117; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=kdK2nHySgc3zBfwVd6vMFTAdGAtMoPuZ+ZgiD7Ye2w8=;
 b=L3PtDnxilU7FMNDT5AOnyx50cYmYxaoF7eeUkRRgmevW6sCu4sggf5ImqJBaeWYV
 7mf6OYLt8asXULry9NV07PBEoW0yu2PXXKu3VFz5yyfOnOLO1iLWfYr4jYSbdIqG/fp
 /646HkGbnGAOLcoX10S4GflkUgP5rF4MkZo6m3PA=
Received: by mx.zohomail.com with SMTPS id 1779478115233305.15604822272246;
 Fri, 22 May 2026 12:28:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v9 2/2] drm: Send per-connector hotplug events
Date: Fri, 22 May 2026 21:28:27 +0200
Message-ID: <nHIzMkkRSw6xN8LBsR66Zg@collabora.com>
In-Reply-To: <CAPj87rOiq1i6ZFaeYoeu3jhCRdZPiwdfffHBJ97ihTxmgMJ_VA@mail.gmail.com>
References: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
 <ZSuf-ENwSXWZM2puVBDxGQ@collabora.com>
 <CAPj87rOiq1i6ZFaeYoeu3jhCRdZPiwdfffHBJ97ihTxmgMJ_VA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Friday, 22 May 2026 19:58:26 Central European Summer Time Daniel Stone wrote:
> On Fri, 22 May 2026 at 14:06, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> > On Thursday, 21 May 2026 17:00:17 Central European Summer Time Daniel Stone wrote:
> > > On Wed, 22 Apr 2026 at 19:24, Nicolas Frattaroli
> > > <nicolas.frattaroli@collabora.com> wrote:
> > > > +       /* Pick up any changes detected by the probe functions. */
> > > > +       if (dev->mode_config.delayed_event) {
> > >
> > > Not your doing, as it was just the same before, but doesn't this read
> > > need to be protected by the mode_config mutex?
> >
> > It looks like the fuzzy meaning of the mode_config.mutex came to
> > bite here. It is set to true with the lock held in
> > drm_helper_probe_single_connector_modes(), but set to false in this
> > function without the lock, and always read without the lock
> > (drm_kms_helper_poll_enable(), reschedule_output_poll_work()). Some
> > of these calls happen in paths where it might be inconvenient to take
> > a lock this coarse.
> >
> > Specifically, drm_helper_probe_single_connector_modes() has this
> > comment right before setting delayed_event to true:
> >
> >         /*
> >          * The hotplug event code might call into the fb
> >          * helpers, and so expects that we do not hold any
> >          * locks. Fire up the poll struct instead, it will
> >          * disable itself again.
> >          */
> >
> > So there was a problem with accessing parts under a lock before,
> > so if we're reintroducing the coarse lock wherever the boolean is
> > accessed we might be going backwards here.
> 
> Yeah, that makes sense - those are definitely called from an IRQ
> context so it wouldn't be safe to take the mode_config mutex.
> 
> I wonder if the safest path which guarantees eventual consistency is
> to change the !trylock(mode_config) { goto out } path in
> output_poll_execute() to jump directly to the schedule_delayed_work()?
> That way we could read and modify delayed_event under the mode_config
> mutex; the if (changed) path will not be taken if it wasn't possible
> to take the mode_config mutex.

If the drm_kms_helper_poll module parameter is set to false (i.e. the
non-default setting), with my patch we'd then also need to think about
the behavior if delayed_event == true in that case, since it also goes
to `out` without taking the lock.

I think I need to ponder this particular orb some more. I suspect it'd
be fine to move the delayed_event clearing + sending to before the
mutex unlock, since failing to lock the mutex will just make it repoll
and try again in 0.1 seconds. The event would only be lost if the
another delayed_event arrives before it's processed.

I think Ville's on the money here in that the users of delayed_event
might want to call a drm_client_dev_hotplug that does the work
scheduling instead, but that might be a bigger thing to work towards.

Kind regards,
Nicolas Frattaroli

> 
> Cheers,
> Daniel
> 




