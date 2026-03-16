Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F70F506D0
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF35610E522;
	Mon, 16 Mar 2026 13:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BgHkyyN1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5639E10E522;
 Mon, 16 Mar 2026 13:21:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 846EE60018;
 Mon, 16 Mar 2026 13:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A192C19421;
 Mon, 16 Mar 2026 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773667287;
 bh=r8Pt+Pp2Ftl++kbOelkEcmT75Oa144vnnykFTqZCrzY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=BgHkyyN1QaslyLHvC+Ve2AC/4PCTdfxBB0nQW5SmFmq4vmvgATMSTFGi2guHWHrom
 NCwtnaRCBdxk596/kON8pWMkFEh73gt9eEsoTdPk+VjrxBlRG+6eqImRifqvZvWmrw
 gBnaWnJSQTnjdPds6RYkcnNB/+lkWxP5GlAoWLJI0cFTEbVaX8wtdk6FV2i0EDEInk
 B6tMCVeIEFUIyi2DnclChIItrMrXSeYxzKIKDxLdNz5Nu+Qfuh8kCS8dJ/bJbP5WHh
 BwB7QLxdCuf1PiTV47DUnC4iG/Qy8DyOBUXzsNxS7oJrQ2lLUn9qnBdkM1SZ30Bbyy
 GS2H+pUiOkAQA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 13:21:23 +0100
Message-Id: <DH47AVPEKN06.3BERUSJIB4M1R@kernel.org>
Subject: Re: [PATCH 6/9] gpu: nova-core: generalize `flush_into_kvec` to
 `flush_into_vec`
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-6-86648e4869f9@nvidia.com>
 <093ca23e-7081-42db-a202-0a42c51741a3@kernel.org>
 <DGYL9FS1Z00X.2HEJ96J8R3OK4@kernel.org>
 <DH46IKESDQ3B.2GEUC479WDK3N@nvidia.com>
In-Reply-To: <DH46IKESDQ3B.2GEUC479WDK3N@nvidia.com>
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

(Cc: Gary)

On Mon Mar 16, 2026 at 12:44 PM CET, Eliot Courtney wrote:
> On Tue Mar 10, 2026 at 7:01 AM JST, Danilo Krummrich wrote:
>> On Mon Mar 9, 2026 at 10:57 PM CET, Danilo Krummrich wrote:
>>> On 2/27/2026 1:32 PM, Eliot Courtney wrote:
>>>> Add general `flush_into_vec` function. Add `flush_into_kvvec`
>>>> convenience wrapper alongside the existing `flush_into_kvec` function.
>>>> This is generally useful but immediately used for e.g. holding RM
>>>> control payloads, which can be large (~>=3D20 KiB).
>>>
>>> Why not just always use KVVec? It also seems that the KVec variant is n=
ot used?
>>
>> (Besides its single usage in GspSequence, which wouldn't hurt to be a KV=
Vec.)
>>
>>> If there's no reason for having both, I'd also just call this into_vec(=
).
>
> I think always using KVVec should be fine, thanks!
>
> For the naming, I think `read_to_vec` may be more conventional for this
> -- `into_vec` implies consuming the object, but if we want to keep the
> warning in `Cmdq::receive_msg` if not all the data is consumed we need
> to take &mut self.

I had another look at this and especially how the SBuffer you refer to is u=
sed.
Unfortunately, the underlying code is broken.

driver_read_area() creates a reference to the whole DMA object, including t=
he
area the GSP might concurrently write to. This is undefined behavior. See a=
lso
commit commit 0073a17b4666 ("gpu: nova-core: gsp: fix UB in DmaGspMem point=
er
accessors"), where I fixed something similar.

Additionally, even if it would only create a reference to the part of the b=
uffer
that can be considerd untouched by the GSP and hence suits for creating a
reference, driver_read_area() and all subsequent callers would still need t=
o be
unsafe as they would need to promise to not keep the reference alive beyond=
 GSP
accessing that memory region again.

(The situation is similar for driver_write_area().)

So, unfortunately, commit 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP comma=
nd
queue bindings and handling") seems broken in this aspect.

This needs to be fixed first, and I think we should probably create a copy =
in
driver_read_area() right away.

I don't want to merge any code that builds on top of this before we have so=
rted
this out.
