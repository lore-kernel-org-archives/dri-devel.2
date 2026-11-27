Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF30606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=il1O+dG9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073DA10E57E;
	Fri, 27 Nov 2026 15:00:58 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D0410E57E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:00:51 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso17418465eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795791651; cv=none;
 d=google.com; s=arc-20260327;
 b=Jeyq3NHOaUhklDi3qviNFqc7NspWEcBynHUKbe807ki0Du5mNIwa5/bC/EVLkcISIV
 vvDadwY3F/UIsNI1qi8EU9lTsv9CGZJkXAxACjaqh35YvFUmNR86fqLXv5XOWNIP+SGm
 vVKnZtDGW0QH0zygQ92ZT5hypdRtYEO3ETN0MA3QdsIVl6b4wTda60gVKq7qAdMQx0gy
 crScDru6zsv+VBUCddY98X5X7LKPd6tzPVYIFwew+BiWbx/nYc6Kh1fzjRLMYroE7etg
 nHHUa6nG12cJ+lDLANswwHbhx1bctaOIrUI04QyqAK39zhj3u+snZyX0KVKo400zltP/
 qg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+iPChri7biYpij+YOdee2tTIQuLdmD1pLVPBNubI3N4=;
 fh=BBWELCHgWK8QrSXOHik939dkLu8Dvsr9jl5o7piuE3k=;
 b=MqFu1dgmuKkILbVr0CWHQwsqxS+Qr8HvXJ1hGShpBixfQ8eUpHgWXS3Ku5KHM4Qk4v
 2CVJWbHPNDIBRa2TT0XhZ86Z3/44j01KTS8e0UR2dtjBla8H8/lHOpt1QnvCeVjIGs6X
 DgmZUTeAURSzPdDEsJ/m2lQPED/Jei5OZXF+vlIrRbUym3RAKwcBnb50jt0yTKMtUJnO
 Aqn5tD/go3JtRhQ5VH3B2RmdW713/+PaDe0nIdazkZlyrNpIkmRmuuJQVN+W3CK23wfD
 qL4Jbx79Ryid4H07ZO+l33VTdpsuLU1M4US7+Ac71/KLNxNGNpCwD22j6pqugSqqhW6d
 tqyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795791651; x=1796396451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+iPChri7biYpij+YOdee2tTIQuLdmD1pLVPBNubI3N4=;
 b=il1O+dG9Xwl1iwsc4eikjZT03zWnCaOh+hLq/qi5z2r+M1OJsntsd3gcaCDrls2kCG
 JPBy5eFxSBcyXHelcq5akGk5Y+Tpb1iQ1Oj567DiZfD3FgMX4v4osqkMmspggbKYohY3
 gud1KnnKGzoBqbgZqc6XqTiqJO8xMgzRyEhnCYoVc+4wayoZ8PGft6pLabmV1K6uR9Fw
 semGcCzw6SQZlT1CB9/d8ibxpu5x+zyBWVprT9OwdfS5w4/Pl5/appQ2cNVUOzWDpV3t
 QW++caewnJ3eA5zrzkpxJyxOj6krbgE1fW7CJAGM8F12pJEQj7mcWW0y9h6Y6vhuqX+g
 ueFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791651; x=1796396451;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+iPChri7biYpij+YOdee2tTIQuLdmD1pLVPBNubI3N4=;
 b=0lsw97LGrYDxphmg1G7oTLQa9AmAWPI1TIoXe+K6BOwoefhORTupM/HSmVrbBYQFXn
 0pxzOGjpsnzM1jLWhgerMglI1mxI91ihOK6pfmsFr02YmtEJIeOjYkpPamqT4Kuq1POn
 AZcJloaScXzwwxQK+5MyfAXtGecC0PQT2MEfZgICZzOdAn3CdViUxmRIKtkmT70y8wWR
 5mH8uPRyNMSmPmd5P+fGp26FEgfgtUOEZOSX9/zFRCQJTJZVbSbHpsR1dXV1WDE3ws1E
 lwApmI7I/570eogVyRxy/ADLw29Xdl2iXlaUGo+r+qWIY+YZS5fJVtkIj6jydpk1ERX1
 NW7A==
