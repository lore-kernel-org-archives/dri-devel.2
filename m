Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81260A3810
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E3E010E802;
	Thu, 29 Oct 2026 14:18:58 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE0E10E802
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:18:57 +0000 (UTC)
Message-ID: <304c061aa5fa7f271acfa74c640ab1f0a40e393c.camel@crapouillou.net>
Subject: Re: [PATCH] usb: gadget: f_fs: Remove deprecated dma_fence->ops
From: Paul Cercueil <paul@crapouillou.net>
To: phasta@kernel.org, Neill Kapron <nkapron@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Sam Day <me@samcday.com>, Michael Bommarito	
 <michael.bommarito@gmail.com>, Gabriel Prostitis
 <prostitisgabriel@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Thu, 29 Oct 2026 15:18:51 +0100
In-Reply-To: <e30a0a03cb7d393cbd88565bf81e156d2f38b293.camel@mailbox.org>
References: <20261029125143.1744481-2-phasta@kernel.org>
 <7fd62daa875e4a3772e980127d368704a849caee.camel@crapouillou.net>
 <e30a0a03cb7d393cbd88565bf81e156d2f38b293.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le jeudi 29 octobre 2026 =C3=A0 14:49 +0100, Philipp Stanner a =C3=A9crit=
=C2=A0:
> Hi,
>=20
> On Thu, 2026-10-29 at 14:19 +0100, Paul Cercueil wrote:
> > Hi Philipp,
> >=20
> > For context, this .release() callback was added to avoid the implicit f=
ree
> > of
> > the base class, which IIRC was a request I got during the review proces=
s of
> > this
> > change set.
>=20
> Can't say anything about the request you got, but fences are reference-
> counted and the ability to free itself exists since at least
> 3c3b177a9369 (2014).

Yes, it already existed when I wrote the code and I was requested to make i=
t
explicit. Not trying to make a point here, just stating the reasons why it =
was
written that way.

> From dma_fence's perspective it's certainly the desired canonical
> pattern since the release() ops prevents fences from the important
> feature of decoupling fence producer and consumer.

ACK.

> > I'm personally fine with the change, but do we need a "keep this field =
at
> > the
> > top" comment for the base class in the ffs_dma_fence struct? Or what's =
the
> > policy here?
>=20
> When I got into the kernel I was told that it's common practice to
> always have the base class as the first element. That also allows for
> obtaining the parent class by a mere pointer-cast instead of
> container_of.
>=20
> But the reality is also that some users are not aware of this rule. I
> can document it in a v2 if you like.

Let's wait on feedback from more people. I don't have a strong opinion eith=
er
way.

Cheers,
-Paul
