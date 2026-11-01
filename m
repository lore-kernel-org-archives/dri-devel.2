Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83D606A33E
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQfT8lS3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFE410E4D2;
	Sun,  1 Nov 2026 22:39:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F0E10E4D2
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:39:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2332439DC;
 Sun,  1 Nov 2026 22:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E941F00919;
 Sun,  1 Nov 2026 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793572774;
 bh=jpeXJjx2vkem/6RcCfIyJEEp/queVwYv/M7mYaopZ/o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mQfT8lS3AbbnONr0Ay8xCT3RWNvSB+/vZbyeBZu82it6Yi1Z0oYyZ+1SMX5gmbbAB
 BzjhZF9XvXQ59q2SePNbaYN/zHq5K4n5dhqiqT3wCwpVZ9gOdgHAzawUqnNS/iBHHp
 JlFw9mc5gdkMloUot63rNgkt9j2HGZwc7TL+MIslX8knbNofWj1DSuAXCtp/8xeZ6o
 U1a9GqP622WxwuH9jDc5Xsrwjw7PGsPeAJHFuFnnftG6gXXuvNYwNazAFapx5aUsKt
 9tTZ7zIrPy+I9lPm+PzLH3ayvzKir42zKuTHVsCnX7uvyIDzMfR4leZNZ9+qrjTqHu
 mQ1cmXVLJNPCg==
Message-ID: <sashiko-outbox-192721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/25] accel/qda: Add RPMsg send and response dispatch
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-11-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-11-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:39:34 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] accel/qda: use-after-free in qda_rpmsg_cb() due to unlocked xa_loa=
d()
- [High] accel/qda: duplicate response refcount underflow in qda_rpmsg_cb()
- [High] accel/qda: unflushed put_work and in-flight contexts in qda_rpmsg_=
remove()
- [High] accel/qda: missing PD exit sentinel filtering in qda_rpmsg_cb()
--

commit 66df96a5b81c60ce1864c2d544af7d04014ec8e1
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add RPMsg send and response dispatch

This commit adds RPMsg message transmission and response callback handling
for FastRPC invocations, along with the wire message definitions and workqu=
eue
reference cleanup.

> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> index 14034e250555d..43b56ab3f0128 100644
> --- a/drivers/accel/qda/qda_rpmsg.c
> +++ b/drivers/accel/qda/qda_rpmsg.c
[ ... ]
> +static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
> +			void *priv, u32 src)
> +{
> +	struct qda_dev *qdev =3D dev_get_drvdata(&rpdev->dev);
> +	struct qda_invoke_rsp *resp_msg =3D data;
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	int ret =3D 0, idx;
> +
> +	if (!qdev)
> +		return -ENODEV;
> +
> +	if (!drm_dev_enter(&qdev->drm_dev, &idx))
> +		return -ENODEV;
> +
> +	if (len < sizeof(*resp_msg)) {
> +		ret =3D -EINVAL;
> +		goto out_exit;
> +	}
> +
> +	ctx =3D xa_load(&qdev->ctx_xa, FIELD_GET(QDA_FASTRPC_CTXID_MASK, resp_m=
sg->ctx));
> +	if (!ctx) {
> +		drm_dbg_driver(&qdev->drm_dev, "No context matches response 0x%llx\n",
> +			       resp_msg->ctx);
> +		ret =3D -ENOENT;
> +		goto out_exit;
> +	}

[Severity: High]
When a protection domain exits on the DSP, the firmware sends a PD exit
notification carrying the sentinel value 0xABCDABCD in resp_msg->ctx (which
drivers/misc/fastrpc.c filters out via FASTRPC_DSP_PD_NOTIFY_CTX in
fastrpc_rpmsg_callback()).

Under the QDA context ID layout, FIELD_GET(QDA_FASTRPC_CTXID_MASK, 0xABCDAB=
CD)
evaluates to 0xCD (205) and FIELD_GET(QDA_FASTRPC_CTXID_SEQ_MASK, 0xABCDABC=
D)
evaluates to 0xABCD. If a PD exit notification arrives while context slot 0=
xCD
is occupied by an invocation at sequence number 0xABCD, won't qda_rpmsg_cb()
mistakenly match it, overwrite ctx->retval, wake the caller early via
complete(&ctx->work) while the DSP is still accessing its DMA buffers, and
schedule ctx->put_work?

Additionally, when slot 0xCD is empty, returning -ENOENT here instead of 0
causes SMD-backed RPMsg channels (qcom_smd_channel_recv_single() in
drivers/rpmsg/qcom_smd.c) to stop advancing the RX FIFO tail. Should
qda_rpmsg_cb() filter out 0xABCDABCD early and return 0 when dropping
unmatched responses?

> +
> +	/*
> +	 * Context IDs are only 8 bits wide and are recycled once a context is
> +	 * freed, so a late or duplicate response may name an ID that now belon=
gs
> +	 * to a newer context. The sequence number tells the two apart.
> +	 */
> +	if (FIELD_GET(QDA_FASTRPC_CTXID_SEQ_MASK, resp_msg->ctx) !=3D
> +	    FIELD_GET(QDA_FASTRPC_CTXID_SEQ_MASK, ctx->ctxid)) {
> +		drm_dbg_driver(&qdev->drm_dev, "Dropping stale response 0x%llx\n",
> +			       resp_msg->ctx);
> +		goto out_exit;
> +	}

[Severity: High]
Can this unlocked xa_load() race with context teardown and cause a
use-after-free in qda_rpmsg_cb()?

When the final reference on ctx drops to zero on another CPU (for example,
when qda_rpmsg_send_msg() fails and drops the callback reference followed by
the caller dropping its reference, or when an invocation finishes),
qda_fastrpc_context_free() removes ctx from qdev->ctx_xa and immediately fr=
ees
it without an RCU grace period:

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_context_free() {
	struct qda_fastrpc_invoke_ctx *ctx =3D
		container_of(ref, struct qda_fastrpc_invoke_ctx, refcount);

	xa_erase(&ctx->qdev->ctx_xa, FIELD_GET(QDA_FASTRPC_CTXID_MASK, ctx->ctxid)=
);
	kfree(ctx);
}

Because xa_load(&qdev->ctx_xa, ...) only holds rcu_read_lock() internally
during the lookup and returns the raw ctx pointer without holding
qdev->ctx_xa.xa_lock or pinning ctx->refcount via kref_get_unless_zero(), if
a late or duplicate response arrives in qda_rpmsg_cb() just before xa_erase=
()
and kfree(ctx), qda_rpmsg_cb() will dereference freed memory at ctx->ctxid,
write ctx->retval, and call complete(&ctx->work) and
schedule_work(&ctx->put_work) on the freed object.

Similarly, in qda_fastrpc_context_alloc(), xa_alloc() publishes ctx into
qdev->ctx_xa before ctx->ctxid is initialized:

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_context_alloc() {
	...
	ret =3D xa_alloc(&qdev->ctx_xa, &id, ctx, XA_LIMIT(1, QDA_FASTRPC_CTXID_MA=
X),
		       GFP_KERNEL);
	if (ret) {
		kfree(ctx);
		return ERR_PTR(ret);
	}

	ctx->ctxid =3D FIELD_PREP(QDA_FASTRPC_CTXID_MASK, id) |
		     FIELD_PREP(QDA_FASTRPC_CTXID_SEQ_MASK,
				(u64)atomic64_inc_return(&qdev->ctx_seq));
}

which briefly exposes ctx with ctx->ctxid =3D=3D 0 to concurrent lookups in
qda_rpmsg_cb().

> +
> +	ctx->retval =3D resp_msg->retval;
> +	complete(&ctx->work);
> +
> +	/*
> +	 * Release the reference taken by qda_rpmsg_send_msg(). This callback
> +	 * runs in atomic context, and if it drops the last reference the
> +	 * context's DMA buffers are freed, which must not happen here.
> +	 */
> +	schedule_work(&ctx->put_work);

[Severity: High]
What prevents a duplicate or unsolicited DSP response from scheduling
ctx->put_work without a corresponding callback reference and underflowing
ctx->refcount?

In qda_fastrpc_context_alloc(), ctx is inserted into qdev->ctx_xa with
refcount =3D 1 (owned by the caller), and qda_rpmsg_send_msg() takes a sing=
le
additional reference via kref_get(&ctx->refcount) for the response handler.
When a valid response arrives in qda_rpmsg_cb(), ctx is neither removed from
qdev->ctx_xa nor atomically marked as already answered; it stays in
qdev->ctx_xa until qda_fastrpc_context_free() runs at refcount =3D=3D 0.

Once the first put_work begins executing in qda_fastrpc_context_put_wq() and
drops refcount from 2 to 1 while the caller still holds its reference, a
duplicate response from the DSP carrying the same ctx value (matching both =
the
8-bit ID and the sequence number) will match ctx in qda_rpmsg_cb() a second
time and call schedule_work(&ctx->put_work) again. That second execution of
qda_fastrpc_context_put_wq() drops the caller's reference, freeing ctx while
the caller is still using it and triggering a refcount underflow when the
caller drops its own reference.

Likewise, because ctx is in qdev->ctx_xa before qda_rpmsg_send_msg() is cal=
led
(and remains in qdev->ctx_xa after rpmsg_send() fails and drops the callback
reference), an unsolicited response matching ctx->ctxid before send or afte=
r a
failed send will also schedule ctx->put_work without a matching callback
reference.

> +
> +out_exit:
> +	drm_dev_exit(idx);
> +
> +	return ret;
> +}
> +
>  static void qda_rpmsg_remove(struct rpmsg_device *rpdev)

