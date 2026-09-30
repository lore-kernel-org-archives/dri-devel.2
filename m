Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39E4CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D64110F333;
	Wed, 30 Sep 2026 11:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OFh8VXYj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D2310F333
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:54:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F27A343B1B;
 Wed, 30 Sep 2026 11:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCBD1F00898;
 Wed, 30 Sep 2026 11:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769264;
 bh=cIeqxL+8GrMb29vk5fax6n5NaOMIRALmJeUEwFX8BUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OFh8VXYjAGZuGXJ0qzn2nAQKU8SaLRuNtNpXazP3Hgyl5jSbG0B8Q3vx3qboZOnpJ
 OobS75cYZMPIPTArYdJFwC/zJzAKqZJ2vuPuUf6tmDL7EnZLC+2UP+TcfNcpReHWnk
 +CTHRhrDl4Hi+h3NQbRZIu2nsegA3qKwf+Ag/mfqo36SJ+7RYKis6t2fo/WgsM+tg7
 CadscLQ4qwtsjBeCaA1Qde7f1eeoo1l+AiZFgyWXTY8S1WbT7an8ER+BU/2gbi3wUJ
 x7XaYZ8iCAbJod5nxAGQICzNOjOdiJJluyCXiJgT8Nma86nBFapMR6nY/9kU3bifWv
 V76bAMoHQ1e5g==
Date: Wed, 30 Sep 2026 12:54:55 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 4/8] misc/arm-cla: Initialize devices on CPU bringup
Message-ID: <20260930115455.GD480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-5-ryan.roberts@arm.com>
 <20260717105847.93A7E1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717105847.93A7E1F000E9@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 10:58:47AM +0000, sashiko-bot@kernel.org wrote:
> > +	reg = FIELD_PREP(CLA_TSOFFOWNER_PL, cla_kernel_pl);
> > +	ret = cla_op_regread(dev, accid, CLA_REG_TSOFFOWNER, 1, &reg);
> 
> [Severity: Medium]
> Does this code mistakenly call cla_op_regread() instead of cla_op_regwrite()
> here in cla_reset_ts()? Doing so will clobber the newly prepared configuration
> value with the current hardware state, meaning the kernel fails to claim
> ownership of the TSOFFOWNER register. This could cause the subsequent writes
> to CLA_REG_TSVOFF and CLA_REG_TSPOFF to be ignored.

Yes


> > +	if (!ret) {
> > +		reg = 0;
> > +		ret = cla_op_regwrite(dev, accid, CLA_REG_TSVOFF, 1, &reg);
> [ ... ]
> > +static int cla_dev_setup(unsigned int cpu)
> > +{
> [ ... ]
> > +	/* Clear DATA and LRESP_DATANZ */
> > +	for (i = 0; i < CLA_NUM_DATA_REGS; i++)
> > +		cla_reg_write(dev, CLA_REG_DATA(i), 0);
> 
> [Severity: Medium]
> The comment above indicates this should clear DATA and LRESP_DATANZ, but is
> there a missing cla_reg_write() for CLA_REG_LRESP here in cla_dev_setup()? If
> left uncleared, stale response data from before the CPU was offlined might
> remain and confuse userspace or the driver later.

No, DATANZ is tied to DATA


> > +
> > +	/*
> > +	 * Reset all accelerators. We restrict PLxCTRL to the accelerators that
> > +	 * are attached and well behaved.
> > +	 */
> > +	for (accid = 0; accid < CLA_NUM_ACC; accid++) {
> > +		ret = cla_dev_setup_accel(dev, accid);
> > +		if (ret > 0)
> > +			continue;
> > +		else if (ret < 0)
> > +			goto err;
> > +
> > +		dev->accelerators |= (1 << accid);
> 
> [Severity: Medium]
> Could this accumulate stale state across CPU hotplug events?
> 
> Because dev->accelerators is never explicitly cleared to 0 at the start of
> cla_dev_setup() or during teardown, if a CPU is offlined and an accelerator
> subsequently fails to probe on the next online event, it will incorrectly
> remain in the dev->accelerators mask.
> 
> During teardown, cla_op_reset_all() might then attempt to reset a non-existent
> accelerator, fail, and mark the entire device as broken.

The FW does not change the visible accelerators across CPUHP events


> > +int cla_op_reset_all(struct cla_dev *dev)
> > +{
> > +	int ret;
> > +	unsigned int accid;
> > +
> > +	cla_for_each_accid(dev, accid) {
> > +		ret = cla_op_reset(dev, accid);
> > +		if (ret)
> > +			return ret < 0 ? ret : -ENODEV;
> 
> [Severity: High]
> Does returning immediately on the first error leave the remaining attached
> accelerators running?
> 
> When cla_op_reset_all() is called during CPU teardown, an early abort means
> subsequent accelerators are never quiesced. As the CPU goes offline, these
> active hardware accelerators could continue issuing DMA transactions or raising
> interrupts, posing a risk of memory corruption.

I wouldn't put too much effort into handling HW failures because they
normally don't happen at this level, but finishing the iteration
even in case of failure seems simple enough here.

