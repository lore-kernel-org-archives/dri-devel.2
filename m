Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F981C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2005710E5DC;
	Fri,  3 Jul 2026 12:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OfaXoLQw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D6B10E5D6
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D2E86001A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE1A1F000E9;
 Fri,  3 Jul 2026 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080167;
 bh=2FXm0wRzNDW+XPkhRl4d+1krW3yU1Bg71TxetOLLz9c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OfaXoLQwcnyDnUcQ20w2VnTmkQc9Ck+6xshGcsXcQFgwPYbT2aYNPae2SFWP8vPSe
 DLipxMI38Oz813WsZ7B4D57lrEt84KULT/RgGagosuU74yqQ3vltbu1cMeQQkoZVeN
 Jzog+uuUlko80p3ihl8bXJgFDg1k7j/1NH2ijKa6zinJiVFLDeuvqRRQHBXJxJ3u4o
 03zurXCNz3N7z3tBPaVC3kl3vKtFrPqHLnuIMFcZuApNxStRqaJiuETTybMl7go46t
 Lf2H+WqGaUR5QLMX8O4EgKT4Mm+qTXFon8kiOszuD0Kq7EJ89XTbi2AsbJCAdL0B37
 mci7YVLTMRFUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/14] firmware: qcom: Add a PAS TEE service
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260702115835.167602-4-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:46 +0000
Message-Id: <20260703120246.EEE1A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] qcom_pas_tee_remove() unconditionally unregisters the global PAS o=
ps, which can corrupt system state by deregistering another active backend.
- [High] qcom_pas_tee_get_rsc_table() fails with -EINVAL and aborts initial=
ization when handling a zero-sized resource table.
- [High] Broken TEE size-query logic in qcom_pas_tee_get_rsc_table() aborts=
 on TEEC_ERROR_SHORT_BUFFER and passes a NULL buffer with a non-zero size.
- [High] qcom_pas_tee_get_rsc_table() silently discards the resource table =
if the TA requests a size smaller than input_rt_size.
- [High] Lack of synchronization and module refcounting on the global ops_p=
tr leads to TOCTOU and Use-After-Free bugs.
- [High] Unvalidated TA-provided size leads to an out-of-bounds read of ker=
nel memory in qcom_pas_tee_get_rsc_table().
--

Note: The format of this report is altered due to system recitation
restrictions. Instead of inline diff quotes, a free-form summary of the
findings is provided below.

commit c175d6ee38b74c2a77d95052360287597c771c21
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: firmware: qcom: Add a PAS TEE service

This commit adds support for the Peripheral Authentication Service (PAS)
driver based on the TEE bus with OP-TEE. It provides the backend PAS service
implementation.

[Severity: High]
In drivers/firmware/qcom/qcom_pas_tee.c during driver removal, does
qcom_pas_tee_remove() forcefully unregister the global PAS ops even if
this driver wasn't the one that successfully registered them?

Looking at qcom_pas_tee_probe(), it calls qcom_pas_ops_register() which
returns void and only logs an error if another provider (like qcom_scm)
is already registered. This allows the probe to succeed without aborting.
However, upon module removal, qcom_pas_tee_remove() unconditionally calls
qcom_pas_ops_unregister() which wipes the global pointer, potentially
breaking subsequent operations for the actual active backend.

[Severity: High]
Does qcom_pas_tee_get_rsc_table() fail the initialization sequence for
peripherals without dynamic resource requirements?

If input_rt_size is 0 and the TA also returns a required size of 0, the
driver allocates a 0-sized shared memory object and calls
tee_shm_get_va(rt_shm, 0). This triggers a size check failure internally
in the TEE subsystem because the offset (0) is not less than the size (0),
returning -EINVAL and aborting the setup sequence.

[Severity: High]
Could the TEE size-query logic in qcom_pas_tee_get_rsc_table() pass a NULL
buffer with a non-zero size to the TA?

During the initial invocation, the driver sets the parameter size to
input_rt_size but does not allocate a shared memory buffer, passing NULL.
Additionally, if the TA correctly responds with TEEC_ERROR_SHORT_BUFFER
to request a larger buffer, the driver treats any non-zero return code as
a fatal error and aborts instead of proceeding to allocate the buffer.

[Severity: High]
Will qcom_pas_tee_get_rsc_table() silently discard the resource table if
the TA requires a smaller size than the original input_rt_size?

If the TA optimizes or removes entries and returns a required size strictly
less than input_rt_size, the driver falls into the else block, sets the
output size to 0, and returns NULL. This causes the original static resource
table to be lost.

[Severity: High]
Are there missing concurrency protections for the global ops_ptr in the new
core driver design?

In wrappers like qcom_pas_shutdown(), the global ops_ptr is read twice
(first to check for NULL, then to dereference) without any locking or RCU.
If qcom_pas_tee_remove() is called concurrently, it sets ops_ptr to NULL,
which could cause a NULL pointer dereference. Furthermore, since the
operations structure lacks an owner field to pin the module in memory,
the backend module could be unloaded while its functions are actively
executing on another CPU.

[Severity: High]
Can qcom_pas_tee_get_rsc_table() read out of bounds from kernel memory if
the TA provides an unexpectedly large size?

During the second TA invocation, the driver unconditionally trusts the
size returned by the TA and uses it in kmemdup(). If the returned size
exceeds the originally allocated size of the rt_shm buffer, kmemdup()
will read past the bounds of the buffer on the kernel heap, leaking
sensitive memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D3
