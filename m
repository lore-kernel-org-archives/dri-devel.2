Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D0606A32E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=qOdY7Exy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3A910EB75;
	Sat,  7 Nov 2026 14:28:25 +0000 (UTC)
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFDA10E53E
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 06:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794031609; x=1794290809;
 bh=JaFhQlbGMVu6dPzMiMumPiDBerU8ltcrj5X8PekJ3O0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=qOdY7ExymmNPoK9Zkd77ploFiNc1Og/RXWxlC8UVkDx069fl+qZEIgn8CVqDQH9B/
 Tiu2zYXFs4hNIPv1s00lzeXH4ZKQGgCTyBIBnYrz+QqT+1MxsQAd8YkYn4MaW6Xg8m
 1aX6glQgedIuJTZa5ig5WggvDyTCO3yLgv5kgRBmyQV6+CB1hZNGCSB+bbEcF/uAHB
 IUxh+cP4W75z07/HOmWOPujh5PVVUuBzoYV9stFLjDdB4H4rwm2EgvzEHiQ6PfsXC7
 aqKLWxnH7ZMc+kAQZ689fgv9ZF/5X1IZqMETv7hkaXHeEsgm7i1f53lxZR6xfNqngk
 c53Z/lpN7hplw==
Date: Sat, 07 Nov 2026 06:06:46 +0000
To: Alex Hung <alex.hung@amd.com>
From: Kylie <kyliepc@proton.me>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on
 DCN2 seamless boot
Message-ID: <47gCGmeNagej2jpE8s4BwyMJo60YGRhrG930vkJHcmiNmxej2wKyTvZXnchut8Vjkh0BOB5l5T-Q-Mv_uQzav_AYLw6tt463Wp58qo_EoHQ=@proton.me>
In-Reply-To: <f25f4726-17c1-4fdf-8fd2-d96e73fbb22a@amd.com>
References: <20261022-dcn2-seamless-vtotal-v1-1-6ceb87f98629@proton.me>
 <f25f4726-17c1-4fdf-8fd2-d96e73fbb22a@amd.com>
Feedback-ID: 112467285:user:proton
X-Pm-Message-ID: 46eae040950bedaba9044ca028d5aa48e3b45a3f
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


As this solves the black screen issue with seamless on DCN 2.1 (maybe 2.0?)=
 could seamless be enabled by default?

I only have access to the 1 Renoir laptop so that is as far as my testing g=
oes.

Thanks.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218483


On Friday, October 30th, 2026 at 9:58 PM, Alex Hung <alex.hung@amd.com> wro=
te:

> This affects more than DCN2, but I can fix patch title by removing "DCN2"=
.
>=20
> Reviewed-by: Alex Hung <alex.hung@amd.com>
>=20
> 
