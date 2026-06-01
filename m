Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4788CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F43B1135F8;
	Mon,  1 Jun 2026 17:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oxtf6dVG";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E42F1135F8
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 17:00:25 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-137eb8e3491so39935c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 10:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780333225; cv=none;
 d=google.com; s=arc-20240605;
 b=LJQMUXpWceGeVoPAdAjUNO2n08AfcKXJTrMsS+srOnBwd8KJ42nB0GvPFnMo4nska0
 XaIPkcaG9Z+P//5OXVYRkTXnMVcRQ2MxXW4myuFIGZeDDkTaXCh8sQXlCWnrarfozIAS
 LwYs2TyBf/Lfc62EQec8WiRK90UfFP/e7enc4P4MXyxZvlMWiHAPVgQBllcG60fuUyV7
 /ds4P1Cp2EDze1tr+93OMoOiIchNzRO3t9AHn39QTNztJdJ0o4gh67w/lEcLz3FpmaAU
 IRnUgOvz6KoFjm02l16h+gubPJTd5dTv2RjgU4ki9Zkk+WvQ3zjr+2jviX+YtZMt1Hd3
 9MYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kYUhb6mQkkMhkxxhyG/H6BneYLT2Y7wBn/vJjSqdV84=;
 fh=g+EWKCjFjwqGitQ8spLmDGWF+/5XHKieNHgCG4e9Afo=;
 b=dst/SYFFvp95yKhv652kFVRqReP0Jarp3ZXB3628jpPXn3OLhvuzb0h385UMw5v+yv
 Ss8N1hXQyjYzXdqqGzbFOgHS8JO40xbKBi4TplxxsaQmvnXzLbSh4oD9v8PirT4Hk2TV
 Fq2bdzG0Yb7RbONpkhHA+vmmmcfVKqcKh6PPjPbfTDNcD84zyUKIe25Is1Y4dh+mz4so
 Vn2LSv4pOex+d86s0fYd2jUH6lkCXhlu/yFpgUYSHngkNaYqDTVZZ0AhHeH5G2uvbotL
 PK98OLk6PaCxG0JdInkSxd0WLdJZs6pKJI1U0oCvbI8jxGy+uF+Der7+3Sytep5Ym8EO
 uqqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780333225; x=1780938025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYUhb6mQkkMhkxxhyG/H6BneYLT2Y7wBn/vJjSqdV84=;
 b=oxtf6dVG4bOCif6U9w9McZymAViOtmOmeYs0RnIUhDeC6CHaQxLRsHKvh9cr4aM1P0
 8JzwYjjKiL2+wXz2HIs33xAY8zUdBIOeLWFn49V9iJ6bYQA5+flVO3YfLZMNv8yNIsDG
 snZRMQaaqbQt+DTlqDgpY+PW0F0UXDTRMtreUFYyqZS7zGrzTz9RewvBgV4zJ4L8rE4D
 w3SYaL/Sr4mRqW+Ifc/gO+hETu7MY1N0iY6ai8BcsiExCY4YYNLtZw6pvAeDK0Utmf28
 7ez35oQ2BDHvww1kmFu+/C7midDHrag34K4QVqJDTjgBYJtOWtt/xgE1FJsVcxTA4YVX
 NC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780333225; x=1780938025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kYUhb6mQkkMhkxxhyG/H6BneYLT2Y7wBn/vJjSqdV84=;
 b=JXN6N/vY0wILe5Veq6KcT4F60ZsJRM0tx8Y5vyC+bw3+cVRXVtCxQkLJbMj1mhy7p6
 WqGaKTr8e/plUWu7uDiEpUl5gReQsMNI6s+8epcANzCBbzchAfWhhiIoUsOeIIp5XOlL
 4ZZ+LSRq/j8T8maNYrw1L4QR7Gyau0zHz/qs6CzhTnPLJA1VDNHfK0+xtCgPG2fSa7nK
 YqGk1WVZmHKTuo4rGQPHv82ePDvyuj5/CMuGyYRb3tvlvevA9utq6PNNU/f75H1Zstsv
 gPGM81rngnLa8W+CR09Tph+6yH41WeTD6U9C38wLOdccVHQy/Fc6kQa4A3oEzqOFE1uG
 t+PA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eHNa91BIUZZwXg/Fpq22sqNlWLGeE6qFure12/oNWe9LlmetHHsMsSsUyZAJOb0xzfP4oXXITZ70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXtl9k/2iUq6fNK89EnpLcyG987YLnF+I578f63noAslFf+8ZK
 zglXlEV25FwXGkDjVdiWfqXU46KVDX/h7UMOZmSqkYKAHGNgs8KQ6BWx8BFSpS+CmEi8YJ0viJ/
 2isEPSIo7HkXr7wsV/rQ2XagZk4LtKAY=
