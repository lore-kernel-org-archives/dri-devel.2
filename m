Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F8D1098793
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6931010EAF5;
	Fri, 20 Mar 2026 14:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NHD40AJH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762E210EAF5;
 Fri, 20 Mar 2026 14:51:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A23A661854;
 Fri, 20 Mar 2026 14:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB9EC4CEF7;
 Fri, 20 Mar 2026 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774018317;
 bh=c4iKsXS9FObY8UukAwlggqveq7EGRVJUILeikf6snDI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NHD40AJHDT02+DvH/U1AsJXl9mQNxpthbOfOD+j7zwpJXm63hipCalLLf5sapIWrX
 Xp3wwneQs9BXKqya3aLcaa7SgnGQedPzxvQrrke5GlT3E/glOW6X4wZqZ0A7P9KRqZ
 mykBOZeIl8huNcxg0UhMcDXwv8zl5eYXp6BSKOFmNKVTEeSqjcqwxXHkCtXBvD+2PR
 +37G9unuMj4jT1glUwytlEDQyI+bGy8bquPV+dNkv7nNnbXb3+boSwr/WOgYU59Mzs
 vaHTLzxjik+gcdVAmfnZC/lSbhrRMGfZxbwni4605oz24xg6W0jabK4Uw7V8gz+P8e
 Xsj9Q8jUdmseQ==
Message-ID: <480059c8-33e7-4f8e-bf03-b0d7ca3fd074@kernel.org>
Date: Fri, 20 Mar 2026 14:51:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] rust: dma: introduce dma::CoherentInit for memory
 initialization
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: aliceryhl@google.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, robin.murphy@arm.com,
 driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-5-dakr@kernel.org>
 <DH7OO4961WUH.1MM3MW1SVWI3I@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DH7OO4961WUH.1MM3MW1SVWI3I@nvidia.com>
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

On 3/20/2026 3:35 PM, Alexandre Courbot wrote:
> On Wed Mar 4, 2026 at 1:22 AM JST, Danilo Krummrich wrote:
>> +/// # fn test(dev: &Device<Bound>) -> Result {
>> +/// let mut dmem: CoherentInit<u64> =
>> +///     CoherentInit::zeroed_with_attrs(dev, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
> 
> Since this is an example, shall we use the simpler
> `CoherentInit::zeroed`?

Sure.

>> +    /// Initializes the element at `i` using the given initializer.
>> +    ///
>> +    /// Returns `EINVAL` if `i` is out of bounds.
>> +    pub fn init_at<E>(&mut self, i: usize, init: impl Init<T, E>) -> Result
> 
> Should this method be introduced in the next patch, or even in its own
> patch? It feels a bit out of place at this stage since the non-array
> `CoherentInit` doesn't have an equivalent.

The non-slice variant doesn't need it.

I don't see an advantage creating a separate patch for this.

> I was also wondering whether we could have an `init` method that
> initializes all the elements without having to zero the whole array
> first, but I guess it might be a bit difficult to implement in a
> flexible enough way.

You have this in the next patch, Coherent::init() works with arrays.
