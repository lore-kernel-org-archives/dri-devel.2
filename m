Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69440C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 22:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC2C10E321;
	Mon, 24 Aug 2026 22:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fVo5f0n1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA77710E321
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 22:06:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80115406A5;
 Mon, 24 Aug 2026 22:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236041F00A3D;
 Mon, 24 Aug 2026 22:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787609215;
 bh=y9+kKSxDZd8QazKfr4Wfg2Gi9MQ6P0jGZWYgREczVCo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fVo5f0n1IjtXZGzAAHdw0YsQwjSWLdkI1Ur4sQu/Y+eSbKvqP5L9w4Nx+DXKJVLxb
 122hE8RjWXNdHxip3r64ERk+xj9/D1yK087VWe2kN3R6jTrbbx5Kg92c6maNm9JBfO
 GPQQC5T56IIGz2bzhskXV3MeDiaEYQh+V91dMmndOJECxP2iK6txrWrh9hEt2sCFbM
 YWO8wUp3gVt+K9CqjPMKhkuL9Elt+tfZzyEKbOpIFznxaELEa/tiREB82f2IWL4MgJ
 62wBA/iENSVID7KIz76aIduJpCxsRGu401ZJDJnzbaurg9rGmqCtHJSQJ6W5caQvhs
 UcZPBEUyS5i2Q==
Date: Mon, 24 Aug 2026 17:06:54 -0500
From: Rob Herring <robh@kernel.org>
To: GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/5] accel/ethosu: fix scheduler and IRQ lifetime
Message-ID: <20260824220654.GD50486-robh@kernel.org>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-3-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717061145.1478139-3-zhaoguohan@kylinos.cn>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Jul 17, 2026 at 02:11:42PM +0800, GuoHan Zhao wrote:
> ethosu_job_init() requests the managed IRQ before initializing the DRM
> scheduler. If drm_sched_init() fails, the error path calls drm_sched_fini()
> on a partially initialized scheduler. The IRQ also remains registered until
> devres cleanup after normal or probe-error paths destroy the scheduler.
> 
> Initialize the scheduler before requesting the IRQ. Scheduler setup failure
> then needs no teardown, while IRQ setup failure can tear down a valid
> scheduler. Free the IRQ explicitly before drm_sched_fini() to prevent
> interrupt handlers from accessing scheduler state during teardown.

I don't think there's an actual issue here. The interrupt is never going 
to fire unless probe successfully completes because we reset the h/w and 
the interrupt only fires if we schedule something on it.

Rob
