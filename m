Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2306FC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BCA10F6B5;
	Fri, 11 Sep 2026 18:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ka/TLAKk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080D610F6B5
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:46:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BECDB4191D;
 Fri, 11 Sep 2026 18:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DA11F000FF;
 Fri, 11 Sep 2026 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789152373;
 bh=55tXRHPx+Y+AaGKeNfnLCI/eEih29vPRjWhLRw+90x8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ka/TLAKkkY1gEEiwxlraCCAyaXtx6gPNlczFDBGqP9+xqMMRxZmlSUjWrSNozkcjB
 ymWrTmO376p3lMT9IyX7rG8FWzT8EyDzk5ESxZzJJWbC6VavUAD8HksdLI/xHcZctS
 tbICoM3J43Mob+vDX1/8Kc3zD9lCPq/hnl3QTgYYjZctAZjxcZDv6TNswtoHheDlBC
 dhnRhUvPal6dWkq9xylmjQ/J+hNZjqBmizusNoiw4N1eaH+V0VV1kEnnakssmWU+hJ
 9QpTd5O1rpC+L5QEG12A/4krhpBoh7c5OC/HTkjEWvjmCZzxfO+z8NaR4tWv/7smNY
 1i+EiZnYTwWIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amdgpu: hold a runtime PM reference for P2P
 dma-buf attachments
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911183825.935140-1-mike@fireburn.co.uk>
References: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
 <20260911183825.935140-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 18:46:13 +0000
Message-Id: <20260911184613.77DA11F000FF@smtp.kernel.org>
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
- [High] Incorrect handling of negative return values from pm_runtime_get_i=
f_active() causes a runtime PM usage count underflow.
--

commit ea3c97ff59ae3ca0f3d8bdf4b2a1ca3b95cda6f8
Author: Mike Lothian <mike@fireburn.co.uk>
drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments

This commit takes a runtime PM reference in amdgpu_dma_buf_attach() and dro=
ps
it in amdgpu_dma_buf_detach() to prevent P2P dma-buf attachments from falli=
ng
back to GTT when the exporting device is suspended. It uses
pm_runtime_get_if_active() to avoid deadlocks against the resume path.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index b33c300e26e2e..fae695c3e5315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
[ ... ]
> @@ -100,15 +101,50 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dm=
abuf,
>  	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>  		attach->peer2peer =3D false;
> =20
> +	/*
> +	 * P2P access needs the exporter awake for the lifetime of the
> +	 * attachment.  pm_runtime_get_if_active() never resumes the device,
> +	 * so it cannot deadlock against the reservation taken during resume.
> +	 * A negative return means runtime PM is disabled and the device
> +	 * cannot suspend, in which case the put in detach is a no-op.
> +	 */
> +	if (attach->peer2peer &&
> +	    !pm_runtime_get_if_active(adev_to_drm(adev)->dev))
> +		attach->peer2peer =3D false;

[Severity: High]
The comment states that the put in detach is a no-op, but is this accurate?

pm_runtime_get_if_active() can return a negative error code (such as -EINVAL
when runtime PM is disabled). In that case, !pm_runtime_get_if_active()
evaluates to false, bypassing the attach->peer2peer =3D false assignment.

Since the reference was not actually acquired, but attach->peer2peer remains
true, wouldn't the unbalanced pm_runtime_put_autosuspend() calls in
err_pm_put and amdgpu_dma_buf_detach() cause a PM usage count underflow
rather than acting as a no-op?

> +
>  	r =3D dma_resv_lock(bo->tbo.base.resv, NULL);
>  	if (r)
> -		return r;
> +		goto err_pm_put;
> =20
>  	amdgpu_vm_bo_update_shared(bo);
> =20
>  	dma_resv_unlock(bo->tbo.base.resv);
> =20
>  	return 0;
> +
> +err_pm_put:
> +	if (attach->peer2peer)
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
> + *
> + * @dmabuf: DMA-buf where we remove the attachment from
> + * @attach: the attachment to remove
> + *
> + * Drop the runtime PM reference taken in amdgpu_dma_buf_attach().
> + */
> +static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
> +				  struct dma_buf_attachment *attach)
> +{
> +	struct drm_gem_object *obj =3D dmabuf->priv;
> +	struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> +	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> +
> +	if (attach->peer2peer)
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911183825.9351=
40-1-mike@fireburn.co.uk?part=3D1
