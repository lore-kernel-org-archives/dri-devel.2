Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E928F99C95
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 20:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB9F10E031;
	Sat, 18 Apr 2026 20:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lNq7Vf0q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF5F10E031;
 Sat, 18 Apr 2026 20:43:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 716DD40B0D;
 Sat, 18 Apr 2026 20:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8294BC19424;
 Sat, 18 Apr 2026 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776544994;
 bh=y/wvlviY2ep26rl/rICAKXuCCJlaF96Y446O19jE1Vw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lNq7Vf0qw/0F20NcL1nBMAbzhKn8MPKLaiXV99y/a/upM8s9N/gS4SDgvRVYN6wPS
 GXawJEm1zIiRWmYOol1gXTrSDG275LTi5rffwaWVBO6Fg2PB4ZXTOp/5hc0nBC3OTq
 4pQQ7SwUqUjMWFIY97vUQNi5j73MZCZPLslvJddv5i+qP1dbuQBawGET40JlCbYg7v
 f/MFo2uH3Rg/JVTe6JFKsdAINUOpzfuHPT0Kyb88N09icAA6WTvknMvRIBoAgzdJ58
 y75WgLM9YGhrMNo7CHA8euBklXIFaEPnMYwlXbESZLvgIWEdviGHQnKYgGSRJ28bO6
 kwNnvmBL2lErQ==
Message-ID: <9e835632-0882-4fee-a66c-3cdfec5a410f@kernel.org>
Date: Sat, 18 Apr 2026 22:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/gsp: Fix possible NULL pointer dereference
 warning in r535_dmac_alloc
To: Timur Tabi <ttabi@nvidia.com>
Cc: "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "sunliming@linux.dev" <sunliming@linux.dev>,
 "sunliming@kylinos.cn" <sunliming@kylinos.cn>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>
References: <20260418071412.86022-1-sunliming@linux.dev>
 <DHW9RZVWDN6Y.2G2RKSJMF5ESB@kernel.org>
 <abb12ec2c8d72d6a369ef7b29d0453736a07f90c.camel@nvidia.com>
 <DHWGN6Y2J9X6.3FMWWDU2NQ2LV@kernel.org>
 <f3ea592561af59cf0d677e66a70165e2d7b7edbb.camel@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <f3ea592561af59cf0d677e66a70165e2d7b7edbb.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/18/26 7:44 PM, Timur Tabi wrote:
> On Sat, 2026-04-18 at 19:35 +0200, Danilo Krummrich wrote:
>>> I posted a patch a couple months ago that cleans up an IS_ERR check, but it was never picked
>>> up:
>>
>> Thanks! Can you please make sure to send patches to all maintainers? If they
>> don't land in my inbox, I can't pick them up. :(
> 
> M:  Lyude Paul <lyude@redhat.com>
> M:  Danilo Krummrich <dakr@kernel.org>
> 
> Hmmmm.... I did CC Lyude, but you're right.  I should update my git-email script to catch these
> better.
> 
> While I have your attention, I do have other patches that I neglected to CC you on:
> 
>   2. [PATCH 6/6] drm/nouveau/gsp: enable FWSEC-SB on GA100
>      - by Timur Tabi @ 2026-04-07 19:21 UTC [95%]
> 
>   3. [PATCH 2/6] drm/nouveau/bios: specify correct display fuse register for Ampere and Ada
>      - by Timur Tabi @ 2026-04-07 19:21 UTC [95%]
> 
>   4. [PATCH 1/6] drm/nouveau: check for GA100 specifically when calculating FRTS size
>      - by Timur Tabi @ 2026-04-07 19:21 UTC [91%]
> 
>   5. [PATCH 4/6] drm/nouveau/gsp: require GSP-RM for GA100 support
>      - by Timur Tabi @ 2026-04-07 19:21 UTC [97%]
> 
>   6. [PATCH 3/6] drm/nouveau/bios: skip the IFR header if present
>      - by Timur Tabi @ 2026-04-07 19:21 UTC [75%]
> 
>   7. [PATCH 5/6] drm/nouveau: parse the VBIOS on GA100
>      - by Timur Tabi @ 2026-04-07 19:21 UTC [99%]
> 
>   8. [PATCH 0/6] drm/nouveau: fix GA100 issues
>      - by Timur Tabi @ 2026-04-07 19:21 UTC [93%]
> 
>   9. [PATCH] drm/nouveau: expose VBIOS via debugfs on GSP-RM systems
>      - by Timur Tabi @ 2026-04-07 18:53 UTC [95%]

Ok, I will take a look in the next days.

Thanks,
Danilo

>>> https://lore.freedesktop.org/nouveau/20260103000756.1002890-1-ttabi@nvidia.com/T/#u
>>>
>>> I'm quite certain that there are other similar issues in Nouveau w.r.t. IS_ERR_OR_NULL.
>>
>> Yeah, that sounds likely.
>>
>>> I think an audit of the Nouveau error paths is in order.  I suspect that Ben's big refactors
>>> over the past year have resulted in some invalid error paths.
>>
>> Are you planning to look into this?
> 
> No, but it does sound like something that Claude could figure out pretty quick.

