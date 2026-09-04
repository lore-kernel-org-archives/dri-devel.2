Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE35C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1D510E2B7;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKk4PUMN";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD4C10F95C
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:31:45 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-852c481415fso787995b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788510704; x=1789115504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p4WLi0L/B/Ti355IxU6nG0ELeTToNoFw6PkBrzW0jhc=;
 b=BKk4PUMNSfcqZx1KN+L+iv2cnlnO65IcZa9TXzwfoGbwevqs2VgmVTw2nJRG7aGGpM
 OlZSpwulmjyQPlOnKhQshfvwSP3C4DE/9bOOzAbCrT0fM9BKsPM5mcuPKzy0sW33esL/
 i8RQzUafa8v0vtRPILTFjqPbMaWyBpwJIjPH0S19eN6Peu8Rj9PwOHXypJqQ8vvxlm/n
 3E7o2uRTqfGceLnWWtUVX0997YbdmsjxvpnJW79H1xFx5S1DDxUffVxb1dg/lit6uAdv
 uiOh5/vBX/z2xjj+rz8sDfVd9y9Igbreh62/nITfUU2rlzakf1x2HyM+O1ydp7lz+tfS
 m1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788510704; x=1789115504;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p4WLi0L/B/Ti355IxU6nG0ELeTToNoFw6PkBrzW0jhc=;
 b=Tx/Zncxp+jpmwVU5wLea5VdaCXVcQQg0LBYJbtNIuBrkkLmAihcZdNm0Bjee7UXkwM
 rRBWuOLjtSd73bnraVO8E2VISCOVWS5CGQOK4k3G2Ab0DOd6t0STs86DUWYwT0/R+9d0
 E10x2uK2xcNkL042CuKLAKAB7agwYMbIAOe25OqKb5T6IxFaKd3pn8j66+cWYT5RMhct
 f/WPzqFxRqcjqDEHWFghFfvUe0kmW69hHekddcvTUsEBjcTIGhPSGIv9hxy4GsmDbYgw
 wO2pneIdegsIsCNef31CJ0w/N7BQgSn2lrb6oFZVZU0SfyxaHZxyr3pjjf4hSDGBai5V
 3Fqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOT9qEt2XeNtKyE6Rshb0hC/MILXG65FGgMGYFi4UYth38baDKuB9YBQA8RS1Q6UCr2jCCBAoMRL8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kriQ2DqqhCGzUx0zL/DCpSjXI/4HawgRaCGegYxIjBBQDh/FnK
 FWlrxDQn3/UomUO4oOsqnQb8EaYo8fnlGLpxBit+nmzoSCAeVb0xDT8=
X-Gm-Gg: AYBFou3er06icSm8WLFlVhto7ylTnILPcvrKM7Zw6ndjXS1R8FGEyY3uhTKks2aCVhL
 ifhQB1UyasokpyPWXxVd6jsqDBjotS9wRkWpd3w9CUswHOMKH8YJgMwqkd1fi2MMCKxaT5pQ46b
 LJrEXD5bz7AZvVN9FBlKiufmbp+DNKX3uor6EE78QyuVh0RPZ5nQh61+/PhCP7yuNRWsZYtiAb5
 ZdEvN2eZbSdMigH7kDyE1KcW1UeuynJN2C0OIjqePGF/1KXMfwvbNTO3UpVaSYEmUMVWbp73bL+
 TXevh3+2zZJQeFmtvPwbEJ6/yxZtXQYbLDbrjOHEoZjtUAv84rsWOWE48F1MKRIowFw/fRN+hve
 Bdgf2hmPQ57JzECb5sx3+7tTnPl86gRGppr+srfaYqb47u5rvm+M+/NZ9nYDr4Q+1Mn0r6BTJB3
 ilXRRXiXNJKoWuRDFKs7jzrtev23PuQPnopPzx10ZgtSXxsvoYnBcdlxjc/4zNuEUotH7GZ8dbl
 v3e982r3/RI9xNd5epeBnX7IPI=
X-Received: by 2002:a05:6a00:300e:b0:857:7337:5dba with SMTP id
 d2e1a72fcca58-8616b373626mr7144753b3a.24.1788510704466; 
 Fri, 04 Sep 2026 01:31:44 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-861537284c6sm861515b3a.49.2026.09.04.01.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:31:42 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: christian.koenig@amd.com, phasta@kernel.org, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Date: Fri,  4 Sep 2026 17:31:38 +0900
