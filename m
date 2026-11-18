Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDEC606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=i1APa+4O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAD11120B2;
	Wed, 18 Nov 2026 23:15:04 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A801120B2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:14:57 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1751BD77;
 Thu, 19 Nov 2026 00:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795043547;
 bh=dct3OBUdxsuGKI0CV47QxpcGo2zqix3lmVc/RdlIyAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i1APa+4Oy3ez0tMIgz0OCtIItxtbV0jrQySoB33bDTPP8JeaS8j/fzbR8zeVDAEsT
 u75zHl61iYjlKZZa6vU1yoYAIBuyyfsXJG2s6pxppGK04PD2qXm7RiOp1pFi9+7XWT
 o04XsWyzlWDvzIxgMl/xsJEHisv+xtufEpP9VGGo=
Date: Thu, 19 Nov 2026 01:14:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
Message-ID: <20261118231454.GL1923307@killaraus.ideasonboard.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-21-ville.syrjala@linux.intel.com>
 <20261118221114.GI1923307@killaraus.ideasonboard.com>
 <av4nb98f3ewe2rV3@intel.com>
 <20261118223911.GJ1923307@killaraus.ideasonboard.com>
 <av4tQaL6caoqd2w8@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av4tQaL6caoqd2w8@intel.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 12:57:05AM +0200, Ville Syrjälä wrote:
> On Thu, Nov 19, 2026 at 12:39:11AM +0200, Laurent Pinchart wrote:
> > On Thu, Nov 19, 2026 at 12:32:15AM +0200, Ville Syrjälä wrote:
> > > On Thu, Nov 19, 2026 at 12:11:14AM +0200, Laurent Pinchart wrote:
> > > > On Wed, Nov 18, 2026 at 11:45:17PM +0200, Ville Syrjala wrote:
> > > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > 
> > > > > Make DRM_RCAR_VSP selectable with COMPILE_TEST=y, and enable the hidden
> > > > > DRM_RCAR_WRITEBACK option by default, so the VSP and writeback code gets
> > > > > built for greater coverage. Builds fine on x86, x86_64, arm and arm64 at
> > > > > least.
> > > > 
> > > > Let's see what build bots will report on more exotic architectures. I
> > > > may volunteer you to send a fix if I'm too busy when the builders start
> > > > yelling :-)
> > > > 
> > > > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > > Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > > > > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > > > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > ---
> > > > >  drivers/gpu/drm/renesas/rcar-du/Kconfig | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > > index 80bd770ae0f6..5394f131c58f 100644
> > > > > --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > > +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > > @@ -76,7 +76,7 @@ config DRM_RCAR_MIPI_DSI
> > > > >  	select RESET_CONTROLLER
> > > > >  
> > > > >  config DRM_RCAR_VSP
> > > > > -	bool "R-Car DU VSP Compositor Support" if ARM
> > > > > +	bool "R-Car DU VSP Compositor Support" if ARM || COMPILE_TEST
> > > > 
> > > > This will make it possible to disable the option when ARM64 &&
> > > > COMPILE_TEST, which will break operation on Gen3 and up. It would be
> > > > best to avoid that.
> > > 
> > > Break operation, as in when running on real hardware?
> > > People actually do that with COMPILE_TEST=y kernels?
> > 
> > Hopefully not in production, but that may be the case during development
> > (I don't though, there are enough kernel options to deal with without
> > COMPILE_TEST).
> > 
> > This should do:
> > 
> > 	bool "R-Car DU VSP Compositor Support" if ARM || (COMPILE_TEST && !ARM64)
> > 
> > (untested though). Do you think it brings too much complexity ?
> 
> Doesn't bother me.
> 
> All I'm really after is being able to have COMPILE_TEST=y
> enabled in my x86-32 and x86-64 drm-misc test build configs
> so that I don't have to build on all the other architectures,
> while still having reasonable confidence that I've not
> completely broken some non-x86 drm driver.

Sure. Let's go for the above change then. The commit message could also
be updated, maybe to

----
Make DRM_RCAR_VSP selectable with COMPILE_TEST=y (but keep it
unconditionally enabled on ARM64 to avoid breaking operation), and
enable the hidden DRM_RCAR_WRITEBACK option by default, so the VSP and
writeback code gets built for greater coverage. Builds fine on x86,
x86_64, arm and arm64 at least.
----

With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I assume you'll merge this with the rest of the series.

-- 
Regards,

Laurent Pinchart
