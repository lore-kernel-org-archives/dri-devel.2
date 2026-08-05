Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FFFC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A7510E1A7;
	Wed,  5 Aug 2026 18:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oKIksMlR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8252E10E1A7
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 18:29:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B8B941190;
 Wed,  5 Aug 2026 18:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD051F000E9;
 Wed,  5 Aug 2026 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785954578;
 bh=Ubge1xIhaMVtNlK1W4+X5SNrqz3ntDqZDTmYPkn/nf0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=oKIksMlRhAGkTOqGfbYfo2uxbddIDPJ6yRuC1+qz0HD367Nw3b5uYOY7dJs6so52h
 lPBCXxoBowrthLhtQuXnRCtfrCBvaNpishqA1ly4MRtnADuozm09vt/3ADBMG9VT1p
 sHCeYqeSdkUWyfKQYQmHKenSMrN7+VuS0ZRKwMl8uXLFyKsxYTnc5tw/MCBeLUmmLI
 ggBxcCdCTCPM7IIkH1PxMMHu9hGrczfwaqeUHJHXEbvL8qOtOBtF2pJmv5nEOHNnOL
 mF6nK8TqTY51otnDD0UUyZIImdB35MGEF+GZ7VXF4qwBwGi4jMOtjwSIlPD0dmk2Gk
 7iT75Pb8pB9+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com,
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 viro@zeniv.linux.org.uk, brauner@kernel.org, igor.korotin@linux.dev,
 vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, m.wilczynski@samsung.com,
 boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk,
 daniel.almeida@collabora.com, shankari.ak0208@gmail.com, lyude@redhat.com,
 j@jananu.net, lossin@kernel.org, acourbot@nvidia.com,
 markus.probst@posteo.de, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org
Cc: david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org,
 bjorn3_gh@protonmail.com, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, sergeh@kernel.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, jack@suse.cz, ljs@kernel.org,
 liam@infradead.org, bhelgaas@google.com, kwilczynski@kernel.org,
 ptikhomirov@virtuozzo.com
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>
References: <UWdIvfYijKEB-nyPuUo4FRBSzoE63d32sYuIQ9Cn-wWmceZpbNq-V2rcl_vTofMvOWAuXSPSc6YnxpYgwiMmjw==@protonmail.internalid>
 <20260628100731.64885-1-trev@trevrosa.dev>
Date: Wed, 05 Aug 2026 20:29:21 +0200
Message-ID: <87se4s775q.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

"Trevor Chan" <trev@trevrosa.dev> writes:

> `AlwaysRefCounted::inc_ref` is a function that shouldn't be called lightly.
>
> To prevent accidentally calling it, change `inc_ref` to be an associated function.
>
> Modify all `AlwaysRefCounted` implementors to work with this change.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1177
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Trevor Chan <trev@trevrosa.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg


