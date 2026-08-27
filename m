Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32C5C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB6D10E110;
	Thu, 27 Aug 2026 17:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ctRynCWC";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DCA10E110
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 17:48:42 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-836c2907a24so81427b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 10:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852921; cv=none;
 d=google.com; s=arc-20260327;
 b=ZLf0VyhJ0ALDTA7PA7wkoK0BDNzbTvy04vlP+cOY1Ihq3QCDwCBeAokXP85UJoRrC2
 kVsjPecz1kWglR3mKgHw2SRbyNtjfZL5sGEqwF4ATEAKuLG8RoRvdoqH3RmV2GI0Op6P
 BUGISMFlNDoD6cKY7rknKpSYNoDUn7DHtg27PqegglbsD6FKvomjxnDrlTaA9PBNWYTO
 XaN2OlUXWkZCrSAkWa85Jx+zjYbVGTq05hiOrTmFmaAMNc7F8TJANz6AJ5wfKVglst9k
 xMnWhzVSHEUumU7hX0gEmlQ2TCsqUUwu1oLMPV8RLvKqeIXoaa90ruMCnWwRQ0s+Urkj
 FaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eMpyVl6OrfAqJGf1zAX+86w7HRNlanfwOLffIBk4mQs=;
 fh=m6boYDckd8dHZ4P0fAQdKbhT9G/Eqvvr1IT1zSSCgOQ=;
 b=XBlggHGmwir3IiCcSNd8Scq6240R4vxq7S1TL6VE4LNvKw5BIrjH2FxPQN9EZq4ux5
 svmt6YwKOs8I6JatP4/kGqCpcKNxVGdJtSb6W/vxxGGWzB4TvRpwiYQcrXKFcsy7KgQZ
 Xzpjsd7rYxzgJ1vUssWNcqaPzaqcM6TY1q3QA3FxuRqXUmD+lK+cWsZYVM69diICLF9u
 fjbYPSC8AciaOQOxtK0OTUsa3sbJO6dx3tT43yWllYyPo6h/7Wv9AJj1diZ0i/3JKdC9
 51S8DQLLRqEMncYETLgz8GtEzgU1SPqVq2F0QVmDCyqR3Ox/YuU8Nk3C/SLOV4EgqxHG
 xTcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787852921; x=1788457721; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eMpyVl6OrfAqJGf1zAX+86w7HRNlanfwOLffIBk4mQs=;
 b=ctRynCWCch50Fq6iCCt0saOhbzjPsc3+R17gidK1yuZpN+DCuvcVgiT7zNgspwBBps
 j+c7bZitETIQBOsCatAvgVoW6+40pZI8eSg5xGUdacSyz7wXEXnKqBksO6d3QLv0bOIC
 wLYyNiChSawMkNRLSYcMlagz00HbdPR3N63Cm1rggDe0NELHVdTB1vkOXD46C/ryVUxY
 N59ue74Igd7WWXqLRb7al4syQcjGs6e02TliwET3+m747SS8NOHu8v3i5bpXjavgCSlf
 S5xvx4YFSOJjrhuuM1DtDiAB0dPTdXnf5yQoP4wo7pPzuPzY9U1oO8gHxPlZHI5cR2OP
 /ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852921; x=1788457721;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eMpyVl6OrfAqJGf1zAX+86w7HRNlanfwOLffIBk4mQs=;
 b=U+cHzeLuEisT7SI7bkTTjJ0RTtasVCIf0cgccDOTQmD1Vz2b5+W6DhlyY6/UCHCHx0
 UI3pOMRx3vvftNjbVMY9iZ8QhcSD/Afmlc0FqmYCE69CqZlZ5OI6VKOqcGaDPS6qJVy/
 qWgdoRNLuUujzzjlkIPz+aaWzhP9u/uDekWAzC7iHZ9ZAJfuCqgNwTzSvg+fLGtfipUF
 t9QmsmuzpRtQ54KtqjxQl7QHqnIDc+n9TAtvyGNv2UhUd1XdRQQXswfbctLIfh49yO+7
 AeBAUBWbzAFBeQXTNTq5d8QMa9od+3Zvoih0G89y7yReK3ePeGpWZfYRiY+i3tt9LXpU
 qNdw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNPaxzCzcGimOZJkMpmhL55/HxCxf/cnAEQcKKFtvNcDCBk7wuquuidqym12943b6pNQ2v0V0vvlM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLQbtggwy72zU/uXwDZTB6H5KeBbMMhVpNkH5kddEcJ2HM8zUr
 2AZY/xNfTdfyyGcWozppgkdEiSEAF6cYuslLX89QyxgsWyQSi+1byiqYVCeRCD+58xIkalhr+3C
 2Sm3KmFtH0EoywKpPU89J30+x/mi66o8=
