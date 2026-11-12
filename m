Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2E606A335
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=opp40mLC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C0010FAC4;
	Thu, 12 Nov 2026 08:24:50 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A0710FB19
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:24:44 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-55650fe1f0dso2080666b6e.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794471884; cv=none;
 d=google.com; s=arc-20260327;
 b=MO8VlL1xh3sV51xjXc5623ICSA3HX77QOqU4QVlcVtz+VJPTctKO0d4ZIrXds7fnkl
 0vrQ9DBUMwEum8igMp6Trg5vbPixHzm4ndTjSwIcaVMSAfXnD9kd3Cg1Y4cqHp6FaSyM
 B1BXRJhtUAK8l7K+emvQzZbCxL07L674ioOhZPpZRIIY3afvLxwg2iX7CF5hEbljz53p
 7k2UJ6KrC1QdShwBLqcTjN3UEWLfWjl6468mwHVwaKk4hx34jmv3vt3yxu7hw9ecLFHd
 2kDKAuP3DpedKM8sQvy+/jblpL4mO/ECP9pjsoSJcroE9tDWgTw8aVi87DayOoZbr3Nw
 lNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9OoKBHV7mRh3x5bd7scgaHwwhZIWLco7Oq1PqOHadsc=;
 fh=ViPLcYqsejsKRIAGrMQF5himlkt2jFAgDSZV92or528=;
 b=Xante7Zz24KNimgKkH3NHph6Yxx9RxSRzlIrJ+hf9kHqVMn/HCdtb7kTwmz7rRYuAr
 ddnlY6o9lmmvOSX5iTD7BkEyuemhIzI93vnAjXSX7Gt6edXbBsBRykYCb/b7d702eeB4
 godeaFe2WIb94LV46Mr5O912RVqjfU2czaEEdybQsunhRlwF/FzG82FMzuPxS1JjqTPP
 Q7YuWUEuc2Xt0Qh15U7fV/OnMx85pEwh+Mb5MbiHxPuJ6aBYxiNImyziFvT61+gVItai
 IoZV64MlyVhMEslUH4b0Lwp6yoYJBekWNd88zugExWGxAo4KcC91e+BtsnuV0X4HpF5z
 Hmtg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794471884; x=1795076684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9OoKBHV7mRh3x5bd7scgaHwwhZIWLco7Oq1PqOHadsc=;
 b=opp40mLCT/Qm+G0Ivd+hCetf5dqXf70a6/rl4SoAzbH+2BbFt/UDfDrVsp5YLdmhBR
 UFSjBgVHQWdNAUlkaro6ylxzruCDQqp7JSnPA3O+LY+/EdGIw2CtoX374b2u0w4ngO51
 guMmjQ+3FEl2CfaDPp943NILXwwucl1xCrYEP+zNvzx4oM4xg6Ywt3ipvI/w26bR14b0
 S2cY3mY/kZk1zwlGbzoC8Z9QxQlhBIA6SWDNxYrTZoj5+9di3PA0Gevy0hap/vGhF9C6
 1YTAJOX41JuTA4d3mTXoN9WRSoWZ7C3BbqpvHRU3bxjpud9KDq5L/wYUbuDUMW5KFmJU
 lC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794471884; x=1795076684;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9OoKBHV7mRh3x5bd7scgaHwwhZIWLco7Oq1PqOHadsc=;
 b=ttDSpkXlB7Z+BRukXbTclfHuFXVz4kd/3gPhhgbk0k9hTagaVQ5G6LbKxrm21SO42o
 cZwyj+yLlRZ9oQvC08i+iPSFUoe07dNmQtQsb/i8rt5aarIiGqlua3t7b+FwLYao0nMm
 1yD3nOhf6VzKGUXA0h+jP8MBkw+6BeWhT9uqPK7q9mX9vjPiVgSGxkzMhKoCBkWtimSL
 6u1lZWBUezUasTQJzF8KTG8xJJKnoFAFSlBANJ3QrmWMeLVMl/oE/SqUN5hQxT8l2jnX
 kWCEA1QjTdsytSXWXzF0mnV8V0TwzI4MBVV7rjBoHvZTT/altHcywu0AFMlhkc3iptOn
 1H6w==
