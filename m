Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124D4CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7331810EB57;
	Fri,  9 Oct 2026 23:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GB8vUd0E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5C810EB57
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:08:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F17960211;
 Fri,  9 Oct 2026 23:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A82B1F000FF;
 Fri,  9 Oct 2026 23:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791587312;
 bh=mkrUVtcvU2bRuRzCE+2xaz3xlBu8d6rjFRB0TETaTds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GB8vUd0EyopN6kIUnLZhskRBEvzTIIdFJmpoF7mgaMT+Nktzm46/CpgQztV2LMFg4
 PytXIoHiESTr+V72DKcLI6WBNIeSp6BAP+pCxHYqvHhHZINuCxL/M04JSPBCHRC9FS
 jC55cYnP6SEnC/tRYnRwo+VzkvcNkGb1/7WJs4Vv71DQtB6hM7J0h6iQuChx43vlIa
 FNZ8fDfr/QW330ICvTSzvhNhTiEBkoiFGroMoH+a9X7oaie/In9a/0xoIoPAaisUNX
 KLYcCcAwKyZWKKUCWEoYL5Q9sCT+9WKd4j3A9bNoaRdNHL95Z8tE5wZ+mhr0c8GEw+
 we+TwdlobEmVQ==
Message-ID: <sashiko-outbox-166175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 05/19] accel/amdxdna: Add NPU3 classic device support
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009225343.3079074-6-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-6-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 23:08:32 +0000
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
- [Medium] amdxdna: user-triggerable WARN_ON via AMDXDNA_BO_DEV_HEAP on NPU=
3 classic
--

commit 9daa4537d3513c6a4bc057f8afd01b65162be2b6
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Add NPU3 classic device support

Add NPU3 classic device operations (aie4_classic_ops) and register
definitions, as well as the PCI device ID and firmware declarations for
NPU3 classic devices. Remove device IDs 0x1B0B and 0x1B0C because those
devices will not be released.

> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/np=
u3_regs.c
> index 93f749acb5d5d..c82433d629012 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -105,3 +105,17 @@ const struct amdxdna_dev_info dev_npu3_vf_info =3D {
>  	.cert_feature_tbl	=3D npu3_cert_feature_table,
>  	.ops			=3D &aie4_vf_ops,
>  };
> +
> +const struct amdxdna_dev_info dev_npu3_classic_info =3D {
> +	.mbox_bar		=3D NPU3_MBOX_BAR,
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

[Severity: Medium]
Since dev_mem_size is omitted here, it defaults to 0. Does this cause a
kernel warning when creating a device heap BO?

If an unprivileged user opens the accelerator device and requests a BO with
type AMDXDNA_BO_DEV_HEAP, the ioctl dispatcher calls
amdxdna_drm_create_dev_heap_bo() which unconditionally evaluates:

WARN_ON(!is_power_of_2(xdna->dev_info->dev_mem_size));

Since dev_mem_size is 0, this will evaluate to true and trigger a warning,
potentially causing a local denial of service if panic_on_warn is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009225343.3079=
074-1-yidong.zhang@amd.com?part=3D5
