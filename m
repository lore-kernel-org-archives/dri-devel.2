Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD2CCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E6410E1B7;
	Thu, 21 May 2026 15:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FifsnU2z";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7750210E1B7
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:42:29 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-bcd3c190f71so1067068766b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779378148; cv=none;
 d=google.com; s=arc-20240605;
 b=ELS2R8HhnWT1W8C23bjt3hiJHcs7IR2G2TDBwL6VrqlM7u33Mmdcn3xsBF5VeRjcd/
 4vUCCIpk+dalxQ6RZqL7R9g2y6Jb8UYPqPBRFLyyLqYSfuXKkwwqEAJjtZiMsWE/Nplo
 KAnsi1pEJYE2xW0RlL7i5Y7qVmQ/dPWTiXvVYjWAi/jK5hOM3KL3OePCklDkkeY20/JW
 hfOlFdQCFbV4WHhcbc7pFqC7cajWK/mSKbyE1fY0uCLhlNeGURVG5zqpz7SUlAtFYjfZ
 gCqfEY7UMUGfoOO9/c5E4+XHr9iEljWAhH8aW+UmYKDstOzlY1iVNS4xwsaUYkiUbfGT
 CeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E2fslM12sgO4F+qxOdbD1nIBWEAvdOZMDwhieZ6kPT8=;
 fh=5TVFwtDPtRSyXYoMAAstG7lgQHUnhBHG1CO2eTKIqYc=;
 b=MD55H0fhwF2OalGH/Ou6SXx004wTxJPH/p3cW7HrPP41toszizFFJbxeReplnuZfLQ
 byIQ1E0UAbYa2afnI+J6cb7WfMRPvxAkeDmwqMXiiI5auTsLv0pSKU18WfeIcYDHJxwk
 /Da4rNEMdqAeTnFUw0cCbefaZqHGtDr1TWwc+M2iaRJ+4CtibgSKKA0Hsu8/r8DH5PuQ
 iKdc6OKJp37/HkBpaadiQ6BxNQ3YudvpVy7r8LaqfHZLki7iXS+58Hflw9LLtYpqWFxT
 v5XaWZ6odJE50idQbbD6Cs4pvI9kvwfBXwB0GHv+FGqBUIgm8gMgEInJogwOjynxxil/
 OFNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779378148; x=1779982948; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E2fslM12sgO4F+qxOdbD1nIBWEAvdOZMDwhieZ6kPT8=;
 b=FifsnU2zULNbKD1+CPWRdquRNL8kJA4/xTE6xZv+E/TUOBgZwGZnJ8a0tByAQL/jLo
 uF8Vb26EHhHuxH95Pvngqfbl/zEi1c/cRzPch94UGjr7MyYqwYht6mrWp9e7frj2GrAg
 vM3RvdTHJalhew7G4gX/tE3Uw6x0aAsA0WcussgdNpMiqYgkoi95LQFDN2oEyGsXqR8L
 IyELn9yaTo0Rdxj08Rzv2BXNyA6W2A9WjljdnsMciQik1JWg7C+WzUAwfXZ6mXn4il5C
 sOKkriW3WGgIPBND4W378lZAs+RzdlussBOhtnFNlF3UeLvYsemxDHxyiQyf63l2IUHj
 sOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779378148; x=1779982948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2fslM12sgO4F+qxOdbD1nIBWEAvdOZMDwhieZ6kPT8=;
 b=eOjmfXqPN8xwBA7ZlXyVMxHXSSrtJ1Ma0Db1IiNOhcImqmbng27UKC0ykIjM+3KdKk
 TzkSUaDWfPJVL+F5aR6H/f7aKLLTFqS7weDH7nGQjsOt+G8r1+EceQbeEYWl9MYUKN5e
 GKvRcGijOOLJHA2xgFjN/zOZ6c29zeNGygFRuCL95E/50ZoBXxAMInP+T70cVOOs7au2
 ckwWpnqsKSt8mfNMbKQ2GtSEuDXlfSwhYKuSSozEpm6asFzhl1WYQFAnryspPkKWPhkK
 FQKF/6b9QdxHmK/URShEX4bnE0kosTsfxu7g0LtVX/aZ1S1iqq83xoKGlXWqzGJlW0QJ
 KHsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9On8q016GLnE5fGFOnx9MHkmwLuQqWlalp9H/wog1U3zCTCTtqL2q/vtbwumqLxPX8O67+iK/vlqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwPoyVsyl0k3xy+Ki+iB0wjDj43j9w0hDT9CNZdhsS1PFj4u15
 t6hmLv+8ZohmJX2Jsdgp5VAzx1KTfrbOD82+haYGdkCK3qA+CF6qFpfAX2NG76Jl62RW7BKkc1z
 7Vv+ZIiWeSoMdE9g/HzvkJBG+/TE8jC0iTRAWHKHnfw==
