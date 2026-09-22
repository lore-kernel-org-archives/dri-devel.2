Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A30BC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 02:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003B010E19E;
	Tue, 22 Sep 2026 02:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2VUOK2S";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E46D10E416
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:55:23 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aa8e6bbso1706395d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790045722; cv=none;
 d=google.com; s=arc-20260327;
 b=QTnmrTtRdtrySRIasnTThvhvBPFsfBIuWGPeGOrEIhWsi3wr6WcpWyjXHwErk1ZQEa
 HKzjZ8EoI3hpNyeYS6myKSLQDq8w2s/ohpvr+bBsyRAY9d2ey+MWwmUaDWxUt26Knx/g
 02YHyls9INsHqJ7TCATNhfoUMT+7eMepktX4cVi2ptKWyvZFft1u+n+11E8g+gkRsGF+
 9KU3EbZGHpIvv+OdBAac4s2wLP0JwN+PiDbEs5rdDswwEEg+z2qpUcyLFFedQOffoZlC
 qZT1MqkjFcPmSzHjAHlRBKJnnHisxjBtHyj2p6Uox1Eo2R0+ci5ibpTsQNa2t0WRlB7X
 puoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OTieWtMtlg1zITO+Uxg0UDNibYRqr028lfLfV7Q57S8=;
 fh=p/NkkezVpoD+cj+zmQO4nTslQoBN+GGQrXuu6ZFoO8w=;
 b=J86nuDyy3TwNUH5z1ZMlvpzut2PtDdHrTZXW4VEz13bTXIH7iuQIHHAni9szD9lo/d
 x3Y2L7JrFk8TkBLQ88MO/lLeNwMJdGEtjj+ML0+EYPxbzY4COgY4VJ+nXAsFYM5JXbzi
 2MOIlT9A9qzNH3tPiUGw7zFw4Q7Y1/GTaXNPc4L6RSboNv3Ll1gYUCEio1XWnV5N/gzU
 FifyjA6cxB3EK5TcWiwVDKNiIaDEItXRIEOYOWIzTp7uucbp3RJsNDIdGWp7spZNUtdr
 DxyRrwbOr6aGGzH4iODVYtBZoclhvnsGYtYqAz/SuHmPU38fqzOrwgYhmPnMuKI4px8L
 hcmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790045722; x=1790650522; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OTieWtMtlg1zITO+Uxg0UDNibYRqr028lfLfV7Q57S8=;
 b=Y2VUOK2Sy3uF7jpF9DZK9z6W1VFJqqi7zExxggBTOdU/Hgo8a9CRa46peV1qYX4MJw
 nWOCWQq5QTzTGN4JKomwKWYfch6JerKfq1eiAhxUVAHSTBLI+W3LNn3vtwAe05mIRQRI
 Ys5mmP4kC3wAN9Z/acgijZYsdJiWOuLVD5t+GbVfmMTA4z72NhaNtdka/o5waFH+K1EQ
 4HhpesH+plKxTV7gns1S9fq7Q4T8aWE7eA0irNESfLJ0ExaC1hH3mivMkyHUSi9wqBIc
 jsPZY/Ifd+0gnS5d9/xTYy7bq5eS+zgdGYjoYGZXiKok2Mi5Smaht9YtzxgQbXYPUVNx
 ot/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790045722; x=1790650522;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OTieWtMtlg1zITO+Uxg0UDNibYRqr028lfLfV7Q57S8=;
 b=f7gvgLF68iZixHiZ5S0/zK8ll/gxsrZ4TyY0paEno5nUVb9uHbF0k2uiznvjzvF8WU
 7OCBBJcMl9rJbWc/ygsI0mst+ZM0FWqRPUB/0uh/JR6uDRgwWYHFiSN2Vgv1P793XqZt
 6BeEhUhnpjNgYbjkA3QO2KY2EtZJ8QmVPFtLKH4yRjQ1jNjF52r80Zq98yRqzI7YjNUc
 kcms3Z9+MOvCQf3RqdSL0smAKUm09sMXxyx00Qf9s2+Hd8F76TaiH1YJG/ggp1tW34Jm
 02VVettbCRGgHuNM0hoSCPde0Qrk7HiFm4RCscmbIAAmJvL9wiGWxrDc0jhSaZ+Br5V9
 BBSw==
