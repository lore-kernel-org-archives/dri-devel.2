Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5953DFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBFC10EBC1;
	Tue, 28 Apr 2026 13:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="niMQvys8";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECA510EBC1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:40:07 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488ad135063so104116375e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1777383606; x=1777988406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Orx5/gPWDKP0X7XcJxaQkFmZgHlHVZHIc16Qggo3SU4=;
 b=niMQvys8UuO/BwfTYjoyZIpzKAn2HuhTZOZmCwOidsh0BQWLq7IelY50SD1YHgyoVb
 RXTzAvnGC2p9SXk1eAOQKHznYyiqq9goOxDPnlALhj3g1iq45ux+rnOTdBweu6t+3Mxs
 jje+96iYNVFX1Ddcr0JesTf253rP/SmIc+8dNpdYXNx+tp8722n/A6B3oTzTdAnNW/4Z
 z7x7OBJAq6cxlVR3KV29Maqy3VG7Ngx7gpe9TlDr+BoAL8xLE7cHIrvcajFGvcBEQD4u
 oxCHE55yk42eZh6mQvGlg/0UuMObZCfwPPprrrqNWN9FuFqmQyOy/7XPUkZ1WYuitQQd
 24dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777383606; x=1777988406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Orx5/gPWDKP0X7XcJxaQkFmZgHlHVZHIc16Qggo3SU4=;
 b=Qp2F65hRD9xN1fun1KcHtRnHU2SkPMoKM89OyNVDtCRUZCP4+haDSWWFFxBqpERRMS
 vCPQnzTAFy4wmxzEO6GeMzKmUzXl24HrwqDdvET//rgzTAtrTZYBibC8vaasThgsPB/s
 Z1xNov7ZYvzz5twlzRkJtohvJAZp6kp54iZu4Vn/NCda0W8KD3GQ/ZuUgYY7VrZz3qh8
 EEkMWAuvCtuynlyEwASuc5mR8w2Kf7kIe5vL3YDzVHHeZ0sqUvD3thK257bnqny8UDTd
 TV26rpePeZK3C1PozkhrbtjbXM4m4Oe90NbWkip7OwUmTsFFHh9MSJw9bcZAZUsSq8vO
 FGew==
X-Forwarded-Encrypted: i=1;
 AFNElJ8l6jNJd7WWiccr7A1kGZTixQfcj2ldCGLPDZ1LKyjDwG+QfbsgQW8yX8oYQEzJr40T5+x6JORPClQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXYFGoSojBgWNbWSEGqwlT4rGD1+OSqCS9QFyQRZqBxuollbNv
 MzvwSuWCR5eHxgwc0C1N2xNKyH++BxhDHnShejwGx06zzHkgcVgtY7K0D6SwgGNN0AzUq7QFn5y
 e119B
X-Gm-Gg: AeBDiesaLr4eO8GcubTh8DXoPqYaD4dxT3885COtjFOb2vGanuyz66O5AZhGumG20NQ
 XPNO9AQXPSoc+Jr+iVvCQj7ixUzBQfFsSmKnrv3bCwt64jnmDlyrA/yxbsb2VmHVZP6haG7PKDM
 jYK6MmJzrM4xVQaxUs7LEJ3VlVGvepGeMMj7CeCgFEJEODU1WCul8ubE31IJEpu+LnLN6hfsfBS
 RzNw86xwogxtrpQtwT+O4xD5w/cwRuEqbooDwl8OzXegKet3QGH4QbGurQUCZvfg5WmXHKf4+SC
 D8kcptSVFKGQ7XlZUzBgTDB1oHbqeJ2ABk2D6nqfe/cxGDOtyfplfjOVbs+6dO58nm63w3ojM4c
 WWjzhWra7I5s8s23GmctSC++EO2TvxygdJGPnbcCakz2onGAE4fYijkLtU9kEKbVSmA1AO8mBm5
 sUtPIcyJMppQ0JkyXxWsCDxpgmtlPC6US3bRPwRseMMhM1j1Ijyd58cT8=
