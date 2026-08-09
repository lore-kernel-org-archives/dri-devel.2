Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE1BC5B567
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0443510E653;
	Mon, 10 Aug 2026 06:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zrwj3oDy";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86F810E05B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:27:15 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso714567b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786253235; cv=none;
 d=google.com; s=arc-20260327;
 b=VEQUm6wRvWPO7xhHoXNmNLIccfErVTIjXHw6pu2lMXjbTC5Q2MQ2LFMz8Howe+4sYd
 7LQzG6prqWvJD5nW0IplFgTf5q7w2Z70y9xGCa0XCfYr3VP6ojjYjSBq7jVNZSL/k5DH
 TIiK5/X4H9UpKAO+1XNlesGxEP0Ei/wJNigaZF/YuOqImPDa8X6zMyGAWVQkA+mDkDnh
 mIC4U89poslbdw+yFCHahRTzzZ4XUEHM9FazJCfRrSKPouMhcI0wkK6u6FEQykG7GvcX
 LnPFg0yVX3Aa3raIDhfkXMmXZKhkgKeP0RqifC8qJwazhNi+D108+Lr2l67SBdXfWJZB
 KGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qp+uXNR368+hJZ/wrvahvTKJvm9irpZPOZXonNCOWu4=;
 fh=zGypzi5s9MrspI7QVaitGrVt0vnbrsR1aomlJmCfzL4=;
 b=V1U5Fgc6ABygp8KV89eOse9xZUr08a7+lR4pXLnzIg7OIhbg9IE6h+egTHXLyKIkwV
 6RuebJ8+z32duIeOyzkvM8j0h1I7qok2ug8Ghecy2YH7XyRST8vXw4M9e4uAW6afdHVW
 9qW4pn6ffwPjIHM7Se/RXnprlZd+5WR7QkfaJ6H76RpypeB/9zqozsljIfGbAZw9G97e
 pVpMjTER5kj1Y7Q+9xf4By2BcevR9y/2086wniR6kM6kwpA2j/yY/+xcqzxNrY8DyFth
 uIj4B4x7D9WQ25C3hXGuTFCuYgZjNwCM9i8N7RKYN2riDQDvLGt4Gr1wyOZ69+gtlc4P
 L1Dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786253235; x=1786858035; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qp+uXNR368+hJZ/wrvahvTKJvm9irpZPOZXonNCOWu4=;
 b=Zrwj3oDyK9DzZtgigDSuxwhr3lBaypz1CL+HnmggCsIzB5SRic2FrJ0KqOtSf2pzdh
 rGJkdLIFTibEWEZ2tk+T3SzVzGYHWF8tKQhA9sZKDqhSLOij+UK+EwYbiAqo/Ienedyw
 mKQ2+/D/P+/XfFN5vcA8B8x+RLTtjWOOQWZPFNcFTORwQDa3OFgjrLyYodehC9jceyO3
 G8VwyeEcFjOPOJH4Yz8jtPTOXkhkGYFSG9Pttbq2Ll3sWC+L4/G4X7+hScS0AK3GCA0y
 ungsW7eTpK9QqErAZp3FGx/uB0I+pcY7IAZamfVwDqWpbU3g7ELptVYsQve5Fo4t5amV
 3tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786253235; x=1786858035;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qp+uXNR368+hJZ/wrvahvTKJvm9irpZPOZXonNCOWu4=;
 b=Urcdh3eBJ6jtS+vxvoAdgMC9+LAEDBrOsPJsjan0js+bsX00E2xgdUmtQM/kzfgKMM
 UGtFQ5yJLY0o5OU4cQX0/QbwJQMD2O24OHlA7HaqPb4LI1bVcSlHvlwMaTySJVsoFuJX
 ZTlIu7eRjMX3ygEjuSMf78d83/gYhoAVJsjMiyIk9wb0+s2zj0lkYSqeFFiU4oND+l81
 Pmp21XCkOzfSZXCz69lyzw7xEEdHknAbM8fdqaMx3B/V9p0wxTrLQI1z4RWvdwsKC+9n
 kz78TzNZ2hzQXvvdmm5TX2bD+cR6u5y129XaGgmzQQ+h5X++ccCBiYyhUT6Yqptj3Hqy
 quIA==
X-Gm-Message-State: AOJu0YynSzO7zqlZ+EEkcOr5Y/qM68qttVdy7aTuK9a1p+CuI+L/Nz4g
 gkGDXEUozzj+RsPql4hrkQVwFu5RG/ZGPecyMrQm3JzIKGgQnQpiqrCHEKE6MNww82x73Fp1IWp
 iyL+WSRBiUK/lmXI28yuSzJS688LcnjRjxg==
