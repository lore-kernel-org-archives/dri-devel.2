Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3192C54F51
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B80110E5D9;
	Tue, 28 Jul 2026 20:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="H1LIDzYy";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D27910E5D9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 20:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785270928; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=f2/jRC+MITzs+rDlKhMHrYc3cx38Cx5UCcIzffZ8twp5YQltQEEA1imSuNP8GmGFBImSKWsTRamuleFkXLxdh/3Z1+sK8aSbvw3pQX8KBRJ2ouBm5/v/CsqOp/BF8teQo34FumXDv9nI3FnFILBwzNWsX9Elif73I4ReAhINDKE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785270928;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YhxTGf5YXkQYjZLE3DoklfRuPngjyDj+Ylg5ViviS+g=; 
 b=Zokw+rmBE/8vtwEgAJtsKPycT5uqipcMQ9nCZouODuVT+foJmcYO9CTZyV8oqQc8ev3qDDU+uVeW93N7CmoSv3ykcwTAsHTqtVv9ewIapBPX0qqssDIKGhM7J5zgKXJKaW9N6FTNm6/tzCrIZEljuEZpj4y9GCLaeeOdNc8wuPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785270928; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=YhxTGf5YXkQYjZLE3DoklfRuPngjyDj+Ylg5ViviS+g=;
 b=H1LIDzYyE3qnL2DpZtUbBsCMb8P+4gVaco4Asw2jesTz1aJRJ3fGtMEkpp1ZGBHm
 oDKN0taXlwBqvwlKfJvMssKJk5Qu8FQv7XSVHAvY/ANNY5vOo4sn57rMjn6AyR0zFWn
 Ut7OhLjA5rPwMyvjzMupq38Ws2U/0GvTdyrI5xMo=
Received: by mx.zohomail.com with SMTPS id 1785270925370174.37285430042743;
 Tue, 28 Jul 2026 13:35:25 -0700 (PDT)
Date: Tue, 28 Jul 2026 13:35:24 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, laura.nao@collabora.com,
 samitolvanen@google.com, lyude@redhat.com, beata.michalska@arm.com,
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev
Subject: Re: [PATCH v10 3/7] drm/tyr: add Memory Management Unit (MMU) support
Message-ID: <amkSjDCt_P-TfXHD@um790>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-3-9187aefa3f2f@collabora.com>
 <DKAGDGAGBRXN.T20HFE198R5A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKAGDGAGBRXN.T20HFE198R5A@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.252.37
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

On Tue, Jul 28, 2026 at 09:31:50PM +0200, Danilo Krummrich wrote:
> On Tue Jul 28, 2026 at 8:39 PM CEST, Deborah Brouwer wrote:
> > +/// Locked wrapper for carrying out virtual memory (VM) operations on the MMU.
> > +#[pin_data]
> > +pub(crate) struct Mmu<'drm> {
> 
> This shouldn't be 'drm, but 'mmu or just something generic like 'a.
> 
> The rationale is that Mmu might be shorter lived than 'drm once we have
> self-referencial pin-init. Currently it is straight forward, such as in
> 
> 	struct Foo<'foo> {
> 	    dev: &'foo platform::Device<Bound>,
> 	}
> 	
> 	struct Data<'bound> {
> 	    foo: Foo<'bound>,
> 	}
> 
> where the lifetime of `dev` really ties back to 'bound. However, with
> self-referencial pin-init it could looks like this:
> 
> 	struct Foo<'foo> {
> 	    dev: &'foo platform::Device<Bound>,
> 	    io: &'foo IoMem<'foo>,
> 	}
> 	
> 	struct Data<'bound> {
> 	    foo: Foo<'io>,
> 	    io: IoMem<'bound>,
> 	}
> 
> Now Foo is not constrained to 'bound anymore, as this would be longer lived than
> `io`, so it has to capture 'io instead in order to still compile.

Danilo, would you be ok with renaming this lifetime as a follow up
patch? Currently, if I understand this correctly, the mmu lifetime is
still tied to the DRM registration data, so the name is not inaccurate
for Tyr at least as it stands right now.

