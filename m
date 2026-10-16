Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96232CCF2C4
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 21:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E7810E23C;
	Fri, 16 Oct 2026 21:44:37 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF9110E233;
 Fri, 16 Oct 2026 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=g0Zf2J1CP5PMO/q2SJC02U8X5dIjn1ORSO6M5pd19Bk=; b=Lbx1edA9H82D5vzL9njua8LfUf
 8mn1geV1OMSdUAmcHEi9GQetKFfKLHfMfC+leA6K7jaOL45cJa9kE+uGRH1iDUEwoqwK3MQAxMLbt
 lJxEnL+nNS9CNVmXhbvoIe5K4/U4QhM991j76M0VwwUcGL+59TuzCr5sNBsEqsN9zyP8vyUxlS3i5
 Tla5s3eKMQl+Ufs1QGpKg4Ye6JT5DxZ+1aGl66STmPPRCqmkNy68qasY6uVHiTMzQAodaWo5gzzWI
 bATNzR/0cu8amg8zfk892zT7t6/wkDxNOFVz9jGq4GhTLUQBk8YIKDLDog9BNKKPifhj37dI3tMCj
 FPdvF7Xg==;
Received: from [179.190.179.102] (helo=[192.168.1.27])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHpiz-001FYW-C5; Fri, 16 Oct 2026 23:44:25 +0200
Message-ID: <f7af30de-197b-426e-a8ab-efbb3d7b049e@igalia.com>
Date: Fri, 16 Oct 2026 18:44:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET
 programming for ADL
To: Matt Roper <matthew.d.roper@intel.com>
Cc: rodrigo.vivi@intel.com, demarchi@kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 tvrtko.ursulin@igalia.com, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260930170434.317671-1-koike@igalia.com>
 <20260930232937.GQ730887@mdroper-desk1.amr.corp.intel.com>
 <be2b367a-870b-4b93-84dc-eb36542fee82@igalia.com>
 <20261015192801.GC578251@mdroper-desk1>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <20261015192801.GC578251@mdroper-desk1>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Matt

On 10/15/26 4:28 PM, Matt Roper wrote:
> On Thu, Oct 01, 2026 at 11:17:17AM -0300, Helen Koike wrote:
>> Hi Matt,
>>
>> Thank you for your reply, please see my comments below.
>>
>> On 9/30/26 8:29 PM, Matt Roper wrote:
>>> On Wed, Sep 30, 2026 at 02:04:30PM -0300, Helen Koike wrote:
>>>> CTX_CS_INDIRECT_CTX_OFFSET default value is not retrieved from the GPU
>>>> by inhibit+context save mechanism since it is not part of the Engine
>>>> Context. Thus, at restore, 0x0 is programed back to the GPU, which is
>>>> an invalid value according to the PRM.
>>>
>>> I don't follow this explanation, but I don't think this is quite right.
>>> For example, CS_INDIRECT_CTX_OFFSET definitely is part of the in-memory
>>> context image (the CTX_CS_INDIRECT_CTX_OFFSET is the offet into that
>>> context image where it's found). Let me try to explain the relevant
>>> flows here.
>>>
>>> When hardware first comes up, it contains "hardware default" values for
>>> various registers.  For CS_INDIRECT_CTX_OFFSET, the hardware's default
>>> value is 0xD, so that's the value the register will have when the
>>> hardware first wakes up or powers on.
>>>
>>> For registers that are part of an engine's LRC, whenever a regular
>>> context switch happens, the current copy of the register gets written
>>> out to memory in the outgoing context's LRC image, and a new value is
>>> loaded from memory into the register from the incoming context's LRC
>>> image.
>>>> "Restore inhibit" is a special case that gets used at one place during
>>> initial driver startup where we tell the hardware "switch to this
>>> context but do *not* load any register values from memory for the
>>> context that we're switching into."  When restore inhibit is used, the
>>> currently-present register values remain unchanged by the context
>>> switch and the only thing that changes is the hardware's idea of which
>>> context is currently "active."
>>
>>
>> The problem is that CTX_CS_INDIRECT_CTX_OFFSET is not inhibit by Restore
>> inhibit.
> 
> Sorry for the delay getting back to you here.  After re-reviewing the
> internal bspec, you're right CS_INDIRECT_CTX_OFFSET is indeed part of
> "execlist context" section of the LRC instead of the "engine context"
> section, so it doesn't get affected by the "engine context restore
> inhibit" bit.
> 
> You can ignore my earlier feedback since it was mostly wrong.  :-)
> 
> It seems like programming CS_INDIRECT_CTX_OFFSET is something we should
> be doing on all platforms, not just the pre-Xe2 platforms.  And contrary
> to the comment that exists in the code today, 0xD is documented as the
> hardware default for INDIRECT_CTX_OFFSET[15:6] on all engine types and
> all Xe1/Xe2/Xe3/Xe3p platforms.
> 
> The failures you got from CI on the Xe2 platforms seem surprising to me,
> but I can reproduce them on a local LNL machine, so they don't seem to
> be a fluke.  If I can find some free time, I'd like to update that
> configfs test to update registers that are actually part of the LRC
> before/after the point we indicate via INDIRECT_CTX_OFFSET and see what
> their behavior is.  A test update like that is slightly more involved
> than just changing the string passed to configfs since we'd also need to
> adjust the register readback strategy to actually use the command
> streamer to read the correct context's copy of the register (today the
> test just uses a CPU iomap to read the register after the LRC is no
> longer running, so it only works to verify registers that aren't part of
> the LRC's save/restore list and won't revert to hardware defaults).
> 
> 
> I haven't looked at the old public PRMs too carefully, but for reference
> here are the restrictions that are currently documented in our internal
> bspec for INDIRECT_CTX_OFFSET:


