Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F489CD4F54
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 08:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A9C410E100;
	Sat, 23 May 2026 08:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="KUinc4ZV";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3F710E05D;
 Sat, 23 May 2026 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1779524975;
 bh=9SDUMtgft28p5MCL5835tAIitrsFvvpZqTuSRHohrFE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KUinc4ZV/jI6nAbY75NcTIumKg6SME5cG8HJ4ntmnGNFY4xhQjS1WsWS8FpTuFSNl
 W9W7zAapuGpZIt0poR2uhzPpdmU2sCiEcXiSfFc9M0YeQi0iHXr7XghkB5IKAIAM1Z
 7n0eLQanypGQ5toZIUnlCsLmTvuDEyvS4dfhhoH7LEVW4H4ciFelsAhPx7Ts6ODERt
 tqSjxDOVpPZWJHR/Nv+rjuOtPfPbBddKQyhQeCGb0z1lk+kdb6Cd/B79Tb9a4RJwi8
 jXWVFLDx+aGSpbwt2c//g7S8EO28/hECIIqt6GP7JQ3K6jzWIIxJ+D9Y2vzH/nvKNh
 m/diaLZ0BOTrw==
Message-ID: <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
Date: Sat, 23 May 2026 10:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
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

Hey,

Den 2026-05-22 kl. 22:54, skrev Linus Torvalds:
> On Fri, 22 May 2026 at 13:44, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>>
>> Any journal saving the kernel buf log of previous boots? Preferably with
>> some drm.debug flags enabled 0xf likely
> 
> Note that this is very much not repeatable. I have no idea what
> triggered it, and I don't think it was necessarily brought on by
> anything recent.
> 
> I've seen timeouts before, but looking at my logs, the last time it
> caused a complete hang was Feb 3. So a few months ago...
> 
>> What was the last drm-fixes pull you got in this 7.1.0-rc3-00073-ga6920214ba75 ?
> 
> That's just mainline commit v7.1-rc3-71-g31e62c2ebbfd with two random
> small patches on top that change some build flags (this is my "built
> by clang" tree)
> 
> So the last drm merge would have been 51d24842acb9 Merge tag
> 'drm-fixes-2026-05-08-1' of https://gitlab.freedesktop.org/drm/kernel
> 
>                     Linus

Just thinking that since the guc_id=0, the most likely culprit is in the
kernel migration code.

There are 3 places you'll most likely interact with it:
- Zeroing VRAM bo's on allocation
- On integrated, it may clear system memory bo's CCS data.
- Moving memory between system and VRAM.

I'm assuming you only have a discrete card, so it's either happening
on allocation or memory movement.

Since it's sporadic, it *might* be more likely the latter.

Does it happen more frequently when loading VRAM intensive programs?

Kind regards,
~Maarten Lankhorst
