Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067D610ED67F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BEA10E17D;
	Fri, 27 Mar 2026 15:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMSbLhEh";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A09E10E17D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:00:31 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2c16286c496so36648eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774623631; cv=none;
 d=google.com; s=arc-20240605;
 b=NfA0/ygGOrszt+uxHfGAn93Q6MEjiocvrs+N3isDRVF3GOwPvZELF2JiXRvD5Hqs2L
 Z8F6UOli0s1Wg0N1rv9Mz4OX4KD0dRjJtm9h/9zBONP+Hwi5ZiQXXeYgxVdyzdJQrCEB
 FjAlNpaEBDmqXxjqE6hoII6ScSkL+9ni127TcsUri9EHMORZciNLWhWdQhBEK2EUbGvc
 +IFFnS1sxaRaBbH93LmVmy3rP9Iq2OidiPwQrGFSglQIL+on4PaiwBbuOsIxcoRUlIXY
 VIjuDHCzL6W8zbAuDuK1YylOZP7CqMveksPbKNXQCegvUu4AtwS5fym5o1YUuMRcxR0v
 IE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D9xCXX4qh7yDgqFtjupRac54WTmWuupUUXzjqiuoTv0=;
 fh=CwCVPGa1Lad9ZdfSUHWahgffuYQj6bWqoJBVCjqq8w0=;
 b=hKTgdSU+d1/7o8MJU6EBDYM7Nhajhl+rRlaFt9uXZy9GkAlx8upPiqFxz/7A6LN85f
 MfbviV9GhJyKO+1/Hy7BZ5Y3SBDAfIrDPSYoPCIwrg8AIzy7QsoSqhw0BdJtc2hRKDsb
 frHCUL76qzV4HI/qMJsb8UuK8yOri6Sh52ADhqtXzuC42x/8nH7FLCn/HgZ8Y6uuMHsS
 orPbc3RBw4Q14od4Yk5VcVzmL1KAU6I3Yb48e2mumZDOOhLjCuMOusV/Rc15guG9qL+U
 wksm6fB/rhch/6rbhz7ce79ZIC8gMoVtIa53LsLYAanDQHtXIdnrDtnwqM5tQsq9pULa
 bbBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774623631; x=1775228431; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9xCXX4qh7yDgqFtjupRac54WTmWuupUUXzjqiuoTv0=;
 b=dMSbLhEh1U4y4dNArsEaarTSKnBZJayITaig2lbeNuYQtNuGS27b658AHpgGFsy7YL
 GKJP7naBNgAE+E/DsOd4YrrJKafT+NxMYsc0YaGuEu016152y32tPep+Ql1x6Fook30U
 ZOcowErDMBgB3VAFIozRtG2N1tIt6c+IQ7ILfCuGEZfcNCa+3IzFggtefDpSujW4GVYu
 yZyX2BZo3UUyL4KOg8ce6QyComEJPiCudpbBnUOj+OcvJS7gI39UIZrOq7hK+YCWp1g7
 W8fbm6ULv5mGRNvHUOGircqjoBTNc/YH2eXHjgg/Ow9sVHhRS3Pbpnw0K/giA9Sw6bdy
 ILqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774623631; x=1775228431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D9xCXX4qh7yDgqFtjupRac54WTmWuupUUXzjqiuoTv0=;
 b=hkPkJ3FLIMZCD9MKAeTvy4SqXIOXBQXCiLDQpIODo1PL4BK9C4zlCspO+Z/nOcSKLi
 uutwxwmIT5yI54W4hw54CcyYUK3xtdkEGLVrTT9YDsGwXjnwAnpF40S9XQhk7kCMilfS
 ZHrjG8KlLuv0IZgz8aW8Bq8agvpIx2egburu674kpN5diMc+Sh+l3dQdBVw5q2b0hNTV
 uT8GHe0lmPleDEZQ4Z59b1vd3pO2jdwwrYcvLBOwM/2ymBy8ARVIgUdGzBrPP57ZhCEN
 usivKMSZoa01t+lLI2gCy8br3Jy31E3lns3Kfre5uIQlY1vpc7QiQdDqN9dNOqokuoTK
 2tbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYdbzV6VbdTqSKOMWSo8N27t1LfIPbbLCs4OunThcU0p8SlPTNQg5nUBFfZkJERP5JvbGFWLjQSo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEfGPgrcOALeJIn1rxk804eyYIIIHUfhNSsusvaDcwsPo8EEmz
 AWE1ZR3tqjEML+UgWAs/pxYjIZl5zKI8+gLdgu+UERgEDRQ22oBDxGsLDuHaBApr1NRzslEc41N
 dFaA+QmNaIoRlP71JQJRgjICQ7l5xTjI=
X-Gm-Gg: ATEYQzxvnYYc9a6eOLOnpr1gjuUIQfFMVbgvzSXxOGrD2SbBfKeI27vGOph+4xw7aJC
 flkfUessbBc7sHESGZ03IYbBBjVUSLCP3pCNLkwPJ+48MaFElJxGNBgylW5by4EEXhL0+ip3yk4
 /o+t6O0N8t6X3ilTzmKB4DeSkkiDWM6ol+D0XzFVbLUlnCmrS+O8RvS+OJrulzJvBwfDkgr95Ea
 2a9aG6Q3mSYPYvSbUqpiuX65M6QaAlZ017ceXkEa6wIdkyDJMTcqh728Oy86HfFbRvrreqtdhiS
 VBfJ94OcZtb7u5lE3P7LbZdCuFyrNWJ8hTKc5AUwHUZviS0kualgBzu9Al0r6kgBiy5g7kS6eXy
 VpZ/Ois3OTf0kamHrorjW/sA=
X-Received: by 2002:a05:7300:3254:b0:2be:1946:858b with SMTP id
 5a478bee46e88-2c185e6b478mr676695eec.3.1774623630624; Fri, 27 Mar 2026
 08:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
In-Reply-To: <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 16:00:17 +0100
X-Gm-Features: AQROBzCg8z5hsjJLNQncsQnLe5Jv3qMm0sXMulY5sLScvTl8_VvaOlFJW_RT3vc
Message-ID: <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
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

On Fri, Mar 27, 2026 at 2:19=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> Stephen came on the list and started to merge this things this week. I
> was going to collect up more patches for him if he wasn't around, and
> intended to include this. However, since he's starting to collect
> things, I'm not going to send him a clk pull today.
>
> It's up to you if you want to send this in via drm-rust or wait for Steph=
en.

I guess it depends if he plans to pick it up this cycle or not.

If he doesn't, then it may be best to just go forward with your
Acked-bys -- Danilo can pick it up if DRM needs it in their branch,
otherwise I can pick it up.

Thanks!

Cheers,
Miguel