[Severity: High]
If the RPMsg device is removed while ctx->put_work is queued or while
invocations are in flight, can qda_fastrpc_context_put_wq() access
qdev->ctx_xa after qda_deinit_device() has destroyed it?

In qda_rpmsg_cb(), schedule_work(&ctx->put_work) queues
qda_fastrpc_context_put_wq() on system_percpu_wq and immediately exits the
drm_dev_enter() critical section via drm_dev_exit(idx). When
qda_rpmsg_remove() runs:

drivers/accel/qda/qda_rpmsg.c:qda_rpmsg_remove() {
	...
	drm_dev_unplug(&qdev->drm_dev);
	qdev->rpdev =3D NULL;
	qda_cb_unpopulate(qdev);
	qda_deinit_device(qdev);
}

drm_dev_unplug() only waits for active drm_dev_enter() sections; it does not
flush or wait for pending ctx->put_work items before qda_deinit_device(qdev)
destroys qdev->ctx_xa via xa_destroy(&qdev->ctx_xa) (and if all DRM files a=
re
closed, devm frees qdev when qda_rpmsg_remove() returns). When the queued
qda_fastrpc_context_put_wq() worker subsequently runs,
qda_fastrpc_context_free() calls xa_erase(&ctx->qdev->ctx_xa, ...) on the
destroyed XArray and freed qdev.

In addition, if the RPMsg device is removed in this commit while invocations
sent via qda_rpmsg_send_msg() are waiting for a response, qda_rpmsg_remove()
does not complete ctx->work to wake waiters in qda_rpmsg_wait_for_rsp() or
drop the callback references on entries remaining in qdev->ctx_xa before
xa_destroy(). Although a later commit in the series, commit 9e89a77ec2ad
("accel/qda: Add the invocation ioctl and teardown on unplug"), adds
qda_fastrpc_flush_pending(qdev) to qda_rpmsg_remove() to wake and put
remaining entries in ctx_xa, it still does not flush pending ctx->put_work
items that were already scheduled by qda_rpmsg_cb().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D11