X-Gm-Gg: AR+sD12e5TM4L+apwW93NrLt4Tgmf2Yi4PAbmNi2OhAPfrJOtfIZcjoFkesxegNjTVZ
 MRQB2to8cX3PITU1hIUvGalsFUpQUrLtEPrSqhjufNDn9/xxaYQuZeSxMyTro0L5RfmjJAN+gj7
 yda/KPC4vMWeSDnA+REQ8eEdxqc+jrbj203uu/Gr/W+anhyUnTLduoIbZqa+PFp8Yyc8I14ClIo
 lOAVEe6T2YjusqXSU9feEhoMfiSIAGqi5GKeWOCGYxdo6NxRtHYoFhq/ac2bsnP9sB/1Le0VW/J
 NLp4+mhtHZpjyPh+SwvHNvU0XUzqPux+WYLMF6zkYJ6o4Q==
X-Received: by 2002:a05:690c:6f0d:b0:849:3b75:d86c with SMTP id
 00721157ae682-85d6ec138f0mr4877627b3.4.1787852920451; Thu, 27 Aug 2026
 10:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEWPSH7AcRb4uAnhmcL+kk3mQrgqYsQAYR=JQjJdkFGVK4qfHw@mail.gmail.com>
 <20260827014924.254513-1-gahing@gahingwoo.com>
In-Reply-To: <20260827014924.254513-1-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Thu, 27 Aug 2026 19:48:29 +0200
X-Gm-Features: AcwNN1Wc1hJQ8CJkbMykQhUnhteK3tcP5Qo5Zkoyfk_FlEksFY6NgDA-VYWbMf0
Message-ID: <CAEWPSH5_PmfUCEm5O53=32NQjPKMd4vm--Y2R=4ErMoehtt=tA@mail.gmail.com>
Subject: Re: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
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

Hi Jiaxing,

The depthwise finding is the best kind of answer - the axis was
never mine to guess, and 94 models beat any amount of guessing.
Thank you for closing oc =3D 64 as well.

Yes, please send the RESERVED_0 table. A constant that follows the
model series rather than the geometry smells like a toolkit setting,
and the table is the way to corner it.

Looking forward to v10.

Regards,
Igor

On Thu, Aug 27, 2026 at 3:49=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Hi Igor,
>
> Three things: the note you caught, the oc =3D 64 answer I have owed you s=
ince the
> 17th, and your SIZE_E question from the 20th. The last two turned out to =
have
> the same source, and it was sitting on my disk the whole time.
>
> First the note, because you were right and I was wrong about why. send-v9=
.sh
> never passed --notes, so whatever was on the commit could not have reache=
d the
> mail. grep on the patch file I actually sent says
>
>   $ grep -c '^Notes:' rfc-send-v9/v9-0005-*.patch
>   0
>
> so nothing was lost in a rebase and nothing needed recovering; the note i=
s on
> the commit and format-patch --notes emits it. The flag was missing, which=
 is
> exactly what you said. v10's send script regenerates with --notes and the=
n
> refuses to send unless the number of patches carrying a Notes block is ex=
actly
> one. Thank you for saying it before v10 rather than after.
>
> Now oc =3D 64, concretely, as you asked: SIZE_E_2 =3D 1.
>
> The expression, which is what the merge request emits and what I should h=
ave
> sent instead of the sentence about 0x124 and 0x024:
>
>   (DIV_ROUND_UP(oc, FEATURE_ATOMIC_SIZE) & 1) =3D=3D 0 ? 0x80011111 : 0x8=
0011011
>
> At oc =3D 64 that is DIV_ROUND_UP(64, 16) =3D 4, even, so 0x80011111, so
> SIZE_E_2 =3D 1. Your reading of the merge request line was right in every=
 detail.
