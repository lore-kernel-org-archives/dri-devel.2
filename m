Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCF7CDE012
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 23:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDF110F3C0;
	Thu, 25 Jun 2026 23:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="Cj15jEMN";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D3310E18D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 23:09:30 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 52A4932E491
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 00:09:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1782428968; bh=K/o3c3A5OTzQuinic9HUZn27oI9oXWleoJD5KlpDVP0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Cj15jEMNsVZ/VcZ0kO0bHNoGj0kBrICCq6j05hThsLDU3y88AlcgKJ1N00ugggLmE
 7JBHIIP2RS+uM+uy4hLmNC8wWanhEeIo/NuwJP57dkDxtzHraU3qn8ZemYI9ZoOKXY
 5a6KOHDtQo9smGb/U6VB0AzqJKV9SisL56NVASt9om81CAI1fAU2/imqVGheUAvV2r
 qSgSrvSJQQaNOI9gAM+tp7KE4EaSZWrc+DvWBi6G+ixd8eyDx/UUxMyvLzHoFH6gQ0
 qw2e1C/4/wp49d/T3J+mHc1w+/Ceo308m4IDWTzcjRYBQENuV6oFMDMRcOCVgZuQ3N
 wc3lpX393CK8A==
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-9204711e831so47258485a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 16:09:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/9bMXm+e+Sjfhg4wrmXWTL8Ydg2U3z7xd5MC6lqxuP/PvXL4a/epJXB2lJPdVj7TjHbp6VorjkrVg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvYy4loYEa9HdQ26fKUD//YLQNixPwpasz2Nf4q5TARDdlpY5U
 VxWA/ZSen36hYe+9wLbrS/t5fNqPzoDY3U6Cf8xPDgqXC3J9KDA0LJOePFHDr/XTJq1QUWnrCzm
 PUzEne6AQEPA/Hj0XXQKibYaaM4P9iDE=
X-Received: by 2002:a05:620a:470c:b0:916:1970:5e66 with SMTP id
 af79cd13be357-9293c9e81f2mr702168885a.44.1782428966671; Thu, 25 Jun 2026
 16:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
In-Reply-To: <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Fri, 26 Jun 2026 01:09:14 +0200
X-Gmail-Original-Message-ID: <CAFZQkGy6f9vr5HjjnKtObOGA08TvhEhoaxiBd_0_i7WqJ2S8ow@mail.gmail.com>
X-Gm-Features: AVVi8CdcXSj6ybUSkqiaEDaNVgsPqIFcwpBgQiGhsvarwZMHGOxf_V2PDTG4YQI
Message-ID: <CAFZQkGy6f9vr5HjjnKtObOGA08TvhEhoaxiBd_0_i7WqJ2S8ow@mail.gmail.com>
Subject: Re: [PATCH v11 1/7] drm: Define user readable error codes for atomic
 ioctl
To: Arun R Murthy <arun.r.murthy@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com, 
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Suraj Kandpal <suraj.kandpal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

I finally got around to updating the KWin implementation, and made it
handle some more cases. I found some issues though.

Am Di., 31. M=C3=A4rz 2026 um 11:06 Uhr schrieb Arun R Murthy
<arun.r.murthy@intel.com>:
> +/**
> + * enum drm_mode_atomic_failure_codes -  error codes for failures in ato=
mic_ioctl
> + * @DRM_MODE_ATOMIC_UNSPECIFIED_ERROR: this is the default/unspecified e=
rror.
> + * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
> + *                                    enabled, invalid falg, page_flip e=
vent
typo: falg -> flag

> + *                                    with test-only, etc)
> + * @DRM_MODE_ATOMIC_NEED_FULL_MODESET: Need full modeset on all connecte=
d crtc's
> + * @DRM_MODE_ATOMIC_ASYNC_PROP_CHANGED: Property changed in async flip
> + * @DRM_MODE_ATOMIC_SCANOUT_BW: For a given resolution, refresh rate and=
 the
> + *                              color depth cannot be accomodated. Resol=
ution
typo: accomodated -> accommodated

> + *                              is to lower the refresh rate or color de=
pth.
> + * @DRM_MODE_ATOMIC_CONNECTOR_BW: Refers to the limitation on the link r=
ate on
> + *                                a given connector.
> + * @DRM_MODE_ATOMIC_PIPE_BW: Limitation on the pipe, either pipe not ava=
ilable
> + *                           or the pipe scaling factor limitation.
What are actionable things a compositor can or should do in response
to pipe bandwidth limitations? Just turning off displays, using a
lower resolution or refresh rate? It's not clear to me if it's
practically different to scanout_bw in that way.

> + * @DRM_MODE_ATOMIC_MEMORY_DOMAIN: Any other memory/bandwidth related li=
mitation
> + *                                 other then the ones specified above.
> + * @DRM_MODE_ATOMIC_SPEC_VIOLOATION: Limitation of a particular feature =
on that
> + *                                   hardware. To get to know the featur=
e, the
> + *                                   property/object causing this is bei=
ng sent
> + *                                   back to user @failure_objs_ptr in t=
he
> + *                                   struct drm_mode_atomic_err_code
I didn't find any case these two values would be useful in KWin yet,
should we just leave them as "unspecified" for now?

> +struct drm_mode_atomic_err_code {
> +       __u64 failure_code;
> +       __u64 failure_objs_ptr;
I made use of the object list in the KWin implementation for the
CONNECTOR_BW case, to reduce the mode resolution and refresh rate on
only the affected connector.
When I did that though, I noticed that the memory management of that
pointer isn't defined. How is it supposed to work?

I think a good way to do it could be to let userspace set it to a
pointer to an array of uint32_t + specify the max number of elements
in count_objs. Either way, if it's included in the struct, its use
needs to be implemented, so these questions are definitely answered
and it can be tested.

- Xaver
