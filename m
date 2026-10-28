Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB664606A321
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JaiWIoBm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD5B10FBA7;
	Wed, 28 Oct 2026 11:39:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE5E10FBB2;
 Wed, 28 Oct 2026 11:39:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 367AB40A05;
 Wed, 28 Oct 2026 11:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBC31F031E0;
 Wed, 28 Oct 2026 11:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793187558;
 bh=n7EyN63YMbsGSuXorcATqKgLRCoyblrPSFRBEfcKo4s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JaiWIoBm55p1NwsB+vy+ilIpUD7pwPvzI1ksLV9662wlW7H8On6YGTVC1i0+Xrk84
 k5W/ilarBdyIN/yCEmIWVB2gmMJRNiRZolia5EG34pbKBnltzQHPVApqo9j5WJgTqH
 KWRZOdc+BCiaiNjLFcRDdMVXVC9h206K82s4w/d6UMEYkdahRTAIK8U+M2R6g5ZlgL
 1rCIVXl9OztEjx91lyOhnsiVD0Aq4/aml4oVdS18wwr9XzcO/DaqLMm4VQm0ljLNWH
 hVnQtTELWGx7ZCnaK+Q8z3vN5iIcaFh0Vxqdw9NIljvI8th3utNplBmYmtvIC/5cDo
 Ps+l6n6ItFjNg==
Date: Wed, 28 Oct 2026 12:39:14 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: yaolu@kylinos.cn
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net, simona@ffwll.ch,
 chris@chris-wilson.co.uk, 
 lionel.g.landwerlin@intel.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gem: Reset err for each fence entry
Message-ID: <auHeqGZ-hm2lS7Nk@zenone.zhora.eu>
References: <20261027072832.726435-1-yaolu@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027072832.726435-1-yaolu@kylinos.cn>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Lu,

On Tue, Oct 27, 2026 at 03:28:32PM +0800, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> If dma_fence_chain_find_seqno() failed once, 'err' will store val in
> the following loop. May causing returns '-EINVAL' even though that
> entry never called dma_fence_chain_find_seqno() at all.
> 
> Fixes: 13149e8bafc4 ("drm/i915: add syncobj timeline support")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>

pushed to drm-intel-gt-next.

Thanks,
Andi