X-Gm-Gg: Acq92OFaEqMZ0PJu9VFw3Af4VGL+Ux4LX6lkdc1xEe7bsdl7xHYwmWnEXFNzw8qdpLm
 0UfGHo4s9+nh7QiAdw/FPazsRwpgPPLCos1Rx17/8JaOfVM6REorPL/ySTPJkQ169rXeHtRd0xW
 Y0SaLauMEHWCRc2HEgwbNUnEcTbU3CtEQGtcy8nEXbYBqWZ3lkJ8p8rYFlZNpzBRkAIfGyNX04T
 jA5elcUKIjYtezPXQT8PJ8z20iE6iyBckwmg7OVyaCbR3HZnfBx7cUgG0oBxl/ryZuaajzcrtTu
 qh0pIct/e6PITmhhiWuU2UJ4eftDx1lO3ZPB2LsJiqlSO+O2diQM0lD8ZiIJ9W62Cv9xTwTov/k
 3Ud0RlyjbQGR+okqvymLPhUpL7zyLFrsieg==
X-Received: by 2002:a05:7300:d508:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-304fa30cb81mr2563311eec.0.1780333224237; Mon, 01 Jun 2026
 10:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260530-nova-exports-v3-0-1202aa339ef7@nvidia.com>
 <CANiq72kbzmLeFv58mkiKn+LvhCXmH5g7UsnTYTcVmJ6kyc+vLw@mail.gmail.com>
In-Reply-To: <CANiq72kbzmLeFv58mkiKn+LvhCXmH5g7UsnTYTcVmJ6kyc+vLw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jun 2026 19:00:10 +0200
X-Gm-Features: AVHnY4LIwUudBe8SRqAYvkFU4tYqnuQ9elbt4jHzXY4lB4fo93aHUJvNuPfUj8E
Message-ID: <CANiq72nAOpowra81qOHHCw6EVyWVTymDoL8xPdpjT=xc3eS5bQ@mail.gmail.com>
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

On Mon, Jun 1, 2026 at 3:50=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> By the way, I think a `.gitignore` entry for the generated header is miss=
ing.

A few other notes:

  - The `exports` rule' `awk` filtering is stricter than the one we
normally use -- it is fine if you don't need `static`s etc., but I
will likely export `T|R|D|B` when I replace it, not just `T`.

  - Similarly, you don't use `EXPORT_SYMBOL_RUST_GPL` and the "dummy
symbol" is a function instead of the simple `int`. Is there a reason
for that? i.e. the ones you want to export are functions, but using
the global one (even defining `EXPORT_SYMBOL_RUST_GPL` the same way)
would reduce the divergence (so one less thing to think about later
when I replace it).

  - I noticed touching `nova-core` and then running a build twice will
only build `nova-drm.ko` the second time -- you may want to use
`--extern nova_core -L $(objtree)/...` like we do in `rust/Makefile`
instead of giving an explicit path to `--extern`.

I hope that helps!

Cheers,
Miguel
