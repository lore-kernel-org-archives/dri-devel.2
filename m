Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283DDCA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BF710E167;
	Thu,  1 Oct 2026 18:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Zgm4jHfW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326DA10E3D3;
 Thu,  1 Oct 2026 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=lwD0tq9kOXo25StVj9HfyV90bbrSfiL0k0vfeLXKdH8=; b=Zgm4jHfWmbbqFCxXJRKGa45J/z
 q1GafYG8r/oc2H9s+3kIyT2VAxO5OdIBGpz1MyCovDfLqv9RirunY1n0xGehxvrHqVpy5N5jKmqEq
 WCDra4zMSlTaFP1PBKSoPm6wUff2bvB4cKtwzlPYz4A5x6QDhYiaSVtQpNMoznaZ2FUU6NPr7gQVx
 SwJDkD70QC0v7Fc4TvIJqHYGS4gt86ws0jNQ4psPfa/HAx59zPY/7lHJMd4zJkeCKtW6SE4ZdU94a
 x20DmOokVdB5DggOSWHPxaQlYp74ivuL5NuCYjRYZhxTBiAimLZM2rlq1C5Es2Cvzln+I6WT7PHJA
 svPZXFLg==;
Received: from [179.190.179.102] (helo=[192.168.1.27])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xCL4i-00AEm6-KF; Thu, 01 Oct 2026 20:00:08 +0200
Message-ID: <f852acbe-6d4c-4edb-a320-e2d690486bd6@igalia.com>
Date: Thu, 1 Oct 2026 15:00:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET
 programming for ADL
To: Andi Shyti <andi.shyti@kernel.org>
Cc: rodrigo.vivi@intel.com, demarchi@kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 tvrtko.ursulin@igalia.com, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260930170434.317671-1-koike@igalia.com>
 <ar3_LjzklapoN1tM@zenone.zhora.eu>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <ar3_LjzklapoN1tM@zenone.zhora.eu>
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

Hi Andi,

Thanks for your reply.

On 10/1/26 5:45 AM, Andi Shyti wrote:
> Hi Helen,
> 
> On Wed, Sep 30, 2026 at 02:04:30PM -0300, Helen Koike wrote:
>> CTX_CS_INDIRECT_CTX_OFFSET default value is not retrieved from the GPU
>> by inhibit+context save mechanism since it is not part of the Engine
>> Context. Thus, at restore, 0x0 is programed back to the GPU, which is
> 
> /programed/programmed/

Ack

> 
>> an invalid value according to the PRM.
> 
> ...
> 
>>   	/*
>>   	 * Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at its default: it
>> -	 * varies per engine class, but the default is good enough
>> +	 * varies per engine class, but the default is good enough, except on
>> +	 * Alder Lake.
>>   	 */
>>   	xe_lrc_write_ctx_reg(lrc,
>>   			     CTX_CS_INDIRECT_CTX,
>>   			     (xe_bo_ggtt_addr(lrc->bo) + state.offset) |
>>   			     /* Size in CLs. */
>>   			     (state.written * sizeof(u32) / 64));
>> +	if (GRAPHICS_VER(lrc_to_xe(lrc)) < 20)
> 
> Are you assuming that only Alder Lake is xe < 20?

This is a good point, since I was basing this patch on TGL PRM [1], I 
believe it should apply to all Gen12 gpus. Maybe I could s/for ADL/for 
Gen12, make sense? I only tested on ADL though.

[1] 
https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/tiger-lake.html

> 
> As you are restoring the original code for render and compute,
> would it make sense also add a check for class being
> XE_EGINE_CLASS_RENDER || XE_ENGINE_CLASS_COMPUTE?

In my understanding from commit [2], indirect ctx will be allowed for 
other engines in the future, so I'm not sure we should limit here to 
those classes besides what gt_engine_needs_indirect_ctx() does.

[2] 
https://lore.kernel.org/all/20250916-wa-bb-cmds-v5-5-306bddbc15da@intel.com/


Helen

> 
> Andi
> 
>> +		xe_lrc_write_ctx_reg(lrc,
>> +				     CTX_CS_INDIRECT_CTX_OFFSET,
>> +				     CTX_INDIRECT_CTX_OFFSET_DEFAULT);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.54.0
>>

