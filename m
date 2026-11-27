Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1076606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3bpTeYi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287531129E9;
	Fri, 27 Nov 2026 10:23:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1E31129D9
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:23:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E64B944982;
 Fri, 27 Nov 2026 10:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40741F000C1;
 Fri, 27 Nov 2026 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774998;
 bh=5b0qHFu/l5lUTg5Be3b3eZeW9st71mF0W6jq6bcNG74=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i3bpTeYiMuZNABOI+M8/yU6ef6+Zt0X85EWZ+VcYQZyrKBfZOmSLa1iimT1I4cuDg
 ASKaVFy1m34rT1pFctIDDJhl8se/1g4cfSJ1IGOex2rwsA3/7B8+dHbHlCMKWDAgtH
 b5CvFLDRPljg6HKvbT16/f5jGOkV4iKlMHOyGZoi6DFoL2WUVyDkoMqCX0dUd/tVtv
 PoI+IrlfUoQE1DMoeMNlcYwvaNVLGlT9MdvRHQGl4BkFyl6/3WfeiM4P/tzia2qohE
 f8VdXdDtMELzGbK7lP8wpGz/dEN10d0AntMb9hUUcNrzNilekt4WA16ChQxTfJwsls
 zJQuH0OA1SFfQ==
Message-ID: <sashiko-outbox-237113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] misc: fastrpc: query the dsp capabilities during
 probe time
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-master-v1-1-f998ec22497b@oss.qualcomm.com>
References: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
 <20261127-master-v1-1-f998ec22497b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:23:17 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] misc: fastrpc: race between fastrpc_cap_query_work() and
  fastrpc_rpmsg_remove()
- [Medium] misc: fastrpc: double misc_deregister() after
  fastrpc_register_devices() error
--

commit 502b28e3abb8ed99c00c841e2045fedc442784d7
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: query the dsp capabilities during probe time

This commit moves FastRPC device node registration out of
fastrpc_rpmsg_probe() into a per-channel workqueue that first queries
and caches the DSP capabilities before registering the device nodes.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5375847d8c9a2..48ded6080ddd6 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2585,6 +2617,195 @@ static int fastrpc_device_register(struct device =
*dev, struct fastrpc_channel_ct
>  	return err;
>  }
> =20
> +static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
> +				    struct rpmsg_device *rpdev)
> +{
> +	struct device *rdev =3D &rpdev->dev;
> +	int err, i;

[ ... ]

> +	case CDSP_DOMAIN_ID:
> +	case GDSP_DOMAIN_ID:
> +		cctx->unsigned_support =3D true;
> +		/* Create both device nodes so that we can allow both Signed and Unsig=
ned PD */
> +		err =3D fastrpc_device_register(rdev, cctx, true, cctx->domain);
> +		if (err)
> +			goto err_deregister_fdev;
> +
> +		err =3D fastrpc_device_register(rdev, cctx, false, cctx->domain);
> +		if (err)
> +			goto err_deregister_fdev;
> +		break;
> +	default:
> +		err =3D -EINVAL;
> +		goto err_deregister_fdev;
> +	}
> +
> +	return 0;
> +
> +err_deregister_fdev:
> +	if (cctx->fdevice)
> +		misc_deregister(&cctx->fdevice->miscdev);
> +	if (cctx->secure_fdevice)
> +		misc_deregister(&cctx->secure_fdevice->miscdev);
> +
> +	return err;
> +}

[Severity: Medium]
Can this cause a double misc_deregister() in fastrpc_rpmsg_remove() if the
second fastrpc_device_register() call fails?

Previously, a registration failure aborted fastrpc_rpmsg_probe(), so
fastrpc_rpmsg_remove() never ran.  Now probe returns 0 before
fastrpc_register_devices() runs, and fastrpc_cap_query_work() only logs the
error.  Because err_deregister_fdev does not clear cctx->secure_fdevice or
cctx->fdevice after deregistering them, fastrpc_rpmsg_remove() will call
misc_deregister() on cctx->secure_fdevice->miscdev a second time after its
dynamic minor was already freed and reset to MISC_DYNAMIC_MINOR.

Also, at the register_devices label in fastrpc_cap_query_work(),
fastrpc_register_devices() runs using the initial rpdev snapshot without
re-checking whether fastrpc_rpmsg_remove() has already cleared cctx->rpdev.

> +
> +static void fastrpc_cap_query_work(struct work_struct *work)
> +{
> +	struct fastrpc_channel_ctx *cctx =3D
> +		container_of(work, struct fastrpc_channel_ctx, cap_query_work);
> +	struct rpmsg_device *rpdev;
> +	struct device *rdev;
> +	u32 *dsp_attributes;
> +	struct fastrpc_user *fl;
> +	unsigned long flags;
> +	int err;

[ ... ]

> +	/*
> +	 * Linked into cctx->users so fastrpc_rpmsg_remove() can abort us
> +	 * via fastrpc_notify_users() instead of waiting out the timeout.
> +	 */
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	if (!cctx->rpdev) {
> +		spin_unlock_irqrestore(&cctx->lock, flags);
> +		kfree(dsp_attributes);
> +		fastrpc_session_free(cctx, fl->sctx);
> +		fl->sctx =3D NULL;
> +		fastrpc_user_put(fl);
> +		return;
> +	}
> +	list_add_tail(&fl->user, &cctx->users);
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +	err =3D fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_A=
TTRIBUTES);

[Severity: High]
Can fastrpc_rpmsg_remove() clear cctx->rpdev and finish its
fastrpc_notify_users() pass after cctx->lock is dropped here, but before
fastrpc_get_info_from_dsp() sends the message?

kworker                           CPU0
fastrpc_cap_query_work()
  spin_lock_irqsave(&cctx->lock)
  list_add_tail(&fl->user, ...)
  spin_unlock_irqrestore(&cctx->lock)
  fastrpc_get_info_from_dsp()
    fastrpc_internal_invoke()
      if (!fl->cctx->rpdev)
                                  fastrpc_rpmsg_remove()
                                    spin_lock_irqsave(&cctx->lock)
                                    cctx->rpdev =3D NULL
                                    fastrpc_notify_users(fl)
                                      /* fl->pending is still empty */
                                    spin_unlock_irqrestore(&cctx->lock)
                                    cancel_work_sync(&cctx->cap_query_work)
      fastrpc_context_alloc()
      ...
      fastrpc_invoke_send()
        rpmsg_send(cctx->rpdev->ept, ...)
          <-- NULL pointer dereference

If fastrpc_rpmsg_remove() runs after fastrpc_context_alloc() adds ctx to
fl->pending (while fastrpc_get_args() sleeps in dma_alloc_coherent()) and
before fastrpc_invoke_send() takes the worker reference with
fastrpc_context_get(ctx), fastrpc_notify_users() also schedules
ctx->put_work on a context with a refcount of 1, freeing ctx while
fastrpc_internal_invoke() is still using it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-master-v1-=
0-f998ec22497b@oss.qualcomm.com?part=3D1
