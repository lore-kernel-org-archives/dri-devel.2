Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C3606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=EI0Z9TmD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CCAB112A0F;
	Fri, 27 Nov 2026 10:30:47 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E64112A0F;
 Fri, 27 Nov 2026 10:30:35 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jbV6q2vQrz8vhc;
 Fri, 27 Nov 2026 11:30:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795775431; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1bwRJul72ZLviTaCPZunjtVUaFqJfdRWa3psjhNQOw=;
 b=EI0Z9TmDP8tgkkM57uthb7S46C7I+kQkQguRgJExpjhlwr6/Q+UK/kAUoJ+0qqIWwOEQx2
 H4g/xJ2XHFSjo2LVgri8aJU6epGehYpsSKHm2Wf+OinDBwdLsfcOYTAoQ5hhb9qHeNmFgb
 eaT9/tz2Dn1qg8xuRhHJa7Xb4zRHbWUmF2IsttmEy3sHLXpmG6LzchcggJCFhjOBVPjB4X
 WXQh+CHjziPsJUKzZyX6ejvYy7a9RNQRae4DUZ7FCoG7AHaifIJOyW3MGESIC+6Tdjakro
 tV4nZ6l3X1ydgRfICoxLC/ypDUwBFwlD7jUEjZOhtHXKVoHlHhCsNOer+6jGEg==
Message-ID: <69845631bb184d86b4af8b4143b3b7adf726e0ca.camel@mailbox.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Hot-fix timestamp misordering
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Philipp Stanner	
 <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Matthew Brost	 <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>,  Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,  Gustavo
 Padovan <gustavo.padovan@collabora.com>, Chris Wilson
 <chris@chris-wilson.co.uk>, Luben Tuikov	 <ltuikov89@gmail.com>, Shashank
 Sharma <shashank.sharma@amd.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 stable@vger.kernel.org
Date: Fri, 27 Nov 2026 11:30:18 +0100
In-Reply-To: <71b2506f-8534-468e-881d-1abf8f8224d9@igalia.com>
References: <20261126172046.2473303-2-phasta@kernel.org>
 <20261126172046.2473303-5-phasta@kernel.org>
 <71b2506f-8534-468e-881d-1abf8f8224d9@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 74d278230c8cbc92940
X-MBO-RS-META: 6gy6o1iytwz9kk1ncbnnpkypaffiyik5
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-27 at 09:57 +0000, Tvrtko Ursulin wrote:

> Not sure the fixes target is strictly correct since timestamp access=20
> goes even further back, but I guess it is good enough for GPU stats.
>=20
> Please just add some sort of an impact assessment and bug description to=
=20
> the commit text. With that:
>=20
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Thx for your review

I was considering, though, to minimize churn by not fixing amdgpu for
old kernels and simply take it aboard with the misc-next series.

Reason would be that amdgpu only ever runs on x86, which doesn't
reorder loads with loads, so this should in practice never be broken -
right @AMD?


P.
