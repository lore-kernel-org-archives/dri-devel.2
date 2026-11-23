Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF4606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6gtS408
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DDA10E4B4;
	Mon, 23 Nov 2026 23:49:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C5A10E4B4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:49:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EE4660018;
 Mon, 23 Nov 2026 23:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318A01F000C6;
 Mon, 23 Nov 2026 23:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795477762;
 bh=sAXNrWbDbP7ysg441+6RZE6+jFTIZd3JkPpVhxHYPgs=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=f6gtS408v2vNyAEMKpsOCu+0RDvmsVoB3kxhsZNNVWzBL0NfRDnzliSks/xqdXzwv
 XJiXA5TcMEdf7BDqF0QnQD235fvkGFLsyebML2Rmhmg5kdUfXAODOSeNRhUEBrlCfh
 tyv+1Wz61EYtrfOc7Ix2nfI5o36w8w8EyULCiN0BCqEchf7r0+30CyJLPD9ak0tLRo
 C1H+u3fxoeNIyLza93rnczJtxgcO/0ebfxysluULlEkV8W7eZGvOT4kYwj85pE32kZ
 DPLwGIcLqjISiPx5Lkvcc9asLsbT/HI4csQgv4UYZSxjXle9Kv5oeGRqwBuCIKSTNR
 Mf0gvM14dPPZA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 00:49:17 +0100
Message-Id: <DN2ZQV0NPYW5.2D6Z4TNR45UAF@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
To: "Matteo Kloiber" <kernel@matt3o12.de>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH 0/3] rust: dma: require device configuration before DMA
References: <20261123203926.1787169-1-kernel@matt3o12.de>
In-Reply-To: <20261123203926.1787169-1-kernel@matt3o12.de>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matteo,


On Mon Nov 23, 2026 at 9:39 PM CET, Matteo Kloiber wrote:
> Matteo Kloiber (3):

Thanks for working on this!

A few notes below, ahead of a proper review.

>   rust: pci, platform: pass InitTokens to probe()
>   gpu: nova-core: build Gpu inside pin_init_scope

I want to avoid wrapping everything in pin_init_scope(). Now that we have
pin-init self-ref, we can just store dma::Handle in Gpu itself and then bor=
row
it from GspResources.

>   rust: dma: require device configuration before DMA

I think this should be broken down in multiple patches, e.g.

  1. Introduce Setup, Params, and Handle.
  2. Convert drivers to configure DMA and retain/pass the handle.
  3. Change each DMA API to require a handle, converting all callers.
  4. Remove the obsolete setters.

Thanks,
Danilo
