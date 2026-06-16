Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BB7CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265D710EA9A;
	Tue, 16 Jun 2026 12:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WUXUGWLC";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E178010EA9A
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 12:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781611462; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dLAXd5sN2L14bG9hkzkm0CxW55uRvk/1mqGi7+lMBL1Xm7hOJGxAQnOMjr3xnKoiZUZqrvp91cBw3jsMWXPJteBMiHY6dGSFcN7eLLFP83L3Jab0HalqZV1b8VA/fGSKR1O4uRcbwxg51cszRTI+4d6oV69Evt5C4US9PnMh2As=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781611462;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SYmKzwI4nq4EDUtuPmTgrXKdRMpJnM/v7Sv+byW3jhw=; 
 b=l3Kr2nPoOMon9Q686nR+Id5NiqOO5+VuTJrB5kyVcGLwLbrsnkr5s5aIy2eSyj4Fm3yOsfO0amm4QO6pmfUaaL0PE4AbDHRpGoCbxf67Qqf0GIB90AwroLsB2wUG9KxcitDvur/f8kjcWMMWkK+xJUnOx0vcsCoIkVN1sR0Sd/k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781611462; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=SYmKzwI4nq4EDUtuPmTgrXKdRMpJnM/v7Sv+byW3jhw=;
 b=WUXUGWLC4/k5zkqgzOeJ04wOcdqL/6LNR+RhsSSlNQxyUsu6khBaoM6VC0HTkEvI
 bUFwUy4M35D02y4uGWWRgIcWiy5l6wP+z6k3sVmZkL7puZkqAuZqPnqaVqn37LMEfot
 RmlgufSEuNirRJ6iE+n1+hTR2mPbUHTuu1N2AcT0=
Received: by mx.zohomail.com with SMTPS id 1781611460351423.87744694676974;
 Tue, 16 Jun 2026 05:04:20 -0700 (PDT)
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
Subject: Re: [PATCH v6 0/4] Add SCDC information to connector debugfs
Date: Tue, 16 Jun 2026 14:04:13 +0200
Message-ID: <GWBGXfaiTF64ibliB2zCRg@collabora.com>
In-Reply-To: <20260615-mature-frog-of-certainty-d05f99@houat>
References: <20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com>
 <5DBSVhedT12K_nGj0amyCw@collabora.com>
 <20260615-mature-frog-of-certainty-d05f99@houat>
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

On Monday, 15 June 2026 18:33:11 Central European Summer Time Maxime Ripard wrote:
> On Mon, Jun 15, 2026 at 10:07:02AM +0200, Nicolas Frattaroli wrote:
> > On Saturday, 13 June 2026 08:57:29 Central European Summer Time Hans Verkuil wrote:
> > > Hi Nicolas,
> > > 
> > > On 11/06/2026 14:57, Nicolas Frattaroli wrote:
> > > > HDMI uses the DDC I2C bus for communicating various bits of link status
> > > > out of band with the actual HDMI video signal. This information can be
> > > > useful for debugging issues like questionable cables sabotaged by feline
> > > > teeth, Enthusiast Grade cables made of cow fencing wire, and other such
> > > > problems that ruin one's media viewing plans.
> > > > 
> > > > Consequently, this series exposes various bits of pertinent information
> > > > from the SCDC protocol in an HDMI connector's debugfs. To continually
> > > > poll the link status, userspace can poll the debugfs file.
> > > 
> > > Something is not quite right: I've been testing this series with my i915
> > > based laptop with HDMI connector, and I never see the scdc_status file.
> > > And that's because CONFIG_DRM_BRIDGE_CONNECTOR is not set for my configuration.
> > 
> > That's to be expected. i915 does not use bridge connectors, and neither
> > does amdgpu iirc. I am working on embedded boards that do use bridge
> > connectors, along with all the rest of the HDMI state helpers.
> > 
> > Implementing something new in DRM usually involves having to triplicate
> > certain parts of the work in order to have i915 and amdgpu behave the
> > same as everyone else.
> > 
> > > So I think you are creating the debugfs entry in the wrong place.
> > 
> > I can't create it for all drm_connectors as Maxime suggested due to the
> > cyclical dependency that would create. If someone has any idea on how
> > to break that dependency cycle, I'm open to suggestions.
> 
> Back when we introduce the audio support, we floated the idea to
> de-midlayer this and turn it into a debugfs_init helper. We don't have a
> lot of users yet so it might be the best time to do so, and would solve
> your issue.

I agree and will be happy to do that. I need some more concrete info
though on what "de-midlayer" means here. From what I can tell, the
core problem is that drm_connector.c directly calls into
drm_debugfs_connector_add of drm_debugfs.c, which if it did also
do a direct call into drm_scdc_helper.c would mean drm_scdc_helper.c
needs drm_connector.c but drm_connector.c needs drm_scdc_helper.c.

So I guess the de-midlayer and turn it into helper part is that
drm_connector does an indirect call to a function pointer instead,
which is default-filled at runtime with the helper debugfs_init
function? I don't know if we can then do this by default for all
drivers in drm_connector.c or if it needs to be done per-driver
like some of the other helpers. If the latter, then we don't
really gain much over what I'm doing with bridge connector.

The other maybe less intrusive change is that
drm_scdc_debugfs_init and scdc_status_fops travels to drm_debugfs.c,
while the actual implementation of the read op remains in
drm_scdc_helper.c. I think that would solve it without a big refactor?

Kind regards,
Nicolas Frattaroli

> 
> Maxime
> 




