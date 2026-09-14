Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DABC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E207D10E038;
	Mon, 14 Sep 2026 08:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GEXTiDgB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9956910E038
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:58:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 476F943923;
 Mon, 14 Sep 2026 08:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BF61F000FF;
 Mon, 14 Sep 2026 08:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789376285;
 bh=jwUx0q1SeIC+p2pIPrYTvour3tJcjxy6b3KhpkLF/Zk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GEXTiDgBcpKIFn9GkrGIVIcKjTvZRQwvZ3KGEGDEmj9ilBqfl8pTcOuq2myLCK+i7
 BGDFhYn0yeKbmEFpgMNv9df06qFRKXYEm60j89Cc5Y44FQ1a9tHRIYHlE3BekCU1jV
 COycwge4phKIijKXAdcw7Qtn6QtYml08xxKJf2DrBQBsgT7hZCZF1QZf5qQLsH1u7f
 zXqt+l+zuTiwHcZEuBYVzHVVTfDiIWkHrSMB8Ol00foCBz8JNqqxa1XaGF9eWNCX2e
 +S5bwsF2lOf4huqtVGTeJK7ckzbE8GRsTseXlNH8zG4xazy9DbyPQVgHeDSThKWhmM
 ZR64/vtRWsvtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/ivpu: Use separate flag for job timeout
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
References: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:58:04 +0000
Message-Id: <20260914085805.09BF61F000FF@smtp.kernel.org>
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
- [High] Lockless `xa_load` without RCU read lock and RCU-deferred freeing =
leads to a potential Use-After-Free of `file_priv`.
--

commit 267f0542c58f023dad2c373ec173ea2fa96d1b24
Author: Jakub Pawlak <jakub.pawlak@intel.com>

accel/ivpu: Use separate flag for job timeout
   =20
Use separate flag to mark a job timeout as a reason
of starting context_abort_work. This allows to distinguish
engine reset reason and clearly adjust reset procedure flow.

> diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
> index 41efd8985fa67..b2025274f91de 100644
> --- a/drivers/accel/ivpu/ivpu_mmu.c
> +++ b/drivers/accel/ivpu/ivpu_mmu.c
[ ... ]
> @@ -964,7 +964,6 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vd=
ev)
>  		file_priv =3D xa_load(&vdev->context_xa, ssid);
>  		if (file_priv) {
>  			if (!READ_ONCE(file_priv->has_mmu_faults)) {
> -				atomic_set(&vdev->faults_detected, 1);
>  				ivpu_mmu_dump_event(vdev, event);
>  				WRITE_ONCE(file_priv->has_mmu_faults, true);
>  			}

[Severity: High]
This is a pre-existing issue, but is it possible for file_priv to be freed
concurrently while it is being accessed here?

xa_load() internally acquires and releases rcu_read_lock(), so the returned
file_priv pointer is unprotected once xa_load() returns.=20

If a userspace application triggers an MMU fault and immediately closes the
file descriptor, could ivpu_postclose() drop the last reference and invoke
file_priv_release() before the hardware event queue is processed?

If file_priv_release() erases the entry from the xarray via xa_erase_irq()
and frees it synchronously via kfree(), does this lead to a use-after-free
when ivpu_mmu_irq_evtq_handler() subsequently accesses=20
file_priv->has_mmu_faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914084301.8940=
28-1-karol.wachowski@linux.intel.com?part=3D1
