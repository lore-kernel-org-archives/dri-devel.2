Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B17BC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7B310EA36;
	Tue,  8 Sep 2026 07:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WV6j5MHZ";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E59C10E028
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 14:48:54 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso448083066b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 07:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788792533; cv=none;
 d=google.com; s=arc-20260327;
 b=itXw2zXVT7NEiaKgBP2fVdAwZko9NcrbqlMDBstOogHvjvETHoJWxszpp23ZDvU3y4
 7SnQOFDFBB8gEVCapCSqfRktvhWnzHxwUdDiIiUQmuPmco2Woj9nkKSvH+0PrGjvd6pe
 gqZt6K9oybc/gCFgsqu31In1FW5Luv8MVOO/nXsE95Se+dde2rl85gaLnZesSV6sFtVM
 gedVb8YVfkO+TRipn3s3mOwxMv5m8EE4TJF8JSgWAI4BcM6iw7DPFjhvzqJ/5AeL2c22
 1bCPnE8d0oxhYw0v3MCr8LP5X6aR+nlm+GQtQ/3umkxvp2Nnmyla0d45lPbNAqFOY+Po
 oE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=OQ7lVrdGCVQfqjoDQj3oh9/Z+LDJpxNUrYSzk3foVl0=;
 fh=5Z+7GQEuADcP7T5VzGd9q8+xXwaRVcB+RxwA9jFUkJE=;
 b=NbbMz8gMS4z+THPrBE0g5oq4jENxduSbtEFoazUbEY/+G+EkvQ5V5SYW8A4jpRWTL0
 U1y1hIqVNu8pNzBN3OmCd7BsiYMzhl4LEJDYNmidUkUCL6Lar6NfgWqcCzYevZAbzoR/
 HxRFsbHPmf59Qb+Lw/ii0ksVyEOSb4dMIW1nQkNKrEIveilFBQTlN9CiXoZ2trMdDx1n
 j9YsQC1vB3g7TLWSD1/Etqu3VOfTRmiHQDKo8fElOHZO23vWXnqLzdttOVFGz1dfdFml
 qqJCPQBmEn42IiNN/nDpu8jPCulaWox3tUqC98mclcNMbE/afRo7E4cd0hXHw/EbnCmp
 nGNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788792533; x=1789397333; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OQ7lVrdGCVQfqjoDQj3oh9/Z+LDJpxNUrYSzk3foVl0=;
 b=WV6j5MHZvZLVJQDIGrVkBoC9Ui2/GGqJtL4tMZYX0YH1bWPpjtOmWKM1g+WVVxfT4Q
 Y4ADySBRN7hdmis6YBbdqLF6Z0ZaUHPyMkt+/Zt8iKe2jkux1WhdvOIWP9/ub/3HOJlx
 7wL0+0auvdJEkvzjFYNGKGRw5MhVSc0SlaX2GkpJgAyAQKv4meOMeCT/gJRTnPQwN6Zs
 NX6A2oW3gqp1eXOQcRpw3R2fXCp+a3mDop7oVo3Fu+4+xw6WufTN1kO97EmTugbVuYY2
 5o6QVQ5p4cF4xpmx64mgzDYG9ynZvOgqQTZgM9dbr6l8FC8OzrX5YVQ/kMumxbLMPusp
 p4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792533; x=1789397333;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OQ7lVrdGCVQfqjoDQj3oh9/Z+LDJpxNUrYSzk3foVl0=;
 b=DPQCgzo07ffUM1AXstOMhHV9ykrwOU12pGXMG4B8yOc/oH1PvgdUJkpbUDtCHUB0Aa
 FC23DpTh8qWnnHBEQxq1f11QGKoG/xzvcB9038tNQMpB2Vi87+AI+6WU2Khyh9zBg4/D
 +NfagyhvUmzP9TRhPHG1V2YOvOODwBIXGq/LrgXuqJc2W5cYY8wOmOyjzgvv4Nuhi07i
 v2fghGjXWCNmnXF1KPdoH+eB/+aaNY5Ny6yj/BHtGGwprpEmCdYlcTAWPDrR+wQaaMjF
 7++zFVqHUkO2m455NpdXlGEcHRHfh+uL/v90rcEOK47dQRoDbxOocLIo7pbqTD7YpHbg
 ZnmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkf3zWHMIY7GIr8Im5XWV5pTXkt7PsUgTF9yOIyU/YXDRBRoj3xv60V6zdeLFw6BcYePHYclRnm8I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lvqcEIQ9H3DPIM3PjnSNl9OocrKtaOHA1bs/U1T28jhk7lZCIq
 z8PMH24EcKl4UzK7UhQSEEh1RltI4kLKRSJY+9J7Q2hR9fPoqohIKydUQGJpgQbI5sGojZKoMWI
 tBJ+BfgS2sRnLHYHZDjm9wHdbXd50VA==
X-Gm-Gg: AYBFou03LAx4RpCX9nvvaFpzYmKlP2EQEdXJMhmJ0t1okJMPEMROIfJtZ8fvkEKGw5g
 N80DMD+Pxd9CMpDJO9/9z+221ODqsArsom3YTdrkhwiZV/pmoaTq8Aj9g5/1c8DaSM/xmUSxXQC
 5pzr21PAr6hLrRHOyWsUfSPiWs78bK7nlVX5MmtSK1MiRtiOOpC7tzYkDvNXEtp083gX9c4UGIe
 NZNNkhmglgcZcAr4bFxXdl2PHuHcZABPE8m1nsmI9xPDmXsrK7v0MbLhfUIJq1HVft9qyVl01Mg
 AqvLZ78/T6V4Puyc98eWr3qtO79xWhWe7ZVOoTc0tuVMhiQiZ8t7MrGQPErFWR8eiZSbvtCsLkA
 6Zw==
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47b6 with SMTP id
 a640c23a62f3a-c261649567dmr708618466b.44.1788792532708; Mon, 07 Sep 2026
 07:48:52 -0700 (PDT)
