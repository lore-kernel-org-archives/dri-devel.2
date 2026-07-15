Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BFAC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE4010EDB4;
	Wed, 15 Jul 2026 18:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZK0eSJpU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546A710EDB4
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:01:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 99FD36187A;
 Wed, 15 Jul 2026 18:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD9A1F00A3A;
 Wed, 15 Jul 2026 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784138485;
 bh=dp9YY2Z2mvKIeuvrp9uZXt7NbkRfiOtNxQLNn6A9MdE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZK0eSJpUPToOXhCY8/Rpz7wEn32k7qxiUE91xyhp9bpqKZtf/VmI8LoC3CKk/KGM1
 pph8gdGB4MoXrzQfw0dSEfA0rirvW1aCHVw+RNZC7xAuuzL2ynsiOunHnMFuZeudMH
 SsMU7UOJ9XDnVGqKcU+PxRj4sVK1NhV8FIlmfSNiytDEC0HLZ6am9YIiZe6MGWJOdY
 CDrVIPbx4+XnNtTbgzsDgoP82v8fGktbLsu+sEYBgL6g1hSXkEQO5ivebtKUGBDsUT
 m4oZJVtn+F3c9qB2hRFRP6eS9eTXSAetqJhTMyW4t+KH2Mm2gc9604XfH7D478raCe
 FSEEw0861KD6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] vfio/pci: Provide a user-facing name for BAR
 mappings
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260715174737.15287-7-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-7-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:01:24 +0000
Message-Id: <20260715180125.0AD9A1F00A3A@smtp.kernel.org>
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

> Since converting BAR mmap()s to using DMABUFs, we lose the original
> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
>=20
> This applies only to BAR mappings via the VFIO device fd, as
> explicitly-exported DMABUFs are named by userspace via the
> DMA_BUF_SET_NAME ioctl.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D6

