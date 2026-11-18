Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F3606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTMNTFi4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFC910E637;
	Wed, 18 Nov 2026 07:41:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB8810E637
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:41:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A94C860DE7;
 Wed, 18 Nov 2026 07:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CA81F000C5;
 Wed, 18 Nov 2026 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794987665;
 bh=Oo1MKewcFNXxeSMzmTcVUalvGTXEFHTTVSAG1Jzyvh4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XTMNTFi4iPKhmtpnlHDTs6jihpXTRh7UDC1Gyswg0Q+Q/wiqZBXdAmhxJLpx+cKrn
 4zGdITOBlaNcvNJQze6kP63dkuOxvkLHS3f5TmpaR43ft9eWeecNG1lQBMxjXrS3Y2
 C/Xm32eqNNZPDfV1YZepY9FNe6goZaJo4L7vFo9dadWarlJ4C220yKpPZq/Jux5BAd
 tK5FIqdu4qNR7k8d7TKzPGnX2bHInONSuG1aliQEMoTh0PfcgOuruzGAXLRDlfgaen
 27rtbxdpzoS7H0Wdxp6gNUrhofSblfye62RuNo4tIi8JO4u8MzUAhaC0Qc0dp6DwOg
 y2otnm5zWLzNw==
Message-ID: <sashiko-outbox-220324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/qaic: drain the control workqueue before the
 device is freed
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118072448.1259909-1-shunsheng1218@gmail.com>
References: <20261118072448.1259909-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:41:04 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] accel/qaic: Fixes trailer cites c501ca23a6a3 instead of
  22ec9a3b73dd
--

commit 4e36def68e52df8a1a1cb9f08c76e856b9e13fb0
Author: Yaohan Li <shunsheng1218@gmail.com>

> accel/qaic: drain the control workqueue before the device is freed
>
> qaic_pci_remove() tears the MHI controller down and destroys the DRM
> device, but nothing drains qdev->cntl_wq.  qdev itself is allocated with
> devm_kzalloc_flex() and is freed as soon as the PCI device is unbound,
> while cntl_wq is a DRM-managed resource that survives until the last
> open file drops its reference to the DRM device.
>
> resp_work is queued from qaic_mhi_dl_xfer_cb() and resp_worker()
> dereferences qdev, so a work item that is still queued, or still
> running, when the driver instance goes away touches freed memory.
>
> mhi_power_down() moves the controller to the shutdown state, disables
> the interrupt and flushes the state worker that destroys the channel
> devices, and mhi_unregister_controller() removes the controller, so no
> data event can reach qaic_mhi_dl_xfer_cb() once
> qaic_mhi_free_controller() has returned.  Flushing the workqueue after
> it therefore covers every work item that can still be queued.
>
> Fixes: c501ca23a6a3 ("accel/qaic: Add uapi and core driver file")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

[Severity: Low]
In c501ca23a6a3 ("accel/qaic: Add uapi and core driver file"),
qaic_pci_remove() called cleanup_qdev(), which destroyed qdev->cntl_wq
synchronously via destroy_workqueue() before qdev was freed.  The
lifetime mismatch was introduced in 22ec9a3b73dd ("accel/qaic: Leverage
DRM managed APIs to release resources"), which switched qdev->cntl_wq to
qaicm_wq_init() and dropped cleanup_qdev() from qaic_pci_remove().

Should the Fixes tag reference that commit instead:

  Fixes: 22ec9a3b73dd ("accel/qaic: Leverage DRM managed APIs to release re=
sources")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118072448.1259=
909-1-shunsheng1218@gmail.com?part=3D1
