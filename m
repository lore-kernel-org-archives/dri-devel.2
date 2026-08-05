Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ED6C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 22:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5111010EBF2;
	Tue,  4 Aug 2026 22:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HFtjdaqA";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F8210EBF2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 22:15:30 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so145009a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 15:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785881728; cv=none;
 d=google.com; s=arc-20260327;
 b=VTWV3tnOEMJbW8l8cuDboj6op3zxIlG9KbfCSaTxFxbAYc+IAI8K5H/uys9YfKxS+L
 WvkO9zMAF3iS2Dhk6KgHGFz4COOwV8V3ATf8gaYB7ILKvtaQRLSREK+Q09g18ZAVeB7N
 FuuWT84HGiN6rCG0CONzO6ZFLfDuC0o7xvhKbP0jA8qRmb3mIug7e3URPl9jAIY45h5R
 69V6jjoG+3Z2n+W4v77dzjg8ML/6E111Ly1ICK6tDKC00h4vynpdW8v1s8qnVozVX5WI
 M69i13xytPTii4LviS+2CdPCIi8/LAaVRAo76urcbXnZmQFHYjk5iEAO4Q3DUzwsI1I5
 Q+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ef3eP2ZfvS4QgihgygcbC4UqPqMKPMjYnWKL4nfyJxQ=;
 fh=s/1uhpoYbsE1Htfux8dk0082eIBYIQlaYHkV8RwcSpI=;
 b=CCwKjAj+za3pqjaEP04hwrPG7u4jvl1nAbQdt90/X4BqLcrSUSKoa1nNrsuDygudBr
 VB/9UxY20UGwt09ovMZ3jurioJJfPc4S3ORGai4YGBw/IRLwDC+d0p7wyntoMyXvfzNg
 9svcTQRROb72SbLhy00v/6C/7N0PVaof1SskgGW0XtmwK2S0AZBrACHkAv51oLkW6UAC
 T42Gn7qepdcAPwz2tA0YfJ1kvVram1aRO92exQaZqWFGx2v38XIO6TjT2HdJhazqSqIe
 UVnfQl8q9Qp1hO+wYW427wbBu6jwQWnM5YhJxodUiWWRTeRj7vZKNWanrTAvt6SeX+md
 5x9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785881728; x=1786486528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ef3eP2ZfvS4QgihgygcbC4UqPqMKPMjYnWKL4nfyJxQ=;
 b=HFtjdaqAWHPIeXmAyI4siVYy1i3ZdQHjerKthV97iSLrc0idgwRNIBaBhTn3n3FUGT
 BfbJh3yqCubBx6LympFL5vMSEGttkCIAIS+Tr4M3A+TGtkgkRx4W+sKJV4UIDO+n1Vuq
 jynFKLsR14vftTk7pjayGAh5ACsEOQ1km3iwGCv+HsjdpRnIt7c7AqGDdjEQ9CbcvGsx
 75n2j4uy2CnyWVQa2K0JKN/jVNNZ5o5dCGNZcbJwJZodJ79rM96Zcugs7vmnN+6sHG9V
 WM/v9T9IiKL8ZM/JF4mga4wp1oVNXRCzt4r+n/DOs+Bcrn4sbbVyO+Ou49CCZMOtvkSc
 YftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785881728; x=1786486528;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ef3eP2ZfvS4QgihgygcbC4UqPqMKPMjYnWKL4nfyJxQ=;
 b=YlN83r34mcbapfUp2AS+CaAG5DBBAl7nAm3nIfwuAC9JEW9JK7C3BdkzwNXxop+EUs
 muHUhF+AUe9ZFpmvI5uvSkNgKtpw4WAwkIYscD3yqmDFa6IuPC5bqPXTKKxSr4a8W3jW
 b9ULQkLq8+1FO9ypOTSCObC4baR9PVzZdRaCBWz5xlPDxZLI3KzU04yGbOgJslrUV+EG
 2FPbwTXXzQC0agHZDsyj9V3sGBySHkKHgDFMGH1WNRt/Q+NUUEEzv4RREmwS4zwbqmDy
 YjsYRsgdKn1UPWyTDeoBfbjbSpMw9KogeS1ebr60mi0aGb1ennRCm9Wc8MbT+L22Wt7v
 WohQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpG6k+yu8gO9FWEWLk59oGSvBOJq3hoU1LnWPB9GAe71d7EZv5/qMIQePYSxva069DIqkRlmB6ClFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5D/PjSLYiPtta5C9r9V/cYzLesECjqwh30PQiRBeKz83Mz0pw
 /68zQ0YCDQxvNuZCBsLTIU+L8hk9Twr8AiqbcJhKtEcq/9aJDZQoXJuGzx361NusOsvvLfOKwQ4
 6NZVA/uwULXl3fHPqbBNCP5FRzB6vUfE=
