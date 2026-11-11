Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED1606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uhzje9/Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3CB1120DF;
	Thu, 12 Nov 2026 12:55:15 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0359A10FC50
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:02:56 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-679a2b5fe87so4022256d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412975; cv=none;
 d=google.com; s=arc-20260327;
 b=GuAMRBUUH/P/yfcZXWsxuWNo5zialJwNZz52Q0JXglPRpBG3aFMpVUjiV4FKlCl75/
 EAMhe1iyExst6X25CFIoJaGhd7qvX1VkiEW4c0iAjlcSyrrDx9WCjVNAi4qCz9Lb2wOK
 s6S+vm3aZMtELQnNvf70/AbnMDVob/uKXlKDzLJzDqzNUUN7Ws6pkuzZHHzXR3n2bcwQ
 Mr22oKF6pxuTLbXD+dEeVT0XNXgGmnBvPUhkeirBcxL2BNuuefZ/IJqaxNA7X+rl8ojC
 NmrmBCUG+Li91Wjr3Yk9GBn5WroalhY3Q7Sqi9U9C0bGMVFOHAawOa43ASzVrg02pTwm
 PjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1MTb6+K+DiWbXH5syUxf48Q0aYKAf9KtSh4KBDlK36M=;
 fh=V7BnN1/27JhrdePHZD7d2mrv/ndYAf4HqaJ3RfrcZwM=;
 b=CybKKTbWzAW1DeUj6TDjwR8F/fO2NDIqCASW6SCcKQWXR4ERIBb7efbt/EbNE970WN
 3B2ThkbVI8qlYtb0k0dbwE2CrOIluNr+c/05p0aasiEDRI24FbGCb1I6aHz4q7Jf+Qkk
 J9pbjmypvKYEMzu5Fu1CBPeTOtr+3L2Ngay0W/9GTPO6N12Z4uOFJ5m3Y3pWhf1GAlmF
 aivV5Ii3P3CYudlpCvxcbIwtXpC7cubiEENTh1tU35em1llY86xAZCTuvlgo0ZN+tMuY
 Qcfex8L9DrARmd68IOabUW9eu471f5GxlgU9kz9Vk0qflABzhnH/q7EztrLivpZ7Flj2
 5qeg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794412975; x=1795017775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1MTb6+K+DiWbXH5syUxf48Q0aYKAf9KtSh4KBDlK36M=;
 b=Uhzje9/YhSCZOWB/6KaBdICKnxYFFg86yISqTiYE+/8y+ovmkzM1nJtcfbbrTLE2Z8
 2y12KK4IiHV3fQSHFgwPnBKquBNDd/2qLpdHbeXL9r30vyN9z3qdLizNfh1PH85Cijv5
 7Zizi5LGsMxrA1cLmd6K5GmPvyRufQvgbeWNT4FwQCaWpDypCng11ngZ4N9s5wXqjK3m
 XailQdcDIgnA5kH1wtyyt8xUuGlUgu4qxDln26sadML+5NX291BszwUgAYC2SEl1l1Ur
 zNJT9y1RDQfgVDSprb8GXooCPmeoLu1wQ9xFC+RYkRGhKt5TJ0eeaAKrUiSrxLZhePng
 lrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794412975; x=1795017775;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1MTb6+K+DiWbXH5syUxf48Q0aYKAf9KtSh4KBDlK36M=;
 b=G/Sziahd5IUARpDNiUS/YWKKsrfXcUFyaeZYlJudEGFZu0FQZYqDNNpcwbQ4vm05KL
 kg5cylOkJNLOAmx8xTLV/PjY3LoMr0zTIYAClWrZxfn6mSYqwnhLnxZ6KtWNKTs+JQt6
 KjTqVqmzn9oMFUe+NMnt/Ty+CSXJQ0L0CjX4jViMvN/Os6/vmRmMF/CpHezAehWKK9D7
 FjE9ajAsRatocqZZV3bIdlBn8ATPPlgPcu14zoF1hX77bEZfcdKKfdQCv/zs2ehqUH+r
 YPpIeDb06ouDozcFrb8fLWl5RHDhIdGE8bXdhpV31EykNTozHttMFur8xovwQsAW8fZL
 mVLg==
X-Forwarded-Encrypted: i=1;
 AL+hErG+FTTVxUhceF2/LpgAtXi6VagG1W5D7dG3I9oNGx0SLgvbfRW5PDKkLWc0Ig4KyJOp4NXNrmcQJDc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YydMTPqk9hLREeGUaLS6Eg1bJF1PoxMjeY+lGtzPw7lRXWHPU
 xqk/sECwV0x1xr+F0F/ecoFbZEYLB804wzsaXFgTQ7JI9eTJB3CH6MCh+nv/OhZU51lALQ3Z3Gp
 u3zMutWvtpVM1MP7DB39UqLOm6CiFWQo=
X-Gm-Gg: AYBFou3/zwCBaDI6s1n2e8ezjIdJeuhodNDbh1daLlEsOv6vffelLdBTwxzYeKwfXyL
 4gm/PdEjCn15Msg+cpoMLrbWHYeg6eVwqvnkLZtkTr3N119jnMIptkmxgtgTCRF2a2URlYwFc30
 2Fd9v5A3rl53pBmxQutL8+K6cVZsAz7BEt2KzXskHoMLputJVCwoOUMwU2Ez7MDzBkP+F/VFbAB
 cQYpC9cfkLIzY4j9oWbhM4jvLoDJvF08SKgyu1ohGe/Xu3f6oVic3soCFWUd61HBK4eydfGc2Vy
 cLDB9FjS/tIYGmxMaoSVA9StS4xbO6l0XTSPFRzusVtFA2vfnga2XXoEMHxM2kl1D/8pE8HA72V
 tVbtj/3d0SbuRK8Ui12+EswZauFLq9N5kLBPsMos3bepJEbN2nS2vEZ4rcwhA+Fk+27z2XA==
X-Received: by 2002:a05:690e:169b:b0:67c:33d9:7927 with SMTP id
 956f58d0204a3-67c67cb7cd5mr1503453d50.12.1794412974424; Wed, 11 Nov 2026
 08:02:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
 <20261107-lm3630a-led-max-microamp-v1-1-ec9e441d9b2c@gmail.com>
 <20261111-cute-impetuous-otter-0d70c2@quoll>
In-Reply-To: <20261111-cute-impetuous-otter-0d70c2@quoll>
From: Michiel van Beers <michielvanbeers@gmail.com>
Date: Wed, 11 Nov 2026 17:02:42 +0100
X-Gm-Features: AclHuK-qKY6zTrJn_1i0uQfpLRmaZpJ8hHHbOyKs16JHL3o_cT2giJuDjxuxfRc
Message-ID: <CALcvxfH8N554Pn3uN+cms5zuq+LPGj4rnV39-5G3G9yzhXTfgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: backlight: lm3630a: Add led-max-microamp
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 2:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On Sat, Nov 07, 2026 at 01:13:54PM +0100, Michiel van Beers wrote:
> > [...]
> > @@ -77,6 +77,14 @@ patternProperties:
> >          minimum: 0
> >          maximum: 255
> >
>
> I do not see in this node reference to LEDs common.yaml. You need it for
> any common properties.

Thanks, I'll add the reference to leds/common.yaml in v2.

Warm regards,
Michiel
