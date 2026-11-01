Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2157606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9ZLvmV+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D0410EACC;
	Sun,  1 Nov 2026 22:44:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFAA210EACC
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:44:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92940407CA;
 Sun,  1 Nov 2026 22:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA981F000C1;
 Sun,  1 Nov 2026 22:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573071;
 bh=ebsX1ApCPrdY8qGeVlmogoAQGSvNKhcmzdCYF/KpWDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X9ZLvmV+vdrDwHylwCw4JOPRurLG8W7vh/EJOzzMPvpBGzPuhys9zXl67FmTQU33g
 t2i6/DYmdhU/+x8h/B27msPF2LQDYvLDzvePayRp24hZeedtQA5v9veFcZsxsML2nn
 aNjzv2GtlaoPB6o7zoh6PUI8ORAFZemJ5rePcx18pkcIAANrEeUOm63Bm8h03YkQEE
 m4knqNGQE2Koyn8Z5qD1hW8m4owhnS5eC0WDNSM7S6lIXuPJmlQwcjz+cEC6yfpbS8
 mTqKlMaSQZ6qdfHGlWyEfu2IQYgKLCka15w/lmdUQFuIAUW3Ccjq4pgZMkZhS/OcXe
 6OGODCL6pyhwg==
Message-ID: <sashiko-outbox-192731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/25] accel/qda: Add FastRPC invocation contexts
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-10-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-10-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:44:30 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/qda: premature publication of ctx in qda_fastrpc_context_all=
oc()
- [High] accel/qda: premature ctx_xa destruction in qda_deinit_device()
--

commit 0b392f877740b474d80d7f4392edfd3f880836d4
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add FastRPC invocation contexts

This commit adds FastRPC invocation context allocation and reference-counted
cleanup, tracking in-flight invocations per device in an XArray with an 8-b=
it
context ID and a 48-bit sequence number.

> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 21113deceaadb..bdfb23c3c0b1d 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -100,6 +100,8 @@ struct qda_dev *qda_alloc_device(struct device *dev)
> =20
>  	INIT_LIST_HEAD(&qdev->cb_devs);
>  	mutex_init(&qdev->import_lock);
> +	xa_init_flags(&qdev->ctx_xa, XA_FLAGS_ALLOC1);
> +	atomic64_set(&qdev->ctx_seq, 0);
> =20
>  	return qdev;
>  }
> @@ -122,6 +124,7 @@ int qda_init_device(struct qda_dev *qdev, int num_cbs)
>  void qda_deinit_device(struct qda_dev *qdev)
>  {
>  	qda_memory_manager_exit(qdev->iommu_mgr);
> +	xa_destroy(&qdev->ctx_xa);
>  	mutex_destroy(&qdev->import_lock);
>  }

[Severity: High]
Can calling xa_destroy(&qdev->ctx_xa) in qda_deinit_device() in
drivers/accel/qda/qda_drv.c race with outstanding invocation contexts that
have not yet dropped their final reference?

In qda_fastrpc_context_alloc() in drivers/accel/qda/qda_fastrpc.c, each
struct qda_fastrpc_invoke_ctx is inserted into qdev->ctx_xa with an initial
caller reference (refcount =3D 1) and stores a raw pointer ctx->qdev =3D qd=
ev
without holding a reference on qdev->drm_dev. By design, the entry is only
erased from qdev->ctx_xa in qda_fastrpc_context_free() when the last
reference is released.

