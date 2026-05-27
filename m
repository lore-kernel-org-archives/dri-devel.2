Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBF7CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 13:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A8610E7BE;
	Wed, 27 May 2026 13:17:49 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B355C10E7BE
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:17:30 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-631333ee9e4so3673112137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887849; x=1780492649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JRCmfpq1b4R+1qcl85pdAn5PhWzGoG97LYi2GdYmC1E=;
 b=DG6jnwwHzWqx9I/tfwq6fYIGRWq+FWwsHLVCetTR6jV2nNWP5DKVn39Dx5/D+fIQE5
 RM6X4fPweJCbCyLJicrf/aJNMm0sh5J/UDgEV98nRwDEa7d8+FFpWD6wW7jHGB6wE0xZ
 i7fpJdD6vu55pMZlCNSQTEWt1Ez8L4oWnbTpB1NM27S2Ct+Hic4ocqpDmJ/JUwMQIA8Q
 oX9+UC41qwyEBYO8lpA7f51MxNcExqUCF1+Ihc7Kw9V36tnaVn5K0ee0MMc6Ya6nARqg
 CVTcKrEEV6NcvBfoaGwqm6XlZB7WjjMR8yNFykvEYNK1dkPOiRLDOJaRvkzM2P6pwBAU
 Y25Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nELHb4l30eYkAHG3nZh4YniHwWug7KZHI9HSbKqH9I7wjMyQskKyHEd1HaMwa+tQsgNU/sp/PpEA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXghn3AtYPoOZ4njGlnnCaYOIbWTWItx9gEOSiAp1noFWUPGaL
 vce8u8rJHFcC76x/4n3dfRgJmX+dOKg9gb+17TYPMKMg8bmawrgTHKH9QnGiFa5ZB+w=
X-Gm-Gg: Acq92OFmvZPvx/CzPe0w0Z1l8RRpIAVSlwpzwbD5qXiekFCPwx2BVcM68B7BJtd/TsR
 8o2YSgg7P2h7VuF7soUFsleihgVDMdcvNMMtxmpGqPM6QFEn2egSGTbf2ffZuaHLpn4jYNtoM09
 dJPgLrh5AjYY4eMm/tw1xe8MFFR+ug3U3ujt178FcYVemQ8twjU3xs5xldOkUR2dioNrpxrqtSa
 z6au8cmD/AzzJqffW7HrDqIevtN3KMhLqV2tVLBAngHCSbHUvnY1X3m7CMaf7dd34KISs7Unw9B
 sKN9HnQa3+uf8DLU/5fuDybHFP2+UUnqn0Z1o3afezc8W6YbpWlv4yzdUxzWtyEQqv2VAxBm7Hs
 RHAJEnoH6I0vW+gtIUX0Q2iQT+i3culnXSzUCGrHQQsfY1NCY0dnH2gUnUt8ip2m12GfNAXd316
 yxZ6Rkq8EAeBC0uC8SjW94mY7QrDkj2xCtPf3V1gkUgdqNmcMfVPnTlzAsG8XU
X-Received: by 2002:a05:6102:2b8c:b0:632:88f6:d6ae with SMTP id
 ada2fe7eead31-67c8398fa78mr10184274137.22.1779887849442; 
 Wed, 27 May 2026 06:17:29 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com.
 [209.85.222.45]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96173af3e82sm16977705241.10.2026.05.27.06.17.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:17:28 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-961556c15ceso2504124241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+FHy4lPKlzBwhsw7F7kfTqTwqIb2NjTedzf9AL9rUtI/z8aiCJOE2EPKf0Dc835b5THcvjKRaENHM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3ec6:b0:631:4580:6a3f with SMTP id
 ada2fe7eead31-67c767cb843mr10676067137.7.1779887848413; Wed, 27 May 2026
 06:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <12911d2a1dfc4e482bbc0a417df73748283d04ee.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <12911d2a1dfc4e482bbc0a417df73748283d04ee.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:17:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZZi9MVEnS1VjugLCY-18Rxq9FcrtzR7x3=MdbcmTiHg@mail.gmail.com>
X-Gm-Features: AVHnY4IGd02q56r2qfPhmxXv4tp6c-mV5aR4QFnr15yhVjYq6uruWZtcFagWHm4
Message-ID: <CAMuHMdXZZi9MVEnS1VjugLCY-18Rxq9FcrtzR7x3=MdbcmTiHg@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] video: fm2fb: Use named initializer for
 zorro_device_id array
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
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

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Using named initializers is more explicit and thus easier to parse for a
> human.
>
> While touching this array, drop the explicit zero from the list terminato=
r.
>
> This change doesn't introduce changes to the compiled zorro_device_id
> array.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
