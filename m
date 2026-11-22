Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566A606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=njt6uaCY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA87910E629;
	Sun, 22 Nov 2026 17:14:31 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582F410E347
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1795344558; x=1795603758;
 bh=SdPhVrPD3FLfRdA9n5gci/RQLV/kspB0OdPKdxqs61g=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=njt6uaCYTLwQ+imeLSN37A0zq9iaPO/++XP/P6IDtELLxW1Ih7KDeHkHWY+1rURw9
 IYVxLJXOe+Tx/vtNR16Y8RWottwqjOpJqBIaVFBwpI0rc9XmzZZ4xGb3ymbuji7pAZ
 2rEtl/4igA/WcGth1adLfgAWOXMUxn6MfnYs50RcjEreyNxW4ZzVtJ10Qwa1/wEHAB
 A99yCbjJAF5/QkhPjBcJ2OmU6PGOVO/afZyvWrivi0fxkCssDF5X+mL4ca8c4rMXVL
 lVFNLCS2kqPxf0rUfxFKjFpbEUcHd0YpQvzB38IEEqGbxQIthX1O3Yg3WD7j0z20yV
 EAzNCCQBKIzNw==
Date: Sun, 22 Nov 2026 10:49:14 +0000
To: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
From: Falconet3 <Falconet3@proton.me>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-buf: fix leak of ctx and dmabuf reference in
 dma_buf_io_ctx_create() WARN path
Message-ID: <tRqxbL7txMRAzNLKylzBLQURNLpU-D0Xx5CrngGwLoYrK7V7kREharagUfgQLGIfiYFyTALR0BwL93AL_PWmFXq_MoZPhvPfUojBsyCnilI=@proton.me>
In-Reply-To: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
References: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
Feedback-ID: 48740069:user:proton
X-Pm-Message-ID: 67157a7a4555990622919bb0247c6c6c6fb36fdd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Withdrawing this patch. Apologies for the noise.

The WARN_ON_ONCE() path in dma_buf_io_ctx_create() is not reachable with
in-tree code: the only in-tree implementation, nvme_init_io_ctx_locked(),
installs all of dev_ops (map/unmap/release) before it returns 0.

And on the only path where it could ever fire =E2=80=94 an importer violati=
ng the
contract =E2=80=94 freeing ctx directly is not safe: init_dma_buf_io_ctx() =
has
already attached ctx to the dmabuf and linked it into the importer's
tracking, so kfree() + dma_buf_put() leaves dangling pointers and turns an
unreachable leak into a potential use-after-free. Since dev_ops->release
may itself be one of the missing callbacks, the core has no safe generic
cleanup on that path.


Thanks,
Falconet3




Em domingo, 22 de novembro de 2026 =C3=A0s 00:05, Falconet3 <Falconet3@prot=
on.me> escreveu:

> (leak of ctx + dmabuf ref on the WARN_ON_ONCE path, new file in v7.4-rc1,=
 patch attached)
