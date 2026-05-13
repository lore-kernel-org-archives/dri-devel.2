Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B121BCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1945410EF67;
	Wed, 13 May 2026 16:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gMRCAAIT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A057110EF67
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778689013;
 bh=ZflAobmezTMyxUcMZaRJFQwRT+gnDZ32d7ahzROvR0A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gMRCAAIT4rdyq829nUeI1ubFGyPIFW4OyAoGc2ynbP2ly1jWd4HscjXP4Z9KUKdS8
 hALCDUAEJTtFY8hvbK9ZR1T6BajRUApPpKYPog3iVOvzluHuDI0XKvJE9W4bfND0Ue
 9jXyd9277+bzydOL6PWod56sGPqFgqfryRn21wzXWnPUrGF8KweE1decTdV3jEnfij
 INecwqtBIQR3/J+7S53CaJQ+7Itwj8zXuWfcKnskz6ym5teOZoe8FoEUZ3fbJVkhZ6
 M6U4A9zpDB4Keaouk8nhZ2KBJMiac04NlFYVSuCvkNw82pGXYUwsvefwHHEIhDutTu
 BNwnQyhASyaGA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C60B517E05FC;
 Wed, 13 May 2026 18:16:52 +0200 (CEST)
Date: Wed, 13 May 2026 18:16:49 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v11 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260513181649.44f50753@fedora>
In-Reply-To: <661a6aab-a643-496b-94d2-ae9230df1a54@arm.com>
References: <20260507214939.2852489-1-adrian.larumbe@collabora.com>
 <20260507214939.2852489-6-adrian.larumbe@collabora.com>
 <661a6aab-a643-496b-94d2-ae9230df1a54@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 13 May 2026 16:46:17 +0100
Steven Price <steven.price@arm.com> wrote:

> On 07/05/2026 22:49, Adri=C3=A1n Larumbe wrote:
> > Allow UM to bind sparsely populated memory regions by cyclically mapping
> > virtual ranges over a kernel-allocated dummy BO. This alternative is
> > preferable to the old method of handling sparseness in the UMD, because=
 it
> > relied on the creation of a buffer object to the same end, despite the =
fact
> > Vulkan sparse resources don't need to be backed by a driver BO.
> >=20
> > The choice of backing sparsely-bound regions with a Panthor BO was made=
 so
> > as to profit from the existing shrinker reclaim code. That way no speci=
al
> > treatment must be given to the dummy sparse BOs when reclaiming memory,=
 as
> > would be the case if we had chosen a raw kernel page implementation. =20
>=20
> Do you need to fix up the remap_evicted_vma() path though? At the moment
> that will go through panthor_vm_map_pages() without doing the
> panthor_fix_sparse_map_offset() dance. Also I suspect it won't map the
> whole region (just the first 2MB in the sgtable).
>=20
> Maybe I'm missing something?

Nope, you're right, we definitely need to special-case sparse-mappings
in the remap_evicted_vma() path.
