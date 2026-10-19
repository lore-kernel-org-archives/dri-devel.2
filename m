Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CD606DA72
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B0QpsPf3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E27110EEB3;
	Mon, 19 Oct 2026 16:07:33 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7737D10E111
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:07:26 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3514b90bb89so5872185eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426046; cv=none;
 d=google.com; s=arc-20260327;
 b=OdaRKEax9uu8d4MJoIIUf81SeB7dWt04F/GMYP/yIP+MVARBTGSfEpSEcPu7/H4njH
 j+2vsfV6s1A9g1itMPfGaqSjr390/8+yJpxiMRaYPjzGp7a7C/VB644xy9ZbEkvqJyu8
 9h59RSd+6iir8msMh3iqQZq4ePBhxbJqzlwV+f3xR3Ly+HqA+mZNwzUdG/aoHtSIJDJq
 A1izzfTufq079F4y5WCzzHgGwJ9/A/99iNBzmPAvVHDiP6Gd+LFZh3TKTamxORvhkk/g
 spMvXTjHBtUt1icFVTMQboLNmmSEnuHGaiGviniHLse1Y3fxBk/qkTIJZxAO/wGdXpfk
 ZBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pp1wXmjGVdO0km/o46/fcmdmsHRC4xyRzbLPpnmcTsc=;
 fh=xcTSarzP/UxfTexgfjdv11UJu/MTYhNUnpXAtouyuyY=;
 b=GhsJdlnvEa3RpNNlUWLZbr5SAP1++wZ4uOSA6SvtCaqTTsQaJzqKLISL17V1M4Nnpi
 XxgtqdQPcDmfeKIp9bzvApGdN4jY9dPBDFJS/n/eSTN8SV2efqQxDY94IDPdm3cO2Xx6
 1ki9I4TJzvGBUu28IR2Paf3iK1bsLoVL4Hk8hHqQqAIopmWVRuFHtk35OvLpuOWouNhe
 TUd7s+xWia3VA/ruAGJABicQQkjIam4qDofbx6nkfyRGtcyDSHEoVcb9+hrj44LHLZ9b
 iAL+9img89WK05cGxYygu/hArMKamuaqDzLVPTD377iP0vzUXHMzLFUREYEEen5mfu8w
 wuKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792426046; x=1793030846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pp1wXmjGVdO0km/o46/fcmdmsHRC4xyRzbLPpnmcTsc=;
 b=B0QpsPf3Vgm2EIlBXdWrhJjWmfj8X/qfYQ3Xfqv8SkOQqJim1kjnry2H9TpN+o/V83
 14sj00JL1oVJx6pEEWx1whi2oM4icCR2Aph/Jg2biEKIvyF0b45YwT747I8XRozBsO3O
 g7jeXA886njPSj+RFjow68mYAHGzVjiFJef/HmETHFXVUhxZ1HMNvNJSjWVJ/7M7E8cC
 zDSkJ7RpUotYIYnv9Qyb0k3SH3oKA+j9kkcxje8E/Y76maOy5Di34SmRXYeMt/QDCsQN
 UGvQWe1/XAk75V0zSMmO9FZDgwVfaTbwelmgMqr0kpR3SX/tOeToPiIDNSxjrU0PHdB/
 Cyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426046; x=1793030846;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pp1wXmjGVdO0km/o46/fcmdmsHRC4xyRzbLPpnmcTsc=;
 b=GEHnATFqU9d2rxiLPTYHtmnY6Zv+njajN9mt/T/Fu3qx0O8dEG+gHuUFVdnOSLrnGT
 YBeyiyEsEdWZNmrbQvCkCpnszmv9JRtWWmxIbQMVjUSRJScHiJOcHBsRRaqkvbuSC0cH
 UfYefJ2qajAoFmt44cDKX4bsWoBKz1DyeSqLQSSFYHDx37rrQkr5thfBfMrA8GkBwj0I
 5KZk+E3A6qm7edU53YEfFLnyQhcaDtInsbbia7LfIJkJqaoPZ5fuh+HbSaSpPXeW6F1v
 h/yyV1d3EzPiuhEQr6fyLc5gYkKXyaj4OifQPmSgnDrDEtDDCKcodeHn+MAkmoPp8IRH
 9/pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnwAtOIP+mT7B3i8x5DF07ImRfTT6/I6G4gMJkI/UznG+h6jymFkAJW/aKSn2tJmJhqR10KlBALPI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKS4zUEMKrFBK3p8wMnTVrPqcu3jKEqWFgZsYN4g/10ymT90NXn
 GaFC8wITEuuz6NCfG8CaiSd6EPs5IX/1G09hSsWewB3EqrVSJbQn0IYDPZPtPZvq5MjwVXUI5Bk
 ghV17N6dsxlaSYNV4L9EexW3zItihBa8=
X-Gm-Gg: AYBFou2Hs2YaZ18Z+6o4oU7owd2W2DUYtMw/etezpn/ENFkmSeKiZTJHyxLIKzwbxFq
 7tNZuNCyBWIInhP91gJWIYMyEerM7RmyyPeUg5Kea6FZcIM72iPse0F49Khmfed6oW8IhCjW+9C
 eMil30/6SpeUxZrzSJ4BXnugwE5Yo7mLrkqnNWYmmmFBZFYQKasHiAUxg+UUT6R0MACYDQNlokw
 HFZc3RF9YKo5WGx0kPZXv8oplbAolNPTjGz3RW7TJw5dhjOTlEwuf00kd+saULPX4COCi1ZDgvH
 qNmL3t7gcPMHBC/u1suSDyBLrCO908LdkJprjDuVYWEZhim4OtV+v0Vfo/AIHcChCXHLGJa6Doq
 JAzO7ODU7Tbmm
X-Received: by 2002:a05:693c:884f:b0:35d:4e41:d2c2 with SMTP id
 5a478bee46e88-361a2c38d17mr11330019eec.33.1792426045527; Mon, 19 Oct 2026
 09:07:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-2-clamor95@gmail.com>
 <179198322819.839288.5272985130898382430@kernel.org>
 <CAPVz0n08bXQrujADdgQwuLu10JNjOrjBq-zNS6agSBGLLWt0OQ@mail.gmail.com>
 <20261019160202.GE2663669@google.com>
In-Reply-To: <20261019160202.GE2663669@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 19 Oct 2026 19:07:12 +0300
X-Gm-Features: AclHuK9VJmJMQJiC82ERiz5L-8HMq7v4t7pij145Dauw6OWtgiTFIN9w7D539M0
Message-ID: <CAPVz0n2oCKyLKG+pXFw2hAfMTXXSjrwwsFRrhzC24d33LOi-zg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document Skyworks AAT2870
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:0=
2 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
>
> > =D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
17:52 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Wrong subject line.
> > >
> >
> > What do you mean by "Wrong subject line"? Specify.
>
> This is a LEDs patch, but you have incorrectly tagged it as `mfd:`.
> Honestly, I would have thought it would have been obvious, hence the
> lack of further explanation.
>

Uh, yes, I have figured this out already, but thank you for
explanation and patience.

> > > > Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lig=
hting
> > > > Management Unit.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++=
++++
> > > >  1 file changed, 124 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/skyworks=
,aat2870.yaml
> > >
> > > [...]
> > >
> > > --
> > > Lee Jones
>
> --
> Lee Jones
