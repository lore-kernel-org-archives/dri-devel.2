Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A2606A330
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iK07iyfb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73C610EA06;
	Mon, 16 Nov 2026 14:22:30 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576BB10E3BE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:22:24 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-94961d90b79so233244685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 06:22:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794838943; cv=none;
 d=google.com; s=arc-20260327;
 b=VyfMQ4EjyGT1G1FxAh5LaJ/wF634iYIyKJwOKq12cvxAWoqo8czz/YgCQOKw6k2Jfj
 D/zS7kI1XgUvKPjFGZ+zj5JcjGfeobZZH5oYu3sPdrcyRnvPytJq1h8OQk6Pv0G/87Em
 qkiBLYQvwlFsIjtqGf7G4TT+EVZf1iSIiMsvC755UrgqVpSKDTbBAXe8e2RyrZffV4jD
 scbB1n6SHMfcOWhz6TMdXuwJ1/zGrB1Ga9/iAo9swK87aWmLBLskOKiUuQSKbCH0Lq40
 Ixj62QRHzKtKFxmFU/NoY6yAkVXHiY6jTtXzO3Ug8r3hANqzl0G4kVPVhb5m7/gnx8+M
 7mHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=whWJsRn/1UObkhQ6vFbtYGotnDXUyjncCuIw3+hU87g=;
 fh=y67sfoaTosLrLegB6Pc5vJZmJ1+iTuMN3pKFHRJHoxo=;
 b=aM2zoTk1aBTsjpRtLp8BAl2b/D0ztX9fd/ip/LK98BZTs8bssCNtRik/GZ54afjE+d
 Brlty87/E6KpdHqJ/Eyn7GlaZreySrhOVZTYNGIqds/W/weyCEzdyRKq9SKrwcddlXgX
 bT4FP39CSCEXZDUP6DMkNxbtUVq8BLJoskXFQw//fqhpiw4yehulf/Jw2kBMVjkStjTK
 jw/AB63jY96PZ49ygt8VtICwaFrgfEwiBTWQ5n1ca+8HjjBsWVNs5xKmLt7bvNRKcRtn
 IMh0ECyqp8XMKfhvjVyAx80PREEFJLw7oVd2OB7G7inUL9ZrH8SwlqBMipK189fFlpLp
 4hvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794838943; x=1795443743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=whWJsRn/1UObkhQ6vFbtYGotnDXUyjncCuIw3+hU87g=;
 b=iK07iyfbQkYgDaqk+APBt9CzN8jx4q+/RgygHGY9VdOAUT9gOw7h2cWBOHZdaYbGDO
 oRXkt9vnNfBT1gICM928xgLBMjaJpweMSXRJvrQ7CzBJdN5OhLy19CZnjjfMXa6eRCHC
 zlMutOJrsKro8U+QfvrD9k7OCAJQ5FTx26Gnkaygq5kG+0/Uxw5N/tiJmhTO1PD6EDVw
 Wi6yS0ttgefhXPkN+eOFGmtxlS6IKLf/CwwOSeRhy/TZdjHSEuSygBiVwU/cPeTnlb5N
 /L5AdJkg10jRrADvk08Cmtvu1oZ3fDq4yImHDjXwY0KO6k1axsupOMfnVPnp3UtUzz1R
 P1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838943; x=1795443743;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=whWJsRn/1UObkhQ6vFbtYGotnDXUyjncCuIw3+hU87g=;
 b=ctQs4/HamY4N0WeUdjkvERwfClTPLx+XsLUJbPJ1Ap23Fq/Ukk+sjTItbBHaiVRr//
 ztAQ+SyhU3VW+uT1bDtIYvAcTjaU9kt5y9NHQ9Z3vUjAZDQGSdQGxTC3ogSMQnszD3J2
 tI08HAq6lWXPl06jGsVPoYk6TKI0EM54v2ZX3LlQVQZhn0/gdPkktCz8KqxTFBjslExS
 6eRIhhTkfvnrxdg6Rbmd3fhMbXSMVX6QS7GZIsWu2fsZl9n/w9UmFaKMawrUp7ujtfq4
 +MGYBVBkK+gkWf8f8vzgtHp8mOlTjseEM6w5a9/EC06HexBXhRfpvhayY5u1/0UEny/I
 /yBA==
X-Forwarded-Encrypted: i=1;
 AL+hErE6jap6xp2jQ/S1VO5ff9MbDGrE7g0tVlMkYxPGl6LQ+AlPwOA3KFXdo3CGSmpOs89x3vDsJKlgLaA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8COFY0La8Fbo1MbzM32s+oUvDAizHVpzguqjLKZaiiRHryEiq
 II76Leg4xCIwZl80i16UzNz1kZFl8Fa80mkG4/hqAuAR7zeBV5RBPXxyOLSPXgZvylvpMyfxBVD
 8RwxVi6Qj4oVi9ngx6XUrxPmbcOS3E9Y=
