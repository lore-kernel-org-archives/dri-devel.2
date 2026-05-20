Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EAFCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9098F10E14C;
	Wed, 20 May 2026 15:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="quuL0OnN";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 776C310E14C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:26:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B668416A3;
 Wed, 20 May 2026 08:26:44 -0700 (PDT)
Received: from [10.57.33.178] (unknown [10.57.33.178])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B9BF3F632;
 Wed, 20 May 2026 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779290809; bh=7n6+w/JNJIy9JBoZEpq6DMA9zKTx48lQeLJC8YLMxp4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=quuL0OnNg2zLJ2BDZ1cDhvpe34hP8cBpi4dNiIS7uWI9QJj/QpjNuoupzxo27MkGx
 7LeMTtSADUfabpkVQChWMdtc+4mKpoJRgcnVPE6zou0KA1WiuebrMJEOWWZYcDDf6+
 kwMaqTeo6QGyfMGTBU6A0OGpW+xw8UfHYagH5+v8=
Message-ID: <6923c228-b81e-4d02-b59c-a21b2212318e@arm.com>
Date: Wed, 20 May 2026 16:26:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/panthor: Driver-wide xxx_[un]lock ->
 [scoped_]guard replacement
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-1-f2d8c15a97ce@collabora.com>
 <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
 <CAPaKu7S9WMbJERrWa=bj5qyQg72no9MPex6S1MY6t8nXoMbB-Q@mail.gmail.com>
 <20260518104356.71827224@fedora>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260518104356.71827224@fedora>
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

On 18/05/2026 09:43, Boris Brezillon wrote:
> On Thu, 14 May 2026 10:09:10 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
> 
>> On Thu, May 14, 2026 at 6:24 AM Steven Price <steven.price@arm.com> wrote:
>>>
>>> On 13/05/2026 17:58, Boris Brezillon wrote:  
>>>> Right now panthor is mixed bag of manual locks and guards. Let's
>>>> make that more consitent and thus encourage new submissions to go
>>>> for guards.  
>>>
>>> I'm fine with encouraging guards for future code - but I'm a little wary
>>> of a big change like this - it's hard to review it and check that
>>> everything works the same. And it's a little dubious that the mechanical
>>> refactoring produces more readable code in some cases.  
>> I agree with Steven in general, although I am in favor of landing now
>> that you've gone through the trouble.
> 
> Honestly, I agree with you. The only reason I went for it is
> because the mix we have right now is pretty confusing. This has to do
> with the fact the scopes are often loosely defined unless you used
> scoped_guard(), so it's pretty easy to mess up the lock/unlock
> ordering. For instance,
> 
> 	mutex_lock(locka);
> 	guard(lockb);
> 	mutex_unlock(locka);
> 
> 	...
> 
> once expanded, turns into inconsistent locked sections, where the inner
> lock (lockb) is released after the outer one (locka).

I think that's a good argument for getting all the guard forms available
before tackling the conversion. Mostly I feel like it would be benefit
from being split up into multiple patches (maybe one per file?) so that
there are smaller units to review.

>>
>> I also have mixed feelings about some of the non-scoped guards. Their
>> scopes are extended slightly than before, supposedly to avoid adding
>> another level of indentation. But other than slightly slower,
> 
> I tried to used scoped_guard()s every where the extra non-guarded
> section could be CPU heavy (the only bits left are some very simple
> bit/arithmetic ops, and a couple queue_work() IIRC).
> 
>> it also
>> becomes less clear what exactly do the guards protect.
> 
> I know, and I have pretty much the same feeling, but we've crossed that
> bridge when we started accepting non-scoped guard()s, unfortunately.

The problem with scoped guards is the extra level of indentation.
Personally I find a mixture of all three is appropriate depending on the
case.

E.g.

int small_simple_function() {
	if (simple_condition)
		return early;

	guard(lock);

	if (condition_that_needs_lock)
		return early;
	/* more work */
	return late;
}

Here it's easy to reason because the lock is just held for the duration
of the function after the initial early-out condition is checked.

int short_lock() {
	/* bunch of work */

	scoped_guard(lock) {
		tmp = read_value();
		if (tmp == 42)
			return -ESOLONGANDTHANKSFORALLTHEFISH;
		tmp++;
		write_value(tmp);
	}

	/* more work */
}

Here there's a small section of code which is working on the lock, so it
makes sense to indent it to show the boundaries of it. The other nice
thing is that the error return handles the locks for us.

int old_fashioned() {
	if (lock_required)
		mutex_lock(lock);

	/* some work */

	if (lock_required)
		mutex_unlock(lock);
}

Generally a pattern to be avoided if possible, but IMHO this is much
better than the equivalent of:

int dodgy_function() {
	/* some work */
}

int outer_function() {
	if (lock_required) {
		scoped_guard(lock)
			dodgy_function();
	} else {
		dodgy_function();
	}
}

which requires breaking out the work into an extra function and
duplicating the call (or worse duplicating the function body).

One thing I do agree is that mixing and matching within the same
function is a recipe for confusion and mistakes.

Thanks,
Steve
