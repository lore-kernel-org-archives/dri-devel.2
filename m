Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A82C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27AA10F295;
	Wed,  9 Sep 2026 21:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="juKp9hiW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3E510F295
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 21:11:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DF6A42B7F;
 Wed,  9 Sep 2026 21:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E6A1F000FF;
 Wed,  9 Sep 2026 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788988266;
 bh=sJw319V3qv+1Dfrao12AKkohQCAzVeu6BFVDExsIeZA=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=juKp9hiW6y7Ll2x+QeUNc43LnJ0ZqrO3DSlYqxZbcbEUPhkyOnHUtNYyfYhsG6j6p
 mdWiGjADlf22/f0/x03YZPY6O3rWe7qebua3+MbmacwVDmKkb/+sKf1qvpLxIwan0d
 QVt1P/+XbTG4gPXogKTLiAQds681lAnEpRmhNBWOdgThlmkVbpXTi835JLgVvZAn93
 xWCecp+KI5xlzLrFCRXdmPQjoYxSdaapZAFk/n6xMR6XZQm+7LECEsH5lrlPzq0dDD
 hLyYlTvOqCJOmR1EQxMUHOGd3/PLAMHf0JI1tb9ltypRgNOpQC+yILo0yQjMB9Fdr3
 1IaBHx3mCumrw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 23:11:02 +0200
Message-Id: <DLB3EU0DVC9B.1J5OLPMUZJBNE@kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/16] gpu: nova-core: GPU page table, vmm, and bar1
 mapping
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
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

On Wed Sep 9, 2026 at 5:59 AM CEST, Eliot Courtney wrote:
> I am reposting Joel Fernandes's original series [1]. The rebase adapts
> the patches to recent changes in the rust infra, like HRT lifetimes. It
> also adapts to the changes I posted in [2]. It keeps Joel's design and
> patch split.

I left a few comments that we really need to address. However, I'm fine if =
we do
that with subsequent patches. Thus, a bit hesitantly:

Acked-by: Danilo Krummrich <dakr@kernel.org>

Also note that eventually we want per-PT-page reference counts, so VM_BIND
ioctls can reserve for the whole range requested by userspace. We only know=
 at
job execution time which parts of the requested range are mapped already (e=
ither
already with or without the correct contents) and which page size is used. =
I.e.
we need quite some flexibility in the API to take the optimal decision at j=
ob
execution time. So, this together with a reclaim approach will probably be =
a
huge rework anyway.

Eliot, when you apply this, can you please fix up the nits, e.g. make the
imports use the correct kernel vertical style, etc.?

Thanks,
Danilo
