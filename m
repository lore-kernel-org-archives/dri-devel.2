Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC3CC43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F60910E4DC;
	Sat, 27 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CoBTulrT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8509F10E4DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E28244030
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B72D1F000E9;
 Sat, 27 Jun 2026 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567749;
 bh=/ECLjTsfvhFpnXdhyPrjOjTKzk0w1osuGkug5uccHcc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CoBTulrTBygQhZsG69u3hM9wSoDZkLQdoE9ZCiCXoK5S1HhCiC9R/OGhP5lxH4p+d
 uhoHz4d419liKlk94ClNqPLGd6AAGoGDr62B6eZCxrGZAXpqGiB6tM8H4oDn4KxIPe
 tg4+5y2RvKjRQb946HNPFoXpKgkWB3HiD7j38ZFHVtF6HtXPeVwbCTELQpvT+xiAdY
 qopNW9wdXABqM/L3crCPbKLfiY73Us5gKK6GBZaSsSH4ZTWgRaR7zVA2rPhs+mvdcE
 4AuLTwC7ejW3UioaFXuJHD8NrArL4CGxsHEKo22PdWlY4CZ0m9b6JQbxSOqATnEFUU
 G5Q7SO5hf7ayg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/14] firmware: qcom: Add a PAS TEE service
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-4-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:28 +0000
Message-Id: <20260627134229.2B72D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] Heap buffer overflow in `qcom_pas_tee_get_rsc_table` when copy=
ing the input resource table.
- [High] Out-of-bounds read and info leak in `qcom_pas_tee_get_rsc_table` w=
hen duplicating the returned resource table.
- [High] The first TEE invocation fails to pass the input resource table da=
ta to the TA, resulting in an invalid parameter error.
- [High] Unsynchronized mutation of the global operations structure and unc=
onditional unregistration during remove.
- [Medium] The `output_rt_size` pointer is left uninitialized if the TEE re=
turns a size of 0.
- [Medium] The driver incorrectly treats the expected `TEEC_ERROR_SHORT_BUF=
FER` response as a fatal error.

Pre-existing issues:
- [High] Missing protection for `ops_ptr` reads causes a TOCTOU NULL pointe=
r dereference.
--

commit f2659330f38d92cd91647244dc269a73194079c0
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

firmware: qcom: Add a PAS TEE service

This patch adds support for a Peripheral Authentication Service (PAS)
driver based on the TEE bus, using OP-TEE as the backend implementation.

> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom=
/qcom_pas_tee.c
> new file mode 100644
> index 0000000000000..a2ba3af05a502
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas_tee.c
[ ... ]
> +static void *qcom_pas_tee_get_rsc_table(struct device *dev,
> +					struct qcom_pas_context *ctx,
> +					void *input_rt, size_t input_rt_size,
> +					size_t *output_rt_size)
> +{
> +	struct qcom_pas_tee_private *data =3D dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg =3D {
> +		.func =3D TA_QCOM_PAS_GET_RESOURCE_TABLE,
> +		.session =3D data->session_id,
> +		.num_params =3D TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] =3D {
> +		[0] =3D {
> +			.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a =3D ctx->pas_id,
> +		},
> +		[1] =3D {
> +			.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +			.u.memref.size =3D input_rt_size,
> +		}
> +	};

[Severity: High]
Does this first tee_client_invoke_func() invocation pass an invalid memory
reference to the TA?

In qcom_pas_tee_get_rsc_table(), param[1] is initialized with
u.memref.size =3D input_rt_size, but u.memref.shm is left uninitialized (NU=
LL).
If the firmware has an embedded input resource table (input_rt_size > 0), w=
ill
the TEE subsystem reject this call with an invalid parameter error before t=
he
TA is even invoked?

> +	void *rt_buf =3D NULL;
> +	int ret;
> +
> +	ret =3D tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret !=3D 0) {

[Severity: Medium]
Will this error check abort the loading process if the TA follows the stand=
ard
GlobalPlatform TEE Client API specification?

When queried for a buffer size, a standard TA is expected to return
TEEC_ERROR_SHORT_BUFFER (a non-zero error code) since the initial buffer is
NULL or too small. Since this check treats any non-zero inv_arg.ret as a
failure, does this prevent the code from proceeding to the second pass to
allocate the correctly sized buffer?

> +		dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			ctx->pas_id, ret, inv_arg.ret);
> +		return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> +	}
> +
> +	if (param[1].u.memref.size) {

[Severity: Medium]
Is it possible for output_rt_size to remain uninitialized here?

If the TA legitimately returns param[1].u.memref.size as 0 during the first
invocation (indicating no resources), this block is skipped and the function
returns NULL. Since output_rt_size is never assigned a value, callers like
those in qcom_q6v5_pas.c might read garbage stack data for the table size.

> +		struct tee_shm *rt_shm __free(shm_free) =3D
> +			tee_shm_alloc_kernel_buf(data->ctx,
> +						 param[1].u.memref.size);
> +		void *rt_shm_va;
> +
> +		if (IS_ERR_OR_NULL(rt_shm)) {
> +			dev_err(dev, "rt_shm allocation failed\n");
> +			rt_shm =3D NULL;
> +			return ERR_PTR(-ENOMEM);
> +		}
> +
> +		rt_shm_va =3D tee_shm_get_va(rt_shm, 0);
> +		if (IS_ERR(rt_shm_va)) {
> +			dev_err(dev, "rt_shm get VA failed\n");
> +			return ERR_CAST(rt_shm_va);
> +		}
> +		memcpy(rt_shm_va, input_rt, input_rt_size);

[Severity: Critical]
Can this memcpy overflow the allocated rt_shm buffer?

The rt_shm buffer is allocated using the size requested by the TA from the
first invocation (param[1].u.memref.size). However, this memcpy
unconditionally copies input_rt_size bytes. If the TA returns a size smaller
than input_rt_size, wouldn't this write past the bounds of the allocated
kernel heap buffer?

> +
> +		param[1].u.memref.shm =3D rt_shm;
> +		ret =3D tee_client_invoke_func(data->ctx, &inv_arg, param);
> +		if (ret < 0 || inv_arg.ret !=3D 0) {
> +			dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +				ctx->pas_id, ret, inv_arg.ret);
> +			return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> +		}
> +
> +		if (param[1].u.memref.size) {
> +			*output_rt_size =3D param[1].u.memref.size;
> +			rt_buf =3D kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);

[Severity: High]
Could this kmemdup read out of bounds of the initially allocated rt_shm
buffer?

During the second tee_client_invoke_func() call, the TA can update
param[1].u.memref.size to a value larger than the initially allocated rt_shm
capacity. If output_rt_size is updated to this larger value, kmemdup will r=
ead
past the end of the rt_shm_va buffer, potentially leaking adjacent sensitive
kernel heap data to the caller.

> +			if (!rt_buf)
> +				return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	return rt_buf;
> +}
[ ... ]
> +static int qcom_pas_tee_probe(struct tee_client_device *pas_dev)
> +{
[ ... ]
> +	data->session_id =3D sess_arg.session;
> +	dev_set_drvdata(dev, data);
> +	qcom_pas_ops_tee.dev =3D dev;
> +	qcom_pas_ops_register(&qcom_pas_ops_tee);

[Severity: High]
Is it safe to mutate the static qcom_pas_ops_tee.dev singleton without
synchronization?

If qcom_pas_ops_register() is called when another backend (like SCM) is
already registered, it fails silently but the probe still succeeds.
Could this lead to conflicting states if multiple backends probe concurrent=
ly?

[Severity: High]
This isn't a bug introduced by this patch, but is there a TOCTOU race
condition when reading ops_ptr in qcom_pas.c?

In functions like qcom_pas_init_image(), ops_ptr is checked for NULL and
subsequently dereferenced:

if (!ops_ptr)
    return -ENODEV;

return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);

Since ops_ptr is not protected by RCU, a lock, or READ_ONCE(), a concurrent
call to qcom_pas_ops_unregister() (e.g., via module unload) can set ops_ptr=
 to
NULL between the check and the dereference, causing a NULL pointer
dereference.

> +
> +	return ret;
> +}
> +
> +static void qcom_pas_tee_remove(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev =3D &pas_dev->dev;
> +	struct qcom_pas_tee_private *data =3D dev_get_drvdata(dev);
> +
> +	qcom_pas_ops_unregister();

[Severity: High]
Does this unconditional unregister break the SCM backend?

If the TEE module is unloaded, qcom_pas_tee_remove() forcefully clears the
global ops_ptr. If the SCM backend was the active registered backend instead
of TEE, wouldn't this destroy the active SCM registration and break PAS
functionality globally?

> +	tee_client_close_session(data->ctx, data->session_id);
> +	tee_client_close_context(data->ctx);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D3
