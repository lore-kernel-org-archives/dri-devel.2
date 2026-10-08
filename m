Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9D8CA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE1210E41D;
	Thu,  8 Oct 2026 03:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ENdKyFmW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E46110E41D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:44:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E989409B1;
 Thu,  8 Oct 2026 03:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C4A1F00893;
 Thu,  8 Oct 2026 03:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791431098;
 bh=C9/Oss/JFN3oT5aEwQ9Q61tt42Sr2/hb/LbR8Gi2LYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ENdKyFmW30ZA4xdtgVuq3HY34MjxIspwg676x9gh4zwAAbf85EaMh8daaM1nxTXgn
 ZgnHcAFhwx8r/cxqwEjc2L7fnOUHQLwh9QHBi8EYcixgoSwHW2WXJ34h445IFwyU04
 Fs4mwVZtPOp2B5ObU77yVHUwH0mf2jITglU/mpJnImXduwKaRZY6rikGn4KoKBjnOh
 oVFwDnPzaJ3Rg+7FS6RCVvCqFHhDbqvwhYO7N/CaWZkJr+R1zPOYksjtIo5fVjm754
 UPcZim7Ujss4EcdKW0zjt+TtLUJgyDoENKvRiXNDd8yBset6R//3gJJnlWndf6FeHA
 eeXczdyExB2FA==
Message-ID: <sashiko-outbox-163576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 05/19] accel/amdxdna: Add NPU3 classic device support
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-6-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-6-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:44:57 +0000
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
- [Medium] amdxdna: user-triggerable WARN_ON due to 0 dev_mem_size on NPU3
--

commit f86aaf866bc504bcba674227ac3b36c9902b057f
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Add NPU3 classic device support

This commit adds NPU3 classic device operations, register definitions, PCI
device IDs, and firmware declarations. It also guards device heap memory
initialization against a zero-sized device heap, since NPU3 does not
configure a dedicated device memory heap.

> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/np=
u3_regs.c
> index 93f749acb5d5d..c82433d629012 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c

[ ... ]

> @@ -105,3 +105,17 @@ const struct amdxdna_dev_info dev_npu3_vf_info =3D {
>  	.cert_feature_tbl	=3D npu3_cert_feature_table,
>  	.ops			=3D &aie4_vf_ops,
>  };
> +
> +const struct amdxdna_dev_info dev_npu3_classic_info =3D {
> +	.mbox_bar		=3D NPU3_MBOX_BAR,

[Severity: Medium]
Since this struct leaves dev_mem_size uninitialized (defaults to 0),
can this cause a user-triggerable WARN_ON?

When an unprivileged user space client calls the DRM_IOCTL_AMDXDNA_CREATE_BO
ioctl with args.type =3D=3D AMDXDNA_BO_DEV_HEAP, the handler delegates to
amdxdna_drm_create_dev_heap_bo() without verifying if the device actually
supports a heap.

In amdxdna_drm_create_dev_heap_bo():

        WARN_ON(!is_power_of_2(xdna->dev_info->dev_mem_size));

Since dev_mem_size is 0, is_power_of_2(0) evaluates to false, causing the
WARN_ON to execute. This allows any local user with DRM node access to
flood the kernel log or potentially trigger a crash if panic_on_warn is
enabled.

> +	.sram_bar		=3D NPU3_MBOX_BUFFER_BAR,
> +	.psp_bar                =3D NPU3_PSP_BAR_INDEX,
> +	.smu_bar		=3D NPU3_SMU_BAR_INDEX,
> +	.doorbell_bar		=3D NPU3_DOORBELL_BAR,
> +	.default_vbnv		=3D "RyzenAI-npu3",
> +	.device_type		=3D AMDXDNA_DEV_TYPE_UMQ,
> +	.dev_priv		=3D &npu3_dev_priv,
> +	.fw_feature_tbl		=3D npu3_fw_feature_table,
> +	.cert_feature_tbl	=3D npu3_cert_feature_table,
> +	.ops			=3D &aie4_classic_ops,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D5
