Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E64C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5D010E4DD;
	Sat, 27 Jun 2026 13:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYaitmuN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E255410E4DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68B0B60051
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25EA1F000E9;
 Sat, 27 Jun 2026 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567750;
 bh=vEbmJROMXbC7QIqX++FJk3g0e475pUTlcxL0EVVKlMk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eYaitmuNJptdJBJwNTKwnvGZPSV/ETgXVL9GxU8qhiPiLNgmVIIhxwFV76Kj3SUd/
 NXsI14Y47N1MIKIl7ekq9vNWoV5N5Q+ndTmkoKm72jsDaQwaX48y5P04gBel0kJLxX
 7kbTiNM5SwVtDScKSuw8GleOYyG/2s66uMN8xapOwWk5x+IGTUd5zAZxXTQ1+QthZe
 dJDsQyGwidDSOvptu975OSCnxvNtL/Lvs97wZuO+PGZBgNW9s6peSfzWaY/cl9qUOf
 7atLctRBD4GjsWasSWzKY8sZIZcCozJN0IY4olCefeq+VPpnXgzd6CXVY5hdOlG+6x
 JIh9QW8is6DMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:29 +0000
Message-Id: <20260627134229.E25EA1F000E9@smtp.kernel.org>
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
- [High] Removing the `if (!ctx->ptr)` check from the metadata release path=
 causes a kernel crash when called with a `NULL` pointer on error paths or =
during teardown.
--

commit e2ee3fe2c5f5a59a30d27512b70afb597cba4bec
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

firmware: qcom_scm: Migrate to generic PAS service

With the availability of generic PAS service, this patch adds SCM calls as
a backend to keep supporting legacy QTEE interfaces. The exported qcom_scm*
wrappers will get dropped once all the client drivers get migrated as part
of future patches.

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 6b601a4b89dbf..7933e55803dc2 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c

[ ... ]

> -/**
> - * qcom_scm_pas_metadata_release() - release metadata context
> - * @ctx:	pas context
> - */
> -void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
> +static void __qcom_scm_pas_metadata_release(struct device *dev,
> +					    struct qcom_pas_context *ctx)
>  {
> -	if (!ctx->ptr)
> -		return;
> +	if (ctx->use_tzmem)
> +		qcom_tzmem_free(ctx->ptr);
>  	else
> -		dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
> +		dma_free_coherent(dev, ctx->size, ctx->ptr, ctx->phys);

[Severity: High]
Will this cause a kernel crash by passing a NULL pointer to
dma_free_coherent() on error paths?

If a client driver calls qcom_scm_pas_init_image() and it fails before
setting ctx->ptr (for example, if dma_alloc_coherent() fails), the
client's error handler will then call qcom_scm_pas_metadata_release().
Since the !ctx->ptr check was removed, this would execute
dma_free_coherent() with a NULL pointer.

I note that a later commit in the series (commit 823d5bd22444cb98ee7ba)
removes these SCM PAS wrappers entirely after clients are migrated.
However, does removing this safety check here break bisection for
existing client drivers in the meantime?

> =20
>  	ctx->ptr =3D NULL;
>  }
> +
> +void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
> +{
> +	__qcom_scm_pas_metadata_release(__scm->dev,
> +					(struct qcom_pas_context *)ctx);
> +}
>  EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D2
