Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ACDCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79469112038;
	Wed,  3 Jun 2026 15:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="j5WYXppv";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F1E112028
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780500203; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D/0dxtUblON0mXObz6BR/PDgkNDFDP/80FrqnGoouLQJ14XmDwwmnX5FsiqGaK6+7ge+DF3OW9MWDOve00+M/FJ3FuGAq4Cp7cNWW5JmxeFgYza1SA7tMDNWVx1AtAUq19YATy9XmC3899kfKwsj8lDFT7zjCGZC5FuftLJrapM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780500203;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=So9rH2Wa9Qe/DNplu0afd7KojnM7XszJ5ToWirB61zg=; 
 b=aMPm3sSfvKgr1e0Q4dy9VwmM2KrrIarsGVzDsWf52uuVfY/oTef29laLpXXNOnVwAlH+MkzBJx/Aig5+Ck9PAspdgvppkWJrEhJR1fwQhr/+tdXpSlZExTZSsJgyo1n9s00uACQAbMTpuHYGCgzyAIQ97cuzXUoYnTAETLdV0uE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780500203; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=So9rH2Wa9Qe/DNplu0afd7KojnM7XszJ5ToWirB61zg=;
 b=j5WYXppv0gWakahQAHN3IARwLLtuiyzF5As+zXBSFYIEqglZKhqBq2zQ4K/+ZuoG
 wHFprTnd4InI66J91owt/Ro2rUWwtmfPGyxRbUGxCnvgFYc0Z5/EmjwnN1IQJazNi3+
 cUV5Wx+6Y5mE2h6HdfzkJCA98VUtadRlBLg/YAXw=
Received: by mx.zohomail.com with SMTPS id 1780500200690832.6247679096393;
 Wed, 3 Jun 2026 08:23:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/4] rust / dma_buf: Add abstractions for dma_fence
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260530143541.229628-2-phasta@kernel.org>
Date: Wed, 3 Jun 2026 12:22:57 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9AA494AE-3CC0-4D8B-8D44-3DBB654A7880@collabora.com>
References: <20260530143541.229628-2-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

I tested this on Tyr and both GNOME and kmscube work, with a few
(small) caveats. I will address them in the respective patches.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
