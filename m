Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C01CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B234510EF2C;
	Wed, 20 May 2026 07:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=czernohous.de header.i=@czernohous.de header.b="nQvQ5s2y";
	dkim-atps=neutral
X-Greylist: delayed 603 seconds by postgrey-1.36 at gabe;
 Wed, 20 May 2026 04:37:49 UTC
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1769F10EED9;
 Wed, 20 May 2026 04:37:48 +0000 (UTC)
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id AF5B6240BC8;
 Wed, 20 May 2026 06:27:44 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id DC54224037A;
 Wed, 20 May 2026 06:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=czernohous.de;
 s=DKIM001; t=1779251262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SoAUxG5Wqu0754xFY9UxVmw3FUsIrhMKJDvUQnTnS7Y=;
 b=nQvQ5s2yqgBPqHRMk+zqcAu5xbOrmENMSNEB4E9lfK9uK3WVwOeTv0dam9iUj8eRBYyhBv
 fgIevP6Ug/MpZVwEb/T3zH0Qz9YqIyjEc6hP13SVY9TVaM+hVFzJWccvWf2t+TtOwzHqUj
 ILOpgrmQPg34RFOkgLv2lSH7Zyj5Ox1zZ4MOri3YlCsE//hVbDUsSzPEqBAiQBq1BUR7sw
 eQt7nhsUixtIhF7UX/7oho+5tUmr7KurUMu079j9Pj/4cMrz9MrlQZN+MlyjKa0/v9N4C9
 vhFWZr3Ui19tgqqs3dyl6WB+vdNIkv2znQj96IBa7MryMjWOf7OEVHvSRDthYg==
Received: from [192.168.1.211] (ip-109-193-028-214.um39.pools.vodafone-ip.de
 [109.193.28.214])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id 817532402DB;
 Wed, 20 May 2026 06:27:42 +0200 (CEST)
Message-ID: <40087297-4c86-4214-acab-f036ccfa2861@czernohous.de>
Date: Wed, 20 May 2026 06:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/nouveau: nv04 FIFO cleanup + recovery for Tesla
To: lyude@redhat.com, Marek Czernohous <mczernohous@gmail.com>,
 nouveau@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260513175014.96599-1-marek@czernohous.de>
 <4037b4a4c1768f5f28c7ae1c5dfb2913e675d6ab.camel@redhat.com>
Content-Language: en-US
From: Marek Czernohous <marek@czernohous.de>
In-Reply-To: <4037b4a4c1768f5f28c7ae1c5dfb2913e675d6ab.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 6632ff
X-Rspamd-UID: cb2c3d
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

Hi Lyude,

No need to apologise, it is a completely fair question and I should have 
got ahead of it.

To answer directly: these patches were not written by a person alone. I 
used Anthropic's Claude (Opus 4.7) while developing the series, to help 
investigate the nv04_fifo fault behaviour and to draft both the code and 
the commit messages. I reviewed every change myself, the series was 
soak-tested on the reference hardware as described in the cover letter, 
and I take full responsibility for it under my Signed-off-by.

I missed Documentation/process/coding-assistants.rst when I prepared the 
series, apologies for that. The fix is to add this trailer to both patches:

Assisted-by: Claude:claude-opus-4-7

I can send a v2 with that trailer right away, or fold it into the next 
revision together with any review feedback you have, whichever keeps 
things tidiest for you.

For full disclosure: my earlier April series (NVAC stability, ref [2] in 
the cover letter) was likewise developed with Claude's assistance. It is 
still awaiting review, and I will make sure the trailer is in place when 
I revise it.

Thanks for the careful review,
Marek

