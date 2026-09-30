Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DD7CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C4E10E255;
	Wed, 30 Sep 2026 11:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eg1OcjVZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62AF10E255
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:51:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A87460008;
 Wed, 30 Sep 2026 11:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3BA1F000FF;
 Wed, 30 Sep 2026 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769115;
 bh=CPqj88vIa1FSYE/V+HmQ9fVv2jdNmxwDjn22SC7nC5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eg1OcjVZNXx9+od6HdER/J6+vzCzyvz0xzkZQkxDiGpyuYwdC8yrJNe3BUxvH2FFd
 RMIiqzHuxBQ8Ao/sayOewsbmZ9LLt3x6P+lKXweQJe7xQrCRRfVjSwsy9/h/cVoD/4
 nSreX/e+AChIHAs5fz8/4ZOjjq81faMjxrFKKhh2z0H4qqBjpiVKlyPXcMrdLQ+h9v
 JssW/pDHmmeDK7P5PxQyjU+AKIvTsYQXiGtwi22P87yfv/Bh0G6606HvygykTjlVeR
 b5Dg3AC5QB6efBXGmbzpf5O1Osacpgo5UMLF0Rd/BP8TnzobEUXFM0gyknzFgK6uf5
 lXoICK4Klo7HA==
Date: Wed, 30 Sep 2026 12:52:25 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 2/8] misc/arm-cla: Add launch operation helpers
Message-ID: <20260930115225.GB480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-3-ryan.roberts@arm.com>
 <20260717110108.B6F881F00A3E@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717110108.B6F881F00A3E@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 11:01:07AM +0000, sashiko-bot@kernel.org wrote:
> > +	/* 1 to 8 registers accessed at a time, within the same 8-reg group */
> > +	while (nregs > 0) {
> > +		unsigned int reg_group = ALIGN_DOWN(regidx, 8);
> > +		unsigned int max_reg = min(regidx + nregs, reg_group + 8);
> 
> [Severity: High]
> Can reg_group + 8 overflow? Since regidx and reg_group are 32-bit unsigned
> integers, if a caller passes a register index near the 32-bit maximum
> (for example, 0xFFFFFFF8) and a small nregs value, reg_group + 8 will wrap
> around to 0.
> 
> If max_reg evaluates to 0, ndata becomes 0 - regidx, which can yield a value
> larger than the original nregs. Will this cause out-of-bounds memory accesses
> on the regs buffer when passed to cla_op_launch(), and an infinite loop due to
> underflowing nregs?

We do need to be careful about regidx overflow since all 32 bits are
valid in CLA (custom accel range is 0x00100000-0xffffffff). I'll make
it u64 in this function
