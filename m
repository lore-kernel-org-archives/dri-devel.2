Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D12606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lvg2O/5v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C588D10EC01;
	Fri, 13 Nov 2026 08:24:43 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D4310EC01
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:24:37 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-55651e7de9bso755552b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794558276; cv=none;
 d=google.com; s=arc-20260327;
 b=p4WcL4DTUiJSi4r1zp4Umovj+uogX8DFgsw/NDAC3yrTIY1KCuCqasFBrfQQq3ATM9
 K8fiK6q7baqKfUGHW8ocjDOypjZiAMARZNQy9LZhf6zLJ87VTzXX0qYKbXgLMPQG8/gO
 n/YP5ZhBBd6O/599Q9h2hKfve0SJhlHfmcUMTpMmyB5/QI4tpeoxBzeRLdALRpoALdZV
 IzyX0Nj2WiSGai8lhR2sOe3guBg+pJB8nBoI5rS7IuqIACPfC0y8YACcF2B+YlLCbRJ1
 I6wBavZMh2uhhhEH+JxVkurP34yn9SItimgbAckW4lRECHpGiQTsu8mx4XY6ORGHxWRa
 jfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1PkqeO6Hkxg8iRsNxeaTlgsJtcyhR8PF5X4MEa1RZK0=;
 fh=KpHBSz3ronA9KRU923F8E+FZ14sC2jrXtFnisHfmfNs=;
 b=Hmp9tZUQCLfcrUFRFGTNJ2wQRYQwbniOi+a0Kz7oeta/eetUvQ25hY2uc1g/5/AZ2S
 UzfGwU1u8RPaIdf/NxAB9teo29R30vfJ8+VYT35fbKnuyE/nM+9E0eg03zgC9WWpzon5
 Sydb/ctqDN3bN+KbArqtXmYLmxc5/psOINSTqew37fgNvxCRv9KH4NmjRfwjRWwwGXaq
 StoWxa2awa5/4VqRMm5HYQgDTRwWcNvMV7SA9soK0LGSNvuXLIi5xhYFm4aGDoPR+ya9
 JCHZQm/Sy85QS0xscFypxUnr5VrMY59HKWHe9dDlHkc1hUlPe54AXZTiTtMm6Ys4z9jF
 fnOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794558276; x=1795163076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1PkqeO6Hkxg8iRsNxeaTlgsJtcyhR8PF5X4MEa1RZK0=;
 b=Lvg2O/5viJfBncrvXm2z5OjlQ36VDBRpeNJQPyvz9ND+1q07XCKQ+I9B1wHdIiy69c
 LULdygACTlZqmoxCvjpOKtemGRMsMU1kV2ZHJ3HgpvA7GCQFra9UWi0LjknCyN/yHtKa
 b4g0Lhhf8jfM3/8fdgtX1CGwOlQmNsSZ6Q3YkMqulwlX1JuIhI3uypsg9Yxo6HlXNRq8
 AVA15oqvSIE+z25PmiPzFGG0mM7WNTTJ4U1t576XCdFTvEHS42Vy3AJVArthO3woS+Fb
 DePOLIRzdbo+qK9foMJXAiWBEnXteuYR3Flhx90C81/Q/CyOJOshJsCOsnjzjlbmuDsO
 XrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794558276; x=1795163076;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1PkqeO6Hkxg8iRsNxeaTlgsJtcyhR8PF5X4MEa1RZK0=;
 b=LrGnqC8+cwhmAZhZGbo/VF8RCpNGXcu8VYnbFPSclKsSHMQopqoP0yynMTZXJlIbII
 cJd7UwBWEi3nJj8Aq53XMxW8uhYk0ikwoEvh02hphfTNcobEgmRA9AEJtw1E2g0OpjtX
 i6JJE9bZT5VAGvwBKfJjPZjxyjZ/h7YZYrSUwJ0rNR3gTQuYukg6zDCGGFGU2x8AGFRv
 M7VuBDt6x91RYHaa/tFmGWFogJQVQTVi8y75R0J/vLqYQEkzOSY4rR1xWMLZAXuyfbZo
 PwbsGdpWlD2iA1qcwbXEjl9TnFmpT0WAkor5q/EF4WJlFcHnR88C4aPPbv8Dq57cHlF+
 oIag==
X-Forwarded-Encrypted: i=1;
 AL+hErE3CWD8WQCRapvzl+ORVZ4BQsheWw65LWLwPttxQXiBdqbDA2ubqY41gQ4209+0TGHz/Th5tWak/1g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+5wAHhleiUwcv8NawoizZjN7yaqgYNEH1bjk6ffx3Vz+ga/+jk
 RpL5/0K3W2Xw89n/9cNTDsJV1GH6REJ3X9e+nU4MuOZz5gd1onv7Bzp+lQOoUbXtinbqTzL003F
 3gmvr+ioopA8pp+elSdCr3MZHJ/ajIBo=
X-Gm-Gg: AYBFou11PBPuvO5DbdDdbBpZKEpX2HIfaxVJrUwlKytvc4QAqP1d2Wof64nAP7ypdT4
 AvlWe0+b+3Ea/Rufa9kVtxKMRfdkic/Ns59nm/M5+/J+gXf+RpELvbGkg1hVQY7gpMY3EkpL3HY
 o3mev0Yo32vpUbEyMWuSjxjIY3isOMg2ZNXlAOdov7E0QEPhbk5Dyze9cAaR2sMoqICCrVs6dM+
 T8llazNxX1ZYQosGmrYH7++3DQCpIkpFezmtlmnUNoatWnaQM5hvGQ292vEiA2n68gekUvST9gn
 jCSQnnz4nEbqunhB/bAgFwCYvlH1kchLcJQfxqyBHEnOoULr7q47zXrvVSr7Brt3WjjEy9WQDwv
 FJJc8zmJWEAUJ2vpHBp8VjQ64n2A8/+DA5SA=
X-Received: by 2002:a05:6808:c211:b0:4b3:8d45:aa2b with SMTP id
 5614622812f47-56e648e7782mr1537245b6e.16.1794558276349; Fri, 13 Nov 2026
 00:24:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsb4+9NiSYzWVWxRt-_Q-t3E8qsC1jb6E_xD3ruGmao9Cw@mail.gmail.com>
 <20261112200219.6239-1-joseph@telaak.dev>
 <CAFGNeajWk0aAnTHyHFmp+gEYJi_RMcLkw0s6yenBeZgT6uF9gg@mail.gmail.com>
In-Reply-To: <CAFGNeajWk0aAnTHyHFmp+gEYJi_RMcLkw0s6yenBeZgT6uF9gg@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Fri, 13 Nov 2026 09:24:25 +0100
X-Gm-Features: AclHuK-SUFO9XG8KsHDsIMKfs48xPrNMC9fmrdphLjDgKjxtzT-Mbm0bokrutME
Message-ID: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Joseph Telaak <joseph@telaak.dev>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 1:22=E2=80=AFAM Gabriel Gama
<operatingsystemsdepression@gmail.com> wrote:
>
> Oh nice, I saw your RFCs here!
>
> About the SGX544MP2, I was thinking about making a separate DRM driver fo=
r Clover Trail+, since it's quite different from Poulsbo, but I'll take a l=
ook at powervr_sgx too

Clover Trail is not supported in gma500 so perhaps it's better to keep
the SGX driver separated? You and Joseph should try to figure out how
you want to do this together.

-Patrik

>
> I'd be happy to compare notes, especially about PDS and MMU stuff
>
> Also, thanks for keeping me in Cc !
>
> I've been following your project for a while now, back when mine was stil=
l mostly documentation
