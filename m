Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56941C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B451310F168;
	Fri, 31 Jul 2026 06:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cVt1echW";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187BD10F168
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:46:21 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84e2061eed9so94269b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785480380; cv=none;
 d=google.com; s=arc-20260327;
 b=bRYiYuwf/HHqGfPvLhAFeyzD9S4BppHeoR1taVm6flYuVItaGVVZc9D3/s5xGbSMqp
 kboTlzhgOsLmTUuw3IUWWYMsZK8njaqLD4y2PH2o/0MiobR6Vmi2/z1qAeHiPVgR/C8T
 DcQFnwG5rCHBC7wu0mzHUZLVadofp7sACbvYaiw1vRqRoX8raibn1BM0N6QX0ifTEFJS
 6qa+fko4kwja236BREEmw1Kp4sjz01+LXLdBhM0O1pc/jWUy95oiwQhSvGyEScsM8x5I
 HL+ogs6pGa+yAtMihecpBO9jgRr6Qn1Of+CNYrKqIE5RRaMSVIXchB8TqU0VKuoiynUq
 qAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
 fh=RoSD1yFfPhZxl54UYpFyaXXSRrKy1+Wzet3im/t9PuA=;
 b=Gl7oqIapR0r8rpRJJ3tIea/B2v7jhrZM5GoEB7VD3JEPGqiE1lFbC1TmmJ5rhufs4i
 k8+05uu4dIoK1eSgBnjzzBopYituCocQmoM8DWWDy8ayzTWGpxItoN4wb9e2g1qulyOP
 Ix9rjn75XHR+GLCsxCHwzUlRHNX4K4O64W8ztZuL1bRlLGojBItIp4vRWy4mRmV7RjCI
 MVFaJHH5lEn0B55mYv6KnXAqY/AQBXF16ufPzAm/rdx6gVUk3J0nIblTKqOCuqaBpffH
 lmtbpiRNnSlWg5D5DHBAUYrnSepHBrvN9HFAf/JUVT3HwkRURVC3nhKoEBu3J6kjeA1n
 XWag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785480380; x=1786085180; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
 b=cVt1echW1i4uEXkroxFWZM1hWktMXIc7ODCf4hvc8k0uWHgGRg0Ue+SQ5F2pgiU4LY
 tJefcSqSHVmWhaGBnKIKi4NqXUTqjGy0POR3NMz7MhZYsAmeUqU6Olfc6DNC6eTfPOKk
 BaYW+JP2tdaClBwgA9TbEvJtP/cqc4wJXr9vlpdLiA5RHibkayDf6AMhV+wfrJk+gHc1
 KKFuUSIDzA9uZUYtdeCbfkSRI4eE1+SJwUH3B9f+mtojdkdPLRtXAj/seC610wghaWf3
 hqLPnv/ypcB/8FeTgCrqBhkNPUXOUxGzHUX/8Ac03xN8g6cLS0nE3PuxfzRDNz/xaqpq
 BLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480380; x=1786085180;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
 b=Ndi5YhxhE9yQjeEURCIs2Oj/HOs0+qbZdQ6Hdz7uvw5uASyAnq4kqGHZmkUD9wQBdc
 nZOZincUmA9l8RjGk7Jn2IGEaAP/66rYnpJ2ukT2Ixp2d6aE8ak34mFHCQ67cU5mhEQu
 PhNXQRRIplYt+81PUD6z9DWRIm8Nbdj4dK1sR9efcCzb2I9VQFK7onygLIk37l8KoexB
 jXCbFGTTDElXV2dFwvjvA88tErKApvayDxEFT7DbKuwkIRvkTS+bmCZtm3EDx1A60nxS
 oI+rXHARVY1/+HfXf95EbPqtb7BY9YVVfhXdJPdN8REM21Z20KTHTNm7AlEGPSRpUhSy
 EVuA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpsp9DuqaDLG1JP6zwtRA0ZFvQ+RQ9fvl6703jnizRjecraYMY4BwQB09YmEeE5Q4RCj/3c9d6SDPw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfqzkQ166y8Xqw8yNaDGNBwwbJGs/aVpUdtZXRBKne2tDwI5p0
 CVqUg8x3gULUCo6qaV7x9Iud8OoPjN3tn2cE/sAv+zrsiwEZrKGWctep7rHZt118ZMbMkDKMkTn
 zhP8J72kLyvu/WHKmogpbWWK0NkTa4Lk=
X-Gm-Gg: AR+sD11ebnBvRw1rKAYMVCCQDtxs577iPR0FVGnzdyI1fwMzig3noTCZEs2pDunwTZU
 jf+hFMsIneg/3BoLsAn6UCyoMlgEoSIkTdUck68Caheu38ksygHGCut+zhl40rxecUPDd3r1gUZ
 m142SX4AzFLgZkxdpWSy+cg5kGi8TpHaVLvfxuSbzmbdL8SURu6Scmaa4M5QPYDzNF8RQeGDFfS
 Wd0mMHn3nlUfLKwGwM8Q/1UDIEXAD76PYcBJR7hsP+yuvR3vOvBPoE/Bf/qXLT7Iay70CfVaeeV
 nZf+TTHSMbG80twfb4tvHYA3HWggUXAjp3SSB6BCKdVc18JPunRKQ6I6mNUQP6XYnxdoGD7Lb8f
 1u+Md+PyWZEEcDBepE4Pj6hChdMw/mZ5KzUKzIa+0Shej/oWjYCjtqcMajWUA
X-Received: by 2002:a17:902:ce08:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2d046b459b3mr15748155ad.0.1785480380480; Thu, 30 Jul 2026
 23:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
In-Reply-To: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:46:07 +0200
X-Gm-Features: AUfX_my5gmBTyBxP6uEcBbaVDtTCrtAGlQbEryzjfR6FoeX2UBUc_vHFPgNtGlo
Message-ID: <CANiq72m59O-ruHUvUcZC7yCvu0KV0w_m5vMO4e0rxyHdRmihJw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Alvin Sun <alvin.sun@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Thu, Jul 23, 2026 at 4:11=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed

Was this old tag used for some reason?

> prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
> prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
> prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
> prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
> prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
> prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
> prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
> prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701

Are all these actually needed? Some seem unrelated (some were already
applied too). The only one that seems needed has Andreas' Acked-by, so
I guess it is fine.

(By the way, I will use this second message to take this chance to
move the modules maintainers in the To: in case it helps, since I
didn't do it in my previous message)

Thanks!

Cheers,
Miguel
