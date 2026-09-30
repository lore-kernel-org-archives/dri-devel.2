Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52102CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A277110F32B;
	Wed, 30 Sep 2026 11:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ktgHxXgy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA4F10F32B
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:51:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2734601DE;
 Wed, 30 Sep 2026 11:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70BD1F000FF;
 Wed, 30 Sep 2026 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769089;
 bh=twvCo9F4fQHCiiIQGifl5pTUwb8i7TJL07u4EaKAtrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ktgHxXgya3AUgLBiMWAz4ZqBqUWRUd81EzR39TzRBTYKWy9tV8HJ/YHc0ypkdPNFN
 QWMGTn7P350BPiKnauLylMKCSLenRGXQyBQte4WwU9HpY5qHWRzM/bDBGnHunxDwZV
 koFKqaKIMUVu/81NuLcg9iQIYTpFGZAJ28FafA0IH6LfLQnnjzdFN9r5t9w/9qnNPG
 RreKWBzQ9NzmgBEDWPiugXotn2BjXWkbgdkKcBFk04HvNDiSNtj6S98QnwUbYgFm2F
 +Y3iYFNpndmqqyTxIml5rgYEUKM2j2THaONQ5nUR6AXxbrTwjCfUBbDrYKaOETP0nk
 /heBp9hfuks7w==
Date: Wed, 30 Sep 2026 12:51:59 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 1/8] misc/arm-cla: Add driver skeleton and
 documentation
Message-ID: <20260930115159.GA480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-2-ryan.roberts@arm.com>
 <20260717105637.9FBB61F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717105637.9FBB61F000E9@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 10:56:37AM +0000, sashiko-bot@kernel.org wrote:
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +
> > +/* Registers */
> > +#define CLA_REG_DATA(i)			(0x00 + (8 * (i)))
> [ ... ]
> > +#define CLA_PLxCTRL_AVAIL		BIT(0)
> > +#define CLA_PLxCTRL_DBGPERM		GENMASK(3, 1)
> > +#define CLA_PLxCTRL_PREP(accid, v)	((u64)(v) << (8 * (accid)))
> 
> [Severity: Low]
> Should linux/types.h be included in drivers/misc/arm-cla/arm-cla-regs.h?
> 
> The CLA_PLxCTRL_PREP macro casts the value to u64, but the header doesn't
> include linux/types.h. This could lead to build failures if the header is
> included directly in new source files without prior type inclusions.

linux/types.h gets included, but 4 levels deep starting from
bitfields.h. I'll move the include from arm-cla.h here.


> > +/* Common register offsets */
> > +#define CLA_MTC_PSTATE			0
> > +#define CLA_MTC_TTBR0			1
> > +#define CLA_MTC_TTBR1			2
> > +#define CLA_MTC_TCR			3
> > +#define CLA_MTC_SCTLR			4
> > +#define CLA_MTC_MAIR			5
> > +#define CLA_MTC_TCR2			8
> > +
> > +/* EL2 specific register offsets */
> > +#define CLA_MTC_HCR_EL2			80
> > +#define CLA_MTC_VTTBR_EL2		81
> > +#define CLA_MTC_VTCR_EL2		82
> 
> [Severity: Medium]
> Are these EL2 specific register offsets intended to be relative offsets like the
> common ones (0-8)?
> 
> They are currently defined as absolute indices (80, 81, 82). If the driver
> applies these by adding the base index (e.g., CLA_MTC_REGIDX_PL2, which is 64)
> to the offset, using CLA_MTC_HCR_EL2 (80) would yield an index of 144. This
> would exceed the defined CLA_MTC_PL_SIZE (64) and target the wrong hardware
> address space.

The generic offsets are for both EL1 and EL2. These are differentiated
by their _EL2 suffix. Targetting the EL3 frame or beyond causes
cla_op_setctx() to fail loudly.


> > diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cla.h
> > +struct cla_dev {
> > +	unsigned int cpu;
> > +	struct device *dev;
> > +};
> > +
> > +#define cla_dbg(dev, fmt, ...) \
> > +	dev_dbg((dev)->dev, "[%u] " fmt, (dev)->cpu, ##__VA_ARGS__)
> 
> [Severity: Low]
> Does this header need to include linux/device.h and linux/dev_printk.h?
> 
> The cla_dbg macro uses dev_dbg() and dereferences struct device. Relying on
> implicit inclusions can cause build issues if arm-cla.h is included in
> a different order or in new files.

We include device.h in a later patch. It includes dev_prink.h
