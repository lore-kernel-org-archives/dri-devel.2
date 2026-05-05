Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE57CD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2A410E0BB;
	Tue,  5 May 2026 18:13:31 +0000 (UTC)
Received: from h6.fbrelay.privateemail.com (h6.fbrelay.privateemail.com
 [162.0.218.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C345310E0BB;
 Tue,  5 May 2026 18:13:29 +0000 (UTC)
Received: from MTA-11-3.privateemail.com (mta-11.privateemail.com
 [198.54.118.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4g96872rLWz2xKZ;
 Tue,  5 May 2026 18:13:27 +0000 (UTC)
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
 by mta-11.privateemail.com (Postfix) with ESMTP id 4g96846HKYz3hhTh;
 Tue,  5 May 2026 14:13:24 -0400 (EDT)
Received: from hal-station.localdomain
 (bras-base-toroon4332w-grc-26-174-91-51-28.dsl.bell.ca [174.91.51.28])
 by mta-11.privateemail.com (Postfix) with ESMTPA;
 Tue,  5 May 2026 14:12:50 -0400 (EDT)
Date: Tue, 5 May 2026 14:12:47 -0400
From: Hamza Mahfooz <someguy@effective-light.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Yussuf Khalil <dev@pp3345.net>, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Colin Ian King <colin.i.king@gmail.com>,
 Charlene Liu <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] drm/atomic: attempt full modeset on page flip
 timeout
Message-ID: <afozH9lcganPCL4g@hal-station.localdomain>
References: <20260501203552.749080-1-someguy@effective-light.com>
 <5dd93e29-a076-491b-9861-e08a0204c77d@amd.com>
 <afnXTwKBfjBYdwgL@hal-station.localdomain>
 <8de14305-b4bd-43eb-9025-f9d210ee125b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de14305-b4bd-43eb-9025-f9d210ee125b@amd.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4g96872rLWz2xKZ
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

On Tue, May 05, 2026 at 10:32:57AM -0500, Mario Limonciello wrote:
> 
> 
> On 5/5/26 06:41, Hamza Mahfooz wrote:
> > On Mon, May 04, 2026 at 04:50:21PM -0500, Mario Limonciello wrote:
> > > Do you actually need to set all 3 of these to true?
> > > 
> > > I would think you only need:
> > > 
> > > crtc_state->mode_changed = true;
> > > 
> > 
> > According to my testing `mode_changed` on it's own is sufficient for
> > amdgpu and the documentation [1] seems to suggest that it should be fine
> > more broadly. Though, it doesn't seem harmful to set all of them just
> > for safe measure.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_crtc.h?h=v7.1-rc2#n118
> 
> My main concern was it's safe right now, but what if future changes to
> atomic control flow mean it executes more code paths than needed; or worse
> unexpected code paths.

Point taken, I'll respin this with them removed.
