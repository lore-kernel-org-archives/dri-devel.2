Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE62C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A26510E9F2;
	Tue, 28 Jul 2026 19:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iOH59auN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0243A10E9F0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 19:31:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2429F60A99;
 Tue, 28 Jul 2026 19:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C894E1F000E9;
 Tue, 28 Jul 2026 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785267116;
 bh=eTizqzQ+hVIezvWHkd+A28hpM6dneaU75ikX2ECeUwo=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=iOH59auNLajYqQo3htj9g0bxWv/U8IUNadqAcKGU7jBplYIH/9o2/fNbpdHcmMzz2
 0t/EUQxwnvXY/NVIeeZZN5BBwo10NG1byrDccokQPQjMaEPBWIH1G9y2/RtS4kF2ss
 Ns8+bFOpT0zlw9DxNnqPRJVrBbiwk6KuLR14oU7DeopiFvOv7OTphNgHObKhI5rcyk
 wNVMYmKYj9hNyDa2dA087IAhtFtrc99zGuOYVdKkURycaym1ne4tH+gmCF/mTCOUc4
 OXH+jBOdzlhBlP34Fv8X6+Z/djmb/g1I5FLhd/wlgzXZQirLSW3Vp6pk93NnkYCF0P
 WokwqBsJVuWDg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 21:31:50 +0200
Message-Id: <DKAGDGAGBRXN.T20HFE198R5A@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 3/7] drm/tyr: add Memory Management Unit (MMU) support
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <laura.nao@collabora.com>, <samitolvanen@google.com>, <lyude@redhat.com>,
 <beata.michalska@arm.com>, <boris.brezillon@collabora.com>,
 <steven.price@arm.com>, <alvin.sun@linux.dev>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-3-9187aefa3f2f@collabora.com>
In-Reply-To: <20260728-fw-boot-b4-v10-3-9187aefa3f2f@collabora.com>
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

On Tue Jul 28, 2026 at 8:39 PM CEST, Deborah Brouwer wrote:
> +/// Locked wrapper for carrying out virtual memory (VM) operations on th=
e MMU.
> +#[pin_data]
> +pub(crate) struct Mmu<'drm> {

This shouldn't be 'drm, but 'mmu or just something generic like 'a.

The rationale is that Mmu might be shorter lived than 'drm once we have
self-referencial pin-init. Currently it is straight forward, such as in

	struct Foo<'foo> {
	    dev: &'foo platform::Device<Bound>,
	}
=09
	struct Data<'bound> {
	    foo: Foo<'bound>,
	}

where the lifetime of `dev` really ties back to 'bound. However, with
self-referencial pin-init it could looks like this:

	struct Foo<'foo> {
	    dev: &'foo platform::Device<Bound>,
	    io: &'foo IoMem<'foo>,
	}
=09
	struct Data<'bound> {
	    foo: Foo<'io>,
	    io: IoMem<'bound>,
	}

Now Foo is not constrained to 'bound anymore, as this would be longer lived=
 than
`io`, so it has to capture 'io instead in order to still compile.
