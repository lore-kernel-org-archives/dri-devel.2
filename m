Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD605E88D63
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B281010E0C2;
	Fri,  3 Apr 2026 21:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="aAt3L47A";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXAxLxft";
	dkim-atps=neutral
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6863210E0C2
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 21:24:13 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3151F7A01CB;
 Fri,  3 Apr 2026 17:24:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 03 Apr 2026 17:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1775251451;
 x=1775337851; bh=wJDhh1aYQ1l4wE/5x0P8ZIQHMCjj0qGX6ZaMgUpSYDs=; b=
 aAt3L47A9yhTQN+76uDqU6NmR6i1x68uMDpeEEV2ENc92vb/nKT/P50ht5Rh7yNH
 zlrAdkk0T9LEJUl2LGaiShm6nrWTQ63f/clxqaXyuUcpcDlT5jSyhvzwX0wJMOwF
 rChvsk0D5T+utpa8GcCE8TKjJ0i4qk9Fl+7jDnjIfM64oQN2MwSD1A/AgYy2DPYN
 qOsh/clXlm1OTfS58WOpqOqCyuckuTmtwrZSCuuc5DWvgAjX2uL2t+K+Wjgh9W3o
 uAstcaF5f0WuACIFuBBRkbiuqe1pbfGqB4NMox9L6llq8Fk6iAuBfohxPQATImp2
 77GrkYqP8XoJ9mibPRegAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1775251451; x=1775337851; bh=wJDhh1aYQ1l4wE/5x0P8ZIQHMCjj0qGX6Za
 MgUpSYDs=; b=kXAxLxfti1IaQGTj5DE1eTHOVU3fz2e6HtUfswfA34t2NmT3GYy
 T0ANeA6MPaa7PwVpoMzWJ56wliT+IA004jOEyDytWbpJT3Asvk+ziuyuQy348QBJ
 UC3wzuSvg7PGMPWJPSgScb2oKO170l40zL7u5pPCZONCbWYfAiZlXB3c6t8BApIQ
 wPzPnwVlWFKBeNGVPgtLtHQlBykAbU7xbio1Cpu5FXOXnjrZgv4VY7FgOo6ToIaN
 FDfCTJb+MjFUkXXDKltkUPo21EhsCAw5KAV6e4lV+EpfXWCYZIv1pVDLOPrbi+kj
 ic8ZODfHppRaqjhSSnlaw/e68ivExmWTbwg==
X-ME-Sender: <xms:-y_QaRr1XTAQ9LyrLFOTPLlOumIgLtbXY3IN9h-aKuVs7xuuiFzniw>
 <xme:-y_QaUUm3hDRjGEgKKc4_OY_USIx7Ot-s3oZvcSuPSaQEQOAqZe2qSXhZ9aPDXWVL
 43z0grLVYPrs36reD07Zfpl1j3ZPGmgtb7UCaYPc_A0n9rmBA>
X-ME-Received: <xmr:-y_QacYdSSqSmKaieuB8VmUHk4MphOc0deUQEqblCeedqzy4HW2bcMn21A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghkucfo
 rghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvhhish
 hisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudelteef
 vefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhn
 vhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehtvgguugihrdgrshhtihgvsehvrghtvghs
 rdhtvggthhdprhgtphhtthhopehvrghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsg
 drtghomhdprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhr
 tghpthhtohepgigvnhdquggvvhgvlheslhhishhtshdrgigvnhhprhhojhgvtghtrdhorh
 hgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthho
 phdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtph
 htthhopegrrhhirggunhgvsegrrhhirggunhgvrdhsphgrtggv
X-ME-Proxy: <xmx:-y_QaRfxtirIBioAWRbktAN6gJkuRnR1Ev5RQjHr2vJoizemSi6lTg>
 <xmx:-y_QaW2sjTPblbnJqzQf3RHHa_I6V-7ksolTPLy5osm8Q8GnAQdDgg>
 <xmx:-y_QaYJTIUWPC-0nxvANtutqJl3H2VayrOkd-Hz_jzPH6aNL2eLSZw>
 <xmx:-y_QaVEYnKui8E_TxwxLNAFiA4fij7N4ZS6lWjiBy3_wCrh8LoWPeA>
 <xmx:-y_QadRujxaY6YfeywYpy0HDzSrdZ0nAizMKR0kLY1kncJmTVSVzuRq->
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 17:24:09 -0400 (EDT)
Date: Fri, 3 Apr 2026 23:24:07 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: Val Packett <val@invisiblethingslab.com>,
 Demi Marie Obenour <demiobenour@gmail.com>,
 Xen developer discussion <xen-devel@lists.xenproject.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Ariadne Conill <ariadne@ariadne.space>
Subject: Re: Why memory lending is needed for GPU acceleration
Message-ID: <adAv-HfiyKptEVvq@mail-itl>
References: <84462c4b-7813-4ad1-aeb2-862ae4f3a627@gmail.com>
 <c38387fe-beef-4f50-b928-74f96b881b7a@gmail.com>
 <0bbf0349-1006-485f-a2db-6c8b795b4242@invisiblethingslab.com>
 <1de15ce0-9f7e-4253-80a7-ecd94caa4325@vates.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4Ae0y7aT9vuqArIi"
Content-Disposition: inline
In-Reply-To: <1de15ce0-9f7e-4253-80a7-ecd94caa4325@vates.tech>
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


--4Ae0y7aT9vuqArIi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 3 Apr 2026 23:24:07 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: Val Packett <val@invisiblethingslab.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Xen developer discussion <xen-devel@lists.xenproject.org>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	Ariadne Conill <ariadne@ariadne.space>
Subject: Re: Why memory lending is needed for GPU acceleration

On Tue, Mar 31, 2026 at 09:42:22AM +0000, Teddy Astie wrote:
> XEN_GNTDEV_DMABUF has been designed for GPU use-cases, and more
> precisely for paravirtualizing a display. The only issue I would have
> with it is that grants are not scalable for GPU 3D use cases (with
> hundreds of MB to share).

FWIW we do use grants for graphics buffers already - window composition
buffers specifically. We do run xen with extra options for that:
gnttab_max_frames=3D2048 gnttab_max_maptrack_frames=3D4096
And similarly, on domU side:
echo 1073741824 > /sys/module/xen_gntalloc/parameters/limit

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--4Ae0y7aT9vuqArIi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmnQL/gACgkQ24/THMrX
1yxbGQf+OgsupCAnm7yeXU50i8UAUbaCxLl6LTgomVWE8BqqFLLzbd1uZRBaxgwi
08KM6UwaNDnWYrJjTzzuVajjgvb364NRxaCcDQMU1gg9QaScwe0rvqNXjTCyyZIZ
KcGYITuyNobu6TEOlxjMZCYe09hjh5Tv6YIAjNytG/v4Wj0BeLd6dpU3y/K79rsz
k5Q2KuSQNJBm0DrX1xHtYDI34Ecs8kMi+QNmTxBNirLjkzswlCpewSvOONNsy8Ff
8k+hGeZuhbRQMidzb/toBQpk5p82359YvtUwGWz6rn/YnryTk6+3x3Vr1octMvgz
5SPKxfVNDvikjgpYpZpWowiX1sDLHw==
=Aya7
-----END PGP SIGNATURE-----

--4Ae0y7aT9vuqArIi--
