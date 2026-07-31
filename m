Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086ECC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E41510E23B;
	Fri, 31 Jul 2026 15:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mCd7q8fo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3FB10E23B
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:39:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1C6260A66;
 Fri, 31 Jul 2026 15:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B1B1F00A3D;
 Fri, 31 Jul 2026 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785512339;
 bh=Ja1g9jZ9LiIZwNMcTfUoR6B3HRkhPjrW/v2OmLo7GJg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mCd7q8fog7B3tD3Dt9uP3fwsk+NmugwDUmf4PMUpgM1PRuURpqjtimYrDYfs9WCO/
 2bfRn+Hiw57B6+xjWb1ymuZxZ0JwXrs63dhbu2necfxcnHFDFUTWlukaPZJoRpHhCR
 KPfIf/djln0Pprj2x3af4raC1AyTM8FY1+VsCIFE6Pl6Gm0Co7ateYTn0Oatr9NgCA
 QAEbK+muywjhB4L9ZX8fMxx9CZA0lqdMlktZ0C8TU/d/dFctvvneBknPytxm42M9k6
 Bp4uY3GpE07VF2k/lsEf1HJ6uF5bCGt2QscsK0CHdd+oQbpwi6p0KMzuwphGe/QTM8
 qHWhM8PFwrpIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/qaic: Address potential out-of-bounds read in
 resp_worker()
To: "Youssef Samir" <youssef.abdulrahman@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731152344.1905882-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260731152344.1905882-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:38:59 +0000
Message-Id: <20260731153859.76B1B1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Insufficient transaction length validation leads to out-of-bou=
nds reads on the wire message and heap buffer overflows when writing to the=
 user message.
- [Critical] Concurrent execution of `release_dbc` causes a double-free of =
DMA memory.
- [Critical] Concurrent `QAIC_ATTACH_SLICE_BO` ioctls cause list corruption=
 on `dbc->bo_lists`.
- [High] The bounds checking in `decode_message()` fails to account for the=
 message header size, allowing out-of-bounds reads past the slab allocation.
- [High] Uninitialized kernel heap memory can be parsed and leaked to users=
pace because the MHI download callback trusts the untrusted `msg->hdr.len` =
field instead of the actual DMA transfer size.
--

--- Patch [1]: [PATCH v2] accel/qaic: Address potential out-of-bounds read =
in resp_worker() ---
commit 5420c8d76fb8c8bd25b927d7ec9f082dda6e6558
Author: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

accel/qaic: Address potential out-of-bounds read in resp_worker()

This commit refactors bounds checking code by using decode_message()
directly inside resp_worker(). It addresses a potential out-of-bounds read
or kernel panic when handling an orphaned DBC deactivation message sent
from the device.

(No Link: tags present in the commit header)

> diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_=
control.c
> index bb94d3556904a..ecbafab7187cb 100644
> --- a/drivers/accel/qaic/qaic_control.c
> +++ b/drivers/accel/qaic/qaic_control.c
[ ... ]
> @@ -963,11 +963,13 @@ static int decode_status(struct qaic_device *qdev, =
void *trans, struct manage_ms
> =20
>  static int decode_message(struct qaic_device *qdev, struct manage_msg *u=
ser_msg,
>  			  struct wire_msg *msg, struct ioctl_resources *resources,
> -			  struct qaic_user *usr)
> +			  struct qaic_user *usr, bool orphaned_deactivate)
>  {
> +	u32 msg_hdr_count =3D le32_to_cpu(msg->hdr.count);
>  	u32 msg_hdr_len =3D le32_to_cpu(msg->hdr.len);
>  	struct wire_trans_hdr *trans_hdr;
>  	u32 msg_len =3D 0;
[ ... ]
> @@ -990,7 +994,20 @@ static int decode_message(struct qaic_device *qdev, =
struct manage_msg *user_msg,
>  		    size_add(msg_len, hdr_len) > msg_hdr_len)
>  			return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does this bounds check allow
the offset to exceed the physical buffer size?

Since size_add(msg_len, hdr_len) is compared to msg_hdr_len instead of
(msg_hdr_len - sizeof(msg->hdr)), msg_len can reach the total message lengt=
h.
However, the payload buffer msg->data only has msg_hdr_len - sizeof(msg->hd=
r)
bytes.

Because the 32-byte header size is not subtracted, msg->data + msg_len can
point 32 bytes past the end of the out_buf slab allocation when msg_hdr_len
is QAIC_MANAGE_MAX_MSG_LENGTH.

Could this out-of-bounds memory then be copied to the user-facing message
buffer in decode_passthrough():

drivers/accel/qaic/qaic_control.c:decode_passthrough() {
    ...
    memcpy(out_trans->data, in_trans->data, len - sizeof(in_trans->hdr));
    ...
}

facilitating an information leak?


[Severity: Critical]
This is a pre-existing issue, but does this loop verify the required size f=
or
the specific transaction type?

The bounds check only verifies that hdr_len is >=3D 8 (sizeof(*trans_hdr)).=
=20

If a malicious or malfunctioning device sends a QAIC_TRANS_ACTIVATE_FROM_DE=
V=20
transaction with a truncated hdr_len (e.g., 8 bytes), could decode_activate=
()
unconditionally write 24 bytes of fields (status, dbc_id, options) to
out_trans?

drivers/accel/qaic/qaic_control.c:decode_activate() {
    ...
    out_trans->hdr.type =3D le32_to_cpu(in_trans->hdr.type);
    out_trans->hdr.len =3D len;
    out_trans->status =3D le32_to_cpu(in_trans->status);
    out_trans->dbc_id =3D le32_to_cpu(in_trans->dbc_id);
    out_trans->options =3D le64_to_cpu(in_trans->options);
    ...
}

Since decode_activate() checks the remaining capacity in user_msg using the
8-byte hdr_len, could this result in writing 16 bytes past the end of the
user_msg heap allocation?

[ ... ]

Additionally, there are a few other pre-existing issues in this subsystem:

[Severity: High]
This isn't a bug introduced by this patch, but can uninitialized kernel heap
memory be parsed and leaked to userspace?

In qaic_mhi_dl_xfer_cb(), if a device sends a short MHI packet but with a
large msg->hdr.len field, the actual DMA transfer size does not appear to be
validated against msg->hdr.len:

drivers/accel/qaic/qaic_control.c:qaic_mhi_dl_xfer_cb() {
    ...
    if (mhi_result->transaction_status || msg->hdr.magic_number !=3D MANAGE=
_MAGIC_NUMBER) {
        kfree(msg);
        return;
    }

    resp =3D kmalloc_obj(*resp, GFP_ATOMIC);
    ...
}

Could decode_message() subsequently parse the uninitialized kmalloc memory =
as
valid transactions up to the length dictated by the untrusted msg->hdr.len?


[Severity: Critical]
This is a pre-existing issue, but does concurrent execution of release_dbc()
cause a double-free of DMA memory?

If a user issues a deactivate ioctl which gets interrupted, and resp_worker=
()
processes the orphaned response, it calls release_dbc(). Concurrently, the
user retrying the deactivate ioctl could also successfully trigger
release_dbc():

drivers/accel/qaic/qaic_data.c:release_dbc() {
    ...
    if (!dbc->in_use)
        return;

    wakeup_dbc(qdev, dbc_id);

    dma_free_coherent(&qdev->pdev->dev, dbc->total_size, dbc->req_q_base, d=
bc->dma_addr);
    ...
}

Since dbc->in_use is checked and modified without mutual exclusion, can both
threads pass the !dbc->in_use check simultaneously and call
dma_free_coherent() on the same dbc->req_q_base pointer?


[Severity: Critical]
This is a pre-existing issue, but can concurrent QAIC_ATTACH_SLICE_BO ioctls
cause list corruption on dbc->bo_lists?

When multiple threads issue QAIC_ATTACH_SLICE_BO ioctls concurrently for
different BOs on the same DBC, the only locks held during list_add_tail() a=
re
the per-BO mutex (bo->lock) and SRCU read locks:

drivers/accel/qaic/qaic_data.c:qaic_attach_slice_bo_ioctl() {
    ...
    bo->sliced =3D true;
    list_add_tail(&bo->bo_list, &bo->dbc->bo_lists);
    srcu_read_unlock(&dbc->ch_lock, rcu_id);
    mutex_unlock(&bo->lock);
    ...
}

Because SRCU read locks do not provide mutual exclusion between readers, can
multiple threads concurrently execute list_add_tail() on the shared
dbc->bo_lists?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731152344.1905=
882-1-youssef.abdulrahman@oss.qualcomm.com?part=3D1
