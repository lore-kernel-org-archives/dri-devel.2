Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED5AF4611C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD7D10E3EF;
	Mon, 23 Mar 2026 14:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dEpGLon/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3659E10E3F4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:21:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5302860120;
 Mon, 23 Mar 2026 14:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D61C2BCB4;
 Mon, 23 Mar 2026 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774275669;
 bh=pfaja9npXTBJVbbZ5cSxz+J/eQvQ2fURUlrTlcqfBVc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dEpGLon/VMU7tngHZQ6W9Iv45XhgyyUNQ0Awe81b5ojuhstGoG34Fn3tryY6cN57T
 MG/LXWFfie6UKPM4CAttKSQW4bTNwTjg6rheBJ7kAS/JGVA2J0nU6HAHfplUYiaEsT
 ESfY3WXfOs/fRuE3x/JUuaYxGJyszEWhtMZWryPGD5S9HKAyQb4AiHq2SwKuoqS6QS
 PFD4iITcnjOy+2Hh2mgY3C2FULVR0zk5owMwsZiJNQMlHsCKKCZHZDqyQ0b9xA1v0i
 sjlCxWOxRDXY+jHW3AflPSU7DxokNJMEtTbfUom7Q4GSpJp3JC0JWF/dAV8t4SNtw+
 1KC88Wq135mAg==
Message-ID: <9a458b4e-982f-4371-8db5-295fce95f0ba@kernel.org>
Date: Mon, 23 Mar 2026 15:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] gpu: nova-core: convert PMC registers to kernel
 register macro
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
 <20260323-b4-nova-register-v3-1-ae2486ecef1b@nvidia.com>
 <DHA4EQAOO8QW.3AFGNJZFQX6N7@kernel.org>
 <DHA81784G24U.1446CUTJC271J@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DHA81784G24U.1446CUTJC271J@nvidia.com>
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

On 3/23/26 3:11 PM, Alexandre Courbot wrote:
> On Mon Mar 23, 2026 at 8:21 PM JST, Danilo Krummrich wrote:
>> On Mon Mar 23, 2026 at 12:07 PM CET, Alexandre Courbot wrote:
>>> -impl TryFrom<u8> for Architecture {
>>> +impl TryFrom<Bounded<u32, 6>> for Architecture {
>>>      type Error = Error;
>>>  
>>> -    fn try_from(value: u8) -> Result<Self> {
>>> -        match value {
>>> +    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
>>> +        match u8::from(value) {
>>>              0x16 => Ok(Self::Turing),
>>>              0x17 => Ok(Self::Ampere),
>>>              0x19 => Ok(Self::Ada),
>>> @@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
>>>      }
>>>  }
>>>  
>>> -impl From<Architecture> for u8 {
>>> +impl From<Architecture> for Bounded<u32, 6> {
>>>      fn from(value: Architecture) -> Self {
>>> -        // CAST: `Architecture` is `repr(u8)`, so this cast is always lossless.
>>> -        value as u8
>>> +        match value {
>>> +            Architecture::Turing => Bounded::<u32, _>::new::<0x16>(),
>>> +            Architecture::Ampere => Bounded::<u32, _>::new::<0x17>(),
>>> +            Architecture::Ada => Bounded::<u32, _>::new::<0x19>(),
>>> +        }
>>>      }
>>>  }
>>
>> Can this use bounded_enum!()?
> 
> If we move it outside of `falcon.rs`, yes. I didn't want to make too
> permanent a solution with the `TryFrom` macro being developed, but if
> you prefer that way that's doable. I guess `bounded_enum` would need to
> be in the root module though to be accessible by both `falcon` and
> `gpu`.

Since we are going to have it as an intermediate solution, let's be consistent
about it. Maybe num.rs is a good place?
