Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1736CC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661FE10E4DB;
	Sat, 27 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C9qjp2xo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339A110E4DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A899160051
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8031F00A3A;
 Sat, 27 Jun 2026 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567752;
 bh=lpYxoH7YlFJqfve2Pjo2WGPChJ9CEvddh0ojyxod2Y0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C9qjp2xoAvpxDQ9EQQu4YoqQy9h8CPNBOjAaaUarYWDjIS8CeysgAmZwx0cWITQX4
 1uQ0k5c4mii2oCyvh25JoPnsb2wvVFLwUTIVvQNhfnm9FlGRJx61/WQZmAJ9C6ZhHH
 k5gv3tuKcSwjFNVyC1W9iACb8kvNQqGADCjF7mMlAPVI06MA73k19APPVk2kh0LJPU
 GmDMYdR0nJs5ESNQwxg6yszPDAuR81MVTSob5fp7wsYTGbxqRtxya96NKB+tsVcvoF
 kew/aB8UnKGBCUBYRMPqZ7aUMgF9ytjGHgeIfWOb4m0+1QxzlNorHaUhFY3OAQrK0M
 oYWwPzCX0A5cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-2-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:31 +0000
Message-Id: <20260627134232.3B8031F00A3A@smtp.kernel.org>
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
- [High] API wrapper functions perform unprotected back-to-back reads of th=
e global `ops_ptr`, leading to a Time-of-Check to Time-of-Use (TOCTOU) NULL=
 pointer dereference.
- [High] The PAS framework lacks module reference counting or lifecycle pro=
tection for the backend provider, making it vulnerable to Use-After-Free if=
 the provider is unloaded.
- [High] `qcom_pas_ops_register()` contains a lockless race condition that =
allows concurrent registrations to silently overwrite each other, and an un=
safe error path that risks a NULL pointer dereference.
--

commit 3d615dbf6ff0774259979478250df4ba919064e7
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

firmware: qcom: Add a generic PAS service

This commit enables the generic Peripheral Authentication Service (PAS)
provided by the firmware. It acts as a common layer with different TZ
backends plugged in, replacing splintered legacy SCM calls.

> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qco=
m_pas.c
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.c

[ ... ]

> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);
> +}

[Severity: High]
Could this result in a Time-of-Check to Time-of-Use (TOCTOU) NULL pointer
dereference?

Since ops_ptr is accessed locklessly without READ_ONCE(), the compiler
could emit two separate memory reads. If a concurrent thread executes
qcom_pas_ops_unregister() and sets ops_ptr to NULL between the check and
the dereference, it looks like a kernel panic would occur.

Would it be safer to fetch ops_ptr into a local variable using
READ_ONCE() before checking and using it?

[ ... ]

> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *c=
tx,
> +					      void *input_rt,
> +					      size_t input_rt_size,
> +					      size_t *output_rt_size)
> +{
> +	if (!ops_ptr)
> +		return ERR_PTR(-ENODEV);
> +	if (!ctx)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
> +				      input_rt_size, output_rt_size);
> +}

[Severity: High]
Does this function suffer from the same Time-of-Check to Time-of-Use
NULL pointer dereference on ops_ptr as qcom_pas_init_image()?

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

[Severity: High]
Is this lockless check-then-set logic vulnerable to a race condition?

Two backend drivers probing concurrently might both see
qcom_pas_is_available() as false and write to ops_ptr, allowing the second
driver to silently overwrite the first.

Additionally, in the else branch, what happens if ops_ptr is concurrently
set to NULL by qcom_pas_ops_unregister()? Does the unlocked read of
ops_ptr->drv_name risk a NULL pointer dereference?

> diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qco=
m_pas.h
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.h

[ ... ]

> +struct qcom_pas_ops {
> +	const char *drv_name;
> +	struct device *dev;
> +	bool (*supported)(struct device *dev, u32 pas_id);

[Severity: High]
Does this ops structure need a struct module *owner field for lifecycle
protection?

The PAS framework doesn't appear to perform module reference counting. If
the backend module providing these operations is unloaded while a remoteproc
client is actively invoking a PAS API, the backend's code and data would be
unmapped while the CPU is still executing or returning from it, leading to
a Use-After-Free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D1
