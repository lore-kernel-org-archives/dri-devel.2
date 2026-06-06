Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1432DCD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 18:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D940210E830;
	Sat,  6 Jun 2026 18:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="EW2TQW2i";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0892710E830
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 18:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780771190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PqpQa88e5bwqmcaFA652JDeAPdo+EOirG8JoaGnOdeGMNiVLJ5Uzlpl218WxKgCy8unw/EIiMKfax7XKf75o2ThaNP19cCBDN8jZKEDfapoCdv/2wfUAoJ1Qwiz3CnPrxS08u3/phM4ZZUdvttFLm+nSyF76FiS+xHG/05CFeik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780771190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IBRJ5xkb51o4nAEKxK2DLYLkB7ZAohg6NhCUWzAEfEY=; 
 b=DCGaDpLYVGoeQHJFRHM1S9Ns+VL2jKdFAQFqcExWgx1TFK6rd+8lcfoyJvoHetPxJHdk7joun4R64wt6k8CZEqELXDKcYv4ExKEO2/cVdl0YbqXHceOJmpZYbSdNmojqYFWuC+Bb7g+6qamZEWTNqJiy8xxm4FuSfj8dvhqHwCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780771190; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=IBRJ5xkb51o4nAEKxK2DLYLkB7ZAohg6NhCUWzAEfEY=;
 b=EW2TQW2ik9fFVdgLR0PbTgjVTmfoNOG5VpEV5TzF4FPSFQasfiLv2mUKGlyrHssn
 WUSgQ4nQr6e/320sZagA2tq1qlqYxbup/yc0JmOmgDppnS2F5AHDOwfBbrUVsq27gwD
 E/muLbn7oa/shoyqZQ2/zPhHSeoSPHdUlbDk4VM4=
Received: by mx.zohomail.com with SMTPS id 1780771187168175.71050321767996;
 Sat, 6 Jun 2026 11:39:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v5 3/4] drm/display: bridge_connector: init scdc debugfs
 for HDMI
Date: Sat, 06 Jun 2026 20:39:39 +0200
Message-ID: <kFXCAerTTJqUXQYeypgmPw@collabora.com>
In-Reply-To: <20260606-bright-smooth-chihuahua-3eac7f@houat>
References: <20260604-scdc-link-health-v5-0-11173b0ac3de@collabora.com>
 <20260604-scdc-link-health-v5-3-11173b0ac3de@collabora.com>
 <20260606-bright-smooth-chihuahua-3eac7f@houat>
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

On Saturday, 6 June 2026 10:54:23 Central European Summer Time Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jun 04, 2026 at 05:52:08PM +0200, Nicolas Frattaroli wrote:
> > On drm_bridge_connectors that contain an HDMI bridge, initialise the
> > SCDC debugfs entry under the connector's debugfs root.
> > 
> > Reviewed-by: Daniel Stone <daniels@collabora.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> > index cafa498c3848..629d9b8aff22 100644
> > --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> > +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> > @@ -25,6 +25,7 @@
> >  #include <drm/display/drm_hdmi_cec_helper.h>
> >  #include <drm/display/drm_hdmi_helper.h>
> >  #include <drm/display/drm_hdmi_state_helper.h>
> > +#include <drm/display/drm_scdc_helper.h>
> >  
> >  /**
> >   * DOC: overview
> > @@ -263,6 +264,9 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
> >  		if (bridge->funcs->debugfs_init)
> >  			bridge->funcs->debugfs_init(bridge, root);
> >  	}
> > +
> > +	if (bridge_connector->bridge_hdmi)
> > +		drm_scdc_debugfs_init(connector, root);
> >  }
> 
> We register the other debugfs entries in drm_debugfs_connector_add /
> hdmi_debugfs_add. I don't think there's anything specific to bridge
> connector here and it would benefit to drivers that don't use it as
> well, so I think putting it in the generic part of the framework would
> be better.

Yeah, I tried that, but unfortunately this creates a dependency cycle
during linking:

depmod: ERROR: Cycle detected: drm_display_helper -> drm_kms_helper -> drm -> drm_display_helper
depmod: ERROR: Cycle detected: drm_display_helper -> drm -> drm_display_helper
depmod: ERROR: Found 3 modules in dependency cycles!

My way of working around this was to move it into the target of the
indirect function call for the connector, in this case the bridge
connector.

If you have alternate suggestions I'm open to them; I don't know
enough about the kernel's linking process and how people usually
resolve these issues.

Kind regards,
Nicolas Frattaroli

> 
> Maxime
> 




