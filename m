Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7BDC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838DF10E2C9;
	Fri, 17 Jul 2026 13:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="IKX8FluK";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF5F10E2C9
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:03:25 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 6354332470A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:03:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1784293403; bh=Urj/R/FpK9zLJboh7KJ8MQp4Cp4Db3W5PivoanLlD+8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IKX8FluKD9v6W4lkQNAsD/N2b5QOCuKfuKx8nCjL49oZPLSybEesf3vS9fa/u5m4F
 j7S7mz23IAgzmU5P55JKbFS/DZZBu+xdNgPWZyyZVWUblurca8FtKo3I4dyKeQXgZm
 Wvt/JtiFinuQhVmn4N3zKgdlzbYJa70aRXiExmgWZ5wW4YLelBrCfo9eqggLsCExn3
 sXgrgQSqL3mJfXa9CcRce61Z13i8X8Z50bRSfhNfXcX5FLWtD7+gJBz0ir4eqGM0mu
 UQSO0cpQYe+ceWu5NgAQK/vZ23d4ASoAMvls0cIIyx8pKFJhiz3RUJxXGKEo86Gu+j
 I9JSlbR3ZMcQA==
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92edb12cdf2so276735285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:03:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrUlIuMHq0RQX730+rqiV3bQVB6PTsszmeAvOQDmY/o7C0gOtpNVW+rQaJ4tGKSeTgXi0FyvTEJMPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzabm/T9J2nNQoss1ej3fygnoJt81DhZWrhUglMVit6I0XJjEwI
 j0kfT3JXRyjUYyTtH8eY9kpID+ffhRhEed7ogQ6yAh71bvnXBycnE7v+KaoK8zah7oszOr6lfUE
 Qe/YqIUvB3nqRzm+m5CrmvOACce+EOn8=
X-Received: by 2002:a05:620a:4714:b0:930:771e:e8d1 with SMTP id
 af79cd13be357-930b3ce9194mr265705185a.0.1784293402154; Fri, 17 Jul 2026
 06:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
 <CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com>
 <20260716-expert-crouching-bonobo-ffd0b6@houat>
In-Reply-To: <20260716-expert-crouching-bonobo-ffd0b6@houat>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Fri, 17 Jul 2026 15:03:10 +0200
X-Gmail-Original-Message-ID: <CAFZQkGxf+GFq7HhrBOAgSfStxwptCXjYoXJjkptUoeyyN0=xVQ@mail.gmail.com>
X-Gm-Features: AUfX_mxZ_ctPJZptSIkRNgGhrxhUm-XzpetMRcZJvBTkyuT24sxKthdblA7pmMc
Message-ID: <CAFZQkGxf+GFq7HhrBOAgSfStxwptCXjYoXJjkptUoeyyN0=xVQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Stone <daniels@collabora.com>, Harry Wentland <harry.wentland@amd.com>, 
 =?UTF-8?B?Sm9uYXMgw4VkYWhs?= <jadahl@redhat.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, 
 Simon Ser <contact@emersion.fr>, Victoria Brekenfeld <victoria@system76.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Am Do., 16. Juli 2026 um 10:26 Uhr schrieb Maxime Ripard <mripard@kernel.org>:
> > The compositor may use the same CRTC states, modes etc; whether or not
> > the commit actually ends up requiring a modeset depends entirely on
> > the exact contents of the commit. So I definitely wouldn't require
> > ALLOW_MODESET.
>
> Just to make sure we're on the same page, you're saying that when using
> the reset flag, the compositor is expected to fill the state with enough
> that a modeset is unlikely to happen anyway?

I'm saying that it's no different from a "normal" commit, and should
just follow the normal rules for whether or not a commit needs
allow_modeset. You can't make assumptions about which properties the
compositor will or will not set.

- Xaver
