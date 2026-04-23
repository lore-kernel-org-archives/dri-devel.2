Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F984F9937D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92AF10E1CD;
	Thu, 23 Apr 2026 12:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="g2P2D3sp";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1880610E1CD
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:00:46 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so4087946f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1776945644; x=1777550444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zLzaFLs4ICv5PiFTkQVxKST9crjAFi/HDMgVeoThYgA=;
 b=g2P2D3spVf2WqApRLQvwON091wCeZv9hH3rv2JoEFqxdKKmu12SjfOhkXKFzkRRSRr
 3o1d9GMzqblwc3qnBoCSKyqsSpl8NSY+tHLLLYs2V0a4KsUt545JTVrNkx2A25uTua9x
 Q7637gMItIC+0GXyKA4xAJZadi4k3qWKlZDQHyl7RQ+R+bDw7s28tUCR2RTH7Ji+cxS8
 Or7uZJf+UJnGQVCY73EYQNh819IAMTS8Yj68XVWE/EfmfqrSB048Gyr0QaGeiQLK81xo
 1nJWQPAXwVRjn/jOk7jIjLEdVjcXQ6xAOFrLGynsl7p5w/8gxWivstNFqCF6rFaXFMcu
 VESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776945644; x=1777550444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zLzaFLs4ICv5PiFTkQVxKST9crjAFi/HDMgVeoThYgA=;
 b=LKe7f9L8I2VZkMUjpeaeMqTcHrEvqnp1MePYiTmSGaUZy00dfGyq+Y7TSoMdR1QVgB
 MbSK5H82J4wREtprf+UwQqTUaQPLRfpFC33PUAVijjFW/ZKpwECe2uEV4UPY8OaXfzrE
 XNEfpaPYIfJyqWLbKlLnGr9ZXTebq+pJVtiGclBWFbOkigLRgV1ezDwBsgW0jBQh6c0Q
 6wsweRqnY1C5VEvOYhJlXhsn3B6WnS+yw4ZUZyXdCviR5Pw9Hn59lyOd4GizLnxcZTNw
 xe/lizCUReZ16Pu8nCCuCT0w25KVmQJE7DV/sn5IhSZtvNI9Fa57ppd8ldh8eBfuLN1O
 3fVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ905FSEoY/nvqYII4qos8OEcL8bMqpBgo+wH/Xs31/2HKpZf6nWrbujxeiuc8Z1s2oETvr2AMF7HeU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkiAPx0QGyVgklnu/FesDqiadmYjXmzfrrVnBe7xYnSma2wJ8y
 DSiYslkOl21+mynezYVOETyUarXCpZwx5MEeurtMdKozCeRsVfj/6bhwFOQ/qsLe31U=
X-Gm-Gg: AeBDievFso+ytWqF84KwhmTFxgBYnGVpddS9IShNjV5RAAYV3r1fJykZ5y+CMJctag/
 /HBlwF64JIT82BAcBJlWHtaFH4A+Ooe4Z92vgsiZ9nlosKAMoQti28ijlHiEbMVjUOWhZ98BxqO
 Zr+NYFeijGBi9TyivHIDuu4C+eQD24N30msfIfOGC8fIWjrx8Bw2f54OU62638E1KNFi+FIFQXs
 6VMrijnoTRYqrYhNGYiN3A+uBXrl8LhQ6pMozkDdR+PiAGzaoXXIUD8xtI8/EIoBe97vQD3zwtE
 izlI36mbbakfWfRnNUwE4Q4nmUM7mzvqcn2Ip3fQjlaHX6NH5RkxCiVKvanFJdm2M3tJPynEsHY
 yoY8PKn3c4oB/9jWyjekitC7BTuxSS6a610+ydStIH9I13+zXM1aSX30JTEOBDVsrOEiwXxBp17
 UOXB5V7pAlydsfpoiIixGQaVePQxVIfrxNYX6GGIOQoUlMfy3biXw1d0FcErimRhHFIg==
X-Received: by 2002:a05:6000:2dc6:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-43fe3ddcc21mr41618573f8f.21.1776945643852; 
 Thu, 23 Apr 2026 05:00:43 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1405sm52523987f8f.4.2026.04.23.05.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 05:00:43 -0700 (PDT)
Message-ID: <f37d6f6c-49ac-4725-ba4f-b7ce0a3baa5a@ursulin.net>
Date: Thu, 23 Apr 2026 13:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DRM Equivalent for top
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Francis, David" <David.Francis@amd.com>,
 list DRI developers Maling <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>
References: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
 <eabe4e7e-00b4-443a-930c-d838a9aa96e2@ursulin.net>
 <c99d0439-767e-4a87-b47c-f9d6020c774d@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <c99d0439-767e-4a87-b47c-f9d6020c774d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 23/04/2026 09:14, Christian König wrote:
> On 4/22/26 17:05, Tvrtko Ursulin wrote:
>>
>> On 22/04/2026 15:40, Francis, David wrote:
>>> AMD have had some client requests for an equivalent of top that works with our drm driver
>>>
>>> We're looking for an interface that
>>> - Can be used by processes with no particular privileges.
>>> - Gives a list of which processes are using a drm device (by pid).
>>> - Can give (driver-specific) information about these processes.
>>>
>>> We'd like to do this in drm, but drm doesn't track the pids of processes that have drm
>>> device files open. It only knows which pid opened the file and which pid last touched it.
>>> For example, if an X server opens a drm device file, creates some buffers, and then hands
>>> that file to a child process, drm might still associate it with the X server.
>>
>> Slight correction here - DRM tracks the last ioctl already (so last user) since 1c7a387ffef8 ("drm: Update file owner during use").
> 
> Yeah that clearly got better but I think it is still a bit problematic.
> 
> We have use cases were one process uses multiple driver connections, so identifying things only by PID is something we try to avoid.
> 
> The fundamental problem is that Linux in general doesn't track which file is used by which process, but only which process uses which file. So we don't have the back vector.

Right, for the "how to efficiently list all DRM clients" angle, okay.

>>> We would like to do this through fdinfo, which does track by pid, but that would require
>>> making part of fdinfo public, and we received negative responses to that.
>>> https://lkml.org/lkml/2026/3/16/1816
>>
>> Would setcap CAP_PERFMON on the executable be good enough?
> 
> I don't think so.
> 
> The fdinfo access is currently protected by ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS).

Right, sorry, I was very unclear. What I meant was, if the patch which 
was rejected by the fdinfo maintainer was changed not to propose making 
access public but gate behind CAP_PERFMON _and_ new FOP_PERFMON_FDINFO flag.

I sketched it out, on top of David's patch, here:

https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=cap_perfmon_fdinfo

With that if one does "setcap cap_perfmon=+ep $IGT/tools/gputop" it can 
enumerate and show GPU utilisation for all clients. Well all which have 
marked their fops with FOP_PERFMON_FDINFO to allow that..

I am not saying this is great as it adds more code and more inefficiency 
to an already sloppy path of client enumeration so for discussion only. 
It is exposing things less so may have more chance as an interim 
solution, or it may not, I have no idea.

Regards,

Tvrtko

>>> Would the public-fdinfo idea be useful to anyone else? More support might help push it
>>> to acceptance. Alternately, is there appetite for an alternate interface that could
>>> provide what we need?
>>>
>>> Thanks,
>>> David Francis
>>
> 

