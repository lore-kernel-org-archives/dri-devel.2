Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B678CCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD541121AF;
	Wed,  3 Jun 2026 17:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XZ067zuT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17E81121AF
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 17:36:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DDC986008A;
 Wed,  3 Jun 2026 17:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAF1F00899;
 Wed,  3 Jun 2026 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780508180;
 bh=W0atkC16En4IZdbZdsjQCqRJTQ/DFbwkWu7nB7JU7rQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XZ067zuT+zSmlyt0tNWWWAEVuaJn7eTw7avNuL3/EmI7L9S1qYOEJMmbxyRWKf4/+
 72RW1kYzkbFCwPm8Qv2V2g3ZWizE9yxMLJdT7eQYc06e3zURBiPjwkQFnUnngfBncS
 fL0jjihTX/tcRtfA5oCT/ucF3Xx/a/hJutUrCB9oySrWa4fMW2//yzHkFf0kKs3RWS
 vv+M/tJ/RMHF3uDbTVttVpEaQ/6pTZgLVg33mnGLYAqrSqFObJsGSSSlgnDDi49QAo
 5Afv3HdavgVTi+IYD7GzlGAINWmb35tZthHr7ZFE70As1Mz+GZldi3k8WJrrsk9USK
 r19J54EdelY2g==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfauth.phl.internal (Postfix) with ESMTP id 00F26F40076;
 Wed,  3 Jun 2026 13:36:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Wed, 03 Jun 2026 13:36:19 -0400
X-ME-Sender: <xms:EmYgakmDEdhpTVl_WevR5FD2XgK8yHnavi6_-lejRvlqtVxcyrD34A>
 <xme:EmYgagmmGa__kdlLlByW8q9iaLSrjoYHsMhpnRzkuG7P0k6XN_CFBBvKbU1s0TSeL
 CaIc_OYk7q_w-GpKeUVhe6xLQf25U34QEpZpAOdZ5bBhtaadDL-7A>
X-ME-Received: <xmr:EmYgaiOShT93iIwSlKdA5xiXK4_XcvBxd28PYRZ8vs5RYoKsNuacHoO-Fvo>
X-ME-Proxy-Cause: dmFkZTExiAM4S4b6rbDBhYcsipt+WIcQ6U92Lpa8QXEozbKBUuNKniuqF8nLee6VGz/1IM
 wH6MVeq3StWv5bWz4ExZ/72JO0pdsE/ERKzl1Iak6MH3IHVKCisb2zKFOiWyK1VU3RoKDM
 9OnABto/ClwFrxe0LbbCc/Urw/R6p8Xjq28WIPem4wxbpq1/FJ3pE+iZS5/fH9BBNpEK0k
 Py0InZHQ+GCPlEffJv06Lhqaxtlhb82z+KTZACF67znSkQXHpsH9PhF/f5iO6JCaXaJL9C
 mfpvi8h/iV12rJIfTbMWXQgJ8TrK2rnhiX7vmT/FZMuXUIsxVNaxup2eCLx9K5GzlGY9bq
 7W0aE11bk31uSLtt0kamnoXI/FseX6YWbA0HCpgFi/yp2k1iT5hz5rZQVW/vNPaHZsa+Gk
 Gi2rQ1Pjw/iWKAb0VSccByuRxHo58Y0r4u6Ra9htuCzrz7kflCTBMjnwhg88aPL4AHDFSM
 UxNFI3WeQPpPzCEzDf2pOCWqB475UqLzKUu7a9dVnSOX2v/yF87QF3iLuhU45iwjLslLkY
 EdkAKhG5/QK/aWZjzR0NQ+M6lBaaPVpzjcr+q+RfYtHue87beXg7Q2cOJeZYMpL+Sdc5EX
 pFXxEXoo5A6YDWE1fAsvBcpZQigub9OcACkAIUgZPkJJnKUqWpchmmlv5KuQ
X-ME-Proxy: <xmx:EmYgapMF0_L7rcF8njCmaB8Np2WhsRwIUyPwh8tsG9nkbplnj7HguQ>
 <xmx:EmYganHUyR9F7eLuQ6I1T3DUUgWD3flki5o_JNttRj4Jaqqc0WelqQ>
 <xmx:EmYgano-0gjNnHZcUEHJRktEzt6deD11ds10nYaz0fK8UP8h29_wNQ>
 <xmx:EmYgak8ksADbxYFMj44ImNygib9jFYCpnzUlT_eoPSlHJWElAY9pEg>
 <xmx:EmYgaoQZqpT6gnp3USQITMG_I8BoTGRAa-cNGbBns6qS8R3RaX6VCDT7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 13:36:18 -0400 (EDT)
Date: Wed, 3 Jun 2026 10:36:16 -0700
From: Boqun Feng <boqun@kernel.org>
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>,	Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: rcu: add RcuBox type
Message-ID: <aiBmELaetTWXcmhu@tardis-2.local>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-4-phasta@kernel.org>
 <ahr9gtzQLSbPeBx_@tardis.local>
 <e8b16f3b40d42f3b0a8814180fa9b06f82c9d901.camel@mailbox.org>
 <ah2L-TMT5UHSd_Hs@tardis-2.local>
 <441fccce521857ab82b84bb8e5ab539ee3810a36.camel@mailbox.org>
 <aiBH95n4HqrNtgtz@tardis-2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiBH95n4HqrNtgtz@tardis-2.local>
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

On Wed, Jun 03, 2026 at 08:27:51AM -0700, Boqun Feng wrote:
> On Wed, Jun 03, 2026 at 11:33:27AM +0200, Philipp Stanner wrote:
> > > > > and Philipp can use the `RcuKBox` in this patchset. We also need to impl
> > > > > InPlaceInit for RcuBox, but that can be added later.
> > > > 
> > > > So shall we merge my series with Alice's patch, and later we add your
> > > > patch and other features, or would you prefer to have the additional
> > > > boxes from your patch from the get-go?
> > > > 
> > > 
> > > I would like to have it from the get-go mainly because of RcuBox vs
> > > RcuKBox naming. Thank you!
> > 
> > Fine by me. Just process-wise: how should we do it?
> > 
> > I could include your patch on top of Alice's. Would be a bit more
> > consistent regarding the git-workflow if we'd squash the two patches,
> > but then you two would have to agree on authorship.
> > 
> 
> Keeping it as a separate patch is fine by me.
> 

So is squashing ;-) Whichever is easy for you.

Regards,
Boqun

> Regards,
> Boqun
> 
> > All is fine by me, but I wanted to ask instead of just do A or B.
> > 
> > 
> [...]