X-Gm-Gg: Acq92OGZ+w3N0Csj+eGLutFS+1T42G/1wJu6WaWXSq4ndh8xzAYZuq+eh6706U4fYtH
 YB6V5Ec0LCODede/qV8eVWMVbNC5Bsk3QpY+w0zvESqu+UhGr93vmtIiXXAW9ZRR+frO8zQl161
 6nHk8bK7DwpyU++89bfol5PcjBO+2iUSTW9zFWf2cH/AdamxOPNA1lWV18Pfilq0sdzym4C/xtG
 j8lU4L+UTJ/j9YCaL6WFzZOc9KHF9nYBORu1yk0eXndUOWn7Piuf1Tvw6sPVUvcG2ZGpL+ZEQtQ
 rYOmrr7PeJQZUva4uNK0vW3GK637ORR6HEZKGDRMvkyYofZKQQ==
X-Received: by 2002:a17:907:c70b:b0:bd2:616c:56a3 with SMTP id
 a640c23a62f3a-bdc12d97c62mr249495866b.10.1779378147756; Thu, 21 May 2026
 08:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
 <9fe0e3bc-1f04-48eb-ab79-2a7dc421a5a7@ti.com>
In-Reply-To: <9fe0e3bc-1f04-48eb-ab79-2a7dc421a5a7@ti.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 21 May 2026 21:12:16 +0530
X-Gm-Features: AVHnY4KdwJRloPYYPr3vT_nqSzNJHilDu5uFjOj7H9mPzggIRmV41fNmlJ_I7Kc
Message-ID: <CAO_48GFgBku=s_oGTudh9MQeiCtE0aov0K0UE6zavYDgvNrATg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] dma-buf: heaps: Turn heaps into modules
To: Andrew Davis <afd@ti.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
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

Hi Maxime,

On Thu, 30 Apr 2026 at 21:43, Andrew Davis <afd@ti.com> wrote:
>
> On 4/27/26 5:04 AM, Maxime Ripard wrote:
> > Hi,
> >
> > The recent introduction of heaps in the optee driver [1] made possible
> > the creation of heaps as modules.
> >
> > It's generally a good idea if possible, including for the already
> > existing system and CMA heaps.
> >
> > The system one is pretty trivial, the CMA is now easy too with the
> > reworks we got in 7.1-r1.
> >
> > Let me know what you think,
> > Maxime
Thanks for the series; merged to drm-misc-next.

Best,
Sumit.
> >
> > 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wiklander@linaro.org/
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> > Changes in v5:
> > - Rebase on 7.1-rc1
> > - Add a patch to enable the heaps in arm64 defconfig
>
> Could you do this for ARM (multi_v7_defconfig) also? Actually seems
> loongarch has Heaps enabled by default and I've seen it default enabled
> on some x86 distros too. Maybe someday having the base Heaps + System Heap
> set to "default y/m" as they should always exist for any arch would be an
> idea. Anyway for this series all LGTM,
>
> Acked-by: Andrew Davis <afd@ti.com>
>
> > - Link to v4: https://lore.kernel.org/r/20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org
> >
> > Changes in v4:
> > - Fix compilation failure
> > - Rework to take into account OF_RESERVED_MEM
> > - Fix regression making the default CMA area disappear if not created
> >    through the DT
> > - Added some documentation and comments
> > - Link to v3: https://lore.kernel.org/r/20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org
> >
> > Changes in v3:
> > - Squashed cma_get_name and cma_alloc/release patches
> > - Fixed typo in Export dev_get_cma_area commit title
> > - Fixed compilation failure with DMA_CMA but not OF_RESERVED_MEM
> > - Link to v2: https://lore.kernel.org/r/20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org
> >
> > Changes in v2:
> > - Collect tags
> > - Don't export dma_contiguous_default_area anymore, but export
> >    dev_get_cma_area instead
> > - Mentioned that heap modules can't be removed
> > - Link to v1: https://lore.kernel.org/r/20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org
> >
> > ---
> > Maxime Ripard (4):
> >        dma-buf: heaps: Export mem_accounting parameter
> >        dma-buf: heaps: cma: Turn the heap into a module
> >        dma-buf: heaps: system: Turn the heap into a module
> >        arm64: defconfig: Enable dma-buf heaps
> >
> >   arch/arm64/configs/defconfig        | 3 +++
> >   drivers/dma-buf/dma-heap.c          | 1 +
> >   drivers/dma-buf/heaps/Kconfig       | 4 ++--
> >   drivers/dma-buf/heaps/cma_heap.c    | 3 +++
> >   drivers/dma-buf/heaps/system_heap.c | 5 +++++
> >   5 files changed, 14 insertions(+), 2 deletions(-)
> > ---
> > base-commit: 5e9b7d093f3f77cb0af4409559e3d139babfb443
> > change-id: 20260225-dma-buf-heaps-as-modules-1034b3ec9f2a
> >
> > Best regards,
>
