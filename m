Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234FEC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5BB10EC8A;
	Wed, 26 Aug 2026 09:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GMLbpbtV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC09B10EC7D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:29:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B60740148;
 Wed, 26 Aug 2026 09:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9931F01561;
 Wed, 26 Aug 2026 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787736572;
 bh=vE0DFncUbEa7WUezDlJbcmjpQbbiEpMqeMkCvD7YDbU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=GMLbpbtV6XRD4w6KN91RH1oCiVx72uKzWQqLkbfx2kIDN9D9Eag0gzkEbhDAl0gWt
 P1YCkvBlGTSdwRH3cp7KuiATo/uaSTYejkU3Vxpztm9iu3uFxILV1ojmRaKWYlikRY
 Ggw4d12WTNh1bcjG7gDKhj2+I6mDhrKTue5CuHtVBbtjdSc5JxIGzd18mhpGbu9Yql
 CcB/55rMLKstOxN38hkC+/m6VAXbVIPr7Ta8HzW2B+7BxGx5BXD678vW+tpQrbQfJh
 g9tTDJTf0faFwf4/6U0eVGbrjKFJOeooMnCeoyi93Y+sF616btPc7GrV1O9Sww9y70
 JGj0Mli2sglfQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul
 <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
 Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Mangold
 <oliver.mangold@pm.me>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
In-Reply-To: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org>
 <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Date: Wed, 26 Aug 2026 11:29:08 +0200
Message-ID: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> From: Oliver Mangold <oliver.mangold@pm.me>
>>
>> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Do you want a link to this issue with a regular `Link:` tag?


Best regards,
Andreas Hindborg



