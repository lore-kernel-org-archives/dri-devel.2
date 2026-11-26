Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBF606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0tw077D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9678410E27B;
	Thu, 26 Nov 2026 12:19:55 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5FD10E27B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:19:49 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-38190551625so13508143eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 04:19:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795695589; cv=none;
 d=google.com; s=arc-20260327;
 b=GnRxblBAOEsDzhTiAUYKjq77Xzt5HkBsmu5Qpj+or7Njq8zApkQ+F2OIu0gMC9kHTV
 hLcUgffSf9xnWOHktEwt//ocUqp/5+kzA7Q3TwWLuLbWEc5sCwKVr4ypOTx6OjEr9Bmo
 gaNy8R2THavFpcp+rQXCN7JvdiDl1DY4vjFOJb6XFgEsv043FnlljkDjGmJwQHuBCgs+
 JWD6PxcJutsawrCLU7x/bz7lMtHKQOiFqCN+78Mk5Gt6o4jR1dFKuoY3hxso5yYemuUC
 xbds2XlFMz1zR6QB57js8L2ZftDXJ26cW+1kq5peh9lJDffiF9g/wnX5DXdnh2wBIcpg
 zhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZYEewzeGbNDfeOmY59g+Qph2DiYQKE8Yfta5ll+tJaY=;
 fh=rUSAo+94mSo8LrSmvZAggwmahmgHSJtUPTIpbWq2nHY=;
 b=gURjcZte6woCs97Pp7UTq39tS/acxQjaHsigPZW8HNBY/r/Q7IL3gDWbdwKgwylwOC
 zKVSFatjQqzlV7PQGYBYO6mkz3q5hO13X6UdeS6qo5MewH4BItDIGOzNq8CXtR16d4LE
 djzAilez38ZdMzK+EEIk/X3/j9uR6WKdLKjJXfuCakF/MAQs4dwu+UtAY/m275mGYqWo
 gRfLI64EesBtfO6uV7EKkDT8ug4LG38DKK0xXF5Vtzf5avTNbqLj68WabarZuWqCHIJg
 058DuI+iBXqoaDFPkKY13r6yQcFn8K1RXXgSRaIRlyytiaevbwJRI7DBY2Ci9oZvLH9Y
 PeAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795695589; x=1796300389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZYEewzeGbNDfeOmY59g+Qph2DiYQKE8Yfta5ll+tJaY=;
 b=t0tw077D4N9CKRByvAw0TUg86djk+kNq6PiTt5Z4e9hkUs/a0kw/W/5sRD11fyCOzw
 nrNebgVo78DX7VaXo8Gzp117aQC02l842HyvtnIIs4Uum+Vsp5s+Jcc0o3S+LaJwb30M
 hVwkBxOWxIVy/JUut0EasFfBE1dTkopQtRuv2/lc9Ip+SGObSS7zpyD/XXpqBAzy842c
 rWrwynRgG7wihavoj8VyetHt9KtO3iimA0hoVzQu3hTQMZqwyLd45Rs1ihMpR7JMfrb6
 g/QuG1Nh7B3/PixvqUvh66x2PZ0CKv/WS1167wirn1BDBKdfmWiEseS0FtWwndJ6luRn
 jRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795695589; x=1796300389;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYEewzeGbNDfeOmY59g+Qph2DiYQKE8Yfta5ll+tJaY=;
 b=lG1iL09w+sbzL25QbRF3jmULfHvNZcVz+dvvZHLqz0AeLvUuMh51dS7/RiRryQiD7g
 1KUIbJML0v3qWFqv5b4+sV3zPPV5iZ/g0KIidUHgLAbPkJk9oE9d+Cuz9zCxvv8VAg9x
 InWgSytSqXo9HbN8fQKyqthSLDbgpQ/q2nwuLgETTc0sFBnjTg+n2OCeMBv+IWgTHodf
 UsmJc4ZN3p7aWQqerjDgKpO8v4/RDQo3DkouGDP/yEl68DW1cvvWgESYkcuf8arWR8oZ
 eWDlujOcf5WQFC81lyVD6Hw1qt6HFOEOfmIF36VDC6KceRCHGLtkueZV5GNDfzYx6KN8
 zvpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFShdXXZof2VDjW5JXyR6BUmFleCZKMn9SNov0Aj8F5+Kn2cueh4zN31WeBQNe7+AMJZ82l3Dzgpp0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z//SDQdfmciK/+2moPjS+XdMtNSsJYM099y9QftQBUn0y/AhawQ
 WD5r7q4E3CQymC2mjkBrsS7gQG93q+FK3aY1xXjy0eEFGXEktHgU5+ootIPUVO5d5TB4Nzxoh08
 pBg8SFmjrZIUSXWUWpOgBtx67GO1WUzw=
X-Gm-Gg: AZFdTZdnX2gWtYBCmmGqFsgtsMeMOIelbPlPK+GL4Cl6gYzWuSScifSe6hsN1VNSw+Y
 meYZfjQAOOMATggsJiXMvaBzr1aZa14W5JZKgOcC8pMeoKocLryEYmd0WlkOvJFCDgQ1sXeK4i3
 ujUMuha1HAsOKUbwkXCX4qqhILf+uhgm9acydYWRBOfxP0VaMmu9cD19cFA2Ju0QLnO2jr0ypbe
 rq+xfoMVWemGt1lbYqiUOs6xblSsqaR23KDjd9rbtzo/PE7i1DXmWSvqew5reAM5jm4i/t353BW
 I3bQeXWQ3a/5TGKoMOsZhBpdpH8BNKWVX3ZoOyyq/nH7n0l9vJBvKgozYaWVegKkDqInCnYkyoX
 V2uw7O6lLOjMftKUxDlccAbnfRpcaUtGJliT9Ml3HVzqDjOo2a3PeHU5LA9Dlw5+h5H/YcC0iWD
 rWwlbtOAoWZtUFBqygC1d3MeNpW3K7Zw==
X-Received: by 2002:a05:693c:895b:10b0:385:cf42:9b98 with SMTP id
 5a478bee46e88-385cf429dcfmr20910606eec.34.1795695589053; Thu, 26 Nov 2026
 04:19:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115085826.89641-1-clamor95@gmail.com>
 <20261115085826.89641-5-clamor95@gmail.com>
 <20261126114728.GG38590@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261126114728.GG38590@joneslee-macbookpro.roam.internal>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 26 Nov 2026 14:19:37 +0200
X-Gm-Features: Aa3M54o45-8oLpV7u0fds3mVX__iIW7iqATGNdrlwb2jFlsQvtadJWGIKMAZpQU
Message-ID: <CAPVz0n138PXP88++q4QXiao-7=nzade=e_jAdfKK0_xsEyPtFg@mail.gmail.com>
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

=D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
7 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
>
> > The AAT2870 supports a dedicated main power supply input alongside pare=
nt
> > power supply for its internal regulators.
> >
> > Add support for retrieving and managing these supply regulators
> > (vin-supply and in-ldo-supply) using the regulator framework to ensure
> > proper power supply dependencies and power-up sequencing.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/mfd/aat2870-core.c            | 5 +++++
> >  drivers/regulator/aat2870-regulator.c | 1 +
>
> Is this a build dep?
>

More a logical link, I can break it but it still will be part of this patch=
 set.

> Would something that was working before, break?
>

Other way, it was broken (aat2870 may have a dedicated supply) and now
it is fixed.
