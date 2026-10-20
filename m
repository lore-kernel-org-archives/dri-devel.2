Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC61606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Do6KW+Tn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C049D10E833;
	Tue, 20 Oct 2026 16:04:59 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE30C10E833;
 Tue, 20 Oct 2026 16:04:53 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j8HLB5J9pz8vd5;
 Tue, 20 Oct 2026 18:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792512290; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIFxSu05lTK1ZyMP+g8KkPk3Y+HiZ5HVRNbztGjBNqA=;
 b=Do6KW+TnM4KDHOY5sf07y3+UKyIwRoDOZ8T4lFOBo8gcD8cvFLTvzik6SwfHRhJ/s2fAYl
 so7/BAi6i5TJ/nXCam9Wyc6h3xwnbD2oF5wEWkC7lIlQP0/XHcFYVpkYT6RdbijPC9/qp0
 G3zMwCNVMoEWHO63IvtFT8vDlwih3+hIZ4U4eQUgDpnqEVeo/CAKh/tkBrkL6R30Y65GZ5
 wUd5s+dPaIRGgqxMJrte3DvBmNYYMEFxNgJBQc4gNZQEqDk3LpdGiA9/AQC07jBv+c942M
 dAPUgv67CHA4wjXgSc12r9jAUfkQsgbix6JO4Ualw4t2WtK0bSyGZw4imoXmFQ==
Message-ID: <1f102ca178b7101008e45b796dc67a64cee0b029.camel@mailbox.org>
Subject: Re: [PATCH v2 0/8] DRM scheduler assorted cleanups
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>, Philipp
 Stanner <phasta@kernel.org>
Date: Tue, 20 Oct 2026 18:04:47 +0200
In-Reply-To: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 34a749bfe93803e1577
X-MBO-RS-META: tkzuqfrifksm4bcskdspigy51hksip8b
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

On Tue, 2026-10-20 at 16:41 +0100, Tvrtko Ursulin wrote:
> A little bit of a dump of my patch queue leading towards the SPSC queue r=
emoval
> (which is still WIP). Primarily because Philipp asked me to rebase and re=
-post
> "drm/sched: Replace completion with a flush".

What's your merge plan for this? Since it's a series one would expect
that things depend on one another, but patches like 4 look surprisingly
independent.

> Then I realised we agreed to split out one part of that in a separate pat=
ch.

completion =E2=87=92 flush patch now need to be part of a series? It was
independent before.

> Specifically "drm/sched: Ignore stopped entity attempt to change its run-=
queue".
> And I also realized that one is easier to argue for if we also try to tig=
hten
> the rules around entity initialization. Which is "drm/sched: Disallow
> initializing entities with un-initialized schedulers".
>=20
> Then there are some trivial cleanups in the same area which should be eas=
y
> reviews.
>=20
> The first patch of the series feel free to ignore. I have sent it separat=
ely
> already but need to include it so the series actually applies, both for C=
I, and
> should someone want to apply the series.

But why is it a series when so many things are independent? :(



P.
