Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B39C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEB610E02F;
	Mon,  7 Sep 2026 11:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="ob+WvKTP";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0857510E02F
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:06:58 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c263110a8cdso213158566b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788779216; x=1789384016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dhAjW+vdg6oBYt2ixKDAKgKvkSQhUYU9D5adc0m7hns=;
 b=ob+WvKTPgnJ61Za31t4Yj3Fx7OTod623C7TW+P0d396TbdzFpl6ryq3j5VnHqmyuoB
 qCuBTNZTZt+A/O7wIveEhD+2peluaZaWngHXP6IEzpmLBknEKEdeiE2MEWQsu0El0s6S
 UJYBVHER6UhG59183T6SavNL8x0Sp4JeCF8CddgQmPaykMQQYanc6VKKUOMhOqdPCMEY
 g7XKJ4SRDrMakzYD53zdghJ3gvN0FptFs2Jixlvc1kJpeqiza0GhdruEJpIFmuv7YVLe
 KqaE48KyOyPma7AjLB4JvV7H4Khm7Fuyo1Gdi+cKKWInrKxWWf172JwAMfhYu3pKs9Wt
 gUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779216; x=1789384016;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dhAjW+vdg6oBYt2ixKDAKgKvkSQhUYU9D5adc0m7hns=;
 b=BB5X8H4rYT5NvG2kNZjyvxwbdE2LBFAZxtlnFSJhSGMN7D0vOrqVApKggpkuJyEATr
 SLQAePJg59GQTJKqPs9aJwSyqI+DPItvasCNRuzC2UfT2m4jl979uHNUHbDyLdOnV+J8
 5/kDF47ujfDc8pzeVO0DGOICDZWUrhyrpJpszUf5558trLGMHABsxcutIAGh32JdsV2D
 UWeYJAzm4Bs+yr4bCGXOtztxtHdaHRq2b0FJ38v9cfsQWGyu3QvHRlwTDtdad0d1mPSf
 7OW2bG5MHTQ6Il+okndAipuF7zpAxqBrixX9Sp0zQyu4AIxN0Cn2dSyQgoACAlm3j1cp
 nUUQ==
X-Gm-Message-State: AFuF++lb6w94xzhfGeT+EAaXLMe4aw83ieWdfB2lfRyHNi0MJA1mEqjL
 CHYw1jnHl8e/PzFZZb/fNPyvXZzsGl4CLHmBwtFKCmSp0EECII8D3qo2QhYzuJuz50A=
X-Gm-Gg: AYBFou3kHhpiJNk6v4pIceB1Uhr+I5zH8sybaDzr4VOFZq+megC2I7JWB/yBtdVBODG
 ywp9Gkhl8R2B0Vq/c/aDsNpIK7XMWTNZyZm8eNUZlkXKRGTkBXLZ7Nrqik5vbdZM8KGH8443QdV
 dhoSYmxVqg5FpHkNgpvCmb2/NqDjvwkfKPjoNKlaweuy7qO1vhEEKSoKW9E33g7/3579U1/Ayb/
 ReGDl4M557gdm4y0NCE0DlW+R8jzutQpTsu/uYeqTTYChxAgeZwv0A6wAcfARjDpxfJpWVpJqTX
 G6nxPvVhIqct0/I/4SO8kgJrpTvhIMvBACdvgi2RM5rltJLWlZes++1aj+2zZImBLRoFcvMS42h
 +nSfLXZIFda+AEqkuOT4hcYAjnLZXqlAv0dAdA/KvpYCJfo1fr69TUS3aqUJTKdp/zNnwBVOWAV
 YqGhAnB/Lo0pJ4v5JzJgi++3wFROq259MWsASlTaPWujrsYS9/6KGoSH7ldZ18qHe9TTvHsCpy/
 1mw2SiLH58NxZk=
X-Received: by 2002:a17:907:3f98:b0:c26:19e3:e986 with SMTP id
 a640c23a62f3a-c2619e3eef0mr722713366b.38.1788779216293; 
 Mon, 07 Sep 2026 04:06:56 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262ccca88fsm290331366b.17.2026.09.07.04.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 04:06:55 -0700 (PDT)
Message-ID: <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
Date: Mon, 7 Sep 2026 12:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
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


On 07/09/2026 11:47, Philipp Stanner wrote:
> On Mon, 2026-09-07 at 11:28 +0100, Tvrtko Ursulin wrote:
>>>
> 
> […]
> 
>>> How did the others fix that?
>>
>> Combination of kfree_rcu, synchronize_rcu and storing the name in an
>> object protected by those:
> 
> […]
> 
>> For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.
>>
>> That makes scheduler timeline name vfunc safe:
>>
>> static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
>> {
>> 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
>> 	return (const char *)fence->sched->name;
>>
>> sched is then RCU protected. sched->name is already static so not a concern.
>>
>> As you say nouveau_sched_fini() only tears down the scheduler after
>> fences have been signaled it seems adding two new kfree_rcu make is safe.
> 
> 
> I don't see how any RCU mechanism would make anything here safe.
> 
> As long as ops->release is implemented, ops will never be set to NULL,
> (with or without RCU) – so everyone who holds a reference to finished-
> fence can still run into drm_sched_fence_get_timeline_name() and cause
> UAF on the sched pointer *and* the name pointer.
> 
> Moreover, all of this falls apart should the driver unload.
> 
> So I maintain the position that we only get it right by having the
> signaled-bit be the decoupling point.
> 
> Or am I missing something?

The driver fixes you asked about and I listed work(ed) in the context of 
506aa8b02a8d ("dma-fence: Add safe access helpers and document the 
rules"). In that "world" it would have been safe. Did 035219a760ed 
("dma-buf: dma-fence: Fix potential NULL pointer dereference") break 
those fixes a bit?

I can try my IGT and see..

Regards,

Tvrtko

