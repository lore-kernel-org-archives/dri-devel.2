Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FD1CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7273210F826;
	Mon,  8 Jun 2026 17:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kUHCV6/e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB1E10F826
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:59:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E85D43A89;
 Mon,  8 Jun 2026 17:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637D81F00893;
 Mon,  8 Jun 2026 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780941586;
 bh=q2JqATLztu+mIBVuhWa8EiLN1hz2Egk+EZOysl2E1h4=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=kUHCV6/ezHm16sVuomaCS9gJrTOweRjwt3q9+UtmWmTxStpGTivrtB1eWFoPeGTRi
 Rt1rYLWtTlbygc6r7E1o3j234o8PH7MkGBgbgDrmb3oMAWu57Xq+WFIXYJFoGCXoHz
 VG120l533CGIe9Tkjbe4fVAGbgJvzkL1Qt+LyOR+ZMdECbY9d39OTW+ylMga4MxFSD
 uaUXJq43RAMak/XdyjRKHviGfGTs5m1vA4QyIffN3ZFbGQJj+e98O+u4y2LZoSS2Vq
 DCjTk+LOp3hVUTmJdiV0VL7NqiQmGRZORKd1d4EHF75sMs3UTPKN6PMViSfZpfdKjj
 KCZTTCkCOaOPg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 19:59:42 +0200
Message-Id: <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
Cc: <phasta@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <dwlsalmeida@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
In-Reply-To: <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
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

On Mon Jun 8, 2026 at 7:34 PM CEST, Christian K=C3=B6nig wrote:
> That's why we need the RCU grace period to make sure that nobody is
> referencing the driver stuff any more.

Right, and that's what Philipp tries to address, the requirement to wait fo=
r an
RCU grace period is perfectly fine if it is only about freeing memory, but =
it
can become painful if the fence private data contains data also needs to be
destructed in some way.

IOW, if a driver signals a fence, it is lifecycle-wise reasonable to destru=
ct
the private data that is no longer needed (remaining users only deal with s=
truct
dma_fence) and having to wait for a full grace period adds sublety and
complication that can be avoided with the proposed approach.

That said, I'd like to ask the opposite question: What are the concerns wit=
h the
proposed approach over (pure) RCU?
