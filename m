Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA48C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66C110E87A;
	Mon, 13 Jul 2026 08:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="TOINnr5z";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C6F10E879
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:57:52 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47640541585so1322843f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 01:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783933071; cv=none;
 d=google.com; s=arc-20260327;
 b=kiJii1PpI8A3ykBFvl81asdpgT/8+qOQrrcigyUEL96NnGWFMFP8Lm/7hOCYsO/Tvt
 6KAy4xtJ+NeFcuHbzsjYh5AUP8+sWQLTq5YcRNEUDbyzTHGY7ImET1MMYNXSb9eVKjJ/
 jzQoX5OCEBlb2924dTqDxqVsaAVmW9XTk9XJi1Aq1GtYb0gtX3jQrwdgg46haneRsIAt
 ZTYctQkdJP9uJx0EEtw1zrC1EEZBwYo7BqP7ad1Hsn20K/rRTIgGKW53VQn9JA4QE+5q
 zI69ezycBnvMn80+Fnzx5cBX8Tk8kXZxt5laCGTAJVqagwtHh/tTbBMsu6YtinwQMET2
 SeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
 fh=v+lxHQW7V6Q6U2BF4JSzmu382kzZo8zX+RfE1NMh0JI=;
 b=NkMzjuWuX/F0KTu/YYtrzq1W3BDBlZ0NbqhwplyiFzk1UbG+3BcQQBX5eLt/4fdQ0L
 dBVS8Q/jh37fK37P0ArMX3uLMbYmbP/wNddyGfHKLFPCskHdqjFwRUoDe3Lp6xWeTwYs
 mgYKwNZSWBZ5IuDbkxleql+paF7nGJqJm7MbiZ55hH8gs9LBQaSKfaEwqztoAMMIeQ0V
 CLZYZNLduT60H38/Hvw5z+iyRFL02E3CX6BKB++MdHPR/fK58v7FCWzre2pYFAOY7N/G
 c73BjwbCSTGHeX3VHeThNLquvJdeMWBuGURqjCV4aelP8YUqin/KToFW8tA60RWEVxWM
 rtXg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783933071; x=1784537871;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
 b=TOINnr5zd8b0vJQk95EmGWhnETn4/tsceHruJUi86ZVyfSQx3kr0kHB09f+pIXpysf
 rV5eJHeWAc6QoyhQronJicIHS9olRJS2SdyUqHtCY0oWcmgMfJGU8QCUk98YVW9+xkdP
 vYc4oKy7nhm8qsvYdxpz+VIROPs5IMRTry45YN3sYBEPG3Q12mys6cMq42tUGjSuMmlv
 7KYlQp+etahnNqAiHf/Wdqm3MIasxm0M46Pw1+qB5RoC7TSUPxyo4qG9MT7kS5BtmdC6
 gmJOCIn4Hxty1mCLxT9ztWYOZRw2eqNTkdYLsx/sopAwWj8e7wX+k+M6izjZ5XVH6HZM
 giRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783933071; x=1784537871;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
 b=L3p/sqIBJ+RueJk3ipupqbBCDPjP9z9+1z0GC9QBh0IUlY45go2lf2M3Fq8VYLpzj6
 N10FAEfNPdSfroZht4T8cZ7Ay8mrebZldUJtmaDYoMPtGw9YSmsCnztfHj/1tkel9qR3
 9P1g0XMtHE2d7kvZQT1DePbH6gSTfBs6zBa+pZkQ/igCfrHoX0yu+WD0vCZgJzFOmACG
 d7Wwv2D+eizXdQSDXx/gssexjrvq9j/Fh0+KOkBjpUA6YIHU+pGTWk9pKIIdjaZFCVTc
 wYfIoyOD5MZiTjNha8/cUdUeJ2SKVJxKunN4G1WQRt7Ekh2etqcj3nMp06NUFqK5oSt5
 qduQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0IvQbSVqIk6tC1OngiSWnp7td8piC8OnLjeGIuMp8MgaNDpJFHz9hk0ZzRQSBflAQ/Qm+iiTv328=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYfmrculR93/3v5jm1llZmPI0A+Y7CzT0wYSKwTuVP6cpXo3FH
 aJKboCLsfzHBleurGp8tt+C+SL8OzR0eqEqLfkS046jZ9x/nSLnI36gHNLoVxDnJ/khYPABxCmq
 m4E5D2YuCalWHNwYjbbHv1y0cDVAoJt3fr8PrvM1p
X-Gm-Gg: AfdE7ckCIiTQ+LXVpZKQLD8vdhcYsmDPT6HjCbhq88/0/E3V1FyiYO+Reb0/CTGZLOK
 8geHs0D5uOKrwJfjK8P1rrijx4Xx8dG0FBNS3w1FpsuIb5VgZyhsPEZgs8MtosxUWTInkLtK9rC
 6tpFACZjfVt0QljUh7QVPkRj2E/9XXnOn1Oj0hbWhzPM601K+eVJcOL5peE4ci8xP4fgeQEiUze
 b9POgD5omswueTpgcCYCWKOeaiLkjmZrhR4ScExhttqDHPqGNOrC5l/2XAK6awMNJq6NAx7t9QT
 8D4OCRXzM7Q1173660/mCG15HYGLyOEN38J5RPZPGGy1cDFEGEjnD+RqwSJ/QCRTvITPbQ==
X-Received: by 2002:a5d:5850:0:b0:472:55a:ef9b with SMTP id
 ffacd0b85a97d-47f2dcac418mr8602513f8f.8.1783933070140; Mon, 13 Jul 2026
 01:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev>
 <alSe6PsvdrSYP_Z0@google.com>
 <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
In-Reply-To: <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 13 Jul 2026 10:57:37 +0200
X-Gm-Features: AUfX_mw1uUYgV4eMXkVflbUYoDKpPh-OOQHMx0yAVcG6yUMQsdEhmzk4SLg_fQ0
Message-ID: <CAH5fLggszOnUm7Rykt41V91de8h9YVaZt49wr52i3t5-QV84Xg@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] rust: module: update MAINTAINERS to cover
 module.rs
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
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

On Mon, Jul 13, 2026 at 10:48=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
>
> On 7/13/26 16:16, Alice Ryhl wrote:
> > On Mon, Jul 13, 2026 at 02:45:31PM +0800, Alvin Sun wrote:
> >> Module types now live in `rust/kernel/module.rs` alongside
> >> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> >> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> >> files are covered.
> >>
> >> Cc: Petr Pavlu <petr.pavlu@suse.com>
> >> Assisted-by: opencode:glm-5.2
> >> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7=
d21c5a1a1b8@suse.com
> >> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> >> ---
> >>   MAINTAINERS | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index e035a3be797c4..74733de3e41ee 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -17984,7 +17984,7 @@ F:   include/linux/module*.h
> >>   F: kernel/module/
> >>   F: lib/test_kmod.c
> >>   F: lib/tests/module/
> >> -F:  rust/kernel/module_param.rs
> >> +F:  rust/kernel/module*.rs
> >>   F: rust/macros/module.rs
> >>   F: scripts/module*
> >>   F: tools/testing/selftests/kmod/
> > Is there a reason why this is a separate commit from the commit that
> > introduces rust/kernel/module.rs file?
>
> Gary asked the same on v6; `git log` shows MAINTAINERS changes are
> conventionally
> standalone commits with a `MAINTAINERS: ` prefix, so I kept it separate.
> Gary agreed [1].
>
> [1]:
> https://lore.kernel.org/rust-for-linux/DJJ26195JBS9.D3DNLZPRJYO4@garyguo.=
net/

Ok, that's fine then.

Alice