X-Gm-Gg: AYBFou2IsNFR3OIlLq6E40ket32kP0WuvBSA+SbO6my6NWT0XVRc7OfhdCPR5jggPOg
 EJDKxm5HDa+aajc3pyE5iuZHhj3J41peGxBsjoCOJxpKpD1BLSLjFYbHBLVjXDZ+gBGI4ihvqLx
 rZUA80GrmBNAPe7RNZiXSW3Qsg2ETycgT5R/dTWPVGh/j5CSv1oJ41NTqZChtPS6Auscm7ErV6N
 1mvPjTLuLE1Ec98bnflHaQE6etvhI69HTvrS8fgKGvaFRAb38A2mB5jMhnsVrV6rUsY8Njf1wE9
 M3+tb9vx6UQuOARpME4hU/J8HkU1SeSgKkls2I18adsoq1z0VFLZ6nM7QA3HDTZeNtElRkIgEf4
 OhpBkgWirmWOnhJpvoSBwCF8U3x10iq9x1Pfg
X-Received: by 2002:a05:620a:6497:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-9494ba7e95fmr1498779385a.26.1794838943170; Mon, 16 Nov 2026
 06:22:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114200703.33229-1-mbkchelofficialdev@gmail.com>
 <20261114200703.33229-2-mbkchelofficialdev@gmail.com>
 <DMWMG16XGPYB.W659Q8DBV6F4@garyguo.net>
In-Reply-To: <DMWMG16XGPYB.W659Q8DBV6F4@garyguo.net>
From: MBKCHEL <mbkchelofficialdev@gmail.com>
Date: Mon, 16 Nov 2026 16:22:12 +0200
X-Gm-Features: AclHuK8fns1-r926XfwgL2WRc_EEssCxZIC_o5cjkaSCMh-o-Y6f2l6EEQJ4o9U
Message-ID: <CA+YDrKAM1-Jx+WH+ewzFuU9SzF=Ef=QYs-stgDNHC=7t84cCFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: lock: allow fallible initializers in
 Lock::new
To: Gary Guo <gary@garyguo.net>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Matthew Auld <matthew.auld@intel.com>, 
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Lyude Paul <lyude@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gary,

Thanks for the pointer, I missed Philipp's series. Please disregard
patch 1/2.

Patch 2/2 (rust: gpu: buddy: store the allocator inside the Mutex)
depends on the Lock::new change. Which tree would you like me to base
it on? I can rebase it and resend it as a standalone patch.

Best,
Ivan

=D0=BF=D0=BD, 16 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 14:0=
8, Gary Guo <gary@garyguo.net>:
>
> On Sat Nov 14, 2026 at 8:07 PM GMT, Ivan Tverdokhleb wrote:
> > Currently Lock::new() only accepts an infallible initializer for the
> > protected data, because impl PinInit<T> defaults the error type to
> > Infallible. This prevents wrapping a fallible initializer, such as
> > Opaque::try_ffi_init(), in a Mutex or SpinLock.
> >
> > Make Lock::new() generic over the error type E, so that it accepts any
> > impl PinInit<T, E> and returns impl PinInit<Self, E>. E must implement
> > From<Infallible>, since initializing the lock state itself cannot fail.
> >
> > This is needed, for example, by the GPU buddy allocator, which has a
> > TODO to move its gpu_buddy structure inside the mutex.
> >
> > Signed-off-by: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
>
> See https://lore.kernel.org/rust-for-linux/20261022160725.2215244-2-phast=
a@kernel.org/
> which is already in linux-next.
>
> Best,
> Gary
>
> > ---
> >  rust/kernel/sync/lock.rs | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index 10b6b5e9b024..26c071088b02 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -128,11 +128,11 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync fo=
r Lock<T, B> {}
> >
> >  impl<T, B: Backend> Lock<T, B> {
> >      /// Constructs a new lock initialiser.
> > -    pub fn new(
> > -        t: impl PinInit<T>,
> > +    pub fn new<E: core::convert::From<core::convert::Infallible>>(
> > +        t: impl PinInit<T, E>,
> >          name: &'static CStr,
> >          key: Pin<&'static LockClassKey>,
> > -    ) -> impl PinInit<Self> {
> > +    ) -> impl PinInit<Self, E> {
> >          pin_init!(Self {
> >              data <- UnsafeCell::pin_init(t),
> >              _pin: PhantomPinned,
> > @@ -141,7 +141,7 @@ pub fn new(
> >              state <- Opaque::ffi_init(|slot| unsafe {
> >                  B::init(slot, name.as_char_ptr(), key.as_ptr())
> >              }),
> > -        })
> > +        }? E)
> >      }
> >  }
> >
>
>
