Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB57EC43602
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F53C10E4E5;
	Sat, 27 Jun 2026 13:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="emmumZBY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1159110E4DC
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F014B43BE1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06C61F00ADB;
 Sat, 27 Jun 2026 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567750;
 bh=bIyOaV36vGLGAzdaaCwad8lEbbKerxhZWEAFhGA7rzs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=emmumZBYt1eRPNk1DuWRudwffD2qEGwJ2CNcvmkm5J9P95qJPa7DkJVAV2YDjbk+c
 zULybbHWR1R4lF+uMmX6TouZhPoIeaeNDSXuPhAgkfOF0vO6Iu5aLzLnoE8pxiH3jJ
 ov+bfSJ8gghDpeQe+al1IATkT4qdXJZco+MP+hn3uxrOk+2VnoB7d9qBF+uEKKCX5+
 OZSexDAulSzHDd0LlXKMjhrKi4ZiofQ1ImgCAkTlPI7xlZaOiXW7t7w+3Usv+1wCGF
 9tFL/4LAuDbA6T0kAdl1ch1XeFSG+3ww/UqW0uJlJufcMSICPg/AAzmm6JZLrr/jbM
 XrH1k/dOQRFiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/14] remoteproc: qcom: Select QCOM_PAS generic service
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-8-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-8-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:30 +0000
Message-Id: <20260627134230.B06C61F00ADB@smtp.kernel.org>
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
- [High] Heap buffer overflow (OOB write) and undefined behavior in qcom_pa=
s_tee_get_rsc_table due to missing size bounds and NULL validation.
- [High] Out-of-bounds read in qcom_pas_tee_get_rsc_table during kmemdup.
- [High] State corruption due to unconditional unregistration of PAS ops.
--

commit b487f397efddfdc143f4e42a9e7644cc3aeb39da
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

remoteproc: qcom: Select QCOM_PAS generic service

Select PAS generic service driver to enable support for multiple PAS
backends like OP-TEE in addition to SCM.

> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qco=
m_pas.c
> new file mode 100644
> index 0000000000000..bc6c42f2b3c61
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.c

[ ... ]

> +void qcom_pas_ops_register(struct qcom_pas_ops *ops)
> +{
> +	if (!qcom_pas_is_available())
> +		/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +		smp_store_release(&ops_ptr, ops);
> +	else
> +		pr_err("qcom_pas: ops already registered by %s\n",
> +		       ops_ptr->drv_name);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
> +
> +void qcom_pas_ops_unregister(void)
> +{
> +	/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +	smp_store_release(&ops_ptr, NULL);

[Severity: High]
Can this lead to state corruption if a second backend driver fails to regis=
ter
but subsequently unregisters?

Since qcom_pas_ops_register() returns void instead of an error code, if a
second PAS backend (e.g., TEE) probes after the first (e.g., SCM) has
registered, its probe succeeds without owning the registration.

If the second backend is later removed, its remove callback will invoke
qcom_pas_ops_unregister() and unconditionally clear the legitimately regist=
ered
ops_ptr. Could this cause a denial of service for remoteproc subsystems
since subsequent PAS operations would fail with -ENODEV?

> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);

[ ... ]

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

[ ... ]

> +	if (param[1].u.memref.size) {
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

[Severity: High]
Is there a missing bounds check and NULL check here?

The TEE Trusted Application returns an expected buffer size in
param[1].u.memref.size, which is used to allocate the rt_shm buffer. Howeve=
r,
this memcpy unconditionally copies input_rt_size bytes.

If a compromised or malfunctioning TA returns a size smaller than
input_rt_size, could this result in a heap buffer overflow?

Additionally, if input_rt is NULL and input_rt_size is 0 (which is document=
ed
for firmwares without an embedded resource table), wouldn't this result in
undefined behavior by passing a NULL pointer to memcpy?

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
Could this kmemdup read out of bounds?

After the second TEE invocation, the TA can modify param[1].u.memref.size,
which is blindly assigned to *output_rt_size and used in kmemdup.

If the TA increases the size beyond the initially allocated rt_shm buffer s=
ize,
wouldn't kmemdup read past the end of the buffer?

> +			if (!rt_buf)
> +				return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	return rt_buf;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D7
