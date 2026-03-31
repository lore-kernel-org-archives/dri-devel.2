Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F70DFF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C028F10E9AA;
	Tue, 31 Mar 2026 11:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KigaQzFR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E5310E93A;
 Tue, 31 Mar 2026 11:03:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D5AB437C3;
 Tue, 31 Mar 2026 11:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7123FC19423;
 Tue, 31 Mar 2026 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774955017;
 bh=ki8n3fWjJ0uDLFj/cJjwAfUHSi8/QbPmwfna1VWmJpM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KigaQzFRq2BwuyGeaF4v7+e+qDvQNCTfHCJOLYHznpfQXn8fDrFu+rMX4zjSX6ur8
 INwAPokWjXvuUaS44mCmKq6efIjjqm2ZMjC63Le1YoKE0ZUQZcp9Zea/DyeL+MB29y
 Nwn9PxeHLMdIOKO5YCCJLY1E0G0YiD/epwQ3mTLw=
Date: Tue, 31 Mar 2026 13:03:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 stable@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Bin Lan <bin.lan.cn@windriver.com>,
 He Zhe <zhe.he@windriver.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Roman Li <Roman.Li@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
Message-ID: <2026033157-trifocals-swerve-d18f@gregkh>
References: <20260326234716.16723-1-rosenp@gmail.com>
 <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
 <7351746.9J7NaK4W3v@timur-hyperion>
 <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
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

On Mon, Mar 30, 2026 at 02:38:35PM -0700, Rosen Penev wrote:
> On Mon, Mar 30, 2026 at 7:21 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
> >
> > On Monday, March 30, 2026 3:55:55 PM Central European Summer Time Christian
> > König wrote:
> > > On 3/30/26 15:16, Timur Kristóf wrote:
> > > > On Friday, March 27, 2026 12:47:10 AM Central European Summer Time Rosen
> > > > Penev>
> > > > wrote:
> > > >> From: Timur Kristóf <timur.kristof@gmail.com>
> > > >>
> > > >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> > > >>
> > > >> It already didn't work on DCE 8,
> > > >> so there is no reason to assume it would on DCE 6.
> > > >>
> > > >> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> > > >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> > > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > >
> > > > This patch is incorrect and should not be backported.
> > > >
> > > > (Note that the error is already fixed upstream. For stable kernels IMO
> > > > it's
> > > > best to drop this one.)
> > >
> > > Is there some alternative which needs to be backported or should the old
> > > kernel just work out of the box because we never enabled some feature
> > > there?
> > >
> > > Apart from that the patch set looks good to me.
> > >
> >
> > This patch had a typo and does the opposite of what it should, ie. it disables
> > eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older.
> >
> > The upstream fix is here:
> > https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
> > which disables eDP fastboot on DCE10 and older.
> Not sure what the process is here. I make sure everything can be git
> cherry-pick ed. In that case, both should be present.

I agree, I don't understand the problem here.  Just take the commits
that are upstream including "fixes for the fixes".

Timur, what specifically do you want to see happen here?

thanks,

greg k-h
