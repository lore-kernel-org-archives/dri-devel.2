Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA321C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44FAA10EAC7;
	Tue, 11 Aug 2026 08:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AtSjWI1X";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B9610EAC7
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:04:20 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5b01910b499so633579e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786435459; cv=none;
 d=google.com; s=arc-20260327;
 b=lEOvqRhOxI+IjH8jh4Dsn4q3PCvjBgHZbhC0PfMCfXJzYLLyos8V5XBxPSd2Hk3Bda
 R5NEznAKsXhot/05ayyvFdu/BCwvXgKLbSUerMffZJPT7su120ks0pcUcH/0SMf3cb/J
 0u5ycfRoctOq7lI7yzxCdT9Codmv8BsSLuHTxUgS7S9DlxJyRIPCErePZh2GJlP0hPUL
 mOgzDVrVffc247pX/urS1kw3ZgQPiZ/ODPeeisXs3BhB5R5NDova0oFAckqO4trjGfWv
 jtvBud1Uj89mWb+AqMj8YSISZ+92FaoWVA1475JDSlSKazydpcfMsmEy8/cj1iWYhHzB
 ybug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eD2VIkq4zaZTjNLqo1OszCP1hmPdXu0NsEJWpsPsgXs=;
 fh=T0Di0OIQtKN2Jy2HJaiCSh4pkKOz1gwjS3SDM7fMoNk=;
 b=rySRvRm38MI6sKzfXS01LfWiZtkyMHp2gNYFbr/ROTWHEBsm2V0pJ8CuMTGjHUH9O9
 dNECL+Bm2hf1uk1eEVHai3BuQPRqTMUpgHSIqBzP7j/ZudI+JvMn6CyaokFhrpVKAVcX
 Ko0IVShrnl0gMRMPIsImQvHVvr4AVy4li7VDM/1t6P8EX/IxJHms3OgFbDjeFd8Je2bT
 9iyqV5y3zUaT3tTEqlgwjMdZoUYLuVQrP/ClhmQxG+51N/uqWbGO0VU4xi+DWVsv3nTW
 lRGp257oeGSdw1gH07XtfefLOE1Dh4lod9M7wi9wnVGOLrPRe9FROkIMjDme+p873V7m
 7o/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786435459; x=1787040259; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eD2VIkq4zaZTjNLqo1OszCP1hmPdXu0NsEJWpsPsgXs=;
 b=AtSjWI1XqGLGoh6SQqsP0ETJ/y8qkd+sYDWWBM3L2bL4E3MmxEPyGEe62SykYZfYfL
 0dEHjmbR3xf/8VHoVgxxKNy4GWwJRF94dWT0oI5JCeo9XCdJif82tRomyJMda0DVvP+s
 eg3rGCdidiVg3M1kKHoleHgM2Apmz0d7QwwBEXw4rsOKlbQGcqFO4gzMw5OVsMyutv/B
 /jQbxYuZ5cXTxSNGFDh/rufY6YvLzdLVIFZCR3flqKzN8dGHiU39I4k1HXzflgGM8rqG
 073Qv2YDSGfSTRh72AG9YrDf1IWAQ+oZBPJp1l5lXg2XBiskXCwZ+vNySYi0csPyiprc
 HJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786435459; x=1787040259;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eD2VIkq4zaZTjNLqo1OszCP1hmPdXu0NsEJWpsPsgXs=;
 b=dg7vVL+2pbjQQhYs1c1BSjEJ3qxTgS5xWdlZiJZV0x+snY/rQBJiBkmAX5JawgdFEP
 8G8JbPwXGmuFlcKd7nLmw8uNc9FebDuA7jkm4gYt95pklErDNzxsqsU7i9QSbMHBixCQ
 AMdJtIMwjhQXzg5fKsKVfSBpCY9UgwNqmLdZH2cdIldR6lPbFIbmAAQOAD+RE4xmUHxg
 rBNU3591xTHR10qx2Rs1ir93hN01TUkheuPtCdtiu/z/JHSFkMdlSl6xnyCXKtoLK4jg
 UHN6HYz93wDBZ0w1GEb+pf80s/5OY9G5QdJ7oS2pmRhfrIB7dSG+htMVSEpqkVN/UvLH
 qvxQ==
X-Gm-Message-State: AOJu0YxKHfrYfzWIjZGM8Z/HI0h2OgmLqcJ7kUT6WNIqYT8T/JpWSN/O
 3ZsL+GLlpeWExrBm2nO94b/ivN8eG1m/JuzOxxmeblHcSaClhcctN3BLT0hmKrBRXlzcl4Xgh5n
 64P94rtfqVCUnjuyOpr9MZBO/9Az5cIzJOldk
