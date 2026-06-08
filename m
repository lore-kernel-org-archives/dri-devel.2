Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684C5CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E5410E233;
	Mon,  8 Jun 2026 18:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VdtPmKqP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAAA10E233
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:39:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EB6D442CC;
 Mon,  8 Jun 2026 18:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353A01F00893;
 Mon,  8 Jun 2026 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780943991;
 bh=eDl99UMrerAAIsjDTb3KiIZXC+bsyxC+y8sPtmMFhKE=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=VdtPmKqP6b8oZT4A4Gon6mW790XcP9ycKqa04vNMBeznenfKSbsOiXASTvfGX1lJz
 0oI/XrGuDPxzpC4M8wAH41KNZWD7lioRxwGFdG2KExZyqavlgUqa9G1XKz2smqrrlJ
 cFfTp5epVC48j8S4KPt7z6PZOD0/VI858lrPxW6fPUQemJzYA0hyBJPOgFsNwmLr2Q
 SkDEfZB+Pu0VkdU6McQpDjhKAS+njLkg/9RSjblPNjNbOVHcHSisFD7D4XZflKSnuG
 kTp6ZUV8/ekkPb2w01wH2wZCc/mAw8FtVfPEpczgg+G2CGEJdVUeZdTRDt2HaVbTqN
 SvqxuR0lpUPog==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 20:39:47 +0200
Message-Id: <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
Cc: <phasta@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <dwlsalmeida@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
In-Reply-To: <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
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

On Mon Jun 8, 2026 at 8:32 PM CEST, Christian K=C3=B6nig wrote:
> On 6/8/26 19:59, Danilo Krummrich wrote:
>> On Mon Jun 8, 2026 at 7:34 PM CEST, Christian K=C3=B6nig wrote:
>>> That's why we need the RCU grace period to make sure that nobody is
>>> referencing the driver stuff any more.
>>=20
>> Right, and that's what Philipp tries to address, the requirement to wait=
 for an
>> RCU grace period is perfectly fine if it is only about freeing memory, b=
ut it
>> can become painful if the fence private data contains data also needs to=
 be
>> destructed in some way.
>
> Yeah that makes sense.
>
>> IOW, if a driver signals a fence, it is lifecycle-wise reasonable to des=
truct
>> the private data that is no longer needed (remaining users only deal wit=
h struct
>> dma_fence) and having to wait for a full grace period adds sublety and
>> complication that can be avoided with the proposed approach.
>
> Yeah, I've run into that when I tried to make the amdgpu fences independe=
nt as well.
>> That said, I'd like to ask the opposite question: What are the concerns =
with the
>> proposed approach over (pure) RCU?
>
> Well a) locking inversions and b) performance.
>
> For example the reason why we have the dma_fence_is_signaled() and
> dma_fence_is_signaled_locked() variants is because there is a measurable
> difference in some specific use cases for not grabbing the locks.

I checked for this as well, but couldn't find a case where
dma_fence_is_signaled() is used in a way where it would be performance crit=
ical
to avoid the lock in any way.

Note that the lock is only bypassed when the fence is signaled already (thi=
s
would be preserved) and if signaled() returns false, i.e. dma_fence_signal(=
)
will take the lock anyways.

> I personally find those micro-optimizations rather questionable, but the
> community agreement is that we should have them.

I agree, it is rather questionable. So, I wouldn't make this the deciding f=
actor
unless someone can present a valid case where it actually matters.

> So my take would rather be that the dma_fence_is_signaled_locked() varian=
t
> goes away and we consistently call the ops pointers without holding the
> dma_fence lock and the driver implementations can then optionally take it=
 if
> necessary.

How did you get to this conclusion considering that you run into what I
mentioned above as well and the fact that we seem to agree that the perform=
ance
concern is rather questionable?
