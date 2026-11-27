Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB0606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9EzPvb8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1EC10E00E;
	Fri, 27 Nov 2026 03:58:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3002210E00E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 03:58:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 672AA60008;
 Fri, 27 Nov 2026 03:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD141F000C1;
 Fri, 27 Nov 2026 03:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795751922;
 bh=iowtpXFui0asVnKSuOWy+UPTAbvhmczn/w43LCEGF/E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l9EzPvb819aT2sapsMFYwuyzVwOEDlOS3VqVBiW2CWdFlCY5VekOn/jH3aXh+/kXc
 ofKAFgDTzPyirOOkXhRgcFfBDkM16K9z5bk/PUS6wWFdif1sNY91TUqyNFjIvQZBGc
 wyevBjwtOrxCIMVmc7A7V/mx0v/5udLeVCy1x4YGTP0SyAmZuuovOQ/NJjj0VOTYBt
 C8Lo6o5CeNFPAHf3H+BU6urjOHCICEqVSxm9JjNI9N+c19lmlK5JCU4+v9uRht5PBe
 ikLiZ4BgJnQmDF2gohQ1qN0PoF3JCpx4cryH4zgoNlAya62X+55c77zB228JtJPVyC
 P4iqus9kiFPGQ==
Message-ID: <sashiko-outbox-236569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/imagination: re-check firmware idle state before
 runtime suspend
To: "Baihui Liang" <liangbaihui@linux.spacemit.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-img-pm-autosuspend-v3-1-3a65ee22d9b2@linux.spacemit.com>
References: <20261127-img-pm-autosuspend-v3-1-3a65ee22d9b2@linux.spacemit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 03:58:42 +0000
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
- [Low] drm/imagination: missing Fixes trailer on runtime PM idle
  rejection fix
--

commit c29dc1db48c5cba60c84fc26290cdb68ebfc286c
Author: Baihui Liang <liangbaihui@linux.spacemit.com>

> drm/imagination: re-check firmware idle state before runtime suspend
>
> pvr_power_device_idle() rejects runtime suspend while the firmware
> hasn't reached ROGUE_FWIF_POW_IDLE. The PM core doesn't reschedule
> idle notification after rejection, so no further pm_runtime_put()
> arrives on an idle GPU and the device stays powered indefinitely.
>
> Move the idle check into pvr_power_device_suspend() and return -EBUSY
> after pm_runtime_mark_last_busy() so the PM core reschedules the
> autosuspend timer and retries until the firmware is idle.
>
> Factor the power-off sequence into a helper and call it from the
> removal path with runtime PM disabled, bypassing the idle check.
> Power off before destroying the job and free-list ID arrays, since
> the IRQ handler can still process firmware commands during shutdown
> and look up free-list IDs.
>
> Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>

[Severity: Low]
This fixes a bug where rejecting runtime idle in pvr_power_device_idle()
prevents the GPU from autosuspending.  Should this include:

  Fixes: 727538a4bbff ("drm/imagination: Implement power management")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-img-pm-aut=
osuspend-v3-1-3a65ee22d9b2@linux.spacemit.com?part=3D1
