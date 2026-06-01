Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4D8CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6CB10EA14;
	Mon,  1 Jun 2026 22:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XabdzBz3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6610EA14
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780352769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEKGZD7wPG4K2tO6rX2z5E8F6yamjZqlTqEu1Uo9K0c=;
 b=XabdzBz3UzQZ59ZYp+pepiAEs6O+ztIej2pq1sP1QFDvuILKvT15RaSK7lG/y2QqV+TAse
 vA6nn7DLUpy648Uc/Pqn0nwViR0dVZ6xsuFEkn9SpuIDdg6BGwGv6HWv1FJnRiTNWmFYG7
 fFs2kJTg8RJ7v6Pu+PH9VOaCtnW9inE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-fdCjhA67MKKrSljMUkpt1A-1; Mon, 01 Jun 2026 18:26:06 -0400
X-MC-Unique: fdCjhA67MKKrSljMUkpt1A-1
X-Mimecast-MFC-AGG-ID: fdCjhA67MKKrSljMUkpt1A_1780352766
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccebf7e86aso81874396d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 15:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780352766; x=1780957566;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KEKGZD7wPG4K2tO6rX2z5E8F6yamjZqlTqEu1Uo9K0c=;
 b=lMI0CYa7hc8DhSZwP2zgaUsRNvlTggUlIRx6mP21tb5FbOGwlimFpAYkd78uzAOuJO
 ziazPPbkAtf/haj91PvNgGpR32gEgq9mocVn7c1SWHcxRB2ccvZhn+ddvXx1lw0s2/7d
 MiHBohvt3nLWQPE1gnTC4SbG78fsgW2d7xD/02WbMp/4S1AMybLFbJBfuYLPTFyOZVA+
 MUYIogK7GuLf8bljOz8g5Y3siz05R2Dt52Def08GhKiCuHQLGOscRdDv3HwjtRBa+2oB
 /GRnWS7dbQHYjooe/ZgQ6a/VADdIvFQ6jbi+4YsGQMIACsia2Hv7GDhb9ktEQ7X2Fkp8
 AeHQ==
X-Gm-Message-State: AOJu0YwWHlth7ljjjatwjbu7f2V8Jhs/bH+9PFoCaduPPyzsDjIJUXzp
 4HJ8e0oSRE7Bl0mxuPDuB6gfmAFqxpUh1a9yiwAvpR79W70FSHcGDmVSDNzmeakX8cu0g+2MkcD
 cFUMYwi8d0fy5up7oLvfnqxqU2vJZxnTyjSrc6RZGLkjTLi8Tgpn2amqkjie0AGq6Y0v36g==
X-Gm-Gg: Acq92OF/IRsXyElYeKgcjcULXlaxOpFUy7g2b9kSc2K9YHT8CqaR9ZMmGINNCZ2ybM6
 qiJDksb7+b6HY8Os2V1+EcslHWWbzol6HJVgxZrAbsZv4LP/WH9Y09VzWiC1x29dF4SJAqpSRsE
 jQGHH3vTICemsk/fMv+kL2UoeWZw77W8ff51NYCOGNRHDcU9NSjmAiJosHM9S/HhU6j+jAIUv0u
 eZzUuzZD4iC+0gYJaY62ABPR4BAH2Qdown1tHyQxjkP0lDSqIA+Em6Z5foZPwb0/h5xiYByFM7n
 KnSx6XHJcbIa/aB59Qct7YTHQJTbgI7rWJ9TAAEeQe5b+MIll2NpA8efsvBlQEElF8KjlgYc9mf
 xVHJBTfnsiNXxjKdFN4WOF+knXySu
X-Received: by 2002:ad4:5947:0:b0:8cc:f5b7:4e13 with SMTP id
 6a1803df08f44-8cebf53afdbmr26107466d6.24.1780352765758; 
 Mon, 01 Jun 2026 15:26:05 -0700 (PDT)
X-Received: by 2002:ad4:5947:0:b0:8cc:f5b7:4e13 with SMTP id
 6a1803df08f44-8cebf53afdbmr26107066d6.24.1780352765346; 
 Mon, 01 Jun 2026 15:26:05 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccebb681f6sm99921236d6.4.2026.06.01.15.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 15:26:04 -0700 (PDT)
Message-ID: <fe3c191db743897eace3e50d9994269b45f16d3f.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] rust: sync: Introduce LazyInit
From: lyude@redhat.com
To: Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>, Ingo Molnar	
 <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Tamir Duberstein	
 <tamird@kernel.org>, Boqun Feng <boqun@kernel.org>, Peter Zijlstra	
 <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Benno
 Lossin	 <lossin@kernel.org>, Will Deacon <will@kernel.org>
Date: Mon, 01 Jun 2026 18:26:04 -0400
In-Reply-To: <ah1CarNtFhCvAAav@google.com>
References: <20260529173137.303717-1-lyude@redhat.com>
 <20260529173137.303717-3-lyude@redhat.com> <ah1CarNtFhCvAAav@google.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3qe9p91qqLMKaX0lYI3jcmeUZDlBIlR2d2C_8T787ls_1780352766
X-Mimecast-Originator: redhat.com
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

On Mon, 2026-06-01 at 08:27 +0000, Alice Ryhl wrote:
> I'm not a big fan of using these kinds of tricks to access the
> contents
> of a mutex after unlocking it. Could we instead use a struct like
> this:
>=20
> struct LazyInit<T> {
> =C2=A0=C2=A0=C2=A0 data: UnsafeCell<MaybeUninit<T>>,
> =C2=A0=C2=A0=C2=A0 set: AtomicBool,
> =C2=A0=C2=A0=C2=A0 lock: Mutex<()>,
> }
>=20
> or even:
>=20
> struct LazyInit<T> {
> =C2=A0=C2=A0=C2=A0 data: SetOnce<T>,
> =C2=A0=C2=A0=C2=A0 lock: Mutex<()>,
> }
>=20
> I think this logic will be simpler for everyone.

> By the way, another option is to use a similar strategy to
> https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-2-f5b4c74=
7eac2@google.com/
> where you just use SetOnce and protect calls to `populate` by another
> mutex in the structure. Then you don't need a separate LazyInit.

ooo - yeah, that definitely works for me and would be preferable. I
still will like to make one change to SetOnce that I think isn't too
crazy: writing up a `reset()` function for SetOnce that works through a
&mut like what I had here for LazyInit, since that would be quite
helpful to have in the gem shmem free_callback() function.

>=20
> Alice

