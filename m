Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972B0C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74F410F50C;
	Thu,  9 Jul 2026 11:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="OnhN6t7A";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6AFD10F50E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:38:35 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 6B2CC32E4E3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:38:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1783597111; bh=VkImaP986qYsluwwoX8dWvkmM++SDGoD6+tk2rM71JE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OnhN6t7AaJcYkoCVuU91FFnHBLsxrNREYcA0nwK6xC7QJB9Seg3+aeMfkAyjlQr04
 68dk0YwD+Zq5dufJ5r3w16GTUQuvV76/m8Z1lt9EClMPsgz4Tq38NRhXuESQZxZKf4
 uaLIvcfO5I5ONiCoyLFzEm4Qd+bNLhZeGiCmmRGC14co/PhEoa7O2t9Kp0015peicG
 +prVO22N0Y6CKiNxCQANjm388zAlRkahygFCugGQpKo7Rrtkbu/B8TKOY7f8SlIu1N
 xf7LLxWn5M5sxkehfso690/+Td6iF6Inh3YDobIFN4OXD+sNIaf/CvSuiptguKOHQs
 JUGi2ydGbb/tg==
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8ee43b3e5abso4967776d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 04:38:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqyaccP7k8uUuSju/j9GFjYlCB3+vusEACpi1sRD6vQ/IxMrMdzzVQS3JKYwxYOt8vMNAGeu7h5xt0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJB5Raco9GYZdZ0zcpbGrR9tXh9ZtFoBDVlS+zetzNw8hsFSQQ
 C96zCunZ0Eaxio0QoE85yIinLoVLKIZgeqKckkkst1U/Xa/nJKLxuEDAEPF0ZZOieHDMIgJwr2g
 G9gtpZq5eCJ19eyTSgahvj/ode8pgxnc=
X-Received: by 2002:a05:6214:5087:b0:8fd:6de3:dd7e with SMTP id
 6a1803df08f44-8fec371c58bmr69260556d6.64.1783597109866; Thu, 09 Jul 2026
 04:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260625150439.330875-1-nick@haghiri.net>
 <928d4c2a-d8b7-43d7-995e-a3e6996d2952@amd.com>
 <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
 <7a474010-67a1-426b-9ca2-76c11cfbb0ac@mailbox.org>
In-Reply-To: <7a474010-67a1-426b-9ca2-76c11cfbb0ac@mailbox.org>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Thu, 9 Jul 2026 13:38:17 +0200
X-Gmail-Original-Message-ID: <CAFZQkGwv3Nb46EQ6qrxVVEao6RS6QNeYiAw+3FJ09bwwG4Qo4w@mail.gmail.com>
X-Gm-Features: AUfX_mydIY1RLdkm4mRQqEkFzWqLWJy0RXCRjIgjB2fowZig78KG-pZVp99mDsc
Message-ID: <CAFZQkGwv3Nb46EQ6qrxVVEao6RS6QNeYiAw+3FJ09bwwG4Qo4w@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/amd/display: extend HPD debounce filter to
 DisplayPort SST
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Nick Haghiri <nick@haghiri.net>, Ivan Lipski <ivlipski@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Am Fr., 26. Juni 2026 um 10:53 Uhr schrieb Michel D=C3=A4nzer
<michel.daenzer@mailbox.org>:
>
>
> [ Adding Xaver for awareness ]
>
> On 6/25/26 21:45, Nick Haghiri wrote:
> > On 6/25/26 3:15 PM, Ivan Lipski wrote:
> >> I don't think I've encountered a situation when a monitor with DP can
> >> wake a system up from DPMS, so that's interesting. What distro and
> >> desktop environment are you using? I'd like to reproduce this issue
> >> and help with it.
> >
> > openSUSE Tumbleweed, KDE Plasma 6.7 on Wayland (KWin). GPU is an RX 907=
0
> > XT (RDNA4), monitor is an MSI MPG 274U over DisplayPort SST.
> >
> > What happens: when the output goes DPMS-off and the monitor drops into
> > deep sleep, it briefly de-asserts and re-asserts HPD. amdgpu forwards
> > that as a hotplug, KWin re-probes and re-enables the output, and the
> > panel comes right back on, so it never actually stays asleep while
> > connected.
>
> FWIW, that the panel comes on and stays on might be a KWin bug. Mutter ha=
d a bug like that, which I fixed in https://gitlab.gnome.org/GNOME/mutter/-=
/merge_requests/4209/diffs?commit_id=3Dec73076e07640fc0752d9ecc66c5934726db=
2d7e.
Yeah, I did find (and fix) a different problem with our workaround
recently, where KWin-internal pointer warps in response to the
"hotunplug" were wrongly counted as user activity in some cases.
Either way, kernel-side debouncing is very much appreciated.
