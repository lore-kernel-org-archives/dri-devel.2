Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5194C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095C810ED7B;
	Wed,  1 Jul 2026 16:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H6IbxqcG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBCF10ED7B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:11:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 74DF841426;
 Wed,  1 Jul 2026 16:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C601F000E9;
 Wed,  1 Jul 2026 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782922319;
 bh=5rlLFV6yor6MdmYu3pfPwBrHgkQ+Q2afO3cH49A0LOE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H6IbxqcGZl5BNOrvgz9K9ZhjM6RJxan+XjeaA6jBrm3WepggFmpnFr7smGyHgCVW/
 u9Ni3lqoX1UckT4srYFIkNEUU+8P41QQQhyya4Ro18KvPn8wE2VOnkisJ4RuL2DOnF
 HfrxTBynF5YO7YLB77Lt7oWs6YK3QSGcnMvRZcqT0FQuPnkV/Ve9+0fQud+9t95PLC
 IqRoGMj6/MNzbBQwoYzndb8YnN8bgdbHRMuAHKv4ZVCX6Er6+wnIpL8V0Jn3tfMiVK
 sG4y7Tz3pfAzhbqoQqfdqTcm1Mj+vpsJKE8ZDyoT5YQDyBB47s5A5RUGCQTb0VELZR
 QbaWP86ZnivbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Fix use-after-free in debug BO
 command handling
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701155556.663541-1-lizhi.hou@amd.com>
References: <20260701155556.663541-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:11:57 +0000
Message-Id: <20260701161157.E4C601F000E9@smtp.kernel.org>
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
- [High] The `aie2_cmd_wait()` function ignores both the return value of th=
e fence wait and the fence's error status. If a DRM job aborts early (e.g.,=
 due to an error in the scheduler before hardware execution), the response =
handler is skipped and `cmd->result` remains its default zero value. Caller=
s will incorrectly interpret this as a successful hardware execution and pr=
oceed to update internal states, leading to state inconsistencies.
--

commit 77f1579d79492199ed29e6079ac11fa573ee9e04
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix use-after-free in debug BO command handling

This commit fixes a use-after-free in debug BO command handling by
introducing reference counting for drv_cmd objects. It transfers
ownership to the job while it is in flight to ensure the command
remains valid until the completion handler finishes.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index e9fbd8c143641..54486960cbf5e 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
[ ... ]
> @@ -912,32 +926,39 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_h=
wctx *hwctx, u32 bo_hdl,
[ ... ]
> -	ret =3D amdxdna_cmd_submit(client, &cmd, AMDXDNA_INVALID_BO_HANDLE,
> +	ret =3D amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
>  				 &bo_hdl, 1, hwctx->id, &seq);
>  	if (ret) {
>  		XDNA_ERR(xdna, "Submit command failed");
> -		goto put_obj;
> +		goto put_cmd;
>  	}
> =20
>  	aie2_cmd_wait(hwctx, seq);
> -	if (cmd.result) {
> -		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
> +	if (cmd->result) {

[Severity: High]
This is a pre-existing issue, but does trusting cmd->result here correctly
handle early job aborts?

Looking at aie2_cmd_wait(), it calls dma_fence_wait_timeout() but ignores
both the return value (timeouts) and dma_fence_get_error(out_fence).

If a DRM job fails early in the scheduler before hardware execution, the
fence might signal with an error without executing the hardware response
handler. Since cmd->result remains its default zero value, will this cause
aie2_hwctx_cfg_debug_bo() to falsely assume the hardware command succeeded
and incorrectly update abo->assigned_hwctx?

> +		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>  		ret =3D -EINVAL;
> -		goto put_obj;
> +		goto put_cmd;
>  	}
> =20
>  	if (attach)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701155556.6635=
41-1-lizhi.hou@amd.com?part=3D1
