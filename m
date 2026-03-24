Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C19FEC0FA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C221010E5D9;
	Tue, 24 Mar 2026 19:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VIobglsX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6BAF10E485;
 Tue, 24 Mar 2026 19:34:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 837E3400DD;
 Tue, 24 Mar 2026 19:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47733C19424;
 Tue, 24 Mar 2026 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774380887;
 bh=R8I4mdhtlC1Y2rsYo7HXdjeN+ixJqbw10kbyE8reKig=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=VIobglsXliT085fJ7tTtsNbvortGGRFcanYJOJ5yzPvJxjzlAKbDvW7Bnlc1rRVo5
 /NP01GkFOWl+pJnNxtZIaNau+od5syO0Aw+9yMOF0D4tqV9Yxvo3bBhKHi9VOCpQyy
 vGKjr1KhPobO6upQAfkAOM0/BE5jn1hG/clWZWOj2HcDtY3AYmWLW+mqTzfhZSvAqU
 doz33itB2g0+Yu9IlbfX1dyT+qsGsvGf1WknWCrbc1qtp3tqRXGi1VvsH59uLiZ4eO
 Hdpa2re8nrpody5agAj/EmDko203caTcAPlOdvP6Lcy0X0aWQKyCrFqnEEMwxi1NVi
 VlXS3mEPOHyEg==
Date: Tue, 24 Mar 2026 14:34:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/5] Bridges without VGA support
Message-ID: <20260324193445.GA1149183@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307173538.763188-1-Simon.Richter@hogyros.de>
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

On Sun, Mar 08, 2026 at 02:35:33AM +0900, Simon Richter wrote:
> Hi,
> 
> reformatted the descriptions to follow the style guide, removed unlikely()
> from return code checks.
> 
> Companion patch for i915/xe is v3 of
> 
>   https://patchwork.freedesktop.org/series/161721/
> 
> which can be applied independently and should probably go in before the
> __must_check patches at least.
> 
> Not sure if these should have a Cc stable. If yes, there is a backport of
> the i915/xe patch as well (what patchwork calls "v4").
> 
> Simon Richter (5):
>   vgaarb: pass vga_get_uninterruptible() errors to userspace
>   vgaarb: pass errors from pci_set_vga_state() up
>   vgaarb: mark vga_get() and wrappers as __must_check
>   pci: check if VGA decoding was really activated
>   pci: mark pci_set_vga_state() as __must_check
> 
>  drivers/pci/pci.c      |  6 ++++++
>  drivers/pci/vgaarb.c   | 20 +++++++++++++++++---
>  include/linux/pci.h    |  4 ++--
>  include/linux/vgaarb.h | 15 ++++++++-------
>  4 files changed, 33 insertions(+), 12 deletions(-)

Applied to pci/vga for v7.1, thanks!
