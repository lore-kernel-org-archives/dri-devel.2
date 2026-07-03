Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3508C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733AE10E5CC;
	Fri,  3 Jul 2026 12:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mgcKgA/h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53DA10E5BB
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E9CB43E83
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385B81F00A3D;
 Fri,  3 Jul 2026 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080161;
 bh=+/0Yr1GiCRun5ZQL2MjqOpqapPSLfonV+w2JzIBWmmM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mgcKgA/hqf+AbucsQBfzUiR902PyrKkZYwQHpRoGROB/C9CePbR4A5wpSTwplbCIk
 vsr0EyBiWBU60KN7riYC5CK0quDFPcf/8rHm0qMJfxeZRI2JKKIG7C2bZt1lBL143B
 EgGFT1KsLyUdxJCmbelOuqTq1IIcmcjW5cKvB8F1yWzM+F9TwiGVbbqLYNu4yEvMNC
 3rzzIrILt7kWBrs3tJaAtzSsAqEsovSaIsw7HbVwLm9+igfpoCScx6zGtxjmCPm7nh
 5nz2Jh1cDH25QX+Qtqo8geljUKf9Cb7vSN1M0nAYZMrS2vy0RArkXJrdK8l/9/RhVy
 YTv1WxXwmgkKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/14] remoteproc: qcom: Select QCOM_PAS generic service
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-8-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-8-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:40 +0000
Message-Id: <20260703120241.385B81F00A3D@smtp.kernel.org>
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
- [Medium] QCOM_WCNSS_PIL still implicitly depends on QCOM_SCM via QCOM_MDT=
_LOADER, defeating the attempted decoupling.
--

commit daedd535ea1eca89bbb7b28d89c346e3968988b4
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

remoteproc: qcom: Select QCOM_PAS generic service

This commit selects the PAS generic service driver to enable support for
multiple PAS backends like OP-TEE in addition to SCM.

> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c521c744e7dbe..65befdbfa5f7d 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig

[ ... ]

> @@ -282,7 +284,7 @@ config QCOM_WCNSS_PIL
>  	select QCOM_MDT_LOADER
>  	select QCOM_PIL_INFO
>  	select QCOM_RPROC_COMMON
> -	select QCOM_SCM
> +	select QCOM_PAS

[Severity: Medium]
Does this change fully decouple the driver from QCOM_SCM as intended?=20

Looking at drivers/soc/qcom/Kconfig, QCOM_MDT_LOADER still contains a
select QCOM_SCM directive. Since QCOM_WCNSS_PIL continues to select
QCOM_MDT_LOADER, it seems Kconfig will still unconditionally enable QCOM_SCM
through transitive dependency propagation.=20

Will this prevent users from building the driver solely with the OP-TEE PAS
backend, as the kernel image would still pull in the SCM backend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D7