X-Forwarded-Encrypted: i=1;
 AKwUvByyzHYIDoAqEfYqseP2vTstxUKcWXtwPcP2u7jpI1oqYLKwV/niAsrcSLd0C7Os47Z0jVXXYFAqztQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kl6hm0VHUEPonTUSq0Ley0XrpuqmfoAZhL0v0xipOHiSAcVilF
 UbBLYHsl3LmY5B4m045BAraDpEez51hbQXQOEwPF7QtY2Zq7weGfA2gDQFGGQg/kBZdqnKEuIEa
 hQnsjHV3fn8QzsxCkRbr9NfLggM/Iyaw=
X-Gm-Gg: AYBFou0f0cs/wBlxD1uC3p6TQNjSxvI0SRfWwFxVPn7J1nJOcS7oj7tZeicPElLn4oJ
 9IDDZDI1Ihlf/c6H+dTCyZlkcSc+4qcS+RWEJ3aCQAspqiBBsmvqHWYIO4RK59Hl99yoqHSF267
 kqnQaSUjPkLwER9LvOk3pOtkaBMXcTMSTvK35hDEsc06EbkfPLvydF4zpTOPdBt69xdBotwWbnG
 zzLJ9HJHSjjSFIEyYdbwNPnWfOBZhfi00hgERGNg2VyTI/zndPJnrds0hEskvwyN8of5WFu/52e
 BvnedEa9bwAR969rUdWvFH/vNSvMF1uAlkTw122o1BzegRv1MZuVHsnOjg==
X-Received: by 2002:a05:690e:12ce:b0:66f:b0f7:5958 with SMTP id
 956f58d0204a3-672c292b051mr691603d50.6.1790045721971; Mon, 21 Sep 2026
 19:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260919171710.3699710-1-lgs201920130244@gmail.com>
 <arFH__nd1-T-6kft@quoll>
In-Reply-To: <arFH__nd1-T-6kft@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:55:08 +0800
X-Gm-Features: AcwNN1WJzmefJMuoQ8BNwToU4Ldlc5pP17GQHNyphMtayYqHxTXwBfR3oYlyR7c
Message-ID: <CANUHTR9CncY6h_j-ADSrW_+QSPpDpKsqgN2Y_WrFukq4SYpy6w@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: fix mock ring memory leak on context allocation
 failure
To: krzk@kernel.org
Cc: David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 linux-kernel@vger.kernel.org, 
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
 Matthew Auld <matthew.auld@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:06, <krzk@kernel.org> wrote:
>
>
> On Sun, 20 Sep 2026 01:17:10 +0800, Guangshuo Li wrote:
> > mock_context_alloc() creates ce->ring before allocating and pinning the
> > context timeline. mock_ring() initializes the ring reference count and
> > returns the initial reference to the context.
> >
> > If intel_timeline_create() fails, mock_context_alloc() returns without
> > dropping the ring reference. The same leak occurs when
> > mock_timeline_pin() fails after the timeline has been created. Since
> > context allocation did not complete, CONTEXT_ALLOC_BIT is not set and
> > the later context teardown does not release the ring.
> >
> > Drop the initial ring reference with kref_put() on both failure paths.
> > When the reference count reaches zero, intel_ring_free() releases the
> > ring VMA and frees the ring allocation. Clear ce->ring after dropping
> > the reference to avoid retaining a stale pointer.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: 75d0a7f31eec ("drm/i915: Lift timeline into intel_context")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gt/mock_engine.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
