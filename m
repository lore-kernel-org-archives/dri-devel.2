Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48125606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAVFNlJf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D9310EC98;
	Thu, 19 Nov 2026 16:40:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE5210EC98
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:40:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 18AB745FA4;
 Thu, 19 Nov 2026 16:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A232E1F000C6;
 Thu, 19 Nov 2026 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795106404;
 bh=4VzLDqafiDWhFr/DdyeQKRM0NcRyz0FQybaldYQnsfI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eAVFNlJfeKEpL3/1EoXVrCxRiDu8TI68rMxzUh6PyVPkfJHM6mhJtUlPG251K/mka
 EmohQMaTJjXvqrIh/PScsUcXS0ekfsl7MlFOs07dLr5sv7T3OtDT9mQTPrU2XNcSdz
 2jUATcuZqTkfxQaGMPf4FA3hR9HiPMLfo27Nx9wu1DfalCfN3h/8ci6AegDh77/P19
 r1RBBlIcy8FyzZnOyp3JZGZ3fWqjWS+u8TQGd8ocwC1YMmXOyQmLXeCHCKrn199EJW
 yIMXO54WsNrzbe7MXbrGJ6klwNF9Z8a6Pl7oc2gK3ynn5DXFkB4n9sRnM23Mc/CNne
 3zyrFBDTIYYxw==
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
 by mailfauth.ams.internal (Postfix) with ESMTP id 11CA81980066;
 Thu, 19 Nov 2026 11:40:01 -0500 (EST)
Received: from ams-frontend-01 ([10.64.2.36])
 by ams-compute-01.internal (MEProxy); Thu, 19 Nov 2026 11:40:01 -0500
X-ME-Sender: <xms:YCb_ag4uDpFv27jn8CuOXBWSlmjSm9tRhoOrzPGim8aX3Y3ZfjS0Lg>
 <xme:YCb_aqrLerbacfGddxYK089spM0P86UjoaoqUHYLaKrvD40CZTKlHrpTe3bbFov-g
 3N5rxdrmx8UvjxF5ug4IJtzO9GCyWYSjU5josYIAQaXeb5n4eAaZznI>
X-ME-Received: <xmr:YCb_auKSmnzgaYae-HO4xGpoZPsNEOWRu3byDAEoNTdFoYBf34pzADgAuy0ll66_0A>
X-ME-Proxy-Cause: dmFkZTGCPjoSuxH0fAr9/QnGtf8k3qsXIbYvox3eF/ev855AN0NnwQRh0s20wnNReHI1mY
 1MAs9dMfamltZFMfqcy6+GfGyTX7DTk8ofBSdS7O2AMMfY+YbZOv74NA7tjTng5rsio6fM
 XtC0FXS06fnB4LX3qCH2PP+aSO/+6usSr7B8DOeMITWtWC1smW0U85jJhuwNn94wlYtiqJ
 0Bptk5nAhgHjEWgvXkd6fr442yCMs9se7hPNXEfwwgtHpUZXMHnHRHfE6rAZ5WfD+qMgzP
 +jcqdzVRbn3pucq50T05OEQA0SdBnL3lUgJWZ4+XmwYQTgmc2GfatiBA5e4VzS9+8g5WnD
 LLLJ5hKxn2aE11lvcZIkIotu0LMKbXzm+oiQb1iItFYVu8GSnLRAN0p5vaRWy8E28KH3OS
 XBYDaHmbJ8VccXQJohUWZMOeGSQIQJzJEPwBRg0ylzXnFnEGAS/GUrRgVL1+Ji2cZlGQO2
 XG6VP/e9S3ieVC5SEOr83ezGJm0Pqt2LblcRqG/TW0xsQ/YUnJjrFrkasGYlKNw3a9QW2x
 qnhpHmvwR1Ck8tsXvV6VEpjr9X+1k8LWTLqyv0pydXq+I8touW/KfSnAivDgh2E4aNCks6
 XzIJ3YEYuZ6O/YrpVItZfMLGTTY8pLMiaUo2rtzKcQTlZofeEllU/gQqwW7w
X-ME-Proxy: <xmx:YSb_angtOrQ9cdKh5y_zsmvogKSnnwLAkUcZJOUjnPgDq1iA5uW7OQ>
 <xmx:YSb_an_r9ZfhCeranaw1GK6tWV0JIlirCLc_II0fKPEhsP9idd8L5g>
 <xmx:YSb_aroVVOQ7xVkFNV9SrhBlj7c9_WUmC-WHnmrZ80exb1F4mHP9-Q>
 <xmx:YSb_asNlcCzHNrtb9rCsQuCzQaYJ0JqSjzz_HcwNHZ383jiWP07u6A>
 <xmx:YSb_ap7j7-XMhuElr4Zsoz6DW5WFmRz4yumvWFuIUenOKjyw3leS6wTN>
Feedback-ID: i78584a88:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 11:39:56 -0500 (EST)
Message-ID: <44b2b390-e5bf-49ce-995b-724be11a9ff7@kernel.org>
Date: Thu, 19 Nov 2026 17:39:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: drm: gpuvm: rename UniqueRefGpuVm data accessors
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Sami Tolvanen <samitolvanen@google.com>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 5:36 PM, Alice Ryhl wrote:
> `UniqueRefGpuVm` currently names its shared and mutable data accessors
> `data_ref()` and `data()`, unlike `GpuVmBo::data(&self)` and standard
> Rust naming conventions. Thus, rename them to `data(&self)` and
> `data_mut(&mut self)` for consistency.
> 
> Link: https://lore.kernel.org/r/20261118111653.448550-1-aliceryhl@google.com
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
