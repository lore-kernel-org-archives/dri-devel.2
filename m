Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AB0CD98DE
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1763410EC89;
	Thu, 18 Jun 2026 05:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G5XTgIxl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A03910EC89
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E71F60008
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C78F1F000E9;
 Thu, 18 Jun 2026 05:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781759712;
 bh=c89PiQ/mO1wb9bqJG3k4eZG9U3X0hkAsK484DLR/aMs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G5XTgIxlAzZYX3ZfxGXNZ+3PYlxg5JrQ3kIcMvklkPnHPc7YQ/+wn19VqBMuTTNpe
 fD7FD2RZImkspX2Eq38YfVOzoSlkMVFPOc+Yods/046lk40lpMmJGpXN10WYTrh7WO
 OeB9hdpaP8dOJFr0HLcSjjSqJXyISlSaUW1iXytcLozfYd77OjNI6T9p+VfVxXOSh+
 aNujPAoj6MLcEbzmdWbTEyfLWSZNI0fa5azWmUGPgKitbqdHM+zfjorXv/rYafg4Cj
 WvDGgzTTk8z/w6BM50BeXu3OOPNg+L4loS2JbN4GxbTNTOOkAt6aIPOqcmb0tqPaIA
 OKJ3unfq9NcLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
To: "Linus Walleij" <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org,
 vkoul@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:15:12 +0000
Message-Id: <20260618051512.5C78F1F000E9@smtp.kernel.org>
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
- [High] Calling pm_runtime_get_sync() and pm_runtime_put_sync_suspend() on=
 `lcla_dev` from the DMA hardirq handler causes a 'sleeping in atomic conte=
xt' bug.
--

commit faf19ae1be6f68a94634761ce6a55206f7f124da
Author: Linus Walleij <linusw@kernel.org>

regulator: db8500-prcmu: Remove EPOD regulators

Remove the obsolete DB8500 PRCMU regulator drivers.

> Drop the regulator build hooks now that EPODs are power domains.

[Severity: High]
This isn't a bug introduced by this patch, but since the EPODs are now power
domains, is it safe to use them from atomic contexts?

An earlier patch in this series transitioned the LCLA SRAM to use power
domains, but the DMA interrupt handler d40_handle_interrupt() acquires
spinlocks (base->interrupt_lock and d40c->lock) before taking this path:

d40_handle_interrupt()
  dma_tc_handle()
    d40_queue_start()
      d40_transfer_runtime_get()
        pm_runtime_get_sync(base->lcla_dev)
     =20
      d40_transfer_runtime_put()
        pm_runtime_put_sync_suspend(base->lcla_dev)

Because base->lcla_dev is tied to the ESRAM34 generic PM domain and is not
marked IRQ-safe (GENPD_FLAG_IRQ_SAFE), its callbacks are invoked, leading
to sleeping operations while holding spinlocks:

pd_power_off()
  guard(mutex)(&ux500_pd_lock)
  db8500_prcmu_set_epod()
    mutex_lock(&mb2_transfer.lock)

Could this lead to scheduling while atomic bugs and deadlocks?

> Keep the MFD cell around because a later patch reuses it for a
> small compatibility regulator driver.
>=20
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D9
