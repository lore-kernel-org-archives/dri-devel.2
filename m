Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E38C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2501610E4D5;
	Sun, 13 Sep 2026 22:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JhWvyR5w";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1495310E4D5
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:30:21 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c253425b253so418546066b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789338619; x=1789943419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sqTwf+tfdmvg8JXeAPO0sWL+0ffOQu+hzmUICqT8dEs=;
 b=JhWvyR5wuIlkGAMVjrf8eQoY4eLogrhIjCAVlj3lSszTv0Mtec9bbCcAtgaTZJ9Q/n
 igeWtb1MCo1LFJcloEOaRf2AIrzF3/BTbPsMCD5tKS6uoI75CZsKu33SarwcMPAi65jP
 HdGbnOF9fVHt+wATOYGKNMFhxHI3wQWvJ4jrcXloM7IQQBoRs1KyoWP6Bh23ay60OMVD
 OKmzvVzzpO4vhvUdds2UsCvJqimx4orB7pl+yvYsneEBeQUVROvcVFw6dD5nRDrl/h1j
 d+w9Q+aurwnJ7nlLOE+NlBu6iMetXw7UGsQQeRpcuMGstEqYaXlPx+5BeVCWpa+z3D+u
 wnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338619; x=1789943419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sqTwf+tfdmvg8JXeAPO0sWL+0ffOQu+hzmUICqT8dEs=;
 b=VkPqaIjRsYyUE61cZyDZpaWtrmZQZW0O6sNk4d84PY7uREiIUoVRB0YzMKw4Oq1r5a
 n8c53Ya726wm1zNRANx1g6f0q29oJdV3QzsACWWWhPxdYl2q9+hKRL9mAcOK5gYZG97j
 d8jRY5I5jtO6fYUy51//y7kzWZj0+n5O0xTT+3rkfdj19tsrFau8xqBNNJxCPu/GBrHq
 TEuNP2I6HCrS4je0K2UpCuNJ+n5hXAHKg61AZlOhBZNW4MR+het3wb6+JqntxTNjfvqa
 VxhFyCG5mNzBvhDodLo629zvQjW1FHlNm0n2J4SGPp/V6u3YCSIzj248p4zlcKFDwAel
 zXyw==
X-Gm-Message-State: AFuF++kEA4JIlUPqm7hZMFveC7JqTi5K0qGikkNydkx3SuBwY+HUIxRa
 uQF54ntEopBps8/CAi7LY0+Tdqt3x8Lhizhhxq1SDny/awh7VZ4au/rcHBfAbtKl3837uA==
X-Gm-Gg: AYBFou1Vm4TRZJJyHoWtaHhPjbOEbIMtuTc/+BLsGnQk0Rv/vTX7LTqu5kj5ooB/OGv
 bJhm5tlFM5/uCXjnxwXs8Gi7mfB6J4vroigcVUcqIJfWACAK8XeqkAhg9sX7y7nFTCKTmiJ678e
 qOUdPjg4AYhEUAZm3NevTFrUIrDiATOXaDp+RWOLKxzCSWSUSQx8R4hBvgXUFnAwHykBkf9KcOj
 nBqtFNTiNuxf4LCFnBboDB8rQ8913PAzotfYTRAvwNO1186JLxy9GUcyMOlO10JgLMdkq8ejtuB
 b1Hw/0WB7yZRqvWbKk/3rbnkYjph3ut/uuv6D3PXKdEb7Ytd9/AuSzcEc+vT99SKR6SnGWGPv8f
 th1ekCEl70pO+ZLjxorZCGMYbGWSNdZ5ph9VNuZ/Cr+1vtuGkZaPd2WdUqBKPLMDtowhRLZukUf
 Wd14zAuCPnkBfuzebaxw5vaEoY2EeEQXHZE99MU1pMdzeW6ZlHsuUwnxxSkdZzqr4o
X-Received: by 2002:a17:907:1c92:b0:c1f:e9d9:64d4 with SMTP id
 a640c23a62f3a-c29b862f42cmr4848666b.11.1789338619195; 
 Sun, 13 Sep 2026 15:30:19 -0700 (PDT)
Received: from beelink.. ([186.247.78.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:30:17 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 0/4] drm/qxl: fix multiple missing bounds checks in
 execbuffer relocations
Date: Sun, 13 Sep 2026 19:29:56 -0300
Message-ID: <20260913223000.695299-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

The qxl execbuffer ioctl processes user-supplied relocation entries
without adequate validation, enabling several memory-safety violations
reachable from any DRM_AUTH render client.

Patch 1 is a v2 of a previously submitted single patch.  The v1 had two
gaps identified by sashiko-bot review: the upper bound for dst_handle==0
relocations did not account for the write width, and the general BO
bounds check could overflow on ILP32.  Both are fixed in this revision.

Patches 2-4 fix pre-existing issues in the same code path that were
surfaced during the v1 review:

  - Patch 2: The release sub-allocator ignores the requested size and
    always uses 256-byte slots, but the ioctl allows commands up to
    ~4088 bytes, overflowing into adjacent slots.

  - Patch 3: Relocations with page-unaligned offsets can write past a
    single-page kmap mapping.

  - Patch 4: src_offset is silently truncated from __u64 to int and
    never validated, generating out-of-bounds physical addresses.

Aldo Ariel Panzardo (4):
  drm/qxl: validate relocation dst_offset against destination BO
  drm/qxl: reject command sizes that exceed the release slot
  drm/qxl: reject relocations whose writes cross a page boundary
  drm/qxl: validate relocation src_offset and fix type truncation

 drivers/gpu/drm/qxl/qxl_ioctl.c   | 28 +++++++++++++++++++++++++++-
 drivers/gpu/drm/qxl/qxl_release.c |  3 +++
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.43.0

