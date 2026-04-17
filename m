Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980E2F8E4AB
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0596110E030;
	Fri, 17 Apr 2026 05:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lhRq3gsM";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141DA10E030
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 05:56:10 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bd801b40dbso33312eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 22:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776405370; cv=none;
 d=google.com; s=arc-20240605;
 b=a00pBLAAXJnsznhhS9LoNeH14HX7FUt6vMXFY6tySFeMuoWqd12ODBxmkzUyNbzfEw
 ksoO5bygYmFwNnRu9fBPrXhQWEGvDKSk32yLvu3DUOmZ93UOieYs6UL8YFnOaLbzP7ao
 m6M5iY2ytiGL7UqRoPll3BVPLPIVonUAOT+0RbA3jaBbJhxKdNz1dgcSXVwk8kwbSoe5
 j4frhvabAFm1ZwFUCVjsoc0R5J6bRybPSmGZh17PI1Ytq4PFSISm5mMLrp9FGcYqCeMa
 dtJWjWaqAl/QNjKoS4uVFrdABibgvCehmwmq/7f7PSLCM02enpIiyk+IxUCZF5NL3Aw2
 Az4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8wLBjGvJshmmFrIdurJHEvic7nm1Xi3uImDSR3XDZcU=;
 fh=eJGL+9AvxTK1668G9uWXKQnpdHUaTCKWUfo+Mssehns=;
 b=MpivWz+XD17ri8XeTtrUMT6hbiYY0VGtUmkU91ju6KV3HYYITmuaPqTp+dnVkzj9/n
 JCTieigZR5Azr0GYB9mVRIkPETaW+q1Jxcpx+TqzvGJKZOjCAecIQ4zxpPvrwrHA85NP
 d4HcQlzv8ATo0Yr2AZzackF2bej5/AsEfQ3br7hGcb43H9WSXNrbP9p2s658aKij0WSf
 Qk9yfcJUAbeQ/8O4BtjauKrjAvWK8NUenAoE2YzM9xS/TObQdID/sjFhLQafHJG9MH2l
 +5rR3Wk8ISKWPcpW8EEArNAk8RrNR84FvixUG06HeemA6y/cfas9YVZ0awfddcLfEay4
 4L6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776405370; x=1777010170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wLBjGvJshmmFrIdurJHEvic7nm1Xi3uImDSR3XDZcU=;
 b=lhRq3gsMz8DzGXODRNV8EfhV9KX7nmnrnFvuf10uuypKjaMN3gtFwar0Jsxu0Gchyg
 DoPWjW0qZwH70kNqAA9MV9ZzhlfnIE6/+oNwx525U/J4yq1wzOsF0tnDdFHLMr0F+Hss
 J0eCJtV6XWnjGLGLrmXfrHOzJwSGQ3NY9gkX3KCkllKk5yDIFs+AuTtyt4hhpeBuBJ96
 0C+pV4L6nuRieZHt5H6lEw6WF7/XFPww1X0eaoPwWNA7MsRg0Dk+XUZ0QreIoiw+VcHW
 KedE2SJ8ub4rZlmrkzDN0McxX7TQlv9jZY5Qyun6HHw9mUEwLGm6UMvWWz/BfwC1bgMD
 56pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776405370; x=1777010170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8wLBjGvJshmmFrIdurJHEvic7nm1Xi3uImDSR3XDZcU=;
 b=QmSGQ9w+kMi3BjCpY4ZSu079Q5fVo7jUppfPKIozy3kCeZaGbguicwjc5UF27ig6B9
 gBKqdYWTIedEbcG+LP+dU0A5giU4wXHnk8RfoIE4aYQQvmOTX55/sufJgMOkZA+COGI5
 fhrxZZAXIyhLoYbVKL68eT91429es6R55DN7cgtlw5cDAPFE/f146uw6Tzp40VIPcJaf
 7fMn7vKvqjK3U9V0Jfp7imrBwJrWWt2LP/N545WRQbhQJL9/c5/3wguGxIlzITUBmXOK
 Ro99LsheEJo+tkyuPt34fvQlx7XWrshXwS8ZHwkmTbGXVaQyPc4nlKg2shZND2sRQOcs
 x5Ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jjlqupnwSJ0zeiy1i+fISJPqA46G6KZDicp8bib01t+T99fToicy0MfJbHAfGRPwbW++/XZpBW8c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygRWpx7SEo423aODbVV8AVrYRyN5ZtUxQInQRWBWak3S5CsrOK
 dQaZvNE5XDATkAgpLblbN6xLiPugyxCnZbDWkoZVc4HSk1kTwyU30H0oZPxRcDEApcR3xdfrjNw
 4hM1ZH7w0a6Zu66OCQ+AlirQ9d0+YPgw=
X-Gm-Gg: AeBDievzxCmQZVjRe+jmM44TGqAQ9/83QYgm42Pd7UNIHG245tTJSaFCYg+2DfJldgr
 i5rcXNR3XKOA7Jp9RpZmg3fithz+MIevrwUJ0cjZFwFJHzt6cfV5petTewnwVMenat5k3/8yuAG
 R1CQowTL3MX9u1TwXqMKUR2QcmdJuQ3WzjfEonydlCqcu+VvEBprLyK9sea7/bP//ovthOYpiGs
 gQNQqdIkgSwhrhKrSyCOSwY9lbKLIcEiKZIR9EVEc1wQEPUB0UY8vDhnC4kaku/GGTURYw6VPjs
 LZwcrMcDaTNqe4c1XdJAOJbUwjyHIVaWKQZGj3uBKcRkzCRDRBDOvlcqeq3zimRKKZijZ6/Chxc
 mSO0/+Yxtn3ESA0ZtneQsbidu+dBaBo490w==
X-Received: by 2002:a05:7022:e1f:b0:128:d0cb:7a97 with SMTP id
 a92af1059eb24-12c73f93093mr233445c88.3.1776405370040; Thu, 16 Apr 2026
 22:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
In-Reply-To: <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 Apr 2026 07:55:57 +0200
X-Gm-Features: AQROBzC6Y3v48sYFOsEz2cwt7XYI8G2mRokkhCY-Bi8cmA958EMimlDkpSumvjs
Message-ID: <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
To: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Fri, Apr 17, 2026 at 12:19=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> But now it seems to develop into some semi-official "shadow infrastructur=
e" for
> when the drm-rust tree is closed after -rc6 and during the merge window, =
and
> it's not part of the official drm-rust workflow and other maintainers don=
't have
> oversight of it.
>
> So, in order to not motivate workarounds, starting from the next cycle, t=
he
> drm-rust-next branch will be open for new features at all times.
>
> Consequently, all patches applied to drm-rust-next after -rc6 do not targ=
et the
> upcoming merge window, but the next one.

I think that for branches going into linux-next, in general, new
material is not meant to be added until the merge window closes, e.g.
from last -next:

    The merge window is open, so please to not addd any v7.1 material
    to your linux-next included branches until after the merge window close=
s.

Some things do target future merge windows (e.g. Rust itself was such
a case for a long time), so it may be fine when adding it before the
merge window opens, but I think the idea is mostly to avoid too much
movement during the merge window to avoid interfering with other
maintainers finishing their trees for Linus etc.

But not sure how flexible this is -- Cc'ing Mark.

Cheers,
Miguel
