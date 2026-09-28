Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2549CC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC8110E7DB;
	Mon, 28 Sep 2026 08:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LyP7Xio0";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACD510E7DB;
 Mon, 28 Sep 2026 08:10:47 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4htYsH35qGzKqK2;
 Mon, 28 Sep 2026 10:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790583043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIY8SPKWTyDpONssmi/1MXmgnQQyjM5Q9JRAxu1BCzY=;
 b=LyP7Xio0SjFMctEiuiF6nXS35fp9M345lu2ob3Fmzp5i2UTTEdVHeBDNzvvELjoiwG3nnr
 VB3Jeh7BG/61T6Vf/RG5OkXid41+i9+lsPkMq8kMNxXtAkbh+9wU4vyD1/45pHm3TBgeth
 Fe0BxsGq7Nw0xtLi7kon6UKK+wgBTgA/1S2wo4QLNW6mnlkw3kqxB5EW91JTB797cIMF8j
 Hbl4HdaY2ybLC2Q69gikRqAA7+HlIM+5kKj5zdsmO9Sbk9mP4QizOYDa895AeuydNGQT3V
 ydnfCKiGnN4P0FaJ51ea6tUXGO9W+w62Qc6QFZGZR/mNHWb4IC/Svk5TSWrkag==
Message-ID: <3cf7143d-7013-4a3b-a831-96c3f125c2f6@mailbox.org>
Date: Mon, 28 Sep 2026 10:10:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: Leo Li <sunpeng.li@amd.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <0226527e-ee38-40ab-a2a8-1ae62013b950@amd.com>
 <VERVf-aJRRKsBOI_3dpScg@collabora.com>
 <8a3b2902-3255-4dd9-82f0-75a7747b710e@amd.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <8a3b2902-3255-4dd9-82f0-75a7747b710e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tcbp3n76m8henjpos5gobg5u9xk9b6pk
X-MBO-RS-ID: 863b51de2cc2ecb5cfe
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

On 9/25/26 20:42, Leo Li wrote:
> On 2026-09-22 11:26, Nicolas Frattaroli wrote:
>>>> + * VRR Limiter/Target Properties
>>>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> + *
>>>> + * The ``VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR}`` properties expose a mechanism
>>>> + * through which userspace can control the desired range of refresh rates in
>>>> + * which VRR is allowed to operate. Each rate is expressed as a
>>>> + * numerator/denominator fraction of refresh rates in Hz, allowing for rational
>>>> + * target rates like 24/1.001 Hz with no loss of precision or ambiguity.
>>>> + *
>>>> + * If the minimum and maximum rate are set to the same value (and not 0), they
>>>> + * are understood as a fixed target rate. This is especially useful for media
>>>> + * playback, where the content's frame rate is both constant and known in
>>>> + * advance. In such cases, a refresh rate that is not an integer multiple of the
>>>> + * content's frame rate will introduce judder, since not every frame is
>>>> + * displayed for the same amount of time. A modeset of the display with a
>>>> + * compatible rate may in those cases be either undesirable or impossible, but
>>>> + * the rate can still effectively be reached through VRR.
>>>> + *
>>>> + * .. _VRR-MIN-NUMERATOR:
>>>> + *
>>>> + * "VRR_MIN_NUMERATOR":
>>>> + *	Default &drm_crtc integer property forming the numerator of a
>>>> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
>>>> + *	target rate. Set to 0 to disable.
>>>> + *
>>>> + * "VRR_MIN_DENOMINATOR":
>>>> + *	Default &drm_crtc integer property forming the denominator of a
>>>> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
>>>> + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
>>>> + *	zero, it must be non-zero.
>>>> + *	Otherwise, must also be zero.
>>>> + *
>>>> + * .. _VRR-MAX-NUMERATOR:
>>>> + *
>>>> + * "VRR_MAX_NUMERATOR":
>>>> + *	Default &drm_crtc integer property forming the numerator of a
>>>> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
>>>> + *	target rate. Set to 0 to disable.
>>>> + *
>>>> + * "VRR_MAX_DENOMINATOR":
>>>> + *	Default &drm_crtc integer property forming the denominator of a
>>>> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
>>>> + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
>>>> + *	zero, it must be non-zero. Otherwise, must also be zero.
>>>>   */
>>> If VRR_MIN_NUMERATOR == 0 && VRR_MAX_NUMERATOR > 0, do we interpret that as
>>> vrr limiting is disabled?
>> You can picture VRR limiting as always being active, but with a limit rational
>> of 0 it uses the display's limit as per the EDID, which is what unlimited game
>> mode is. So with how it's implemented right now in hdmi_validate_vrr(), your
>> example would set a maximum target, but leave the minimum at whatever the
>> display defaults to.
>>
>> Now that I'm thinking through this, a possible problem is that
>> drm_crtc_helper_vrr_is_fixed_rate() operates on the user supplied limits, but
>> if the display supplied lower limit is equal to the user supplied upper limit,
>> then we have a fixed rate scenario without recognising it as such. I think I
>> need to have a ponder on what the least surprising behaviour for userspace
>> is in that instance. The display limit stuff gets a bit complex due to
>> CinemaVRR and QMS TFRmin/TFRmax.
>>
>> I'll improve the documentation on the next revision to make the meanings more
>> explicit.
> 
> Perhaps a simple way is to require simultaneous setting MIN and MAX pairs?
> IOW, require userspace to set MIN and MAX simultaneously to >0, or =0. For example:
> 
> if ((vrr_min_n == 0 || vrr_min_d == 0 ||
>      vrr_max_n == 0 || vrr_max_d == 0) &&
>     (vrr_min_n > 0 || vrr_max_n > 0))
> 	return -EINVAL;
> That way, it's never ambiguous what userspace has requested for the range.
> They can copy the EDID supported range if they don't care about limiting one side, rather than leaving it at 0.

Determining the actual limits can be non-trivial (though I guess that might be fine as long as libdisplay-info can work them out), if user space gets them wrong, it might accidentally apply a narrower limit than intended.


> It's then also clear if they requested a static Hz.

I do see the benefit of your suggestion for this though.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
