Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C7CCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853CE10E131;
	Mon,  5 Oct 2026 11:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="YUpg1W2C";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86E510E5C3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 11:39:57 +0000 (UTC)
Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com
 [74.125.230.169]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 4753733F25C
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 12:39:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1791200396; bh=3XJn2mVSdIQylxqa0RU54rxgqj0u+ROWTib96AVY9mw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YUpg1W2CSfMCJhgk/d8IOHMCW3/8rgj3s8OnTP4BOgCzH71K2Qoh7Q0leQ8nMQnZv
 M84dwOVchdD2jKUzN1JkeI0kbGsHpNlRoGE5FusgaXXBfXfHZN4I83YsM7vUcq/kJM
 rZO+Dar3oesKE6ObFYfkTQI70cYXso99BbPKDCPOflV458s6IyIQxZ12xdNZ5zJthi
 AYPBBdLfznIWG3irzSia/EK27q4Bg8RhebgM7TC8Dl4stnGs+KpGu6X+DNb8kwvNnf
 Ref7Qmew4lPYquOWYE5EjYuJ6WNB/clASTg0zqBeSvCzyQMlonp/s/+j2+aq1eqhCH
 pKrQikqnc8knw==
Received: by mail-qv2-f41.google.com with SMTP id
 6a1803df08f44-91786b004f2so19153466d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 04:39:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByLmXSkorsH5Rw0GF6h9GenuN2Nv5gFmr7RU2LR8vkVog/72QReJXksKBpsiE1wSt4QMhB/IX+yhAs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLscOcAgWdMqPqZxz5C2l+vS2WqbPXanV4pxD0ttsvqTL1w64M
 HpqxFN/qFR8P+5EGnasXbS7CXYlV8fNu0mBsvHpYSLr40B/Mv6VQ8I6ZwWt+/8fIxnDn8s6kDAi
 V3Nbbpop9uMdW8Cf8fMovAupe2jmaxMA=
X-Received: by 2002:a05:6214:19ea:b0:919:82c5:43ad with SMTP id
 6a1803df08f44-91982c544b1mr4394986d6.13.1791200394616; Mon, 05 Oct 2026
 04:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
 <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
In-Reply-To: <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 5 Oct 2026 13:39:42 +0200
X-Gmail-Original-Message-ID: <CAFZQkGzSkUZTodjUudhLsYtset=EqviZeqrfv6gj6XmG+ZJOPQ@mail.gmail.com>
X-Gm-Features: AclHuK9JKTC03NA4ozxQo1TQRCH1D3FyK2zi18UQWiM7SR2tFBvD2G16KXT3IGI
Message-ID: <CAFZQkGzSkUZTodjUudhLsYtset=EqviZeqrfv6gj6XmG+ZJOPQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/7] drm: Define user readable error codes for atomic
 ioctl
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arun R Murthy <arun.r.murthy@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com, 
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Suraj Kandpal <suraj.kandpal@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

Am Mo., 5. Okt. 2026 um 11:08 Uhr schrieb Thomas Zimmermann
<tzimmermann@suse.de>:
> I have serious doubts about these failure codes. The core issue to me is
> that when the kernel driver detects an impossible commit, it probably
> knows best how to fix it.
There's lots of different ways you could fix any specific error, with
different tradeoffs and it all depends a lot on what the compositor is
actually trying to do. The kernel can't make those kinds of policy
decisions.

> > + * @DRM_MODE_ATOMIC_UNSPECIFIED_ERROR: this is the default/unspecified error.
>
> This one does not give a hint to what happens. Should userspace abort or
> fall back to TEST_ONLY?
That's up to userspace. It's the same as ret=-EINVAL today.

> > + * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
> > + *                                  enabled, invalid falg, page_flip event
> > + *                                  with test-only, etc)
>
> I've seen this being used in the i915 patch for a async flip.  Could
> mean anything there (format, driver specifics).
Its purpose is to catch anything that the compositor is supposed to
know it can't do - using unsupported formats, invalid combinations of
properties (crtc active=1 without a connector), that sort of thing. It
should never be anything driver specific though.

> > + * @DRM_MODE_ATOMIC_ASYNC_PROP_CHANGED: Property changed in async flip
> > + * @DRM_MODE_ATOMIC_SCANOUT_BW: For a given resolution, refresh rate and the
> > + *                              color depth cannot be accomodated. Resolution
> > + *                              is to lower the refresh rate or color depth.
> > + * @DRM_MODE_ATOMIC_CONNECTOR_BW: Refers to the limitation on the link rate on
> > + *                                a given connector.
> > + * @DRM_MODE_ATOMIC_PIPE_BW: Limitation on the pipe, either pipe not available
> > + *                           or the pipe scaling factor limitation.
> > + * @DRM_MODE_ATOMIC_MEMORY_DOMAIN: Any other memory/bandwidth related limitation
> > + *                                 other then the ones specified above.
> > + * @DRM_MODE_ATOMIC_SPEC_VIOLOATION: Limitation of a particular feature on that
> > + *                                   hardware. To get to know the feature, the
> > + *                                   property/object causing this is being sent
> > + *                                   back to user @failure_objs_ptr in the
> > + *                                   struct drm_mode_atomic_err_code
>
> There codes don't seem actionable to me.
Scanout and connector bandwidth are very directly actionable. I agree
about the others though, adding these error codes should wait until
there's a compositor actually using them for something.

> > +     char failure_string[DRM_MODE_ATOMIC_FAILURE_STRING_LEN];
>
> I'd don't think we should return error strings from the kernel. If we
> do, these strings will become uAPI. And I guarantee that someone will
> start parsing them for information. We'll be in a situation where we
> cannot ever change the strings.
>
> For error logging, we can put messages directly in the kernel log
The error string is half the reason we need the API: When things fail
on an end user system, we need to be able to find out what happened
after the fact, without the user needing to have drm debug logging
enabled and without them having to trigger the bug again (which can be
very difficult to do).

I think making the error string something more abstract like the file
+ line number of the failure would also be okay, if that solves the
concerns about uAPI. We just need some way to figure out what happened
after something goes wrong, which would usually involve diving through
kernel sources anyways.

> or you can build them in user space from within libdrm.
libdrm doesn't have any of the information returned in the error string.

- Xaver
