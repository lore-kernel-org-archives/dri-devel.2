Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782C1C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDABD10E009;
	Mon,  7 Sep 2026 12:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kRYVCxLY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A8110E009
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:38:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 516E342E18;
 Mon,  7 Sep 2026 12:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804011F00A3A;
 Mon,  7 Sep 2026 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788784722;
 bh=KD+2zcpvmkcDZ3cJuCNDIPkcI/BtMjbq/CkWlis/PbU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=kRYVCxLY0/vTJ+fbmiuidiZQ+nIGH/QQuK/Qi8lQ02VhxlPUZ0WJUQjPMPR57SbcW
 q9ArkX+lA0h0qlH46NRcal31nv+ecnkEemNBrVHbmQ1h71tj5VST7+zO0x6YXSzB3i
 cPQW6OnsBJ7tUaclciTTf0zGW4oR1lCVNyUm6YsyUC9aGtgib7AnMYkJNGu41k6wdO
 /F3gYxxJ0BBinS+JZ2un9pBUwwbDdmNSaUG9m9bFQvkpJN3EFGFST8Mmq0yV6ViYwW
 7xvSkClBpumHKJBZnZ2b9YGNbICmSo0MxgutXJ3cXXgZrZrwS7637pq/UkkfPReY2B
 x5Ldt7pD8EE7Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>, Lyude Paul
 <lyude@redhat.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXY=?=
 =?utf-8?B?w6Vn?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Christian Brauner
 <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
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
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, Asahi Lina
 <lina+kernel@asahilina.net>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
In-Reply-To: <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
 <ao2WubjLtDuHvRzx@google.com> <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
 <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
Date: Mon, 07 Sep 2026 14:38:23 +0200
Message-ID: <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set>
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

Alice Ryhl <aliceryhl@google.com> writes:

> On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>>
>> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
>> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
>> >> +        // SAFETY: We just successfully allocated a page, so we now =
have ownership of the newly
>> >> +        // allocated page. We transfer that ownership to the new `Ow=
ned<Page>` object.
>> >> +        // Since `Page` is transparent, we can cast the pointer dire=
ctly.
>> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
>> >
>> > This doesn't satisfy the safety requirements of Owned::from_raw()
>> > because the page may be used with vm_insert_page(), which increments i=
ts
>> > refcount and causes it to be shared the vma system, and this occurs
>> > before Page::release() is called.
>>
>> I suppose the existing vm_insert_page() abstraction we have is already
>> problematic, because it uses `&Page`?
>>
>> Maybe we want to change the API to use `ARef<Page>` so it already has to=
 be
>> shared? Conceptually it takes a reference count from a `&Page`, which is=
n't
>> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&ARef<=
Page>`
>> to be able to do that op.
>
> Honestly, the problem is the safety requirements of Owned::from_raw().
> Pages have a "special" main reference, and free_page() does more than
> put_page(). It even does something when the refcount does not hit
> zero.
>
> The correct behavior for Page is to allow the user to hold one
> Owned<Page> whose drop calls free_page(), *plus* any number of
> ARef<Page> references that invoke put_page() on drop. This way, the
> owned page controls the special drop codepath.

This does not mesh well with the model of `Owned` behaving like
`UniqueArc` to `ARef` behaving like an `Arc`.

Please help me understand; with page having a main ref and an auxiliary
refcount, if we model that with a single `Owned<Page>` and a number of
`ARef<Page>`, what would happen in the case where the main ref (`Owned`)
is dropped first? Is this legal?

My intuition here would be to follow Garry's suggestion and have
`vm_insert_page` take an `ARef<Page>`. Can you elaborate why this is not
an option?


Best regards,
Andreas Hindborg

