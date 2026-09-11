Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC97C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82EB10E0CA;
	Fri, 11 Sep 2026 09:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rHEuFwex";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AD010E0CA
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:08:33 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so406044f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117711; cv=none;
 d=google.com; s=arc-20260327;
 b=HVUQwLChNQ1+RG+QArJF3L5b+ae+2eFsdKHgl+ZifJ9SQrNs4OhHBKzobvROeLdtmk
 bFuL6gearp2FrQb1akCWlYbKYhs1KRzH+2XMBsu9myawZstzLryCYkxKl3ghW5gwsVoa
 06At1TGZ4brZji4/cIc3iZi3a5wuULPVDS67wEixorHFZ8deBIVMc/IJPt4DbtraBvoP
 em4FRirNsm/Pnyk7nkP+4gZZfNfObIHVXQAvR8ubWJ1eFS+7fe5nGDJtGuxGYvW6Jbfv
 BXmhbX9U8HIyHOENbJMTxrxV5G2HYoqDeCrkObRQt1fygoaAZGSGo6jx223aYoFDEU6H
 5UVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
 fh=awtzXjNFLa0uJZouxOuB+8MVuA5LiJpIcbTf5iPixlM=;
 b=ht2j82aHnv3slBEb3KPEoCK/AN2a8ZL5ceP+dOq4TmrBt2o1Jx+DNVlM3CcfHoBf8l
 I0SprZ6LaGaGPCh+rKBj+hmTYBGwtZXG+dXnYIK3NKrsh8pUCELDpVncxJQtqcEGDWVJ
 QOvm1xD2eP8+Ik1Hvmoq57Aq/J+KHgWzR9HJDZwLgre7PWIzxJpzs/JGFtmGAAM96/XK
 2SJHe3VXHl+q2rtZkUAzyy612V6JzYKwKpKP7ttizB7Zqnpo+bRiS9+iAloriBfGqbnu
 zwHQjCql1qjSUMRdcwys0CrNtMWwRjpOcabOwQRTx9bv7c+Qnj4uCKgCs99/kVbqzP0T
 3GVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789117711; x=1789722511;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
 b=rHEuFwexynAq0uTEEBk38aZ7LgYeo+M8mL91BvqNYKG2HixhG/xONYDtQM+o/x7OJi
 LCppAi77K/UBs1tll5mX9HSrRNBvRGaJUCQe9YxrJscHzpWyW5w/MHy1qmoxXVrt8fPC
 Nkoaae0UdTBHLtCyh+8m6e0KvPniQssoZdE7S1Xl1eYeIBaSiiSL+tOt9wLyAkQdHcVI
 WrS1ApXb2GG6utQp6jBB2+fEPNIJqzh8lTsNwradufnRvCW+6xV+u435mzGqT4QNsKx1
 1sAb63z5cDNtora8QaTAttuDzANvRPWyHlxoyt+TNcfGYUKdbUzHB7Y8DqAcW+XPt+iY
 2+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117711; x=1789722511;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
 b=L8NEL3aXqXNDbnaUXDuPD9NOgeem4bDb6SH/56V2xD+5Vml2jTwEZZU9hxtXLpBkre
 08lXEyGLFFobWBms2p5P8RYmilMWNf+Oa7VL30iaUsMsJKBlgtNhR9gbUmiKbc4+Kazb
 5D/0kJ58Ybv0+rjwu79saxTEqj3v+dIuhBpjXP9dBjPlFrNWQUNS+Md0Cz6Aec0qzgRQ
 M9IdUX3q3Rwc8h0r8n/2tWw2MS/qJnak6f+fAdWjGtM6+BgsljF6TYqGnBFYuAoJqVtb
 FfZMay77fkDHms57K0q5ZwNZPNTaXBCnHC7NxlubsmVCxsc1SWovcjzaTxII8UuyCnFD
 eNEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6mzcxdDR7gjVgZ+OF0470IKjC6I/wFF9iNnwKbePyjxFQswbI0Waz2OvRkRXYDd/VX/B5YIYkXbk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYLnCD57MslrPfQZcUZl2DjrV7NXd1ptrx6re+BXhMjOhzLDck
 KSkMyZUIJgcomjS9WXh9u2AGT2+t+sIiGzpUKjjmkmejD2lbI5opJkjCskOWIqg2ovN8izV6LAX
 fnm4VKJ1slVfKNA5viFcQf/islJIWgfsNCWtQ+Ool
X-Gm-Gg: AYBFou2wN+IIuHz3EdzM3YqopdAXhEQvxsGdlYt2sIBT/0Vtvb/MHxvU3hssBItGYNO
 nLSzNftz25V6DqAnCRWFFmRcpP2qc46BLu+urBixZo8o6DkMqdTAw5xwGnjAaoWzBy3QZjaY9rj
 9544yXKpQ/ZkmEhHo7CVz1T6pZ2H5FKcBnJpwTNb8lz7nlg2u0aMfolZnzMccFaxyNWq/cAGG2o
 9HMwmu/PFNXskBe5Bwo76NdHWVhrLZooL/ok3rVHFRcaGVWEoWJysiq6vpnxPb81eqC+4QxtTQZ
 Jco2SDyFsp+Lk28w0ZeiKDysOIv4tCh+vm17knAc6absG04azEKKUZOsD8dn9P+BdimOvkaE+e8
 fjny9arh8huCzYgAgyWZKMFgU8VrxqtkBJ6PUXeEfOsv+GMXFLj5j/BqrY6tOJzNG
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id
 ffacd0b85a97d-486e0f6ce92mr8157059f8f.16.1789117710377; Fri, 11 Sep 2026
 02:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-4-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:08:18 +0200
X-Gm-Features: AcwNN1Wcpw91RcC64bgI4fLKPGdY59qIT8O1U-qjeWGvrNCV-tRUtkCYbazUk4w
Message-ID: <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
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

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has a lot of safety comments of the form "This does not implement
Ownable, *therefore* it can implement AlwaysRefcounted". But I think
the safety comment should instead explain that it's okay to create an
ARef<_> from an &_ for this type. The fact that Ownable is not
implemented is not sufficient argument.

Alice
