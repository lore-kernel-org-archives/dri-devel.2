Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A10DCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A170510F528;
	Fri, 15 May 2026 12:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cFJQxP8o";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C0710F521
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:58:25 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gH6gy08LFz9txZ;
 Fri, 15 May 2026 14:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778849902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPw7LGzoduvEREvDI8bkRAn05Q+tVmQfqSAUu5raJdE=;
 b=cFJQxP8oE21WCIwz7uMIJmJz+IisHYMoUnVK4s0QCBboE7m/n8xeTvKGl5wLH9V0EX+hYz
 JzMy53U7c2wAff/SsOsA8Pqx/O8rJJMV2vMGe5xzcaZ/2dAOa3zMYPQt49nEB2Fm2yKtwq
 mS4ifReD0M7QQ1XUEtFIR87uWFj9Z76MBpH2TWsDQ39ACYgGIf7C7p9A6qKFXX7i76fVT5
 RVu4wdbGnaVtEbvkx/7yH1y90Dy2LySqPGsBbsV3s+B5CREexaKOhidMr91gMdcbTflqQe
 K2+pRDJXkoCCRHU5ND97QiLoWsSB2MSTDu1TEHyelocpfPr5ezpryWylJX6qBA==
Message-ID: <55dfe576-6c49-4051-92e3-a0a678ba8187@mailbox.org>
Date: Fri, 15 May 2026 14:58:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/syncobj: Fix memory leak in drm_syncobj_find_fence()
To: Liviu Dudau <liviu.dudau@arm.com>, Erik Kurzinger <ekurzinger@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simon Ser <contact@emersion.fr>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 Sam Spencer <Sam.Spencer@arm.com>
References: <20260507144425.2488057-1-liviu.dudau@arm.com>
 <agb9Bq2y6tq0z6at@e142607>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <agb9Bq2y6tq0z6at@e142607>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: htjct3h6k1g36zpbyspd56i3xofxd9rm
X-MBO-RS-ID: 8a0091de48236636a10
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

On 5/15/26 13:01, Liviu Dudau wrote:
> On Thu, May 07, 2026 at 03:44:25PM +0100, Liviu Dudau wrote:
>> Commit 18226ba52159 ("drm/syncobj: reject invalid flags in
>> drm_syncobj_find_fence") forgot to take into account the fact that
>> drm_syncobj_find() takes a reference to syncobj and returns early
>> without dropping the reference, leading to memory leaks.
>>
>> Fixes: 18226ba52159 ("drm/syncobj: reject invalid flags in drm_syncobj_find_fence")
>> Reported by: Sam Spencer <sam.spencer@arm.com>
>> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Ping on this patch.
> 
> Erik's email address is bouncing, anyone else willing to give an ack?

Trying Erik's gmail address.


>> ---
>>  drivers/gpu/drm/drm_syncobj.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index 8d9fd1917c6e6..c9dbf64c0c9f2 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -442,13 +442,15 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
>>  	u64 timeout = nsecs_to_jiffies64(DRM_SYNCOBJ_WAIT_FOR_SUBMIT_TIMEOUT);
>>  	int ret;
>>  
>> -	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
>> -		return -EINVAL;
>> -
>>  	if (!syncobj)
>>  		return -ENOENT;
>>  
>> -	/* Waiting for userspace with locks help is illegal cause that can
>> +	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* Waiting for userspace with locks held is illegal cause that can
>>  	 * trivial deadlock with page faults for example. Make lockdep complain
>>  	 * about it early on.
>>  	 */
>> -- 
>> 2.54.0
>>
> 


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
