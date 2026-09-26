Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45D0C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C387410E031;
	Sat, 26 Sep 2026 12:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="iPv2CDHq";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C74110E031;
 Sat, 26 Sep 2026 12:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790424821; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nasoSrIl9KcUqK0DT8SzV5nVDXuxQRhCTTDweswR05ZrmYaXHn3oz9PlTU3oA5BvzEo1i9/OrERg6U/HNFW93k8Y1FFVHeNeLOk8fTw/1O/PiFtLVHvMrvWnGp9JbPR28G4UP3uNujBwxR1jPTFTHnysG9c7Y84viUOakjicA7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790424821;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NeIgan50r491jqmuR3ZRoobvDzKxm124IC7JCVTX4Hg=; 
 b=U473Jxzs+gWttpqIClZECT9YHH0jfQMLHBhh78p2EE/W09lZmOmZbbuci6brvPYwSv1By9IHwDx+JZpVloBKcVbjxeL7eJy6mkILltw/k7pXJMKxzeIhH7FzyccCAXI+kOhoZInEaqVNHPdnZCr/kfNNHgTlLDl4ZBY8ng5k1Wc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790424821; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=NeIgan50r491jqmuR3ZRoobvDzKxm124IC7JCVTX4Hg=;
 b=iPv2CDHqWUGmUCmjfvIt2UOD5Nt5e7yhBJIBrktXvKsWVZr4Ffm4/i3FnSCBsc4s
 lE69f5fnxybJi3c8wAATYcUHA0sXHztWAWr36Hczs6UzJ0wzxOGdyAhhsIlM6Wv2MgP
 3p00SA60uTQWk8DmNWDlt8XbFNXG8n3Py8lS/njo=
Received: by smtp.zohomail.com with SMTPS id 179042481925589.85921556278674;
 Sat, 26 Sep 2026 05:13:39 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Leo Li <sunpeng.li@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
Date: Sat, 26 Sep 2026 14:13:32 +0200
Message-ID: <Fw4fv4KvQKui7PMYotsPFw@collabora.com>
In-Reply-To: <8a3b2902-3255-4dd9-82f0-75a7747b710e@amd.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <VERVf-aJRRKsBOI_3dpScg@collabora.com>
 <8a3b2902-3255-4dd9-82f0-75a7747b710e@amd.com>
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

On Friday, 25 September 2026 20:42:05 Central European Summer Time Leo Li wrote:
> 
> On 2026-09-22 11:26, Nicolas Frattaroli wrote:
> >>> + * VRR Limiter/Target Properties
> >>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> + *
> >>> + * The ``VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR}`` properties expose a mechanism
> >>> + * through which userspace can control the desired range of refresh rates in
> >>> + * which VRR is allowed to operate. Each rate is expressed as a
> >>> + * numerator/denominator fraction of refresh rates in Hz, allowing for rational
> >>> + * target rates like 24/1.001 Hz with no loss of precision or ambiguity.
> >>> + *
> >>> + * If the minimum and maximum rate are set to the same value (and not 0), they
> >>> + * are understood as a fixed target rate. This is especially useful for media
> >>> + * playback, where the content's frame rate is both constant and known in
> >>> + * advance. In such cases, a refresh rate that is not an integer multiple of the
> >>> + * content's frame rate will introduce judder, since not every frame is
> >>> + * displayed for the same amount of time. A modeset of the display with a
> >>> + * compatible rate may in those cases be either undesirable or impossible, but
> >>> + * the rate can still effectively be reached through VRR.
> >>> + *
> >>> + * .. _VRR-MIN-NUMERATOR:
> >>> + *
> >>> + * "VRR_MIN_NUMERATOR":
> >>> + *	Default &drm_crtc integer property forming the numerator of a
> >>> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> >>> + *	target rate. Set to 0 to disable.
> >>> + *
> >>> + * "VRR_MIN_DENOMINATOR":
> >>> + *	Default &drm_crtc integer property forming the denominator of a
> >>> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> >>> + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
> >>> + *	zero, it must be non-zero.
> >>> + *	Otherwise, must also be zero.
> >>> + *
> >>> + * .. _VRR-MAX-NUMERATOR:
> >>> + *
> >>> + * "VRR_MAX_NUMERATOR":
> >>> + *	Default &drm_crtc integer property forming the numerator of a
> >>> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> >>> + *	target rate. Set to 0 to disable.
> >>> + *
> >>> + * "VRR_MAX_DENOMINATOR":
> >>> + *	Default &drm_crtc integer property forming the denominator of a
> >>> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> >>> + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
> >>> + *	zero, it must be non-zero. Otherwise, must also be zero.
> >>>   */
> >> If VRR_MIN_NUMERATOR == 0 && VRR_MAX_NUMERATOR > 0, do we interpret that as
> >> vrr limiting is disabled?
> > You can picture VRR limiting as always being active, but with a limit rational
> > of 0 it uses the display's limit as per the EDID, which is what unlimited game
> > mode is. So with how it's implemented right now in hdmi_validate_vrr(), your
> > example would set a maximum target, but leave the minimum at whatever the
> > display defaults to.
> > 
> > Now that I'm thinking through this, a possible problem is that
> > drm_crtc_helper_vrr_is_fixed_rate() operates on the user supplied limits, but
> > if the display supplied lower limit is equal to the user supplied upper limit,
> > then we have a fixed rate scenario without recognising it as such. I think I
> > need to have a ponder on what the least surprising behaviour for userspace
> > is in that instance. The display limit stuff gets a bit complex due to
> > CinemaVRR and QMS TFRmin/TFRmax.
> > 
> > I'll improve the documentation on the next revision to make the meanings more
> > explicit.
> 
> Perhaps a simple way is to require simultaneous setting MIN and MAX pairs?
> IOW, require userspace to set MIN and MAX simultaneously to >0, or =0. For example:
> 
> if ((vrr_min_n == 0 || vrr_min_d == 0 ||
>      vrr_max_n == 0 || vrr_max_d == 0) &&
>     (vrr_min_n > 0 || vrr_max_n > 0))
> 	return -EINVAL;
> 
> That way, it's never ambiguous what userspace has requested for the range.
> They can copy the EDID supported range if they don't care about limiting
> one side, rather than leaving it at 0. It's then also clear if they requested
> a static Hz.

That's a good thought. It makes a lot of the logic simpler to catch bad
conditions, and it's the kind of thing that can definitely be checked in
connector-agnostic shared CRTC atomic_check code.

Thanks for the suggestion, I'll likely adopt it for the next revision!

Kind regards,
Nicolas Frattaroli

> 
> Thanks,
> Leo
>  



