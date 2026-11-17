Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7B606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WD//XV+U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6595010F8F1;
	Tue, 17 Nov 2026 19:44:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F0310F8F3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:44:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F340B43A51;
 Tue, 17 Nov 2026 19:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA1A1F000C5;
 Tue, 17 Nov 2026 19:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944643;
 bh=BjdbSdOn+OiXif0qvNOpfXX+bqn/Yz1IYg4KX8UV2J4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=WD//XV+UOmq5pCu3fa295HCqshVIVRVNRdXCHpg5N0pz7ZWn8fzAGgBI3Bnyj46F6
 OBAcmied0QnyP46jMdRbQXI3W1nYJPWHLf8E1i+JuBlxzdMPILJNcS5drlX0Ora02P
 UIvpQuWulXaendYnyGGmhVXird7x6ATG+lYeTddTUzJdMndGRh84+r2dxgAfYC30Dt
 xO50xCVJt01Dd9AeVFSD24NBLYQUPsnHVoGFwJ51w/Y4UZsSLBqGGT8BU9Or/5ofDK
 lkLaku5owqomEWiVleS2B311+svfrMjE+w5E479JM/i9ZXxt5pEZkYK+33ccNGZjG9
 eb4eekoa7+bpw==
Message-ID: <sashiko-outbox-219517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 1/2] accel/amdxdna: Check the fence error after
 waiting for a driver command
To: "Lizhi Hou" <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117192157.154516-1-lizhi.hou@amd.com>
References: <20261117192157.154516-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:44:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] accel/amdxdna: false -EINVAL in aie2_cmd_wait() when fence is
  garbage-collected
--

commit c14f81e589ab4e7ef12c7146189062d34baca05a
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Check the fence error after waiting for a driver command

This commit returns the out_fence error from aie2_cmd_wait() and checks
that return value in aie2_hwctx_cfg_debug_bo() and
aie2_hwctx_sync_debug_bo() so driver commands that fail before reaching
firmware are not treated as successful.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 74d7019268cb6..87bd6117e943f 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -980,20 +980,30 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwct=
x *hwctx, void *buf, u32 size
>  	return ret;
>  }
> =20
> -static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
> +static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>  {
>  	struct dma_fence *out_fence =3D aie2_cmd_get_out_fence(hwctx, seq);
>  	struct amdxdna_dev *xdna =3D hwctx->client->xdna;
> +	int ret;
> =20
>  	if (!out_fence) {
>  		XDNA_ERR(xdna, "Failed to get fence");
> -		return;
> +		return -EINVAL;
>  	}

[Severity: Medium]
Can aie2_cmd_wait() return -EINVAL for a command that already succeeded if
a concurrent submission on the same hwctx advances hwctx->priv->syncobj
before aie2_cmd_get_out_fence() runs?

drivers/accel/amdxdna/aie2_ctx.c:aie2_cmd_get_out_fence() {
    ...
	ret =3D dma_fence_chain_find_seqno(&fence,  seq);
	if (ret)
		goto out;

	out_fence =3D dma_fence_get(dma_fence_chain_contained(fence));
    ...
}

aie2_cmd_submit() drops hwctx->priv->io_lock after adding the timeline
point to hwctx->priv->syncobj, and regular command submissions via
amdxdna_drm_submit_cmd_ioctl() do not hold xdna->dev_lock:

CPU0                                  CPU1
aie2_hwctx_cfg_debug_bo()
  amdxdna_cmd_submit(..., &seq)
    ...
    drm_syncobj_add_point(..., seq)
    mutex_unlock(&hwctx->priv->io_lock)
  <job at seq finishes and signals>
                                      amdxdna_drm_submit_cmd_ioctl()
                                        ...
                                        drm_syncobj_add_point(..., seq + 1)
  aie2_cmd_wait(hwctx, seq)
    aie2_cmd_get_out_fence(hwctx, seq)
      dma_fence_chain_find_seqno(&fence, seq)
        dma_fence_chain_walk()
          /* seq is signaled: sets fence =3D NULL, returns 0 */
    if (!out_fence)
      return -EINVAL;  <-- false failure

When aie2_hwctx_cfg_debug_bo() hits this race, it jumps to put_cmd without
updating abo->assigned_hwctx even though firmware already executed
ATTACH_DEBUG_BO or DETACH_DEBUG_BO, leaving abo->assigned_hwctx out of
sync with firmware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117192157.1545=
16-1-lizhi.hou@amd.com?part=3D1
