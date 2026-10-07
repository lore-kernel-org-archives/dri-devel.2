Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD78CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37AE410F5CF;
	Wed,  7 Oct 2026 13:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="YBrGsEew";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4FA5010F5BE
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:28:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 827F91595;
 Wed,  7 Oct 2026 06:28:13 -0700 (PDT)
Received: from [10.57.75.203] (unknown [10.57.75.203])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356773F66F;
 Wed,  7 Oct 2026 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791379696; bh=Jn7PJPGHlmYIPJnS8L1ETz+D8J64WDknXKE3E9/atik=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YBrGsEewRGcLUnFe5kHsA5c/x/j2mR6m1W05Cqa5wudduxNqbX2elplroYOekyLFm
 W4xmn+87MF3o7A93THziEkHML9MYzXd5IrIIw3SnyjcVkCXxWW0M4G4e885MgqGVk6
 szslq0oIcmKL3Jvzz7APATBKgocpAZgMGmwk5IYs=
Message-ID: <65ce6b05-1afb-4b01-b529-fb218b154539@arm.com>
Date: Wed, 7 Oct 2026 14:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
 <20261005103855.655f8199@fedora-61.home>
 <5af99ba3-97e7-4a05-b91c-7d53a508b635@arm.com>
 <20261005173741.445715f0@fedora-61.home>
 <37422c77-ecdc-46a0-8896-3a5098417426@arm.com>
 <179130812939.1018806.2045583346110052897.b4-reply@b4>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <179130812939.1018806.2045583346110052897.b4-reply@b4>
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

On 06/10/2026 18:35, Adrián Larumbe wrote:
> On 2026-10-05 17:05:14+01:00, Steven Price wrote:
>> On 05/10/2026 16:37, Boris Brezillon wrote:
>>
>>> On Mon, 5 Oct 2026 16:06:02 +0100
>>> Steven Price <steven.price@arm.com> wrote:
>>>
>>>
>>> Hm, I'd say it's actually impossible because every unmap operation is
>>> followed by a flush+inval of the GPU L2 and LSC, so for this stale
>>> clean line to exist on the GPU side when a physical page is GPU-mapped
>>> again, it would take a bug in the unmap logic or in the MMU HW, I
>>> think. Am I missing something?
>>
>> Ah, yes that's true :) Although there's no need for us to do an
>> invalidate on the unmap path...
> 
> Does that mean the panfrost_mmu_flush_range() we do at the end of panfrost_mmu_unmap()
> is unnecessary? Is it because, as you said in a previous message, cache lines for
> BOs referenced in a CS are always invalidates before anything else is executed?

Sorry, I wasn't very clear on the wording here - we don't need an
*invalidate* but we do need a *clean*. Midgard/Bifrost hardware doesn't
really give us much control over cache operations - we tend to just
clean everything and blow away the cache (because the GPU's caches are
"small" it's not worth the complexity).

> If we keep the invalidate at the end of the mmu path, then there would be no need
> to mention that all counters being enabled is the ultimate reason why no initial
> flush/invalidate is needed in the perfcnt enable path.

Yes I think relying on all counters being enabled is a bad design. We
can justify the change based on the existing flushes/invalidates we're
doing.

>>>>
>>>
>>> I suppose speculation pre-populating the caches with stale data would be
>>> covered by the flush+inval we do after a map operation (this is
>>> currently done in the unlock path regardless of the VM op, so both map
>>> and unmap get it). I don't know, maybe the goal is to relax the flushing
>>> policy around VM modifications in the future, but if things stay as
>>> they are now, we can assume that a fresh BO being GPU-mapped guarantees
>>> that no cacheline points to it until the first GPU access. But maybe
>>> I'm missing something else...
>>
>> I have to admit I'm coming from experience on CPUs - there speculation
>> means a CPU can load a cache line at basically any point. So the
>> argument that a line cannot be in a cache almost never holds. GPUs (at
>> least Mali GPUs) haven't quite got to the stage of CPUs.
>>
>> Thanks,
>> Steve
> 
> 