X-Forwarded-Encrypted: i=1;
 AL+hErEfYiBsOTX9u6LclfTeTlRv57A8N5se+9eX78K2s6FxQ2zv2Mm0Rl+X+Kh3DzutbTU8Ft3gWoFt5ts=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8h1RpQ7Q02ENPMUwdIa3/qKL9EPjdiwQH7fngFw6zgHddp51Zo
 xKk6YQYuhq5gIbuthJ0dScOP1jaAAfTQGl1m5CsHlxSLm2Fn/jusfEuXTHIRWi3EEhDTHtFLpyS
 zIi4xQcX/UgrrO3CukscRcP7vXTCtfl0=
X-Gm-Gg: AYBFou3oZY+JVAw07On1Fn018WH3Ub7ZEyGmIcpt1Mcs9zQTBaDetZtUHENVqYIfJlX
 NZxDNrqOUhWl8JNDaqTOqctykvic57ZfxRhGWV1dU1UhD6ivuhsrkvTYOLiBLcoWhIxOFESbzFJ
 tXQWsoNL1ROzEP+84FxJw7vHwqSaCxmFsryyWZO9ddeIKSiHTcZtsekW/wUuwo36GuxdXGqKUAQ
 pqQz+PXNI7RSMn3e6rDgAN6bhpVOxuVSsgpuf/d9S5IbGd64/l96l8a3o384UwI87pbIznEqJOZ
 Nw/EKCKcSXxYF58yURzK3VzWpoIJuGq0/wwifA8Gy39i1nzUwJelWwAHgoNu+9jqFFMLz9Cx+v6
 TlsCVniBT0mdIvByYtFINSUyNZtUVvInEcOU=
X-Received: by 2002:a05:6808:8887:b0:4e9:69e9:59c3 with SMTP id
 5614622812f47-56bd74d4fd0mr3030474b6e.67.1794471883620; Thu, 12 Nov 2026
 00:24:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
 <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
 <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
 <CAMeQTsb6CESYugWG32JHiNOVVHUUqTY1JdKCCd4Wf0Uf3T9XFw@mail.gmail.com>
 <CAFGNeahpZCnGHy8iC0FS_oALcsU7YrW6afxOe=xJi+407Q0MVQ@mail.gmail.com>
 <CAMeQTsbJ3UimZVpY7NO3deNrvc5uHE0qCaUHJ9j=XK99PBhsJA@mail.gmail.com>
 <CAFGNeag2+SXcYtYDBcLw_F35j1gTNdjLHc96sab0RRA9zY9OaQ@mail.gmail.com>
 <CAFGNeah7oj4scrBXh6fB2OPfZMsqhO96TkPzjNHpRLiOoC-cfA@mail.gmail.com>
In-Reply-To: <CAFGNeah7oj4scrBXh6fB2OPfZMsqhO96TkPzjNHpRLiOoC-cfA@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Thu, 12 Nov 2026 09:24:32 +0100
X-Gm-Features: AclHuK9l5GTZdEFObMWeTJjMratKRcBlM4_JWMNIpoWP7PW2QLGgfS41LzqrLjk
Message-ID: <CAMeQTsb4+9NiSYzWVWxRt-_Q-t3E8qsC1jb6E_xD3ruGmao9Cw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
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

On Thu, Nov 12, 2026 at 1:42=E2=80=AFAM Gabriel Gama
<operatingsystemsdepression@gmail.com> wrote:
>
> I'm finishing up the first reMESA beta and have been thinking about
> compatibility with other Poulsbo machines
>
> So far, I've only tested the SGX535 rendering path on my Dell Mini 12,
> since it's the only Poulsbo machine I have
>
> Since I'm keeping it inside gma500, I'm assuming most of the BIOS and
> display differences between machines are already handled by the
> existing driver

Alongside Poulsbo, the gma500 driver also supports Oaktrail (improved
SGX535) and Cedarview (SGX545). It would be nice to support 3D on them
as well.

The most obvious things are that the 2D engine goes away in CDV
(perhaps also in Oaktrail) and that some models of CDV support 64-bit.

-Patrik


>
> Is there anything platform-specific I should watch out for when
> enabling SGX rendering on other Poulsbo systems?
>
> I'd rather catch any obvious issues before releasing the beta
>
> ty,
> Gabriel
