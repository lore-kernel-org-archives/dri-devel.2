Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739D6C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D1A10E2A5;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YsV6U5cq";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C3510E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:06:31 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so905662a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788509190; x=1789113990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QTyILQ3Nb9xTYITTyUAAxXfDx2OTqAg1QFKIj6VFxCw=;
 b=YsV6U5cqH/+V17KotxBM65XERH9KdHaJSTavs6f1HoUTGnAceL0abEDpnEb0994E8l
 E5QLYzNOgIj6y8KYOfvUtDywvkAoj1L5PpJp43ky1jU2n3eI0BaSXPrXsc7F6KxSUM3U
 nNh7ptpHwfgHqgEDl1cu6cSDrnLnUpBNAGse0YDGbRD2F2XyH6eSBfyCMNmf2tBpQfKs
 NeVJeetCcyagtoQHUAtq+VyquRKxx37IJJO/OvkVv38jqAlir9EpHaMTJpfbhScVDXg+
 7Mxd2cVP3BlvkELhZQZCoOPz7aU6fJsA3WjqyA9dMJWdDCtoSxmuFqUc0lcwD2xVGM9u
 66vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509190; x=1789113990;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QTyILQ3Nb9xTYITTyUAAxXfDx2OTqAg1QFKIj6VFxCw=;
 b=heg0eduhOAiWT/MI+OG+o/QAD06nmaXpgauDdvMrZ4OjDyIjTBHIsjz8OIFMZG5cuE
 N4YsO9zds+hadbBk9G5jI93ouw+8J1rMzeOwfZDFHBUKYU9JAo4/xLwbbppTk46OiwKf
 elu5jhtMbKbp2uuU2n4cuEfUsMDYX5acdzHVfxlRQQPJscYsxKqRFRAa37qjzvMrW349
 jBO4BZv2CuHnJKlOB2472wtCUnAZZE9n9S0dnIAm9UkQ7bnJjvt7YtqCrhuhyZojs4q0
 I8IB9ia4QmaFdUGkfMndZDdrz4+fyr0JvwCwRLPRDT7llE6b9VSc8TXHmyPNQPtyr6Zx
 G1sQ==
X-Gm-Message-State: AFuF++lEm1lsQa4UimQ15XPgd7htVgFqfCp8DKG8eHtbDkjnlGkIlgr2
 v77Mop7WfjLzzfnjy72VPDBAYFRm6QZ0du6k6gDeVcqs2snfiVWRIJE=
X-Gm-Gg: AYBFou0ffzj6kUxoUopMMKtm1kU+1m2F7ukdvmTEK/CAyIFtn5xpOEcgWNO7MUOkVC5
 ozshlWOVM/VhFEsLZQZhAIPwRKojxzHuSyck7+MHcKsj7YVhyN6PDHe/OsXSNfurAdIOaiN0qeg
 E0SLRwT7aVNJlEFx1x+HAVJIP0xb7L2UkV3eurcYaf9//vc4Nx6iWUTzlAsi7Og5PjHtp4N/YTH
 A2kwWstTIA5mzgTbY/y8UKUJumEnNgPgZ0+mWSMHBIr/0gGot/TM3M1KttbU0/Hx9JeFNUK2q2G
 VeOtL6+3W6GRmfLtYO8UWVss4q2OBgP9x0x5+55hMltKML/0P0zcEAZBQWzmNbSJBvyTX4x/QMr
 F9uIqHp8nKXYhe487wPKiu5fozc+rC0wneDhImkrah+vy1ApqotOoNBInqEqBR6sjZIh5847Fd4
 /KKWoPzPw3dw1HGsiwa/g5MZWhpfqjMttiX806LhOqWKS/+OeQrcw4fI8vq7errZRUuv4zwkDdM
 aXwbBLi90j1qLMG5RSCBwQgiTQ=
X-Received: by 2002:a17:90b:28cc:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-39b260e13d5mr7636395a91.1.1788509190441; 
 Fri, 04 Sep 2026 01:06:30 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b261549f3sm3181153a91.16.2026.09.04.01.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:06:29 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v4 2/3] drm/sched: add the fence ops-detach cleanup to the
 TODO list
Date: Fri,  4 Sep 2026 17:06:17 +0900
Message-ID: <20260904080618.2098450-3-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904080618.2098450-1-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
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

The previous patch caches the timeline name so that get_timeline_name() no
longer dereferences a scheduler that a userspace-held fence has outlived.
That is a targeted fix: the underlying reason the callback is reachable at
all is that both drm_sched fences implement .release, so dma_fence never
detaches their ops on signalling. get_driver_name() has the same exposure
for module unload.

Dropping the .release callbacks is the complete fix, but it requires
auditing every to_drm_sched_fence() caller (ops-detach makes it return NULL
for signalled fences), a different identity mechanism for
pvr_queue_fence_is_native(), and a rework of the shared allocation's
reference handling. Record that as a TODO entry so the cleanup is not lost.

Suggested-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 Documentation/gpu/todo.rst | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 14cf37590fc7..284aeba3c752 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -990,6 +990,45 @@ Contact:
 
 Level: Beginner
 
+Detach the scheduler fence ops on signalling
+--------------------------------------------
+
+The dma-fence contract forbids touching driver-provided data - everything
+reachable through &dma_fence.ops - once a fence is signalled. dma_fence enforces
+that by detaching a fence's ops on signalling, but only for fences that carry
+neither a .release nor a .wait callback (see
+dma_fence_signal_timestamp_locked()).
+
+Both drm_sched fences implement .release, so their ops stay attached forever.
+That leaves the callbacks reachable on a long-signalled fence that userspace
+still holds through a sync_file or drm_syncobj, even after the scheduler is
+gone: get_timeline_name() used to dereference the freed &drm_sched_fence.sched
+(fixed by caching the name), and get_driver_name() can still return a string
+literal belonging to a module that has since been unloaded.
+
+Dropping the .release callbacks so that the ops are detached on signalling is
+the complete fix, and it is what the dma-fence rules ask for. It is not
+straightforward:
+
+Tasks:
+
+- Audit every to_drm_sched_fence() caller. Detaching the ops makes the helper
+  return NULL for a signalled fence, and callers such as
+  amdgpu_cs_p2_dependencies() and amdgpu_ctx_fence_time() dereference the result
+  unconditionally.
+- drm/imagination uses the ops pointer as an identity test in
+  pvr_queue_fence_is_native(); that needs a different mechanism.
+- Rework the reference handling. The scheduled and the finished fence share one
+  allocation, and the finished fence's .release currently drops the scheduled
+  fence's reference, so the callbacks cannot simply be deleted.
+
+Contact:
+
+- Philipp Stanner <phasta@kernel.org>
+- Christian König <christian.koenig@amd.com>
+
+Level: Advanced
+
 Outside DRM
 ===========
 
-- 
2.43.0

