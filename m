Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F977F436BB
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE0D10EA78;
	Fri, 17 Apr 2026 16:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Oh9mCKFJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A3F10E097;
 Fri, 17 Apr 2026 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776443332; x=1807979332;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5nXwJ1p+e+YdXF09wEe4PHC4FbUvtavabcxZ4YAKq2c=;
 b=Oh9mCKFJKZ7XONGRw5+Zx0tVSU8vreV8gN2HMASMC0dFB1syljnGLi8L
 CAQ4i0im8TcBjwu7/rdt6a0LTlfx7ySpa8arXAtKJWLy6nn5ivJPh+GL1
 l9+XbdqLpIqyxoi6ouzIpR3z/klatqsaGUhq5S4YQZ8ceGY5PLoqR6Dp6
 DOJfMKcxW6WENjMU7yW9aKDltyRn92DvfjHlpTh+IGEzIlwANzrr0sfgf
 yubPZ57OG4nBYb+FANIkenTp7i8enOx4VfltHl86FmAHbrAXX2NWpp2vy
 WLqAnJTul/gCv0CWlS49PLHiHCtLB9miO1GID+4tBsqZfKwqHxU9epYZM A==;
X-CSE-ConnectionGUID: cB/M9RMzRO+ILtzoe584sQ==
X-CSE-MsgGUID: q0vk4I5XSw60aa4lqwIvAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="102921428"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="102921428"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 09:28:52 -0700
X-CSE-ConnectionGUID: gLKT2Z88Q3esgqpRIUGBzA==
X-CSE-MsgGUID: CAyb2lqRSrS24TmUoPjLEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="236043344"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.245.176])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 09:28:46 -0700
Date: Fri, 17 Apr 2026 19:28:43 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc: Hamza Mahfooz <someguy@effective-light.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm: introduce KMS recovery mechanism
Message-ID: <aeJfu0CQwMGEsidC@intel.com>
References: <2e359cd9-0192-44d0-886f-7f93a8b0a4fa@amd.com>
 <aY99D-yXVydpMdwy@hal-station>
 <85319290-4027-4eb8-95d1-9009d23f2294@mailbox.org>
 <aZD0W7V_6--2yqNK@hal-station>
 <7f4a86ad-d642-444c-a576-17ff9caaa934@mailbox.org>
 <aZULq2bDnZpdXvIg@hal-station>
 <8588dcbc-621e-43db-9d69-32398f75d9e6@mailbox.org>
 <dab8d21b-1d28-48c6-87bf-f2060e2d2f1e@mailbox.org>
 <d7c7a96e-1686-4878-8b96-92c3427b2f6d@mailbox.org>
 <07072379-32c8-4912-8539-7fa590abf544@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07072379-32c8-4912-8539-7fa590abf544@mailbox.org>
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

On Fri, Apr 17, 2026 at 06:08:05PM +0200, Michel Dänzer wrote:
> On 2/20/26 10:09, Michel Dänzer wrote:
> > On 2/20/26 09:42, Michel Dänzer wrote:
> >> On 2/18/26 10:22, Michel Dänzer wrote:
> >>> On 2/18/26 01:45, Hamza Mahfooz wrote:
> >>>> On Mon, Feb 16, 2026 at 10:28:13AM +0100, Michel Dänzer wrote:
> >>>>> On 2/14/26 23:16, Hamza Mahfooz wrote:
> >>>>>> On Sat, Feb 14, 2026 at 03:02:49PM +0100, Michel Dänzer wrote:
> >>>>>>
> >>>>>>> In principle it's possible to do (the equivalent of) a modeset with the current state for all CRTCs, no need to do it separately per CRTC.
> >>>>>>
> >>>>>> AFAIK that is what the uevent is already doing (unless I'm mistaken).
> >>>>>
> >>>>> This is about just doing a full modeset, which isn't something user space can do in response to a wedged event.
> >>>>
> >>>> I was referring to what compositors are doing in response to
> >>>> `drm_kms_helper_hotplug_event()`. Perhaps, the enum constants should be
> >>>> renamed, since the forced modeset is actually sent when the current
> >>>> reset phase is DRM_KMS_RESET_NONE (the phase is updated before sending
> >>>> out the event though).
> >>>
> >>> Ah, you're talking about the drm_kms_helper_hotplug_event call in drm_atomic_helper_wait_for_flip_done (I thought "uevent" referred to drm_dev_wedged_event in patch 2).
> >>>
> >>> I don't know about other compositors, but I don't think mutter will do a modeset in response to a hotplug event if no KMS state changed (because some monitors can generate spurious hotplug events).
> >>
> >> [...]
> > 
> > [...], a reason why the kernel can't just do a modeset itself occurred to me: A modeset might affect other CRTCs than the ones affected by the timed-out commit, which could interact badly with other pending commits affecting those other CRTCs.
> 
> In a different thread, Ville (added to Cc) said this shouldn't be an issue.
> 
> In which case this would seem like the simplest solution.

Yeah, so extra blocking commits will just make everything (including
subsequent non-blocking commits) block on the modeset mutexes before
the -EBUSY check even happens.

On a somewhat relatd note, some time ago I proposed making blocking
commits also do the commit_tail part locklessly. But realizing that
something might depend on the current not-actually-nonblocking commit
semantics I was careful to preserve that even while dropping the locks:
https://lore.kernel.org/dri-devel/20220916163331.6849-1-ville.syrjala@linux.intel.com/

-- 
Ville Syrjälä
Intel
