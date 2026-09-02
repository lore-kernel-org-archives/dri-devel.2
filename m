Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09BDC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B88010F327;
	Wed,  2 Sep 2026 19:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cfi1/dqU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7732A10F328
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:27:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28167419D7;
 Wed,  2 Sep 2026 19:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D9D1F000E9;
 Wed,  2 Sep 2026 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788377220;
 bh=r4rjYwJZSJZ2c1QOwxHbimkxPShAVA5Eroly37WYSrk=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=Cfi1/dqUVDDAJtAQJAyCb9d4b4/kZr2IjmF/z0TDxKyI3C/BDTKeSj7+QrqheDMah
 jjq9LxdKHP/wVhQje4L9wIrK8SojHh1rjjx+9GY90Ky3jp8i/ywJks6Wa+g32pzr5j
 9GfMmM56OQ68Hw/sgVS9/X4da6cgaV+M6qTbETjdBwpoDnUVRrVK8L1T9/BOTRCLef
 J4+KrCNUUzgzPZL5LFGkzihQav6yADsaHuwbVb6pXdLSU+KFEMwyy9Xjj8UGfed79i
 NFV9CxbEuNkfWAgH8PBoT6BST4ztTVvfVJzsrk2y6BeFzL1ol4K+brNUTGZ8/BgrCQ
 0d8ZRV1MwBJAA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 21:26:55 +0200
Message-Id: <DL52TB47MFFY.CICXD0XQ3T5K@kernel.org>
Cc: "Dave Airlie" <airlied@gmail.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "M Henning" <mhenning@darkrefraction.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org>
 <apZCTUYiN5FHCkCm@nvdebian.thelocal>
 <CAPM=9twQxnx5DDkjwXWi-vXM4kqUQQdPaL+=1ASS0tpf2GmnYw@mail.gmail.com>
 <apZbKc5xMQ1yTBTu@nvdebian.thelocal>
 <DL3SXIIA4FID.2V3K5YC91RM3V@kernel.org>
 <apetgjQ9zWpJATj3@nvdebian.thelocal> <apfJhtr6BpMosz1q@nvdebian.thelocal>
In-Reply-To: <apfJhtr6BpMosz1q@nvdebian.thelocal>
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

On Wed Sep 2, 2026 at 9:05 AM CEST, Alistair Popple wrote:
> On 2026-09-02 at 15:21 +1000, Alistair Popple <apopple@nvidia.com> wrote.=
..
>> Ok, so just to double check are you happy with an accessor to return
>> gsp_static_info as well?
>
> Still interested in your thoughts here though, just to avoid churn becaus=
e I'll
> probably pick the wrong answer :-)

Yeah, exposing that for gpu_name() seems fine.