> The sentence was mine and it named the arms by the wrong predicate, so di=
scard
> it and take the expression. You are also right that we should name the ar=
ms by
> value and by count, so from here: oc =3D 64, 0x80011111, SIZE_E_2 =3D 1.
>
> I did not have to derive that. geom/g_oc64.rknn, compiled at ic 16, 80x80=
,
> k =3D 5, stride 2, oc =3D 64, has DPU 0x4050 =3D 0x80011111, and so do si=
x more at
> oc =3D 64. Two others, pp_oc64 at k =3D 3 stride 1 and pw48x64w56 at ic 4=
8, 56x56,
> k =3D 1, read 0x80021111, which differs only in RESERVED_0 (see below) an=
d has
> SIZE_E_2 =3D 1 as well. Nine vendor models at oc =3D 64 on this disk, all
> SIZE_E_2 =3D 1, across three kernel sizes, both strides, and spatial size=
s from
> 1x1 to 112x112.
>
> Which brings me to your question from the 20th, whether different output
> channel counts would exercise different SIZE_E fields, and whether two sh=
apes
> can rule out one that leans on SIZE_E_1.
>
> I have 94 compiled vendor .rknn on disk from earlier rounds: oc 4 to 1024=
, ic 3
> to 1024, 1x1 to 224x224, k =3D 1, 3 and 5, stride 1 and 2, regular and de=
pthwise.
> Reading DPU 0x4050 out of every one of them and decoding it against
> registers.xml:
>
>   SIZE_E_0   4     in all 94, it never moves
>   SIZE_E_1   0     in all 81 regular models
>              1     in all 13 depthwise models
>   SIZE_E_2   0..1  regular, 0..3 depthwise
>
> So the answer is no, and for a sharper reason than "we have not seen it m=
ove".
> SIZE_E_1's axis is the depthwise flag, not the channel count. No output c=
hannel
> count can be the shape that leans on it, because oc does not select it at=
 all.
> What does is regular against depthwise, and the driver already emits a
> different word entirely on the depthwise path, whose SIZE_E_1 is 1, which=
 is
> the vendor's depthwise value on all thirteen.
>
> That also means my comment in the driver was weaker than the truth. "SIZE=
_E_1
> left at 0 because two shapes is not every shape" was honest, but 0 is wha=
t the
> vendor emits on all 81 regular models, and upstream's 1 is what it emits =
on
> depthwise. It is not an unexplained traced constant, and I have corrected=
 the
> comment to say so.
>
> Your padding reading holds too, taken literally and with the depthwise pa=
dding
> you pointed at. Depthwise pads to 64 output channels, so the last bank ho=
lds
> one to four atoms of 16:
>
>   oc            16  32  48  64  80  96  112  128  256  1024
>   last bank     16  32  48  64  16  32   48   64   64    64
>   atoms in it    1   2   3   4   1   2    3    4    4     4
>   predicted      0   1   2   3   0   1    2    3    3     3
>   observed       0   1   2   3   0   1    2    3    3     3
>
> 13 of 13 depthwise models, ten distinct counts, no exceptions, including =
the
> three the driver's comment says it predicted rather than fitted: 16, 80 a=
nd
> 112. I had been carrying that as (atoms - 1) & 3, which gets the same num=
bers
> and says nothing. Your form is the reason for them.
>
> And while I had all 94 open I scored both candidate readings against the =
81
> regular models:
>
>   parity, DIV_ROUND_UP(oc,16) even    0 wrong of 81
>   modulo, oc % 32 =3D=3D 0                1 wrong of 81
>
> The one point where they disagree in that corpus is ocp56, oc =3D 56, ic =
=3D 64,
> 56x56, k =3D 1, stride 1, and the vendor emits 0x80021111, SIZE_E_2 =3D 1=
, which is
> the parity answer. Every other model has an oc where the two forms agree,=
 which
> is why the original ten point sweep could not choose between them.
>
> That is oc =3D 56 again. The board picked out a different model at the sa=
me
> count, pw64x56w56, as the one shape that times out under the modulo form.=
 The
> board and the vendor's own compiler arrive at the same discriminating cou=
nt
> from two directions, which is better evidence than either alone and bette=
r than
> I claimed at the time.
>
> One thing I cannot explain, flagged rather than claimed. RESERVED_0 is 34=
 in
> most of the regular models and 66 in a subset of them: 0x80011111 against
> 0x80021111, which inside the field is its bit 5 against its bit 6, both o=
ver a
> constant 2. It does not correlate with oc, ic, spatial size, kernel size =
or
> stride. Both values appear at oc 16, 64 and 128, at k =3D 1, 3 and 5, and=
 at both
> strides. What it does track is which batch of models it came from, which =
makes
> a toolkit setting more likely than a geometry, but I have not established=
 that.
> The driver emits 34 always and the board is correct with it, so this is a=
n open
> thread rather than a defect I know about. Say the word and I will send yo=
u the
> table.
>
> v10 goes out shortly, and I said I would tell you here when it does. It i=
s v9
> plus six tags and the note, with no code change: I diffed every patch bod=
y
> against its v9 counterpart and twelve of thirteen are byte identical, the
> thirteenth differing only by the Notes block. Your two tags are on the pa=
tches
> you sent them for, with the comments as you re-sent them on one line, so =
02/13
> carries "differential base" and 03/13 does not.
>
> And thank you for the differential arm. The run that signalled success wi=
th an
> output buffer that was never written, all 48 channels 0x80 and nothing in=
 the
> log, is the clearest statement of what these two patches close that anyon=
e has
> produced, including me.
>
> Regards,
> Jiaxing
