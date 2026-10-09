Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5615CA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B11510EB3C;
	Fri,  9 Oct 2026 21:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1uVZL0g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0732F10EB3C;
 Fri,  9 Oct 2026 21:53:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3221560120;
 Fri,  9 Oct 2026 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538691F000FF;
 Fri,  9 Oct 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791582828;
 bh=+7ZmDM7eGMHf9jQqmIQ9W5YX2nKr2knSDAYajP9Gkig=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=T1uVZL0ggAl0VPQm3eJhRvJGiAujxieV5Azk/FASvWFVeiRoJ4n/l07py6sua5Df7
 o4zokVMYdepXjYod6t0uSKSB5acU1eyJFkGKuNVffMGka8VzHqiuXiPlCUw1RGD2ny
 A4MSNbkPlewdgOuJexEYxYNIaFX72LnXy4WFPm2MViDiU575mS1+b9RY+L2cH2P982
 l4vLqBtpoNHiZyKIkJkRwshI3L4tJKq/LkDkTobig0ztDT78jtw0hSN7/x0Qg46gz/
 sKUjyyV//1JysFEjWCkhFG7jjcBtV2y0HTVvo1KE0rApx4fm9M8rBTUrTeMKL8UH8l
 yG8CDERZDB5cQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 23:53:44 +0200
Message-Id: <DM0N3VIIXERD.PZBNSZJPSEL7@kernel.org>
Subject: Re: [PATCH v2 3/3] nouveau: Fix NULL dereference in
 nvkm_gsp_gcx_ready()
Cc: <jim.cromie@gmail.com>, "Lyude Paul" <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dave
 Airlie" <airlied@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Campos Ramos" <Capitain_Jack@yahoo.com>
To: "Jim Cromie via B4 Relay" <devnull+jim.cromie.gmail.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
 <20261009-my-fixups-v2-3-839e2bbe514d@gmail.com>
In-Reply-To: <20261009-my-fixups-v2-3-839e2bbe514d@gmail.com>
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

On Fri Oct 9, 2026 at 7:44 PM CEST, Jim Cromie via B4 Relay wrote:
> From: Jim Cromie <jim.cromie@gmail.com>
>
> Commit cb4c7603678c ("drm/nouveau/gsp/r570: Add support for
> INTERNAL_GCX_ENTRY_PREREQUISITE") hooked nvif_device_gcx_ready() into
> nouveau_pmops_runtime_suspend() to consult GSP before runtime suspend.
>
> On GPUs running without GSP-RM (e.g. Volta GV100, NvGspRm=3D0, or missing
> GSP firmware blobs), device->gsp is instantiated but gsp->rm remains
> NULL. nvkm_udevice_gcx_ready() checked "!gsp" instead of verifying
> nvkm_gsp_rm(gsp), allowing non-RM instances to invoke
> nvkm_gsp_gcx_ready(). nvkm_gsp_gcx_ready() then unconditionally
> dereferenced gsp->rm->api, causing a kernel oops:
>
>   RIP: 0010:nvkm_gsp_gcx_ready+0x10/0x30 [nouveau]
>   Code: ... 48 8b 87 70 0e 00 00 <48> 8b 40 18 ...
>   RAX: 0000000000000000 RDI: ffff8c9555fca000
>   Call Trace:
>    nvkm_udevice_mthd+0xa5/0x150 [nouveau]
>    nvkm_ioctl+0xcc/0x1d0 [nouveau]
>    nvif_object_mthd+0x110/0x1e0 [nouveau]
>    nvif_device_gcx_ready+0x36/0x60 [nouveau]
>    nouveau_pmops_runtime_suspend+0x39/0x140 [nouveau]
>
> Instruction decode shows `mov rax, [rdi+0xe70]` loads gsp->rm (0x0),
> and `<48> 8b 40 18` (`mov rax, [rax+0x18]`) faults accessing rm->api.
>
> Fix by:
> 0. Checking !nvkm_gsp_rm(gsp) in nvkm_udevice_gcx_ready() so non-RM
>    devices report GC6/GcOff ready and bypass the GSP call entirely.
> 1. Guarding gsp and gsp->rm in nvkm_gsp_gcx_ready() before inspecting
>    gsp->rm->api->gsp->gcx_ready.
>
> Fixes: cb4c7603678c ("drm/nouveau/gsp/r570: Add support for INTERNAL_GCX_=
ENTRY_PREREQUISITE")
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Isn't this fixed in commit 4d0e27041185 ("nouveau: check gsp->rm as well as=
 gsp
pointer before gcx ready") already?
