Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94E606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lt37JKR9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81666112A33;
	Fri, 20 Nov 2026 13:14:07 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CF6112A33
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:14:01 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jWG4k1WDvzKmcF;
 Fri, 20 Nov 2026 14:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795180438; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ct9uYE0MzuKkAMie5CXMo99Xok8IAJAQ6knyjO+0/hE=;
 b=lt37JKR9rIh6DlBR0U+q0QMh6BHcGjljqKeNNe585NLbVM2ygPKRdX12oxxnuzcpj2ayN1
 LJJQNDX4/MMRlaGIF+wLLFH6IzidejaRKx9dlHHiKacZ8sZPi7e4OqG8KCBjBhbmbLSSzB
 pBTWzCfmfdsfRCQvMaKHBKA8OVJM5nn6+VazUHi6eMc5lo8F/PacL14BH//lG05dsaHvj9
 QLUevQvjcQfYH14M2k1oY4/x886KStGGfUKEhW/orEIha0Pz5Pjver2TZokT8jvQXrgWRa
 KO+Vr3ecu/cXkr6iqEGyhqoDtUnaocfjY8+oYSgjyWB8pbsNDekaQphEEnG8Eg==
Message-ID: <f8244837789536b0c339818a45aa3e6a52580a4e.camel@mailbox.org>
Subject: Re: [PATCH v4] dma-buf/dma-fence: Prevent misordering for error checks
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Simona
 Vetter	 <simona.vetter@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Fri, 20 Nov 2026 14:13:55 +0100
In-Reply-To: <9a434a22-249b-4121-a390-95eaedb5ba6a@amd.com>
References: <20261120111615.2940647-2-phasta@kernel.org>
 <9a434a22-249b-4121-a390-95eaedb5ba6a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: a7acc205da7b9c483bd
X-MBO-RS-META: ezmrjbsp5jwni611xb19k6cbdob6odsk
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-20 at 13:36 +0100, Christian K=C3=B6nig wrote:
> On 11/20/26 12:16, Philipp Stanner wrote:
> > Ensure ordering for everyone evaluating the error code centrally by
> > using test_bit_acquire() in dma_fence_test_signaled_flag().
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Pushed it to misc-fixes. Thx.

P.
