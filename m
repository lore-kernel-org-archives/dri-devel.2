Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C35FC88E40
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABBD10E12B;
	Sun, 13 Sep 2026 09:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PfBvxpKE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C0610E12B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 09:49:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB11242AC6;
 Sun, 13 Sep 2026 09:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DC51F000FF;
 Sun, 13 Sep 2026 09:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789292967;
 bh=Tg5IU0+H9KMkSOpIVEYusfjm6bIb4fQEllwynyz0EVc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=PfBvxpKEvpJ5VLvXhFNDyHaYXB+ow/oOmmQUHohuPRTQ5OidCuKr72NVna21Lhj74
 r5JNth+EicGcrCC7nWRPU3KP7VvVO3pSw3SMgGmOSz4IhFnNf6O4Pe/2yjIehooC1j
 V5gfQBN3V7CSTiFObippk57pdzCBTAaYjhpBs8h86PcRmrAVE5mHCe8CBXR8sdZ9lI
 hOiIl8GhtQRUZJhWmq4v0gpGo2yCDfi4JJ5+JCDbKJMzUMLQpHEY7eL23wcPEXXOYK
 YUZArZv4sXfKDhvHqKab4q5jTSS5LAjaBXREtzk2jtVz45lYaQ3li0P61UqlG1ww9i
 AGBthjzkxuVUQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul
 <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, "Rafael
 J.
 Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski
 <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Mangold
 <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
In-Reply-To: <DLCHKYBQ3WF1.B8YPUTAKNM7@garyguo.net>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-4-e83257373062@kernel.org>
 <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
 <DLCHKYBQ3WF1.B8YPUTAKNM7@garyguo.net>
Date: Sun, 13 Sep 2026 11:49:12 +0200
Message-ID: <875x09v5uv.fsf@kernel.org>
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

"Gary Guo" <gary@garyguo.net> writes:

> On Fri Sep 11, 2026 at 10:08 AM BST, Alice Ryhl wrote:
>> On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
>>>
>>> From: Oliver Mangold <oliver.mangold@pm.me>
>>>
>>> There are types where it may both be reference counted in some cases and
>>> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
>>> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>>>
>>> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T=
>`
>>> would require) and a marker trait to indicate that the type is always
>>> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversi=
on
>>> is possible.
>>>
>>> - Rename `AlwaysRefCounted` to `RefCounted`.
>>> - Add a new unsafe trait `AlwaysRefCounted`.
>>> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>>>   `RefCounted` implementations. This leaves functionality of existing
>>>   implementers of `AlwaysRefCounted` intact.
>>>
>>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>>> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
>>> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
>>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>> Assisted-by: LLM
>>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> This has a lot of safety comments of the form "This does not implement
>> Ownable, *therefore* it can implement AlwaysRefcounted". But I think
>> the safety comment should instead explain that it's okay to create an
>> ARef<_> from an &_ for this type. The fact that Ownable is not
>> implemented is not sufficient argument.
>>
>> Alice
>
> Yeah, I think for types that currently implement `AlwaysRefCounted` and d=
oes not
> have a new `Ownable` form, it should keep saying that "this is always ref=
erence
> counted".

Makes sense, I will fix them.

Best regards,
Andreas Hindborg



