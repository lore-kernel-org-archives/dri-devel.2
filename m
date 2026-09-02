Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3741C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B194F10F422;
	Thu,  3 Sep 2026 07:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HvvGzC2l";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93BDA10E4DF
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:03:43 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so2532940a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 12:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788375822; cv=none;
 d=google.com; s=arc-20260327;
 b=HMuk+V1uSv2KiXA/B7Hxe05G3WSNxs522EfF6x+csJyrK5Xuxs16bA2etz69bfYkjG
 Vxlp1LNqiHeKcZpaXaeFlXmpms6f4xWjqNy/Db47zuYzkeBH+cwFkVNLgNZYhrLg1o8/
 0i+i8KWyvoza0qVf2aN7d445ZXwTP5yCLiYTkCJhFpTdO0Mp9RiI5MFeecd2J3zE7ON5
 WiZZph4M3KOBKUTw8gHloo1uGG5QqYtAeyKCi4YX+fd4YvYveYbpJhIeNAKloLTaI8fL
 7/+yHtPM93vlv/KkSRyRkKNvzDf4/5kgFLCVWu3CwoLwyjMo2HjULezHLjoSW9qDL0iA
 Blvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CX+aldy4IdlZys9p6WogYj4jfpvnAYxHS8MWawp2ssE=;
 fh=qbq9dy4T08GfQcSf1gv9WVKfivfr7qakPZicDZ1DD+8=;
 b=S6TB98zcIl27Zm9CGsVhiLeVd6wi2K/1b6jVxPCCtq1bo2yg1E+BWDV6GgjvoMfflb
 2w/CpkYlYPvT5pTFj2lGb78kUIA1kVioX2GppJ9zRMu+LKd1c2p1Q/4vvEc7LorlVnPZ
 +YWsS1yfC67JD/ddbgvtGG7Pj9NKbIaIGeuuivWFSV1Q8wGX6ZqZQVrSe9oRe57ei7K7
 S/GNO6LeaiQUAkIHRR2nEoM4Os0+HohK7jv7BYqtFLEAb+2hPlSgYDPJzJv6ICdzijTz
 cuZD08hZelaGIuNZHdpBG+mUmoYpeRkmF+G1K+Rzf+NJ4ntYDigGilAhaisqRyl/jzlx
 6gTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788375822; x=1788980622; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CX+aldy4IdlZys9p6WogYj4jfpvnAYxHS8MWawp2ssE=;
 b=HvvGzC2lsF48aCyczHqDO80fkQZppJpiDFYBs4If/r4pHZ/JMdQpgU7ZERWDqNTmYf
 xJyOO+gHTBOqfQAHvU2aLIAaKbnUawFd/rzwNxEbWlamP8eiCz8YyC3LYnnhGBPj+mWh
 kMwOhv1Sw3DS69Gu7JtoceUBSVEJlsgOKftsYZqscYe6NrspSiYXQzNqiLk4394k/4K5
 fO2vTA3EjxNZ10U4X+LZK4lih7PtM0J9Q/u50EchbPAOxAO+FB1EfNuyOaW5bYHDrltC
 pCHih75hEKtIsSTURrK79YvUKUrfa4/0xRt47hn9+kS+SDk93I2f9glVmhgKgkmk0nwb
 JWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788375822; x=1788980622;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CX+aldy4IdlZys9p6WogYj4jfpvnAYxHS8MWawp2ssE=;
 b=I7n0OtctlVvlBxEyEKAQM9mmZ6Zq/OUivlP92sJQUw4eroBJQK/wpvhuI6SHQ/liXN
 AhTpntCP+ZcjLb56em6zaC8vLPZBpLwkM1MP06VE0Qpj2FQf/vdZCtogvoytWHgrlJCf
 w3RMAp1puuNyAj0GDhnv7H9YfXdKbRRWZEvghTdsCsvOVR4WbwLehQkWgT72mVSJ02Mw
 rjpsdXcf2ovyD9z/2DBPSHPMvF3hyOgFkVXHUlLWwebxdGUsAxO9yvQ8BGxrPRy3Dur4
 tAkgRzl6J2ca93QMcP+KzjmbT6j4NRllsHpM4ig/ObrUwDmiAXWKnZMNSG+na1/WwNIv
 VqVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDap+o0/YsUVnNxJzW9NnYvqzZ78IeVHCU9lmM7K9TpgmRoL8y+QriUXLCZXuOU/kPp9UTwZJWF/o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lpgtRSrdltKA5iDWvqFQ1mCZmPZw5ajTnEVNt5Jbq3uyhsCsvC
 kgwXhKcgJqcmlZB18S2mjVIrPTE45hdNDcOYjxQVMuhmYeVR12+qHKV/NrP6QoHpps6QyMIc0d7
 cf6hZEOmfjQM3fuE299LWQLs0bV5I0W8=
X-Gm-Gg: AYBFou1Uq+iyebrM6C0vIViw9MUlPsBCaztmEVeP0RlCQblpy9fL2/cWor2Ocd+Pt2+
 NRLVO9BVoC5FRcgcdrZmMkYfOf3FeY+Xx/arOzIR9ElZjbVuh9koGPMs+ZOzPaVBdSddLDu41gL
 AIE2x+5la1bG2716NYmjoxexQWPrJrQ8WFh41MVJNANxznObmiU0jog/pIqqiIRixYRBU9pcczr
 sUst5/AWKHikH4qMn2GeE10VRZuqMF7OuxPl87PcxrORbnQvIFuj+UGxPCe4zn3vOV/cXKclq6I
 dAK9kcDgyQCZh5+Ka7Mil8RUYKYu+Uv4syg1kkqFCswbMi/D6F1KEv+0WHQJEu901TxRC8jkv9y
 4m5QkMD3ub0nfkg==
