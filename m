Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8900606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwBQXcGC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD9F10E095;
	Tue, 17 Nov 2026 21:41:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACCD10E095
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:41:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7CAF611C6;
 Tue, 17 Nov 2026 21:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650381F000C4;
 Tue, 17 Nov 2026 21:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794951682;
 bh=YyOTBYF91PLAEbebJAWaoM6/4jU+c7rEoxGJiFd8g/o=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=WwBQXcGCNuv9sXGcsF7o08Db5/tS3UPG5blZ42yLqzL+LavnHh9ywMfA6djYEnNy8
 8t01Z+Gp9bxFGr0dH8tvNVNuWz2ThtgV66hN2q/b9JeRQsExJIWfbmUCwiSUsCycYS
 ksT6xV5v6tIB52xaZpIugosWin2//EEicX47sRAOq2iqLsM3+rRC8LHGuHijl5PbuN
 3E751p7t9TAQLn4AvOqVQdKbvpoaWNRVoBZfDDxwWqu2oukj78hs4lksxTmehNCzLb
 crD2S95pHnyxapx2AJJdByVRbtjL3XuvnrJiBHIbRNwL3qGiJqqaYoHKN8Uijg16pk
 8+6ur7TlsoqXA==
Message-ID: <sashiko-outbox-219709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 1/2] accel/amdxdna: Detect a driver command without
 firmware response
To: "Lizhi Hou" <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117212733.172074-1-lizhi.hou@amd.com>
References: <20261117212733.172074-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 21:41:21 +0000
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
- [Medium] accel/amdxdna: premature return in aie2_cmd_wait() when
  syncobj is reset
--

commit f05d19edddd799b35af693f49ef6b95d8743aad9
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Detect a driver command without firmware response

This commit initializes cmd->result to U32_MAX before submitting debug BO
driver commands so that commands which never receive a firmware response are
reported as failures.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 74d7019268cb6..7525fefa6f1ef 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -985,10 +985,14 @@ static void aie2_cmd_wait(struct amdxdna_hwctx *hwc=
tx, u64 seq)
>  	struct dma_fence *out_fence =3D aie2_cmd_get_out_fence(hwctx, seq);
>  	struct amdxdna_dev *xdna =3D hwctx->client->xdna;
> =20
> -	if (!out_fence) {
> -		XDNA_ERR(xdna, "Failed to get fence");
> +	/*
> +	 * No fence to wait for. Either seq has already signaled and a later
> +	 * point pruned it out of the timeline chain, or the syncobj was
> +	 * reset. Neither means the command failed, so leave the verdict to
> +	 * the caller, which inspects cmd->result.
> +	 */
> +	if (!out_fence)
>  		return;
> -	}
> =20
>  	mutex_unlock(&xdna->dev_lock);
>  	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
> @@ -1018,6 +1022,7 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_h=
wctx *hwctx, u32 bo_hdl,
>  		goto put_obj;
>  	}
>  	kref_init(&cmd->refcnt);
> +	cmd->result =3D U32_MAX;

[Severity: Medium]
Can aie2_hwctx_cfg_debug_bo() and aie2_hwctx_sync_debug_bo() observe
cmd->result =3D=3D U32_MAX while the job is still running if the syncobj was
reset?

aie2_ctx_syncobj_create() exports hwctx->priv->syncobj to userspace as
hwctx->syncobj_hdl.  If userspace resets that syncobj while a debug BO
command is in flight, aie2_cmd_get_out_fence() returns NULL and
aie2_cmd_wait() returns immediately without waiting for the job to
finish:

CPU0                              CPU1
aie2_hwctx_cfg_debug_bo()
  cmd->result =3D U32_MAX
  amdxdna_cmd_submit()
                                  DRM_IOCTL_SYNCOBJ_RESET
                                    drm_syncobj_replace_fence(..., NULL)
  aie2_cmd_wait()
    out_fence =3D NULL
    return
  if (cmd->result)                <-- sees U32_MAX, returns -EINVAL
                                  aie2_sched_drvcmd_resp_handler()
                                    job->drv_cmd->result =3D 0

Unlike the pruned timeline point case where seq has already signaled,
resetting the syncobj drops the fence before the firmware responds.
aie2_hwctx_cfg_debug_bo() then sees cmd->result =3D=3D U32_MAX and skips
updating abo->assigned_hwctx even though firmware still executes the
attach or detach command, leaving abo->assigned_hwctx out of sync with
firmware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117212733.1720=
74-1-lizhi.hou@amd.com?part=3D1
