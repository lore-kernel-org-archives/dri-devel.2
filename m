Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5BEC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0963B10E126;
	Fri, 10 Jul 2026 12:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PMfnteTl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241A410E126
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:00:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70F91600C3;
 Fri, 10 Jul 2026 11:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81A21F000E9;
 Fri, 10 Jul 2026 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783684799;
 bh=PYgDsQYuLbfalbhG9b6XJtlqaTJrgDhAQ6Bp7baDmoA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PMfnteTlYy6V6+Gwk9Wp3++tMSBKBxKx0BP+7gpM55EyiV+QuZbLtsM7CPEYMgp66
 wUtVw5q81lYNbzpw/AHzUeuWx5iQ60UfCUqC20uw8kYSAJ1PpYLOALKEVKJAGNO8p3
 TUbE2qtY+Ips6gyZs9QoIzSq+StfFTQncgHrAPgY7EtMRm1vQI81BmjIziYUt5qgoZ
 sWAjL6C5G/Xa5ZvI7iiuxOwajUz92IgbQjNmxjBzWiXwhpzjM7zjnOqydQxWPS9JG3
 eVAUtPhevR1AhEwcmrvM+hENLTgmYThYWqEeOwER1OCYtAO8yhAJpIK1zHR8UDTa+w
 +nBxhEF4aThww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/v3d: Associate BOs with every job that accesses
 them
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710114734.2731000-1-mcanal@igalia.com>
References: <20260710114734.2731000-1-mcanal@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:59:58 +0000
Message-Id: <20260710115958.E81A21F000E9@smtp.kernel.org>
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
- [High] Missing implicit synchronization for V3D_BIN jobs leads to data co=
rruption when reading shared BOs
--

--- Patch [1]: [PATCH v4] drm/v3d: Associate BOs with every job that access=
es them ---
commit 72f7a40fe9b93eb2404edd2978dd5c1851c59920
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Associate BOs with every job that accesses them

This patch associates BOs with the specific jobs that consume them, rather
than just the last job in a submission chain, to ensure correct implicit
dependencies are acquired. It introduces a has_implicit_dep flag to avoid
adding these dependencies to jobs that don't need them, like CACHE_CLEAN.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 119a81c9e1c46..834d52030979d 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> @@ -223,13 +246,14 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct dr=
m_file *file_priv,
>  static const struct {
>  	size_t size;
>  	void (*free)(struct kref *ref);
> +	bool has_implicit_dep;
>  } v3d_job_types[] =3D {
> -	[V3D_BIN]		=3D { sizeof(struct v3d_bin_job), v3d_job_free },
> -	[V3D_RENDER]		=3D { sizeof(struct v3d_render_job), v3d_render_job_free =
},
> -	[V3D_TFU]		=3D { sizeof(struct v3d_tfu_job), v3d_job_free },
> -	[V3D_CSD]		=3D { sizeof(struct v3d_csd_job), v3d_job_free },
> -	[V3D_CACHE_CLEAN]	=3D { sizeof(struct v3d_job), v3d_job_free },
> -	[V3D_CPU]		=3D { sizeof(struct v3d_cpu_job), v3d_cpu_job_free },
> +	[V3D_BIN]		=3D { sizeof(struct v3d_bin_job), v3d_job_free, false },

[Severity: High]
This is a pre-existing issue, but does setting has_implicit_dep to false for
V3D_BIN jobs risk data corruption when a user space application shares a BO
between contexts via dma-buf?

If a shared BO is written by a first context and subsequently used as a
Vertex Buffer in a rendering submission in a second context, the BIN job
will run Vertex Shaders to compute positions. If it explicitly lacks
implicit dependencies, could the DRM scheduler dispatch it immediately,
causing it to read the Vertex Buffer while the first context is still
writing to it?

[ ... ]

> @@ -1165,22 +1195,33 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void =
*data,
>  	if (ret)
>  		goto fail;
> =20
> +	/*
> +	 * We don't associate the BOs with the BIN job. Fences are only
> +	 * attached to the last job in the submission chain, and BIN jobs
> +	 * don't need implicit dependencies since depending on results from
> +	 * another context is not a realistic scenario for binning.
> +	 */
> +	ret =3D v3d_lookup_bos(submit.file_priv, &render->base,
> +			     args->bo_handles, args->bo_handle_count);

[Severity: High]
This is a pre-existing issue, but does intentionally omitting BO attachment
for the BIN job prevent it from tracking the buffers it reads?

The comment mentions that depending on results from another context is not a
realistic scenario for binning. However, if a buffer is exported from anoth=
er
subsystem (like a video decoder or compute) and used as a vertex buffer,
wouldn't the binning job need to wait for that buffer's dma_resv fences to
ensure the data is fully written before reading it?

> +	if (ret)
> +		goto fail;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710114734.2731=
000-1-mcanal@igalia.com?part=3D1