X-Received: by 2002:a05:600c:81ca:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-48a77b24e5emr49976715e9.27.1777383606012; 
 Tue, 28 Apr 2026 06:40:06 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463f4c0a35sm7480396f8f.22.2026.04.28.06.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 06:40:05 -0700 (PDT)
Message-ID: <2ee10ed2-09d6-4d80-a94a-d6076654ecdb@ursulin.net>
Date: Tue, 28 Apr 2026 14:40:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DRM Equivalent for top
To: "Francis, David" <David.Francis@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 list DRI developers Maling <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>
References: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
 <eabe4e7e-00b4-443a-930c-d838a9aa96e2@ursulin.net>
 <c99d0439-767e-4a87-b47c-f9d6020c774d@amd.com>
 <f37d6f6c-49ac-4725-ba4f-b7ce0a3baa5a@ursulin.net>
 <759f311f-3551-4a3c-b889-8149de7081ef@amd.com>
 <SA1PR12MB814414F7DF978B9FFA3B626DEF362@SA1PR12MB8144.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <SA1PR12MB814414F7DF978B9FFA3B626DEF362@SA1PR12MB8144.namprd12.prod.outlook.com>
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


On 27/04/2026 19:38, Francis, David wrote:
>> I sketched it out, on top of David's patch, here:
>>
>> https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=cap_perfmon_fdinfo
> 
> Thanks a ton. I also did not know about this.
> 
>>
>> With that if one does "setcap cap_perfmon=+ep $IGT/tools/gputop" it can enumerate and show GPU utilisation for all clients. Well all which have marked their fops with FOP_PERFMON_FDINFO to allow that..
>>
>> I am not saying this is great as it adds more code and more inefficiency to an already sloppy path of client enumeration so for discussion only. It is exposing things less so may have more chance as an interim solution, or it may not, I have no idea.
> 
> Yeah, finding the processes that use drm by going through every fdinfo for every process is still not great. But still, it might be the best we can do from this position.
> 
> Is it okay if we build on this and send it to linux / fs mailing lists (with credit to you of course)? Or would you rather do that.

You can pick it up, no problem. I am curious how it will go so please 
keep me copied.

Regards,

Tvrtko

> ________________________________________
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, April 23, 2026 9:29 AM
> To: Tvrtko Ursulin; Francis, David; list DRI developers Maling
> Cc: Simona Vetter; Dave Airlie; Deucher, Alexander; lucas.demarchi@intel.com
> Subject: Re: [RFC] DRM Equivalent for top
> 
> On 4/23/26 14:00, Tvrtko Ursulin wrote:
>>>>> We would like to do this through fdinfo, which does track by pid, but that would require
>>>>> making part of fdinfo public, and we received negative responses to that.
>>>>> https://lkml.org/lkml/2026/3/16/1816
>>>>
>>>> Would setcap CAP_PERFMON on the executable be good enough?
>>>
>>> I don't think so.
>>>
>>> The fdinfo access is currently protected by ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS).
>>
>> Right, sorry, I was very unclear. What I meant was, if the patch which was rejected by the fdinfo maintainer was changed not to propose making access public but gate behind CAP_PERFMON _and_ new FOP_PERFMON_FDINFO flag.
>>
>> I sketched it out, on top of David's patch, here:
>>
>> https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=cap_perfmon_fdinfo
>>
>> With that if one does "setcap cap_perfmon=+ep $IGT/tools/gputop" it can enumerate and show GPU utilisation for all clients. Well all which have marked their fops with FOP_PERFMON_FDINFO to allow that..
>>
>> I am not saying this is great as it adds more code and more inefficiency to an already sloppy path of client enumeration so for discussion only. It is exposing things less so may have more chance as an interim solution, or it may not, I have no idea.
> 
> Wow that is impressive.
> 
> I knew about the capability system but had no idea it could do something like that.
> 
> When that works it looks quite reasonable to me.
> 
> Regards,
> Christian.
> 
>>
>> Regards,
>>
>> Tvrtko

