Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BB7CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41E810F039;
	Wed, 29 Apr 2026 13:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HETBOgpT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7F210F039
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:58:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 91ACD4198D;
 Wed, 29 Apr 2026 13:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6167C19425;
 Wed, 29 Apr 2026 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777471136;
 bh=CkAYCE/5j2/fp11dlpM312pzX8TqG3LYxtTmYqCQDEw=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=HETBOgpT4IB8anE+gnU48PwtidV02pTBWMj9U9ARp8btM0k9xFdg5IXUEd5znKIBF
 UPYG3+5uYUUdrDNU+zayIzr4tyYNETQdktT1ve4s2qQvU82F6YIhJTVXBbk16tkm8U
 cDH9/GRyh77Of520Kyhijp1QdL63lV4SB6SEAMlEZfCVa+Ym6NBV7PelQquUb5xY3H
 k0mzt8XLmykgk4rEN+zzHE0FShYYpqQKfRYE6HV1f5xE9kRxe0dec7K9WRSnj/itys
 ECp2NfQsAxotUQVrF7xQ5gUW3qXRLNnU59OCVGL8lDaPdvyVR6m1DTGk1v2Uovvwmc
 aazSBOhiq0mNA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 15:58:51 +0200
Message-Id: <DI5OXGXY5IW4.281BBJHGITWR9@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org>
 <DI5LKWS7J1D7.1O8GCHRV28QZ2@nvidia.com>
In-Reply-To: <DI5LKWS7J1D7.1O8GCHRV28QZ2@nvidia.com>
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

On Wed Apr 29, 2026 at 1:21 PM CEST, Alexandre Courbot wrote:
> I'm wondering whether we could avoid introducing a Rust-only member
> here, either by just allowing the aux device private data to be used in
> C as well (which might be as simple as a rename, a couple helpers and a
> bit more documentation),

This is intentional; if this pointer would be shared we loose the guarantee=
 that
the stored pointer is either NULL or of the following form.

	#[repr(C)]
	#[pin_data]
	struct RegistrationData<T> {
	    type_id: TypeId,
	    #[pin]
	    data: T,
	}

This is important, since otherwise we can't check the TypeId independent fr=
om T.
Of course, we could store the TypeId in a separate allocation and use this
instead, but then we'd also end up with a Rust specific pointer.

> or using a wrapper type specifically for Rust
> drivers:
>
> struct rust_auxiliary_device {
> 	struct auxiliary_device auxdev;
> 	void *registration_data;
> };
>
> Although I am not sure what the implications would be for e.g. a Rust
> auxiliary device spawned by a C driver? Is that even doable with the
> current code anyway?

You gave the answer yourself with this. :) If we'd "subclass", there'd be n=
o way
to distinguish whether the struct auxiliary_device * passed by bus callback=
s
stems from a C or from a Rust registration, i.e. we'd not know whether the
"upcast" is valid or not.
