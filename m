Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93975606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PViqqUHy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C210010E41C;
	Thu, 26 Nov 2026 17:24:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D76D10E41C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 17:24:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3924243CC0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 17:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831081F000C4;
 Thu, 26 Nov 2026 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795713854;
 bh=MoBIqvG8dNjYRVZtJGGgK4JFoprL2V+QtAwvKKT1PAg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PViqqUHysMoY2drMc6MNLf/yi6YlKHZO1/9HoecvBeMHF0JvtXkC7B/gHNaefbGeT
 +oy4cy+fxk8t+lmNv/2tiqNXhLnjw2Ve+xvcTyLLc0k3lNhIRDGIYWZlgezhu2RIwd
 YcC2In8r8lrECs7OK1ZK6qfRAoQReN9RReBWimQYuLiubQdFuzMIiO5sJAfdURivP8
 6i11zc1/k1g7jjsNeDym7Xo5fl0vrLDyKnWPC2qMQ8O2Q/NGvpWxkWlmtg773+ukx9
 OYbDBADyV9/310QN6J+E9Ynqu4+CGyl3QqmxCKA3Q86lH1cFaclu+wTHW4wIepsvGj
 m+Eb8JCdbqzPw==
Message-ID: <sashiko-outbox-235974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm: fbdev: Unpin the framebuffer buffer object
 on destroy
To: "Vladimir Zapolskiy" <vz@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126170535.361985-2-vz@kernel.org>
References: <20261126170535.361985-1-vz@kernel.org>
 <20261126170535.361985-2-vz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 17:24:14 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/msm: missing msm_gem_vma_get() in
  msm_fbdev_driver_fbdev_probe() [1]
--

commit f61acbf5c2e9c608df43ac6974e8470121d1679c
Author: Vladimir Zapolskiy <vz@kernel.org>

drm/msm: fbdev: Unpin the framebuffer buffer object on destroy

This commit unpins the framebuffer GEM buffer object from the KMS address
space in msm_fbdev_fb_destroy() before deleting the client buffer.

> diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fb=
dev.c
> index f37cc3f97a21f..25e55b5c5ecc0 100644
> --- a/drivers/gpu/drm/msm/msm_fbdev.c
> +++ b/drivers/gpu/drm/msm/msm_fbdev.c
> @@ -41,6 +41,7 @@ static int msm_fbdev_mmap(struct fb_info *info, struct =
vm_area_struct *vma)
>  static void msm_fbdev_fb_destroy(struct fb_info *info)
>  {
>  	struct drm_fb_helper *helper =3D (struct drm_fb_helper *)info->par;
> +	struct msm_drm_private *priv =3D helper->dev->dev_private;
>  	struct drm_gem_object *bo =3D msm_framebuffer_bo(helper->fb, 0);
> =20
>  	DBG();
> @@ -48,6 +49,7 @@ static void msm_fbdev_fb_destroy(struct fb_info *info)
>  	drm_fb_helper_fini(helper);
> =20
>  	msm_gem_put_vaddr(bo);
> +	msm_gem_unpin_iova(bo, priv->kms->vm);

[Severity: High]
This problem wasn't introduced by this patch, but does
msm_fbdev_driver_fbdev_probe() need to call msm_gem_vma_get(bo) [1]
when pinning the framebuffer in priv->kms->vm (paired with
msm_gem_vma_put(bo) in msm_fbdev_fb_destroy())?

drivers/gpu/drm/msm/msm_fbdev.c:msm_fbdev_driver_fbdev_probe() {
	...
	ret =3D msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
	...
	drm_gem_handle_delete(file, handle);
	return 0;

err_msm_gem_unpin:
	msm_gem_unpin_iova(bo, priv->kms->vm);
	msm_gem_vma_put(bo);
err_drm_client_buffer_delete:
	drm_client_buffer_delete(buffer);
err_drm_gem_handle_delete:
	drm_gem_handle_delete(file, handle);
	return ret;
}

The only VMA reference on bo comes from drm_gem_handle_create() ->
msm_gem_open().  Deleting the temporary handle at the end of probe calls
msm_gem_close() -> msm_gem_vma_put(), which drops vma_ref to zero and
tears down the KMS VMA while fbi->fix.smem_start still holds the freed
IOVA.  If msm_gem_get_vaddr() fails instead, err_msm_gem_unpin calls
msm_gem_vma_put() before falling through to drm_gem_handle_delete(),
underflowing vma_ref to -1.

[1] https://sashiko.dev/#/bug/linux-f430fb49-9db8-4da0-8b31-b9f1caff2095

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126170535.3619=
85-1-vz@kernel.org?part=3D1