X-Gm-Gg: AR+sD11k3q1k0AHpbPzR0AyeP/H7MorvH0iHANu+ccpjJ2lNNiAyo/x3l2O8yJneogo
 xKB1TlrEslTeD+ptKgTbHIjWo98NnulgGm7aLSc6RcV6nMc5PGGudB/Uq2ISTjaGYoiFvQJi48e
 hekTNk26wJkXslyiB9iPqiSlbVrGULmlRxvMwj55evY/Ap0RqolQndDAJviF5djVXIP9KUARJci
 QdqaH5oWY5CdKptmYt7rq2No/3fJSDa6l+zcSwe5UMJBFNZ5DjimLZkQM+3XGO9xTb056Ntdxay
 i5jUuj4AJDzWEJgOhWENoYDuQPMaW7NocNwvTTIp3Wa1EnpAphy93VqycEx8X7suloxZEn8W9ZL
 dVMeRvNxU6i48mRdXJlBae68u3rzyXU/uayD/G2GAq0DUW2tgH/xZpUpUBow=
X-Received: by 2002:a05:6a00:1d8a:b0:842:3c77:5996 with SMTP id
 d2e1a72fcca58-84f6b649de1mr9788943b3a.1.1786253235043; Sat, 08 Aug 2026
 22:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACa-pC0Adw8u5NXCAhZUfrEyO0-kosqJZa8FeFjD7nvGNX1qaQ@mail.gmail.com>
 <CADqY2u7ast+7SbjR_y2CqrNZF7uj4+D64+d81m7yaKjvWQW13A@mail.gmail.com>
In-Reply-To: <CADqY2u7ast+7SbjR_y2CqrNZF7uj4+D64+d81m7yaKjvWQW13A@mail.gmail.com>
From: Parth Kamani <parthvipulkamani@gmail.com>
Date: Sun, 9 Aug 2026 10:57:02 +0530
X-Gm-Features: AUfX_mzNjoR2ys4o2_KhzkUvb7P2AvTspPFenF9FzMej7fK7tbJiOsc6xJEaW9Y
Message-ID: <CACa-pC1YVK4Nq=hzTJ7u_33jh4bBqZ_e9KsSTUZEEJLQsOw8YA@mail.gmail.com>
Subject: Re: Interest in the amdxdna debugfs TODO item
To: Min Ma <mamin506@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000008dbfff0658967da4"
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

--0000000000008dbfff0658967da4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Min,

Thank you for getting back to me and for pointing me in the right direction=
.

I=E2=80=99ll reach out to Lizi and also take a closer look at the amdxna re=
pository
as you suggested. I=E2=80=99m quite interested in continuing with upstream =
work
beyond this particular task, especially since I=E2=80=99m entering the fina=
l phase
of my B.Tech.

I was also hoping to ask for your advice on something slightly broader. I=
=E2=80=99d
really like to spend my final year getting more involved in real-world
development and contributing consistently to a project rather than limiting
myself to coursework. If there are opportunities where I could join as an
intern and contribute over a semester or longer, I=E2=80=99d be very intere=
sted in
exploring them.

I=E2=80=99m open to where that opportunity might be =E2=80=94 whether it is=
 with AMD or
with the team/company you=E2=80=99re currently working with. My main goal i=
s to
find an environment where I can contribute meaningfully, learn from
experienced developers, and gradually take on more responsibility.
Given your experience in this area, I=E2=80=99d really appreciate any advic=
e on how
I should approach this or whom I could get in touch with.

Thanks again for your time and guidance. I really appreciate it.

Best regards,
Parth Kamani
Final-year B.Tech Computer Engineering
K J Somaiya College of Engineering, Mumbai

On Wed, 5 Aug, 2026, 10:32=E2=80=AFam Min Ma, <mamin506@gmail.com> wrote:

> Hi Parth,
>
> Thanks for reaching out.
>
> Yes, adding debugfs support is still an open and wanted item for the
> amdxdna driver. Your plan to keep the patches small and test them against
> mainline is exactly the right approach.
> You might also want to check the amdxdna repo in github. :)
>
> I'm no longer working at AMD. It will be good that contact Lizhi. So that
> you can align with AMD.
>
> Thank you,
> Min Ma
>
>
> On Sun, Aug 2, 2026 at 1:37=E2=80=AFPM Parth Kamani <parthvipulkamani@gma=
il.com>
> wrote:
>
>> Hi Min,
>>
>> I was looking through drivers/accel/amdxdna/TODO and noticed that one
>> item still appears to be open: *add debugfs support*.
>>
>> From the TODO, it seems the direction is already defined, so the work
>> looks more like implementation than design. My plan would be to keep the
>> patch small enough to review in one sitting, run checkpatch --strict,
>> test it against current mainline, and submit it via git send-email.
>>
>> Before I start writing code, though, I wanted to check with you first
>> rather than spend your review time on something based on a wrong
>> assumption. Is this item still wanted, and has anyone already claimed it=
?
>>
>> I'm currently in my final year of B.Tech in Computer Engineering at K J
>> Somaiya College of Engineering, Mumbai (graduating mid-2027), and I have=
 a
