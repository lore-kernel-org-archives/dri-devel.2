Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F349606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gV0tG84/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA9910E23D;
	Sat, 21 Nov 2026 15:28:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5259510E23D
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 15:28:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6E734236A;
 Sat, 21 Nov 2026 15:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E7F1F000CA;
 Sat, 21 Nov 2026 15:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795274919;
 bh=tu2X+l79DQrXYjw0mWYuuJBKGa/OqdTNT6ih39CCmpI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=gV0tG84/xLm6saYJjUQa3vCjzk+tZ+zwn6yjheIhUtg1SHIwTvc849mGY2YbgO4El
 sZb0ltUST4jqfnjbJ9xs3OpOP8abEJbGNVQpw0qRqudAnbYf9FweH8rCnai9gxc7Xl
 vlYDGXtTrmotbjzRYzlhvvIq+p5MzoPnoRpiW+OJwuz9mIQixfMxfew7j0XYYnZIUZ
 8X9GelY5JMdx6O3VdO24+P2iRsEN3joIXKb2NvvkmQ1YEipwCFvROO4J4B2PwmUlPI
 +B5Wvvb6FftMexmYUZKJ7ysn6fQl+P2Mu1iByQKFvz6aKbu0RN/kA4UErV19TlH32s
 NeA2wjcVvDNZg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Nov 2026 16:28:35 +0100
Message-Id: <DN0ZUECUCER4.QK2US2HOR3I4@kernel.org>
Subject: Re: [PATCH v2] rust: gpu: buddy: store the allocator inside the Mutex
Cc: <rust-for-linux@vger.kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Arun Pravin"
 <arunpravin.paneerselvam@amd.com>, "Joel Fernandes" <jfern@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Ivan Tverdokhleb" <mbkchelofficialdev@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261119111850.33270-1-mbkchelofficialdev@gmail.com>
In-Reply-To: <20261119111850.33270-1-mbkchelofficialdev@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 12:18 PM CET, Ivan Tverdokhleb wrote:
> @@ -313,16 +313,11 @@ pub struct GpuBuddyParams {
>  ///
>  /// # Invariants
>  ///
> -/// The inner [`Opaque`] contains an initialized buddy allocator.
> +/// The `lock` field contains an initialized buddy allocator wrapped in =
`Opaque`.
>  #[pin_data(PinnedDrop)]
>  struct GpuBuddyInner {
>      #[pin]
> -    inner: Opaque<bindings::gpu_buddy>,
> -
> -    // TODO: Replace `Mutex<()>` with `Mutex<Opaque<..>>` once `Mutex::n=
ew()`
> -    // accepts `impl PinInit<T>`.
> -    #[pin]
> -    lock: Mutex<()>,
> +    lock: Mutex<Opaque<bindings::gpu_buddy>>,

I think we should keep the name inner.
