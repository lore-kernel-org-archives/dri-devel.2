Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3ADD35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9004710F0B2;
	Wed,  1 Apr 2026 11:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="kmTDpPzd";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2BD10F0B7
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:57:23 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 1DF20327F73
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 12:57:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1775044641; bh=4uVC0aEYxjaQTuwalpCxtrvLnrNOwwa3Rtte4QhHBaU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kmTDpPzdnZocJ3AAU9nGKH3TvjRuQ03QfSox30SizVXApcMbr5C9q/fTv9Ew/gqZm
 20AJF7HAftyEUv2Ckrj9zKxJXCRljRApIiVsgAKW3/PaWqwnMItAmUeatsR1NT+/w9
 KqwVL+sRddC+5m0enXAodov9/Anvwz0JRCkPYV4D6eHA5JEY4Ih9GoP1d0L1704bu+
 IzBrFYAr/ZtsWhXGIDWwvyqf1ozXZ/Ghp1xyaH4ctNPXs5ZaFsx9AdrtMfGtE3axDT
 poxYQTtGa5CmOg2yyvhPABYyOTKezcEK5w3PxFvMTvsnBAPHOFsxieaVy4aPMj8uXX
 X4Q0ANYOTd3NA==
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso9888323d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 04:57:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWEnPDkBVHsFfZ932/3Q6QhWiakEFMzSyu0ZAICA+jGa0bqQ6LtOpGzFyXug3CLsc33YGk+RLMHcQ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsjhWaVky4n0dW6g4VMaQw828Qx2EV01fqqzz8rVTVzA1U3Bhw
 xWhb/AVUTtrHCwj20w7dHLtU/FUT3KdqAizHPaaWH52NMvN05cOBmHNUEzicTRsFU5ZbqZVM5hz
 plTQ2Gg/bOfqHBuaC4WERgYYfwyI21Pc=
X-Received: by 2002:a53:d6c6:0:b0:64f:ff90:4d56 with SMTP id
 956f58d0204a3-6502fe7bfe7mr2471092d50.61.1775044639847; Wed, 01 Apr 2026
 04:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
In-Reply-To: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Wed, 1 Apr 2026 13:57:08 +0200
X-Gmail-Original-Message-ID: <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
X-Gm-Features: AQROBzB1fVLxlzjejIYl_P8C5IorU1scQP8jhea66UlykTztcno2mlXZQEtFuOY
Message-ID: <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>, wayland-devel@lists.freedesktop.org
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

Am Do., 19. M=C3=A4rz 2026 um 13:28 Uhr schrieb Nicolas Frattaroli
<nicolas.frattaroli@collabora.com>:
>
> This series adds a new "link bpc" DRM property. It reflects the display
> link's actual achieved output bits per component, considering any
> degradation of the bit depth done by drivers for bandwidth or other
> reasons. The property's value is updated during an atomic commit, which
> is also when it fires an uevent if it changed to let userspace know.

Hi,
I think it's a really good idea to have a property for knowing the
actual bpc of the link... however, I do have one big concern with this
API specifically: It only gives me this information after a modeset.

With this limitation, I can at most show the user which bpc was chosen
after the apply display settings and have the end user manually test
and figure things out, but I cannot show in the UI which bpc will be
chosen with some configuration before they apply it, and I cannot do
atomic tests to find a desired tradeoff automatically on the
compositor side.

As a side note, for future patches relevant for compositors, please cc
wayland-devel. It really shouldn't be up to chance whether or not
compositor developers that would later use the API find out about it
before it's merged, and keeping track of all of dri-devel is way too
much to ask from userspace developers.

- Xaver
