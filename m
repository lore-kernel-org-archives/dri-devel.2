Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5C8C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0A710E11C;
	Fri,  4 Sep 2026 07:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sz6YA3LX";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CE510E161
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 18:01:42 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8485b358552so75903b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788458502; x=1789063302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xjazdtGuj7thY8vVrVUeII/vHI3KkN+Fj8pG30w25iU=;
 b=Sz6YA3LX5ISX7AQPFz+aLGwiioTacICDKjk2BB7xRsqxpek0mH9MT6A2JKEvODEzV6
 C4LDqeQ0Uj6D82geYf5xeQEP7xMYETmE+uORvaS0iUhmBYNEQIGOiqbvN4GGa5emzQNH
 EipM3Dq8HaVfG+FBrz7pMjO6S7ShlDCws2J+rg4QPD5qlByXNAsbM6biNwAUocKVudyo
 dwmjCOYt9v2wNnxkw38fUodkeMq8Nfwt1AbJv83ROIaXZf+/cuY8YkWb2WpY2ZGQUIdD
 UR4JPe4y76qV31xWxdOgACxvNUrtYtjMZpnFFjJlUn8OxkL+JKhoENen8Xja+bjYnmSk
 P1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788458502; x=1789063302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xjazdtGuj7thY8vVrVUeII/vHI3KkN+Fj8pG30w25iU=;
 b=Snpz4dF2sX6YoKzdDh2UE2xFOwS6Xj4IOAPX9xvfRjuqZRLAWrFekOdnJ60XZs33fF
 Vcr7azdspmu7rPuPEf+8oL+wsDrTmwkNvlLOtPezuAt6EH3JaLY0iXPTFKAesKaAubIo
 BCRivQEZDZmaxGyf7E7B1m9J6pC1saef64cJqNGD9ijixI2zrU8bppfJSTtgUeAhrloM
 ujBRMHz7ihzlG9mddMVX8EuQiW0av51dB00oIudHr6LgtegxTrZ0xx8Wq9HCK7AMtP+s
 eETeTb5Nv+2QkQX/BJTAYFXzvM1E0cLvzxO/Y+/Lmm/XTnTdwPNzcWlipQjsVnA+r0Iz
 1xUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZNibAlSdzDlqUsrylxJCfY/oqnWawnZZ5sTjwC5MtaCNcSebuRqvCED7cULwaS6DTIt9VJG0X2Nc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k8DM35ajYJbHnJZ9Ox7yFCF8V4O+0FEGwiNGrWJ9LVovyY29F4
 BDzzjkNVFuhsVy0/2/+nLzNNUg925Dealrh2a4eU5FWYj6mT/r+Yiiw=
X-Gm-Gg: AYBFou2tTJP/eX/uo6GpoieKQS8l++qfkHGZokqcXkn8msHpY/Zf9SGVnRCnIM2JWm2
 Fzd+Dh8g0HjNxAPQfmE4D4ctfTr258qwvg2pgp3adZGoWcfa9QGctio1vvXmV8/qN/Nj3dEJCRs
 9cLGnsO1rrv89LLyhrRTJqdwtEGZDiEi38Rxg4KdwvZ2cKNlEG5oJJVr39hQ4WYQjXwR5G4lYhl
 ocPn+rdAPZ6jknJ5gH24Ut7HGOuU5lwlWHKI7l4Wq4nnptsj2MvDFKxXGpepQBd/bL+7VLTmVlQ
 jormpgS9PKMfQscj0mxVod4LHh5NbM1KLp9gWVIEAOSpXhMM497BM/ZaqoeddnSOnNgSY9b78Ib
 fciLc6xPqHqaSNgdMVwmX6HrTRPMBQuldfqtdv3sf1Z+Fb1o6jz9OiDzFDeMfRIiPI5CMwsKKlm
 nazCu0Zhk+ODOEwTuZSQ1PN1f00qkFDdIk6tot3qhukDgB6aZrKqqo9WMERFWLJuxKu+l4SSgBD
 YJ88wRrjHANLxdxUUPBblAtQco=
X-Received: by 2002:a05:6a00:1950:b0:85c:3922:25d5 with SMTP id
 d2e1a72fcca58-8616aa68194mr968000b3a.21.1788458501589; 
 Thu, 03 Sep 2026 11:01:41 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152d29654sm248926b3a.33.2026.09.03.11.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:01:40 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: Re: [PATCH v3 1/2] drm/sched: fix use-after-free of the fence
 timeline name
