Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47DCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4AA10E08A;
	Thu,  2 Jul 2026 04:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hlFNzB7n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463CB10E08A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:35:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0818C4346E;
 Thu,  2 Jul 2026 04:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FB71F00A3A;
 Thu,  2 Jul 2026 04:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782966933;
 bh=qQ6AcPC+6tAtj4mR79LcDBehZQeOv0pwvXO06/ad9J4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hlFNzB7nDQ4wPhvzbuKbP7GlttuU2+McLfPo+tBfpaAbDLr39y3b3z0mZaLOE1eN+
 Xo2KpqTODQ1oEMKC6rNpXHgGCK6z9PsUpN5ZzJpQh6WBqWf1yxTen0hhagAsMl4KLh
 EOYnlxm6yckhDLSgZkrC8A/X8eChraULH0VifJBljelorzVLYzY3/PH13GiGANpOGa
 OqAMGqqGmOgt4xlD07tejTYPjOL2rtlWbwURWVcURymn+zPjDnGA2Z2Sh13RvVLR9n
 NT+ShiFAoe5irKBTqEocdhZybA5kduIgLOLlfu9ZFsfvGjKOwuupoz5mDrJYebK/3W
 DdaQZz6WuWtkw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfauth.phl.internal (Postfix) with ESMTP id 054CDF4007E;
 Thu,  2 Jul 2026 00:35:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 02 Jul 2026 00:35:32 -0400
X-ME-Sender: <xms:k-pFatVPHD-wfdcSt5DDIq0s1NHyp_qvyNMB7Cnk_mAIFVN99cSmmA>
 <xme:k-pFanQ-sHo2pzbTosB-CFoipUa6MDm1Mo5fd3bLkilkXUlzuJoHlIWY6oJ_7OlAf
 _HkIch71sdhk7R_vNUGv1UjDNUH-NabtwC2tMUfAweW3CUybftI>
X-ME-Received: <xmr:k-pFaosQeL-3gUkbDkM8DPrL66eOsQLai29P1S0YNMxBPx_fmkLJi506iGiMHSCphMEaJ9muXD3M0p_XwWBFpaXMw2bkylnL>
X-ME-Proxy-Cause: dmFkZTGOWROfQ5BeBPMP1RytPcByPAeRGYXaRj56CjJShjBvVAial8V+/PhS9tKRf9j4Ua
 XZcHmtCjilWnt9dRtPHRHfnBfoErbVRWDu6Z6yvc6r9FWcVn80Zqq/aEldJ98LYAK9xv4T
 PAy07CxqyOcIe953y1bCgmlQP8fIX8Ckiib7dYq50y7uL+thRqbjSqENvf0nMGGlZMnE/D
 ARY8TqA7CA75MgyK3o+hv72aa89IkKbCBOdG8ohGu4REqrLaNC2ODUlNduW41yh/gbu9TA
 Ey+UgG9Pfo6TRFJPTPet4cA8Y89vISFu50HAW82CkBUBzokLysd358b/TKxbZ0Eluhv3b2
 dmNzxENhqsuBg6lrPSMoCv+wNdjTxXsb2L7kg3NLEfArWJVpZHfy4p09f+XDjEi9GjJymd
 gMJMdEM+zDF5bp7qgHB4NkEMcKZIKDo9VH1z9ng+qKsjhsyZeEQzeginJsm0oCLGO5RsV8
 usyj9TY+fHLmM94EJCxWRRud/n3u+jMQHRFHRMm8IqYUKgYQqanOmQd2lVtgruUsC1Om6o
 dMzpADLMJMe9I/YmRD2bFzN+t89L836nIp2/CSHVwXnudd33/3j+m44k5rFdbn4vdFTB/M
 j0jBoan9AqnJVUWxoXUwzcBszVsEfsT161gh74B9/VLDpww8pvVfN/2QXoRQ
X-ME-Proxy: <xmx:k-pFaoYLIT92EgYrSPsjR4GFqeWHIQLZ9F6gCvB8srd-AdWAZkwfAQ>
 <xmx:k-pFar-gvME-Shrg5pq5qLV9yM-vOcbbi_OPHCav_xDhLmiIevCGEg>
 <xmx:k-pFaqCvyWS_NQVvrkPPINpbxuja7jrpLRPtqhd6_r6xvj1zqqQebA>
 <xmx:k-pFanvk_OFE-DDi32qJw2OT5W-9aOrycyM6hPeCbcleNSVjk_8p3Q>
 <xmx:lOpFakbghDJU3owT6epJUFnsOhG_qLz8TSDD4hmq-L5Z81S_LXG-gFzT>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 00:35:31 -0400 (EDT)
Date: Wed, 1 Jul 2026 21:35:30 -0700
From: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,	nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,	lkmm@lists.linux.dev,
 Eliot Courtney <ecourtney@nvidia.com>
Subject: Re: [PATCH v2 1/4] rust: sync: add helpers for mb, dma_mb and friends
Message-ID: <akXqkldA4NnODxAC@MacBook-0RXW5>
References: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
 <20260609-rust-barrier-v2-1-30fcc48e1cd0@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-rust-barrier-v2-1-30fcc48e1cd0@garyguo.net>
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

On Tue, Jun 09, 2026 at 04:38:37PM +0100, Gary Guo wrote:
> They supplement the existing smp_mb, smp_rmb and smp_wmb.
> 
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Queued in rust-sync, thanks!


Regards,
Boqun
