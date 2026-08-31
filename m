Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB331C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3237A10E312;
	Mon, 31 Aug 2026 17:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QMZuxQ1e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C1610E312
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:09:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6933860120;
 Mon, 31 Aug 2026 17:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94041F000E9;
 Mon, 31 Aug 2026 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788196175;
 bh=aMXmj/ThRagC+ZN5eJb1jYwcxTLcgdevLpP6+Vgnh7g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QMZuxQ1esB/PdIJ8nahkMnFss+MyZ0EQN/f1lc5HS8yqwyIt9W3YH2PYB0gWqAgTP
 lmXk3ZpO4/IzsdypSZan3CFhBej8jxTXGoWdW+FB8iy1J+8yxCsrABxNn3B9u30LTK
 CExjnmNnX3i9/xoLHFmVRV3QNU1ibgUXh61oqtbLUmpa4ibNrKvnVUtVPT+GU0oqKI
 xNsPgA8/61/niW8SMkXN8htyDcifwbRKY+jXLY7rQilBlthFvUKfnCvkVZ1ma1B3Dt
 TtmijIfOeQUW1JhGQ6wtmd1PrecwW1Mh4oJ+j5/Q8kjLcb/KO397qZvEWJ2njXxBRi
 9quNacdKE7V9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/qaic: Add support for AI200 virtual functions
To: "Youssef Samir" <youssef.abdulrahman@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831135008.1418190-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260831135008.1418190-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:09:34 +0000
Message-Id: <20260831170934.E94041F000E9@smtp.kernel.org>
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
- [High] System crash on VF suspend due to unconditional NULL pointer deref=
erence of qdev->mqts_ch.
--

commit 136267f1b302748ae2c7ab124a5490ff5bbea19a
Author: Zack McKevitt <zmckevit@qti.qualcomm.com>

accel/qaic: Add support for AI200 virtual functions

This patch registers the qaic_pci_sriov_configure() callback to allow
virtual functions to be created through the AIC200's sysfs numvfs entry.
It also defines a new MHI family for the channels supported by AIC200 VFs.

Link: https://lore.kernel.org/all/20260814165907.C76841F00A3A@smtp.kernel.o=
rg/

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 0acf6cdd44f81..6427105ebdf75 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
[ ... ]
> @@ -768,6 +814,7 @@ static struct pci_driver qaic_pci_driver =3D {
>  	.remove =3D qaic_pci_remove,
>  	.shutdown =3D qaic_pci_shutdown,
>  	.err_handler =3D &qaic_pci_err_handler,
> +	.sriov_configure =3D qaic_pci_sriov_configure,
>  	.driver =3D {
>  		.pm =3D pm_sleep_ptr(&qaic_pm_ops),

[Severity: High]
This is a pre-existing issue, but since this patch introduces virtual
functions that can be suspended, will this cause a system crash on VF suspe=
nd?

When the system suspends a QAIC virtual function, qaic_pm_suspend() is call=
ed
via the qaic_pm_ops struct. This function unconditionally calls into the
timesync code:

drivers/accel/qaic/qaic_drv.c:qaic_pm_suspend() {
        ...
        qaic_mqts_ch_stop_timer(qdev->mqts_ch);
        ...
}

However, since VFs do not support or initialize the QAIC_TIMESYNC_PERIODIC
channel, qdev->mqts_ch is always NULL for them. This leads to an unconditio=
nal
NULL pointer dereference when stopping the timer:

drivers/accel/qaic/qaic_timesync.c:qaic_mqts_ch_stop_timer() {
        struct mqts_dev *mqtsdev =3D dev_get_drvdata(&mhi_dev->dev);
        ...
}

Because dev_get_drvdata accesses dev->driver_data, passing the evaluated
address of the NULL pointer's dev struct will trigger a kernel panic. Should
qaic_pm_suspend() or qaic_mqts_ch_stop_timer() check for a NULL channel
before attempting to stop the timer?

>  	},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831135008.1418=
190-1-youssef.abdulrahman@oss.qualcomm.com?part=3D1
