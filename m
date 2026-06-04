Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD8DCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA38211270C;
	Thu,  4 Jun 2026 07:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bveFE/gX";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A8C1124F6
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 00:43:30 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-59f967189e7so43633e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780533809; x=1781138609; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rym8UMbIPSnQ16D68tiaqUk5iYRBwLoCnDZwF31rnjM=;
 b=bveFE/gXrCbGiRL3HK/gfipHz0i+9Jq6+AAKG5Pczk02sfrpoxxA4Fvse6QipHp0VQ
 3dShZk2DXcPlLS5CCnjEAPRqqpG+fyPQlUYp3oa3KLR03O0/xrMFlRU8JTUfEiaAl3dZ
 kWKy7xion5nVPJPORywlLCtsCP58LPOoQzp4E36iIsYcbD5WuE32x3txCbdHYDUvzzRH
 btLtck0dYJkBkyYgNA5Fp7x5cyzt35GCX3Wb3KDnTs92gx1VqwoHB6K0IEjlpjAicN4z
 ZsI28r5Bmg5uoW1Ft3JSHVxNTZ71+eHlbJgN2C5TOag+fdEXT63HHApp3uBMfVg4uMP7
 uG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780533809; x=1781138609;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rym8UMbIPSnQ16D68tiaqUk5iYRBwLoCnDZwF31rnjM=;
 b=bz8nbcB7qJKHMPVIPecDKTTVqWaKT0OwSAuhhd6Apu/cFKcXH+o/lXTT7Go+y0js67
 3WtpwLfoEi409/RnAtYaIsvQ3wo8dlBOUhXy6X6HBzRYCMZaKAzc5ObrcqHKAWRO/C+r
 8zv73xTsz+nvKpaKtgkkOm4ZHfDkMlPCEYA2fMDgdzTNmUC0N3nlezZxfrvhvOitLt2P
 LyL7/+9g7vpGu+HIHunbPtEPaNTvO97qNgCBp8Qq0+TR5dKbTmtlCOMN1lVI6orCfSQG
 g1jna9HvokxX4bwB02KeRGy5avXG5XMDk7Yxv0ksuE0tGLBkHYsrWoQWmZD/AFaVpqJO
 ZUhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bD/dlP2uyz4hkRZW7nupP7ma/DKg2csjV04TUnEZ/7CD5A6Yl0ZdhcoL3ajHjQPnnfyJGcYBYnhM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvvpUS5N5QV5iJnjWnIXLrbH1QtKd2GYnnwifPe1xLFBGoP8Tn
 q4BfBGYj2vi3q9L3xizM8SJ9JwtokFdV9J90abDzp3p+muF1wF0qWen/
X-Gm-Gg: Acq92OGrK70GcZ1PeZBU2SXta9L/P7FPB7KS+NOvXJapRw5iz6apxLv8q9p0szUSIrU
 w/6nphThwwnHYBCm6WcHu4yy2c2aRnWaJ3YavFaWhjKZVfq/dpzPiyZtkupUUBWvw+nWEE5So/X
 7qTBNCUK5ot2hkgSgZSki4YeQcVLoI4mnnZQVGzRYQZGKhbjABiRXh+9iqsKWgbqIfsqeeilSSQ
 aB32IDoFqeeecVv3c13goCCIlZZ2WIXkc+4jsKyQXg3fRVPQ3crlIeHuO8G9j9DrRM8D39Ghey/
 1mnLCkF4hZrK+zfAwhRArRRzFBkG8RMsE2h/l6cZbf6puwyoudnKuv7Vby13On8HJuxrS+mYxji
 gfSFSPVFj1SQqRy1QdWJZpercqM5OpamDu8ojHZz9Oeq8Bkd0XtwLJKYIz4G2ffXBmO29va046g
 +6L/I6lfqq21TDhgAScDaakPYtGVgGirSFqT5GjGxfCTC6vWPirocI
