Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67832606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pfT/TRA1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED2F10E88B;
	Fri, 30 Oct 2026 09:42:31 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6458710E88B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:42:25 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-3535a54bed9so837673eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793353345; cv=none;
 d=google.com; s=arc-20260327;
 b=n2+Boj1fvSHfYEqR8rzcRP9qtDV2dutHYggKyRUlA/nAespJ36gMbpmCW87Jttijeq
 Yadtl8LVIgcct2Fv+ZpCbSGY64gd2w4rKyozLBr957p0HY6cHSyYipx3P9pDc8YxsE9V
 uDRBpQ2EDJrotKLaGp+NrAClcsVbpqr1sGNCn05ga40OCi8S8IScyXzRey4i4ZPJ2I0H
 avIheMXsLtIPbi5sTGFlJl5rET2RdrHKmBtynqr/EJcorhYZ0hnp66nMajxKRhpaN7K5
 4/c23mQhBxHPDQMyAyR9ULY/0yCpuicooLqehu6VAX8h8//Zi3fMxwKi0tMvYt+QHfDw
 qVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GDGY6UPfJWemExMe2Y2VGpgaiOOBAPyHFBWs4EkVRgc=;
 fh=2VUR4G2JP6rowFX+VCCHswy85naEnw5e5uyqJHsBFs8=;
 b=dfjOsr0Ey+/DSs6EtkSCtrX67fmShzl7LOiHzlaai3O9v+VnEZymR8U06l0njGr6hb
 NjnX8lK7NHkIyLQgLPZLXIBPBCUPcvO2C+F8y7oT9EojnQ8dh5rPoxmH7MJcdq7I8wff
 HGTK35cetNnWHyCcHLot5MaL6vKY5OSPNI/RfP4j8XvxIHh8wRsvnVVHsHErJZqsjhbn
 maNzYLXAuJFZul3AqQj9CgOQsA5XrVOEdi7+Gqynu2ZCwn5HIG3dERfg1oUbrwj6rWt8
 rxXTxvkck7hwB+09Gl5s3ytTS9hENkkAdWgc/uZCODG9ngtEqvcBOGUxrevR4Zi56LUl
 kVzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793353345; x=1793958145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GDGY6UPfJWemExMe2Y2VGpgaiOOBAPyHFBWs4EkVRgc=;
 b=pfT/TRA1Q0TNk1waWpTKTu/feAYEZsX8LcZ45GBw52PeMAo4iWpcHMKlT8O1X21Obo
 b8Cgrrurs3PcKgRjctDhYw0TZYpXflHAIvFVJDSQQ1tJok2KPVhTHFLoF3u0jjuEoLQK
 ViX6wFOZyzsynur4ELVUZAXuChBss4W1I588ObOg2MA8m44qbJK65TtHJrqFj4m15azn
 j54xDnzlbdXXqsIBkGEanaY++w0x3V+eB9R5HMxrLH8fLaOCJqRYBUJE4kR2CuBLj2Yc
 i/NdbkpTOeNZIGl6QRfh6OamU6uB+dR6J99uEGBKavJE98dudZNCAJ6fUEPTvW3kbl69
 2ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793353345; x=1793958145;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GDGY6UPfJWemExMe2Y2VGpgaiOOBAPyHFBWs4EkVRgc=;
 b=Nup3SxiLg1kjM5s9bsk/sESODeZMxVC8Z7jT+1dUaZI0P2WTGOwdaWAbi9fhiw0sp9
 aRnfYSP6+ZmDkzTEIgSe7K9iyBzRdHfnmSjM5TRyZosR8roAWXZ+0zPCB1Mq0rZdQz+C
 jrh5FczsyTmoY9PWKtasLg4hvrpBx5C+pQYJJa24BiaUlXhSLZ0TQi8B6pXpqlECk08r
 VjfC3hSl4QGLIICmks44YHGcbyw5cb9cCRMq7rcvulb9DyBa1pRCkPfE4lbDGYRPvZVN
 K3z3YQz5CNlipColV0VFo8hJMwxX3UPz3hy21bC8JhyrJa36GZuSfQzxQwVlnxIFNe9e
 2CWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoJXmqFuU1abqVIxBSeTpO6PLJFuP86WgRn3Fz/3Rd6Qr7Aax3IPGliW3rLONvz//fYDI/v1/2Ed0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKohiQDs8UueP0fMVq/+A1aFW0BdSbZYf4abYyrESx+8SLxr6R5
 wROBk3lDZm8TpQOiQXkZPOUDa2YCqV3bVjSi4TVWDl1cVvOJHqAVqM3w8ZaHEKSiPIpseg/y3om
 l5MplH1/NUfBVYwHoa4JUhrShxioxReI=
X-Gm-Gg: AYBFou2/DF4Pb/G8cEZ7QfVup+CjpvnCklAISMBHM5uo361qPVSjYWf6sSllCp2YVy8
 k1OKfnu2yg2TpDrPGdPTfA/KdA7UeqCFgOvF/40hQxghfmd/B2NwFJb2YtOMyarWZGp+olnLH/+
 k1kxOrw4VpPKqxJhN+0kAC7i7H4Js99gqb8ojoCDbg5TSOy1J3CkM+DL6WXx8BIwdf07nacI8iq
 SxDRZhUv7ktcSLXL9egloB+OWLYeoqUZDeEVqBrLENyBz0/nqTjMTrIQU9ts3rDr49Sj3MSNi5J
 9OvzWQ1GqXl9MjGjYy/ExVBU5k334xpFQM9kLysg950as6Nfb5sgt3lZ6H66vf6dm6WdrOfpgDC
 Dn1dHlBHF98GuUczHZ38Ma/wIOdVBhpKqP90z6UO3u9WbfEFuHjVsPIM13T5IBoMVNA5FEQ==
X-Received: by 2002:a05:693c:41d9:20b0:368:4acb:f8a with SMTP id
 5a478bee46e88-36a4242f5fdmr2867529eec.17.1793353344529; Fri, 30 Oct 2026
 02:42:24 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-2-clamor95@gmail.com>
 <auRjGM7briuvXDEg@houat>
In-Reply-To: <auRjGM7briuvXDEg@houat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 30 Oct 2026 11:42:12 +0200
X-Gm-Features: AclHuK9xo3P5XZPZURXGSlkxvgjF2BR7aWoJEgrYiYo1jUomIQQhlZvP6BUv2IY
Message-ID: <CAPVz0n2=sgbzBfvhGOoRFXeOzKDvs9en7QD0pHc31r5GzgCsKA@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:2=
9 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Oct 29, 2026 at 05:28:59PM +0200, Svyatoslav Ryhel wrote:
> > From: Mikko Perttunen <mperttunen@nvidia.com>
> >
> > The MIPI DBI bus allows modeling DBI hosts and peripherals using the Li=
nux
> > driver model. DBI hosts are registered by their respective drivers. Dur=
ing
> > registration, DBI peripherals are created from the device tree nodes
> > provided by the host.
> >
> > DBI hosts expose operations that can be used by peripheral drivers to
> > access associated devices.
> >
> > The original code was authored by Mikko Perttunen; I have aligned it wi=
th
> > the existing MIPI DSI implementation.
> >
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> The SoB situation isn't right here. The author is allegedly Mikko
> Perttunen, but you don't have their SoB, and yours isn't there either.
>

This is up to Mikko to decide what to do.

> Aside from that, which MIPI-DBI type is this supposed to support, and
> how do you intend to support Type C panels we already support through
> SPI?
>

MIPI-DBI Type A and B, which have NO support right now.

> Maxime
