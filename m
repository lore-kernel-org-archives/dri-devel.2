Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21960A260D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=C11IswdM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A28B10FDFA;
	Wed, 21 Oct 2026 13:23:06 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C07410FDFA
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:23:00 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j8qhx6W67zMlQQ;
 Wed, 21 Oct 2026 15:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792588977; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeKCpXddBPM3zqxLSgWii91zWsk60vmmQFyoSuWzZOY=;
 b=C11IswdMW66PBv57woN4BR138fbl8UqPdy5vgOb/POLi5vvUN54B1ov9C0naIXTNoKbZJZ
 YS1ge7w4y9zhhoQD90rahE3TKOgkOssTIFisbSd6M+H5X995cG2A21ppf52MLZKt2UGtJR
 1FfQJ4jvb6v3jjs2PcgD95L2/dd3qTRZ338U7OYxHrs9f24wQeNvdpKP+ZFhF1F+opZZFa
 Tn07Y72ckXqIp/VZRfkggpsRM4XrcgLonHk+M2bcrsQc64hu8FYp55g+nsJkW4PCBhOhHS
 OCVS6FDnN+/U4DQQu9ARnwvq+wMYHuQs2qjamRtJOkO3NbquCmfM3+ZGpJuHHw==
Message-ID: <d305166f022bd567cb03f8fb5c8b9f2aa9e6b5fd.camel@mailbox.org>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
From: Philipp Stanner <phasta@mailbox.org>
To: Gary Guo <gary@garyguo.net>, phasta@kernel.org, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes	 <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin	 <tvrtko.ursulin@igalia.com>, Danilo Krummrich
 <dakr@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Date: Wed, 21 Oct 2026 15:22:54 +0200
In-Reply-To: <DMAIIIJ57A3N.GXLM3L5IOAPL@garyguo.net>
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
 <DMAI50AJ10UC.16G4TCC3VAM0J@garyguo.net>
 <56108c0554e92191d2678a407d7d8102b9b304b3.camel@mailbox.org>
 <DMAIIIJ57A3N.GXLM3L5IOAPL@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 8522d2698eb6890de26
X-MBO-RS-META: aac61pah6chuy1w8d71zjmx86m7o33op
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

On Wed, 2026-10-21 at 13:24 +0100, Gary Guo wrote:
> On Wed Oct 21, 2026 at 1:17 PM BST, Philipp Stanner wrote:

[=E2=80=A6]

> > static __always_inline bool test_and_set_bit(long nr, volatile unsigned=
 long *addr)
> > {
> > 	kcsan_mb();
> > 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
> > 	return arch_test_and_set_bit(nr, addr);
> > }
> >=20
> > Where does the "full ordering" come from? I suppose implied barrier
> > then means it comes from the architecture's implementation. But what's
> > then the purpose of kcsan_XX ?
>=20
> It's from arch_test_and_set_bit.
>=20
> KCSAN doesn't see arch code, so the kcsan_mb() and in fact
> instrumnent_atomic_read_write() both are annotations to indicate that thi=
s is
> conceptually a mb() + STORE for instrumentation purpose.


We (i.e., someone who's got the overview) could probably document where
and why our atomic instructions are a bit scattered.

Why is test_bit_acquire() defined in include/linux/bitops.h, and should
set_bit_release() be defined there =E2=80=93 or here?


P.
