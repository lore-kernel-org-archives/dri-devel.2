Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F012C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6752010E41F;
	Sun, 27 Sep 2026 08:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PTKR1D+P";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0949210E422
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 08:27:22 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so1086153a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790497641; x=1791102441; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QAVR3NA1IwToQtg3Yc1aurKDu9RYUd4Cc7CFtZPZAIs=;
 b=PTKR1D+PU/oDFI912k1pg8McHv17cUnb40jalOE0qecrDS23EAT9sSf05o9mIFkADN
 wmxdE1VGw8/otWWORDzBXye0FT4weuBX7iT0hdEL+QBYKRLA9Cyp9IcfN0PN6pciotbB
 9k7nEV4bpw1VPfcGrzVxb6mImyXivF9hNotDHhBNWjrtMjaDgmoa97HGk/1NO66stw9F
 14o+RWumEOrcOg1J60RXnVCWbjhJBIjC3JwHJFco7IVNZdSDQMiBcS3qYITTw0sIt8KA
 84DxvGay7a8O0S6EYu6jS4Pko7vqZkc481JElZ5B25dorHWVOGfd36RlWItDsocO/raj
 BcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497641; x=1791102441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QAVR3NA1IwToQtg3Yc1aurKDu9RYUd4Cc7CFtZPZAIs=;
 b=fnBYmqZuPu/9KGPj0avr3wfIcH9bpEbpK8zh0a6dIftPnpmRoJZW71ZjzKABI6BgI/
 XccK0MwY4yIBDgFBkBwMPvEoEv/nK8MCmZ2pFFYx8lcoSuzh6oUGDjGprJ36A0OAoS/S
 LyvyDsFr4YT4KmFBo1PZP4t88cDk5zp3G+rjlpILiBY4PoncMLDMhJELpzA5LVtyX1b1
 hI1MJ9DsbnnnOFxtxUPyRA+lFhggDlMkHn8NMplV2bxxJduxEZvLCLQgJNRaCyD4deU4
 j1sgyfvGK9Wx9FL1Fs0FWdSQttEG/o7PkRZhyS7mhx8b1RRAD4q4lZPojmACxwzxISPb
 zbpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj/5lrajpPPbXuy5N1R5NrUFzRHJp1HFp+5+9u25vwxGNPnW/XRmoajn3tmid78sNea9gMhcjXPLQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwt4yf6K4fRpY0TWoH7G4AGQOL6pJooH3sGXayba99+SXGvrht
 bPYL8V67neFijgfOn18kUA0sVjW6U5v6eS2/2widr1uVVZfza0h5DxAJ
X-Gm-Gg: AYBFou1MVa5uIN8DpwOoy1urtZkbyxWKFATWR15NlFJB07LOWkt2g528lLESp/bZ5IN
 IzcPkgYlUy4iCoUHvoUYP9gr/vshfl26IjbXMQ92VxK5DNi7yq0YPVejntCKwNK34RTqn8JNWjh
 M33paMnS7Ll0Hoov1jQSC0yrx+JtFwBkv+AWab8RrN1EWpXCF1LyRcbT3FZTua3RMRpCFgXemlD
 vLZD58SUbkfQJTxicvXxjSdJX4dtgb1x/4vwr4bcGhdTlGOifIsEnUznBCsDbD9HiE7o0FUuJua
 kBK3l/um3LQ0p3xT8OCQdTBbxPABOrXhVVqYxgF8Eq1IHXp0DyWBpelHjge3mAzxsy6YqG6GXgx
 pIZZa36tEzsj1xN+b3z+s4n4VN/a61MRfcRhNC1hhbcTqsZS4C3KbX6B2fNpPGiyhIwKqCG0ddY
 EWZwANvCxPiXnz1HN7ohe5glNg/8RRURwQJtuVYfuOWbJfpKKavgdw/E4b9chkA+7vORRnVF8FQ
 w==
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id
 98e67ed59e1d1-3a0cc3324ccmr4525187a91.6.1790497641483; 
 Sun, 27 Sep 2026 01:27:21 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a2b1e4d5basm1921496a91.9.2026.09.27.01.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:27:21 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 27 Sep 2026 17:25:53 +0900
Subject: [PATCH 1/3] drm/imagination: Fix reference and vm_bo handling in
 remap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-pvr-fixes-a-v1-1-7f5b18ab989a@gmail.com>
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
In-Reply-To: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

When a map overlaps part of an existing mapping, pvr_vm_gpuva_remap()
splits the mapping into prev/next parts covering what the request did
not take, instead of creating something new. It gets two things wrong.

- A GEM reference is taken for each part but it's never needed and never
  dropped, so it leaks one reference per split (remap-next-in-2m in
  tests/imagination/pvr_vm_map.c):

    CRITICAL: 33558528 bytes of shmem still held after close

- The parts still belong to the original object being split, but
  pvr_vm_gpuva_remap() links them to ctx->gpuvm_bo, the new object's
  vm_bo:

    prev_va --obj--> BO_A          BO_B <--obj-- vm_bo (ctx->gpuvm_bo)
            \___________link___________/  (mismatch: BO_A != BO_B)

  drm_gpuva_link() catches the mismatch:

    WARNING: drivers/gpu/drm/drm_gpuvm.c:2108 at drm_gpuva_link+0x2ec/0x310
      drm_WARN_ON(obj != vm_bo->obj)
    Call trace:
     drm_gpuva_link
     pvr_vm_gpuva_remap
     __drm_gpuvm_sm_map
     pvr_vm_map
     pvr_ioctl_vm_map

  Link them to op->remap.unmap->va->vm_bo instead.

The locking of the GPUVA lists of the other objects touched by a split is
not addressed here; it is handled by switching the GPUVM to immediate
mode.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index ceb78694cd9..c5ae0b79fe6 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -418,6 +418,8 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_ctx)
 static int
 pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 {
+	/* The split parts belong to the object of the mapping being split. */
+	struct drm_gpuvm_bo *vm_bo = op->remap.unmap->va->vm_bo;
 	struct pvr_vm_bind_op *ctx = op_ctx;
 	u64 va_start = 0, va_range = 0;
 	int err;
@@ -433,14 +435,12 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 	drm_gpuva_remap(&ctx->prev_va->base, &ctx->next_va->base, &op->remap);
 
 	if (op->remap.prev) {
-		pvr_gem_object_get(gem_to_pvr_gem(ctx->prev_va->base.gem.obj));
-		drm_gpuva_link(&ctx->prev_va->base, ctx->gpuvm_bo);
+		drm_gpuva_link(&ctx->prev_va->base, vm_bo);
 		ctx->prev_va = NULL;
 	}
 
 	if (op->remap.next) {
-		pvr_gem_object_get(gem_to_pvr_gem(ctx->next_va->base.gem.obj));
-		drm_gpuva_link(&ctx->next_va->base, ctx->gpuvm_bo);
+		drm_gpuva_link(&ctx->next_va->base, vm_bo);
 		ctx->next_va = NULL;
 	}
 

-- 
2.43.0

