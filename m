Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF57DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF57510EE0F;
	Wed,  1 Jul 2026 07:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K9lDy22p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D5610EE0F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:33:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6930600AB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689D01F000E9;
 Wed,  1 Jul 2026 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782891207;
 bh=SRR0gv+SEigc9fSD1/MJ9M+6k2r0/X3a6W834bV7DyE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K9lDy22p/wua3UvNs35nRAi54+4RdEuRPM7HKXKR2H1KsO84GRQNbAYpkDCbq4RPD
 CCbRnrQTZrQYh4HftkqMuzyyScPAbeQAG0eLeJe+Xxm8ZAc0aYNplsPJGgVHJneDkL
 NUQZVv6NJH2swHXsLIOyHpt3m8IG8LQ1GudE/z37Ob4AKrNK6LPHNA/Y5vxj55OgrX
 jXzhuO9xU6ZtQgvs6ntlTOU98yIs02burjrs4su1sv9ZtL3XDvBRQodInGHvOapfq4
 O5ZXvhDuukUP+RlmnRfOUzBjDfUGigK4krddOrr8db6A6XiBnmxn78rNVhQIV6n09C
 JD1T+OS4xFtmA==
Date: Wed, 1 Jul 2026 13:03:23 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 03/14] firmware: qcom: Add a PAS TEE service
Message-ID: <akTCw4GsP-e_bwns@sumit-xelite>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-4-sumit.garg@kernel.org>
 <20260627134229.2B72D1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260627134229.2B72D1F000E9@smtp.kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, Jun 27, 2026 at 01:42:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Heap buffer overflow in `qcom_pas_tee_get_rsc_table` when copying the input resource table.
> - [High] Out-of-bounds read and info leak in `qcom_pas_tee_get_rsc_table` when duplicating the returned resource table.
> - [High] The first TEE invocation fails to pass the input resource table data to the TA, resulting in an invalid parameter error.
> - [High] Unsynchronized mutation of the global operations structure and unconditional unregistration during remove.
> - [Medium] The `output_rt_size` pointer is left uninitialized if the TEE returns a size of 0.
> - [Medium] The driver incorrectly treats the expected `TEEC_ERROR_SHORT_BUFFER` response as a fatal error.

I have responded in v6 as well, Shashiko is not able to get understand
the TEE ABI with the TA here. Please go and look into the OP-TEE
code-base here:
https://github.com/OP-TEE/optee_os/blob/master/core/pta/qcom/pas/pta_qcom_pas.c

-Sumit

