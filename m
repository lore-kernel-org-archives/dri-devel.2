Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2532110A88E1
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A84A10E244;
	Thu, 26 Mar 2026 15:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZwzvRdSJ";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D0910E244
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:48:53 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43b88b7ca76so883615f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774540132; cv=none;
 d=google.com; s=arc-20240605;
 b=UzgTU5WmgXUYKnOyknlp1W+6FLvHdEoP2mDTTRGoKx03O9bjmXYjTNeEH13T+fDKzh
 ooKSHIPoi+iMNCd94inv4HUpnUuqsC5AjjFL3ArMV9MstVTA35iD4zQhqCkWJSk2InpH
 S3ORWZXPJRT7mcU4CU4xzhgUzABzc0naFNmdqC9jsU1wCUxFpEADDm1poeHvJcIGlh4j
 LvOkrOJ7Qqzz7wUSYtNYm51p8Vg3+t4ULSLEuNi4uaeS84mgmYDHw5nC1ewxSc/sGchj
 Quf9Ldro+mgiqVKD4Mil1NinGc05SjdZsevXuqJTsnIg3zIX17hUvspJNFel+jpKpbxv
 L+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gcmA4xemRq3WR7qmX0kNzwosAdJ+Jh50wm9bWpIEZRU=;
 fh=cfHd6TDkQfJaKIUt2Zzg3RQZF69urIB7MBgBT4t+98A=;
 b=JhcebknJYGhjdUHcWwLs1OOOpBeroS2+jfh4n8JHanHa1EjumjTZt0FnHMcQ4Kz9G1
 9WHQ77DFrg/DAnE8wHfi8xZUT40Sz3SX1nfGwkP89zfXISmZ5cQdYDPq4gbGOgcZjwzF
 RCBKxSZsuqycxE91HvjE/Ue2sdAdg8eOHpZ4mNAhOy+WEyxcMcuPbU036+cJwkSBmfFv
 VBKRe2hnGXhcCfu+mNB3wuWZO75XCemUXq7V3+/hEK1ckdtkW1zoA0EFNpNWVyF2TeRp
 vZLzYCHYZ4ElNs9nerOv3tiaH8GhM51IvMnkwI7r4+KVGhD2laJ2fWWQvEA4ByKlXZAJ
 diHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774540132; x=1775144932;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcmA4xemRq3WR7qmX0kNzwosAdJ+Jh50wm9bWpIEZRU=;
 b=ZwzvRdSJd7JUSLQfj+qQfeYqK4s6z48O5B8xM0z8768MNh4xgX5c8kP7z83ZUGPDqI
 360dDhHm+AQyzKYsRW07NN7wOUE4XRPJ69Y2m4S8699ChZOjfgowL0tJJPOGROWjNS+R
 76Wdq2EOApZ/PJRXeyy1CfYzKuxLkl2LcDxj4iYHyvzqldgBd98FNmbFjJ3L1ji+wtT8
 BzHIhQBlDxcvOMafzP1QysCycKkvw8L7D6RzmhJdz6oZ4ZGTsPEKtJ/8JV+3bAff4sj8
 H+Fa/J3KeHqw5y+cGX/NYs5bv1aZaIF1YbFomkLTXlGfvLF2hcse4kzOonicChVmf7tM
 RKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774540132; x=1775144932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gcmA4xemRq3WR7qmX0kNzwosAdJ+Jh50wm9bWpIEZRU=;
 b=Xqiy/nM1Z3UBFoauSnzG02lsXQsVJG4dK6XrbBaS6l0KB9kin+4GefPYLWM6/00gpU
 JumHnSwnr/NV8OWTWfRTQtaraqtdmyxKOTcNsGKbRfrSBno0OPWdGkacsXjpnKGupcrh
 SubB0f2wmlLqAWQT+CYu5+Vb3kfPLQIGLrxAKr4GFJ+oOeCoOUhxXxdSQ60/7oC74pki
 TXci59S6R8yMblWA8hds4VZxbdmefJELEX6yr9fWiID+sS12pNfFICMMLwC07dYlue9C
 SzvGkgEKTPJGhlwqFZWRjVCUN3aOjqwhRCAb0/e6XA/7semZHfNqhZf0t2WyAFy/22KS
 gzhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+28h8nd5LHH2zOBVHnXsNshERY3boDsArKxu/dV9G/h1/jAdENtw6KERw6TtR6UH+wMUVq2wJnzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxC2HmgbPR1lA/UTwxox5SXq/bF3ofK9sKgJTA3L76itbbWIjpC
 zmqS+uCV957aN/JMO3bFqgV2RHSaqFwn7DYchqdX4/VI7K/pNP4a6Pam4Wru00QpxchLfpCnysQ
 T8OfzihY2gvOyJEFbsueg6UeIA+MNrVFiQRqSeyO6
X-Gm-Gg: ATEYQzwW3qb4JZwtkFHSXGCK3bkbjwdiW0+weoOsGyohkJ5O3GcI4Q32OUumskUwvQm
 ma+Dg84AeUvHBjiVjnq0AcrHPkTr23nbtvChbEXmBJE+4cNqGaRpxggmWptWa682F5ctK8+hEAO
 gmaFlajpM29fsUbJACfIRzMQ7keMBpX7KOOgQkRTJoT+Fq24kNg8EsFItgiAvBmDcI1Jcq5wv57
 K+NIG0ZC+FcJHXv5UoXjs1icLPGkLZ1soR7stxRXWMBD0fnmU1yY9a7yCvRViXliVWrBUwhPAnX
 n38wA6YW8/SygYF6sa2iyZrSprdbqnPR3IJCO4B7BInjH0l+
X-Received: by 2002:a05:6000:2c11:b0:43b:6345:8d7e with SMTP id
 ffacd0b85a97d-43b88984f3cmr13464840f8f.13.1774540131659; Thu, 26 Mar 2026
 08:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
In-Reply-To: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Mar 2026 16:48:39 +0100
X-Gm-Features: AQROBzDW6L8OFzVj7xaTHZyW9yS5R-Yi_mODxiIedVBhkBd6XdeyEN4hQfcujwk
Message-ID: <CAH5fLggOfA1Pik-hr=shhVNwg65rU0=uLEU1FZn62jTEgcnC5g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] rust: Add ARef support for work items
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, Mar 24, 2026 at 12:27=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> This series adds ARef<T> support for both regular and delayed work items.
>
> - Patches 1 and 3 actually implement the support in workqueue.rs
> - Patches 2 and 4 adds a corresponding implementation in drm::Device that
>   dispatches the calls to the underlying T::Data.
>
> This was tested on Tyr, and is actually needed in order to obtain a
> &drm::Device when handling work items. This is then needed in order to
> allocate GEM objects inside the work handler that processes the tiler OOM
> (out of memory) events. The current series sets the stage so that the abo=
ve
> is possible in the future.

Applied to drm-rust-next. Thanks!