X-Forwarded-Encrypted: i=1;
 AL+hErGWzRsZ0wkmlUpP48Yy9EtwaOY3AWK1DeJGBlQ3axBgyFiz3I4ShFnp3eKOaovWAtCsMwZsTDdMjEQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/jjLifcc08moRGtfqoKleJP1NxFgoH42bNPQw8VrjmXdGtGDzD
 uk1bI8RMGEYxINKK8jVu4AehNMKSEF27RzTKhLMZJiV08r1wRCG7K7FNnmVkF/SJDE70atXoO54
 iVn+tMYTTHJ/lTezSWlNX5u6XD6zczd0=
X-Gm-Gg: AZFdTZdd174v31sZA0FJiS/nhInpoIc6/sHgyo/DjRCFyt6qXcTeUuuxkql4tFSdUoK
 cSb3LfZ/nIttoU+Oz1TpgPVtTgaUr4jm92tdBhwLCV844tzb2R0btpKmjIMyTzoi3enmdm8IxyH
 6z3W/9Dw57+aE9n3VGyp5dOoaJWFy5LbkYER1eleRsq1w5UJIKqHC+NsjLcKJBlDZsfuqtsuGe/
 Gj2J3o//jT924Ld2CyD0kbAvnUJnYGyC4x4Bwe9UlYbUhG/s2Ozb4lU0wlmxRWiDsEHouJrhoBj
 1kiVCeGJjKkPlvZ132/jvWIe4XRI8ycvtcyfsdsMH5MfHU1K4URgNBXe8CY+gsxRCPJY+oRY82F
 uCHcdjeSk6kiwrs9qUuCH65TwPSFL0B98Bi5hY8uQUz4OChRnKpYu/3yc2i0xYJqEpmakJRGhDI
 f7Qa/8ksBF9w1YgBwhlC1cmiigAjN+Jg==
X-Received: by 2002:a05:693c:60d4:b0:360:5f7e:2eb9 with SMTP id
 5a478bee46e88-3857111f65amr27118776eec.32.1795791649409; Fri, 27 Nov 2026
 07:00:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115085826.89641-1-clamor95@gmail.com>
 <20261115085826.89641-5-clamor95@gmail.com>
 <20261126114728.GG38590@joneslee-macbookpro.roam.internal>
 <CAPVz0n138PXP88++q4QXiao-7=nzade=e_jAdfKK0_xsEyPtFg@mail.gmail.com>
 <20261126124719.GJ38590@joneslee-macbookpro.roam.internal>
 <CAPVz0n1xgOqusgO23pXzZdaq0A-j0NyX2PvYPyzrzrqUfYM+3Q@mail.gmail.com>
In-Reply-To: <CAPVz0n1xgOqusgO23pXzZdaq0A-j0NyX2PvYPyzrzrqUfYM+3Q@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 17:00:37 +0200
X-Gm-Features: Aa3M54rzV-ViZY9z6DJq1q92HT_iE_h9VqHJH3pyc5wvVXF_KFD3s5My6-b_8Bg
Message-ID: <CAPVz0n3UgNrS1vJnPhbaEFN1rPMyM1eBHHhVt8X+Vq_Lvc8p1w@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:5=
0 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14=
:47 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Thu, 26 Nov 2026, Svyatoslav Ryhel wrote:
> >
> > > =D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 13:47 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
> > > >
> > > > > The AAT2870 supports a dedicated main power supply input alongsid=
e parent
> > > > > power supply for its internal regulators.
> > > > >
> > > > > Add support for retrieving and managing these supply regulators
> > > > > (vin-supply and in-ldo-supply) using the regulator framework to e=
nsure
> > > > > proper power supply dependencies and power-up sequencing.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/mfd/aat2870-core.c            | 5 +++++
> > > > >  drivers/regulator/aat2870-regulator.c | 1 +
> > > >
> > > > Is this a build dep?
> > > >

On the second look, it is a build dependency. Since prev patch
removing platform data changes regulator macro as well. It cannot be
applied independently.
