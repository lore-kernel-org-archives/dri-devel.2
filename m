Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65758CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 00:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7667310E3A1;
	Wed, 10 Jun 2026 00:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="kZOwsiH2";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA4110E3A1;
 Wed, 10 Jun 2026 00:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781050811; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Md6nNVHOEmyf92T+nDS9CJqqPti1DRSk4EGTpu6C0HNPBqi7DA1DYIbBx6XVRwZKGYg+7FAMp+zRe7yCffEmmdzShm8ChVUIErNYfWJ2C0Z5rs+Jr8hsTWIn9J8BQuxRZb4sbMgl4VDNNe+Fp/YF9+TLnLcWHr/2HsETWIA/0Fs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781050811;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O9fNTHv6wbBG42jHa8mAw6pvJNsDpQ9M5O3qhn0l1Vo=; 
 b=CtLCFoN/HUmgdMdaKxivguNvewtVOqnOf/GU04aTbIVSPmsAiqq9UfL62Sh1qJdTXzHGhlCky8R8LX2pYa39GqhrE6Q5y6NWBjh3JAboYzSpnuOv/I0JcGJ2wxwR6L9BGZsTO/owZFYHVWFWX4701w6nqoN2HlVw+vD+Fu7sY3Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781050811; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=O9fNTHv6wbBG42jHa8mAw6pvJNsDpQ9M5O3qhn0l1Vo=;
 b=kZOwsiH29/dAC81lSN65kYEuoTOcxiFWnRZI3eUfAzUyKksZvENO4jOoeUKfRUoY
 DRrLnkZ+tvZiLYP+qTTiiMl8pibUI+SDHnj/H9Qez+JfTBfn21bbtaEiqZZVW628ZQS
 t+lDFRobsq/ZdrPqaZCGglTpHn7wVk4iLg/THklE=
Received: by mx.zohomail.com with SMTPS id 1781050810087120.3536602556942;
 Tue, 9 Jun 2026 17:20:10 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:20:09 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>,
 Gary Guo <gary@garyguo.net>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Benno Lossin <lossin@kernel.org>,
 linaro-mm-sig@lists.linaro.org, Danilo Krummrich <dakr@kernel.org>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v19 0/4] Rust bindings for gem shmem
Message-ID: <aiituaFg3i4Qpb-a@um790>
References: <20260608183057.2001376-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608183057.2001376-1-lyude@redhat.com>
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

On Mon, Jun 08, 2026 at 02:29:00PM -0400, Lyude Paul wrote:
> Most of this patch series has already been pushed upstream, this is just
> the second half of the patch series that has not been pushed yet + some
> additional changes which were required to implement changes requested by
> the mailing list. This patch series is originally from Asahi, previously
> posted by Daniel Almeida.
> 
> The previous version of the patch series can be found here:
> 
> 	https://patchwork.freedesktop.org/series/164580/
> 
> Branch with patches applied available here:
> 
> 	https://gitlab.freedesktop.org/lyudess/linux/-/commits/rust/gem-shmem
> 
> This patch series applies on top of drm-rust-next
> 
> Patch-series wide changes since V15:
> * Fix some major rebasing errors I somehow didn't notice :(
> * Drop the dependency on LazyInit, use the trick that Alice suggested
>   instead.
> * Fix dependency ordering so that Tyr can get the vmap stuff first
>   without the other bits.
> Patch-series wide changes since V16:
> * Fix ordering one more time (SetOnce::reset() doesn't need to come
>   before adding vmap functions)
> * Rebase against the latest DeviceContext changes from me that got
>   pushed.
> 
> Lyude Paul (4):
>   rust: drm: gem: shmem: Add DmaResvGuard helper
>   rust: drm: gem: shmem: Add vmap functions
>   rust: faux: Allow retrieving a bound Device
>   rust: drm: gem: Introduce shmem::Object::sg_table()
> 
>  rust/kernel/drm/gem/shmem.rs | 524 ++++++++++++++++++++++++++++++++++-
>  rust/kernel/faux.rs          |  16 +-
>  2 files changed, 524 insertions(+), 16 deletions(-)
> 
> 
> base-commit: fea3a2dd7d3fc1936211ced5f84420e610435730
> -- 
> 2.54.0
> 
Thanks, it's working nicely with Tyr. To make this work with [1] I did
have to make a few changes to the KunitDriver and tests, but that
is a separate issue.

[1] [PATCH v2 0/7] rust: drm: Higher-Ranked Lifetime private data
https://lore.kernel.org/rust-for-linux/20260603011711.2077361-1-dakr@kernel.org/

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>