X-Received: by 2002:a17:907:843:b0:c25:61f4:b478 with SMTP id
 a640c23a62f3a-c25d54a4f3emr439123466b.15.1788375821722; Wed, 02 Sep 2026
 12:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
 <87wlt3vnzp.fsf@yellow.woof>
In-Reply-To: <87wlt3vnzp.fsf@yellow.woof>
From: Anshika Jain <anshikajain196872@gmail.com>
Date: Thu, 3 Sep 2026 00:33:29 +0530
X-Gm-Features: AcwNN1VPiJnAnPtX1QcY3v4RvnOgG8dbrU5MBNssOwJTqprQep0ooDAz4Axm4ig
Message-ID: <CABj3sPEMo3B9B0ynfLGD=NmMu+0zpZ_Ydf2yyT7NDaT3DDNq=A@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
To: Nam Cao <namcao@linutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashiko-bot@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev
Content-Type: multipart/alternative; boundary="000000000000942af2065a84b11c"
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

--000000000000942af2065a84b11c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, I take that back.

I said two negative values next to each other could make len equal to zero.
I checked again, and that can't actually happen in either place that calls
this code.

In the first place: there's a check just before the loop starts. If the
next value is negative, the function stops right away and never reaches the
loop. So the loop always has at least one real value to read.In the second
place: the code clears part of the number right before checking it. That
clearing always makes the check pass on the first try. So this loop also
always runs at least once.

So you're right =E2=80=94 len can't actually reach zero through any existin=
g code
today. This isn't a bug that's currently happening.

What's still true: the macro itself has no check for len <=3D 0. It only
stays safe because both callers happen to prevent it from ever reaching
zero. If either caller changes in the future, or a new caller is added
without the same care, it would break.

I'd like to keep this as a small safety check for the future, not as a fix
for a bug happening today. If you think that's not worth adding, I'm fine
dropping the patch.

Thanks for pushing on this =E2=80=94 I should have checked both callers ful=
ly
before saying it was already happening.

On Wed, 2 Sept 2026 at 17:55, Nam Cao <namcao@linutronix.de> wrote:

> Anshika Jain <anshikajain196872@gmail.com> writes:
> > This is a latent bug: nothing in the current code prevents
> > two adjacent negative values in an init_sequence from producing len=3D0=
,
>
> Can you elaborate what you mean by "two adjacent negative values in an
> init_sequence from producing len=3D0"? How is it possible that negative
> values in the init sequence causing len to be zero?
>
> > and there is no guarantee future or out-of-tree panel definitions
> > won't do so.
>
> Basic testing of future drivers would prevent such bug. It is not on any
> rarely-executed code path.
>
> Nam
>

--000000000000942af2065a84b11c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr">You&#39;re right, I take that back.</p>
<p dir=3D"ltr">I said two negative values next to each other could make <co=
de>len</code> equal to zero. I checked again, and that can&#39;t actually h=
appen in either place that calls this code.</p><p dir=3D"ltr"><span style=
=3D"background-color:transparent">In the first place: there&#39;s a check j=
ust before the loop starts. If the next value is negative, the function sto=
ps right away and never reaches the loop. So the loop always has at least o=
ne real value to read.I</span><span style=3D"background-color:transparent">=
n the second place: the code clears part of the number right before checkin=
g it. That clearing always makes the check pass on the first try. So this l=
oop also always runs at least once.</span></p>
<p dir=3D"ltr">So you&#39;re right =E2=80=94 <code>len</code> can&#39;t act=
ually reach zero through any existing code today. This isn&#39;t a bug that=
&#39;s currently happening.</p>
<p dir=3D"ltr">What&#39;s still true: the macro itself has no check for <co=
de>len &lt;=3D 0</code>. It only stays safe because both callers happen to =
prevent it from ever reaching zero. If either caller changes in the future,=
 or a new caller is added without the same care, it would break.</p>
<p dir=3D"ltr">I&#39;d like to keep this as a small safety check for the fu=
ture, not as a fix for a bug happening today. If you think that&#39;s not w=
orth adding, I&#39;m fine dropping the patch.</p>
<p dir=3D"ltr">Thanks for pushing on this =E2=80=94 I should have checked b=
oth callers fully before saying it was already happening.</p></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Wed, 2 Sept 2026 at 17:55, Nam Cao &lt;<a href=3D"mailto:namcao@=
linutronix.de">namcao@linutronix.de</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Anshika Jain &lt;<a href=3D"mailto:anshi=
kajain196872@gmail.com" target=3D"_blank">anshikajain196872@gmail.com</a>&g=
t; writes:<br>
&gt; This is a latent bug: nothing in the current code prevents<br>
&gt; two adjacent negative values in an init_sequence from producing len=3D=
0,<br>
<br>
Can you elaborate what you mean by &quot;two adjacent negative values in an=
<br>
init_sequence from producing len=3D0&quot;? How is it possible that negativ=
e<br>
values in the init sequence causing len to be zero?<br>
<br>
&gt; and there is no guarantee future or out-of-tree panel definitions<br>
&gt; won&#39;t do so.<br>
<br>
Basic testing of future drivers would prevent such bug. It is not on any<br=
>
rarely-executed code path.<br>
<br>
Nam<br>
</blockquote></div>

--000000000000942af2065a84b11c--