>> meaningful amount of time to contribute before graduation. I'd much rath=
er
>> spend that time contributing to a live upstream codebase than working on=
ly
>> on coursework. If this isn't a good first task, I'd really appreciate a
>> suggestion for something more suitable, and I'll happily work on that
>> instead.
>>
>> Thank you for your time, and I look forward to hearing from you.
>>
>> Best regards,
>>
>> Parth Kamani
>> Final-year B.Tech Computer Engineering
>> K J Somaiya College of Engineering, Mumbai
>> Email: parthvipulkamani@gmail.com
>> Phone: +91 9820081318
>> Timezone: IST (UTC+5:30)
>>
>

--0000000000008dbfff0658967da4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Min,<div dir=3D"auto"><br><div dir=3D"auto">Thank you =
for getting back to me and for pointing me in the right direction.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">I=E2=80=99ll reach out to Lizi a=
nd also take a closer look at the amdxna repository as you suggested. I=E2=
=80=99m quite interested in continuing with upstream work beyond this parti=
cular task, especially since I=E2=80=99m entering the final phase of my B.T=
ech.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I was also hoping t=
o ask for your advice on something slightly broader. I=E2=80=99d really lik=
e to spend my final year getting more involved in real-world development an=
d contributing consistently to a project rather than limiting myself to cou=
rsework. If there are opportunities where I could join as an intern and con=
tribute over a semester or longer, I=E2=80=99d be very interested in explor=
ing them.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I=E2=80=99m op=
en to where that opportunity might be =E2=80=94 whether it is with AMD or w=
ith the team/company you=E2=80=99re currently working with. My main goal is=
 to find an environment where I can contribute meaningfully, learn from exp=
erienced developers, and gradually take on more responsibility.</div><div d=
ir=3D"auto">Given your experience in this area, I=E2=80=99d really apprecia=
te any advice on how I should approach this or whom I could get in touch wi=
th.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks again for you=
r time and guidance. I really appreciate it.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Best regards,</div><div dir=3D"auto">Parth Kamani</div=
><div dir=3D"auto">Final-year B.Tech Computer Engineering</div><div dir=3D"=
auto">K J Somaiya College of Engineering, Mumbai</div></div></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, 5 Aug, 2026, 10:32=E2=80=AFam Min Ma, &lt;<a href=3D"mailto:=
mamin506@gmail.com">mamin506@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><div dir=3D"ltr">Hi Parth,<br><br>Thanks for reaching ou=
t.<br><br>Yes, adding debugfs support is still an open and wanted item for =
the amdxdna driver. Your plan to keep the patches small and test them again=
st mainline is exactly the right approach.<br>You might also want to check =
the amdxdna=C2=A0repo in github. :)<br><br>I&#39;m no longer working at AMD=
. It will be good that contact Lizhi. So that you can align=C2=A0with AMD.<=
br><br><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gm=
ail_signature"><div dir=3D"ltr">Thank you,<div>Min Ma</div></div></div></di=
v><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Sun, Aug 2, 2026 at 1:37=E2=80=AFPM Parth Kamani &lt;<a href=3D"ma=
ilto:parthvipulkamani@gmail.com" target=3D"_blank" rel=3D"noreferrer">parth=
vipulkamani@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr"><p>Hi Min,</p><p>I was looking throug=
h <code>drivers/accel/amdxdna/TODO</code> and noticed that one item still a=
ppears to be open: <strong>add debugfs support</strong>.</p><p>From the TOD=
O, it seems the direction is already defined, so the work looks more like i=
mplementation than design. My plan would be to keep the patch small enough =
to review in one sitting, run <code>checkpatch --strict</code>, test it aga=
inst current mainline, and submit it via <code>git send-email</code>.</p><p=
>Before I start writing code, though, I wanted to check with you first rath=
er than spend your review time on something based on a wrong assumption. Is=
 this item still wanted, and has anyone already claimed it?</p><p>I&#39;m c=
urrently in my final year of B.Tech in Computer Engineering at K J Somaiya =
College of Engineering, Mumbai (graduating mid-2027), and I have a meaningf=
ul amount of time to contribute before graduation. I&#39;d much rather spen=
d that time contributing to a live upstream codebase than working only on c=
oursework. If this isn&#39;t a good first task, I&#39;d really appreciate a=
 suggestion for something more suitable, and I&#39;ll happily work on that =
instead.</p><p>Thank you for your time, and I look forward to hearing from =
you.</p><p>Best regards,</p><p>Parth Kamani<br>Final-year B.Tech Computer E=
ngineering<br>K J Somaiya College of Engineering, Mumbai<br>Email: <a href=
=3D"mailto:parthvipulkamani@gmail.com" target=3D"_blank" rel=3D"noreferrer"=
>parthvipulkamani@gmail.com</a><br>Phone: +91 9820081318<br>Timezone: IST (=
UTC+5:30)</p></div>
</blockquote></div>
</blockquote></div>

--0000000000008dbfff0658967da4--
