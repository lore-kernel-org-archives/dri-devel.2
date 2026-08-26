Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F2DC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF38310EDA1;
	Wed, 26 Aug 2026 18:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WJB04dht";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA48510EDA1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:59:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B68BA409FA;
 Wed, 26 Aug 2026 18:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794A51F00A3D;
 Wed, 26 Aug 2026 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787770795;
 bh=lx5zp5aqLB/Kk6harZQRtSkCB2nU7PUnJc1HXoMPDKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WJB04dhtjUCaCrbwaDQngVWTAGC4UE2/l2gEV5I1dSZXjTG6Y8B9Kkll5WAWmhE/J
 nvi8scbrwWOeDRweybG2LyryAEiwuZbrtAeRpIjdWVsXadu0acZT9JlZ09GVTja3Tz
 symoYP+OlS2TkEU4LJB2ro4S+dJrq0Z9DuKwF4S9RsJprD0xsxyDTq5CDRPTUSnUTg
 fPAyf/z6YMCE/fJ9QFPMnGqdmSNYyXkCTyYSOHlli3S5gBziQXQ0ov4dT9gyMI5GSN
 WHCIB887YX2UuwMlZhNcsFrdMr0npjYMgmgFShsqjihQ4RdaT56bESz583h0Jska5m
 cdwulo21RcASQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/amdxdna: make the debug BO command wait
 interruptible
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826184503.282106-1-taimuraz@kaitmazov.com>
References: <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
 <20260826184503.282106-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:59:55 +0000
Message-Id: <20260826185955.794A51F00A3D@smtp.kernel.org>
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

New issues:
- [High] Interrupting `aie2_cmd_wait()` during debug BO configuration can l=
eave the BO's assignment state permanently inconsistent between the driver =
and firmware.

Pre-existing issues:
- [High] Failure to obtain the out fence causes the driver to incorrectly a=
ssume successful hardware execution.
- [High] `aie2_cmd_wait` ignores fence errors, leading to silent state corr=
uption if a DRM scheduler job times out or is aborted.
--

commit 05f58ac37b249cd07c7d16bba1c96b7014f1993a
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: make the debug BO command wait interruptible

This commit updates aie2_cmd_wait() to use an interruptible fence wait
and handles interrupted debug BO ATTACH operations by optimistically
marking them as attached.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index baf9a8b90a4d6..d3c80f760a1d3 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -908,20 +908,30 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwct=
x *hwctx, void *buf, u32 size
>  	return ret;
>  }
> =20
> -static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
> +static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>  {
>  	struct dma_fence *out_fence =3D aie2_cmd_get_out_fence(hwctx, seq);
>  	struct amdxdna_dev *xdna =3D hwctx->client->xdna;
> +	long ret;
> =20
>  	if (!out_fence) {
>  		XDNA_ERR(xdna, "Failed to get fence");
> -		return;
> +		return 0;

[Severity: High]
This is a pre-existing issue, but does returning 0 here mask the error from
the caller?

If aie2_cmd_get_out_fence() fails to return a fence, returning 0 signals
success to the caller in aie2_hwctx_cfg_debug_bo(). Because cmd->result
remains 0, the caller will incorrectly assume the hardware executed the
command successfully, potentially corrupting internal driver state.

>  	}
> =20
>  	mutex_unlock(&xdna->dev_lock);
> -	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
> +	ret =3D dma_fence_wait_timeout(out_fence, true, MAX_SCHEDULE_TIMEOUT);
>  	mutex_lock(&xdna->dev_lock);
>  	dma_fence_put(out_fence);
> +
> +	/*
> +	 * The command is still in flight. If the ioctl were restarted it
> +	 * would submit a second one.
> +	 */
> +	if (ret =3D=3D -ERESTARTSYS)
> +		return -EINTR;
> +
> +	return ret < 0 ? ret : 0;

[Severity: High]
This is a pre-existing issue, but does this logic ignore asynchronous fence
errors?

When a DRM scheduler job is aborted (such as during a TDR timeout), it will
signal the job's out-fence with an error code. Since dma_fence_wait_timeout=
()
returns > 0 (time remaining) when the fence signals, returning 0 here witho=
ut
checking dma_fence_get_error(out_fence) hides the failure.=20

The caller will proceed as if the hardware completed the command successful=
ly.

>  }
> =20
>  static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_h=
dl,
> @@ -968,7 +978,17 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hw=
ctx *hwctx, u32 bo_hdl,
>  		goto put_cmd;
>  	}
> =20
> -	aie2_cmd_wait(hwctx, seq);
> +	ret =3D aie2_cmd_wait(hwctx, seq);
> +	if (ret) {
> +		/*
> +		 * The command may still attach the BO. Record it as attached,
> +		 * or DETACH will refuse it and there is no way back.
> +		 */
> +		if (attach)
> +			abo->assigned_hwctx =3D hwctx->id;
> +		goto put_cmd;
> +	}
> +
>  	if (cmd->result) {
>  		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>  		ret =3D -EINVAL;

[Severity: High]
Could this lead to a permanently wedged buffer object?

If aie2_cmd_wait() is interrupted during an ATTACH operation, the driver
optimistically marks the BO as attached by setting abo->assigned_hwctx.
However, if the firmware did not actually process the ATTACH command, a
subsequent DETACH operation will fail in firmware and return a non-zero
cmd->result.

When cmd->result is non-zero during the DETACH, this error handling path
bails out early, skipping the cleanup logic below that would normally reset
abo->assigned_hwctx to AMDXDNA_INVALID_CTX_HANDLE. This leaves the BO state
mismatched between the driver and firmware, locking it permanently.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826184503.2821=
06-1-taimuraz@kaitmazov.com?part=3D1
