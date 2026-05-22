Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041FCCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 18:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1F510E26D;
	Fri, 22 May 2026 18:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VUkyWFKR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95A110E0BD;
 Fri, 22 May 2026 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779473464; x=1811009464;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jrUMl5Pj6W1zeeKqO5bZT+4B5c7mV/TBAJjBOPt581E=;
 b=VUkyWFKRfLYgxfdQDv7vcHXzaFEX5AjTJZbqXDXcCpiMjt7MKJiRQYh9
 3B3fmcCu6ES9ffwT98/1+bTa3gLTk/pB1hmxkuAnNffiEuMpWmT+9KOr9
 g6M7101u6YhQtexgAzpGq2D0zV8WIPaQ+BYLFp1I8dCdrsoVP3EqZtovd
 xWjBqm9+NJ3r1edINKCwmIA9ctcPQ5/LlZqOweJkkJ8dhnRXxBNwbg8AN
 ddkVUZ7bbD4mX2lQRy3DyCOBA0jfieK4U/FHnqcpQPdra9jJ66FBbrZiI
 6974RsdL2iSKH3bY+QKTy6aQk27O4VBS9SvTJ4ddUkB3144hDADMqN0ur A==;
X-CSE-ConnectionGUID: EhBZVOTASdCKJkupqfAIGw==
X-CSE-MsgGUID: 7+2IaW7vSziAl2ID5wrQaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80440575"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80440575"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 11:11:04 -0700
X-CSE-ConnectionGUID: huksGKwGQyWmHQy4pAxRFA==
X-CSE-MsgGUID: 5g2D4wElRq2SNhxXUH4rTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="271325699"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
 by orviesa002-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 11:10:59 -0700
Date: Fri, 22 May 2026 21:10:55 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
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
Message-ID: <ahCcL-QmxwSvMcUl@intel.com>
References: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
 <20260422-hot-plug-passup-v9-2-aef804255986@collabora.com>
 <CAPj87rNHsa2TKMcSMHeq3M7ZfyZp0P_i3FtjxQp8Qk53UwXGLQ@mail.gmail.com>
 <ZSuf-ENwSXWZM2puVBDxGQ@collabora.com>
 <CAPj87rOiq1i6ZFaeYoeu3jhCRdZPiwdfffHBJ97ihTxmgMJ_VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj87rOiq1i6ZFaeYoeu3jhCRdZPiwdfffHBJ97ihTxmgMJ_VA@mail.gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Fri, May 22, 2026 at 06:58:26PM +0100, Daniel Stone wrote:
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

I've been cursing at this delayed_event hack a couple of times.
Seems to me that the correct solution would be to make
drm_client_dev_hotplug() schedule its own work and do the actual
work there instead of this direct call we have right now.

-- 
Ville Syrjälä
Intel
