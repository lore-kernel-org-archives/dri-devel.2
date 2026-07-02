Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FBBC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873ED89B62;
	Thu,  2 Jul 2026 14:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XaMs/9Ad";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F8C89B62
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:00:07 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b1710405so10144255e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 07:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783000806; cv=none;
 d=google.com; s=arc-20260327;
 b=b7LgiKYQL//tMSQjOOt48VTVCrqfblKq1Kcv//rFsd2cSrKn56L2ds+xuZGit+8dkD
 znXbR2f5G6mkMFETN9E4Owfjva5O2f3ULgrSNunE8jDZ9vKvhfjOkjdUw6eqsDeCWMl3
 zexg5O++PETH3mN6/RnVXKVhxowTj84ZSGwElhZoH9864yO9oOqBdTmSdxpZhJoaumHH
 wvaN+cxQkHzLI4XloNB3yFl2EZXlSZyW2+GrfRxJe47jJZOg7YcE3dnd/1g6TwQRJDiM
 w61gJAm1xdYAPsIhy41D+hnGa9bc4ayTWmrbQcBo5t4m6iV3rLXZwHI+J8bkVR/Y9DSa
 2niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ad3f158zhv32TxrF7aQY3I8idlfk4/6P43hesQy1Oiw=;
 fh=asT9/ITNj56nXgZGHonl4vwuDEz4tAb2x5BvbYTr3Fs=;
 b=b1blNh+BSATnv0Oc1pnFQLwn+HlMmzYF+hcNxEuyTIk2RnrUEjCV0rKOUH5wdTWzDq
 371obEl7FcSq+Jz3rq8khuK3MAhR3N66kS6Z+5ewqWsoqw0e+nW7jThSzl2yk1vEjG10
 e+wmSFIBWTDx8DeEygZhCTBkhF7r4SKbjmJE6HaN2w2vcQhYmwy972v9Od/qv79T7B6e
 8BWQob0iq8Jod3ZlHzjVddnb3cCl/fjV+hgKpJ8pIH4/rKtLYyGMWqkDUKXrsIA33U4P
 aE0hLSeALc0nfoYqGKrrfRT+DBhZ0B7YfqHvdLeWE/scwditCAeBLdVsLQ6HYhXcmNa5
 cHiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783000806; x=1783605606;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ad3f158zhv32TxrF7aQY3I8idlfk4/6P43hesQy1Oiw=;
 b=XaMs/9AdrRIP+T9jySo9pPVi6lHcynLIEyOdc4lj/r7CBXmhdxpKR5idNkyrvpfrEr
 YzmVcjpHb4yLDX0jsWagozgyfVpYLj6pxj28JqxahmybUFecXaaM8bLm541r4CKCL71j
 5xyxqLdBs7bipKaStRbOjHroDoKAloQIZsK4r6uw1J6yYlFf9EYRm51a2waJ7EA3088N
 VhdwEExHZEypdlTh14RbnpZooyWqzJ9z44jSpbHCmnxktXqq5cqCPglPdT47l4sEcrlq
 WA66dHXebc2QAuDDUNBFncD7nKEmDb6A57/5dbWym2uUvnKA8dCbEI5fL0ZYlcterIMV
 cGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000806; x=1783605606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ad3f158zhv32TxrF7aQY3I8idlfk4/6P43hesQy1Oiw=;
 b=Ysa+pAL+UYepUtAERxS/TuMfdfNlhIPQfv5C66Dgpyom1PgoYdNQBC+at2q2xeUDHf
 /FdLDi0pOWYCpBpsNi30lqV392yJYBKQie0YiCjfNp2PR6ItrKlVowR4e0XUfCETMlKw
 LiPhZUOn8G/Dhcuq5vDDm+DY8XWv+5snoJPKvi+T9h2SAwClC79Rm+L+bsQAXgxE5OUd
 lteomV7s9UjXYO1NYszulaRC6lnO27CoN622Bqt+g8s3G1JjS4wiWPYrO3NWcpJxHzFK
 Gu/dXMFDUiGBS7kLi8SaLZilwyGXZV+bTujidI3+0Ot0d6rTjsvSLA76xzudBz/AsOCU
 GJoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZQrp7olAgelHCvN9h2Rb8MVFYaVNbjDrFuiURItwfRSRiWGOoUbE3n9Pl09L0T66vMkptKhIOxvM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2H63FONnhrszqnI6BdM7aELnw226H7gTO0mr78fS6Yfb/ad1v
 jnuEqRRaEoG9nsrVNUTlYQGVscJITEhqxJVj6Qk4BUw3CObtgRCYOEMztqfW3sXi13pk7A5+c1P
 ym8u0/WyLiPPDigvGZ3dipviK2LeBbXnbCW/dheBA
