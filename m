Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BA4CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 19:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BC510F31D;
	Thu, 14 May 2026 19:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T021Zb7q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E2A10F31D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 19:07:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B9ACB42088;
 Thu, 14 May 2026 19:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E3C2BCB3;
 Thu, 14 May 2026 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778785636;
 bh=eZ/bsr8dELRKsVaQsmQQFycLQQvD5qTpWQ3063ouFQQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=T021Zb7qWOYy/Ua5pZN5V8DGB71g0T8UIfLIRegjU+lPCG01pTw7G4g9jqXdGMl6Q
 Y6RillbUbaAMeAuDcrWm2oq0nDWe9g+1h40zuEtsYxG/DfZjxl+YTPB26ED1ON6L9u
 I6e+rSHTRnwVtbZb5dW353UMhOEpVN9A4SLTYfg46ul8pIl5mxtF+QSmNWwE5R/nTA
 oRs3VQsYBZHfrW66qep83BW/w8rdZ3mnUJfgGHypIt11Jz2GkiueA6JDu0wiWBgreD
 XyUiAJTGOC3ZCy562689R9cR6A8ojSz9sXCgthQnHrlX4KJvv6KwNmUnOikpqLiq1D
 Wva0bd3gXp6mQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 21:07:11 +0200
Message-Id: <DIIMVPTLV3O5.3Q3DHU66WQZUA@kernel.org>
Subject: Re: [PATCH 0/6] rust: drm: Higher-Ranked Lifetime private data
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <lyude@redhat.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <driver-core@lists.linux.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506221027.858481-1-dakr@kernel.org>
 <DICCEKZ3HU84.34ES3SW3D1FNI@kernel.org> <agYbppHWXk_hW99M@um790>
In-Reply-To: <agYbppHWXk_hW99M@um790>
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

On Thu May 14, 2026 at 8:59 PM CEST, Deborah Brouwer wrote:
> let unreg_dev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data=
)?;

You shouldn't need this anymore as the drm::Registration itself has private=
 data
now that is bound to the lifetime of the underlying bus device, which shoul=
d be
the correct lifetime for juggling the GPU page tables.