Am 20.05.26 um 00:01 schrieb lyude@redhat.com:
> Hey! I truly apologize for asking, and thank you tremendously in
> advance if the answer is no. But I had to check since I haven't seen
> you around before, and these are unusually long commit messages:
>
> These patches were written by a person correct? If not, you need to
> follow the coding assistants guidelines here:
>
> https://docs.kernel.org/process/coding-assistants.html
>
> On Wed, 2026-05-13 at 19:50 +0200, Marek Czernohous wrote:
>> Hi all,
>>
>> Two-patch series for the legacy nv04_fifo path covering Tesla
>> (MCP77/MCP79 and G80-GT218). Daily-driven on the reference NVAC
>> hardware (Apple Mac mini Late 2009, GeForce 9400M) since 2026-05-05.
>>
>> Patch 1 demotes a benign CACHE_ERROR that fires once per Mesa session
>> start on Tesla GPUs. The Mesa NV50 userspace driver issues a method-
>> 0x0060 / data-0xbeef02xx binding probe that recovers cleanly via
>> nv04_fifo_swmthd(), but currently logs at error level on every X or
>> Wayland session, dominating dmesg noise on this hardware class. This
>> clears the channel for patch 2 to identify real faults from noise.
>>
>> Patch 2 adds a two-tier fault-recovery path for Tesla FIFO faults:
>>
>>    Tier 1 (per fault). Look up the channel via nvkm_chan_get_chid,
>>    call nvkm_chan_error(chan, true), fire tracepoint
>>    nouveau:fifo_chan_killed. Idempotent through the existing
>>    chan->errored short-circuit.
>>
>>    Tier 2 (sliding window). When the per-fifo fault count in a
>>    configurable window reaches the threshold, schedule a worker that
>>    calls drm_dev_wedged_event(drm, DRM_WEDGE_RECOVERY_REBIND, NULL)
>>    and fires tracepoint nouveau:fifo_dev_wedged. Worker context is
>>    needed because kobject_uevent_env may sleep.
>>
>> Motivation: Fermi+ gets channel-kill and device-wedge automatically
>> through nvkm_runl_rc; Tesla was feature-frozen before the DRM wedge
>> uAPI existed. Three observable consequences on the reference
>> hardware:
>>
>>    1. Silent state corruption (channel produces wrong output after a
>>       fault, no notice to userspace).
>>    2. Observability gap (no counters, tracepoints, or wedge event,
>>       only dmesg).
>>    3. Repeated-fault loop (the log-and-reset cycle repeats forever on
>>       a persistently faulting channel instead of killing it).
>>
>> Validation. A debugfs fault-injector (kept on a separate
>> DO-NOT-MERGE branch, not part of this submission) was used to drive
>> both Tier-1 and Tier-2 paths through their full state space. Phases
>> 1-5 of the test plan were exercised that way. Phase 6 (no manual
>> injection, real workload soak) ran 2026-05-05 through 2026-05-13:
>> one organic DRM_WEDGE_RECOVERY_REBIND event was captured on
>> 2026-05-05 09:08; the rest of the soak was fault-free.
>>
>> Companion userland tool nouveau-pstate-daemon v0.2.0 [1] subscribes
>> to the WEDGED=rebind uevent in log-only mode and was used to confirm
>> end-to-end propagation through udev.
>>
>> Module parameters:
>>
>>    nouveau.fifo_wedge_count     (uint, 0..32, default 10)
>>    nouveau.fifo_wedge_window_ms (uint, 100..600000, default 60000)
>>
>> Setting fifo_wedge_count=0 disables Tier-2 entirely while keeping
>> Tier-1 channel-kill active.
>>
>> A note on MAINTAINERS. The series adds a new file
>> drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c. The change is
>> covered by the existing nouveau MAINTAINERS section
>> (drivers/gpu/drm/nouveau/), so no MAINTAINERS update is included.
>> checkpatch.pl flags this as a hint; it is not load-bearing.
>>
>> This is a follow-up to the April 9 NVAC stability series [2], which
>> is still awaiting review. The two patches here are independent of
>> that series and apply against current Linus master.
>>
>> [1] https://github.com/hibbes/nouveau-pstate-daemon (v0.2.0)
>> [2]
>> https://lore.kernel.org/dri-devel/20260409-nouveau-nvac-stability-series
>>
>> Marek Czernohous (2):
>>    drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from Mesa NV50
>> bind
>>      probe
>>    drm/nouveau/fifo: add recovery path for Tesla
>> cache_error/dma_pusher
>>
>>   .../drm/nouveau/include/nvkm/engine/fifo.h    |  12 ++
>>   .../include/trace/events/nouveau_fifo.h       |  58 +++++++++
>>   drivers/gpu/drm/nouveau/nouveau_drm.c         |  29 +++++
>>   .../gpu/drm/nouveau/nvkm/engine/fifo/Kbuild   |   1 +
>>   .../gpu/drm/nouveau/nvkm/engine/fifo/base.c   |   3 +
>>   .../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c   |  29 ++++-
>>   .../gpu/drm/nouveau/nvkm/engine/fifo/priv.h   |  10 ++
>>   .../drm/nouveau/nvkm/engine/fifo/recover.c    | 121
>> ++++++++++++++++++
>>   8 files changed, 257 insertions(+), 6 deletions(-)
>>   create mode 100644
>> drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h
>>   create mode 100644
>> drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c
>>
>>
>> base-commit: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11
