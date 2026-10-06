Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C56CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 19:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC9D10E3FD;
	Tue,  6 Oct 2026 19:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZZnoChiY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C434F10E3ED
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 19:45:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6460440494;
 Tue,  6 Oct 2026 19:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165371F0089C;
 Tue,  6 Oct 2026 19:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791315933;
 bh=ChD/me/I18cTRqIGrdJDGDJkKSGPR4tvhYXJ9VV93D4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZZnoChiY2zMILVg+bD/b98xTbcKvnuoVT8+WQepElMWunO8drdHvmBMsvoGAcqhAH
 DunsKiUpVzLk7a7fbeuCp1NCg+tvFCLWFzmoB/44hGHVExFSarbf1AtJlDbcqxfaP8
 WZ2OYO+v0J51Ak4M2cifv0mxZjvOXktmbNwL0c/LpILoYwiXTz33ftnCY+0cQ7nnfX
 +xjnhtYVELQkdSEx0Xan28v3E8/qjgSrJdpJ1juScTzXihxO6etacVLyHxMWQYSdff
 H2SJ9/FKuCqu+TQmu28Wq7EcHQkqslLK1KWLxn8JM9/JjhiArbXN2siPh0FIXFLM3b
 qy3I37UmOv4Bg==
Message-ID: <sashiko-outbox-162409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/9] vfio/pci: Un-revoke DMABUFs in
 LOW_POWER_ENTRY_WITH_WAKEUP resume
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20261006193643.76330-3-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-3-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:45:32 +0000
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

> VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP correctly revokes
> DMABUFs on entry and, when paired with a
> VFIO_DEVICE_FEATURE_LOW_POWER_EXIT, vfio_pci_runtime_pm_exit()
> correctly un-revokes them.
>=20
> However, when vfio_pci_core_runtime_resume() signals the eventfd on
> resume, the bare __vfio_pci_runtime_pm_exit() is used (which does not
> un-revoke).  Add vfio_pci_dma_buf_move(false) to the resume path,
> making it similar to vfio_pci_runtime_pm_exit().
>=20
> This also reorders the eventfd signal after the un-revoke and
> __vfio_pci_runtime_pm_exit() to guarantee that woken threads observe
> the new state.
>=20
> Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regio=
ns")
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D2

