Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF842C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2134910E1E2;
	Fri, 25 Sep 2026 16:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="F/tcWsJc";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78D510E1E2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790353704; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MdsfFVxrSkLYQPPGY6Z+6FzCFPfUdPqICgV/A3fhkJ6P4Xs8E136h7S6I5943X6dCahBxrVGXNqvN9y6OmQ81CuyVMifHbgvFwXJdLJEsurYvTNtV9KEWBgVcSdhc5ZTHYOyyNxTocjuOU3V9FtiiTtAmQFEkkOhk1Jalf+SD2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790353704;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2vSghfXOezWDQ1X3SBhs5lQzlOszb8OvQbW7Q43qvhA=; 
 b=AX4ozuzp6ki5Ke4ui8Oz7WixAzE+X+Pl0SJr1fGzvJo8ck40lNyKLDx6gauCJCBmdmlomrZbykIIAo/ggdR1oAxRWwfuHeVGIDBQ/0wmtaW7xcW6MlNCoTMN9XBwQ2ILa9hhDpjaOkCnvSl43PnKN/65L2IxzF4EHvRrLUoXW2Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790353704; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=2vSghfXOezWDQ1X3SBhs5lQzlOszb8OvQbW7Q43qvhA=;
 b=F/tcWsJcvEjnYTzzp/GbQYKZRaQ/uQY3fYN8aoVxz8ZiPUOuCTfcn3TujWo/s7rW
 BkAYgKL8utlEE3FwEqDAQb1h+1Awr4Nvk1D9jwqusj0iunPWuNTxoRux0MGSJK8QJsW
 1Whu4Q84v2fpg7kgYC/FbSNr1/3v/Ql5NUMle5iI=
Received: by smtp.zohomail.com with SMTPS id 1790353703402972.0436234028067;
 Fri, 25 Sep 2026 09:28:23 -0700 (PDT)
Date: Fri, 25 Sep 2026 09:28:22 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
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
Subject: Re: [PATCH v2] drm/tyr: safely write GpuInfo to userspace
Message-ID: <arahJjCnXfqBVEu-@um790>
References: <20260924-b4-gpu_info_intobytes-v2-1-1b05e33df8a4@collabora.com>
 <CAH5fLgj=h_riWoOvEX_TOH3+0FNbKBtjO1OrxzwHDQq7uzXg_A@mail.gmail.com>
 <DLOBS2HQYSWS.2W0JMY91EZ48V@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DLOBS2HQYSWS.2W0JMY91EZ48V@garyguo.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.345.46
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

On Fri, Sep 25, 2026 at 11:29:07AM +0100, Gary Guo wrote:
> On Fri Sep 25, 2026 at 8:56 AM BST, Alice Ryhl wrote:
> > On Thu, Sep 24, 2026 at 7:22 PM Deborah Brouwer
> > <deborah.brouwer@collabora.com> wrote:
> >>
> >> Tyr creates the struct drm_panthor_gpu_info from the Panthor UAPI
> >> bindings. It initializes this struct by querying the gpu and then writes
> >> the struct into userspace memory faithfully byte-by-byte.
> >>
> >> Currently, the struct drm_panthor_gpu_info does not have any implicit
> >> padding, but if implicit padding were added in the future Rust does not
> >> guarantee that it would be initialized. Then when Tyr writes the struct
> >> back to userspace it could expose uninitialized kernel memory.
> >>
> >> Tyr implements the unsafe trait AsBytes for GpuInfo whereby the developer
> >> guarantees that struct drm_panthor_gpu_info does not include implicit
> >> padding, pointers, or interior mutability. This allows Tyr to safely copy
> >> the struct into userspace memory. However, relying on the unsafe trait
> >> AsBytes is fragile because if the Panthor UAPI changes, the SAFETY
> >> guarantees may no longer be accurate.
> >>
> >> Instead, use the derive macro `zerocopy_derive::most_traits` for struct
> >> drm_panthor_gpu_info. This macro will attempt to implement the zerocopy
> >> traits for struct drm_panthor_gpu_info. If the Panthor UAPI changes so
> >> that the traits IntoBytes or Immutable can no longer be implemented, Tyr
> >> will no longer compile.
> >>
> >> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> >
> > So this looks good to me
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> > but needs Miguel's ok since it modifies the Makefile. And I imagine he
> > may ask the commit to be split into two.
> 
> FWIW I do think this should be two commits, one making Make changes and apply to
> both uapi and bindings, and the second adding the Tyr-specific parts.

I'll split the commit and send a v3.

> 
> Best,
> Gary
> 
> 