X-Gm-Gg: AR+sD11jAwHkmcPIA+t1W5EGvnXrk7q0bbEYgEDP1/7sxfQ6EXuGDUAAj1PmzSdIIJV
 2mGxJzugmT2UXYKWvlah7uMpeYSrXIvoPxn0ATmHqN+b8SJjBGAtLFL+BlnAAwh4HllBBY02qqv
 R+DMSeLHsJAI5zxk1QifnewIaSA9VW173kOJc8YMnwSxoyxoBo4tP5lJkOwFgsLF9Kema3oS4qO
 BePRAYAgh2VZ7reZ0OrxZymI3/mrVKTwhqbUSVSUjODpYXHxWn6kryRYStQEOuxyNEpOPeDp2Na
 /T1H2x1rGG5mqZ7herPvyb+DKWQfy6t6XkegIHgvqlRgFx39yebon8bpenqyOJX9KuXB4sfuti/
 AcLarU5ijW2w8PnQD570YE9Ahv8cwR+azFYwPgNgQ0eBcczKdEILm1b5kxxmcXrMZ5wp4FSrIvp
 vPKixW+eYIjNHiWWdkX5Y=
X-Received: by 2002:a05:6512:3c97:b0:5ae:aea9:63ef with SMTP id
 2adb3069b0e04-5b44884624emr255678e87.12.1786435458791; Tue, 11 Aug 2026
 01:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
 <20260730173643.256052-2-kieweg.leander@gmail.com>
 <20260731-petrel-of-fascinating-finesse-cd10ae@quoll>
 <CAMwcS0hupV50NEOX1Fsi_tzRYXBecaummjAm=CFHO7xOT1uUXw@mail.gmail.com>
 <c5f760db-2235-44c1-899c-b6ac023b3233@kernel.org>
 <CAMwcS0jTwpigztHBTLv_sgFNLK0ERHDMzMGsBdi7josLHw56-g@mail.gmail.com>
 <f3fbdc3b-6ae8-422f-a161-8936ffd82abb@kernel.org>
In-Reply-To: <f3fbdc3b-6ae8-422f-a161-8936ffd82abb@kernel.org>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Tue, 11 Aug 2026 10:04:08 +0200
X-Gm-Features: AUfX_mzY0t4wemhPgOUxlfJ8wfsNV4rlS_YyzWedW4MFJlppAsBpsn_nNSHUWaw
Message-ID: <CAMwcS0ij5Bof_S=aaynAnvY=WANqvvsDR0Zs03_2qXEP8yfuJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add GlandaGPU binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: multipart/alternative; boundary="000000000000ef80840658c0ea20"
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

--000000000000ef80840658c0ea20
Content-Type: text/plain; charset="UTF-8"

> I am fine with small projects, till we do not have surge of them because
> anyone clones some project and vibe-codes new soft-core.
>
> Projects run on your personal github, without any organization, do not
> get their own vendor prefix. Why? Because then you come with another
> project and want one more prefix... Personal vendor prefix would be
> fine, but different thing: this repo for your design was created a few
> months ago, with one contributor and ~70 commits. This means it is very
> new, without users.

Makes sense. I'll go with a personal vendor prefix instead, e.g.
"kieweg,gpu-1.0". I'd reuse that for any future project instead of
asking for a new prefix.

> What is the benefit of having it in Linux kernel for the community? Who
> needs this, outside of you?

Honestly, no one, probably. I built this because I wanted to learn,
not because anyone was asking for it. I actually asked about this
exact concern during the RFC review, whether being a hobby/non
commercial project could be a dealbreaker for mainline. Thomas
Zimmermann's reply at the time was:

  We already have a driver for a RasPi-based USB display that
  someone made in their spare time. So being a hobbyist project is
  not a problem per se.

I don't want to pretend there's a bigger community need than there
actually is. If that's not enough for mainline, I understand.

Best regards,
Leander

--000000000000ef80840658c0ea20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">&gt; I am fine with small projects, till we do not have s=
urge of them because<br>
&gt; anyone clones some project and vibe-codes new soft-core.<br>
&gt;<br>
&gt; Projects run on your personal github, without any organization, do not=
<br>
&gt; get their own vendor prefix. Why? Because then you come with another<b=
r>
&gt; project and want one more prefix... Personal vendor prefix would be<br=
>
&gt; fine, but different thing: this repo for your design was created a few=
<br>
&gt; months ago, with one contributor and ~70 commits. This means it is ver=
y<br>
&gt; new, without users.<br>
<br>
Makes sense. I&#39;ll go with a personal vendor prefix instead, e.g.<br>
&quot;kieweg,gpu-1.0&quot;. I&#39;d reuse that for any future project inste=
ad of<br>
asking for a new prefix.<br>
<br>
&gt; What is the benefit of having it in Linux kernel for the community? Wh=
o<br>
&gt; needs this, outside of you?<br>
<br>
Honestly, no one, probably. I built this because I wanted to learn,<br>
not because anyone was asking for it. I actually asked about this<br>
exact concern during the RFC review, whether being a hobby/non<br>
commercial project could be a dealbreaker for mainline. Thomas<br>
Zimmermann&#39;s reply at the time was:<br>
<br>
=C2=A0 We already have a driver for a RasPi-based USB display that<br>
=C2=A0 someone made in their spare time. So being a hobbyist project is<br>
=C2=A0 not a problem per se.<br>
<br>
I don&#39;t want to pretend there&#39;s a bigger community need than there<=
br>
actually is. If that&#39;s not enough for mainline, I understand.<br>
<br>
Best regards,<br>
Leander<br></div>

--000000000000ef80840658c0ea20--
