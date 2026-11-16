Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C0606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dyAcSFRv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC4710F4B1;
	Mon, 16 Nov 2026 23:01:20 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260EB10F4C1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794870072; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gxZ8+24nZsy9bGwTP1y26p3//VIT57UUXtWB+Ccgn667GFa57AqnWp0yiJTKMRSHgbBOUYNdNIQT+2Lo78hLmWojyUZurVl3TMD14JKYmvq+1Fa+s4ETaSvWzj/DW23007fbSv4AZWEbCOHelOxOHl5u2K6emaz25+m5cXyWUEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794870072;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+NT34kLxa5Buh7EeSg6mueQnhrqQNWaU5x09tG502iA=; 
 b=iiI00f6/IYbLj1b4A6KRIs/we1VgRVpWYdZvo2IPZLg6QJS09faUYlR86ONp8FJSPCsHUeWO2RpIPHlhNcJZ6jYUYr8j2AErTf2zrBXjyZ8p7Qj0v0NRTZNfW49d2LC4HOhGWZR6fvUuF/QRhnPAwWFOdGCyT+JCizLPYBrmas0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=dyAcSFRvv3s59EvRAJG3KLf1F6B3YYlk49CVFsGwWvtPpL4Bes+MF87q9JMZEd7PdMPQVTodHgA0F1+KpPKJINz9qGs+5t5gDKj65+J2cQXm1YShryWM2LURIjPrwqvwlFaIGlDDoswZ0kc80ouvzwEaM/hgkddxOTOy+4oFO3w=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=+NT34kLxa5Buh7EeSg6mueQnhrqQNWaU5x09tG502iA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794870069850930.5156118632432;
 Mon, 16 Nov 2026 15:01:09 -0800 (PST)
Date: Mon, 16 Nov 2026 16:01:08 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Janne Grunau <j@jannau.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Janne Grunau <j@jananu.net>, Sami Tolvanen <samitolvanen@google.com>,
 Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, stable+noautosel@kernel.org
Subject: Re: [PATCH 0/3] Fix import of dma-buf buffers as DRM GEM shmem objects
Message-ID: <avuLNHy3bNAUpzNv@um790>
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.853.92
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:14:07PM +0100, Janne Grunau wrote:
> Hej,
> 
> this is triggered by the discussion of gem/shmem.rs SGTableMap issues
> in [1] which has an additional issue with imported object.
> Imported objects are supported since GEM shmem's AllocOps use
> drm_gem_shmem_prime_import_sg_table() as gem_prime_import_sg_table which
> sets the same function pointer field in struct drm_driver.
> 
> The code is broken in two ways. SGTableMap::drop() calls
> __drm_gem_shmem_free_sgt_locked() uncondiftionally which it must not do
> for imported objects as the object does not own `sgt`.
> The second issue is that the imported object is allocated by
> __drm_gem_shmem_create() with sizeof(struct drm_gem_shmem_object) as
> size instead of the size of Rust's Object<T>.
> 
> The second issue is already fixed in tyr's downstream driver by adding a
> `gem_create_object` callback which is used instead of the minimal
> allocation in the C helper.
> The first issue is fixed in the Asahi downstream driver together with a
> drm_gem_is_imported() wrapper change taken from the tyr downstream
> driver.
> 
> All three patches are tested in the Asahi downstream driver. As this is
> unused code in-tree I marked the fixes as not suitable for stable
> backports. The known downstream users of the code are aware of the
> issues and carry fixes downstream. I don't expect new Rust DRM drivers
> to be based on the (old) stable trees.

Thank you Janne for this. The second issue was recently flagged
by sashiko [1] as a critical memory bug that needs to be addressed
before we upstream tyr's ioctl series [2]. I checked that this series
on my Rock5B with the proposed ioctl series and igt-gpu-tools
tests that exercise some of the panthor uapi and everything looks good.

For the whole series:
Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>

[1] https://sashiko.dev/#/patchset/20261109-tyr-ioctls-v6-0-b2896bf2b3c9%40kylinos.cn
[2] https://lore.kernel.org/rust-for-linux/20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn/

> 
> Link: https://lore.kernel.org/rust-for-linux/20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com/ [1]
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (1):
>       rust: drm: gem: shmem: Do not free SG table of imported objects
> 
> Sami Tolvanen (2):
>       rust: drm: gem: shmem: implement gem_create_object for prime imports
>       rust: drm: gem: add an is_imported() accessor
> 
>  drivers/gpu/drm/nova/gem.rs  |  4 +++
>  drivers/gpu/drm/tyr/gem.rs   |  4 +++
>  rust/helpers/drm.c           |  6 +++++
>  rust/kernel/drm/gem/mod.rs   | 16 ++++++++++++
>  rust/kernel/drm/gem/shmem.rs | 62 +++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 91 insertions(+), 1 deletion(-)
> ---
> base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
> change-id: 20261026-rust-drm-gem-shmem-imported-sgt-85c4a45be283
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
