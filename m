Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDCDC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDC110E405;
	Wed, 23 Sep 2026 07:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+nrzhy6";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E090310E405
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:43:17 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 d9443c01a7336-2df4010a399so233135ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790149397; x=1790754197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DTfLJperzfUzEeNbOZUt7XXLJ7Q/DdPcSG6fXcqgoAo=;
 b=Q+nrzhy6YOQfQMCv+VqX+TivIjlrhHxE0N+uXZUbkHM8FFPBKf1+4mxACCUPOcAx/r
 xPb0vQzUcUt3tO+4LssIqSMP2MioRiDaJi2HlkDOjUc32afWAyiuXE52fk1VtG3AQrds
 /ou0O2kHTELH96fFKWNWoXsXz66ZYok52ahfvORD/j72DrfnqtwSkmCC8mpner1HpbM3
 /xnkAE5efowx2EDz2mse6iWHnfQK/SxUN40MxddKeSwYmj/bXej9AA1lk4P8yjNa2C9r
 /olyvFx7Rt21tuHihyxYoyR85eU6kXUI8TF4dERj15lL8drVTRrGjzAX37CgT9JiNv4w
 HKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790149397; x=1790754197;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DTfLJperzfUzEeNbOZUt7XXLJ7Q/DdPcSG6fXcqgoAo=;
 b=AzF0BxzbVQCUoGcxqb3TSQIYueJUUKYGR9zW92Wd3ksx2CWSRW7sM8qWcka3/T5h2P
 rTLYvyVxkk1CjeexYgQD6zal0x70+YHYiikgPXY+T+BauGFIckbrrnNE0Q4QznndLHoV
 KMyo2XUvu8JPreQc9B0zQxQbRxAbHyOHHWUG/fSQhOx1pkRE3VGA34wVkyIExNJmMbB7
 NltQz5Mx+WbIYW2n4uhK1OW05/TwmJ+HssDpJUwYJrFLSgm954j5oKk20os8JNjHor8a
 fRIz5zwqhEZdWAab3X/uaSppdVNN+cJ8lG8YouVbvA685CmvQf4Cx5sH8JDtmLtRJagY
 Ticg==
X-Gm-Message-State: AFuF++ke6fzqzLSiaWnODW7IHy0rqpg1XKjLXvQ3xqr+yVl7bqu2kFg+
 liBcF4fiumDE0maxxK2oFXNNaUWM+Y2h/h1me7S6kAhwgGusxVKfdH3Qrm0hOfcV
X-Gm-Gg: AYBFou2xP/+k52Of2SZPyXzyTHYGxMHazNg38Bl8Fx/eL0gJ3RADLs6kehQQ+JAICdP
 zoW3mR12mmo7C2MTa2Nst602z5bAk1eyqt2KU7sb0ksrdgiVy74vtclGJ2OjNm8ax5+NPYQhcoN
 fNoyq2EAZJqUUz9Ft4Ufy6/RvuK+32IRTWKEl5vODhgOw9VHTSxb8bAWuQucBG4FyBGeqgImQUQ
 M3hplNZI9revg/1pgE13EbGq1NW60e+0MZZsDNNXTA7jjguApV2VthAbsB60QH/Zjbvjybd6bmL
 II52ZuAg4paQcsfmqocjpzucILULCbpyu9Vjo7o5961vIamU75gew9Kb+HBRhoVm09Mr1EWfWqm
 zLShDz7bqmT+nQzX5LfHHMOwnNzonbGzF26f0c42rzWWuFyQznE01tslyO44gD0nqeorYjphPE1
 bBd5GTaSy+A8wVwqEU8CM8d/6W4V6xNyUM2+J46PxAF8fdGNawa6BS6bnDOJjDSlhRcEraQYYKB
 57CxEuAbBvy6Q==
X-Received: by 2002:a17:902:ec90:b0:2db:2e9e:11a4 with SMTP id
 d9443c01a7336-2df69d1922dmr27273785ad.1.1790149397278; 
 Wed, 23 Sep 2026 00:43:17 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5d9273sm6406785ad.50.2026.09.23.00.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 00:43:16 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, freedreno@lists.freedesktop.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: [RFC PATCH v1 0/2] Fix the v7.3-rc4 DMABUF_DEBUG regression breaking
 drm/msm hardware video decode
Date: Wed, 23 Sep 2026 15:42:21 +0800
Message-ID: <20260923074256.9357-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
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


Hardware video decode in clapper and chromium (V4L2 decoder output
buffers imported into drm/msm for rendering and scanout) breaks on
v7.3-rc4 with arm-smmu translation faults:

  gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
  type=TRANSLATION source=UCHE

v7.3-rc3 works fine. Bisecting between the two points at
143755bdabaa9 ("dma-buf: Make DMABUF_DEBUG default to y on
DEBUG_KERNEL kernels"), which fixed a dangling reference in the
DMABUF_DEBUG default and thereby silently enabled the option - and
with it the page-stripping sg_table wrapper that
dma_buf_map_attachment() hands to importers - on every kernel with
DEBUG_KERNEL=y, i.e. virtually every distro kernel.

drm/msm is affected in two places. It fills the page array of
imported GEM objects through the deprecated
drm_prime_sg_to_page_array(), and it maps the attachment sg_table
into the GPU's own pagetables with iommu_map_sgtable(). Both need
the struct page of the sg_table, which the debug wrapper removes
(and it zeroes sg->length, so the page iterator yields nothing while
the uninitialized page array is kept, with the helper still
returning success).

When such an import is used for rendering, the VM_BIND map job then
fails asynchronously after userspace has already enqueued GPU work
referencing the mapping, which surfaces as the UCHE translation
fault above instead of a clean error.

Patch 1 restores the DMABUF_DEBUG default to n until msm can be
converted to build its GPU mappings from the attachment's DMA
addresses. Patch 2 replaces the deprecated helper in msm with an
explicit loop that rejects page-less sg_tables at import time, so
userspace gets a clean -EINVAL and can fall back instead of
crashing the GPU.

Tested on a Snapdragon laptop with an Adreno GPU and arm-smmu
(v7.3-rc4):

- DMABUF_DEBUG off: hardware video decode works as on v7.3-rc3
- DMABUF_DEBUG on, without patch 2: GPU faults as above
- DMABUF_DEBUG on, with patch 2: imports are rejected cleanly
  ("import of dmabuf from 'videobuf2_dma_contig' rejected: sg_table
  has no/misaligned struct page info"), no GPU faults. clapper falls
  back to a working display path; chromium shows a black window as
  it has no fallback for a failed zero-copy import.

A full fix for DMABUF_DEBUG=y requires msm to map imported buffers
from their DMA addresses rather than struct pages; that conversion
is left as future work.

Comments welcome.


Jianfeng Liu (2):
  dma-buf: keep DMABUF_DEBUG off by default
  drm/msm: reject dma-buf imports without struct page info

 drivers/dma-buf/Kconfig       |  9 ++++++++-
 drivers/gpu/drm/msm/msm_gem.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

---
base-commit: 93f51579e7df248780214094418f205253383cc5
branch: fix/dmabuf-debug-msm-import

-- 
2.47.3

