Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03977F4613D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E2910E4A2;
	Mon, 23 Mar 2026 21:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="NIwXAMPI";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB1910E4B5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:19:36 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id C7A35324CEC
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:19:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1774300774; bh=r20OZHTYgzoYdBQOnECr0qFhpYAC9zz0Ibdh/LXucZw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NIwXAMPIku8YbMuedkkPuDs98hyP1558Xik7EmjMIedrb7Y1J6VGkvZYXt0SUQlBY
 9AzKmJ/oWc5tBnQFZ5MUmLnHCS56DCNW4xZPQEG84TWTadkP0m9IRCkvPDJdY+7Wiq
 UUBTIC4dVFqdnXHasjcS6uScrwoPIo0pFUD5e6cqscQH87XDFtdVv8QzAnvTXEL2Xa
 VOFb9MkoskH1xES4IisaunvAdJ7ivKckCyQBPiPP4zrzbz4FUo+80ictL8DnbLTre8
 i06kpaxerQowe4XlQBaa5B7Hg6PpiYwhp9ogIrQRz5B2IW9WxE5Hunv6Zkv150eJSC
 eOgveT+3fl1xQ==
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-899e87b04d8so48662506d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:19:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUkjpkvrQtpBjaAVbPHgfW4X8AOiNH+tSCjHUOjyCAIo4GdeOuVVrFkFuVsa+D/ydjiKgAd2aC5ECs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkE5d3NWRryK+Nc37SMR50TRqN7upqh6jK2+RQpwrwGWsmptL3
 Wvve/vSHMwNuRHkxWMEHB9tOg03Ydozzn9vPJYsX1G8HgH4UoLI8WMIXZVaS+Jk/Lcl7NLvTxLQ
 WVp6AKI45oqvFcXMkI86q7hErmlkEwKQ=
X-Received: by 2002:ad4:5766:0:b0:89a:b7:9a9b with SMTP id
 6a1803df08f44-89c85a99ac1mr228043676d6.58.1774300772939; 
 Mon, 23 Mar 2026 14:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-atomic-v10-0-f59c8def2e70@intel.com>
 <CAFZQkGw=VJnzFWnh7GT_59NhuSTiy3-VPOcKdWTZX14rkgW_uw@mail.gmail.com>
 <ec9b1e8d-daab-48a7-959a-bfc5309b3ea9@intel.com>
In-Reply-To: <ec9b1e8d-daab-48a7-959a-bfc5309b3ea9@intel.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 23 Mar 2026 22:19:21 +0100
X-Gmail-Original-Message-ID: <CAFZQkGxLWnrt1be4S6pJj0qVRfVPXkzvZODNNNKWjpD2NNTAeA@mail.gmail.com>
X-Gm-Features: AQROBzBi1GIjCBzS3clAXX8UAOhv46EtsZX2EO34VxBgkUC-vgFWSwdNg9EAQo4
Message-ID: <CAFZQkGxLWnrt1be4S6pJj0qVRfVPXkzvZODNNNKWjpD2NNTAeA@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] User readable error codes on atomic_ioctl failure
To: "Murthy, Arun R" <arun.r.murthy@intel.com>
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

> Have added the remaining error codes to the enum
> drm_mode_atomic_err_code, will push as part of patchset 11.
I think it would be best to limit the enum values to actionable
things. Connector and scanout bandwidth sound useful and pretty
straight-forward to me, but the three other new values don't seem
useful for compositors at the moment.

> DRM_MODE_ATTOMIC_PIPE_BW
Compositors aren't aware of pipes. What would they do with that information?

> DRM_MODE_ATOMIC_MEMORY_DOMAIN
> DRM_MODE_ATOMIC_SPEC_VIOLOATION
I can't think of anything a compositor would do differently with these
vs. "unspecified_error".

> As far as the enum INVALID_API_USAGE is concerned, there is a certain
> understanding on the
> usage of the atomic_ioctl,  any miss in that would fall in this
> category.
Invalid API usage would mean the compositor did something it can know
in advance is wrong based on the KMS API. It can't be used as the
default value.

> Some of them include
>      - Driver doesnt support atomic, but still atomic_ioctl being used
>      - Invalid/Junk flags
>      - Async flip not supported
>      - Flag page flip event along with test only is not supported
> If changing this INVALID_API_USAGE to UNSPECIFIED_ERROR makes more
> sense, I can change that.
No, they're two different things. We need both, and unspecified_error
needs to be the default for when the driver doesn't set anything more
specific.

- Xaver
