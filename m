Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618DBCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E25011338F;
	Mon,  1 Jun 2026 13:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liUw8g8B";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9DB11338F
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 13:51:09 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-137dd54dc59so72987c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 06:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780321869; cv=none;
 d=google.com; s=arc-20240605;
 b=aYWtR6qDkP3mCQSTacZAsnsI3u8AEoTbaJ2giFN43D6kGLP6W4buKKiTzh82Nil9bg
 Y9jg0j6ZQtuTaAF11BFt702u6xNmX3CAoiXCf90Wjm7DIe1jF3nkVTDgJJEeVfCDZ8jE
 krXdqSFyvN/cto8+8XkKuDMAyba74quKmHgDRnrPSHDYT2dArOvl7VLT0tpkw0rjVEdv
 jMruS9kiBG09YwrF1/wAbQ94imdFZhbW0MMPrAVOWjgqXWM9bdPky05yr4aeJ6qD6CiQ
 b8ciZjnm8BNvsj5ke8gy8uiiQhRzslIvfTWK/OOjqVT6hbxrDhgWavYj16EmmesoDJJg
 3UJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r/oT687eVRP4yV0RK814W+7Ioe7FWGW2hQhsq1wvEnI=;
 fh=8XLmx0d851lzr3KaESNeEUkzoeagnO/ivVpivMLzFI8=;
 b=N66I+vIyg2j3B/GakX+3TvWhUCAit8/U6aDBYtOzcbO3l19eO1nmhyOtQNcmKbn+Y/
 q9HsLUFKNvxMM+zQ4dfO6jz9DerkWyAMNmBNDONvwHXVssPW5KXzYIHLRbxWXaRhx2z9
 S2xEpcgjCAJg0AOQoItqdKW8m6ztUZQgYQeStsYhv47XRinig0tx42KSb9HbYh5KiQRt
 h62Bta6egde37QKjAYSa9fmR4LcTdGdzhgIYlao/8pMAZKMhCISP0vwzrSipnhV5pi7C
 vQ484+PW87WB+8+zT1etuEGljItbDf99lTIOkQT5M+ruIAfSVhkXJz4MjTCAtYe4W3eP
 Ixow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780321869; x=1780926669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/oT687eVRP4yV0RK814W+7Ioe7FWGW2hQhsq1wvEnI=;
 b=liUw8g8BtLw3CEOM/BKMHb7hWAAkAwDdQkmVHHbJhvBGfKadijvk7KU0EZAm/+UwfK
 1UXsM9vZpiPCTH0dC/EU7pTxYVn25y/J9I5qHFBI3Vfr4HoVPxy4qMAPeVe8ldsbq8LM
 8k2NsB4mOpCcz1gcTYmF96Nf52XTKP2MENBtoOGj1giWD3VRVvYezbLGwKs0BpEs/T6E
 61uxH/T/cXOo4+EFYFgCNGl5P/D2cSItqVuOJEGrbv210YguOxz7ZT6GZVa/6GQs+/4/
 toox2vp8OeiK3Gp+HT3ne6xuk7yyYIrz8o4zfAHyZNdzBZlBWOcBC1Gp6VeQmUZUCBKO
 io1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780321869; x=1780926669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r/oT687eVRP4yV0RK814W+7Ioe7FWGW2hQhsq1wvEnI=;
 b=HBagHfzRAfmaAZ8llAf/CDmcgvBstKfXcZcVDD0dxAnkR2e59L5jn0ME0D4F96JJRI
 2cKRN9kn6bs3pXbOgW4iCu8RN5BnMhBg5PkLKZpbIFmL0aew+Nyad0NjKW5FmgA66Qjo
 cruqAd6Gmt+NHNOlkzWbsU8HHB04l5rrx5h9+Jsws6B72cBAbICLhVtQpWpoIy6m66Rw
 TjMbyBdc8hOkpTRSvzorOCtBRffAKPZCwcBB0vHTGAutmYYL0vBCgvoBGazHEwMHhZKz
 P3QXIOBXm084Y/NzzmhUSXOqYepx9/YhDBevqaOgMxRFIEJ6A8wfVI+87cZB9dayi6rO
 Gj6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OO7hcAbIlcbcMIpbmI+2SoXxcwdKnkWVq3PtLcA+hvXVkGWhSdt3yuFisNYuByaPBJE9CZNH/m7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFK4FcEB/RYzNh0Zc32xbL5ea/Le/slvMaQfEO0x4qrAByQDCP
 Lh3y2X2ywfGRuNoPSezIrwDJwk+BvAFWJmIzS+7iPZlP3gfe1xXDVdSlXr6rC98q1UD0a6nJmOH
 3ocZFr0NK+HbZHk+O93JpgU41yM/Rs7o=
X-Gm-Gg: Acq92OEFPxksSuEaCM/EYdTWthdW02uTWUI56mIp5KVyKI9NMmwauw4UZS1M4ibuOUM
 A57R/hKmoayzx9vOkv0wcQbwiRijb6O5xpgLmU3OLWsA8RBSWrxP6AjHTivAIoSCRU2W20dL5On
 Hu77vzXDZDUE6t+/t5ao2hXJJsQNWoO0cyS4O+nN3u7Ntp91O2IJxa58475rL3BGT051PV6y6Bi
 PMd+gRk9A48NL4+AX18+yBvBmicQJMUHOYrv2Q9PjqRuToulTf5VkOrLrCpNsL2gVbZ9rnl2s4P
 ZD7/Zxx9DZ3KEDYPPuqCaib7ETf3+GHXnL28u6hjsB9jSgTfFNLlLZ07NCocGfKwFaPI7lwGK8x
 H1kw1nvRrXQN7cIItQ2Y+s87Gw/p2vD4Evw==
X-Received: by 2002:a05:693c:2c8c:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-304fa31c4a2mr2349142eec.0.1780321869058; Mon, 01 Jun 2026
 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260530-nova-exports-v3-0-1202aa339ef7@nvidia.com>
In-Reply-To: <20260530-nova-exports-v3-0-1202aa339ef7@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jun 2026 15:50:56 +0200
X-Gm-Features: AVHnY4KWUDuK60JTIBwgnlL-tTjDarV9LStXY-LSeVpwOJ2FNQpjnaTpcPZMaew
Message-ID: <CANiq72kbzmLeFv58mkiKn+LvhCXmH5g7UsnTYTcVmJ6kyc+vLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpu: drm: nova: enable calling into nova-core
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Joel Fernandes <joelagnelf@nvidia.com>
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

On Fri, May 29, 2026 at 5:28=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> In the meantime, this series introduces a Nova-local workaround for
> `nova-drm` to call into `nova-core`. It generates the `nova-core`
> metadata that `nova-drm` can use to resolve references at build-time,
> and also builds a list of exported symbols for symbol resolution when
> modules are loaded.

The "local approach" is essentially what I suggested back then, so if
this works for you then I am happy -- with the understanding that we
will replace it with the global support soon (it is good to have a use
case in-tree :)

I see you play some tricks to get the ordering right, including a
sub-make with a double build of the `.rmeta` in "private", which in
turn forces you also to do the `.o`, right?

What I originally had in mind was simply to do everything from a
single parent `Makefile` instead, precisely to avoid complexity (after
all, it is the local approach, so you don't need to force yourself to
handle that). That should remove all those shenanigans, and it is way
easier to get right. Did you consider it?

By the way, I think a `.gitignore` entry for the generated header is missin=
g.

Cheers,
Miguel
