Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B8C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FBB10E190;
	Tue,  4 Aug 2026 13:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTvTdOSf";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F8310E190
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:59:29 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so4844548a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851968; cv=none;
 d=google.com; s=arc-20260327;
 b=VZp19nbQRvM6I8wfiQ25vWKNJe4orPQLwP+pMoYTATpZNZsZyrEvvahPtW0SQjH0ZO
 p+KI90CXc3RoR+NmJQcfG3FuHzdElumhR4xyinSHvED3u7U4Lsa3oGiTowudYaFEcrCE
 Rvw9/o4iaiTwtK7GwX03D3PQeS+5+BB8vXguglinbThcmgdfcF/OhOKEJ40mLpMscZRN
 oswuQoui4/omC3cZEoNMBNwQi5m51OlPEiPdA+EIi6lDYm7PNrsl0JSvxjBHhtjorR3U
 cEUs3cYVzJgj9aejUEEaMVR68AUaPvCTNW1k3hEogS6bhMy75In3DFx6eAngKdXULJQZ
 EvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=89EaKRTuttPUHq+sVPSA7Zb6zcbSC6P4w6uUi6dNSdA=;
 fh=kNKA7ZKeU/EZ/ENhnfBBxPf8rvaAiYi2qao0p0Y0+F4=;
 b=GF/pq85gz3E3bXSoMDfjfdxfW3yHcprIoFYxirp4JiE+CwsP/8iI9495GH+pRXO7Kq
 /BbN4PjYs+TfSJesqg604bBRpPFJk/qquAaLczNw20/z16a6kaI7ZLpeeSCXmw3JBUix
 pNqU7pF2+HNddpeR5SXbp9Yi9+sONca50wy128JvHY2EYhTQ5XSu1/lEs8JE+BdboyFK
 P8HGdJ5zRLs/igCMwr/5GTKhTF/KZrCKe+512BduzJWazTnUJ3tkba5EgleMNih90Xcv
 gpJs3MZ+ulM9TH/WSAZzhzFDxrBg/jOwU55reAvl/XO+S9snbjuBZkq+hYMyf6GdLPe1
 vrtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785851968; x=1786456768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=89EaKRTuttPUHq+sVPSA7Zb6zcbSC6P4w6uUi6dNSdA=;
 b=hTvTdOSfbdV8j9UfrIRSrrIirPPGsGi5tULa2Myn0LLNC7MEUPYDEPw3JrMn1pXVpO
 EMpcTJnmDLe7N6sj2azq06YHwM7Mz45vRNcoafF0M7HA3EtWx7lQNLrW7t0xg8WrQhwG
 KUcje/kKQyWa6ylk1pmGjCrTxZg5AkmCnLom5gcLKios9CBudlSQYnijy/0dnRfwNPH+
 E3/LJYz3ASeavKj5UKPNr8JLEqD3TUduAKQdwQ2Wu/K+Pio8CKPGhqWDyRva5UTqV0Gd
 rL7Qq24MPnz0GgGC46I4gHBjmMrJ5cn6YQyqxv21RsCALOy4MbjA/TVAS4ogqwyKCUSr
 SR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785851968; x=1786456768;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=89EaKRTuttPUHq+sVPSA7Zb6zcbSC6P4w6uUi6dNSdA=;
 b=Rv1lQpXYFaTy+382jpMLu4KdCQaDcyjWI2qovzcL0fDTWYnOjD4vKEKQOSUr5Eq2/B
 ON8oO/1fS/ZclTMer4Zsn9r4JA3Hw+Mgr67KBECUlhnN7Iepl/iAW0DbD8H2hNhBouJq
 VI2b7Qc0BiJ28dmWvq5MGE8Z3kNuS2Q+eravjODRQpgCT7i4XuTbSITT4580SKhxQkYh
 E+7tF7CqEwrx4fl3hJorGjICxWmMdZ89vJHAM1fchFxZM1YYft5iwUFp22zV6JsIUKTh
 kwZEEd1STJWTNkK1X9B00pLH6DEPR8mmmSuAT8W9siPaF+WqcPFCijyBeb0hbyT8/zAA
 jezA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqa6uR8A+v5PxG+qp92OseCnze4XM47ZBdKovXM6hvtk1FfcO5+EVBBNdPm9bU7hWtW3g7dzOuVhac=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+0NzgudgEMB45NJMYgU0AZvHPvHkHAWIbR5YozF/Q5h17Uh+Q
 b4BqN1rquWFZwlYPnt43gfS0H35qJnFPRRJYnhwqb71PP9ywTE0PMkyoqyuXfrvMD2gB2LVbpHL
 ijB7l8Qk3ANXRjoqq88gRf/3KbEg2vyg=
X-Gm-Gg: AR+sD13inajEoER7CeC9kPbsmfiF3p5D7zJ0PSMvvZMXETfY32+BPiuOvsL7wkmuNQG
 mX7NsV4Z3QNETmVtf0/W+tzL7C9icqnGHyqFnfsoWaKiNHFm3vXrqq2EX25HBxtNAKjNppPa3FX
 cG7lFdbTNW+teTL0yqUllj8OaHv4zqjlLYy4DpRKXdVGJ5nj6bZdWj9Z5xPvDXFtipf7AhpAibA
 U7NUCgBSM/4tRlPNwAtGiBtFbM2mJir8AFQOT7gkjDXxPybk2lbso14Fzpf6Eh/DXoA3VgSUQIZ
 MUl4UdvD3t+fe0sgKdfPHd3FtUtVSJ7slwd3dQj6K5kt
X-Received: by 2002:a05:6402:3209:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a0a7cbcff7mr13543404a12.16.1785851967781; Tue, 04 Aug 2026
 06:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <6rbjbj74zh.fsf@pengutronix.de>
 <CAEUXW=EHD1Y1zHQWE=jFhONM5Hg6TTc_uPYHgp-GS-4YWYJN3A@mail.gmail.com>
 <6r5x1q78yz.fsf@pengutronix.de>
In-Reply-To: <6r5x1q78yz.fsf@pengutronix.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Tue, 4 Aug 2026 17:59:15 +0200
X-Gm-Features: AUfX_mz3aSa6-cw2PyoYrLLjsrQMGpXNCxHpupxxxAIGNK-kmxelTU9OoI4pMZ8
Message-ID: <CAEUXW=FxgN9Zj-1eR2MdxMTyyKTMTUSYHpkcCpuvZKnGYJ-zTA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: =?UTF-8?Q?Ulrich_=C3=96lmann?= <u.oelmann@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 dri-devel@lists.freedesktop.org, kernel@pengutronix.de, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
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

El mar, 4 ago 2026 a las 7:25, Ulrich =C3=96lmann
(<u.oelmann@pengutronix.de>) escribi=C3=B3:
> I think the issue is broader than upstream submissions. Once such a
> device tree is shipped as part of a GPL kernel in a product, the GPL
> obligations already apply to that distribution. Therefore, the licensing
> implications of embedding a proprietary logo are not limited to upstream
> acceptance, they also affect downstream product distributions.

Point taken, thanks for spelling it out. I am not qualified to argue the
legal side and will not try to, but I follow the reasoning.

In practice it reinforces the reserved memory path, which is the one we
ship: there the device tree carries only a phandle and the placement,
and the image stays a separate file with its own licensing, handled like
any other asset in the product.

Max
