Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9B606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aVpc+Xpl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D5C882B5;
	Mon, 23 Nov 2026 15:36:54 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9848A10EF0C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:36:48 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-38699cf08dfso3315174eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:36:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448208; cv=none;
 d=google.com; s=arc-20260327;
 b=RAUyvueR7n+zFI9zr/z9mFCY28QpDFiA7ZTROErFDX9VEWBXOnjTCv+WypuAD11joP
 O306KC+TbDU+CpEh4toVyhZwq33GrzlIuLgY0ollaxMK7uJPZQ5Iy5/XVKL3VA09jEmk
 aoaioqpEk5egCZfW2CCLukQlMlb0aKIh0lmvfvFGuiwy0UnKz7vFnN/r5/yp3yBvVKDL
 NTEYazZM7xYY+sM15yL7N0RTZfMSq5VMbwe6pePBQd3mX8KUFrqQBCamHjaavSmtoS1h
 rc+htCIH43Nc7Nig1WtsOVIh/WIscrnBzwrZcz6swmSIbW99JW+BczmQrtADTKKZxaXP
 M4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7pmbTprJSDMNaET1p8KH97keYwTTHp2TnWKNbSbIQnY=;
 fh=A4CCf9/aHW/a/910A0Cpw5MVj/z3ne55inzqrr4LyMI=;
 b=cez7YdgBSzMjxagzph3M+TeHfcWP1hnLa8J3BpQjDPSpYhNQKFMURWSfS4axng7R2N
 iRcJC1FLUyEoHh9pxoMWklLeLACJ1CdP3uoUiioYQVK4NmhVXkgX5yWBmlOO8D2twiT+
 voPmtXXO33E/svZ6WtA3cSRu7L3H7Oqic+tFF35EmRY5AZxFTHZjNV/9Y7vNlQ2utscN
 r39/9knwP1cfgN1Fvrussx3eNwZA97/29qjIvgTgTrLNiNsFbQLDCgNvHBEfCgqGEhEF
 s7SrBMTegrngnhHVoVT3IaV0dHXERpU5RZnrbGi43brqHBlhXC8oD3/70TU5RStdcZy7
 Lxiw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795448208; x=1796053008; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7pmbTprJSDMNaET1p8KH97keYwTTHp2TnWKNbSbIQnY=;
 b=aVpc+XplA5jmWYXeuzHQK5iUOtIELHkMYOYRcALKKLV0X27OBnisBS4Yk0a0vXJNU4
 sMYWzxh6I5Bqceqbqjq5Rgux0ZXzKcI81g/Rfwe2ch7KVF1t8rka+QEQ1Zelq7+bzE5G
 kirnQu9xdDu7t00Ivqj8oCEs5YqO1v+LFRTjhQsAeowkQ/ayTX11z3viIcczR5w04ZB2
 HdmlV0AA0ER/QP4MdjsjD0uy6sPdGTfbHsyb/zQkuu9f07jjoM1QKa13tMIroPdEr9Mq
 2T6pU8YpZHgtVmAkD5k7e/qsQ2iGBuFhamtbzkZe1BMn8iiAB2CV37BUVXp3ODAb2mSt
 dGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448208; x=1796053008;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7pmbTprJSDMNaET1p8KH97keYwTTHp2TnWKNbSbIQnY=;
 b=iNZAGpGFUSfwvhlNyu/LSxTUH57SFrj3wFpxRD27fgTFViuns1hYaeQ1IXUp3FeMq7
 E0d6eE/HA9/ln9XiluIWCKiDgNYDGgWZa2oAvwdDvu3H6I4it6ZHtvkj7J56Y9y/0SSZ
 s0kcW78K+1eFMdv9bO5dv5UxIZATkPmMNr4omLmcGLHri4ofDQt0FsVly8KccEfizkXm
 3YcO7YHNkq1cr375oDZpBfO9rSiDzQFaJ1JfT5TDv3Y4mPKwoL2vduTCxaAXjz/SH2BU
 OZprA7itKsxCLie/uYKmH2qKjcLGKL3IDd9r8gHMNi99WSDOXgrc0opFrXrNQEsoX7bS
 QtNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGgeCq7sKYH0hJlhVz3rBevUXvMw2vhyYWqY/XgPQFl/zzvitYa6ij8pqemidpB8gRoxtDtQlYBeGk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8CYYkkdSU2gF8CMhr7Fm/Qf7Pn7nxnJmsTxARyTnbb8kHPafUd
 ynf/MNKOcWOQjZJhM4oPENk07MkWkRH/FaP9o6fQcXlEtzYyzUOC5BUM5cE4ouaG6k68O+gma8X
 lbhmmwGi5l1jpPazfkf47hBO9OkmjF+4=