Message-ID: <20260904083138.2135429-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

On 9/4/26 10:20, Christian König wrote:
>> +	return fence->sched_name;
>
> I don't think that this actually solves the problem, the sched_name still
> needs to be kept alive until all fences are destroyed and that is something
> drivers don't want/can do.

Agreed, and that is the same objection Tvrtko raised against v1. Caching the
pointer only moves the lifetime requirement from the scheduler to the string,
and the documentation hunk I added just pushes that requirement onto drivers.
I will drop that patch.

>> +/*
>> + * TODO: Both fences implement .release, so dma_fence keeps their ops attached
>> + * after signalling. Dropping the callbacks would let dma_fence detach the ops,
>
> That sounds like a bad idea as well.
>
> Dropping the fence->ops is to detach the fence from the module which
> originally issued it and not solve lifetime problems between the scheduler
> and the driver.

Understood - ops-detach is about producer/module decoupling, not about the
scheduler's lifetime relative to the driver, so framing it as "the complete
fix" for this bug was wrong. I will drop the TODO patch as well.

> I think we should rather re-consider patch 035219a760edb35ae9a9e96beba7f122e26a997b
> ("dma-buf: dma-fence: Fix potential NULL pointer dereference"):
> [...]
> The problem is that we didn't considered that there a fence implementations
> which still have a release or wait callbacks but rely on not needing to
> return a string for a signaled fence.

That matches what I see in the code, thanks - this is the actual root cause and
it is not drm/sched specific.

dma_fence_signal_timestamp_locked() only clears the ops pointer for fences that
carry neither .release nor .wait:

	ops = rcu_dereference_protected(fence->ops, true);
	if (!ops->release && !ops->wait)
		RCU_INIT_POINTER(fence->ops, NULL);

drm_sched_fence implements .release, so its ops survive signalling. Before
035219a760ed the helpers gated on the signaled bit, so such a fence returned
the static string and the producer callback was never reached. Since that
commit they gate on the ops pointer alone, so get_timeline_name() /
get_driver_name() are called on a long-signalled fence - which is exactly the
window my report hits, with ->sched already freed.

To be clear, I am not suggesting a revert: 035219a760ed fixes a real problem,
namely that "set signaled bit, then NULL the ops" and "load ops, then check the
signaled bit" can be reordered on weakly ordered platforms, and using the ops
pointer as the synchronization point solves that elegantly. That property
should stay.

What seems to be missing is that the ops check answers "may I dereference the
pointer", not "may I call into the producer". The dma-fence rules say the
latter is not allowed once the fence is signalled, so I think both conditions
are needed:

	ops = rcu_dereference(fence->ops);
	if (ops && !dma_fence_test_signaled_flag(fence))
		return (const char __rcu *)ops->get_timeline_name(fence);
	else
		return (const char __rcu *)"signaled-timeline";

The ops load keeps the RCU/ordering guarantee from 035219a760ed, and the
signaled check restores the contract. That fixes every implementation which
keeps .release or .wait and assumes it is not called after signalling, rather
than just drm/sched, and it puts no lifetime burden on drivers.

Philipp, since 035219a760ed is yours - do you agree with adding the signaled
check back on top of the ops check? I would rather have your ack on that before
I respin.

One thing I noticed while checking the callers: the tracepoints in
include/trace/events/dma_fence.h and drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
call fence->ops->get_driver_name() / get_timeline_name() directly instead of
going through the helpers, so they are not covered by the above. That looks
like a pre-existing and much narrower exposure (tracing only), but let me know
if you want it addressed in the same series or separately.

So for v5 I plan:

  1. dma-buf/dma-fence: add the signaled check back to dma_fence_driver_name()
     and dma_fence_timeline_name(), Fixes: 035219a760ed, Cc: stable.
  2. Keep the KUnit regression test - it exercises exactly this path through
     dma_fence_timeline_name() and needs no change; it also picked up the
     teardown issue the review bot flagged, which I have fixed locally by
     using kunit_add_action_or_reset() + kunit_release_action().

and drop the drm/sched caching and TODO patches. I will wait for your and
Philipp's input before sending it.

Thanks,
Jonghyuk
