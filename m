Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56131C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B78710E32F;
	Tue, 21 Jul 2026 11:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LJI39VGc";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B151010E25E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:20:21 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h4FKs4bVfzKwFH;
 Tue, 21 Jul 2026 13:20:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784632817; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKpi1QJExAG0mTKbgB479qLyGlvO4ws8edcvgoE0sNw=;
 b=LJI39VGcVauLEYgUYPnMNj8DTDe+i1zpBwT6gcnHJFMursZ3cC+CZh1+BhMyKfpgAFaXB0
 llbjx8Xl6bzHFPMC1LLF3h04sBjDKOdUuxgxf+8uVNeF7Cl1OAMfH1O13VIH9AQDXB0jVH
 wQ0f+/OzkowhGvIYuhPD6eib84bfWMAvDhjGQJiTUnLKq+lpW0GoSEZW/WLERXEz8xDx39
 Bux2hz9/3788GUPUCei/l4pLE6VvfYU21kySbWVQAzXX3H4x9LbthlHgsC+njHvcqycAGu
 to6TgmpMuXGfAHUlIE0sCp5rEgvViiSHRwOPi7FSwgmt9hwbwi8aF47nZMfQzA==
Message-ID: <d2d9aca41c4f0b9b6e5ae4e9b8e5de3c2d8f95c6.camel@mailbox.org>
Subject: Re: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Philipp Stanner
 <phasta@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>, Sean Paul
 <seanpaul@chromium.org>, Gustavo Padovan	 <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com, Simona Vetter
 <simona.vetter@ffwll.ch>, 	stable@vger.kernel.org
Date: Tue, 21 Jul 2026 13:20:07 +0200
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
 <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 9h7711f6dsx8ed7fjaab3zaieaz7czi3
X-MBO-RS-ID: 6c79188dbeca7e152c3
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-07-21 at 09:21 +0100, Andr=C3=A9 Draszik wrote:
> In [1], sashiko reported the following issue:
>=20
> =3D=3D=3D snip =3D=3D=3D
> Looking at how these fences are managed, drm_crtc_create_fence()
> creates a dma_fence without taking a reference to the drm_device or
> drm_crtc. Because the sync_file framework exposes this fence to
> userspace, the fence can outlive the CRTC.
>=20
> The dma_fence contract requires that data accessed by dma_fence_ops
> (like get_driver_name) must remain valid for an RCU grace period after
> the fence is signaled. However, drm_crtc_cleanup() and the subsequent
> freeing of the device do not wait for an RCU grace period via
> synchronize_rcu().
>=20
> If userspace calls ioctl(SYNC_IOC_FILE_INFO) concurrently with a device
> hot-unplug:
>=20
> CPU1 (Userspace)
> sync_file_get_name()
> =C2=A0 ops =3D rcu_dereference(fence->ops);
> =C2=A0 if (!dma_fence_test_signaled_flag())
> =C2=A0=C2=A0=C2=A0 // Preempted or delayed here

nit: no one will be preempted here since the RCU read lock must be
held. The Sashiko tool misses the point, which is simply that someone
illegally frees up stuff that might be still in use, with or without
delay or preemption, that's all irrelevant for the issue.

Anyways, thanks for fixing this:

>=20
>=20

[=E2=80=A6]

> Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c0=
3e77b36f34@linaro.org?part=3D1
> Fixes: 6d6003c4b613 ("drm/fence: add fence timeline to drm_crtc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

>=20
> ---
> v3:
> - Philipp: update kerneldoc, add Fixes:
>=20
> v2: new patch
> ---
> =C2=A0drivers/gpu/drm/drm_crtc.c | 15 ++++++++++++---
> =C2=A01 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..e8e80c936852 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -493,14 +493,23 @@ EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
> =C2=A0 * drm_crtc_cleanup - Clean up the core crtc usage
> =C2=A0 * @crtc: CRTC to cleanup
> =C2=A0 *
> - * This function cleans up @crtc and removes it from the DRM mode settin=
g
> - * core. Note that the function does *not* free the crtc structure itsel=
f,
> - * this is the responsibility of the caller.
> + * This function cleans up @crtc and removes it from the DRM mode settin=
g core,
> + * after first waiting an RCU grace period to ensure @crtc->dev can safe=
ly be
> + * dereferenced by our dma_fence_ops.
> + *
> + * Note that the function does *not* free the crtc structure itself, thi=
s is the
> + * responsibility of the caller.
> =C2=A0 */
> =C2=A0void drm_crtc_cleanup(struct drm_crtc *crtc)
> =C2=A0{
> =C2=A0	struct drm_device *dev =3D crtc->dev;
> =C2=A0
> +	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
> +	 * the fence is signaled. This is necessary because our dma_fence_ops
> +	 * dereference crtc->dev.
> +	 */
> +	synchronize_rcu();
> +
> =C2=A0	/* Note that the crtc_list is considered to be static; should we
> =C2=A0	 * remove the drm_crtc at runtime we would have to decrement all
> =C2=A0	 * the indices on the drm_crtc after us in the crtc_list.
