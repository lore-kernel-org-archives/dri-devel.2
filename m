Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C6BC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FE110E183;
	Thu,  3 Sep 2026 22:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aj4FW+iW";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B135D10E183
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 22:55:18 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-396555b8c7cso42989a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 15:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788476118; cv=none;
 d=google.com; s=arc-20260327;
 b=py4nBa9Lbc6McdwM6B8GHJGak98LDJgVM+BH58e5o5ZKDX616vOMTvmtLTtcEA3hWJ
 D7BwzBVbfMq0GP+qHLA7Pt3H3si0G5tkKny7hSD/7JaVXkP9pF7lPIQ7N6GfshMm4sNY
 gqxpzaZx8VX2fQ5P9pZ9vDoDeE1HE1SkPh3mK/pbUAylecl0sIxpVrZ71vye03bOH53W
 6PiHgc74joIWcliTAPHLYVpgzdRfKT8AXQszJ+VTirdPaQQ/Te5yzjgT4qO0I9znsvOn
 /118pgsGjUKN+BIxJGx3Ilyh0nG2nAhbTz8SvLM9WYF/e6Kca9QT9ImCUkXuuz6O+v/I
 UOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x5JVoFY9ZeQExqc2q9FWswR6O99QHIYdIyNGXwd0Ync=;
 fh=TAGV1pB5Qa1DP6i2MRu8a8FFXOYjUqemDvZqRGw9Tz0=;
 b=jyj8HuEtfe9qPndqxkM8ZpALfABVkJ7kcAijMUeGD2IcunbMH5dndUJEPGbSbPZqRw
 MrqY/fg/7TM85bDPOYMSw3cFt2xC+kZIjpFdMw4aerZD/IAhDVXlljuHq4y7qdGlFpi6
 6+JvINVNMKOpKukmyqpz4g/3kivGlnew9MPPOmWVQfl3TFU/WXmyCGlTO6GXvw/25Htw
 zCHj4Q3yi+TWl1pKvvDLddfRNKYA+ov6rE+4j/7dR5m8/oe2cJuj9WfH8Df8jIfw86iz
 fx30jnURMvozq/jTZ1bcJSHHspg2vQ1dwAmhXp1m7SAD/RWwIeqQMeGJAUjpxIk0fW0F
 r+dA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788476118; x=1789080918; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x5JVoFY9ZeQExqc2q9FWswR6O99QHIYdIyNGXwd0Ync=;
 b=Aj4FW+iWPqfvWS4v8yeA7ZIzFYrl7LpfkrDFEsukoMYWtVR3uLo1c2MzodJHn5c6A0
 8P0dqSFldjfOXszb4NA58FuJ1qtqAw72yQ/bLuhKIEv7dpJjskJ/BGIibRZvqaQV9goa
 qVuc4f8uVTXonE+oY9GExHSISBWuaQZ4HvSd6T73eHYZ6rk5uiyOaxw7DWYEG7G27VK8
 6fnN4hDyGlO3UMifsL3Qw3s48WGU4Ix+fmErR8ZhXgCJiYCwv7LABVgp3kIzYWlpeF0l
 Tducl3+jpRS8jJdcGBLItasZ74KN1yYkk806nEpks69u6oYE1U4KrlNq4s9AtZj7H/oL
 joBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476118; x=1789080918;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x5JVoFY9ZeQExqc2q9FWswR6O99QHIYdIyNGXwd0Ync=;
 b=X7LRaR9K3llh0qmvAcz8bJa+3m74PhYHm2zQ+vWWcFz4lEENmzLRsUWeWFr7dFqfvH
 OKABsWnmyodVdUWTBmuyEBEogxPE9sN5s6gr3LVoK4zB4Spd6xUh35w0i5G48XI8SPef
 KyMpGoBU5lE5LLqwKh698myeTO/TmQIEsBhGjahMJtb9K4amn0rNp6qkA2hEH5x0UY4x
 PVV0wEo/h6e8Z3C6U5xJyCZQnWr8Bfmq++Sw+EFJDvrvCCT28uY0b7HKfqofQU4vn5Ab
 Xczmos3FjyAMinpZ+NQ49I/0OdmxWiQFX2Igy3L2jZIJvEV/Ov4rR+9Au/jO4Yz/fPLt
 l6yQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByiRR5cAuyrWeweSbT7mgocOn978zNC9wlbttKcwn+jkS6Tl9S4Xfd4sXXlzQ6Dl6fWdR5oDNA6OIk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mM/l5v+/75oUGEqSY9Iux537iQvNezqmW7RUcCit6SypG9Y+lp
 /SkX2iokiltcjHjgW1SuwyfC8gIOSYp6aR38J5HPd1Sjr7UdokFTXEt029HFdZxY/EGTnUlfu/v
 yhrQCp2lD4uth7MH2YDrpVl1fdEMtxCc=
