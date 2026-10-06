Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6F4CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 19:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5CD10E3ED;
	Tue,  6 Oct 2026 19:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aBVVRI6b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AAE10E3FD
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 19:45:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E05B3600C8;
 Tue,  6 Oct 2026 19:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E71F0089B;
 Tue,  6 Oct 2026 19:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791315932;
 bh=t8Lbn45G3cGCuNatD1kB2ZtQaalzcgI14SeHJRG/PWA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aBVVRI6bP5zGR3M1pEeCXNSrTMEZjtjTWSH9iv1mYtaJmfxM1LL3G2dubqQUIdSj6
 kBhvzOWeJO+BLDx1q8Q1qYNp6SeA1234JxGjsCLEywqhqp0QLxUSmo+S5Cl9urjjVH
 jXLkCQWdjtxEF8bgfG0RvnWeZ/kR2Ln8sDB6JYQIaZLYHGU7pgakV5ZkSemESxooCT
 QMEJdRMthGrKSSDeoRg/R+Jqzai6VsWUpRA1kby2kf/d6LEGkPpleMnDRDxzZBHUP0
 vacjRJmCENxX+gbjf5EZViroKP5LG7CxDiq+AqGk8FM95ZRYzM1FWdAsS8EZSusglo
 xWsryaWaDJUqQ==
Message-ID: <sashiko-outbox-162408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/9] dma-buf: Provide dma_buf_set_name()
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261006193643.76330-4-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-4-matt@ozlabs.org>
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

> Allow exporters to set the name of buffers, during export or for
> subsequent updates.  This is useful to express buffer-specific debug
> information, indicate state particular to the exporter's usage, etc.
> Only exporters and userspace are expected to set names; it isn't
> sensible for importers to do it.
>=20
> Originally, the static dma_buf_set_name() was used for
> DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
> this function as a generic set-name helper, taking a kernel-allocated
> string.  The SET_NAME ioctls now locally duplicate the __user string,
> and use the new function to set the name.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D3

