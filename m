Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB4606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjUyc13v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C42710E406;
	Tue, 17 Nov 2026 14:07:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8559610E406
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:06:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 433A2447A6;
 Tue, 17 Nov 2026 14:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7F41F000C5;
 Tue, 17 Nov 2026 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794924413;
 bh=ns0XAWcR6vSuKym0Hs01xZbTwbw63jJg9r2AMFjb7Cw=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=fjUyc13vnFbVpz4NMzIZg5RrMb+xNBv9KzK0pDNPSS+YMxxRFiAjzXos4A2Em8Cfn
 iWKgZHCxvUlB64mRGhTFIl64tRm9FoXFWAAOvn6xrr2QgRoBZy/9Kw1s71JiKeUX6f
 Ur32BhNHpuNgmKtzc/EA1JcLHacHMSPXxsnRa6Gw3Ez1W6vG+ds5BBJA8M1UZVGslo
 rfoy8hvcBsOoU6Asqae+ak9Hp4Y9nrqBZQIiixUTfZT45hDDLuSS3Hu1HUiPQUrd1z
 d4VmJaEqqX1m3yRPAiYfwqVJHqw0dsDk2Hg0qT4cABWwQNZckZ3yRSDIrlhFZ5kF5J
 4DLM0ECaKdaVA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 15:06:48 +0100
Message-Id: <DMXJLLR5G071.39YELPNJSLNZ3@kernel.org>
Cc: <phasta@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
In-Reply-To: <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
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

On Tue Nov 17, 2026 at 10:51 AM CET, Christian K=C3=B6nig wrote:
> See the HW eventually doesn't necessarily stop doing DMA if you unload th=
e driver.

No, if you can't stop the underlying device you must not unload the driver =
and
leak resources. Device resources (such as DMA mappings) are not safe agains=
t
this and it can cause UB in many layers of kernel, e.g. IOMMU.

> I even know about one case where a driver fully intentionally leaks memor=
y on
> unload because the devs couldn't figure out which FW keeps writing into a
> buffer.

Again, please don't finish unloading then; everything else will cause UB.
