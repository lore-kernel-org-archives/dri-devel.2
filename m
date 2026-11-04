Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83C606D809
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrAZImVu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C12810E25A;
	Wed,  4 Nov 2026 14:07:41 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B36010E7D2
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 14:07:35 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-14388db1a6bso20266c88.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 06:07:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793801254; cv=none;
 d=google.com; s=arc-20260327;
 b=pKNgpGItA/qi6e1dZZ9PE3HM1eO8ZtQKcF4jsqblQZYGhavv9RFZLzm5bXAD0p8Yd/
 poosahA4pwbRj4ZVDxUDgLodZEhhx3SQut3su/7XDDU4zNQir09l6CfMr9TJVKC/HT57
 uXvVl2HdevRELpZfef4cSPJm8nF3rpBZO0kG2cwtUxUR1l7wPNaBPX7L8yVv7eF0PaAQ
 2aM/mYimT/c3m5oWR2oEsDcZ6kLlVEfTzDd07WYFoRbMWow0+c8IVq3ZjXsbAkhbpUKp
 NyAoRJXH7SbitY+W4ix+UmOqy2A5s6KeaLF+t9uybOCJTg4mTWDV252lMfte50Tqm3Ff
 TlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SaAZs9B+UXOHTaRDcZeWz12aXXxWAqfcjHVOwU/3B4c=;
 fh=Jse4EWPVokxKuHXz4h8W/mgmizVnFBw5IkjhXg7a0R8=;
 b=eKGpA/rmkbK+Pja7ID/j4jSqinECzBwAq3YU7Uj3BQmiLd2NR5ZF7Rn77I3gOwIvAR
 Ddws0eSEfnmwJJ3iYQsXjoZdCwgXQimfGLwvOQ3Wo/n5jPJ2kkdMWj3uIKzoK3YAZCYq
 qks5pz5KSJ07bRfHgMx4cBMYv2xHyrc0+m86JjVHJ7vr05XylHupzvZQYnIeER2J9QRC
 6RALlF9ksIhAqtU43decstHx2xpTTyIZTu9TQGqR/jSvDOT/IHEb1tEO5mP2Vl8RpBtl
 9WluuDWE1yUoD7zgemiPaerMAHKFifcYJ8XvTlZnSGmw7LImNwyV89da1PXVobsLe7aW
 SgyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793801254; x=1794406054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SaAZs9B+UXOHTaRDcZeWz12aXXxWAqfcjHVOwU/3B4c=;
 b=NrAZImVu4kh3GlCXEVi4PPeYuNORQgNt/Oj2g3koDQaKVH848xL/0NuDNQ5mwzJiHR
 TgL1OVQJfBFlXCMFs02oyDkzqO8WjWSwV3iKJa0h3ZVkAyFRqu59LCYeBN/RlEYQRraN
 E/S29eeyI1R9pWhKGLMPEIp3ogZaorMp0aLMB6ZZ18oyDe8HGZ5znVSEdPDFFg1z67EA
 Nd09rfuJmRDChEl6lNIK3nAbyMS9uJ5sntsmsCT213CUI4Kg+Rb1ovkY6KAH1Ft9IYxM
 1JMlC+t1ytXspQ6m5zPDvYlbnyN7ZBrpJ3HwvU57tTGOfPgWFQoq06WYQIM0s8R94OZE
 OBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793801254; x=1794406054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SaAZs9B+UXOHTaRDcZeWz12aXXxWAqfcjHVOwU/3B4c=;
 b=L+KXAjQLQ2PFyqvIaP6/iHyCr9R5vPFOWkxowK5//uzJMFw1LQoUrq30fTD7JhQbRE
 obuCUO1wXVe7hoHejzQGVdoQmh05BNMyCzAdlDztO2yITcoNASTAReKlay/hlyzqZst3
 YCNOqphNttb085ObHR1Kxyx3QkUFflYr0XZB1/KRjZ2FzkLNTbijzviJNuam+QumQm0d
 imQLWV41a227N8O7gkAI1axH6470USEKCW+NVoYY2wuuYl4K6dL1yyR5e1r1hdBkT0NR
 HhPJDHGlv5FHkk4YYrhCjeWaegKFKH/SW+YVEsNUUBTq4qIMHbmGKMthkRPxbOq/yjpK
 4CKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDUeOiCvuZQrl8rJEQBrSylV79oaP1Fle0guBhlN/1MHmIedJCD7mWwXV8VzaJYgaFYkE78Ko2NWA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QwDmwJGZ2zj6M6n1gMvQj6tMY6I2h6zQVT7vfVmi9052AQP/z
 g2fDtzafBcGl7glo4ko5GEXFKmF+lKO8iSWmT4HivoUgCFV6clQyJH1vp1EWF5um+2H6zRAFnQF
 EwjBZG0/rd0Eh0UCupUGRyquHOtfOZbw=
