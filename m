Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15AC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C40510F1C8;
	Thu, 27 Aug 2026 20:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NfSn9eK4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BBB10F1C8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AEF240573
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87711F00A3A;
 Thu, 27 Aug 2026 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863735;
 bh=Kh8dFszBAmUlMJD0LxWOCpXXnr+O8co35WA0sHjOflk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NfSn9eK4ExL6HNRjpJ7UrbTTC86gnfmlzLfvR7Uvkz2VwaTbpADNm+MdidobGxL4n
 VbLEwx1K9qUH6KVV9rEnxJxDC+h9I1hB3bAjKJqgm0u7LhRxLr7X4yZGQUTvbV1ESn
 DA6fMroCjPoDr7QWI6yYcmAJiNM5qSLrbrxRRVNJZdy5M3xxFL5XNr2d/gCj4cNnMp
 ZWfBkhxCJ52cd6uapvdpkrc2+harfUObQxY8vAeiySfM8KOciNOjPahKVtR7AsOfWZ
 +mqcvLMf0s17q1HieNT6Pgg8iXNGVPnzYuUeFnI44+IvUMZjzeMfJp8ZvRh3suUO5O
 B7yTF08/Ao9lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] accel: ethosu: Reject unsupported commands
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-9-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-9-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:48:55 +0000
Message-Id: <20260827204855.B87711F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The hardware's state registers and BASEP (base pointer) regist=
ers are not reset between jobs, allowing an attacker to omit configuration =
commands and hijack memory regions from previously executed jobs.
- [Critical] The `dma_length()` function incorrectly calculates memory boun=
ds for negative DMA strides, drastically underestimating the maximum addres=
s and failing to check for buffer underflows.
- [Medium] The command-stream validator employs a default-allow policy for =
unknown commands, passing unrecognized NPU commands directly to the hardwar=
e without any safety checks.
--

commit 3012502d7ce6f9c86b531a92e4564ed74d340366
Author: Rob Herring (Arm) <robh@kernel.org>
accel: ethosu: Reject unsupported commands

This commit updates the command-stream validator to reject unsupported comm=
ands
like branches, IRQs, and certain DMA configurations. It prevents commands t=
hat
bypass validation state or access unchecked index buffers.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 3d1f4121db4f4..2aafbfe95a8c2 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -450,6 +450,9 @@ static int ethosu_gem_cmdstream_copy_and_validate(str=
uct drm_device *ddev,
>  		}
> =20
>  		switch (cmd) {
> +		case NPU_OP_BRANCH:
> +		case NPU_OP_IRQ:
> +			return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but is the validator using a default-allow
policy for unknown commands?

If a user submits a command stream containing unrecognized opcodes (such as
undocumented commands or those from a minor hardware revision), the validat=
or
hits the default case:

drivers/accel/ethosu/ethosu_gem.c:ethosu_gem_cmdstream_copy_and_validate() {
		...
		switch (cmd) {
		...
		default:
			break;
		}
		...
}

This ignores the command without calculating memory bounds for it, allowing=
 it
to be copied to the execution buffer. The hardware could then execute it,
potentially accessing physical memory outside the validated GEM bounds. Sho=
uld
the validator fail closed by returning -EINVAL for unrecognized commands?

[ ... ]
> @@ -673,13 +684,19 @@ static int ethosu_gem_cmdstream_copy_and_validate(s=
truct drm_device *ddev,
>  			break;
> =20
>  		case NPU_SET_DMA0_SRC_REGION:

[Severity: Critical]
This isn't a bug introduced by this patch, but what happens if an attacker
intentionally omits these configuration commands?

If a command stream contains NPU_OP_DMA_START but omits
NPU_SET_DMA0_SRC_REGION and NPU_SET_DMA0_DST_REGION, the regions default to
-1 because cmd_state_init() initializes the state with 0xff:

drivers/accel/ethosu/ethosu_gem.c:cmd_state_init() {
	memset(st, 0xff, sizeof(*st));
}

In dma_length(), the upper bound update is bypassed because of the region c=
heck:

drivers/accel/ethosu/ethosu_gem.c:dma_length() {
	if (dma->region >=3D 0) {
		...
		info->region_size[dma->region] =3D max(...);
	}
}

Because region_size remains 0, the job can be submitted without a valid
region_bo_handle. When ethosu_job_hw_submit() runs, it only programs NPU_RE=
G_BASEP
for explicitly provided regions:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_hw_submit() {
	...
	writel_relaxed(lower_32_bits(bo->dma_addr), dev->regs + NPU_REG_BASEP(regi=
on));
	...
}

This leaves other BASEP registers retaining physical addresses from the pre=
viously
executed job. The NPU hardware retains internal state across jobs, so it co=
uld
use the un-overridden regions from the previous job, leading to cross-proce=
ss
memory leaks or physical memory corruption.

[Severity: Critical]
This is also a pre-existing issue, but how are negative DMA strides handled
during length calculation?

drivers/accel/ethosu/ethosu_gem.c:dma_length() {
	...
	len +=3D dma->stride[0];
	if (check_mul_overflow(len, (u64)dma_st->size0, &len))
		return U64_MAX;
	...
}

If a negative stride is provided (e.g., stride[0] =3D -len and offset =3D 0=
), the
logic incorrectly subtracts it before multiplication. This results in len =
=3D 0,
making the maximum address calculation 0 and bypassing the upper bound chec=
k.

Since the hardware DMA engine iterates backwards, it would access physical =
memory
below BASEP. The validator never calculates the minimum address accessed nor
checks for this lower bound underflow, which can allow out-of-bounds physic=
al
memory access.

> +			if (param & NPU_DMA_REGION_INDEX_MODE)
> +				return -EINVAL;
>  			if (param & 0x100)
>  				st.dma.src.region =3D -1;
>  			else
>  				st.dma.src.region =3D param & 0x7;
>  			st.dma.mode =3D (param >> 9) & 0x3;
> +			if (st.dma.mode =3D=3D 3)
> +				return -EINVAL;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D9
