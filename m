Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E220606A882
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RYTOeDst
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0103010F851;
	Tue, 17 Nov 2026 17:47:20 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C4010F85B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:47:13 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jTXHL4Pwcz8v5T;
 Tue, 17 Nov 2026 18:47:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794937630; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lX51Mfz1mJ4y/S3UG7mwW4k5DzJAY1kWSKMs4mbXKg=;
 b=RYTOeDstKKPOhsZfw9LnuApiBQ0YwHDBumHIFGRDBY1WybOVpRVW4hgychjVPHh/UKowN7
 X4flyauLehyoqxmP1gIB+N5QX+s/lTn5WTNQR3S/P1am1iCxZk/Wo+VbmMlaiTlkMw4c4r
 re+Z/B1DR2mzn+GYWbPnfgPMhLJDf3A6d49/FNQIfz2VngzfL8++OTAFZEh9wqqYEoSjGi
 /sRxZzEhFLobgp/+moiCkLBQuyj8rsSF/fh1eFmUFwcL21WoYr8fBkhsrjOBIavBiYWKoH
 EzMlxnG8EX3BtgpgYCrhbD1IrLE8+ISllrHU1c/dMSwwrs384zMb15+vIuK5RQ==
Message-ID: <3005c4692d538785e225f9372e4a261dc457edb2.camel@mailbox.org>
Subject: Re: [PATCH] dma-buf/dma-fence: Prevent misordering for error checks
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Simona
 Vetter	 <simona.vetter@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 17 Nov 2026 18:47:08 +0100
In-Reply-To: <efce5fe0-6e7d-417c-93a3-35247b431448@amd.com>
References: <20261117090144.581909-2-phasta@kernel.org>
 <efce5fe0-6e7d-417c-93a3-35247b431448@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: ecb0f878edf8740d1a6
X-MBO-RS-META: hx6d7wgupk6yr6hyqbay1awpyj4e9j6c
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

On Tue, 2026-11-17 at 15:55 +0100, Christian K=C3=B6nig wrote:
> On 11/17/26 10:01, Philipp Stanner wrote:
> > Many users of dma_fence do things like:
> >=20
> > // Thread A
> > dma_fence_set_error(f, -EINVAL);
> > dma_fence_signal(f); // <- Takes lock, which orders against the above.
> >=20
> > // Thread B
> > if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
> > 	pr_info("err: %i\n", f->error); // <- Can be loaded first.

[=E2=80=A6]

> > +	//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_and_set_bit() should do the tri=
ck.
>=20
> That should probably be a C comment, e.g. /* ... */.

huh, how did that happen=E2=80=A6
-ETOOMUCHRUST

I provide a v2

> Apart from that really good catch.

Found without any LLM 8-)

I saw it while reworking Rust-fence to force users to always evaluate a
fence's error code, i.e., you can only check whether a fence is
signaled when you also check for the error.

dma_fence_is_signaled() incentivizes wrong behavior.

But btw. we really want to carefully rethink our beloved signaled-bit
and its semantics. Mind all our past discussions about it.

This patch is more like a temporary hotfix. Much of our API is quite
fragile.

Regards
Philipp
