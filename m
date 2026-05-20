Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3325CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 22:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13E610E181;
	Wed, 20 May 2026 22:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pAgwiZym";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1C310E181;
 Wed, 20 May 2026 22:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HsjhAy2BBtCFA/egDCdJZk4pjYZbxFSYZKXDkZ+Avwo=; b=pAgwiZymOW8GGrLLojHhetbVx0
 9TrKs9vM0v6AmUOGFF9kTLwGkbQ/WntzQL2Sj0b7582rF4a4DMqcybT4HUbo4l4rKRyqkxpCx4H/e
 o1Z4MDHncvmdjtf+fvVmlVAJ4gNVGT2Q/PtvPUOqX4J6E0C9rvamZCWWq/Rzj8l2qU7wrfxT7Rkj4
 iEQgN5cRzQaPAArG92EKxbyOWFD4IBrKs+vQ4yLdziplGub28uNWH2zOi1fq/2WLfzZDFmtFPb/4z
 VCWOXI0i0O92YxbT0DmOHLG4oKNKWiGJ3fQdBFOulCCk2bIG40O5m42OD9JBUlNlvsdvIRP50KAki
 hzS4+nFw==;
Received: from d209-89-236-181.abhsia.telus.net ([209.89.236.181]
 helo=atmagalia) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wPpk9-0043dh-8d; Thu, 21 May 2026 00:50:25 +0200
Date: Wed, 20 May 2026 16:50:14 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
Cc: John Harrison <John.Harrison@igalia.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, "Kandpal,
 Suraj" <suraj.kandpal@intel.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 0/8] drm: writeback: clean up writeback connector
 initialization
Message-ID: <ag44Kk4h188WGhcN@atmagalia>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <177894506978.2448625.17152574519326512949.b4-ty@b4>
 <8fc45730-b2e3-4ba8-b80a-9b30557e810b@Igalia.com>
 <wcgvogluzfrjk6rlomswkmqceilbbichxsgx3aqzpoawe7jzgw@uiy3ogtswflk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wcgvogluzfrjk6rlomswkmqceilbbichxsgx3aqzpoawe7jzgw@uiy3ogtswflk>
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

On 05/20, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 09:59:00AM -0700, John Harrison wrote:
> > On 5/16/26 08:25, Dmitry Baryshkov wrote:
> > > On Tue, 05 May 2026 03:24:57 +0300, Dmitry Baryshkov wrote:
> > > > Drivers using drm_writeback_connector_init() / _with_encoder() don't
> > > > perform cleanup in a manner similar to drmm_writeback_connector_init()
> > > > (see drm_writeback_connector_cleanup()). Migrate all existing drivers
> > > > to use drmm_writeback_connector_init(), drop
> > > > drm_writeback_connector_init() and drm_writeback_connector::encoder
> > > > (it's unused afterwards).
> > > > 
> > > > [...]
> > > Applied to msm-fixes, thanks!
> > > 
> > > [1/8] drm/msm/dpu: don't mix devm and drmm functions
> > >        https://gitlab.freedesktop.org/lumag/msm/-/commit/c0c70a11365c
> > > 
> > > Best regards,
> > That is only the first patch of the series, yes?
> 
> Yes, correct.
> 
> > 
> > What is happening with the rest? Can they all be merged to drm-next now? As
> > I understand it, only the first patch was still being discussed, the others
> > have all been reviewed some time ago.
> 
> At least we need an ack from the AMD maintainers. I can pick up patches
> 3-6 to drm-misc-next, but it doesn't really help because the rest of the
> patches are blocked by the AMD change.


Hi Alex, Harry,

Could we have your acked-by for this series? I tested it with a DCN
4.0.1 and the kms_writeback test; everything looks fine. This series
should not cause regressions because the AMD modifications are
restricted to the writeback functions; if you want to be sure and cover
more hardware, it can be useful to run it through AMD CI (you just need
to make a few minor adjustments when applying it to the
amd-staging-drm-next).

Anyway, this series was

Tested-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks

> 
> -- 
> With best wishes
> Dmitry

-- 
Rodrigo Siqueira
