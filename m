Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ICRn53sG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8268710F699;
	Tue, 17 Nov 2026 12:00:36 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB90A10F680;
 Tue, 17 Nov 2026 12:00:29 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jTNbG6vLfz8vZX;
 Tue, 17 Nov 2026 13:00:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794916827; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHynNZ8yX7YKWcHWFvvbM+8WS9UJqwnnYu2M9aOKc6g=;
 b=ICRn53sGEr1G9Bcr5zWUDds3vxSBvedTe6X1FIqJD2Lm+eDVW1EYfOzxEtdNyEIaCCIF9m
 80S5iAMHYZp5+y8FM3V1Dhzqcqs2X6jgXbUOaJ9xwRK0vA4pJt465IWgehky9Ylzmp4hiV
 vPmfM3oKeeoYRZFYr0oy5O284hXnrW3WNqGLBbsFqIeNtcF3KfMcqi9r7aIHHjeP1YqDGC
 6pssYyD570bdpe540ZvZ6zZXJXeJPBTbLOEkk2CoxYpOeuQIN8GF2Erpq51hiuyM5qFgq4
 +LAajm+D0e7CV9uYecNB0sv0QAnBiP3iM0sb3MWqnT1JlFnhEl4SaC+Sijd4aQ==
Message-ID: <e0d8e3350b8897c186c0780eb0c16e9dd136ef46.camel@mailbox.org>
Subject: Re: [PATCH 1/4] drm/sched: Disallow initializing entities with
 un-initialized schedulers
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>, Philipp
 Stanner <phasta@kernel.org>
Date: Tue, 17 Nov 2026 13:00:25 +0100
In-Reply-To: <20261117100654.8593-2-tvrtko.ursulin@igalia.com>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: z4u4f4y86mq3foegfkr1wumyhz5pwm9u
X-MBO-RS-ID: 09b1457563b22c097c7
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-17 at 10:06 +0000, Tvrtko Ursulin wrote:
> Simplify the code and theoretical runtime combinations by disallowing
> initializing entities with un-initialized schedulers.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
> I do not *think* any of the drivers relies on this inverted initializatio=
n
> order but it needs more eyes for sure.


I increasingly think that the way to go forward is to demand from API
users that they use the API correctly and appreciate the distinct
lifetimes and especially initialization and teardown orders.

Sure the API can warn when it's misused, but we have certainly not put
enough emphasis on really motivating people to set up things right.
Most APIs I see in the kernel do not warn in foo_init() whether
foo_init() had been called already.

What we actually need is more documentation

P.