> 
> Pre-existing issues:
> - [High] Missing protection for `ops_ptr` reads causes a TOCTOU NULL pointer dereference.
> --
> 
> commit f2659330f38d92cd91647244dc269a73194079c0
> Author: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> firmware: qcom: Add a PAS TEE service
> 
> This patch adds support for a Peripheral Authentication Service (PAS)
> driver based on the TEE bus, using OP-TEE as the backend implementation.
> 
> > diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> > new file mode 100644
> > index 0000000000000..a2ba3af05a502
> > --- /dev/null
> > +++ b/drivers/firmware/qcom/qcom_pas_tee.c
> [ ... ]
> > +static void *qcom_pas_tee_get_rsc_table(struct device *dev,
> > +					struct qcom_pas_context *ctx,
> > +					void *input_rt, size_t input_rt_size,
> > +					size_t *output_rt_size)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_GET_RESOURCE_TABLE,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = ctx->pas_id,
> > +		},
> > +		[1] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> > +			.u.memref.size = input_rt_size,
> > +		}
> > +	};
> 
> [Severity: High]
> Does this first tee_client_invoke_func() invocation pass an invalid memory
> reference to the TA?
> 
> In qcom_pas_tee_get_rsc_table(), param[1] is initialized with
> u.memref.size = input_rt_size, but u.memref.shm is left uninitialized (NULL).
> If the firmware has an embedded input resource table (input_rt_size > 0), will
> the TEE subsystem reject this call with an invalid parameter error before the
> TA is even invoked?
> 
> > +	void *rt_buf = NULL;
> > +	int ret;
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> 
> [Severity: Medium]
> Will this error check abort the loading process if the TA follows the standard
> GlobalPlatform TEE Client API specification?
> 
> When queried for a buffer size, a standard TA is expected to return
> TEEC_ERROR_SHORT_BUFFER (a non-zero error code) since the initial buffer is
> NULL or too small. Since this check treats any non-zero inv_arg.ret as a
> failure, does this prevent the code from proceeding to the second pass to
> allocate the correctly sized buffer?
> 
> > +		dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> > +			ctx->pas_id, ret, inv_arg.ret);
> > +		return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	if (param[1].u.memref.size) {
> 
> [Severity: Medium]
> Is it possible for output_rt_size to remain uninitialized here?
> 
> If the TA legitimately returns param[1].u.memref.size as 0 during the first
> invocation (indicating no resources), this block is skipped and the function
> returns NULL. Since output_rt_size is never assigned a value, callers like
> those in qcom_q6v5_pas.c might read garbage stack data for the table size.
> 
> > +		struct tee_shm *rt_shm __free(shm_free) =
> > +			tee_shm_alloc_kernel_buf(data->ctx,
> > +						 param[1].u.memref.size);
> > +		void *rt_shm_va;
> > +
> > +		if (IS_ERR_OR_NULL(rt_shm)) {
> > +			dev_err(dev, "rt_shm allocation failed\n");
> > +			rt_shm = NULL;
> > +			return ERR_PTR(-ENOMEM);
> > +		}
> > +
> > +		rt_shm_va = tee_shm_get_va(rt_shm, 0);
> > +		if (IS_ERR(rt_shm_va)) {
> > +			dev_err(dev, "rt_shm get VA failed\n");
> > +			return ERR_CAST(rt_shm_va);
> > +		}
> > +		memcpy(rt_shm_va, input_rt, input_rt_size);
> 
> [Severity: Critical]
> Can this memcpy overflow the allocated rt_shm buffer?
> 
> The rt_shm buffer is allocated using the size requested by the TA from the
> first invocation (param[1].u.memref.size). However, this memcpy
> unconditionally copies input_rt_size bytes. If the TA returns a size smaller
> than input_rt_size, wouldn't this write past the bounds of the allocated
> kernel heap buffer?
> 
> > +
> > +		param[1].u.memref.shm = rt_shm;
> > +		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +		if (ret < 0 || inv_arg.ret != 0) {
> > +			dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> > +				ctx->pas_id, ret, inv_arg.ret);
> > +			return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> > +		}
> > +
> > +		if (param[1].u.memref.size) {
> > +			*output_rt_size = param[1].u.memref.size;
> > +			rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);
> 
> [Severity: High]
> Could this kmemdup read out of bounds of the initially allocated rt_shm
> buffer?
> 
> During the second tee_client_invoke_func() call, the TA can update
> param[1].u.memref.size to a value larger than the initially allocated rt_shm
> capacity. If output_rt_size is updated to this larger value, kmemdup will read
> past the end of the rt_shm_va buffer, potentially leaking adjacent sensitive
> kernel heap data to the caller.
> 
> > +			if (!rt_buf)
> > +				return ERR_PTR(-ENOMEM);
> > +		}
> > +	}
> > +
> > +	return rt_buf;
> > +}
> [ ... ]
> > +static int qcom_pas_tee_probe(struct tee_client_device *pas_dev)
> > +{
> [ ... ]
> > +	data->session_id = sess_arg.session;
> > +	dev_set_drvdata(dev, data);
> > +	qcom_pas_ops_tee.dev = dev;
> > +	qcom_pas_ops_register(&qcom_pas_ops_tee);
> 
> [Severity: High]
> Is it safe to mutate the static qcom_pas_ops_tee.dev singleton without
> synchronization?
> 
> If qcom_pas_ops_register() is called when another backend (like SCM) is
> already registered, it fails silently but the probe still succeeds.
> Could this lead to conflicting states if multiple backends probe concurrently?
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is there a TOCTOU race
> condition when reading ops_ptr in qcom_pas.c?
> 
> In functions like qcom_pas_init_image(), ops_ptr is checked for NULL and
> subsequently dereferenced:
> 
> if (!ops_ptr)
>     return -ENODEV;
> 
> return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);
> 
> Since ops_ptr is not protected by RCU, a lock, or READ_ONCE(), a concurrent
> call to qcom_pas_ops_unregister() (e.g., via module unload) can set ops_ptr to
> NULL between the check and the dereference, causing a NULL pointer
> dereference.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static void qcom_pas_tee_remove(struct tee_client_device *pas_dev)
> > +{
> > +	struct device *dev = &pas_dev->dev;
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +
> > +	qcom_pas_ops_unregister();
> 
> [Severity: High]
> Does this unconditional unregister break the SCM backend?
> 
> If the TEE module is unloaded, qcom_pas_tee_remove() forcefully clears the
> global ops_ptr. If the SCM backend was the active registered backend instead
> of TEE, wouldn't this destroy the active SCM registration and break PAS
> functionality globally?
> 
> > +	tee_client_close_session(data->ctx, data->session_id);
> > +	tee_client_close_context(data->ctx);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626133440.692849-1-sumit.garg@kernel.org?part=3
