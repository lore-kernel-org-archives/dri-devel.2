Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59DE606A331
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=nM/cZv3e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D710D10F724;
	Tue, 10 Nov 2026 14:29:11 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2F410F73B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:29:05 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jP8Cx74M1z8vW6;
 Tue, 10 Nov 2026 15:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794320942; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SR9OzcVKv/PD0tXjBHzfheKGshKKBlVx8RKkrI+7pqc=;
 b=nM/cZv3e/rvnoQJE+mSW0GW6ImS386jC0uc9DpzxZ65vnDEJyH/g7BiKkBnABjtTf7MMZ/
 9pbO1HBujkTFj7wYJqPook1xe/54hNMlQUOuuzmRAKa1E/vZTo9ZozLS6k6OHcwcEHYM4O
 W4c4KsVJshXVTNbA1eTS5V/zUEEHpoh83zDYvJ3RAqiGu1iVlBTFWRojGAcPC9CK0sQkHs
 uWaolUZypZbspGQ4/jXooumQLM9PgAwCneLk4h5kqjafGe+nca3NXu9MQ4noNKH2FwgTWb
 W/gThHmgVuVRufUp+9Vw07nPnOoz9G/tmeentY26FX32uLCoy+hmibo3JlFvWA==
Message-ID: <30a1da3baf35c7706e2381d9e3bac3e478f64421.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Switch the default policy to "fair"
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Date: Tue, 10 Nov 2026 15:28:58 +0100
In-Reply-To: <20261110141455.28739-1-tvrtko.ursulin@igalia.com>
References: <20261110141455.28739-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 3pmpwbygsa1j98b87jb395w947xphdaa
X-MBO-RS-ID: 86b4adaaf6e11e17bcc
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

On Tue, 2026-11-10 at 14:14 +0000, Tvrtko Ursulin wrote:
> After the last known real fair policy bug was fixed in commit:
> 2ab510e63197 ("drm/sched: Fix virtual runtime race")
>=20
> And two theoretical ones in commits:
> cda6f72545f2 ("drm/sched: Fix out of bounds entity priority check"
> 75709a35da45 ("drm/sched: Adjust run-queue when changing priority at runt=
ime")
>=20
> Lets switch the default policy to fair.

We shall, but first let's get the spsc_queue series in. Considering
that the last time we blew up the kernel with CFS was =E2=80=93 ultimately =
=E2=80=93
caused by the scheduler's lack of locking, getting rid of a magic
lockless queue involved in all entities seems the safest path
available.

Christian's recent comments [1] indicate that the complicated AMD fix
might be dropped altogether, so we can be positive that spsc can be
merged relatively quickly.


Philipp

[1] https://lore.kernel.org/dri-devel/52d41d99-90f0-40d1-828e-0456dad433b6@=
gmail.com/

