Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB413CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332DE10F336;
	Wed, 30 Sep 2026 11:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PUdtpM+U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101E510F336
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:55:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49DC360008;
 Wed, 30 Sep 2026 11:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3F51F000FF;
 Wed, 30 Sep 2026 11:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769317;
 bh=5rGXeumqL/3dhE8mLtLARo4yQw8+ruJZLdtQV5Z1dyE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PUdtpM+UtN5wrzQs/FS5fLVHyLZcbIIZwrfmRQ3OJx4yaOnVmQLiLljbXOZ9rai0L
 73K99lOdQMWb5La/+8BOaEIOQuWfylx7E44wv/69W+FfQQhLbhjcCqpWjCMl64Djb4
 e+B1t6/DiL0fKy3D24+XZ+BKTfocDqjgTjveuzSwZSBbrGkLEbztmlcLiJsdElFR1w
 IYZqYVX6UNHaRFkR6NZgGtcYeV/tn5lsyd/KdPSxRGU2C99s75CKHThl9cZChV8rZ7
 /6ASn0NVRHOEEQKjXljC5Nd7D4dMhF86ttFjWYXr88ICEhplXgjT+DtK8oJ7iGWu5W
 pf3TsrTrpnZhA==
Date: Wed, 30 Sep 2026 12:55:47 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 5/8] misc/arm-cla: Accelerator context save and
 restore
Message-ID: <20260930115547.GE480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-6-ryan.roberts@arm.com>
 <20260717105811.4B1F71F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717105811.4B1F71F000E9@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 10:58:10AM +0000, sashiko-bot@kernel.org wrote:
> > +	regstate_size = FIELD_GET(CLA_SRSTATE_0_REGSTATE, srstate[0]);
> > +	if (WARN_ON(*regstate_off + regstate_size * 8 > dev->iassizes))
> > +		return -ENOSPC;
> 
> [Severity: High]
> Does this bounds check correctly handle the units for *regstate_off?
> 
> *regstate_off is incremented by regstate_size (which is a register count),
> so it is also a register count.
> 
> If dev->iassizes is in bytes, this check improperly adds a register count
> (*regstate_off) to a byte count (regstate_size * 8) and compares it against
> a byte count.

Yes this should be WARN_ON((*regstate_off + regstate_size) * 8 > dev->iassizes)


> > +int cla_regs_switch_out(struct cla_dev *dev, struct cla_regs *regs,
> > +			bool save_regs)
> > +{
> [ ... ]
> > +	if (save_regs) {
> > +		for (i = 0; i < CLA_NUM_DATA_REGS; i++)
> > +			regs->data[i] = cla_reg_read(dev, CLA_REG_DATA(i));
> > +
> > +		cla_for_each_accid(dev, accid) {
> > +			ret = cla_regs_save_accel(dev, accid, regs, &regstate_off);
> > +			if (ret)
> > +				return ret;
> 
> [Severity: Medium]
> If cla_regs_save_accel() fails here, the function returns without clearing
> regs->accel_valid.
> 
> Since regs is allocated once per domain and reused, accel_valid might
> already be true from a previous successful save. Returning an error here
> leaves the structure partially overwritten (a mix of old and new accelerator
> states) but still marked as valid.
> 
> If the caller handles this switch-out failure non-fatally and retries the
> context later, will cla_regs_switch_in() restore this corrupted state to
> the hardware?

Switch-out failure is fatal, requires at least module reload


> > +		}
> > +
> > +		regs->accel_valid = true;
> > +	}
> [ ... ]
> > +struct cla_regs **cla_regs_alloc_domain(struct cla_domain *domain)
> > +{
> [ ... ]
> > +	for (i = 0; i < domain->nr_devs; i++) {
> > +		struct cla_regs *regs;
> > +		struct cla_dev *dev = domain->devs[i];
> > +
> > +		/*
> > +		 * The regs structures are only ever accessed from the CLA
> > +		 * device's CPU, so try to allocate them on the right NUMA node
> > +		 */
> > +		size = sizeof(*regs) + dev->iassizes;
> 
> [Severity: High]
> If dev->iassizes represents a register count rather than a byte count,
> should it be scaled by sizeof(u64) here?

iassizes is a byte count
