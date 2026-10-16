Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B04CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840C310E1C9;
	Fri, 16 Oct 2026 12:25:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 88FE010E1C9
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:25:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A05EB14BF
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:25:36 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 A79FA3F871
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792153539; bh=krxKzyNI1ZYpileNc2uCsCIeFjKDXJ2c5kSdMOWJL38=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C6/oKlqL/AOW60J29zXcLXWFT+rQU0UonsuW5Bju1JrAC7GUZ98w+ZM6+98Bn5EEf
 SUkBs62xkzRZ4S2dMs0b5bK0pauLm3lxuxqpz4rx5a82T5IBSQBx8qAjJlsYRjbUxA
 wINMfSGQsoAF7G7Hq6fURdmM/ZdylxuSbZJEEI70=
Date: Fri, 16 Oct 2026 13:25:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/panthor: Misc MMU fixes/robustness improvements
Message-ID: <atIXudY6VCIdO2Tc@e142607>
References: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
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

On Thu, Sep 24, 2026 at 02:30:42PM +0200, Boris Brezillon wrote:
> The first commit is fixing a bug we've seen on v13 HW. Even though
> we don't quite understand what happens (race in the flush-elimination
> logic when flush requests are sent concurrently from the CPU and the
> MCU), it seems that the downstream driver has always been doing a
> flush+invalidate of RW caches from the start, and that we were doing
> so up until the atomic page table update changes, so let's go back to
> that state and leave the RO L1 caches untouched.
> 
> The second patch a fix for a race that could very well happen if we
> ever end up with a failure between the as_disable() and as_enable()
> calls. We've not experienced this so far, but it seems worth plugging
> the hole regardless. The last patch is a much more theoretical bug,
> which would involve a buggy FW telling us that a CSG is suspended,
> when it's actually. I've deliberately not added a Fixes tag on the
> last one for this very reason, but I think it's worth staying on
> the safe side by addressing this theoretical issue, still.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Boris Brezillon (3):
>       drm/panthor: Don't invalidate OTHER caches
>       drm/panthor: Fully disable the AS even if it's going to be re-assigned
>       drm/panthor: Move cache-flush after UPDATE(UNMAPPED)
> 
>  drivers/gpu/drm/panthor/panthor_mmu.c | 43 ++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> ---
> base-commit: 45585c3aa285854face65293acc95eff73063d6d
> change-id: 20260924-panthor-mmu-fixes-a1832dc60908
> 
> Best regards,
> --  
> Boris Brezillon <boris.brezillon@collabora.com>
> 

Pushed the whole series into drm-misc-next-fixes after updating the comment
on 1/3 as suggested by sashiko.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
