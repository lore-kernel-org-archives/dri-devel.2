Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78F0CA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EBB10FB23;
	Thu,  8 Oct 2026 19:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="r13YZpHg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202B410FB23
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=0pAmSkx/IkCTjnV05jW/ucJc7NU/LDqoXPGS7Bhh430=; b=r13YZpHgTWDy8YH++bKT7DZKz3
 5kg0zkMrrM+ni+z1NFgdidlLCfBjyS9cFBfawAHjVQyhc4OVd8giIj0CXpQg3sBpPW9qDFTUVFtL2
 WeVJCCiQvVQlb/GkX0sssbWFWVoj5aNO6YrCUM73ISRNeKD9FO5+aageIKg4C6e6quVLRhM63ljyp
 tNmYwLaFy+1vB04sigks6sIjowRIxDaKueo5hOUVULO7D9mv2JYojPqO75RBpWKxfJX4AzXiFhCX3
 NH07IHeaIFqKRHrTmfMssVH6GpTZ9q1Giu135w/iKKzDDlNInT36rrpr+ioP35GQh+kpQaNCf6JvY
 PVaw9D7Q==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xEtp1-00EcnV-72; Thu, 08 Oct 2026 21:30:31 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] drm/vc4: Disable the V3D interrupt across runtime suspend
Date: Thu,  8 Oct 2026 16:29:47 -0300
Message-ID: <179148775854.3140809.7760119335243213315.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925191318.541938-1-mcanal@igalia.com>
References: <20260925191318.541938-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Fri, 25 Sep 2026 16:10:19 -0300, Maíra Canal wrote:
> vc4_irq_disable() masks the V3D interrupt sources and then calls
> synchronize_irq() before the V3D is powered down. However, by itself,
> this is not enough to quiesce the interrupt handler.
> 
> synchronize_irq() waits for handlers that have already set
> IRQD_IRQ_INPROGRESS, and for irqchips reporting IRQCHIP_STATE_ACTIVE.
> A GIC interrupt chip is able to mark an interrupt active as soon as a
> CPU acknowledges it, so there these checks cover the whole dispatch path.
> On RPi 0-3, however, the interrupt controller is ARMCTRL, which has no
> active state. A CPU that has read the hwirq out of the pending register
> but has not yet reached handle_level_irq() stays invisible to
> synchronize_irq().
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Disable the V3D interrupt across runtime suspend
      commit: 6abc8e4dcfbc1d26a94c0ac037dfb3716f686b1f

Best regards,
- Maíra
