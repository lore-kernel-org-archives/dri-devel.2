Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7748606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZuEaLIO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F75810EF87;
	Mon, 26 Oct 2026 15:25:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F4710EF8B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:25:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C2C940528
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108041F01825
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793028327;
 bh=2Qmg6BcXALG/dj9RRiDDchrevIVukXtgjlaBUO9hEDo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=MZuEaLIOAAbhvEk+XobWYQbcJbYFGOW5+7XlBCdzI+jTFM+8Wn85I7Ly5Fjerv3el
 zbGqDVBOgTANr0EokwDZauiniCjDqh4Ppezuuy/J6/4UKectxpYkw1h6e0HGl5K6oz
 PS7UfhJ66MCbKYnvXAKDRgGnkyM1HRWnpbs4Gr5IQWpkI7OcO+9JXx/RSh4MfOVPM9
 +SEwiXEh9+Chmfa73VdnizH64uyGt9cNw39eftY23asUAW/kaGWhEXvEUoxFZamu0u
 m6nyDKM8qA6eg6jslzJKO+r/eeXpQJbv9zIWonXPsdugXpYqRsGQQyKfuHe4mDPZsN
 Zkz7fGEgP8LAw==
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so4546493a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:25:26 -0700 (PDT)
X-Gm-Message-State: AFq9FYIu6mSwNjPOB5e3QSB8z/HLNiBiuQ6nrIqiwg8ILMqTft1olkJv
 x3Ev06inrW128suftFkpMGnRwsNJ9R1qh8Yus6qxUsR5XCisK5Yyfji1RdOTVfI8IpRF/w+dQx3
 rwdruepxFqNto/kEIk4CpHwLC8/hJvQ==
X-Received: by 2002:a05:6402:c4c2:20b0:6b3:dd6e:3dc8 with SMTP id
 4fb4d7f45d1cf-6b442ff000fmr5335746a12.37.1793028325770; Mon, 26 Oct 2026
 08:25:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260831203137.1331960-1-robh@kernel.org>
In-Reply-To: <20260831203137.1331960-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 26 Oct 2026 10:25:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+FErjac-iqe+okjjqw9ZwR57w2zrVSt--8aTuegdsstQ@mail.gmail.com>
X-Gm-Features: AclHuK8Xogf33r4EIeunV6M14Tus6XobjgJHA1U-35PEmz2V5OwQO2qLgIk1tMk
Message-ID: <CAL_Jsq+FErjac-iqe+okjjqw9ZwR57w2zrVSt--8aTuegdsstQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Aug 31, 2026 at 3:32=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> The "sil,i2s-data-lanes" binding and in-tree DTS files use normal
> uint32 cells. Reading the array as u8 only works because the values are
> small, but it does not match the documented DT element size.
>
> Use the u32 array helper so the driver follows the binding. Changing to
> u32 increases a potential OOB access range due to using unchecked
> values, so add a check on the read values.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v3:
>  - Drop the WARN_ON.
>  - Combine checking the values with any other error parsing the DT
>    property. The exact DT error isn't important.
>
> v2:
>  - Add bounds check for property values as reported by sashiko
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Ping. Can I get an ack on this to apply it.

Rob
