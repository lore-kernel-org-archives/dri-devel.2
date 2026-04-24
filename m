Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1FEFE5206
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938D410E37D;
	Fri, 24 Apr 2026 11:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNC6vdkg";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A3210E37D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:09:53 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so6017550f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777028992; x=1777633792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDKNX6OzlxA7jl/VimGCsLSHmvQn0nEFxj0ZFcUDDEc=;
 b=TNC6vdkg4iRbd4uyK2Jj0V7a/CljVWUUtNRnl024+nUlj9+CNk51od9V0kzWelonpE
 xDhzTNA4htaDr4IXYGgGUQs0fl1amn6qeUAH1BYPSqhh6wiffljUcnJabQ5Hh7i8QBF1
 BUs+GEKIahb9dy0zTVQOKgw0BMCQCKGr/qGBgeZuZD0Itvyhk0EnS6xiJirZCtKOp1eD
 tv15QwRytKCtKNzkknPU/1WUIm0YQcV6UnQZaUaPp26XmouKIAAHNNto5T05mUwxqEXj
 APsMrIo6mCJGR2E3vuTyB7BD15lzC12gZoyZNS/ltXLRzznwFx1Hr5LP5hyLvJZvVyPp
 zHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777028992; x=1777633792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FDKNX6OzlxA7jl/VimGCsLSHmvQn0nEFxj0ZFcUDDEc=;
 b=it4wWqHPSkr5VeLQacgZ/GYAtcuWxA2cyqLrutyl47YklY2Nw+3ks2N1XIzDIzVb52
 CwxlHcxIzC9qvShJINzw564wZda1qrZILr5N0hv/zS2KDB6ZQ8LFTUxm+rDFi3gFZBUP
 dbNl5eIfsw7+F5c4iar1qsxys/giol/tpOk3ziOU2lSKdTmu3HbMl9trETQsYYy6ypCz
 zY071YttKArlp/TDMAUpMVqSFWvC3JlhI/3thKJGpye5fwFgMCPxEYLcjqwISup/hp+r
 X0a8zDYjD0kj/i39j8bZMCPMFGZlI0lc+jCWXIHgs0RCEJBPghYmiAwi9Q5lI17Vv+hz
 UbIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5CxjzxHho5rL+bWczs8S/cvrHl0njh0+psOm29b/LjiFrOcUld7Tv3nfyc0OClyWpED3uUr6kRI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOQP/SKqP2bP8lcDucaRCz83f/LW/JBJrdiZc0w5PTb3SbR8xT
 xjyYTIjpWwJ79lbRp1uVMU118OfzVS8EcRP7nmt47polJpcZH2UQ4buE
X-Gm-Gg: AeBDiesfhHgZjMPgEjxwhIzQ66LF8XQgY4H+GBnwzLAX2jclP+d2YJhQXuIflJLvEoI
 LIX61WpBkHU/yWtIcWiBqtC0266m1npAomORqhPkbtzOS046nESZspvfXXxou8sZ0lVdzQ4OwlR
 /OO+e/MjYFrLdo+bKN1lHb9H4E16vXLCbI9oivkJ8IOJqRwc/AYrlMSq1MhYxNrauHuXJ90y13O
 +RjBsLnq9uK+AUK3+9XOWhfLd4uEYjjdnAVwyG3l52sa4kaGlK8Ivsr1CIlE9IvsbIk/eQTVUzG
 3p8iS6C4ROPV/Z2qeqPvp77XWPehG3jiYQQjDPwxEKD1gUMz8CYi3eJ4gwOUto7MbfQupDwBJty
 RoYTcUCFQgKW2seJmOE9IlBGuiabdZ33cn8ScbHADLTO+KK9PUX+MKOovgR2i+KGipPtPDzHweF
 OG4p2HMS6f8JbONa5/W/v4WZMrrVTQ3wxYXxsxki1SCK8iorrmdYajqwWz8PBm/KKOrYJiIjNfj
 BPO8TwGCb1Djg==
X-Received: by 2002:a05:6000:1863:b0:43e:a69b:d818 with SMTP id
 ffacd0b85a97d-43fe3e0ab5dmr49306229f8f.38.1777028991633; 
 Fri, 24 Apr 2026 04:09:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm59174867f8f.12.2026.04.24.04.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 04:09:51 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:09:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, simona.vetter@ffwll.ch,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <20260424120943.4a65dd69@pumpkin>
In-Reply-To: <aes7L3M1d_LvvGKa@luna>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <20260424101425.6bde0e17@pumpkin> <aes7L3M1d_LvvGKa@luna>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 24 Apr 2026 11:43:11 +0200
Link Mauve <linkmauve@linkmauve.fr> wrote:

> On Fri, Apr 24, 2026 at 10:14:25AM +0100, David Laight wrote:
> > On Fri, 24 Apr 2026 11:17:40 +0530
> > "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
> >  =20
> > > From: Link Mauve <linkmauve@linkmauve.fr>
> > >=20
> > > The core crate currently depends on these two functions for i64/u64/
> > > i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t u=
se that in
> > > the kernel so let=E2=80=99s panic if they are ever called. =20
> >=20
> > Ugg.
> > Surely you can make it a link-time failure?
> > Or change the underlying code to avoid the divide. =20
>=20
> This is currently a link-time failure, which means if any of the core
> crate or drm_panic_qr are linked in, the kernel will fail to link.
>=20
> And since we rely on core, that means no kernel can be built on PowerPC
> without this patch.
>=20
> A possible solution would be to change the core crate to not divide
> u64s, but the last time I tried to do that I couldn=E2=80=99t quite figur=
e out
> how to do formatting without it, maybe I will just open an issue against
> Rust.

If the problematic code is (effectively) printf("%lld", val) there are much
better ways to generate the digit string than repeated 64bit divides.
On particular you can use 'multiply by reciprocal' instead.
For example see the latest (I think it'll be in 7.1-rc) version of
tools/include/nolibc/stdlib.h

	David
