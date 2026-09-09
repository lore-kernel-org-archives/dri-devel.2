Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9714DC79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 02:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B547810E04B;
	Wed,  9 Sep 2026 02:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ICMmHOgJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A176510E04B
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 02:23:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF190601FE;
 Wed,  9 Sep 2026 02:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBF81F00A3A;
 Wed,  9 Sep 2026 02:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788920585;
 bh=ggHYejTaMx7iTuBJau09Lzc1LdM0uZJvztejM3SqpLc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ICMmHOgJxPlggaXhOGQv+DvwDAWqQbQP+JePVJ3yZXHTYF5VGzlqNv1Uhy/JvJNcw
 AYuQNgueACqXlU2GNuM3b+7xiq9yyJOC93ySAz9iXhkNJ6pwTJXbZ75M2XU4Bd8W2r
 +Eaw4AMyQnSsrEtiRkPIU1HBDxJt9CyJn82KImOGU0pRJ4TxrNJSwTHg8b7lZX3UCQ
 KWx5YPi83gBZ+1LLiHxOkrCKda6soyK/1EMikI0gcaKejhPY+zZPlEEk1dixThIphg
 R+kmLOxdXVpaRoAqXLf+h6RJBVaHITDOAFU7X4OJC6yfD1EuBKzv4KdDZqEKuZo2Nz
 IXGaHFrUnLcrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: don't migrate a dma-buf into VRAM while
 runtime suspended
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909020854.58462-1-mike@fireburn.co.uk>
References: <20260909020854.58462-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 02:23:04 +0000
Message-Id: <20260909022305.6CBF81F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The check for `adev->mman.buffer_funcs_enabled` is vulnerable to a=
 Time-Of-Check to Time-Of-Use (TOCTOU) race with concurrent runtime PM susp=
end, potentially leading to a PCIe Master Abort system crash or scheduler c=
orruption.
--

commit 7e4c0d8b57d6cf1fda7d356466ca2334810cad8a
Author: Mike Lothian <mike@fireburn.co.uk>

drm/amdgpu: don't migrate a dma-buf into VRAM while runtime suspended

amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
attachment, so ttm_bo_validate() can migrate the buffer from GTT into
VRAM. While the exporting device is runtime suspended its SDMA rings
are down and the move fails. This patch only requests VRAM when the
device can perform the move.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index b33c300e26e2e..d1dae5f3fee5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -191,7 +191,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma=
_buf_attachment *attach,
>  		unsigned int domains =3D AMDGPU_GEM_DOMAIN_GTT;
> =20
>  		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
> -		    attach->peer2peer) {
> +		    attach->peer2peer &&
> +		    adev->mman.buffer_funcs_enabled) {

[Severity: High]
In drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c at line 194 in
amdgpu_dma_buf_map(), does this lockless check introduce a time-of-check to
time-of-use race with the runtime PM suspend path?

When userspace (e.g., a compositor) issues buffer validations on an exported
dGPU buffer in a multi-GPU environment, the exporter's BO dma_resv lock is
held.

However, if the BO is in GTT, amdgpu_device_suspend() does not block on this
lock since it only evicts VRAM.

This means amdgpu_device_suspend() can proceed concurrently, call
amdgpu_ttm_disable_buffer_funcs() to set buffer_funcs_enabled =3D false,
destroy the scheduler entities, and transition the device to D3cold.

When the subsequent ttm_bo_validate() reaches amdgpu_bo_move(), could it see
buffer_funcs_enabled as false and fall back to ttm_bo_move_memcpy(), causing
a PCIe Master Abort crash on a powered-down device?

Alternatively, could it see buffer_funcs_enabled as true but submit a job to
an already destroyed drm_sched_entity?

>  			bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>  			domains |=3D AMDGPU_GEM_DOMAIN_VRAM;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909020854.5846=
2-1-mike@fireburn.co.uk?part=3D1
