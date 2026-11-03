Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD595606D814
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jedt5tC8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0645410E112;
	Tue,  3 Nov 2026 15:52:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BAF10E112
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:52:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B53DA43F0C;
 Tue,  3 Nov 2026 15:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1221F00A20;
 Tue,  3 Nov 2026 15:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793721152;
 bh=OSWWLNaCncajP7f07TaYWk/J71EdrtuxQ8PVqj5RikQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jedt5tC8Ck3n2udgbM3f2I5u8fuSJ4YTWjWzcWkKNCRSlcyMFkhpsLBerutGmFt0r
 ku0pmW68l7HZJyqUSczNQaBORelJqaeUxpxp83cX7b+/1iwHQRK5GZMJcdMvAP4k6k
 SMts0DLIXyFRXi5yw//BqnXg8n+sem3q7+LD9NHYkkWJJiK61B6ijfEHHeSbZk+wxv
 b1uaI7nss8EpAMCmVdXNc5Ni1RuuXoADCUN1EAz6o7HBKZcCNKXU1r6aJbA6PCtA7a
 kUQk0Mm203uFbC86qWR27xPC9Y+otnvw5Nveq+WrcRGYFvQDZi6Scs8B3shfrdz263
 hm7ZEe1fd+MYw==
Message-ID: <sashiko-outbox-195660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 6/8] rust: DmaFence: Tell results in signaling
 callbacks
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261103153138.1087330-8-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
 <20261103153138.1087330-8-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:52:31 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: dma_fence: missing closing brace in DriverFence doctest
--

commit 71f83d6d3879ba695c584c9c6ba8d757e416fe9e
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Tell results in signaling callbacks

This commit updates the FenceCallback::on_signal() trait method in
rust/kernel/dma_buf/dma_fence.rs to pass the fence's signaling status as a
Result parameter to callback implementations.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 9cef604f17ea9..8c5d2a415504e 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -671,8 +681,12 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCon=
textOps> {
>  /// struct CallbackData { }
>  ///
>  /// impl FenceCallback for CallbackData {
> -///     fn on_signal(&mut self) {
> -///         pr_info!("DmaFence callback executed.\n");
> +///     fn on_signal(&mut self, status: Result) {
> +///         if status.is_ok() {
> +///             pr_info!("DmaFence callback executed.\n");
> +///         else {
> +///             pr_err!("DmaFence callback executed, but fence has an er=
ror.\n");
> +///         }
>  ///     }
>  /// }

[Severity: Low]
In the DriverFence doc comment example in rust/kernel/dma_buf/dma_fence.rs,
is a closing brace missing before else in CallbackData::on_signal()? When
both CONFIG_DMA_SHARED_BUFFER and CONFIG_RUST_KERNEL_DOCTESTS are enabled,
building the kernel doctests fails with a syntax error because the if
status.is_ok() block is not closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103153138.1087=
330-2-phasta@kernel.org?part=3D6
