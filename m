Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A4BCD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0EE10E5DD;
	Tue,  9 Jun 2026 19:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UW9tKv2v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C13C10E5DD
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:38:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6627E42D8D;
 Tue,  9 Jun 2026 19:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD6E1F00893;
 Tue,  9 Jun 2026 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781033921;
 bh=4Qkz6DOqkZ66VvYidaGJY4/KLC76NW7muVqfZU+Lc7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UW9tKv2vw1OtbIp9Mxj8gliwX96xJ8QbbhwChY8mCQyZlaiuB0Ts1DjsPGCOVoQL0
 y9zoCSgfJl3wjtPUJ7QM5VB2C79FB+Uk7ppPIaLdGPUhgKgDZ2a11rgG07bSinlJzJ
 SW+EEnImQa1gTEcS3dKYGZYrSGFoic7rEHrsOuMjmA2mW4gmfJpCc0YpKvq0aoLkHg
 ffozoAywS/XMgHZjFLtmlbSKgXNiwtqxeSg0lHjo/PvJPr2EXa3HIlYL+XePhznfG/
 9jYJYm7mq/WkVmS1ml6nf6GFek1bbgrPWmI4ZhRGLguD+9CRU3C0O3g3oGmoS/JCG0
 ZeGkdx1BhdF4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org
In-Reply-To: <20260608185646.4085127-6-zhipingz@meta.com>
References: <20260608185646.4085127-6-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 19:38:40 +0000
Message-Id: <20260609193841.0DD6E1F00893@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the `mlx5r_creat=
e_mkeys` error rollback loop contains an off-by-one error. It leaks the suc=
cessfully created hardware mkey at `handles[0]` and improperly attempts to =
destroy the uninitialized failed handle at `handles[i]`, which translates t=
o destroying the reserved hardware mkey index 0.
--

commit 37ae7395b661b5e14306aec55bedd4ae96943e49
Author: Zhiping Zhang <zhipingz@meta.com>

RDMA/mlx5: get tph for p2p access when registering dma-buf mr

Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
peer access and translate the returned steering tag into an mlx5 ST
index. Keep the DMAH path as the first priority and only fall back to
DMA-buf metadata when no DMAH is supplied.

[ ... ]

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index 254e6aa4ccafb..7b0a883e04048 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c

[ ... ]

> @@ -299,7 +331,8 @@ static int mlx5r_create_mkeys(struct ib_device *devic=
e, struct ib_frmr_key *key,
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes
in mlx5r_create_mkeys(), I noticed an off-by-one error in the error
rollback loop right above this return statement.

The error rollback loop is written as:

	if (err)
		for (; i > 0; i--)
			mlx5_core_destroy_mkey(dev->mdev, handles[i]);

Since the loop body operates on handles[i] and decrements afterward, doesn't
this terminate before i =3D=3D 0, thereby skipping handles[0] and leaking t=
he
first successfully created hardware mkey?

Additionally, is it safe to call mlx5_core_destroy_mkey() on the failed
handles[i] where the error occurred?

Because handles[i] only received an 8-bit variant via assign_mkey_variant()
and the firmware failed to populate its hardware index, its upper 24 bits
are zeroed. When mlx5_mkey_to_idx() extracts the upper 24 bits, it yields 0.

Could this cause the driver to inadvertently destroy mkey index 0, which is
a reserved hardware resource?

> =20
> -static void mlx5r_destroy_mkeys(struct ib_device *device, u32 *handles,
> +static void mlx5r_destroy_mkeys(struct ib_device *device,
> +				const struct ib_frmr_key *key, u32 *handles,
>  				unsigned int count)
>  {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608185646.4085=
127-1-zhipingz@meta.com?part=3D5
