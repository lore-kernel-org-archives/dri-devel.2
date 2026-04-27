Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427B6FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 23:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B354510E9A8;
	Mon, 27 Apr 2026 23:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="JgQctkD9";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C6810E9A8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 23:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777333011; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mVtBRvbv7KKJLThCZ6nLF1OXuXyhmQ2wCU4O6/6QsZW9AqvJv0LzsBvks5j6g9jMiFrcrgeaJGzxIdR3DgoKTupgvKJsWAXRk+vD64TKsSVTPmr9MtktZbA97EER6yatFwdf6cgeNiPb89tVQjYyvDCf2JGvIYwTzIVU3hlOzQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777333011;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7hpeqhF3jnEv6T8olU96rzYxcW7mlYBS6IkFNCMTEhI=; 
 b=TJhDd4LfhAucFUQYgLYicbRw0JUDFdVW7ny3d9G0/zFa4Wy//Af1jF87bufnalG6PZ/TBDwmb8F4pr0SM/9XKQE34ajLuCXaZDoD7JUkIi4wSVn2T9QvjIC9RQv1L3K8Pntg48/5sADNFHUxMtZcu5MX1bJqTA0g1iPIOUzONb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777333011; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=7hpeqhF3jnEv6T8olU96rzYxcW7mlYBS6IkFNCMTEhI=;
 b=JgQctkD9snGp1HfHKxlUsUpxDdoOsC2De1qV5Nw99bPkyEIjkho9MxJuchnsgtDf
 pIKnyE7IphrI7eAA35g9WncjXNS11U31jDJmbutw0A8zcr2srvvQlFN9mKL3Qp6hP0T
 QO8JQ8u6J8SDgfiuPafk4egaQJ7kw/yxbkhgMMp8=
Received: by mx.zohomail.com with SMTPS id 177733300908413.680628273178513;
 Mon, 27 Apr 2026 16:36:49 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:36:48 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, beata.michalska@arm.com,
 lyude@redhat.com, acourbot@nvidia.com, work@onurozkan.dev,
 alvin.sun@linux.dev
Subject: Re: [PATCH v4 02/20] drm/tyr: select required dependencies in Kconfig
Message-ID: <ae_zEJv-H9bPv5jE@um790>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-2-a5d91050789d@collabora.com>
 <20260427092338.4e083a55@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427092338.4e083a55@fedora>
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

On Mon, Apr 27, 2026 at 09:23:38AM +0200, Boris Brezillon wrote:
> On Fri, 24 Apr 2026 16:38:56 -0700
> Deborah Brouwer <deborah.brouwer@collabora.com> wrote:
> 
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > 
> > Tyr depends on DRM_GPUVM, RUST_DRM_GEM_SHMEM_HELPER, MMU, IOMMU_SUPPORT,
> > and IOMMU_IO_PGTABLE_LPAE. Select or depend on these symbols in Kconfig so
> > the required infrastructure is enabled when Tyr is built.
> > 
> > Introduce DRM_TYR_STATIC_DEPS to keep the built-in DRM dependencies
> > selected even when Tyr is built as a module.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > ---
> >  drivers/gpu/drm/tyr/Kconfig | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
> > index e933e6478027..443ce988b570 100644
> > --- a/drivers/gpu/drm/tyr/Kconfig
> > +++ b/drivers/gpu/drm/tyr/Kconfig
> > @@ -1,5 +1,12 @@
> >  # SPDX-License-Identifier: GPL-2.0 or MIT
> >  
> > +config DRM_TYR_STATIC_DEPS
> > +	bool
> > +	select DRM_GPUVM
> 
> IIRC, Danilo said we should have some boolean RUST_DRM_GPUVM option
> selecting DRM_GPUVM for us, just like RUST_DRM_GEM_SHMEM_HELPER does.

yes, I think Alice just sent that patch today. I have fixed it and
will send it in the next version.

> 
> > +	help
> > +	  Ensure required DRM infrastructure is built-in when enabling Tyr
> > +	  even if Tyr is =m
> > +
> >  config DRM_TYR
> >  	tristate "Tyr (Rust DRM support for ARM Mali CSF-based GPUs)"
> >  	depends on DRM=y
> > @@ -7,6 +14,11 @@ config DRM_TYR
> >  	depends on ARM || ARM64 || COMPILE_TEST
> >  	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
> >  	depends on COMMON_CLK
> > +	depends on MMU
> > +	select DRM_TYR_STATIC_DEPS
> > +	select IOMMU_IO_PGTABLE_LPAE
> > +	select RUST_DRM_GEM_SHMEM_HELPER
> > +	depends on IOMMU_SUPPORT
> >  	default n
> >  	help
> >  	  Rust DRM driver for ARM Mali CSF-based GPUs.
> > @@ -16,5 +28,5 @@ config DRM_TYR
> >  	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
> >  	  be supported with the panfrost driver as they are not CSF GPUs.
> >  
> > -	  if M is selected, the module will be called tyr. This driver is work
> > +	  If M is selected, the module will be called tyr. This driver is work
> >  	  in progress and may not be functional.
> > 
> 
