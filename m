Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4C4CDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 23:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7503410F3D1;
	Thu, 25 Jun 2026 23:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uj4Z3mJP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7602110F3D1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 23:27:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF43D60098;
 Thu, 25 Jun 2026 23:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CE71F000E9;
 Thu, 25 Jun 2026 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782430024;
 bh=GfeKln7VY43gLP9rWHhRQ2Q659Cfc3yPzLNXr3JipLQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Uj4Z3mJPSaeMsGcQDGr6ge7FplsFjyNqRS/8bd+IjG1pujknYGpZUBi1x4j48uqxl
 xEV++jZi8qiW4I66/l/POxzyZhvgHPs3TY27Joc1lpTxSNXBcO9B1Ciogqh3jb2cWL
 CSJeVzMKE6DE4J2pXy6MwOt4M1RB7iLCoRePP7vDTe3kd4xfFUQxlgnUZvgHFeUrdg
 sNQsppujCfDNLzqPcZ7g8vAmRUEMktbGRlRZpM+JRsdu5BQsIJI1GPkkGqpV5l936b
 anU7pdd8xtmeyYM6UacdsFg0ZA0GYSnJWg0SWy7CJqzqaPygwnZHEFVEoetxem8loj
 JmOkudC6ikHmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Revert "nouveau/gsp: fix suspend/resume regression
 on r570 firmware"
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625231252.89684-2-lyude@redhat.com>
References: <20260625231252.89684-1-lyude@redhat.com>
 <20260625231252.89684-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 23:27:03 +0000
Message-Id: <20260625232704.47CE71F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Hardware channels and BAR2 are left permanently disabled when r570=
_fbsr_suspend fails midway.
--

commit ba836a35e2d15cfdb3c33dd77c467b89aed9e52a
Author: Lyude Paul <lyude@redhat.com>

Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"

This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18, which was
intended to fix a suspend/resume regression on r570 firmware but instead
caused runtime PM to fail on many laptops.

Cc: <stable@vger.kernel.org> # v6.19+

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c

[ ... ]

> @@ -92,7 +92,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *s=
gt, u64 size, bool runtim
>  }
> =20
>  static int
> -r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
> +r570_fbsr_suspend(struct nvkm_gsp *gsp)
>  {
>  	struct nvkm_subdev *subdev =3D &gsp->subdev;
>  	struct nvkm_device *device =3D subdev->device;

[ ... ]

> @@ -133,7 +133,7 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
>  		return ret;
> =20
>  	/* Initialise FBSR on RM. */
> -	ret =3D r570_fbsr_init(gsp, &gsp->sr.fbsr, size, runtime);
> +	ret =3D r570_fbsr_init(gsp, &gsp->sr.fbsr, size);
>  	if (ret) {
>  		nvkm_gsp_sg_free(device, &gsp->sr.fbsr);
>  		return ret;

[Severity: High]
This is a pre-existing issue, but does this error path leave the GPU
unusable if it fails?

During the suspend sequence, r570_fbsr_suspend() disables channel
scheduling and BAR2 early on. If a subsequent operation like
r570_fbsr_init() (or nvkm_gsp_sg() earlier) fails, it returns an error
here without restoring the hardware state.

Since the PM core will abort the suspend on error and skip the resume
callback for this device, does this mean channels and BAR2 are never
re-enabled, leaving the device in an unrecoverable state until reboot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625231252.8968=
4-1-lyude@redhat.com?part=3D1
