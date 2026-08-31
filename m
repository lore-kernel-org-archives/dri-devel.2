Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4BBC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F64610E4CC;
	Mon, 31 Aug 2026 12:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jHt15kCz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB3410E4CC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 12:33:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A83943D3A;
 Mon, 31 Aug 2026 12:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110C91F00A3D;
 Mon, 31 Aug 2026 12:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788179607;
 bh=cNOsp31OGBXEdQPcnDWbmzK7ZwDCBTeskUMUM2pFRFo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jHt15kCzRptfbH5HZuIyJLFrX1mGlOYmuONfnBVX/WU6EY5mJfW1xeT6UnPNj7mxv
 e7I2ZRD15dZKWyoTYYF7FUZzJ7yCnfObfoSrTey+AdejZYx/ZPuXRJFiLlYXFMQfUU
 bJc1rk4jrf/r0+9sECzksJE0ZWwZ+vVeRiWmc+jCrkGe693qDec7mjD/nQhwfmi4nw
 6CdJ6o3gLE3Mtk6VUI837sa1Uw2Q1T2pHv6fCkJKUOvhGjIvEKLxaBFzi4nLPJbbeU
 gRDUE1iVyWDLkbfM+g194euihh9b0yXVw8MP1D7l5cgggUoOLdEkvDiSf87O8igirl
 n+rTfJcMxIIbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Add support for getting and setting command
 queue priority
To: "Andrzej Kacprowski" <andrzej.kacprowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831121617.395523-1-andrzej.kacprowski@linux.intel.com>
References: <20260831121617.395523-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 12:33:26 +0000
Message-Id: <20260831123327.110C91F00A3D@smtp.kernel.org>
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
- [High] Missing CAP_SYS_NICE or DRM_MASTER check for elevated job prioriti=
es (REALTIME / FOCUS), allowing unprivileged users to monopolize the NPU.
--

commit 57cf0d7005a7761ad6193ea568802164b7fac6db
Author: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

accel/ivpu: Add support for getting and setting command queue priority

This commit adds a new DRM_IVPU_PARAM_CMDQ_PRIORITY parameter to query and
update the scheduling priority of an existing command queue. The priority
can be changed on a queue that already has pending jobs, propagating the
change to firmware in hardware scheduling mode.

> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index ebb2c865b09a0..b3de5dd29d1e8 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c

[ ... ]

> @@ -1127,6 +1132,86 @@ int ivpu_cmdq_destroy_ioctl(struct drm_device *dev=
, void *data, struct drm_file
>  	return ret;
>  }
> =20
> +static int ivpu_cmdq_priority_args_check(struct ivpu_device *vdev, u32 c=
mdq_id, u64 priority)
> +{
> +	if (!ivpu_is_capable(vdev, DRM_IVPU_CAP_CMDQ_SET_PRIORITY)) {
> +		ivpu_dbg(vdev, IOCTL, "Command queue priority not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	if (cmdq_id < IVPU_CMDQ_MIN_ID || cmdq_id > IVPU_CMDQ_MAX_ID) {
> +		ivpu_dbg(vdev, IOCTL, "Invalid command queue ID %u\n", cmdq_id);
> +		return -EINVAL;
> +	}
> +
> +	if (priority > DRM_IVPU_JOB_PRIORITY_REALTIME)
> +		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but is there a missing capability check for
elevated priorities here?

An unprivileged user who opens the NPU device can call the IVPU_SET_PARAM
ioctl with DRM_IVPU_PARAM_CMDQ_PRIORITY and set the priority to
DRM_IVPU_JOB_PRIORITY_REALTIME. Without a CAP_SYS_NICE or DRM_MASTER check,
could a malicious or buggy application elevate its command queue priority to
monopolize the hardware and starve other processes?

I notice this same behavior appears to be pre-existing in
ivpu_cmdq_create_ioctl() as well, where queues can be created with realtime
priority by any user. Should these priority levels be restricted?

> +
> +	return 0;
> +}
> +
> +int ivpu_cmdq_get_priority(struct ivpu_file_priv *file_priv, u32 cmdq_id=
, u64 *priority)
> +{

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831121617.3955=
23-1-andrzej.kacprowski@linux.intel.com?part=3D1
