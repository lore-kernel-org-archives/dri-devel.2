Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD2CDE000
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1696B10E0F2;
	Wed, 24 Jun 2026 19:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jipwVXQt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B60E610E0F2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:17:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 060D360018;
 Wed, 24 Jun 2026 19:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA3A1F000E9;
 Wed, 24 Jun 2026 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782328643;
 bh=BXTL1/pEN/FTyKPKMA8BVIZWBMRtKuw+rExm3vmkKx4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=jipwVXQtIhW9z8lFxljLcuY7oEB/LokW5tJFCYei9aG4AJZaD4IX+IkiuSVyW+9gX
 XkAsEiaMRxjWXGmEuXVkVh28pqAoVc/aDo37K2YiiFJUxAjm2ddCHFTl9+aM661GW3
 PE+Qcm1rb4neo7M1iuFsvHQGR9Z8jyp3VjjmJiFWU3LtteGM0CUG1TvIJmIFo9kAFC
 4R6ORXsd+HioryjRDjvG1YfuF4t1dKBfkbIc9bDf7FTKereQM/74Au9PjcixYNzNzD
 QYNlB8bH7PIOPQgoUBOOyXhslgfwjWS1ahCofuush0ejyBFSORKT3noH+//Lvsum9v
 qnflbrsxJvUcA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Daniel
 Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Igor Korotin
 <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, Oliver Mangold <oliver.mangold@pm.me>, Viresh
 Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v17 06/10] rust: rename `AlwaysRefCounted` to `RefCounted`.
In-Reply-To: <20260623175814.87191-1-work@onurozkan.dev>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-6-7b4c3d2930b9@kernel.org>
 <20260623175814.87191-1-work@onurozkan.dev>
Date: Wed, 24 Jun 2026 21:17:08 +0200
Message-ID: <87cxxfiw97.fsf@t14s.mail-host-address-is-not-set>
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

Onur =C3=96zkan <work@onurozkan.dev> writes:

> On Thu, 04 Jun 2026 22:11:18 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> From: Oliver Mangold <oliver.mangold@pm.me>
>>=20
>> There are types where it may both be reference counted in some cases and
>> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
>> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>>=20
>> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
>> would require) and a marker trait to indicate that the type is always
>> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
>> is possible.
>>=20
>> - Rename `AlwaysRefCounted` to `RefCounted`.
>> - Add a new unsafe trait `AlwaysRefCounted`.
>> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>>   `RefCounted` implementations. This leaves functionality of existing
>>   implementers of `AlwaysRefCounted` intact.
>>=20
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> [ Andreas: Updated commit message and rebase on rust-6.20-7.0 ]
>> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/auxiliary.rs        |  7 +++++-
>>  rust/kernel/block/mq/request.rs | 15 ++++++++-----
>>  rust/kernel/cred.rs             | 13 +++++++++--
>>  rust/kernel/device.rs           | 12 ++++++++--
>>  rust/kernel/device/property.rs  | 11 +++++++--
>>  rust/kernel/drm/device.rs       |  9 ++++++--
>>  rust/kernel/drm/gem/mod.rs      | 16 ++++++++++----
>>  rust/kernel/fs/file.rs          | 16 ++++++++++----
>>  rust/kernel/i2c.rs              | 13 ++++++++---
>>  rust/kernel/mm.rs               | 15 +++++++++----
>>  rust/kernel/mm/mmput_async.rs   |  9 ++++++--
>>  rust/kernel/opp.rs              | 10 ++++++---
>>  rust/kernel/owned.rs            |  2 +-
>>  rust/kernel/pci.rs              | 10 ++++++++-
>>  rust/kernel/pid_namespace.rs    | 12 ++++++++--
>>  rust/kernel/platform.rs         |  7 +++++-
>>  rust/kernel/sync/aref.rs        | 49 ++++++++++++++++++++++++++--------=
-------
>>  rust/kernel/task.rs             | 13 +++++++++--
>>  rust/kernel/types.rs            |  3 ++-
>>  rust/kernel/usb.rs              | 17 +++++++++++---
>>  20 files changed, 195 insertions(+), 64 deletions(-)
>>=20
>> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
>> index 93c0db1f6655..49f07740f657 100644
>> --- a/rust/kernel/auxiliary.rs
>> +++ b/rust/kernel/auxiliary.rs
>> @@ -19,6 +19,7 @@
>>          to_result, //
>>      },
>>      prelude::*,
>> +    sync::aref::{AlwaysRefCounted, RefCounted},
>
> This patch has multiple horizontal use statements around.

Thanks, I'll take another pass to fix that.


Best regards,
Andreas Hindborg