Date: Fri,  4 Sep 2026 03:01:34 +0900
Message-ID: <20260903180134.950043-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <611c2624e60ea422229e666480da3e504d126682.camel@mailbox.org>
References: <20260902144204.1843670-2-malhyuk97@gmail.com>
 <611c2624e60ea422229e666480da3e504d126682.camel@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:19:31 +0000
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

Thanks a lot for the thorough review, and for pulling in the pvr folks.

First, the important one. You flagged the ops-detach as dangerous, and after
your and the bot's pointers I agree it is not viable as-is:

 - amdgpu dereferences the helper unconditionally, e.g.
   amdgpu_cs_p2_dependencies() and amdgpu_ctx_fence_time() do
   to_drm_sched_fence(fence) and then touch ->scheduled without a NULL check.
   Once the finished fence detaches its ops on signalling, to_drm_sched_fence()
   returns NULL for it, so this is a deterministic NULL deref an unprivileged
   process can reach by submitting and then referencing completed jobs. That is
   the bot's [Critical], and it checks out.
 - pvr is worse in the way you described: pvr_queue_fence_is_native() uses the
   ops pointer as an *identity* test, so detaching ops makes it race between
   "native" and "foreign" for one and the same fence.

So detaching the ops breaks the "identify a drm_sched_fence by its ops"
contract that these drivers rely on, and papering over it would mean auditing
every to_drm_sched_fence() caller. I don't think that is the right trade for a
fix we want to backport.

Christian's point that the finished/scheduled .release callbacks are
"unproblematic for the problem at hand" matches this: the release callbacks do
not need to be removed to fix the timeline-name UAF, so keeping them (and thus
the ops attached, and to_drm_sched_fence() working) is fine.

Given that, I'd like to fall back to the minimal caching fix and drop the
ops/refcount rework entirely:

 - get_timeline_name() caches the name in drm_sched_fence_init() and returns
   the cached value, so it never dereferences ->sched. Everything else - both
   .release callbacks, the shared allocation, the call_rcu() free,
   to_drm_sched_fence() - stays exactly as today, so there is no amdgpu/pvr
   regression and nothing new for the backend to reason about.
 - This also addresses Christian's point that the reference must go from the
   finished to the scheduled fence, not the other way around: the caching fix
   keeps the existing finished->scheduled reference untouched and does not
   invert it, so the finished->scheduled conversions that rely on that keep
   working.
 - This makes most of the per-patch comments on v3 (the shared-allocation
   lifetime, the extra dma_fence_get(), the "last put" wording, moving
   call_rcu) moot, since that rework goes away. I'll keep the ones that still
   apply.

On the specific points:

 - get_driver_name(): it returns the literal "drm_sched" and never touches
   ->sched, so unlike get_timeline_name() it isn't exposed. Only the timeline
   name needs the fix.
 - The "already-satisfied dependency / dependency-collapsing" wording and the
   whole to_drm_sched_fence()-returns-NULL discussion only existed to justify
   the ops-detach; with caching, to_drm_sched_fence() keeps working as today,
   so that reasoning (and the confusion around it) goes away entirely.
 - Caching only the pointer: the earlier objection was that it doesn't help
   drivers whose name is freed together with the scheduler. The mainline
   drivers that actually hit this (amdxdna, nouveau, msm VM_BIND) pass a name
   that lives as long as the scheduler, and panthor/xe (dynamically allocated
   names) are already fixed per-driver. If you'd rather close the dynamic-name
   case generically in the core too, I can kstrdup() the name into the fence at
   init and free it on fence release - one small alloc per fence. I'm happy to
   go pointer-cache or kstrdup, whichever you and Tvrtko prefer.
 - Cc: stable: will add "Cc: stable@vger.kernel.org # we don't know since when"
   and let the stable folks pick the backport depth, as you suggested.
 - Whitespace/doc reflow: will split into its own patch and keep the fix patch
   free of unrelated formatting churn.
 - kmemleak: the caching fix doesn't change any refcounts, but I'll re-run the
   KUnit suite under kmemleak as well as KASAN before resending.

Unless someone would prefer to keep ops-detach and fix the two callers instead,
I'll respin as the caching v4 once Tvrtko and the pvr folks have had a chance to
look as well.

Thanks again,
Jonghyuk
