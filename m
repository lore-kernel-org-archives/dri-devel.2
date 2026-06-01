Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F07CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142D41132D8;
	Mon,  1 Jun 2026 12:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XnyElmHF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4177A1132D8
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780317455;
 bh=lCMKu+lhX2bTzCipYgh6dta6DZyvx/qQ1u6dRlK1K4E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XnyElmHFMDTdTGNIVEtlzzXcVa96Pc6E3TFbveZ7Xy43MHe7mvlNCENHMeWAYhcfM
 T/xO8js/ls/ibuWbSAxw0j5LwLDsB8sD+olEem9Oa9FnP3B+3BmMyZHg05XOhtyttW
 rp0OSxHpnjLCmsKLvb7P3Q86FISKXeTbffBMnPNOSb2hQtfljRVKANWsWr+tXqLd2A
 01sPSCmyV1rKnQphZ3/iDNM01dy5gxcjhPqZC+WbVRRIpG6pfCaRyh8Cha3clR4S5b
 6eThizeXVvNphYm5A6lDyKdbZTmn5ZVBvYz2JPBtTcfiGX3fUmGBgQTY/NkWAoGdY9
 Ao+OIZFyMS/aw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 99BE917E052F;
 Mon,  1 Jun 2026 14:37:34 +0200 (CEST)
Date: Mon, 1 Jun 2026 14:37:31 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Daniel Almeida
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Krishna Ketan Rai
 <prafulrai522@gmail.com>, Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
Message-ID: <20260601143731.71c0f883@fedora-2.home>
In-Reply-To: <ah1glmXDM-OAKa5h@google.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <ah1glmXDM-OAKa5h@google.com>
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

On Mon, 1 Jun 2026 10:36:06 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> > +pub trait FenceCtxOps {}  
> 
> This empty trait is unused.
> 
> > +/// A dma-fence context. A fence context takes care of associating related fences with each other,
> > +/// providing each with raising sequence numbers and a common identifier.
> > +#[pin_data(PinnedDrop)]
> > +pub struct FenceCtx<F: Send + Sync, C: Send + Sync> {  


BTW, if you define a FenceCtxOps trait, this should be:

pub struct FenceCtx<F: Send + Sync, C: FenceCtxOps + Send + Sync> {
