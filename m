Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE72CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867F810F5E3;
	Wed,  7 Oct 2026 13:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nkQsipDX";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC4110E574
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:39:54 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cc7cc8aafe6so846130a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791376794; x=1791981594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=stbPCEVKk5/43mdbhizGdpTlS+biXo1nBfE8ir7ZWR8=;
 b=nkQsipDXfWqpHJrSsFffeEgVCClO3k00Lx8GsGlHL/OBzHiDlLafAeTcl4IHAb7OKN
 7ELPiLa3hwdRzUAF8dUYbNXaVjgpsIrPjhPOphvXc2VIhBqBCLzf/cf/N4HRq/8X7ZNr
 ezX/ZxTGtT3wamoI6xgoEvzMNoayJ/GDuH12qC4VLDC87HupdSefp3DSej3tf+2gZaaY
 FPcR1R2PgPfWts2JD9vUdPa9DcjBCRsyA3M0N7PItGDbcVoYNWO8Fh3B/AAZ4D2Msl3G
 Le/28yL9uuM87dclfGXS4ayBBEXoYmnn1jcf/xibAoGZYFLBq7FZ3bRSnbeqU2hp/M4x
 60yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791376794; x=1791981594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=stbPCEVKk5/43mdbhizGdpTlS+biXo1nBfE8ir7ZWR8=;
 b=2llYjfqWLR+peLyKVqFIXm3rXGbwjE7w+4CqUrSsEnkamVQ5OEmg0TN6PgTX1130V2
 XL6tC7DTSltEF0UKN2rzsGs4j4C/W9BH867b5EoGkpqkPcCDSkX1vY/q6+ycctHoQeUZ
 ZhzOsg3joE78qOhPqp5R1dxcqjYeemlt/EIw0kEHkSSHVCBVVEz/VtSfYaYDT5XO/9zh
 BWgausmpWWcDk+0AaIPzDOPkxAAQvwG+97n2pGXWBp53gceXzxPzb2iyLPtnaWSIC02e
 igdmeEGqV0aXJCAGpNy5nzvYl7FAF4XLiKXhV5dy0GVyZO+bsmrJ9HLd4rs745oGMC8J
 v8RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBS4nnoDkga8KkNSWcwJ/0eTa/u/H79D4m4x+7EzUpTj03YyFvC8Zqgfb0hG/vQosVy7iZm6RrCqk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJjaCSS4Dbg8Ykyz+KWiYXP84VlqMVj/Bb2risPED077mbUKA/c
 Q/bUR+dk14C3kN6EL5PXvv6+CsyvReN1KqBAWes5RI+KQ6P5hfSf93ko5I11HSvcbl0=
X-Gm-Gg: AYBFou1fgJdoEIuv+kozOzCvT73tYeVIAiGbcA9qYdYuL57/S3GnrshGgM7KUoZppgx
 3i6M17ly27zVvBwyX73X01kEMeCrHHvI3BfKYc5nR5QXoJ/M6TLVczs8Rhuvimg309ncdLlciPD
 2ydRMFsMM3ay+y9yCVRa5pVwGRDP+W6h2U0WvNRPPSeme70Qe4csxE0fW4yF2vYPnrrE69F2uyN
 MpvZbz5kuFCNL4AF1+GsyTYF+2VFvqTzUixMl3PpSm4jafQyksJ6rhl3EzY43GdW6NTD9fxxvlR
 9BVYNXbdxu+zW4/8SF6LqHX2LlHBLbDA2KxMBchFDPpKaH25h5rhgX/MW9+lkQeRnn+HvnXooVX
 +ZohXqyTVPTuf6VfGTwzBHOfDYesdn7K5isTIPz+Ow2HReK6R7eB4AOuGSiY0C2HKPVh6We7mD3
 RRKRSVa4ooqBqeLu7FifJJ5TutZRLE5xzJz6V0SCXUwY5FvcGmUurEJaea+7MNxdqnW8smUo+U4
 duk28NN2r4Ou7s=
X-Received: by 2002:a17:90a:da84:b0:3a0:cbe2:9e0c with SMTP id
 98e67ed59e1d1-3a8a1c84418mr1597807a91.63.1791376793729; 
 Wed, 07 Oct 2026 05:39:53 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8c46a2f9bsm650899a91.2.2026.10.07.05.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 05:39:53 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 yongxing.mou@oss.qualcomm.com, yuanjie.yang@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: add the SSPP rec0/rec1 blocks to the snapshot
Date: Wed,  7 Oct 2026 21:39:45 +0900
Message-ID: <20261007123945.1694-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

On DPU 13 the SSPP block is only 0x84 long and the fetch registers
(source address, size, format, multirect) live in the rec0/rec1
sub-blocks at 0x1000 and 0x3000. The snapshot dumps the SSPP block and
its scaler and CSC sub-blocks, but not rec0/rec1, so the plane fetch
state is missing from the devcoredump and from debugfs dri/N/kms.

Add the rec0/rec1 sub-blocks to the snapshot.

Tested on a Lenovo Legion Tab Y700 gen 5 (SM8850).

Fixes: 688c7734002a ("drm/msm/dpu: Add Kaanapali SSPP sub-block support")
Assisted-by: LLM
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..dba8a07d34bb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1006,6 +1006,20 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 						    base + cat->sspp[i].sblk->csc_blk.base,
 						    "%s_%s", cat->sspp[i].name,
 						    cat->sspp[i].sblk->csc_blk.name);
+
+		if (cat->sspp[i].sblk && cat->sspp[i].sblk->sspp_rec0_blk.len > 0)
+			msm_disp_snapshot_add_block(disp_state,
+						    cat->sspp[i].sblk->sspp_rec0_blk.len,
+						    base + cat->sspp[i].sblk->sspp_rec0_blk.base,
+						    "%s_%s", cat->sspp[i].name,
+						    cat->sspp[i].sblk->sspp_rec0_blk.name);
+
+		if (cat->sspp[i].sblk && cat->sspp[i].sblk->sspp_rec1_blk.len > 0)
+			msm_disp_snapshot_add_block(disp_state,
+						    cat->sspp[i].sblk->sspp_rec1_blk.len,
+						    base + cat->sspp[i].sblk->sspp_rec1_blk.base,
+						    "%s_%s", cat->sspp[i].name,
+						    cat->sspp[i].sblk->sspp_rec1_blk.name);
 	}
 
 	/* dump LM sub-blocks HW regs info */

base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
-- 
2.43.0

