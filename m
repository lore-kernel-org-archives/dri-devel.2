Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004CEC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2A310F230;
	Thu, 13 Aug 2026 09:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOZ+1p2R";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC8C10F230
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:32:55 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ccdce28edeso3396955ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613575; cv=none;
 d=google.com; s=arc-20260327;
 b=pnLP5ocbqMyOKkJ+NiDpH3b+2E+kg+/FLKZK6sjcVUAFiaQhns3mw1D7XmGCOzdEDf
 1nfvz1s2Txb0gev67KSQYhYEaUjakz0Mj4mQyraGr3h+F2Fiyk0221y4FW/FQ65EH/Dl
 TWC8Rk7LjUmt7bTueIflSrImxMdVaCp17HNke1SDGCccMkW7wp2UGYzfdQfVxCICLu/C
 QaLYWM/LVBvPcVIhhJh6sJEpFilaqjHSYBzsC1BuBlaPoMfFOqLWEiINEyG2/7vjBTAH
 ASRtvkqaCF5sOZankGbhryHNoS4ZSzGma5IAnVA5JmVBl8iiW8GSS2dqDTHFwb1AdTTj
 fjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
 fh=iCy7jFTBA1r1sRT/m28p/6dhV5ZTjd22Gpvdn3bOszU=;
 b=V5PPRUxISiTvrcdpceAjsFMOy8p2xK0ca+OxcVDqJc4+7XkA/Jh4oXvEzt8iKoytgw
 KPttI/TYFbiaamZAPueW0O+jgY3o90EQji83G6uyGaP7RTTS2kcds4vZbs9RV1jrS0J0
 GHjpjCaEINf+OaCbZWgeIvFDJYSQLZr20xh/F8rQMyxmD0skcMyKBCPTFBG68ZwnKybF
 jFryxiLGj9yQiTCBYTSbUfpVT+8e4NzJXLU44dhhRvKpGFgVfPDVqS0tMTSoRl0lNe85
 z6Mq/rjZhX8ET/4n3tuthRaCSyF0rOXlRDzTi0MZFwQdje9hvxhJsWhKdv9ySvspqscR
 7FAw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786613575; x=1787218375; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
 b=HOZ+1p2R0cdNFWk/prfv+ro/znJ17RqeBP248DVJFFRSrvuQrcslm+TV4AFztMT7FL
 cQnL56b1Xiq54uwK5ieGZJUZW/YLWWH938MhS/pkzmQLiv3CxUt2X2V3FxwTKkBI4tb/
 D16YjXfpx2HD2Pq9o/mxG3ia9IPzJ5Of4NFy2yb4dxYPs86O1A2wOt1+FhIF/WTvZQW1
 M7VEYVbXAjnsZEolQcrY0480Ohxp2gtG/bbbjgekF6EhLawTIckjitLF+XUAKVBeLZcC
 e/Z/Tx1+3w5KHKHU2TBiNi6Ic5DyzGGSzPjoqp9TTYcNjGHLTQ9NOWwhNp4fOgeQqDBH
 F4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786613575; x=1787218375;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
 b=npb7D83VsjMD5ECAqfnhbxsWw1bXbFShVEUeDunjlfsH0hx1ML4hgZr9m1ZoeoEEoA
 Wj/lpOHefiy2ckRPbHDngpLrfK306Y7PsQKGdGOQVt7QY+DgGpf8IkQQoP/i2hQx2MNd
 cc4SucL6iz1lL/bWF4cQSrAUL4WBj+0Jv4TVvyB6aSX/cJ7MePQY6hpCKlFET+IyaEMw
 4k5kmc7bYtj96rUfXCD6UQHu8aUhW/b0O52/fmJmgv5ovJhb0zW5/sQwXmBwknbmZSyt
 dvZzn6LHJK2SQTIAfcUD7UgLxY48Ah11IhlXa984EhHM0yhdAg2aP6UPDiB5fXAX/nwl
 I2PQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOHz0D+jQ7+D7dLl/oe2YgTLVTNCPUK/IyLiqaZzqvG2uaNIwhIOFXKkOqUJwJoh1q6F9f/aZG2kc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmqwLUzAocZcFGo5pa4zz+YyP0dpnOjBJuYLh8c9zKsyCe4a7i
 erbKco0ny5dRt8FNk/zwq3irXR0ZqlEVTLcw1ZIj8uHc4U3RIRVYEzQXN5pZko65X6l99DEb/v6
 kcNYMf5Hmd+MNgEqciUBdrp1eBbEvMl4=
X-Gm-Gg: AR+sD12iXrQAXXwgcLKhnXAPAaJSxjR5S6PBefbl4D5++b/dz69Y8VUH0rD8VYSTcjd
 Xtr9udaujJRE+aVu20mN0dqzJGnbycJSSPAaEx0N74wKVwi7gTnWaU41xizxfEd7MxYXIUXnmZr
 zazRpmRHcEnOH963PrI2gFBf47vi5LBoFnULY+1O8DvRQQpk7fljs8A/0EF8janfxUmqX8NpCU4
 B+rGLdiCOCwX4uTBZpm64EZEIJtKWhP8n9hD6c/68v+CzNcIFoKIyZYy0pljsANFXvCDwsZ4llp
 9cuLxb359mbwKV37OvfKvRsub6oR+EcZQsmVuPqVCgFXAk8nrvBMESIK+wZ6rUIQx0MU7dso+Up
 g/e8cF1sQE0QeqzJD8mqY3TTLjxIo/N+L5YbgYpvbw393MgrNYhIAs6WLSxYYvw==
X-Received: by 2002:a17:902:d4c1:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d389a366b2mr27617905ad.2.1786613574868; Thu, 13 Aug 2026
 02:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
In-Reply-To: <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:32:42 +0200
X-Gm-Features: AUfX_mwSjTSmX5g9cpyULDa32fuXt2Yd5-MIkCd-iXvVUBlQKiet4rzS7F5uPZo
Message-ID: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
 Alvin Sun <alvin.sun@linux.dev>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
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

On Thu, Aug 13, 2026 at 1:57=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> IMO this is the correct way, also consistent with
>
> https://lore.kernel.org/rust-for-linux/20260811-fix-fops-owner-v10-3-7e71=
776f9dbe@linux.dev/
>
> It might make sense to add this to rust-next.

Yeah, it is also consistent (in the sense of adding a fallback) with
the other fix I added when applying the series for the `macros`
doctest; and the `kernel` crate is not an actual module yet.

I guess yet another solution would be to have an even more local
fallback, but that would be too local in my opinion, i.e. we will want
to use it elsewhere sooner or later.

So I could fold [2] into commit 98f256e27262, but a commit on top is
fine, I will reference that commit from the new one instead.

Ok, done -- Danilo, I took your diff and converted it into a proper
commit, please double-check you are OK with the Signed-off-by:

  ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
`#[vtable]` `impl`s")

Thanks!

Cheers,
Miguel