Thank you for your investigation, thoughfull reply and references.

> 
>   * "Indirect context pointer itself is restored during context restore
>     and hence Indirect Context Offset must not be programmed with value
>     less than 0x5."
> 
>     This restriction would imply that the current (before your patch)
>     value of 0x0 is invalid.  Yet the IGT test that exercises
>     INDIRECT_CTX via configfs somehow seem happy if we leave it at 0.

I can try to take a look for ADL.

> 
>   * "It is not valid to program this to a value that is greater or equal
>     to the starting offset for RS context."
> 
>     I believe "RS context" refers to the resource streamer, which is
>     something that was removed from hardware all the way back in gen11
>     and isn't relevant to either Xe1 or Xe2+ hardware.  It seems this
>     bspec note is outdated, but I'm not sure if there's some different
>     upper bound that needs to be honored today or not.
> 
>   * "Offset of Indirect CS context must be always programmed to a command
>     boundary and cacheline boundary inside the context image."
> 
>     This one shouldn't be a problem; it looks like cacheline 0xD should
>     fall on an instruction boundary for all engine types and all current
>     platforms.
> 
>   * "BCS/VCS/VECS: This register functionality is not supported and must
>     not be programmed"
> 
>     This restriction seems a bit ambiguous to me.  I'm not sure if it
>     means the hardware ignores the value and it doesn't truly matter what
>     we program for non-RCS engines, or whether programming something
>     incorrectly can cause problems.  Doing nothing in the driver (as is
>     the case before your patch) would leave the register at 0 and violate
>     the other requirement about not being < 0x5.  Getting the hardware
>     default of cache line 0xD into the register does require some
>     explicit programming (as in your patch).
> 
 > > Anyway, I think we can mostly go with your existing patch here for now
> with just a couple minor changes:
> 
>   * Replace "for Alder Lake" in the commit message with "for pre-Xe2
>     platforms."  Also add an extra sentence or so explaining that even
>     though this looks like it should be correct for all platforms, we're
>     restricting it to Xe1 for now while we investigate the unexpected
>     behavior we're seeing there.
> 
>   * Remove the entire "Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at
>     its default" code comment since it was already wrong (i.e., the
>     default offset does not vary by engine, and not programming the
>     register doesn't actually leave the register at its default).
> 

Ack, done, I just sent v3, please check.

Helen

