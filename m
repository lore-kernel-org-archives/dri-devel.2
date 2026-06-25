Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8786FCDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4CD10E2B1;
	Thu, 25 Jun 2026 22:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KZBV9g74";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D86F10E2B1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:50:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C768E401FF;
 Thu, 25 Jun 2026 22:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC691F000E9;
 Thu, 25 Jun 2026 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782427810;
 bh=NnpWXwvbPfWB4bclWA/bnS1vkYrmVaKoTyA1YgpIkHM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KZBV9g74INKOaEaCkkp24iOeNa8ztHTVb/vri/kZoCPGBUQVfVrWs6JhmuLlFpnTN
 uP02i1rpNLJ3tdQMvVR+vwbxvzMsOELFxY9TC0XnPET0XHbRTICkJCHx+6zvYoiqlY
 WpO7+mWbDriKv8L1fIHWxFdsFa02HqKnZHVpEwH1c75ioeuEFR6seGudB4WBoqygME
 7eAKM7kxXe0vXYU4WolfdJTjUnArkGuEwIVtGB6ojlcB+pQDHcumwJV9XZ4cmGFdUB
 KWNG0Af61BX3aVgwXarM8ghlfIgXr8f0KZzMvv0XvK20j4pF8JxC2KadBX81IxoNOE
 xHBc1/6AgtXKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] drm/msm: Validate lazy VM is created in GEM_SUBMIT
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625222744.22254-3-robin.clark@oss.qualcomm.com>
References: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
 <20260625222744.22254-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:50:09 +0000
Message-Id: <20260625225010.7EC691F000E9@smtp.kernel.org>
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
- [High] Ineffective integer overflow protection during allocation size cal=
culation in `submit_create` leads to potential heap buffer overflows.
--

commit 0bc0c946b740e56645786e074bd1e98b7bdd28a0
Author: Rob Clark <robin.clark@oss.qualcomm.com>
Subject: drm/msm: Validate lazy VM is created in GEM_SUBMIT

This commit fixes a potential NULL pointer dereference in the GEM_SUBMIT
ioctl. It ensures that the lazy VM is validated and created before any
buffer objects are mapped.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 26ea8a28be474..0dc983d155cd2 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -30,7 +30,7 @@
>   */
> =20
>  static struct msm_gem_submit *submit_create(struct drm_device *dev,
> -		struct msm_gpu *gpu,
> +		struct msm_gpu *gpu, struct drm_gpuvm *vm,
>  		struct msm_gpu_submitqueue *queue, uint32_t nr_bos,
>  		uint32_t nr_cmds, u64 drm_client_id)
>  {

[Severity: High]
This is a pre-existing issue, but does the overflow check in this function
work as intended?

In submit_create(), sz is calculated using struct_size() and assigned to a
uint64_t variable:

	sz =3D struct_size(submit, bos, nr_bos) +
			((u64)nr_cmds * sizeof(submit->cmd[0]));

	if (sz > SIZE_MAX)
		return ERR_PTR(-ENOMEM);

Since sz and SIZE_MAX share the same maximum width on 64-bit architectures,
can sz ever evaluate to strictly greater than SIZE_MAX?

If the struct_size() calculation saturates to SIZE_MAX upon overflow, the
subsequent addition of the command array size could wrap sz around to a sma=
ll
positive value.

This would cause the check to evaluate to false and bypass the protection,
allocating a memory block that is too small for the requested elements and
allowing a potential heap buffer overflow if userspace provides extremely
large values for the number of buffer objects or commands.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625222744.2225=
4-1-robin.clark@oss.qualcomm.com?part=3D2
