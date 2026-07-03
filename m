Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7447C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018E410E5D6;
	Fri,  3 Jul 2026 12:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LEaz75B7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0816910E5D6
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E47C60139
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E049F1F00A3A;
 Fri,  3 Jul 2026 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080171;
 bh=TsrwiKW1voSugbsio658mK865DCUVG5jBEiRTvO/Alc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LEaz75B7S5FbOve8FF+U/ffc/KWfrQzj8IAYtKVRU6CtF/sBLHKETpocDLzwGpq6i
 7X1Nu4SngW9eAuSEGqdDVcOPAmRNXiZXjg3PtyMoJShxg8yOKn2QJMayci2KafY40X
 n4YtoKYxrRTI2C7yQDcE31uvy1fXZYmWdHu5g+J+S1+tamgkg9uQ0X31Rh22/0xPCR
 /L3qdK//jkXDc6cz249Ysi2JEs+bwD1unSjj1pKJhYYflGMhJ1DZGKApPMrKATbeoE
 DASbjfE8MUvFBaXSHNmfg8/vd3uP9qRzMzsZxFOfoOJdPaEiDNQfQjfOdXwLyWiV14
 TU7BZ254ZN0Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/14] firmware: qcom_scm: Remove SCM PAS wrappers
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260702115835.167602-14-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-14-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:50 +0000
Message-Id: <20260703120250.E049F1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Time-of-check to time-of-use (TOCTOU) race condition in PAS API wr=
appers leading to potential NULL pointer dereference.
--

commit 979ccc647befac000888b4c5f41818fc1037d4ff
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

firmware: qcom_scm: Remove SCM PAS wrappers

Now since all the Qcom SCM client drivers have been migrated over to
generic PAS TZ service, let's drop the exported SCM PAS wrappers.

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 7933e55803dc2..1deee6aea3874 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the new
generic PAS TZ service usage, I noticed a potential race condition in the
API wrappers in drivers/firmware/qcom/qcom_pas.c:

drivers/firmware/qcom/qcom_pas.c:qcom_pas_init_image() {
    ...
	if (!ops_ptr)
		return -ENODEV;

	return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);
}

Since ops_ptr is a global pointer and isn't accessed with READ_ONCE() or
protected by a lock, could the compiler generate multiple loads?

If a PAS backend is unbound and qcom_pas_ops_unregister() sets ops_ptr to
NULL concurrently, can this lead to a NULL pointer dereference when
accessing ops_ptr->init_image or ops_ptr->dev?

The same pattern appears in other wrappers as well:

drivers/firmware/qcom/qcom_pas.c:qcom_pas_metadata_release() {
    ...
	if (!ops_ptr || !ctx || !ctx->ptr)
		return;

	ops_ptr->metadata_release(ops_ptr->dev, ctx);
}

Should these wrappers use READ_ONCE() or some form of synchronization to
ensure safe dereferencing of ops_ptr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D13
