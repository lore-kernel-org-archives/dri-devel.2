Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01A21094478
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 13:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCED10E12C;
	Sat, 21 Mar 2026 13:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BaL9ovRU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5622C10E12C
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 13:54:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 858DB60103;
 Sat, 21 Mar 2026 13:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49715C19421;
 Sat, 21 Mar 2026 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774101262;
 bh=sbUn1F6RmDrL1YnZMN4GH02puIFrMpAq636vcbUPIww=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BaL9ovRUA6y0KRW3NlPMPYPGs54lj1hoEbBGJlDOF0aqPxj1atEohfx/kkUUAKwoP
 /zCmvF10MXRpe/XvQGJ6Y6ndWK3sWdj/DeDnoULVV6HGuMwWDofbzS/MAO43di/Yrj
 Ar+vekeMQwLCgWLcc97uM8WBJCGgCWXqNC+xGaU8bQQFiLVr/izOeQ+fiAAw/eTvWT
 GAlooFynnIKtlso6O55wY68C6T7ehTRaOph4UIxhwLOdyXnWtfGDCZnxRUgbsXeQz4
 pN63tTjq1HgWyXWl2rs4R91BiuMpGp9VYlF7JpCnlveiDYIg2yDj1mg+84vUH9YGvX
 anILdFYSegWTg==
Message-ID: <d7353cb7-a9eb-4b1c-9be8-161f5f68095a@kernel.org>
Date: Sat, 21 Mar 2026 14:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: gsp: move Cmdq's DMA handle to a struct
 member
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
 <DH7MBMNV5WPI.E9TXUC279THZ@kernel.org>
 <DH8I59NUUWR2.3LOLJPY6SEABC@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DH8I59NUUWR2.3LOLJPY6SEABC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/21/26 2:41 PM, Alexandre Courbot wrote:
> On Fri Mar 20, 2026 at 9:45 PM JST, Danilo Krummrich wrote:
>> On Thu Mar 19, 2026 at 7:00 AM CET, Alexandre Courbot wrote:
>>> The command-queue structure has a `dma_handle` method that returns the
>>> DMA handle to the memory segment shared with the GSP. This works, but is
>>> not ideal for the following reasons:
>>>
>>> - That method is effectively only ever called once, and is technically
>>>   an accessor method since the handle doesn't change over time,
>>> - It feels a bit out-of-place with the other methods of `Cmdq` which
>>>   only deal with the sending or receiving of messages,
>>> - The method has `pub(crate)` visibility, allowing other driver code to
>>>   access this highly-sensitive handle.
>>>
>>> Address all these issues by turning `dma_handle` into a struct member
>>> with `pub(super)` visibility. This keeps the method space focused, and
>>> also ensures the member is not visible outside of the modules that need
>>> it.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>
>> Linking my note from the original patch series [1].
>>
>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>>
>> [1] https://lore.kernel.org/all/DH60S91O053Z.1DDUJSL0D6NQQ@kernel.org/
> 
> Do you want me to add a `Link:` tag to the commit?

I don't think that's necessary.
