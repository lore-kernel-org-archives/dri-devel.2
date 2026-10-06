Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E5ACA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 22:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B88010E413;
	Tue,  6 Oct 2026 22:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JsA1JsL2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073D310E413
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 22:20:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2AE5409C0;
 Tue,  6 Oct 2026 22:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635BD1F0089B;
 Tue,  6 Oct 2026 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791325219;
 bh=6XEv2S3lnEbAy/rtFG4gRenDM0hZDhO4PFP4tPnmJgg=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=JsA1JsL2LMhAHfQBfq2zOYKpu3aBiDPbM9+qCx47t5J4ZoutScrZRdpf5snaqchnh
 oeDdyLcKtNqlOdTlHqo995YUWeUvIEXkib2VAv7uZmvRQ6veh1MdP4JEPRpsWRMW1D
 +3++f/TXJm3mbvJVZIMQGyb0fbmn0e2xBop9WlmLVzVYshJ42qyjQ8x7oozD/M4a6n
 tsdi2zNjfUz7bwm9xdqSD+nrJp/43Zmyq2Dzwd8IqH9pzlpoxltrAnfBtMgYeg0FHT
 9gJjdnxVnWx7PU5HH6HgOp3zIRH6bnzWbo0ad2H9UCQaZItBRwYgNn6UFKJbzH8gEF
 2/4vV69bHSXSA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 00:20:15 +0200
Message-Id: <DLY3SJLA1YG0.1YBCCD2CAH2IC@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: firmware: fwsec: use zeroed() to
 zero-pad buffers
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "Timur Tabi"
 <ttabi@nvidia.com>, "Robin Murphy" <robin.murphy@arm.com>, "Tim Kovalenko"
 <tim.kovalenko@proton.me>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Thorsten Blum" <blum@kernel.org>
References: <20261006100442.80432-3-blum@kernel.org>
In-Reply-To: <20261006100442.80432-3-blum@kernel.org>
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

On Tue Oct 6, 2026 at 12:04 PM CEST, Thorsten Blum wrote:
> -            let mut ucode =3D KVec::with_capacity(aligned_code_size, GFP=
_KERNEL)?;
> -            ucode.extend_from_slice(code, GFP_KERNEL)?;
> -            ucode.resize(aligned_code_size, 0, GFP_KERNEL)?;
> -
> +            let mut ucode =3D KVec::zeroed(aligned_code_size, GFP_KERNEL=
)?;
> +            ucode[..code.len()].copy_from_slice(code);

I kinda dislike that this is now a potential panic, but it does better expr=
ess
the intent.

Can you please add a corresponding // PANIC comment?

Thanks,
Danilo
