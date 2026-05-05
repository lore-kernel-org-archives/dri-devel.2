Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F68FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE28210E0F8;
	Tue,  5 May 2026 09:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="KRRQ3dlW";
	dkim-atps=neutral
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [91.218.175.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61C310E0F8
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:34:43 +0000 (UTC)
Date: Tue, 5 May 2026 11:34:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777973681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CESp6uetEB7khEa9r53J2U2W+2MpllmP1Ap/FFA1vfs=;
 b=KRRQ3dlWz78ws2rS5TZAMUbrlgY9EF+6HoTPcSO54Vmtw0edRpBn+BZIUR4CiEkUvz/TaU
 Z2WBOQtcs9xhEvsQrp9OltCN10CSR148F1dMwivvAjeyHe/ZYKL/wWINr6ojccNRI2Lwsp
 RYbwLicxL1uTYheor8rGgnBSWWodjqs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Eric Anholt <eric@anholt.net>, stable@vger.kernel.org,
 Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
Message-ID: <afm5rE1i3D-Uk3S7@linux.dev>
References: <20260502121251.39206-3-thorsten.blum@linux.dev>
 <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
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

Hi Dave,

On Tue, May 05, 2026 at 09:54:53AM +0100, Dave Stevenson wrote:
> Hi Thorsten
> 
> On Sat, 2 May 2026 at 13:13, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,
> 
> Mainline doesn't use overlays, so this description isn't valid.
> 
> Which generation of Pi are you using? Whilst they all share the vc4
> driver, the functionality associated differs. If you're disabling HDMI
> (and HDMI audio), which display outputs are you using?

It's a Pi 500 currently running headless, which is why I turned audio
and HDMI off. I ended up using:

  dtparam=audio=off
  #dtoverlay=vc4-kms-v3d
  hdmi=off

This prevents the vc4 and snd modules from loading and works for me.

> > unloading the vc4 module calls vc4_hvs_unbind() with
> > dev_get_drvdata(master) returning NULL.
> >
> > Return early when 'drm' is NULL before converting it to 'vc4' and before
> > dereferencing 'vc4->hvs', preventing a kernel oops.
> 
> That leaves things allocated and clocks running, so bailing out isn't a fix.
> I'll have a look to see why dev_get_drvdata is returning NULL.

Yes, I realized there are probably other things that need to be fixed.
However, the defensive NULL check avoided the kernel oops for me.

Thanks,
Thorsten
