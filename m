Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E09AEBFD0A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5BF10E348;
	Mon, 13 Apr 2026 07:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZI+cJYV";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8B710E348
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:54:11 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so757566866b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776066850; cv=none;
 d=google.com; s=arc-20240605;
 b=YRELNQ02aLeYrpJScTZZ+LdUfjMS3/Jrpnptl+nAvDImeaOtj/4AqLUmhVX/2uc0ZF
 Mg7KbzStY3j2gg3ofwcv1dhRL2QTS3o6A7CUg48D9phss7Bm+w7pnwuR/Z2gtuKfn6gG
 D62D6wZlU1ujqQCl6i2rzoRGhONmWc3t+7vGIgY+vBkdJbru+0bpg2h32Orqwqo86NzZ
 Bb8/bbZ/4jc63PCP/YtEqXZVfQEpZrHCLoHfvdyY0km8XLHccPgwZ3Gnh//xiSGWLx/c
 aqxknKXym3UZ21fxqfIB9ZitsjR+7E250W/wx87nMU22MmMrkIEv9U6HVy4bM6HOO06U
 jrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WF2eIKkja7dyHhJJwMsSuEwqCgvKiY7IvupflJtjz2Y=;
 fh=frQEOkBxfbSd9b99xzy+cg9PuNxK4WEIhC/3ApNLLf0=;
 b=SruzoNqBnmHogOeVxDv9YUHmHDHMYalfv7ogVob+MGZAAmiRKajfL/hyfC8DlgU0nJ
 hkfjbSwJG4sP2mD5uTHy5ArwdO6gg9YgGendA/5319FAW/LaGLDD3Adoe+5rkL2eOJJt
 XfWcYVhnzSx1hwe8L5+bV3w1EhlU2gVjM7PLGvKm0ToP2k0ULECT8XDqp2OSc4++09cX
 g2a9AKU9DBIBY+bfgMYq4ZRGaKGuXSEOZy9TL3cHZWW3vaZlehQ//zE95ZcmkM+mpAKO
 WkP3QqaD0FSLRJZYlHXSsw3pxiJHiRrhDDDYC9jQm1/YAmr/0HtcHKwcAeX93Mk7PkDz
 mg7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776066850; x=1776671650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WF2eIKkja7dyHhJJwMsSuEwqCgvKiY7IvupflJtjz2Y=;
 b=kZI+cJYV/IPFKsyZ9aCb+1VZftNKhN/Vavyr8ErPGQyCTMLyTMe00GZwbhMQ+JKAJr
 1h62zxbCJTdAQ3KQgmajQ7vfeWq0WOArjcgjSWZ62n0Np6Za4ejxXzxY7whASSLxAT9j
 BihDRdVy3pFjtpXCskLVaPYcck30kKTgYO2vUjXeI9/VC3c9rcaGDfkAArU85j44Ee1Y
 RwzLvd63urW07jfjV5kjGhxW48IU4lV0UrPJQv9lUUfMGKuxtEy9h9Pt1jqANKSYdvoy
 DVEvq69ht/spJhXUn9P1FJx3YmO51U/SaHP5dzvpgCh6LkSWW5iUOPUP8PgNNaKVAnd1
 K3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776066850; x=1776671650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WF2eIKkja7dyHhJJwMsSuEwqCgvKiY7IvupflJtjz2Y=;
 b=oc+ljuOfC4RqDeGvTiNtnvod2ysWiQyeiP67iXv5gy0fyv5RtfprnEm+1eaejEo597
 +GutJ+2ZPuf+Pc4EHg2GyCMofxnqjkDb9OLILZvM7cu4fFh0fDsCNYlEw1djkPhT8Cdx
 aHTSDJzXuMPLihmfa5QE8KGVqHDzoi4xkhWy+jwAbV0G/f/IVHa9zBlsiVRlNywUfnOZ
 cRgIYmtQe25WNUaZ/CMj6pJvD2WNlb7uqwcD4Tyyy3EuiZfmyeISlEZNwgofP2mZNuzv
 kWUKdPfOMErUjFfFnUed1pA/lIY8iWJ7NHBQKiOYXUhknS0tMqLtp8ZoCrUWBjwy459J
 fvBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+scAV8QRY+u9/6Oquom5zwklX8IKVKg0osZhkftdpjB5DRTnsL1Go5V2OzmwDIOgNsadykm79qqkU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOIM3HnT/LVyF8OzwE11/3s5dkXdxOpaiaBmNVdSJQU+M5vOc4
 kmXyAPXOU8PQ41L5MyWiV7YaZvz1vR43GQmIWqU6Uir+9FYiXwMvxrqIoyLK8FprDkJCwVcaFJX
 BVPkwvRwS6DJAHNTnGbRYV7T5MSRvXCA=
X-Gm-Gg: AeBDietXdCIUttHQZ2n8jtft7H83zDkxpihq5gT+g7L/EHuNIEcbbfC257ouOp8+6Cy
 oO8PvtfaaFJ3oQbTGShTaswzCWFqslwIdTW032Q9+f5w/j3cIpLwDLDtBmdUJjMUMOl7Bmaj8iz
 cAxxOWcjpaSD7lgIjLpjo5ne+IB9liQ8e+znqggitR3XlbX2vGACqyEauAWAWy6SH63FjwQyX09
 4NIExugCNHDikqK4wVwHlWfP5NcySh+/t1cPetuoi62YhbChnFqRSyE0ho2qoALwrnPM332p07d
 sbyTmqvDNbUlllCPF69+730qbquQv9rjd8dPl/o+E0PEPlap8qxhgXLKqtmUheU3jJtTsyveomA
 6rJOzhbI=
X-Received: by 2002:a17:907:9615:b0:b98:6984:6627 with SMTP id
 a640c23a62f3a-b9d729c0986mr635516166b.40.1776066849676; Mon, 13 Apr 2026
 00:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
 <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com>
 <adygIkRhnsGv-LwM@stanley.mountain>
In-Reply-To: <adygIkRhnsGv-LwM@stanley.mountain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:53:32 +0300
X-Gm-Features: AQROBzCmapfAP5XxJL0BZHSYMWhRjgPMxX-DCGpXJHZVAmXSTow49ekBVs85ec0
Message-ID: <CAHp75VcZU21syEY7rx9BsvckKq-Tic259xPghetPad-gY7kDng@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Use %pe format specifier for error
 pointers
To: Dan Carpenter <error27@gmail.com>
Cc: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>,
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Mon, Apr 13, 2026 at 10:49=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
> On Mon, Apr 13, 2026 at 10:03:58AM +0300, Andy Shevchenko wrote:
> > On Sun, Apr 12, 2026 at 5:46=E2=80=AFPM Mahad Ibrahim
> > <mahad.ibrahim.dev@gmail.com> wrote:

...

> I always like these changes.  I wish that there were an equivalent
> %e which printed error codes that weren't stored in an error pointer.
>
> KTODO: introduce a %e type format thing which prints error codes

Never happens until it becomes a C standard.


--=20
With Best Regards,
Andy Shevchenko
