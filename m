Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FCAC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06FD10F674;
	Fri, 26 Jun 2026 15:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DNiiWP2w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAD210F674;
 Fri, 26 Jun 2026 15:55:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D45B942AA3;
 Fri, 26 Jun 2026 15:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A308A1F000E9;
 Fri, 26 Jun 2026 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782489348;
 bh=Lt3tIKxtEx/sDzO3B7esFu3Va+TQBS4M1CpL1nTybC8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DNiiWP2w6O6UpV4pL6ppSFUUOkrp/+SmyET7gFVAI40Sup6ibneK9wJIMcQFZ4+9S
 MT5kr1/t8Xk7hCZK+YynXYvv6dINpcu8pjC4nA8UrHPfkzAWNAIo5XOLQe3oYzaaxT
 dIOAvAPgMZWRFr6E0P+P0doZ04TujQlnqmGYRs+OvqosaCFZ+0HE/5/IMnDi18qvr/
 C5mwhPaAxx7dWNYY9YWqpq5/vCEcg4X8yI/oAJpA0fAk78vGm/3GUsjoRMPE4IcAGs
 2EwGmGdAhwZ2jVRIbPhypDueVgAaE6vT61SPcNDUanqiWtAQDzjt+DIoy+yHR2V2my
 SmADq/kWNjMaA==
Date: Fri, 26 Jun 2026 17:55:43 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/i915/gt: Return bool values from a boolean helper
Message-ID: <aj6g3ZDfaCzdS2Iy@zenone.zhora.eu>
References: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
 <aj1HzUjokwiZCk7T@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj1HzUjokwiZCk7T@black.igk.intel.com>
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

Hi Raag,

> > diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
> > index b2cf672564dd..a3f198646e1d 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_reset.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_reset.c
> > @@ -797,9 +797,9 @@ static int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask
> >  bool intel_has_gpu_reset(const struct intel_gt *gt)
> >  {
> >  	if (!gt->i915->params.reset)
> > -		return NULL;
> > +		return false;
> 
> I know the logic remains the same but isn't this Fixes material?

I don't think it's necessary, returning NULL instead of false
doesn't trigger any failure.

Thanks,
Andi