X-Gm-Gg: AYBFou1aUNaU1VtzXYAFgB0yVZfQbXn1iAVCsCWusQYZE6UpjI8flfqY7RJ3jdc+ezA
 UlhqISEf22lVaNzZc7s9BfVGMjjWf1z9A+VPfZt/Z2OsCCe8ilr2ucnCO+NUx0EG+9MFXFvxvHT
 9ou34AM0MrAPFvHuWQ/eVqrcbdU0nF+yAtWaJi1p3AKhUoNc0L+BG+xdwO9T8tw6jcWNTdMInAz
 rBGHXMYvNV4g8jY7Pt5dO/LSE7kakh0H5rwxC+Q3Pu1KeqS9rgZC3BO2aBTh4b8CHtNb9ZLZQMe
 FwKS6GFIwh+0xPb/DsPFc63tMa1ERlcsAtHVMpGTUFvRQiyGlJ1MH2XNW0QhVPwgIC6lncmvfht
 Wi7Fl/XnaZZX8GKT6Os56cgKdY2Qns64Q8Q196KxG462T/zbmrVoJDm5uGlJIkU7EYxZxgT0VKL
 l2rn+xGKdtsu5VScuGBc4B2Zg=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr39911852c88.2.1793801253717; Wed, 04 Nov 2026
 06:07:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
 <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
 <20261104125241.39209-1-ed@charmerstraining.com>
In-Reply-To: <20261104125241.39209-1-ed@charmerstraining.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Nov 2026 09:07:22 -0500
X-Gm-Features: AclHuK_mWOgAzCBAJQN1CbtCJxv3h38jD-baiSMS3zvcmQeJZG5v5X7OZiVyOK0
Message-ID: <CADnq5_N0RFH=n05T_zKSApGB+3o29Nx5rNMOZt5kWzZWxpgsrA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: Ed Schofield <ed@charmerstraining.com>
Cc: atharvatiwarilinuxdev@gmail.com, dev@deq.rocks, aditya.garg@linux.dev, 
 alexander.deucher@amd.com, kenneth.feng@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 7:52=E2=80=AFAM Ed Schofield <ed@charmerstraining.co=
m> wrote:
>
> Hi Alex, hi Atharva, hi all,
>
> Alex, I'd like to withdraw my September v4 submission. I also don't suppo=
rt
> applying v5 as posted or the simplified patch you attached later in this
> thread. Please remove my Co-developed-by and Signed-off-by tags from both
> versions. I no longer think deferring UCLK is the right approach for the =
iMacs.
>
> I also excluded the MacBookPro16,1 (020f) from v4 deliberately because a =
tester
> found that with deferred UCLK it still hung after login, as it does witho=
ut the
> patch [1], which seems to fit Andr=C3=A9's PPTable diagnosis.
>
> Since then, I've been working with Atharva to get his native-5K iMac supp=
ort
> upstream. His patch initializes the display before the SMU, which has als=
o
> prevented the boot failures without deferring UCLK. On my iMac20,1 (0218)=
, 13
> of 20 warm boots failed with the upstream order; with display first, all =
40
> boots passed [4]. Another tester reported one warm and one cold boot, bot=
h
> successful, on a 0219 [2]. On an iMac20,2 (021a), changing only the
> initialization order improved warm boot success from 11 out of 20 to 100 =
out of
> 100 [3]. His patch only applies to the iMac20,1 and iMac20,2, so it doesn=
't fix
> the 16,1 either.
>
> I don't think the iMacs and the MacBookPro16,1 have the same problem. The
> iMacs fail while amdgpu is loading: the SMU stops responding to
> EnableAllSmuFeatures (message 6), and the probe fails with -62. With the
> display initialized first, the same message succeeds with UCLK included,
> and the iMac boots normally. The 16,1 loads amdgpu without errors and han=
gs
> later, after login, with or without deferred UCLK [1]. So deferring UCLK
> seems to help the iMacs only because it moves the enable after display
> init, and it doesn't help the MacBookPro16,1.
>
> I have prepared a draft patch with Atharva as author and me as co-develop=
er,
> incorporating his review feedback. It combines display-first initializati=
on and
> native 5120x2880 support through two tiled connectors with suspend/resume=
 and
> display power-management changes. The current draft is here:
>
> https://github.com/edschofield/linux-t2-patches/blob/7273823e425200e9f371=
e9272e02ebf9abb6f1c2/7003-amdgpu-add-support-for-5K.patch
>
> This has passed some initial automated testing on my iMac20,1 but I need =
to do
> more testing and get Atharva's final review and sign-off.

There are already patches on the list to support the 5K Macs:
https://lists.freedesktop.org/archives/dri-devel/2026-November/610011.html

Alex

>
> Alex, thanks for following up on the boot issue and checking with the Win=
dows
> team.
>
> Best regards,
> Ed
>
> [1] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5646=
139127
> [2] https://github.com/t2linux/wiki/issues/743#issuecomment-6083265811
> [3] https://github.com/t2linux/wiki/issues/743#issuecomment-6131809640
> [4] https://github.com/t2linux/wiki/issues/743#issuecomment-6163146905