MIME-Version: 1.0
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Mon, 7 Sep 2026 11:48:39 -0300
X-Gm-Features: AcwNN1UYGAl9fInNCucS_mKxp2HpZrVX_UzawXxul5SC_lkUXXXY-amPXm2bMTA
Message-ID: <CAJ9xWrJNbB1H6r-bTsTXzhagck2L-Cz0zQczd2Qqbi9-W9oPOA@mail.gmail.com>
Subject: Re: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, dri-devel@lists.freedesktop.org, 
 linux@leemhuis.info
Content-Type: multipart/alternative; boundary="0000000000007d3250065ae5b7af"
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:44 +0000
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

--0000000000007d3250065ae5b7af
Content-Type: text/plain; charset="UTF-8"

#regzbot back in-progress
#regzbot monitor
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

Hi Thorsten, Alex, and Linux Kernel Maintainers,

I am writing to update the status of this regression after checking the
Regzbot tracking dashboard:
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=MMWM=W41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/

The dashboard currently lists this issue as "fizzled out / resolved:
inconclusive", but I want to clarify that this bug is ACTIVE, UNRESOLVED,
and actively tracked. The lack of recent email activity on LKML was due to
ongoing technical data collection on Launchpad and GitLab while awaiting
upstream feedback.

Current Status & Verification:

1. Launchpad Report (#2142389):
   - Status: Confirmed (assigned to maintainer Timo Aaltonen).
   - Heat/Users: 220 Bug Heat points with 44+ explicitly confirmed affected
users across various AMD architectures (Tonga R9 380, Polaris RX 400/500,
and recent Vega APUs).
   - Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389

2. Freedesktop GitLab Issue (#5123):
   - Status: Open.
   - Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

3. Technical Summary:
   - I have executed 3 full git bisect routines on hardware testbenches,
isolating the regression behavior between kernel transitions.
   - Recent user reports confirm the same black screen / no EDID handshake
failure upon resume and DPMS display wake-up across multiple Linux
distributions (Ubuntu, Fedora, Void Linux) and kernel versions (up to
kernel 7.0).

Please re-open and maintain active tracking for this regression on Regzbot.
I remain available to test candidate patches, kernel builds, or debug flags
on physical hardware.

Best regards,
Danilo Machado

--0000000000007d3250065ae5b7af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div>#regzbot back in-progress<br>=
#regzbot monitor <a href=3D"https://bugs.launchpad.net/ubuntu/+source/linux=
/+bug/2142389">https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389=
</a><br>#regzbot monitor <a href=3D"https://gitlab.freedesktop.org/drm/amd/=
-/work_items/5123">https://gitlab.freedesktop.org/drm/amd/-/work_items/5123=
</a><br><br>Hi Thorsten, Alex, and Linux Kernel Maintainers,<br><br>I am wr=
iting to update the status of this regression after checking the Regzbot tr=
acking dashboard:<br><a href=3D"https://linux-regtracking.leemhuis.info/reg=
zbot/regression/lore/CAOnW2VTGBP=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMF=
w@mail.gmail.com/">https://linux-regtracking.leemhuis.info/regzbot/regressi=
on/lore/CAOnW2VTGBP=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.=
com/</a><br><br>The dashboard currently lists this issue as &quot;fizzled o=
ut / resolved: inconclusive&quot;, but I want to clarify that this bug is A=
CTIVE, UNRESOLVED, and actively tracked. The lack of recent email activity =
on LKML was due to ongoing technical data collection on Launchpad and GitLa=
b while awaiting upstream feedback.<br><br>Current Status &amp; Verificatio=
n:<br><br>1. Launchpad Report (#2142389):<br>=C2=A0 =C2=A0- Status: Confirm=
ed (assigned to maintainer Timo Aaltonen).<br>=C2=A0 =C2=A0- Heat/Users: 22=
0 Bug Heat points with 44+ explicitly confirmed affected users across vario=
us AMD architectures (Tonga R9 380, Polaris RX 400/500, and recent Vega APU=
s).<br>=C2=A0 =C2=A0- Link: <a href=3D"https://bugs.launchpad.net/ubuntu/+s=
ource/linux/+bug/2142389">https://bugs.launchpad.net/ubuntu/+source/linux/+=
bug/2142389</a><br><br>2. Freedesktop GitLab Issue (#5123):<br>=C2=A0 =C2=
=A0- Status: Open.<br>=C2=A0 =C2=A0- Link: <a href=3D"https://gitlab.freede=
sktop.org/drm/amd/-/work_items/5123">https://gitlab.freedesktop.org/drm/amd=
/-/work_items/5123</a><br><br>3. Technical Summary:<br>=C2=A0 =C2=A0- I hav=
e executed 3 full git bisect routines on hardware testbenches, isolating th=
e regression behavior between kernel transitions.<br>=C2=A0 =C2=A0- Recent =
user reports confirm the same black screen / no EDID handshake failure upon=
 resume and DPMS display wake-up across multiple Linux distributions (Ubunt=
u, Fedora, Void Linux) and kernel versions (up to kernel 7.0).<br><br>Pleas=
e re-open and maintain active tracking for this regression on Regzbot. I re=
main available to test candidate patches, kernel builds, or debug flags on =
physical hardware.<br><br>Best regards,<br>Danilo Machado</div>

--0000000000007d3250065ae5b7af--
