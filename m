Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B38FF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D4410E081;
	Tue, 28 Apr 2026 07:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qLETHfE3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A6810E081
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777360411;
 bh=nmfG9UmLOwACD+ZeOj7/HSaXXkzjAkBZZiJdwSNqVjQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qLETHfE3kcS6L1NFQJxQrMGYGpuPgIxPNjFzTBA6QJlKshwirqwZvz6togbPeQV0T
 yRbXi4UusNiv9PvFN2Im9Znu/m+UGta5m0V5om/PQtZXR9XBC7eDPrUdBpEi623SN+
 mgK2U+YvdQNFuc4TFtLEg+2xcGVJkvN+qTgdtD5em1qWyejKY0QDZoco+ZJHUy94wT
 GlrVloHkcYeVzWSxXJOTK1Zr/TW1jA4eBVxi2axXYhxUP6k1FBDoapAXumm+IP6nSA
 QZRWizKWGKxWY5/wCQQt9GmSD/d4j/Ykyytl+6EjeQEbc2oj7XwcEU7SxVOBJzHQi9
 k40AD+BMeRriQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6EE9F17E0E90;
 Tue, 28 Apr 2026 09:13:30 +0200 (CEST)
Date: Tue, 28 Apr 2026 09:13:25 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Benno Lossin
 <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 work@onurozkan.dev, alvin.sun@linux.dev
Subject: Re: [PATCH v4 02/20] drm/tyr: select required dependencies in Kconfig
Message-ID: <20260428091325.3b3c8878@fedora>
In-Reply-To: <ae_zEJv-H9bPv5jE@um790>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-2-a5d91050789d@collabora.com>
 <20260427092338.4e083a55@fedora> <ae_zEJv-H9bPv5jE@um790>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 27 Apr 2026 16:36:48 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> On Mon, Apr 27, 2026 at 09:23:38AM +0200, Boris Brezillon wrote:
> > On Fri, 24 Apr 2026 16:38:56 -0700
> > Deborah Brouwer <deborah.brouwer@collabora.com> wrote:
> >   
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > 
> > > Tyr depends on DRM_GPUVM, RUST_DRM_GEM_SHMEM_HELPER, MMU, IOMMU_SUPPORT,
> > > and IOMMU_IO_PGTABLE_LPAE. Select or depend on these symbols in Kconfig so
> > > the required infrastructure is enabled when Tyr is built.
> > > 
> > > Introduce DRM_TYR_STATIC_DEPS to keep the built-in DRM dependencies
> > > selected even when Tyr is built as a module.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > > ---
> > >  drivers/gpu/drm/tyr/Kconfig | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
> > > index e933e6478027..443ce988b570 100644
> > > --- a/drivers/gpu/drm/tyr/Kconfig
> > > +++ b/drivers/gpu/drm/tyr/Kconfig
> > > @@ -1,5 +1,12 @@
> > >  # SPDX-License-Identifier: GPL-2.0 or MIT
> > >  
> > > +config DRM_TYR_STATIC_DEPS
> > > +	bool
> > > +	select DRM_GPUVM  
> > 
> > IIRC, Danilo said we should have some boolean RUST_DRM_GPUVM option
> > selecting DRM_GPUVM for us, just like RUST_DRM_GEM_SHMEM_HELPER does.  
> 
> yes, I think Alice just sent that patch today. I have fixed it and
> will send it in the next version.

BTW, I don't think the deps should be added in their own commit, but
rather be part of the commit that starts using those deps:

- select RUST_DRM_GEM_SHMEM_HELPER in patch 5
- select IOMMU_IO_PGTABLE_LPAE, DRM_GPUVM and depends on IOMMU_SUPPORT
  in patch 10