X-Gm-Gg: AfdE7ckBvUWNnIXr61Qfx6zFF7jtUrMFwA2t4WIfh0xgYVvcva9jtDEymxUkWmId/l7
 8Ct2b3ujde6Vjk9JWUGBE/M5W5Rj5tvCc1xcv+Zj4qeen/TMyWaLs7S+1FHcPopjg2JufRS0BtY
 D2qH0N+At4cmvNypjYGhiX3BqaaJ8XOgJOyggcd1ZGwaLMii6PsVlCmE59h7V0wFo2EqqD6hcmV
 U6oF8dtO3SKBGn4xdqQhUPYHLef+vvb59hjKxpylK0BPvBjPnT4fqBFHBVRqqNkBRcefQJ+a5bD
 pKY0vj99UBXkcLxYMD44tVOiPVw=
X-Received: by 2002:a05:600c:5296:b0:492:6efc:7c60 with SMTP id
 5b1f17b1804b1-493c2b99781mr85583495e9.28.1783000804786; Thu, 02 Jul 2026
 07:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-idtable-rename-asptr-v1-1-e0927273c71a@google.com>
 <DJO4SC0M6BCM.B7RP36WUWCM9@garyguo.net>
In-Reply-To: <DJO4SC0M6BCM.B7RP36WUWCM9@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 2 Jul 2026 15:59:50 +0200
X-Gm-Features: AVVi8CexQdyFEd0R-YBeb950WefW10NhAupPBjQ8CXL2XbC1XoogGwE5GSAY5zY
Message-ID: <CAH5fLgjz_FTzv7rFsxcvt2N-3ehPxa2kHJqUHKDBv56OZw5UVA@mail.gmail.com>
Subject: Re: [PATCH] rust: device_id: rename IdTable::as_ptr to
 as_raw_id_table()
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Igor Korotin <igor.korotin@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
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

On Thu, Jul 2, 2026 at 3:48=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu Jul 2, 2026 at 1:30 PM BST, Alice Ryhl wrote:
> > The current name of `as_ptr` is very generic, and if you attempt to
> > invoke `foo.as_ptr()` on a type for which this method is missing, then
> > an error along these lines will be printed:
> >
> >       error[E0599]: no method named `as_ptr` found for reference `&DmaB=
uf` in the current scope
> >          --> linux/rust/kernel/dma_buf/buf.rs:54:38
> >           |
> >        54 |         ptr::eq(self.as_ptr(), other.as_ptr())
> >           |                                      ^^^^^^ method not foun=
d in `&DmaBuf`
> >           |
> >           =3D help: items from traits can only be used if the trait is =
implemented and in scope
> >       note: `device_id::IdTable` defines an item `as_ptr`, perhaps you =
need to implement it
> >          --> linux/rust/kernel/device_id.rs:165:1
> >           |
> >       165 | pub trait IdTable<T: RawDeviceId, U> {
> >           | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > Suggesting the IdTable trait when an as_ptr() method is missing is not
> > useful. Renaming it to `as_raw_id_table` makes the method name unique t=
o
> > this trait and avoids these bad suggestions.
>
> I think the name is fine. Functions of this sort is named `as_ptr()` and =
I don't
> see why it should differ just because it's on traits.
>
> I'd rather say this is a Rust deficiency. Perhaps there needs to be a
> improvement of `#[diagnostic::do_not_recommend]` so it can be sticked to =
methods
> or traits as well.

I had a similar thought:
https://internals.rust-lang.org/t/do-not-recommend-for-traits-themselves/24=
431

Alice
