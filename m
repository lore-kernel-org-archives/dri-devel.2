Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4A7C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29AA10FB69;
	Sat,  5 Sep 2026 01:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LC2ExAlZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C7D10FB69
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:00:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F444435E8
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9AA1F00A3D;
 Sat,  5 Sep 2026 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788570021;
 bh=nv9dxtWRZIiCAPZdEv35XIE/4aVwjlS3yRpoycLM1gc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LC2ExAlZc2OxppReNyEjvuMHe6aZPD84xD0mBnJJmww9Hg979FQAKpgM5iltxzolk
 nNVyK5nHwdO+lH/vHOP82uTOWC2m/SRcnN35XO65ZtuDjiIJTWnNgK7xsIUbBThj4C
 NvO1VDyEDjw9MQaganvXWV8cKCinJU6AcaFw3ipF/7dbsVEuWg6z80VaAU6pRffcqO
 V/pQVwcho9Xv1qbleBEr0+m5Soz/z5V79xv6aQ68xHAcbOhyy0grXRm/C6bh7Kppe3
 BSuuPFb+J+vLXwQfZVHIGGT9nHzBeROUGmdkDYfXB62fJSSK9ObG2lLZbWSc5e9CHZ
 a/h8R58PrCjOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/19] accel: ethosu: Track command stream register
 setup
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-6-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-6-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:00:21 +0000
Message-Id: <20260905010021.BA9AA1F00A3D@smtp.kernel.org>
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
- [High] dma_params_valid() incorrectly returns U64_MAX in a boolean functi=
on, which evaluates to true and bypasses missing DMA parameter validation.
--

commit 6f2462930489d04d8fd80b48b9dfe3672578205e
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Track command stream register setup

The current method of tracking command stream state initializing state
tracking to illegal values and assuming unaccessed registers are 0 is
proving inadequate with additional validation. Instead, track all the
registers in a bitmap as the register address space is fairly small.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 408b93350dd79..8a44a5d89bce6 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -158,13 +185,54 @@ static u64 cmd_to_addr(u32 *cmd)
[ ... ]
> +static bool dma_params_valid(struct ethosu_device *edev, struct cmd_stat=
e *st,
> +			     const struct dma_state *dma_st,
> +			     const struct dma *dma,
> +			     u16 region_cmd, u16 addr_cmd)
> +{
> +	s8 mode =3D dma->mode;
> +
> +	if (!cmd_state_reg_is_set(st, region_cmd) ||
> +	    !cmd_state_reg_is_set(st, addr_cmd) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_DMA0_LEN) || mode < 0 || mode > 2)
> +		return false;
> +
> +	if (mode >=3D 1 &&
> +	    !cmd_state_reg_is_set(st, dma_use_src_stride(edev, dma_st, dma) ?
> +				  NPU_SET_DMA0_SRC_STRIDE0 :
> +				  NPU_SET_DMA0_DST_STRIDE0))
> +		return U64_MAX;

[Severity: High]
Since dma_params_valid() returns a bool, does returning U64_MAX here get
converted to true?

If an attacker intentionally omits the stride command in a malicious stream,
could this evaluate as true and inadvertently bypass the validation check,
potentially leading to out-of-bounds DMA accesses using retained hardware
stride values?

> +	if (mode =3D=3D 2 &&
> +	    !cmd_state_reg_is_set(st, dma_use_src_stride(edev, dma_st, dma) ?
> +				  NPU_SET_DMA0_SRC_STRIDE1 :
> +				  NPU_SET_DMA0_DST_STRIDE1))
> +		return U64_MAX;

[Severity: High]
Does returning U64_MAX here also inadvertently evaluate to true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D6
