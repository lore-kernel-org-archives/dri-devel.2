Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E08109C027
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DCC10E038;
	Wed, 25 Mar 2026 14:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ACjLKRP6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D5110E038
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:47:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A0DC60120;
 Wed, 25 Mar 2026 14:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65550C19423;
 Wed, 25 Mar 2026 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774450024;
 bh=JCkHCcMSXx/SH5QNREKTXs5UKLFyI2shlYFECOVHDjw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ACjLKRP6WLjmtHAUiVk6vUGQ8g4pcVYEy+cfD27z5i5FCrB5GOMtjuxiETqZGCgBC
 d7WcctHAiUWcUUH0ERJEgJurResU9IJTn70DfWakzVF8TcZzXgMyVys3czZLoFSyVZ
 EswJzzA7lry0SJGZGFQEzstvRxVixw5fToPLZ/C+cYOezjapKPKKpx13a11n/YgoDI
 KWKjJ1b0qrRBEV8DmQt7IVlQ+P9uodoaxf6qwcbamMy0hMu03dwZEZ4blK9ruguDmA
 LtkP8FvODGMcg4Un5llA/s0xq3CAcOe3XWLleTs/061c61euupBDiL8CbW+uVt/+jO
 Eo8K06CPUdqGw==
Message-ID: <f3db51e4-b175-4f0d-b6d5-30970a57c173@kernel.org>
Date: Wed, 25 Mar 2026 15:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] gpu: nova-core: convert registers to use the
 kernel register macro
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
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
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

On 3/25/26 3:46 AM, Alexandre Courbot wrote:
> Alexandre Courbot (10):
>       gpu: nova-core: introduce `bounded_enum` macro
>       gpu: nova-core: convert PMC registers to kernel register macro
>       gpu: nova-core: convert PBUS registers to kernel register macro
>       gpu: nova-core: convert PFB registers to kernel register macro
>       gpu: nova-core: convert GC6 registers to kernel register macro
>       gpu: nova-core: convert FUSE registers to kernel register macro
>       gpu: nova-core: convert PDISP registers to kernel register macro
>       gpu: nova-core: convert falcon registers to kernel register macro
>       gpu: nova-core: remove `io::` qualifier to register macro invocations
>       Documentation: nova: remove register abstraction task

Acked-by: Danilo Krummrich <dakr@kernel.org>
