Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B64C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DFE10E1AE;
	Tue, 30 Jun 2026 09:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PWEvTbJJ";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07C110E1AE
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:39:57 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-92e533aacf2so103939885a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 02:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782812396; cv=none;
 d=google.com; s=arc-20260327;
 b=abiqkH0XATWAP7GYu1scAcQNX2uW8juJPAtG0azZd7u7cyDYTRMlLJgiOOuv7cis+m
 UAMzlpezmhBSD3d5eKdFslwaCCJY/Uat+mtAT/SYSbLP0V4fIXNUabUC/MHxVLy77ZXK
 ElQlQ6PP2M1f8EewfWJ+K62NgM1VbpjFDVIFxGJUWnCaOItyJnRWIGFIyGpbjuJ5Mcvh
 uxFXPR/ZE03hYdv4dSlukyFUw3sovuJenHht2Gn6AYJxKsYxoLkmv1OmNP0thoZz24ys
 zk+09UpV5kIJozQS/VO+JkR/MoCCmYEpbKbHBWSlcZvslUfNQqWnh3yEVNavm5bGx7wL
 rrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=WhmJgn5ABtUgVDU/zSa0VXvb/9MGdaAwoZfUQ9tWYnE=;
 fh=Q0xCG82AsaxCP/42HieqqRMYIB5Khm2PXsHCtjVZBqQ=;
 b=ESUi5jOB8Q/mkFc3xGCH5KmCDGAgZYqcRTSEElA1QWa3D8ZAX0HYcJYOd4pNJDJr+e
 LNt3/oVU2ZbsAWQeDsp0Z/XqdPSSayp9/dOhhTkO6bMg9I1qNtPsH/aSJmYVA9U7yijO
 uYrvJbLlNGptd2TuFBhIl3q4T1fiikTFb8u0bowIMvEEEghvRzmNRx6cZXcvz0mVOgtX
 ZdMizP3mi5lcOJwZiS040dmqAy7PznGEHNXTS5ZpFVBIRM6Bz3UEpa+lg5q29qS17BSq
 8tp+mccGvp/jY2dHzn6TODyfI4hikkCeLDPC69UTqnfPhOdl2D3z70IFKX9+YK8s871y
 BR4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782812396; x=1783417196; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WhmJgn5ABtUgVDU/zSa0VXvb/9MGdaAwoZfUQ9tWYnE=;
 b=PWEvTbJJcl6O3sVoENrk+0MTAC0rZuE+A3d74BFcTRs2jxUiUO1FX+uFklKaqbeU68
 0pLdqk61evvQu3gg4Vc13xvGwTA2FzHbbYYJ6wfMADyaUxr8UURRnGc9z7c2spDTxQLN
 Gk3pZOfDA/CnU5xnBSDfnIcOyy/OyMV1ElaRCca41/lUlJWT3pFjKPOXIvNiXfC+fnbJ
 cbpGRtBzLAIr+DLPuVlb3yoEFNR8WwqoWslbCHKbFj/Y5Dmo1GpIZ/rJvp8M2EAKoKwt
 RcC6/9Fkyt9MpviFu5bB4kQqi8IXPetkjALUcEMelynYkAFAtlnl2QH3MTHs0f++muN1
 j4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782812396; x=1783417196;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhmJgn5ABtUgVDU/zSa0VXvb/9MGdaAwoZfUQ9tWYnE=;
 b=dES+8BbuhB1fxpBarXpzkIMTLY06v+XzCF6mcUSZ7kf6TvdMNsun7ANaYELPoSqQMR
 DkynEUtku61a3vFz1bteMcC152QbcMp1c2MzOHkugUNGn2Ax5BA3PcJk7vSMG6WYz2dh
 HvbdVMVSP53V6pU6kzjgzcrX4PJqI4e72kx9xxZrR86AHh3MkgqpII0OOqjQSt9ZxMgy
 Bb9B/YcrcpV4ZrYm0a7iZ69GSoaAzmxNJL247pRYeKNidiUpEBM9FkJDBcmZhOgMrUk0
 ZwYAZdSxHIfg61oksMgI/kVeG+/81LwPJsf14abd/0TAeBjHPBZzmqBqtImF0IoutOVA
 tSqg==
X-Gm-Message-State: AOJu0YyHpCrkbcCmh0WGoyRga+QTCdN3wXh+q6KDJNC+HWgqW3Uxp/l0
 XrL52k3KUEDmNzc+v+DWFyVlyI67i8JgKqhUbh9HmtRn2U3h/fImB+hQzO5t42LQl2t9mjknpY7
 VXuCalmJVAA8YDjVkxI7j5hhCg/rPQIfq/es4
X-Gm-Gg: AfdE7cl4AYKoa49U7EkSLCW48UBUm3+B7uB7KR2FNMUjIT1aCKn7hh3nGXz7tw2WoqL
 H24UaW445KYP/iU0EV+4sqq7d8IT7FJQzswC4ysWXeClQpD5jvA3XT70CQ9u4+WScpAHj27j1Dg
 SwdY1UqsrpFhVq7pPolVBGb5zIEKb2FfoaQT54uOFnW+z4O0y1zjo7h5GRA1KhOkBwbxyVpRI5u
 T32VUqvfds0F1bhNv1I1muFwgrlITaDO5bmhMk8yzzXwFPIIG73HyH0Lx2BP+YCRaddOPCZ8pUI
 /o1YhxxtkLtQ1735r20LYEKO0Y+8J7Tyy0OLFQhTbS71ZddkAq2DDNkWlQ==
X-Received: by 2002:a05:620a:472b:b0:92e:6a8d:38aa with SMTP id
 af79cd13be357-92e6a8d3a82mr105574685a.63.1782812396317; Tue, 30 Jun 2026
 02:39:56 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 30 Jun 2026 19:39:44 +1000
X-Gm-Features: AVVi8Cc3QGSSCuaNNy6CRHv4oXZmqcbCBmzFn_369vFtXDugv2Y6mJEAIiwv8H0
Message-ID: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
Subject: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
To: dri-devel <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

I've been bringing up nouveau on NVIDIA Spark GB10 and fallen down a
hole of why is the GPU writing to pages I've released back to the CPU
page allocator. I've wasted a lot of time on GPU L2 cache and explicit
handling for it, which might be needed but hasn't solved my problem.
I've also invalidated and flushed the GPU TLB excessively.

Today I finally hit up iommu.strict=1 makes things a lot happier,
non-strict IOMMU seems to allow a race between dma_unmap_page and
free_page where the unmap goes into the IOMMU flush queue, where the
actual unmap are delayed until something triggers a flush later, and
the ATS translations stay alive past when they should, and after the
page has been allocated by some subsequent user.

The options I seem to have: (but I'm probably very wrong)
1. force my own iommu domain and use iommu_map/unmap explicitly in the
driver which avoids the flush queue?
2. split ttm page unmap/free into two stages, and force an iommu
flush/ATS sync operation after the unmap before the free. (I don't
think iommu has an interface for this).
3. force untrusted on the PCI device?

I just want to see if anyone else has hit this problem before in this
space and I'm missing something, just feel solving this in the driver
is a workaround for ttm/dma API impedance mismatch.

Thanks,
Dave.