X-Gm-Gg: AR+sD10DTiEDH7C0iGKrzLEg7ipVKSztChGktC4EfjidspoOITYJO41qCnp2wxJP+xm
 tOYjzu8+JjbV1WKvL5chiWjk3lxIZUNXEVTjSEZVJB//hhs6aGOBhY/i+QzX6um8bWHYyxcjCaY
 dQQOCBbFCygNunq1AfPnlP0gYEfsJFFdTHX6bDmf+ycOCLs1fhPXzomzRtktafmDVgHrUFswh2b
 8vRML5w5I+QXLFQOoqfJsCG3XL601pYWKWv3+lF6WXKQqdjhxdd9sNj7Eauaz14YC6tRi1/CihG
 jFFvlNpXdmWVyBOFbeaGadU98iKvOvVMhCOxwFydJgJb
X-Received: by 2002:a05:6402:448a:b0:69f:b52e:7484 with SMTP id
 4fb4d7f45d1cf-6a14f254d4bmr1202877a12.19.1785881728391; Tue, 04 Aug 2026
 15:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-2-maximpedraza@gmail.com>
 <204c2805-346d-4935-8e2e-1538b79ea995@gmx.de>
In-Reply-To: <204c2805-346d-4935-8e2e-1538b79ea995@gmx.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Wed, 5 Aug 2026 02:15:15 +0200
X-Gm-Features: AUfX_mxQbUNLor7Pu65Fya-T6kupsatV09gVQoaRffyeGIYc9D-fDFpjiNF7eXo
Message-ID: <CAEUXW=E+fcewEHoOan49f9TS4EHq8u3j1+ac0rSYXv+7TiP8ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add a device tree supplied
 boot logo
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

El mar, 4 ago 2026 a las 23:18, Helge Deller (<deller@gmx.de>) escribi=C3=
=B3:
> Instead of adding logo-centered, couldn't use a value of -1 into
> logo-position.x to mark the logo centered in X-Axis (and .y=3D-1 for
> y-axis)?
>
> I don't know if this is better or not though....

It is better, and for one more reason than you give.

The binding as posted says logo-centered centres the logo "overriding
logo-position". That is two properties where one silently wins over the
other, which the schema cannot express and which leaves a device tree
setting both with no defined meaning. Folding it into logo-position
removes the contradiction rather than documenting it.

The per-axis part is not just a tidier spelling either. A boolean can
only centre both axes or neither, so "centred horizontally, at the top"
currently has to be written as logo-centered plus a logo-offset computed
from the logo height. That is impossible for the reserved memory form,
where the height lives in the blob and the device tree does not know it.
With -1 per axis it is just <(-1) 0>.

So v3 drops logo-centered and logo-position becomes an int32-array with
a minimum of -1, where -1 on an axis means centre on that axis and any
other negative value is rejected by the schema.

logo-offset stays, for the same reason the per-axis case needs it: our
own panel is 800x480 with only the bottom 320 rows visible, so the logo
is centred and then displaced, and that displacement cannot be folded
into an absolute position when the logo size comes from the blob.

Thanks, this is a clear simplification.

Max
