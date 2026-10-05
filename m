Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCFCCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E9210E1B3;
	Mon,  5 Oct 2026 22:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="BXEDuZi6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5590410E1B3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 22:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791240452; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X11IIrfVm/W6vJNHgNGmMI3FAg8acPtfYHLjLzAfW6mpqTmFWqT6eUpg05wFriIEjBZk4RlAvUrSYlrouvpjj/u50L7yPoU4/NdBuJAD57GQpKYP0H5J9Tcn16NoZGH64VzCPQ04d2bG2LYReNzj7sFXCF4jzvHYAWQ57Mfh7Tg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791240452;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aDPLd6m9eaalIuU0euZ4duF8q18K96/gVEz/CFzsn0A=; 
 b=Z0btMJ+uLUFkNgO958Usz1ssRX063i/YtURPBBb/LNYMvLpquTN/t9dkUbzNLRJ2lXvsFT1MeUev/x4iE7ic7rCE3nKHODFNNrc1VyT5md65CwZcpLCR0qM3E+8dtfjNBQjXIulT9gNuHpSd1jzvKc2qAC2UULofOYiXlnm5efw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791240452; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=aDPLd6m9eaalIuU0euZ4duF8q18K96/gVEz/CFzsn0A=;
 b=BXEDuZi6Iea1wSlWGLMW/6HR+gxwHv5oW9L/ajt5MGOsR8HNv0t4iiWekyS8FL6i
 S/qrvhpfQ57mlna6V2ElB/+NltSm4uNdqpcr4plD+y8BavgtEf81m0VsGVX5EiyxqNX
 8tKW4h0xD8xdyCo9tfQG4s6ieE6oobLQDGoa7vJs=
Received: by smtp.zohomail.com with SMTPS id 1791240450336816.4858411504894;
 Mon, 5 Oct 2026 15:47:30 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:47:29 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
Message-ID: <asQpARWOjeJRjhq3@um790>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
 <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.236.60
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

On Sat, Sep 26, 2026 at 04:50:37PM +0100, Gary Guo wrote:
> On Sat Sep 26, 2026 at 1:26 AM BST, Deborah Brouwer wrote:
> > Make the zerocopy and zerocopy_derive crates available for use when
> > building the UAPI crate and its tests. Then attempt to derive most of
> > the zerocopy traits for struct drm_panthor_gpu_info when generating its
> > binding. This will be used by the Tyr driver that needs the traits
> > IntoBytes and Immutable to safely copy the struct byte-for-byte to
> > userspace.
> >
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > ---
> >  rust/Makefile           | 12 +++++++++---
> >  rust/bindgen_parameters |  3 +++
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index da1a7409d984..bf02a1efd6f3 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -365,8 +365,11 @@ rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_ini
> >  rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
> >  	+$(call if_changed,rustc_test_library)
> >  
> > -rusttestlib-uapi: private rustc_target_flags = --extern ffi --extern pin_init
> > -rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
> > +rusttestlib-uapi: private rustc_target_flags = --extern ffi --extern pin_init \
> > +	--extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib \
> > +	--extern zerocopy_derive=$(objtree)/$(obj)/test/$(libzerocopy_derive_name)
> > +rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_init \
> > +	rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
> >  	+$(call if_changed,rustc_test_library)
> >  
> >  quiet_cmd_rustdoc_test = RUSTDOC T $<
> > @@ -782,11 +785,14 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
> >      $(obj)/bindings/bindings_helpers_generated.rs FORCE
> >  	+$(call if_changed_rule,rustc_library)
> >  
> > -$(obj)/uapi.o: private rustc_target_flags = --extern ffi --extern pin_init
> > +$(obj)/uapi.o: private rustc_target_flags = --extern ffi --extern pin_init \
> > +	--extern zerocopy --extern zerocopy_derive
> >  $(obj)/uapi.o: private skip_gendwarfksyms = 1
> >  $(obj)/uapi.o: $(src)/uapi/lib.rs \
> >      $(obj)/ffi.o \
> >      $(obj)/pin_init.o \
> > +    $(obj)/zerocopy.o \
> > +    $(obj)/$(libzerocopy_derive_name) \
> 
> Please add these to `bindings` crate as well to avoid have it diverging with
> `uapi`.

Ack.

> 
> >      $(obj)/uapi/uapi_generated.rs FORCE
> >  	+$(call if_changed_rule,rustc_library)
> >  
> > diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> > index 8402b0c93545..332bc8d6a9f7 100644
> > --- a/rust/bindgen_parameters
> > +++ b/rust/bindgen_parameters
> > @@ -71,3 +71,6 @@
> >  # Structs should implement `Zeroable` when all of their fields do.
> >  --with-derive-custom-struct .*=MaybeZeroable
> >  --with-derive-custom-union .*=MaybeZeroable
> > +
> > +# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
> > +--with-derive-custom-struct '^drm_panthor_gpu_info$'=zerocopy_derive::most_traits
> 
> This is Tyr specific change and should be in patch 2.

Ack, will update in next verion.

> 
> Best,
> Gary
> 
> 
