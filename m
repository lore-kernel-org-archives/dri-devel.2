Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FAA606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=uO/ZtZAK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACB110E72F;
	Fri, 13 Nov 2026 07:37:12 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA78710E72F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:37:05 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0443E227AD;
 Fri, 13 Nov 2026 08:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794555422;
 bh=0wAF9gvvBWx1jBLOo+W6S6m0Glsi4Cju2u7ogWxYQkc=; h=From:To:Subject;
 b=uO/ZtZAKe0L/kT/fAoWLX5CgvgoYVxSwh75/juB0sCRQ2IJfOAyc49h+sQqsY9WBe
 4ukCa+fAVSysiZZ1zlKhBthMHEH2ykAu7TmJtn+ZEF8aMTzdAFcel2QExUNQUhmQaF
 WPoMGX0LGWAS0bH9lZffpHexai8IAimYrHGfcjLSuIkfxNilKwhS0F68zsgi//7sTY
 zIj5HbJ2kGDlbxOzfbhRhXU5xZWznDH/SNQ9bApmxYDiJPTpGnEoYw2RPLYuYiAOQu
 Dalz5nWb94nv40Puttwx5Bi7Ax2agrG8pcTOKxD1HdFzCjUS8BgVEmiHBorxXp9SUQ
 ShEIcrvtShoqQ==
Date: Fri, 13 Nov 2026 08:36:58 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, regressions@lists.linux.dev,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, tessolveupstream@gmail.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 marex@denx.de, valentin@compulab.co.il,
 philippe.schenker@toradex.com, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Message-ID: <20261113073658.GA12065@francesco-nb>
References: <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
 <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
 <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
 <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
 <3hfae2i2i2toxbo7hg2if6pztaswgnfj65xfm2c4ofljc6jhua@slaqoewn4mxq>
 <DLATMIFKDMHV.24XNMCRI2ZKBI@bootlin.com>
 <20261024095405.GA5692@francesco-nb>
 <sqilixoei4yw4z52r52vbwfggyjnhdzz62vz3vshrx6wbppa2v@izyujkfcrb6q>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sqilixoei4yw4z52r52vbwfggyjnhdzz62vz3vshrx6wbppa2v@izyujkfcrb6q>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+regression list

Hello all,

On Thu, Oct 29, 2026 at 04:50:39PM +0100, Ernest Van Hoecke wrote:
> On Sat, Oct 24, 2026 at 11:54:05AM +0200, Francesco Dolcini wrote:
> > On Wed, Sep 09, 2026 at 03:30:53PM +0200, Luca Ceresoli wrote:
> > > On Fri Sep 4, 2026 at 2:02 PM CEST, Ernest Van Hoecke wrote:
> > > >> > Also, from our testing, when using:
> > > >> >
> > > >> > dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> > > >> >           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> > > >> >
> > > >> > we are not able to get display output.
> > > >>
> > > >> This is the case for the panel I worked on as well. In the practice we both
> > > >> observe that non-burst mode is what fixes the panel, but there is no clear
> > > >> explanation of the reason in the docs (that's what I hope to discover from
> > > >> TI).
> > > >>
> > > > I am testing a DSI panel on our Verdin iMX8MP module, and noticed that
> > > > this caused a regression.
> > 
> > [...]
> > 
> > > > I think we'll need to either revert this and later apply both together
> > > > when ready, or apply the second patch now as well. Right now, it broke
> > > > the DSI panel behind a TI sn65dsi83 bridge on v7.3-rc1.
> > > 
> > > Reverting is surely the last resort. If you can answer the above questions
> > > it would be good, maybe we find out reverting is not necessary, and worst
> > > case we'll revert with better understanding on what went wrong, and maybe
> > > come up with a new fix that doesn't regress.
> > 
> > What's the status of this regression?
> 
> I still need to test and look into this, that will happen either in
> December as I'm off in November, or by someone else in the team. Sorry
> for the delay.

Luca: I think we should revert this for the moment, the regression is
real, and I do not see an immediate way forward.

#regzbot ^introduced: 4af021a97773
#regzbot title: drm: bridge: ti-sn65dsi83: display broken on Verdin iMX8MP after enabling HFP/HBP
#regzbot link: https://lore.kernel.org/all/3hfae2i2i2toxbo7hg2if6pztaswgnfj65xfm2c4ofljc6jhua@slaqoewn4mxq/

Francesco