When invocations are wired up in the subsequent commits ("accel/qda: Add
RPMsg send and response dispatch" and "accel/qda: Add the invocation ioctl
and teardown on unplug"), qda_rpmsg_send_msg() takes a second reference for
the response path and the caller sleeps in qda_rpmsg_wait_for_rsp() outside
any drm_dev_enter() critical section.

If the rpmsg device is removed while callers are waiting (for example, on a
DSP crash or remoteproc restart), qda_rpmsg_remove() runs drm_dev_unplug(),
qda_fastrpc_flush_pending(qdev), and then immediately qda_deinit_device(qde=
v).
Because qda_fastrpc_flush_pending() only wakes the waiters and drops the
response reference, the callers still hold their reference (and if
qda_rpmsg_cb() already ran and queued ctx->put_work, ctx is still in
qdev->ctx_xa while put_work is pending, causing qda_fastrpc_flush_pending()
to drop a reference that put_work will also drop).

When qda_deinit_device() immediately calls xa_destroy(&qdev->ctx_xa), the
internal XArray nodes are freed while live contexts remain in the table. Wh=
en
those woken callers or pending put_work items later run
kref_put(&ctx->refcount, qda_fastrpc_context_free), won't
qda_fastrpc_context_free() call xa_erase(&ctx->qdev->ctx_xa, ...) on an
already-destroyed XArray and dereference ctx->qdev after device teardown?

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> new file mode 100644
> index 0000000000000..14d9da8c20b3f
> --- /dev/null
> +++ b/drivers/accel/qda/qda_fastrpc.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/bitfield.h>
> +#include <linux/slab.h>
> +#include "qda_drv.h"
> +#include "qda_fastrpc.h"
> +
> +/**
> + * qda_fastrpc_context_free() - Release an invocation
> + * @ref: Reference counter embedded in the invocation
> + *
> + * Runs when the last reference goes. The invocation leaves the lookup t=
able
> + * here and not earlier, so that its ID cannot be handed to a new invoca=
tion
> + * while this one can still be found and completed.
> + */
> +void qda_fastrpc_context_free(struct kref *ref)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx =3D
> +		container_of(ref, struct qda_fastrpc_invoke_ctx, refcount);
> +
> +	xa_erase(&ctx->qdev->ctx_xa, FIELD_GET(QDA_FASTRPC_CTXID_MASK, ctx->ctx=
id));
> +	kfree(ctx);
> +}
> +
> +/**
> + * qda_fastrpc_context_alloc() - Allocate an invocation and give it an ID
> + * @qdev: Device the invocation is issued on
> + *
> + * The caller holds the initial reference and drops it with
> + * qda_fastrpc_context_free().
> + *
> + * Return: The new invocation, or ERR_PTR on failure
> + */
> +struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev =
*qdev)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	u32 id;
> +	int ret;
> +
> +	ctx =3D kzalloc_obj(*ctx);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init_completion(&ctx->work);
> +	kref_init(&ctx->refcount);
> +	ctx->qdev =3D qdev;
> +	/* Anything but a status the DSP could send, until it answers */
> +	ctx->retval =3D -1;
> +
> +	/* ID 0 is never used, so a zeroed context in a response matches nothin=
g */
> +	ret =3D xa_alloc(&qdev->ctx_xa, &id, ctx, XA_LIMIT(1, QDA_FASTRPC_CTXID=
_MAX),
> +		       GFP_KERNEL);
> +	if (ret) {
> +		kfree(ctx);
> +		return ERR_PTR(ret);
> +	}
> +
> +	ctx->ctxid =3D FIELD_PREP(QDA_FASTRPC_CTXID_MASK, id) |
> +		     FIELD_PREP(QDA_FASTRPC_CTXID_SEQ_MASK,
> +				(u64)atomic64_inc_return(&qdev->ctx_seq));

[Severity: High]
In qda_fastrpc_context_alloc() in drivers/accel/qda/qda_fastrpc.c, does
calling xa_alloc(&qdev->ctx_xa, &id, ctx, ...) publish ctx into qdev->ctx_xa
and drop xa_lock before ctx->ctxid is initialized?

Because the 8-bit context IDs (1..255) are reused as soon as a prior
invocation is freed, a concurrent lookup on qdev->ctx_xa for that recycled =
id
(such as qda_rpmsg_cb() handling a late, duplicate, or malformed DSP respon=
se,
or qda_fastrpc_flush_pending() during device unplug) can observe ctx while
ctx->ctxid is still 0 or is being written without locking:

1. If a late or malformed response carries sequence number 0 in bits [63:16]
   for slot id, FIELD_GET(QDA_FASTRPC_CTXID_SEQ_MASK, ctx->ctxid) evaluates=
 to
   0 and matches the uninitialized ctx->ctxid, completing ctx->work early a=
nd
   scheduling ctx->put_work to drop a reference that qda_rpmsg_send_msg() h=
as
   not yet taken.

2. If qda_fastrpc_context_free() runs while ctx->ctxid is still 0,
   xa_erase(&ctx->qdev->ctx_xa, FIELD_GET(QDA_FASTRPC_CTXID_MASK, ctx->ctxi=
d))
   erases index 0 instead of index id and frees ctx, leaving a dangling
   pointer in qdev->ctx_xa[id].

Should qda_fastrpc_context_alloc() either hold xa_lock(&qdev->ctx_xa) across
__xa_alloc() and the ctx->ctxid assignment, or reserve the slot with NULL
first and store ctx only after ctx->ctxid is initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D10