> 
> Matt
> 
>>
>> If you check the documentation on https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/tiger-lake.html
>> , you can find:
>>
>> PRM Vol 8:
>>
>> "When a context is submitted for the first time for execution, SW can
>> inhibit engine from restoring engine context by setting the "Engine Context
>> Restore Inhibit" bit in CTXT_SR_CTL register of the
>> logical ring context. This will avoid software from populating the Engine
>> Context. Software must program all the state required to initialize the
>> engine in the ring buffer which would initialize the
>> hardware state. On a subsequent context save engine will populate the engine
>> context with appropriate values."
>>
>> And also:
>>
>> ""INDIRECT_CTX" and "INDIRECT_CTX_OFFSET" registers are part of the context
>> image and gets restored as part of the given
>> context's context restore flow, these registers are part of the ring context
>> image which are prior to
>> engine context restore and hence the requirement of the offset being in
>> engine context restore."
>>
>> In other words: "INDIRECT_CTX_OFFSET" is not part of the Engine Context (see
>> table on page 49 of the pdf from Vol 8, Engine Context is marked in dark
>> blue), it is part of the Ring Context, so Restore Inhibit doesn't afect this
>> register, which means it programs 0x0 back to the GPU, which is invalid.
>>
>>
>> Without this patch I get the following:
>>
>> :/ # cat /sys/kernel/debug/dri/0000:00:02.0/tile0/gt0/default_lrc_rcs
>> [0x00000000] MI_NOOP (1 dwords)
>> [0x11081019] MI_LOAD_REGISTER_IMM: 13 regs
>>   - 0x2244 = 0xffff0008
>>   - 0x2034 = 0x000000a8
>>   - 0x2030 = 0x000000a8
>>   - 0x2038 = 0x00530000
>>   - 0x203c = 0x00003001
>>   - 0x2168 = 0x00000000
>>   - 0x2140 = 0x00200094
>>   - 0x2110 = 0x00000000
>>   - 0x21c0 = 0x00543001
>>   - 0x21c4 = 0x00542001
>>   - 0x21c8 = 0x00000000 ---> Zeroed
>>   - 0x2180 = 0x00000080
>>   - 0x22b4 = 0x00000000
>>
>>
>>>
>>> So the overall flow for initialization is:
>>>
>>>    * Hardware powers up / comes out of reset; INDIRECT_CTX_OFFSET should
>>>      be 0xD.
>>>
>>>    * Driver allocates memory to serve as the storage space for the
>>>      "default LRC" (aka "golden context"); once initialization is
>>>      complete, this will be the template that is copied to create new
>>>      LRCs.  The registers/state in the default_lrc should be a copy of the
>>>      hardware default values, with various adjustments the driver makes
>>>      for things that we want modified for every context by default (e.g.,
>>>      register changes requested by various hardware workarounds).
>>>>    * Driver writes (with CPU) a basic LRI with the early register offsets
>>>      (but not their values) into the LRC storage space.  This is just so
>>>      that the hardware says "yep, this looks like an LRC" when we hand it
>>>      over for a context switch.  Although we're only filling in register
>>>      offsets and not values, this doesn't actually mean that registers are
>>>      being set to 0 or anything like that.  Honestly I'm not sure if the
>>>      hardware even truly needs us to do this anymore on modern hardware.
>>>
>>>    * Driver submits the default LRC to the hardware with the "restore
>>>      inhibit" flag.  This means that the hardware does *not* load any
>>>      register values from memory like it usually would (i.e., live
>>>      INDIRECT_CTX_OFFSET remains at 0xD)....
>> This is not true for INDIRECT_CTX_OFFSET as stated above (unless I missed
>> something).
>>
>>>      ...The batch buffer submitted on
>>>      the context adjusts various registers away from their hardware
>>>      defaults if there are non-default settings we want present on every
>>>      context in the future (e.g., settings requested by various hardware
>>>      workarounds).
>>>
>>>    * The batch buffer finishes executing, so the live register values are
>>>      now the hardware default values, with a handful of modifications.
>>>      Since we don't have any workarounds that adjust INDIRECT_CTX_OFFSET
>>>      today, it's still sitting at its default value of 0xD.
>>
>> This is not true for INDIRECT_CTX_OFFSET as stated above (unless I missed
>> something).
>>
>>>
>>>    * The driver submits a second context to the hardware with a noop
>>>      batch buffer.  This context switch causes the live register values
>>>      (including 0xD in INDIRECT_CTX_OFFSET) to get written out to the
>>>      the first context (default_lrc)'s memory storage.
>>>
>>>    * ...driver finishes initialization and user starts running real
>>>      programs...
>>>
>>>    * When a userspace process creates a new context, the "default_lrc"
>>>      snapshot is copied as the starting point for the new context.  After
>>>      that, various registers in the LRC are updated with unique
>>>      context-specific values as necessary.  So every context created on
>>>      the system should have INDIRECT_CTX_OFFSET set to 0xD.
>>>
>>
>> This is not true for INDIRECT_CTX_OFFSET as stated above (unless I missed
>> something).
>>
>>>
>>> So I don't see any way that CTX_CS_INDIRECT_CTX_OFFSET could become 0.
>>> Unless there's a hardware bug, the hardware should come up with a value
>>> of 0xD, that value winds up getting recorded in the default_lrc
>>> snapshot, and then every context we make later on down the road inherits
>>> that value.  While we could change it to another value if we wanted the
>>> indirect context batchbuffer to run at a different point during the
>>> context save/restore process, we don't have a need to do that.
>>>
>>> If you're seeing problems related to this register, I'd have a few
>>> questions to try to narrow down what's going on:
>>>
>>>    * Are you seeing problems on all engines or just a specific one?
>>
>> I understand gt_engine_needs_indirect_ctx() returns true for Alder Lake only
>> on XE_ENGINE_CLASS_RENDER, so this is the only one I tested.
>>
>>>
>>>    * Can you provide the contents of
>>>      /sys/kernel/debug/dri/0/gt0/default_lrc_* ; the value of this
>>>      register should be at dword offset (0x16 + 1), so we can see if it is
>>>      getting stored in memory correctly or not.
>>>
>>
>> pasted above.
>>
>>>
>>> Do note that Xe1 platforms like ADL aren't officially supported by the
>>> Xe driver, so it's quite possible that there might be some hardware
>>> workarounds for ADL that we just never implemented on Xe that could be
>>> causing a problem.  Xe's force_probe support is just for usage by KMD
>>> driver developers, so it was never expected to be fully stable or usable
>>> for general end-user use cases.
>>
>> I see, thanks for the note.
>>
>> Even so, I believe that writting a default value in the beggining to make
>> ADL happy should't be a problem.
>>
>> Please let me know if you think I'm missinterpreting things, and thank you
>> again for your review/reply.
>>
>> Helen
>>
>>>
>>>
>>> Matt
>>>
>>>
>>>>
>>>> This causes sporadic hangs on Alder Lake when executing test
>>>> IntelAngleEnd2EndTestCases (error VK_DEVICE_LOST).
>>>>
>>>> Fix it by partially reverting commit c9dfd66cb91e ("drm/xe/lrc: Allow
>>>> INDIRECT_CTX for more engine classes"). Re-add the programming of
>>>> CTX_CS_INDIRECT_CTX_OFFSET for Alder Lake.
>>>>
>>>> Fixes: c9dfd66cb91e ("drm/xe/lrc: Allow INDIRECT_CTX for more engine classes")
>>>> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Signed-off-by: Helen Koike <koike@igalia.com>
>>>>
>>>> ---
>>>> v2:
>>>>     - according to intel CI results, it seems that this default is not valid for
>>>>       LNL and BMG platforms, so limit the change only to ADL.
>>>>     - program the default only on ADL.
>>>>     - restore the comment, but add note with exception for ADL.
>>>>     - update the commit title/message with "for ADL".
>>>> ---
>>>>    drivers/gpu/drm/xe/regs/xe_lrc_layout.h | 3 +++
>>>>    drivers/gpu/drm/xe/xe_lrc.c             | 7 ++++++-
>>>>    2 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
>>>> index 4ab86fc369fd..e4c7c3549735 100644
>>>> --- a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
>>>> +++ b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
>>>> @@ -43,4 +43,7 @@
>>>>    #define INDIRECT_CTX_RING_START_UDW	(0x08 + 1)
>>>>    #define INDIRECT_CTX_RING_CTL		(0x0a + 1)
>>>> +#define CTX_INDIRECT_CTX_OFFSET_MASK	REG_GENMASK(15, 6)
>>>> +#define CTX_INDIRECT_CTX_OFFSET_DEFAULT	REG_FIELD_PREP(CTX_INDIRECT_CTX_OFFSET_MASK, 0xd)
>>>> +
>>>>    #endif
>>>> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
>>>> index 35b4e8289b5f..923bc1ddc851 100644
>>>> --- a/drivers/gpu/drm/xe/xe_lrc.c
>>>> +++ b/drivers/gpu/drm/xe/xe_lrc.c
>>>> @@ -1451,13 +1451,18 @@ setup_indirect_ctx(struct xe_lrc *lrc, struct xe_hw_engine *hwe)
>>>>    	/*
>>>>    	 * Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at its default: it
>>>> -	 * varies per engine class, but the default is good enough
>>>> +	 * varies per engine class, but the default is good enough, except on
>>>> +	 * Alder Lake.
>>>>    	 */
>>>>    	xe_lrc_write_ctx_reg(lrc,
>>>>    			     CTX_CS_INDIRECT_CTX,
>>>>    			     (xe_bo_ggtt_addr(lrc->bo) + state.offset) |
>>>>    			     /* Size in CLs. */
>>>>    			     (state.written * sizeof(u32) / 64));
>>>> +	if (GRAPHICS_VER(lrc_to_xe(lrc)) < 20)
>>>> +		xe_lrc_write_ctx_reg(lrc,
>>>> +				     CTX_CS_INDIRECT_CTX_OFFSET,
>>>> +				     CTX_INDIRECT_CTX_OFFSET_DEFAULT);
>>>>    	return 0;
>>>>    }
>>>> -- 
>>>> 2.54.0
>>>>
>>>
>>
> 

