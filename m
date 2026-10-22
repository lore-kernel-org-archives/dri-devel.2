Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736C606A331
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPzPoR/w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF5B112449;
	Thu, 22 Oct 2026 09:38:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5F2112422
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:38:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0305743883;
 Thu, 22 Oct 2026 09:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67421F000C1;
 Thu, 22 Oct 2026 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792661883;
 bh=fJCiqJRPGgAfSVN7RbM7iHySGCq41L373bwkKti7+4I=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=KPzPoR/wrjNNGbKIkqlMCH7CJUloCIWwrjPJzodjNYeKU3Ve/XXaS5wxkQckuueOt
 R3EwVlkaTwaZAxVCAW0LmapgJ2a9lWtZBxLjZD1h3uPnKRl3f8WdlED65AcWmUQp58
 s2P18JLCDr6LONj/VPojqKPBQRJaVml0ZrRgnWJOYYShV1g0YIf3IAcpU0R9DTVglE
 yPid1dVogbCXY2+8v9y4Lo/UYyycv628hGEAbMPEviteTg/79AmEhMa1gbtF7nDsB5
 zqRySub6a9kHn01RYLG6wi2lbf+tB4naNkfIhu2hsnvf1GngoPW/8cTVphE6Do0ckm
 LrbG12th5iOUg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 11:37:56 +0200
Message-Id: <DMB9LKZEM5I0.2NOCDMVFATD2P@kernel.org>
Subject: Re: [PATCH v4 4/7] gpu: nova-core: add NVKV decoder
Cc: <sashiko-reviews@lists.linux.dev>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-4-e8b92b91aa5b@nvidia.com>
 <sashiko-outbox-173606@kernel.org>
 <db71fe6b-bc96-4d02-a139-2bef73f568a2@nvidia.com>
In-Reply-To: <db71fe6b-bc96-4d02-a139-2bef73f568a2@nvidia.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 16, 2026 at 4:05 AM CEST, John Hubbard wrote:
> How do we update sashiko to make it stop reporting on this issue, which
> we have decided is a non-issue (Nova is actually configured to only ever
> be little-endian)?

There's a repository [1] to track the review prompts of subsystems, compone=
nts
and drivers. Those should be considered when Sashiko picks up patches for
review.

It should be as simple as adding a new file kernel/subsystem/nova.md and
referencing it in kernel/subsystem/subsystem.md.

(I have a few things collected I considered for adding them as review promp=
t and
I can send a patch in about two weeks, but please also feel free to go ahea=
d and
send a PR with the first bits.)

[1] https://github.com/masoncl/review-prompts
