Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01713C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B9410E271;
	Sat, 26 Sep 2026 15:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eZ+NHXCj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B989C10E13E
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:59:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A389840E4E;
 Sat, 26 Sep 2026 15:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523A01F000FF;
 Sat, 26 Sep 2026 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790438374;
 bh=5/zVX49C0tJlYLYcP0MJRp9pjtAbDvgmMHgnqLfnl5g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eZ+NHXCjQWFHJt+KYAAfbcndp0NLRMQifNqCIdMLhhoyI5k4HcHa5EB5WPQWcS7HT
 M0UZvoRNT0drpl5A1K51nVkqnRlMhzE8pwcvjV9APpbt+NdY/dTK9lH+skGymL30Ct
 mkB4xr0oYFar3I7aZL7qg87BJyCeodV6CV2wB2fOptqVkD46azoIzFdVxxl5/WXOXc
 R89xKxbfUGIpQy5kgXFjznGncO+QiZ6GGJYJIfnQbPmyQgZgzjmUarAm8zyJfTSUud
 soGQtY2h5KJZueCicgDeYSrQVvE3Qgnq6sHVJ9NmyXt+2oloybrkG8Nazd2Z0jyShl
 k9Yk9AWTBpTIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] soc: qcom: mdt_loader: remove qcom_mdt_load()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260925155737.4161358-8-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-8-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:59:33 +0000
Message-Id: <20260926155934.523A01F000FF@smtp.kernel.org>
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
- [Medium] mm: devres memory leak in device lifecycle functions due to devm=
_qcom_pas_context_alloc()
--

commit 7aed1d3e9c7b0aae366ecbadb5ead9994e82f517
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

soc: qcom: mdt_loader: remove qcom_mdt_load()

This commit removes the qcom_mdt_load() wrapper since all callers have been
migrated to qcom_mdt_pas_load(). The new function takes an explicit
qcom_pas_context and delegates memory setup to it.

> All callers have been migrated to qcom_mdt_pas_load(), which takes an
> explicit qcom_pas_context instead of a raw pas_id and delegates memory
> setup to the context.

[Severity: Medium]
Does this migration introduce a memory leak of struct qcom_pas_context?

The migration to qcom_mdt_pas_load() requires an explicit context allocated
via devm_qcom_pas_context_alloc(). This allocation is now placed inside
functions like ath12k_ahb_power_up(), venus_load_fw(), and
iris_load_fw_to_memory():

drivers/net/wireless/ath/ath12k/ahb.c:ath12k_ahb_power_up() {
    ...
    ctx =3D devm_qcom_pas_context_alloc(dev, pasid, rproc_info->mem_phys,
                                      rproc_info->mem_size);
    ...
}

drivers/media/platform/qcom/venus/firmware.c:venus_load_fw() {
    ...
    core->fw.pas_ctx =3D devm_qcom_pas_context_alloc(dev, VENUS_PAS_ID,
                                                   *mem_phys, *mem_size);
    ...
}

drivers/media/platform/qcom/iris/iris_firmware.c:iris_load_fw_to_memory() {
    ...
    core->pas_ctx =3D devm_qcom_pas_context_alloc(dev, IRIS_PAS_ID, mem_phy=
s,
                                                resource_size(&res));
    ...
}

These functions are executed repeatedly during normal system operations suc=
h as
system suspend/resume (e.g., ath12k_core_resume_early() ->
ath12k_hif_power_up() -> ath12k_ahb_power_up()) and system error recovery
(venus_sys_error_handler, iris_sys_error_handler).

Since devm_* resources are only freed when the driver is unbound, does every
invocation append a new allocation to the devres list without freeing the
previous one?

This would leak memory and degrade devres traversal performance with each
suspend/resume cycle or error recovery.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155737.4161=
358-1-mukesh.ojha@oss.qualcomm.com?part=3D7
