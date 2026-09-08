Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F09C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661B110ECD9;
	Tue,  8 Sep 2026 15:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IewJOAna";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2EAE10ECD9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:46:48 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2569so480198a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882408; cv=none;
 d=google.com; s=arc-20260327;
 b=JvqA3zZOfJmrNVl9Lof1oO2umhGL+XRmZKIyVyx9hZchQvqlBHTNmI5/pEzBEqCprc
 b+X0Sij/Qr6W0eyMBduUMuWDig81NlJ+dep5lsSLmK7RRf7B54PBAiKyrzZmLLnSnrir
 wLXWp2cOiLxix4aP1SKFswsQRdh4Vk9pWaCIvtu13lRvducSqvynQJ4MciFFrIwF5H0q
 ojtGp2pIsI19EFqELBYCS0uMGWJkeWmWVi8Y1/IdId8XjOy6bwyBnB7OZzxikO39geL3
 cLi1lYwg4apRmMEcZrSqFme+5Eh3bCt7Hkj9VrVmQ+1pOc/7BxG2dQpsQtlI9Axcankt
 NEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WDHmQZuMHbf5qYqxvV/utcQu5YS7zXBqPLQhJFSMwks=;
 fh=FpEvpvdiN+bbVd4sC/4CHsE+y/G6n0iokZZVLHALFWM=;
 b=HxkQwcybpEcjd0kvT+uMuoeo9WY3kOkkC/z+DZMp/GCkLHHH2r/YPu5C0AsQyZFAEd
 0vhA9k7l/rqnsvlBEyk3WtvF9D+CRrUh7fW6VEQHBP4aKVdCM437qZDJGwNKLUW+7fjj
 XL7lw5mO5/R3ogeVcxlVYMSQ9ib+NEoD7e6Z8zLTOz5KoMu0amzcH5S9JFxr2n6HyCkm
 hbOQA3c1s1nAQ8XfQJmvx5DtNNJeh3dKsa1QbcxRbAREanHEvcDYFuRIzduBJgcBh5iJ
 It/2/ezTlAdd1+aAFIIPxH7YPCesiSd4BSv6R0aqU5Y4JZjiGmlxyO84pAg+8Tio+zdd
 nIcQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788882408; x=1789487208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WDHmQZuMHbf5qYqxvV/utcQu5YS7zXBqPLQhJFSMwks=;
 b=IewJOAna0gXWnvlyJO8nFPvFGugZnR95+qOueJXcSPgYKomyJeadkuwH1D8MUTNCrN
 hkkeBX+ec4NBq0T/S0CmC/E2EmGuYUqERzvM2lPmqGYwQRH7QLG1tWWhhb+v3kf5s27q
 9k1HoVBd66g8yvDUszvw6sYDs4W3HCkX9ap8h9a6JoFZDyAcQfoojiP3Nzb4VX/OEh5p
 g6tasLK6fmMaf33rMheNT1ZamTYJu6t7qCgA5vQKAkY4p+g6HTVuIvccPddSk5wBhz9L
 QUFrP7o7Ok9KxrOyvQtDGcwhw11sEzP99Yp2PWV7YE4gDfBGPBkApiicEgRpKQcMe5PS
 alGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788882408; x=1789487208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WDHmQZuMHbf5qYqxvV/utcQu5YS7zXBqPLQhJFSMwks=;
 b=bxq9NOLBfddv0nfuR5HgYoyVI0EPkeG/L74JJdQR3lBF/n+qvnN4fZcxSUBcwZRGsw
 i9si7r/GmTl0jzJm7pHwa0T3gMSYqoDnv7W/Gduu1EHk9eKWaytihCQM1JxlMn8L2j2z
 dSWu3RpsXZ7aJx5IvJfac5bCDzfbZA07jIBDhOe5hAKPsmoZxo+PM2TKxzpxb0kVjWd/
 5itrpFUiln02HvTbmzaU0rstDBN8XF3evOFTUUjaX4JoIQWGg0o7N4T4Gsqa7qwr5L8o
 SdWM2/3WZUJmWa835I27KKtyUomw4avGGHhMuBJ1eEQDDQSLPyEvaWdrWauJmXXb1cxX
 HIcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJgZWwfOinti1NgJ6rMUN+Xkqf459KB61Qjzk0dVhKMeUSy2StWQkmzde/ACkzt6f0VXqakWAQe7c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWS0kTnLitJkaQ1Y7IkhWSLMPLOjyKe8/Bw1gojzzQo2wfkxgX
 eagG3aTgOh4d27gjDUUPGBhPwGLNBcS9HI3/iCJ/1P7NnI6eNd2NpP2H4vgnb28h2mk+LB+g52s
 Y1e2zj6Iq1tF6GkSGe67sqhTJMnOVQmk=
X-Gm-Gg: AYBFou0FsbhKVSDDMat3CferugQGGAi3ytTpom9HlR/WRlwXYwNWvFF3Fbqeh+PEDib
 BX7p2st/xpDKGz8vG2ssIAsqgduTEpTHIUm1szIoHg8MpiZ3o43AZNjFMLeHLhb8Dhopp3X82WG
 qXx39A7uDnr8H6oCACGuhWvw/bni0z7s83Wu/w4Dcrh6/p/bIx7hlj6zQYSA3Cm8914IJH0Xl4J
 FR2D+6gD6faD+hdme/b+OC0lQPwWgY1rayQPEPakgoel2qL6jb4yzJA7HNTflRar0HSV2EWrKwG
 7ayfKTqHiV4AHOPEn4SaWnGHqN8xItN1+9m2IZV21V53d5uMclx+FbRkZfPDcCQtxMZBnXidgFg
 7plKVZ0dBbdUen7vuwEgHh7Go2MZ2cRkYe18t6qSO5oss+2wEu5/aV0Q6S6yw
X-Received: by 2002:a17:90b:498c:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39b3d5c4449mr20100311a91.1.1788882408145; Tue, 08 Sep 2026
 08:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <4da62a4b-c4ef-492a-9a27-b56bd4784acf@suse.de>
 <1b3d0eb2-9e9a-4d4e-b8c0-ff966033ef03@leemhuis.info>
In-Reply-To: <1b3d0eb2-9e9a-4d4e-b8c0-ff966033ef03@leemhuis.info>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Sep 2026 17:46:30 +0200
X-Gm-Features: AcwNN1UZy9klDHYXIQdjFGVCMKJTy69JyKumGJIN9nRq9tK-al_paSfA5ZANsw8
Message-ID: <CANiq72mUW5d1dOQDgpYjuKoUaZAi-im7j3v30Wd4KTDznmM9zw@mail.gmail.com>
Subject: Re: rust: Build error in DRM bindings
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel <dri-devel@lists.freedesktop.org>, 
 "open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>,
 Mukul Joshi <mukul.joshi@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Linux kernel regressions list <regressions@lists.linux.dev>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
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

On Tue, Sep 8, 2026 at 5:35=E2=80=AFPM Thorsten Leemhuis <linux@leemhuis.in=
fo> wrote:
>
> And I already wondered if I'm the only one that is running into this, as
> I reported this a few days ago already. Pseudo-patch to work around this
> can be found here:

You are definitely not the only one! I have been seen it in my CI too
-- I didn't reply here or there because I had already seen the other
replies in the other thread and I expected it to be folded or dropped
the next day or so.

But, yeah, it is painful to have it in linux-next.

Cheers,
Miguel
