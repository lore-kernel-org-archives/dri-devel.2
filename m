Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBC4CDB466
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C222F10E7E5;
	Mon, 22 Jun 2026 18:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VK4fNUZ6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B3810E7E5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 18:54:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8B4C41A4E;
 Mon, 22 Jun 2026 18:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD701F00A3A;
 Mon, 22 Jun 2026 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782154460;
 bh=e78V7kgXMbJ2j9ruANspI4m79EuWYq9kaBl2A/1+vnc=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=VK4fNUZ66VH0IoNx9ToS161nQvezwA8NI56XiQv8YozxaJJXKPpQ6BoxyRyd6D3qH
 w10/rdsz06G0grAxgce2XQn6ei10M8tLdIr0WY/LCEldxduwFMDvKPX5Lupqos2+/6
 etuQmPEgEQ2aiO0vajGR4wLlJNx+7TfY/JfQWvjEDnPChpJEq+fjybdBtk/fZDQXau
 XzHC5zWFy7h0vk3BsRgw+oJ7uCd1Rjm+YX9MnX4nVpDs6Dpq2juey1k/J1b4kTmuo+
 h3sy3y/juj8WqDW5stjd3Jzd6KklCcf/ABRFs1iGZRQu5W451z2ufs9vu2GXnmi8Bd
 U/wc3XGBo3e9g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 20:54:15 +0200
Message-Id: <DJFT12M0PTGO.35EXUBXF6447F@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 06/16] rust: drm: restrict AlwaysRefCounted to Normal
 GEM Object context
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-7-dakr@kernel.org>
 <f476b05e5d57c312230fac93c2a52f1cbe061376.camel@redhat.com>
 <DJFRY0UZD7C0.37LIP9LNMBDLL@kernel.org>
 <0e66953ae97fa60f19d6f744716b3a4a23d86039.camel@redhat.com>
In-Reply-To: <0e66953ae97fa60f19d6f744716b3a4a23d86039.camel@redhat.com>
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

On Mon Jun 22, 2026 at 8:25 PM CEST, Lyude Paul wrote:
> On Mon, 2026-06-22 at 20:03 +0200, Danilo Krummrich wrote:
>> One thing I had in mind is that we could have TTM callbacks that guarant=
ee us a
>> Registered DeviceContext that could be represented by the corresonding G=
EM
>> object. Of course, it could also be represented by a separate
>> &Device<Registered> being passed to the callback.
>
> IMO I think this is better - especially since when I originally introduce=
d
> DeviceContext the intent was that it should be something that we try to o=
mit
> wherever possible, so users mainly only need to interact with it in vario=
us
> callbacks that have assumptions about the state of the Device. This makes
> sense logically as well, since the only reason you would need to manually
> specify the DeviceContext a Device is in is when you're running Rust code=
 that
> has been executed from a non-Rust context.
>
> I think for Registration this is definitely ideal, since now that we're t=
rying
> to give it the ability to represent "This device is -currently- registere=
d"
> vs. "This device was registered at some point" trying to avoid generalizi=
ng
> types over DeviceContext helps to ensure we don't mistakenly pass through=
 a
> Registered DeviceContext somewhere we didn't mean to. E.g., allowing a us=
er to
> store a gem Object with the Registered device context would technically b=
e a
> leak as it would then be impossible for us to guarantee that all Register=
ed
> devices are presently registered.

In general I agree; and I think I also brought it up a few times that it wo=
uld
be nice to avoid making GEM objects generic over the DeviceContext.

But now that we already have it (and it is out of the way with this patch
already), I think it could make sense to wait a bit and see how the TTM stu=
ff
turns out before we go back and forth (I think it may be useful there)?

At least I'd prefer to do this in a follow-up patch and, if required, discu=
ss it
there. Do you mind sending a follow-up patch, given that you already looked=
 into
removing it entirely?
