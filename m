Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F09CD5BCF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A8D10E071;
	Mon, 25 May 2026 08:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="njjuR/c4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD45910E071
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779699354; x=1811235354;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QDVlHkaJzd1yhCNccg0oJiSTSQUYqwHGcctnwRzp9hY=;
 b=njjuR/c45goQgObIEkONMk1GF73NqfGHRIkUYGs+y3vXgnnVbQqXR1H0
 mggtZh9c0X7QMAt6uzy0Ku7ZayvPAChcDvEk8u1+MDb7gam03xz32VzIY
 gAUiqI8J25i6X/Z0BQ6c1RijLZTdp0DiPqpI5xBuE6aGc+EJZS7mf5WSI
 pBzBSqEz/UYBhfxfGFyXsg7UtRxjZTwarP/pp5usB+xwK5ZBPZKu5q8ZI
 iKC1nx89w3HSSeWBmuoJRaHqHv/BZXBP7H+oepXXsfgKXvTYxlP4VbPBl
 1hES/44SAoeT5QaND/FWtG79U5usAM5Y9BJg6VWShrCS5xwjdbKMGVosq w==;
X-CSE-ConnectionGUID: JLiNOKhaRVyd1jCMa2+i2w==
X-CSE-MsgGUID: a1XzJBRSSpmMa+ItRqfbCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91627077"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="91627077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:55:51 -0700
X-CSE-ConnectionGUID: Bknsz68oR+KLd8gP4UuJog==
X-CSE-MsgGUID: ZUe6382PRmebDTDU7tSw+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="237129261"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.200])
 ([10.245.245.200])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:55:47 -0700
Message-ID: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
Date: Mon, 25 May 2026 10:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable and
 timer callback
To: w15303746062 <w15303746062@163.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
 <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
 <2026051633-skyward-parrot-cdd3@gregkh>
 <397754a7.224c.19e38e42006.Coremail.w15303746062@163.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <397754a7.224c.19e38e42006.Coremail.w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Mingyu

Den 2026-05-18 kl. 04:22, skrev w15303746062:
> 
> 
> At 2026-05-16 17:51:59, "Greg KH" <gregkh@linuxfoundation.org> wrote:
>> There is no "minimal-risk policy for stable trees".  And if there was,
>> the least ammount of risk would be to take the reviewed and tested
>> patches that are already in Linus's tree, and NOT take anything that is
>> not already there, as 90% of the time that we do that, it comes back to
>> bite us hard.
>>
>> So please, just backport all the needed changes here.  Otherwise how are
>> we going to deal with the merge conflicts for the next 4 years in this
>> file?
>>
>> Or, get the maintainers of this file to agree and review this one-off
>> change that it is acceptable.  As they are going to be the ones getting
>> the bug reports and not having their patches applied over the years, not
>> anyone else :)
> 
> Hi Greg,
> 
> Got it. After looking deeper into the dependency chain, backporting the mainline commit (02e2681ffe1a) would indeed require pulling in the entire new DRM generic vblank timer infrastructure to 6.18.y. 
> 
> That scope is just too large and complex for this specific issue. Since a one-off patch is not the right approach either, I will just drop this patch and abandon the backport effort for 6.18.y.
> 
> Thanks for your time and the quick review.
> 
> Thanks,
> Mingyu
> 

As far as I can tell, if it's just a bug affecting vkms, all you need to do
is only a few commits:

74afeb812850 ("drm/vblank: Add vblank timer")
d54dbb5963bd ("drm/vblank: Add CRTC helpers for simple use cases")
02e2681ffe1a ("drm/vkms: Convert to DRM's vblank timer")
79ae8510b5b8 ("drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()")
3946d3ba9934 ("drm/vblank: Fix kernel docs for vblank timer")

There's no need to convert all other drivers if it's only vkms that you're fixing.

But since you found this bug in one driver, it might be wise to check if others
have the same bug and ask for backports for those too.

Kind regards,
~Maarten Lankhorst
