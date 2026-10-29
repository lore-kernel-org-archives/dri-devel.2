Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA107606A335
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gmdlD1wN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466F7112316;
	Thu, 29 Oct 2026 13:50:03 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595071122FE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:49:57 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jFlwL0qV8zMlfS;
 Thu, 29 Oct 2026 14:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793281794; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axwW0A/5PYCIOuQ7ZqJPwr1VhkoJypT5+8pks0+szpM=;
 b=gmdlD1wN7AGG6nQfxtq23dGCuMxmNrkZ+NrXKYNfVEL0xlliMv+IdjSR2N1Cm3L0ebA7Ex
 a49o2Ord2frm0n5vrPCmgzzrEY6tcsO7HruzWv8gsdxI/I2DLI5s0RRiI6dNaGMCLZNk3g
 v4BRv4gw0phbhr2SMiHJZbEfB85nvC0imGNuKGAQyU13rVb5Wys8EhLIXm4FMIrKfS9N1D
 l/HB6KFi4v910J0tjwXRRHiPDCkEjMb4AjI7G9gozZ6rdiTzShW82Notr6YNkkMZgIhFl+
 1bbQwKh9uDQLkWCu279NGWJikwm8R1A1ENlTml5UpT4wyPy/ekFyOgMKeyUkNw==
Message-ID: <e30a0a03cb7d393cbd88565bf81e156d2f38b293.camel@mailbox.org>
Subject: Re: [PATCH] usb: gadget: f_fs: Remove deprecated dma_fence->ops
From: Philipp Stanner <phasta@mailbox.org>
To: Paul Cercueil <paul@crapouillou.net>, Philipp Stanner
 <phasta@kernel.org>,  Neill Kapron <nkapron@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sumit Semwal	 <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Sam Day <me@samcday.com>, Michael Bommarito	
 <michael.bommarito@gmail.com>, Gabriel Prostitis
 <prostitisgabriel@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Thu, 29 Oct 2026 14:49:49 +0100
In-Reply-To: <7fd62daa875e4a3772e980127d368704a849caee.camel@crapouillou.net>
References: <20261029125143.1744481-2-phasta@kernel.org>
 <7fd62daa875e4a3772e980127d368704a849caee.camel@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: fsoima31pgmrfkhcj7aypxgy1bshnaqn
X-MBO-RS-ID: 80be9851aa58a305405
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

Hi,

On Thu, 2026-10-29 at 14:19 +0100, Paul Cercueil wrote:
> Hi Philipp,
>=20
> For context, this .release() callback was added to avoid the implicit fre=
e of
> the base class, which IIRC was a request I got during the review process =
of this
> change set.

Can't say anything about the request you got, but fences are reference-
counted and the ability to free itself exists since at least
3c3b177a9369 (2014).

From dma_fence's perspective it's certainly the desired canonical
pattern since the release() ops prevents fences from the important
feature of decoupling fence producer and consumer.

>=20
> I'm personally fine with the change, but do we need a "keep this field at=
 the
> top" comment for the base class in the ffs_dma_fence struct? Or what's th=
e
> policy here?

When I got into the kernel I was told that it's common practice to
always have the base class as the first element. That also allows for
obtaining the parent class by a mere pointer-cast instead of
container_of.

But the reality is also that some users are not aware of this rule. I
can document it in a v2 if you like.

Regards,
Philipp