X-Gm-Gg: AZFdTZfQKD6ht0tyBbVVA5DVYKLfgqlcYzlCoUXjdEvQfwSywtc4YveoQraftYk9c+N
 +32qbx29DP2XcegmSzQ08rIwlhQvoqLCsbr0b86mepy0R4B5UiBcpTrXdIek4zYh0wD3p/bADdy
 C6YwoK9k3ZZxQBffG4urN/MVBFS1C9kqT+q8PtiZEsnq9r3W5OU5PoAMutyNZnNBRd9GO2O95ok
 MYVBW6AFzTQQqzp8LI/hx9CQtGJ3iF6iMymfhfFszl7GQD7PhV7aE0P+HasuFtvs3CSi3vxCaBd
 ZuzOM7iVMeywyJ2A60fGvnUyq7s53qJ8yWUUatbAYN+oNSFPL0UjYe3p29rNx0hCaMjZHG35wY0
 V2YjEKOi/1CpTja2XUtjBWOp+3dnIMkCuKW1me+IhHu0szhfe9mKToEer8+TduDXJd9ebB+IINr
 QBIxXAjt8Z1z4X7MBpizHUtmhe82VOLIJFwOBkZ+aB7/lSqSEABUY=
X-Received: by 2002:a05:7301:259a:b0:36e:800a:71fe with SMTP id
 5a478bee46e88-3856c4b844cmr11761769eec.1.1795448207689; Mon, 23 Nov 2026
 07:36:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-3-clamor95@gmail.com>
 <20261123145520.GA2412988-robh@kernel.org>
In-Reply-To: <20261123145520.GA2412988-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 23 Nov 2026 17:36:36 +0200
X-Gm-Features: Aa3M54rUDkGOVQLPkkzUTzUHY6vBcwEurritNE5bPXzc3P_S34AV-IYkX1z3J3o
Message-ID: <CAPVz0n1sOsC2N+MWEZXN3DYGBgLicS=+e-q53KjBYcJtLiWXRg@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] dt-bindings: display: tegra: Remove Tegra30
 fallback
To: Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>, Dan Carpenter <error27@gmail.com>, 
 Hungyu Lin <dennylin0707@gmail.com>, Hao-Qun Huang <alvinhuang0603@gmail.com>, 
 Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
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

=D0=BF=D0=BD, 23 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:5=
5 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Nov 13, 2026 at 06:18:11PM +0200, Svyatoslav Ryhel wrote:
> > After further investigation, I have found that Tegra30 requires a sligh=
tly
> > different programming model than Tegra20, the maximum VI clock differs =
by
> > nearly a factor of two. Additionally, Tegra30 does not require the
> > APB_MISC workaround.
>
> If the clock rate is a function of the sensor or input resolution, then
> wouldn't the h/w design prevent that scenario?
>

VI clock rate depends on hardware. If wrong clock is set HW may still
work, but be unstable, which will result in unpredictable behavior.

> Does having the APB_MISC workaround make things not work?

It does work, but my main intention was fixing clocks since Tegra114
does not work properly with 450MHz. That was why I even start digging
into this. APB_MISC workaround remove for tegra30+ is more a side
benefit.

>
> It sounds like things worked or could have worked with only knowledge
> about nvidia,tegra20-vi, so I'm not sure this is really justified as it
> is an ABI change.
>
> >
> > Therefore, remove the fallback compatible and add a dedicated compatibl=
e
> > for Tegra30 VI.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
