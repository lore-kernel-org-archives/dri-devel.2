Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BCECDE002
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7242010F1B1;
	Thu, 25 Jun 2026 08:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W84MQ712";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F4110F1B1;
 Thu, 25 Jun 2026 08:37:10 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gmBxb6GCXz9tqB;
 Thu, 25 Jun 2026 10:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782376627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kBqRXRlpUaMX3821HCBG8mAA4wukwyC2l9HGWwcu4A=;
 b=W84MQ712vFQKCDVmGMZW/JvMcp4+hJ/Iqacvb9erdVqDn8cSqOQurxmIkYeuL9baiyQNaE
 dE8ojQRgwHZVitwbAPMLCwUlw2W6W3rgR1uepqvylby0qdJ195Haf+iGNMoVc5c2qVAYBi
 W2wtj4entLQUJ15voWg0gQqnMWKQOpsTOqQ3SB52iK8T0vft8xmuEvaoyMi49Z2En/ZbbM
 VKYeiPSr+CD5s0sn/yIyODWmPw3AfrbkyTIw7giDU/AXY7FV4hrLcg1WwgMpHyrPOFKZrf
 9yz1pb2sZZ6WUGitwPfRzfEmaPKql0WOur31sY15lDgMpzztPBlgektwc+BEHQ==
Message-ID: <e4e280a4-fe82-4c2a-ba1b-43fe06844e83@mailbox.org>
Date: Thu, 25 Jun 2026 10:37:03 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH] drm/amd/display: Pin native scanout to VRAM on
 large-carveout APUs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Melissa Wen
 <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, natalie.vock@gmx.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
References: <20260616071037.26718-1-matthew.schwartz@linux.dev>
 <334d4642-a7ce-4d04-ab14-6b95653e6f86@amd.com>
 <09a37c38-3f99-40bf-9a87-f88298ce349a@amd.com>
 <9b96d6a5-7c3c-4bd5-8785-76c9642bc933@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <9b96d6a5-7c3c-4bd5-8785-76c9642bc933@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 35c4b84c76678b65f08
X-MBO-RS-META: 94343597edxmcf43bju6jbuhcb88ga6d
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

On 6/24/26 17:52, Christian König wrote:
> On 6/24/26 17:30, Harry Wentland wrote:
>> On 2026-06-16 03:31, Christian König wrote:
>>> On 6/16/26 09:10, Matthew Schwartz wrote:
>>>> Native scanout buffers on APUs are pinned with the VRAM|GTT domain, so
>>>> under VRAM carveout pressure a swapchain can end up split across VRAM and
>>>> GTT. The scanout buffer's memory type then changes from one flip to the
>>>> next, and amdgpu_dm_crtc_mem_type_changed() rejects an async page flip
>>>> across the change. The result is repeated async page flip failures,
>>>> observed as choppy updates under carveout pressure, until the buffers
>>>> reconverge to a single domain.
>>>
>>> That's intentional behavior.
>>>
>>>> Pin native scanout buffers in VRAM only so the swapchain stays in one
>>>> memory domain. Restrict this to APUs whose carveout is larger than
>>
>> Above you mention that under VRAM pressure a swapchain can end up split
>> across VRAM and GTT. Wouldn't restricting the swapchain to VRAM now mean
>> that in those cases you fail to allocate the swapchain entirely?
> 
> Yes, exactly that.

This doesn't affect swapchain allocation, does it? It only affects whether or not an atomic commit succeeds or fails.


> My educated guess is that the display server then falls back to using a copy instead of a flip and that helps saving memory somehow (e.g. less scanout buffers alocated concurrently).

If an atomic commit fails (e.g. because the buffer can't be pinned to VRAM), I'd expect a Wayland compositor to first fall back from direct scanout of a client buffer to compositing, or if it's for a composited buffer, from an async commit to a non-async one.

Xorg can further fall back to copying from the new buffer to the current scanout buffer, not sure any Wayland compositor does that though. Mutter doesn't, I suspect it would freeze if a non-async commit to a composited buffer fails.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
