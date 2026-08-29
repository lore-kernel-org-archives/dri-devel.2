Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A43EC624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1608E10E6AB;
	Mon, 31 Aug 2026 07:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fB/vEzlk";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEB310E0DD
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 08:56:49 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so1063516f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787993808; x=1788598608; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B2/Zp6NA4HAJ1jDSITO8e+fRzaCcgFllUHQXoAMtqoM=;
 b=fB/vEzlk9BRAh45Tlq/8O1QPXaWF5Netx2t2SsxOJ1TNOPoiAI8QtNS4S5cwXKY3oA
 j8RfFUxMGxKHquktNTCnU7fZ6q2NkFpg+BKgkC982AgqqSz5jr5GQPD+ncDeuLTHikko
 2rrzU32AoiXTWPQd7kx51gklbt2n3trk65tCjPplQlQxsouBO64nWcHNtcrWRjDUKHjc
 YqXDm+QsHgMzzQqNvGDDXKC2XWQN+mEWbiGqZZKLAGhJkeo2V7oFL673DPy0msXsZc4X
 Fjc8zy5BcYJsPLx8Dv+mTwu8N/wKw5UWBdabXxz95o2okNr1vPDhF/sT5TV8aCEKoI/A
 QMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787993808; x=1788598608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B2/Zp6NA4HAJ1jDSITO8e+fRzaCcgFllUHQXoAMtqoM=;
 b=Fgj6ME78H1JgGoTUVIQuK7oN5+lfYTXW9tikr57hoFNAXYEgeEU6F/JU1Mc0IiClyU
 uHYfyweq6zYeky1UydNLBGXpLd/cBChygvYB+dBggrGeNqNYS+hPNBSL2kPQNViRVAPk
 yNY/QZx62RJyV+/0vT+Y/zfDYgcBnRD33xkgPHDozlW0PEPEYeA3l/O405AfF+s3L+0e
 wNivfVs81iszVUN1gBLnhMIpz7HimyTfm8KXmvHErDmQk3Hi/5uBdillPvV2y5FovBjh
 1j9gfH9fGMUDnUvNVVkyE8bxEwQq23SufFZZQwxxGHGxOysOkGQuuRxJJM/7qudCLi9/
 qw0Q==
X-Gm-Message-State: AFuF++mN732pBDLFhmW/ePdDGYWLebVQIR0sIQwniewYaXbbiazz6hEe
 ClyPe6BJCG2K4vS5+84Tkg4773DySxLIBX0RZXeCeIzeB6NhqPN58Oeu
X-Gm-Gg: AYBFou2Y1USWGmnkV7gqrKwpMLhdS2u2MNfr+XoI8kzj9i/wmrIXwpGF9QLmmkiEe4n
 pnIeozsi+VrgmU87TS1M2OFkXazinUqN3QtDw28VDSxZ+St79Er+NpRKxMWHE8EBwtSVP87BggA
 Bw5IngL6dpNsKJgJJie858l7UoMoWA6dI6r9yDTWP79It2NZ3TF49nEUq0D+r9xWT6o09ld35Bw
 NOjFBdRmX1rmJLBI8HbFvlUj9h7dA8mXP3zypqpMgqPL3G6a5DsC0/+4d2B1F8MCQ/nJSaGRycx
 /pGDatGptK16N+BnxaJE4LRNEUeuNstQjf2ZizbO537KeuuA1DLiYiwKsA4Hu1XW/eF43J0o2Z1
 VJPmCGgmDbUypFA0cb3dOIyanowWausKImVVrjT5QYLKKOYirZ2m7JBpWa5UdqPZRD4u0QM2izn
 kU6hR+4cX2UEMzxyFV3yY8H1PAPAxIHnpuzd4RI41n59xTflEU/9VmR2noUsPfY/3S1BA/GAvrw
 H8kxULoO7M/wQFdzGvTDnGYjdtFZ3WT3T7+0D0vX9M22LAH8/bQcPdmlxUaBoNoBCCemnK0
X-Received: by 2002:a05:6000:481a:b0:47f:f43e:f0cd with SMTP id
 ffacd0b85a97d-482f7977a45mr20810773f8f.4.1787993807937; 
 Sat, 29 Aug 2026 01:56:47 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:e90c:f900:e29d:3a79:ac40:9edd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb28276sm10109373f8f.29.2026.08.29.01.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 01:56:47 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH v2] accel/amdxdna: fix NULL deref and GEM object leak in error
 paths
Date: Sat, 29 Aug 2026 11:56:44 +0300
Message-ID: <20260829085644.38103-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829080016.10002-1-denizaydogan1902@gmail.com>
References: <20260829080016.10002-1-denizaydogan1902@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

amdxdna_cmd_submit() does not set job->cmd_bo for internal driver
commands that pass AMDXDNA_INVALID_BO_HANDLE. When such a job hits
an error or completes normally, both the submit error path and
amdxdna_sched_job_cleanup() call amdxdna_gem_put_obj(job->cmd_bo)
unconditionally, dereferencing NULL.

Separately, amdxdna_cmd_set_error() acquires a GEM reference via
amdxdna_gem_get_obj() when handling a chained command, but leaks it
when the subsequent amdxdna_gem_vmap() returns NULL.

Guard all three amdxdna_gem_put_obj(job->cmd_bo) call sites with a
NULL check and release the GEM reference on vmap failure.

Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 31a414c3f..a806702ec 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 		if (!abo)
 			return -EINVAL;
 		cmd = amdxdna_gem_vmap(abo);
-		if (!cmd)
+		if (!cmd) {
+			amdxdna_gem_put_obj(abo);
 			return -ENOMEM;
+		}
 	}
 
 	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
@@ -575,7 +577,8 @@ void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job)
 	trace_amdxdna_debug_point(job->hwctx->name, job->seq, "job release");
 	amdxdna_pm_suspend_put(job->hwctx->client->xdna);
 	amdxdna_arg_bos_put(job);
-	amdxdna_gem_put_obj(job->cmd_bo);
+	if (job->cmd_bo)
+		amdxdna_gem_put_obj(job->cmd_bo);
 	dma_fence_put(job->fence);
 	mmdrop(job->mm);
 }
@@ -676,7 +679,8 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 put_bos:
 	amdxdna_arg_bos_put(job);
 cmd_put:
-	amdxdna_gem_put_obj(job->cmd_bo);
+	if (job->cmd_bo)
+		amdxdna_gem_put_obj(job->cmd_bo);
 free_job:
 	if (job->mm)
 		mmdrop(job->mm);
-- 
2.55.0

