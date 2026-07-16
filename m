Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F291C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB5F10F322;
	Thu, 16 Jul 2026 14:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iHB/t/6f";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CB210F323
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784210495; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DqrX0QCVhhcHKSAHdoeahzKeUmohOTDkxQwdy4b4U5CQ6/9w5QHqDiVoIhqrWsmI89mwFe67g1dy8qNbi5XmGjxR+pXNaJq5CzFQ8bHCsIYhzZUA1tbmQkTKl3XeJxwRciDCRbcscZx6ow+proXu/xbuRpbp4ivQts9Jokc3tx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784210495;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YkCswN9vU9klZCbaHmjobgXuhJ9kv2i+jhOyWtNZ/gU=; 
 b=AVvnwQwUJIRzJqU0K4yFQ1ts22OjjzvdrO9I0pKO+j9KP8UF4SNWX+J4ARFcWL6CQQwJTF7fizXxrhZMtaGJKjtnTz7VC7QzswwuRCSwEz+UjLXN72XZPqMJQywSPf34rGNPAP5mafXs9yDSItCBJAl1rW/40uH5YMamAIwR0g4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784210495; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=YkCswN9vU9klZCbaHmjobgXuhJ9kv2i+jhOyWtNZ/gU=;
 b=iHB/t/6f8THx8oP3hx/xsCnbqejJwdbqld2us2HWG/dkLDiAtcEa4Dqwn1KSpWpG
 5QqOlb5RRrVVcp3yKbkj+4eYewmyIZKezdvgYZ2oNhCAQH8lp5O7fUBwUKqtxO9G0RQ
 Er3mWUHUzAXjc65l7SKCF/vzIQAvWb8YH1HPFJoU=
Received: by mx.zohomail.com with SMTPS id 1784210492755133.6375897949889;
 Thu, 16 Jul 2026 07:01:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <7a2cf5494824b8451824ebe82e0391df05a7cb5a.camel@mailbox.org>
Date: Thu, 16 Jul 2026 11:01:12 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B393F982-3746-4AE8-81DB-00D07232C681@collabora.com>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
 <046C4D44-1966-4EE9-AE86-A8F83A136771@collabora.com>
 <7a2cf5494824b8451824ebe82e0391df05a7cb5a.camel@mailbox.org>
To: phasta@kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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


>=20
>>> +}
>>> +// Necessary to guarantee that `inner` always comes first and can =
be freed by C.
>>> +// Also useful for using casts instead of container_of().
>>> +#[repr(C)]
>>> +#[pin_data]
>>> +struct DriverFenceData<'a, T: Send + Sync + FenceCtxOps> {
>>> +    #[pin]
>>> +    /// The inner fence.
>>> +    // Must always be the first member so that unsafe casting =
works; but also
>>> +    // necessary so that the C backend can free the allocation =
(coming from our
>>> +    // Rust code) with kfree_rcu().
>>> +    inner: Fence,
>>> +    /// Callback head for dropping this in a deferred manner =
through RCU.
>>> +    rcu_head: bindings::callback_head,
>>> +    /// Reference to access the FenceCtx. Useful for obtaining name =
parameters.
>>> +    fctx: &'a FenceCtx<T>,
>>=20
>> This creates a self-referential borrow in the JobQueue, since it =
holds both (a) the
>> context to mint new seqnos from and (b) the xarray with fences which =
borrow from
>> that same context. This issue does not exist with the Arc and we =
should really
>> fix it before moving with this series.
>=20
> Can you detail that a bit more. So your JobQueue version has a `data:
> T` where T holds both the xarray and a jobqueue. The xarray contains
> fences that hold references to the FenceCtx. But shouldn't that be =
fine
> since the life time ensures that the drop order is correct?
>=20
>=20
> btw we are recently coming up with a proposal on how JobQueue could
> store DriverFences for the driver. I want to present some RFC for that
> soonish.
>=20

Let me address this first, I will reply to your other points later today =
:)

So about =E2=80=9Cyour JobQueue version has a data: T where T holds both =
the xarray
and a jobqueue=E2=80=9D: no. The JobQueue has an xarray backing all the =
stages and
a context to mint new seqnos from:


struct JobQueueInner {
  fifo: XArray<XaEntry>
  fctx: FenceContext
  // other fields..
}

This fifo backs all the stages in the queue, and we track stages by =
tracking
indices pointing to the XArray.

XaEntry is split between a fallible prepare() and a infallible commit():

// prepare() stores this:
XaEntry::Reserved {
    job: Arc<T::Job>,
    uninit_fence: DriverFenceAllocation<???, ...>,
    deps: KVec<ARef<Fence>>,
    // other fields
}

XaEntry::Live is similar, except that the allocation is initialized and =
there's
the whole DriverFence/Fence split and etc.

Under your proposed design, fences must borrow their context from =
somewhere,
and this somewhere is a sibling field in the JobQueue. This relationship =
is
unrepresentable in Rust. It only works if you don't store these two =
things
together.

There are probably a few different ways of fixing this, but I recommend =
going
back to refcounting.

=E2=80=94 Daniel=
