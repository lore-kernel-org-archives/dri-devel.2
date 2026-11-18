Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA57606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=kMQ2IVGZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5233610FC73;
	Wed, 18 Nov 2026 13:16:05 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0E810FC71
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:15:59 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jV2Cw1MlDzMlpB;
 Wed, 18 Nov 2026 14:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795007756; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yW4osrFS24wgu8pSOiR70jM4pZlWA15tPUFvK4+40fk=;
 b=kMQ2IVGZHdYSJi1qr7AZ9ssQhavYnyXjudHLXhc5Gz4zhD67Q5LNKVdw/Q7Kf3s7YRMYyT
 z14c4Gxh3PGt5WK59jRYiVr1b2r1qNmAdnntGsByfYF4p0ivZZ7H2p0RvH+EFN9Nez2qSS
 cUP+vHa6VeOhBAlRkNj7rIOY33r84D5HLofQpEcar11/GSuVbkA/tSPTuWzf3aVtMF3Wmq
 B3GGpAFcM8mKji5LdLlnzrMuA8AUTiySFzS5Hx/epY8d4q7Yhu0urRLCB5XylYeA34k8EI
 vYD6ldQhNbIySbQZT5QISSNB5Llj01NBQehK86haf2EU0duawmxW41BL0xPb6Q==
Message-ID: <3792b7f8f4729820a924e0d60d17c97489827732.camel@mailbox.org>
Subject: Re: [PATCH v2] dma-buf/dma-fence: Prevent misordering for error checks
From: Philipp Stanner <phasta@mailbox.org>
To: Gary Guo <gary@garyguo.net>, Philipp Stanner <phasta@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Simona Vetter <simona.vetter@ffwll.ch>, Chris
 Wilson <chris@chris-wilson.co.uk>, Danilo Krummrich	 <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 18 Nov 2026 14:15:54 +0100
In-Reply-To: <DMYCSXNA6VQ9.22FS1PMBBYWRO@garyguo.net>
References: <20261118110914.1471416-2-phasta@kernel.org>
 <DMYCSXNA6VQ9.22FS1PMBBYWRO@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1cf2ae9d8dfe671f094
X-MBO-RS-META: ko59io9p5mbdaggd9b7y5om1iqooo31t
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-18 at 12:59 +0000, Gary Guo wrote:
> On Wed Nov 18, 2026 at 11:09 AM GMT, Philipp Stanner wrote:

[=E2=80=A6]

> > =C2=A0static inline bool
> > =C2=A0dma_fence_test_signaled_flag(struct dma_fence *fence)
> > =C2=A0{
> > -	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> > +	/*
> > +	 * Best-effort ordering of the locklessly evaluated signaled-bit,
> > +	 * especially so that reads of fence->error are not misordered.
>=20
> I am not sure if this should focus on the error, or it should just provid=
e a
> general guarantee that anything happens before dma_fence_signal is visibl=
e when
> signal test returns true. I would lean on the latter?

See below.

>=20
> > +	 *
> > +	 * The release counterpart is typically ensured like this:
> > +	 *=C2=A0=C2=A0 a) Error codes must only be set before a fence signals=
 and
> > +	 *=C2=A0=C2=A0 b) The fence's spinlock's barriers effective in dma_fe=
nce_signal()
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ensure ordering.
>=20
> Spinlock has nothing to do with this. The only thing that guarantees the
> ordering is test_and_set_bit in (c).

Why not? A spinlock includes full barriers. If it were set_bit()
instead of test_and_set_bit(), it would still work.

>=20
> So probably easier just to say something like
>=20
> =C2=A0=C2=A0=C2=A0 /* Pairs with test_and_set_bit() in dma_fence_signal_t=
imestamp_locked */

It is easier.

I am, however, unhappy with the unclear state of the API contract. It's
still unclear what the signaled-flag even is supposed to mean. So this
comment was also supposed to hint at the unclear state.

The desired meaning aimed for by Christian is that it's only meaning is
"hardware is done".

But as we see here it has implications for the entire semantic, too:
a) signaled =3D=3D true -> the error code is valid (what else?)
b) The fence has either signaled or "is still signaling", i.e. running
callbacks

I still maintain the position that it is inconsistent to run
test_and_set_bit() under lock protection and evaluate it without the
lock. Should be one or the other, not both.

Note that this patch intends just to hot-fix the error code evaluation,
not to make the fence API fully consistent. It's currently not even
clear whether manual flag evaluation is legal. It used to be legal. I'm
the one who added dma_fence_test_signaled_flag(), but mostly for
readability, not for semantic correctness.

It should be illegal to evaluate error codes with anything other than
dma_fence_get_status(). But there then the meaning of the spinlock is
currently also undefined. The lock there, with the current thinking,
would seem surplus with this patch here.


P.