X-Received: by 2002:a05:6122:e250:b0:56f:6cc0:681e with SMTP id
 71dfb90a1353d-5a6e20460f6mr4443168e0c.1.1780533809510; 
 Wed, 03 Jun 2026 17:43:29 -0700 (PDT)
Received: from smtpclient.apple ([179.165.169.30])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d6dc3d3fsm4139948e0c.5.2026.06.03.17.43.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 17:43:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <20260603191405.4c75badb@fedora-2.home>
Date: Wed, 3 Jun 2026 21:43:05 -0300
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09096455-BA79-4E61-AD88-44DA57C5BEA8@gmail.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
 <20260603191405.4c75badb@fedora-2.home>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:30 +0000
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



> On 3 Jun 2026, at 14:14, Boris Brezillon =
<boris.brezillon@collabora.com> wrote:
>=20
> On Wed, 3 Jun 2026 13:41:02 -0300
> Daniel Almeida <dwlsalmeida@gmail.com> wrote:
>=20
>>> +    /// Called when the fence is signaled.
>>> +    ///
>>> +    /// This is called from the fence signaling path, which may be =
in interrupt
>>> +    /// context or with locks held, which is why `self` is only =
borrowed, so that
>>> +    /// it cannot drop. Implementations must not sleep or perform
>>> +    /// long-running operations.
>>> +    ///
>>> +    /// An implementation likely wants to inform itself (e.g., =
through a work item)
>>> +    /// within this callback that the associated =
[`FenceCbRegistration`] can now be
>>> +    /// dropped.
>>> +    fn called(&mut self); =20
>>=20
>> This is a central point. We ideally would want this to consume self, =
because we
>> may want to move things out of the callback. =20
>=20
> This one comes from me. The rationale being that ::called() is called
> from an atomic context, and the resources attached to the callback =
data
> might require acquiring other sleeping locks to be released, and
> sometimes you don't even notice immediately because said resources are
> refcounted, and the lock is only acquired when you happen to be the
> last owner. Yes, those can be caught at runtime if the C side is
> properly annotated with might_sleep(), but that's not always the case.
>=20
> If we defer the drop of the data only when the FenceCb is
> dropped/recycled, we're at least not constrained by this "runs in
> atomic context" thing.
>=20

This design does not solve it, because one can quite trivially get =
around this
restriction using Option<T> as I said. If your point is =E2=80=9Cdon=E2=80=
=99t run any drop() here=E2=80=9D,
then &mut self doesn=E2=80=99t do it.

>>=20
>> Consider a fence design where signal() consumes self. Now consider =
this:
>>=20
>> ```
>> impl FenceCb for MyCallback {
>> fn called(&mut self) {
>>   // Can't move the fence out, so we have to put an Option<T> just to =
be able
>>   // to move.
>>   if let Some(f) =3D self.some_fence.take() {
>>     f.signal();
>>   }
>> }
>> ```
>>=20
>> This used to be the case when our version of the job queue used the =
"proxy
>> fence" design:
>>=20
>>=20
>> ```
>> // Callback on the hw fence
>> impl FenceCb for MyCallback {
>> fn called(&mut self) {
>>   if let Some(f) =3D self.submit_fence.take() {
>>     f.signal();
>>   }
>=20
> I'm pretty sure lockdep won't like it anyway, because this is nested
> locking of the same lock class. For such proxies, we'll need to teach
> lockdep about the nesting like has been recently done on
> dma_fence_array & co. But I'm digressing.

Yeah, but this is more about resource transfer in general, not
this pattern specifically.

I agree that this has issues, and yes, lockdep complained back
then :)

>=20
>> }
>> ```
>>=20
>> Although this is not the case anymore, since we phased out this =
design given
>> Christian's recent work. Still, we should ideally not require =
Option<T> here in
>> general just to make resource transfer possible.
>=20
> I see. OTOH, don't we need to make this inner data movable if we want
> to cancel the FenceCb before the fence is signaled anyway? And that's
> most certainly a case we have in the teardown path.

Can you expand a bit on what you mean here?=