X-Gm-Gg: AYBFou03YX0Uucc09n7GITla1Ok0IwtBQ9sJxBSb561CVR37Tz3fNe/LGMR7nJlzieF
 pMvMvUHmfWGg8mAup7jUwOo6H69ds22Jt4GVws4DnMq5UrEE1okMyk29BaTs29dmMViQ9ww9+VW
 LuGV620q1UqiLBvu/37kteJaKg5z1WcdvdIo1xNdEJ/zuKHrobpmWTHnd50t1wsxLNFXTFZBt3e
 54AsVm8sP5pHqDeOJG0dzIgsuGcWElCyFSQ1oRj6drfObUyVqJl/CNll2l35SvWdmsP20UDY3jg
 j9x70DzDw0RYuYlk6NpGUXHpXmZnyaJz2S2QJuJb9UxUATEdXXfmf0yz8J/RuFAOY2BrP4WVV/f
 LaOoOGx/b+pgmRxURUdoGqPl1HDcjer9lIOH8pX46EGrhFa+h3jwctkCeRNP3
X-Received: by 2002:a17:90b:4b86:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39b26252efemr1538724a91.4.1788476118088; Thu, 03 Sep 2026
 15:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260826145642.43807-1-ojeda@kernel.org>
In-Reply-To: <20260826145642.43807-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Sep 2026 00:55:05 +0200
X-Gm-Features: AcwNN1VrwzX6ASP8KVz13RNpM47mRY3LWDyEJ1EhMzZ8gy8Jz0UYzA8WhpqQQjw
Message-ID: <CANiq72kFZ47SE8PmNe483T=+F_OYzFiP9=SEn_S4jCM=S-cSsg@mail.gmail.com>
Subject: Re: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint
 for Rust 1.100.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, stable@vger.kernel.org
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

On Wed, Aug 26, 2026 at 4:56=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:
>
>     warning: the loop variable `i` is only used to index `self.decimals`
>        --> drivers/gpu/drm/drm_panic_qr.rs:410:18
>         |
>     410 |         for i in 0..len {
>         |                  ^^^^^^
>         |
>     note: for this index operation
>        --> drivers/gpu/drm/drm_panic_qr.rs:411:13
>         |
>     411 |             self.decimals[i] =3D (chunk % 10) as u8;
>         |             ^^^^^^^^^^^^^^^^
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/main/index.html#needless_range_loop
>         =3D note: `-W clippy::needless-range-loop` implied by `-W clippy:=
:all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::needl=
ess_range_loop)]`
>     help: consider using an iterator
>         |
>     410 -         for i in 0..len {
>     410 +         for <item> in self.decimals.iter_mut().take(len) {
>         |
>
> The lint did not trigger here before because it could not handle arrays
> behind a field access such as `self.decimals` -- Clippy was improved to
> catch those cases [1][2].
>
> Thus clean the warning by iterating over a slice rather than using
> `take()` so that an out-of-range `len` still triggers the same bounds
> check as the indexed loop.
>
> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
> Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel
