Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D421CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB10110EFF1;
	Tue, 29 Sep 2026 18:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="atsFqP6x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7BE10EFF1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:40:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BA08409F5;
 Tue, 29 Sep 2026 18:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA7B1F000FF;
 Tue, 29 Sep 2026 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790707232;
 bh=yDA+pcL7IQYIQQjtqHB088yezWAUg1S+dUpzwe1IcXE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=atsFqP6xdrngdjq/FqsLK5lxp5gYUSMSDrKWFJXXMcabyxDn+FSFmeK/E4zfjwlAJ
 zOjhQ+UigNp5RblAtNIJs+Z/dwwEdt1A4Ky40K45Y8sP+MdyeTH0hsRwPrXm0co5MT
 4/f5Gj/L9e3IVLtxh9YVYJDZs4/UHw9HL1Y+MCeeD4yaXDTPHHNWNEqLcygzwtEoLD
 VjfoyWEbfDQliIH3ulLZuRVJtSFJpJQ4df2gGQRhGSSC4UstvZ28htfaPod2zYULg0
 iASas7W75GDszMGgNadKO6AcYVRGy4bTpQqPCVjCJVhs/QMkQAtqCnxAAPuZXmBxQ8
 xFOxALfiFcuTA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 20:40:25 +0200
Message-Id: <DLS0QEPJKOPZ.1MX607W2OQ0RI@kernel.org>
Subject: Re: [PATCH v3 09/11] rust: device: expose dma_coherent()
Cc: <sunke@kylinos.cn>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Lyude Paul"
 <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-mm@kvack.org>, <dri-devel@lists.freedesktop.org>,
 <driver-core@lists.linux.dev>, "Alvin Sun" <alvin.sun@linux.dev>
To: "Ke Sun via B4 Relay" <devnull+sunke.kylinos.cn@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260929-tyr-ioctls-v3-0-26955fb111d5@kylinos.cn>
 <20260929-tyr-ioctls-v3-9-26955fb111d5@kylinos.cn>
In-Reply-To: <20260929-tyr-ioctls-v3-9-26955fb111d5@kylinos.cn>
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

On Tue Sep 29, 2026 at 4:15 AM CEST, Ke Sun via B4 Relay wrote:
> Add a thin accessor on Device<Bound> that wraps device_get_dma_attr()
> and returns true only for DEV_DMA_COHERENT. The other attribute values
> (unset, non-coherent) are treated as non-coherent.

Why not return a transparent wrapper around enum dev_dma_attr so we have al=
l
cases covered?
