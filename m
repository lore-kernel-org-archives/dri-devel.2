Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92FFC9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EF610E13E;
	Sat, 26 Sep 2026 15:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZfhhTmW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81FFC10E13E
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:59:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F8CB43751;
 Sat, 26 Sep 2026 15:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28DD1F000FF;
 Sat, 26 Sep 2026 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790438373;
 bh=hw2thlLjoc62I8gfMmrYIlTQhw2awp8hUVQwM52oA1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MZfhhTmWn2Ka90TyXCuXeFCIM3HocVjfcx3hhdg7EenlF+m5AZu4Q99EaRJ2sUb4H
 ylCNGYJ9saVOhV7bEGd9YvpEpqBFWnusDzyVtVZXj6RqZl79FJvRawjUzOG1q+qUQg
 /IY298/x5PO6+2GqqvGB1qFxX4MtcZT4J5cFte9xudrwpoedwESuyLfPTY6MNuB++j
 82FagpzDjVEJqI0RpUHKKjPYjeiufF8PLqa6plQkGIG6GtHqPYaG4r5OZIZkEN5+2l
 3y1RFTo0vBQCcasV8fzl3+krSjDm6CSmRJtoF9PvdJ9aKzRBp+55m55UkpGxlFAxGV
 NRjRTobFgMQSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] remoteproc: qcom_wcnss: migrate to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260925155737.4161358-2-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-2-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:59:32 +0000
Message-Id: <20260926155932.D28DD1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] remoteproc: qcom_wcnss: DMA memory leak of metadata in wcnss_load()
- [High] remoteproc: qcom_wcnss: missing pas_ctx->use_tzmem =3D true preven=
ts required shmbridge creation
--

commit 77b1a378f038e55ff2a11032d9b6f243214fbb7f
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date:   Fri Sep 25 15:57:30 2026 +0000

    remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load() and qcom_pas_pre=
pare_and_auth_reset()

This commit migrates the Qualcomm WCNSS remoteproc driver to use=20
qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset(). It allocates a=20
PAS context during probe to support TrustZone authentication with shmbridge=
=20
preparation.

> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wc=
nss.c
> index c856a92af43ce..01f9076aa0b17 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c

[ ... ]

> @@ -157,9 +158,7 @@ static int wcnss_load(struct rproc *rproc, const stru=
ct firmware *fw)
>  	struct qcom_wcnss *wcnss =3D rproc->priv;
>  	int ret;
> =20
> -	ret =3D qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> -			    (__force void *)wcnss->mem_region, wcnss->mem_phys,
> -			    wcnss->mem_size, &wcnss->mem_reloc);
> +	ret =3D qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, &wcnss->=
mem_reloc);

[Severity: High]
Does this introduce a DMA memory leak of the metadata buffer?

By passing wcnss->pas_ctx to qcom_mdt_pas_load(), the allocated metadata
buffer is retained in wcnss->pas_ctx->ptr. In the previous qcom_mdt_load()
implementation, passing a NULL context signaled the backend to free the
buffer immediately.

Since the remoteproc operations structure (wcnss_ops) lacks an .unprepare
hook, there doesn't seem to be a corresponding call to
qcom_pas_metadata_release(wcnss->pas_ctx) when the device is shut down.

Will this persistently leak DMA memory each time the remoteproc is started
and stopped via sysfs?

>  	if (ret)
>  		return ret;

[ ... ]

> @@ -600,6 +599,11 @@ static int wcnss_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
> =20
> +	wcnss->pas_ctx =3D devm_qcom_pas_context_alloc(wcnss->dev, WCNSS_PAS_ID,
> +						     wcnss->mem_phys, wcnss->mem_size);

[Severity: High]
The commit message explicitly states the goal is to include the shmbridge
prepare step required before TrustZone authentication. However, does this
actually enable the shmbridge?

The newly allocated wcnss->pas_ctx is zero-initialized by
devm_qcom_pas_context_alloc(), so pas_ctx->use_tzmem defaults to false. When
use_tzmem is false, qcom_scm_pas_prepare_and_auth_reset() explicitly skips
creating the shmbridge and falls back to the legacy behavior.

Should wcnss->pas_ctx->use_tzmem be set to true here to fulfill the stated
security objective?

> +	if (IS_ERR(wcnss->pas_ctx))
> +		return PTR_ERR(wcnss->pas_ctx);
> +
>  	wcnss->pmu_cfg =3D mmio + data->pmu_offset;
>  	wcnss->spare_out =3D mmio + data->spare_offset;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155737.4161=
358-1-mukesh.ojha@oss.qualcomm.com?part=3D1
