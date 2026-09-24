Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A203C98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BD310F673;
	Thu, 24 Sep 2026 15:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WX42Pfsh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C4710F673
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:30:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E98C041AB9;
 Thu, 24 Sep 2026 15:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14A51F00898;
 Thu, 24 Sep 2026 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790263838;
 bh=pDJlwOw2+JDo0jiD4ycltwPcw+aS30nwU3cZNN/8HPc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WX42PfshhZcJ992CNtnwqkAi6ujawXM4bbq46VXTvbT3XgC1q9m1V8yHMGVdf56X4
 pBATuBqTgbmvPAyB6b9nbX8oac4nq/MzyNR5BSYTmv//QqA0UiUFXqOVYWH+V2WvKf
 I9z/vW4LJbOFjQqK0m9xMSx3XZp/8OOzAklEQs8EIi7nmme68Gq23PfxLCMtIRcloc
 Dks1ftEeFbr4ntWgb5acf7twfht6CNH3uTqUsbt59VI6dro7moO/kuvkiPMgmWoWHT
 m8PtxfWL2dfk7vevT8FVGWL1s/N9TVlN1jnrfSUHbwSb9KRYJGEU7oKPMyC5ghNgHl
 9/zVxz49mFzCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] vfio/pci: Un-revoke DMABUFs in
 LOW_POWER_ENTRY_WITH_WAKEUP resume
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260924152159.49702-3-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-3-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:30:38 +0000
Message-Id: <20260924153038.A14A51F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D2

