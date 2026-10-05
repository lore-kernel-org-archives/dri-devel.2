Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADABBCA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017EB10ED65;
	Mon,  5 Oct 2026 14:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="ljaRz7xO";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31C210ED56
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 14:01:19 +0000 (UTC)
Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com
 [74.125.230.171]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 6438E3369B6
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:01:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1791208878; bh=8HJxRxBpXrcbzqs3kEuPtFXZ96yDimqagGTowPB3l58=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ljaRz7xOjT/zezQ6dymn+LPHNTTMNvsRWWZNs6dgNdnY0qGSP9RV8jeL8tnnFyCUD
 KxjjmCvoQo3b0UwwMsgVS/hVLBBWSjGpf5PtdUN4KLl9MUWk9rVFO7d+BF6CLgj1S+
 HXcYlpY6+Yqbz59kSFs1N+V7qAlZam/Ge+skr0nejMl0iPlsxfD3ww2E+IgPHJTBrd
 gqdfCpJ5z3vVJT+Ndf30ad880JMKRWlZ1q33R189ahiBt8VpAEHseRoj0g8d30TAKM
 9R5hX1EaAqnm8gL/98A4dqXm6AQQegMQN95q/exHtXBbyHEvdIEJcAwnqd9DZr9xLL
 0QCAp/18VCXQw==
Received: by mail-qv2-f43.google.com with SMTP id
 6a1803df08f44-91951457245so16746936d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:01:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxp7j1rmliU1GT02ssPFq8kXcwYftM3Gsh8MrqcgvtKgGkexEwm5cvCO3CtcLfQEVxtb0Pf6c7/n3c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nrfgzkMP/j+/yyf9v2So/rq6Xy5QQnDixacN12ZhwLq6nI90ZJ
 GdTS2JgCxR3mWJyBWB8qp/6+fSruiGipW+TB8zggPUeY5Lm9J/hayvpWojaNryfUYMnwrk8gNXq
 uHN6+AHvjf+FnfrsnhJ39n9t8vzHDi2M=
X-Received: by 2002:a05:6214:5196:b0:917:a1ca:e0cf with SMTP id
 6a1803df08f44-917c006ce63mr210844256d6.19.1791208866309; Mon, 05 Oct 2026
 07:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
 <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
 <CAFZQkGzSkUZTodjUudhLsYtset=EqviZeqrfv6gj6XmG+ZJOPQ@mail.gmail.com>
 <636a3dc2-fe17-463e-806a-056818656692@suse.de>
In-Reply-To: <636a3dc2-fe17-463e-806a-056818656692@suse.de>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 5 Oct 2026 16:00:54 +0200
X-Gmail-Original-Message-ID: <CAFZQkGxYm_zBe69ecsOwhL7ftXVSPkTz5EUR_iXsAgLBVPd9NA@mail.gmail.com>
X-Gm-Features: AclHuK9cCVoEfzsEABuVzYuQ4ViN0b-8gs7MSGf7t2AoSkmh4Jx4LbVcpu4xd2E
Message-ID: <CAFZQkGxYm_zBe69ecsOwhL7ftXVSPkTz5EUR_iXsAgLBVPd9NA@mail.gmail.com>
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

> That's not a policy decision. User space is free to do what ever it
> wants.  What I have in mind is a hint from the kernel what to do next.
There's a lot of different ways a commit could be fixed, and telling
the compositor things like "turn off this plane" wouldn't give the
compositor any actionable choices except giving up or exactly
following the hint.

If you meant much higher level things like
- reduce scanout bandwidth
- reduce connector bandwidth on this connector
- do a modeset

that's exactly what the proposed API does.

I don't think there's a middle ground between the two, KMS is too
complex for that.

> >>> + * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
> >>> + *                                  enabled, invalid falg, page_flip event
> >>> + *                                  with test-only, etc)
> >> I've seen this being used in the i915 patch for a async flip.  Could
> >> mean anything there (format, driver specifics).
> > Its purpose is to catch anything that the compositor is supposed to
> > know it can't do - using unsupported formats, invalid combinations of
> > properties (crtc active=1 without a connector), that sort of thing. It
> > should never be anything driver specific though.
>
> I don't see how this could be useful except for the prototype that come
> with this series.  It's so broad in meaning that it's almost meaningless.
It's useful because it tells the compositor that the failure is caused
by an implementation error in the compositor, instead of some driver
or hardware limitation. It doesn't need to be meaningful outside of
that, a developer later debugging what went wrong can use the error
string to figure it out.

> And error codes don't have to be driver specific to be meaningful. I
> already brought up DRM's mode-status code as example. They are not
> specific to any mode, display or hardware. Yet they clearly state what
> went wrong with the mode.
I think that only works because the mode isn't specific to any display
or hardware. Atomic commit failures are often specific to some
combination of driver, GPU and display.

> You could to this with detailed and precise error codes plus the object
> on which it failed.
They can never be detailed enough to exactly pinpoint specific edge
cases, unless you give literally every single return path in every
driver an individual error code. I don't think that is feasible (and
then that error code would be uAPI).

> Filename + line is even worse.  None of this is even close to stable.
> I'll nak this as much as possible.
That's the point? It's supposed to be not stable, so it doesn't become uAPI.

> I also don't buy the argument about diving through kernel sources. Not
> doing that should be the goal here because it is what we currently do.
I don't think that's something you can ever fully get around. Just the
very hardware specific error cases alone make it impossible.

- Xaver
