Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2027D108B91B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4A010E54C;
	Fri, 20 Mar 2026 12:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mxySD56j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B478010E54C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:45:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6037443C54;
 Fri, 20 Mar 2026 12:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CAAC4CEF7;
 Fri, 20 Mar 2026 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774010743;
 bh=DIVRo4pf9YQUx5O/1lAbqeDjeGJvDIX5h8Lg31+I4IE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=mxySD56jeCO+XeyDMoM3S0orTZ/jgbZIsdw3ZKPl8yHhi1To5LLOWrL8PDA3nH4PL
 HH0LUFkbQw326oUPKK84FeJA8m6oE0/xHCTEo2mYtRG++ZJXMYMS9e7TTdyhjxa4gs
 wUEWv99T5EepqiPa0CYcFrQyM0GVoTk4g3GxJ2viAKMClj6lUU/0edZiks+CnfG/6N
 ivsDGlqGilLuaZdKm5oOhyo8BotJaY52WV7UV7KaT6AoEyaXfEMlHJymxjfyc5YW9W
 FXJLTofP+v4aWIZ7WSRKylWsSm8ihT0sIbCEPEcVGpbS7Qu73dRt0Xr/xnA9Mg5vSZ
 JthjwrvqVadeQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 13:45:38 +0100
Message-Id: <DH7MBMNV5WPI.E9TXUC279THZ@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: move Cmdq's DMA handle to a struct
 member
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
In-Reply-To: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
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

On Thu Mar 19, 2026 at 7:00 AM CET, Alexandre Courbot wrote:
> The command-queue structure has a `dma_handle` method that returns the
> DMA handle to the memory segment shared with the GSP. This works, but is
> not ideal for the following reasons:
>
> - That method is effectively only ever called once, and is technically
>   an accessor method since the handle doesn't change over time,
> - It feels a bit out-of-place with the other methods of `Cmdq` which
>   only deal with the sending or receiving of messages,
> - The method has `pub(crate)` visibility, allowing other driver code to
>   access this highly-sensitive handle.
>
> Address all these issues by turning `dma_handle` into a struct member
> with `pub(super)` visibility. This keeps the method space focused, and
> also ensures the member is not visible outside of the modules that need
> it.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Linking my note from the original patch series [1].

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

[1] https://lore.kernel.org/all/DH60S91O053Z.1DDUJSL0D6NQQ@kernel.org/
