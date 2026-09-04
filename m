Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14309C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A22D10E293;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XZmbvy9G";
	dkim-atps=neutral
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD6110E186
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:01:38 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-6aa9606ddadso655560eaf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523297; x=1789128097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z1XyZzGqo8qtOw6QCVse2xuLQ0fYOXbEWeooM5I1+Fw=;
 b=XZmbvy9GA6c0VmzclTzNEcA0sGSzkbIprilNBysQM2YZDmTkGQEyWwmlJ4cL4ynymI
 5IXtIXhS31MuBVUhwPtS8UEPnxdP0F8v2m8k1Jpx5wPO9a97lB6t0Ff9Q2gKcbgFIHQC
 L2QQhJIBPl0TNsUjsetRni/zq1TrySpIdR8j5giEFvh1J6sl6eLVBE51+EAwvVq8mqSP
 8XPsNfJFfdDi0/z904DB43oW5+oJojYIq3OdJf87wx4pW52hz4G7nvlachs1IffP3mtG
 qEtgR2a+gPV2cXynEFd7+FSJm6ZYdblSHBwU2qhTUktIy6rA0+adz9jX4PeRwX8NLbgh
 GHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523297; x=1789128097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z1XyZzGqo8qtOw6QCVse2xuLQ0fYOXbEWeooM5I1+Fw=;
 b=nngyS+Gcjvt6TjUSrsIrUHMPavz/N7uVS/CXAuHBMWlzkVeO8Q5CENlWktqOkCZjPu
 FeZbeqq7fc+LKAQ19jbLZs/XSGiLBTtGkmYaJNaLyv0Oax4sQ7zy44rrnytdqyN8au8W
 N2h8/O/xzamQf6EpgPYwaBsb5IBFHaI6rboR0SkTE3QHM9+auFODKfqXgG5/nor8e/RX
 fO0v97MQkMnq3duFGH7/IGr8qVwLycP8NfLpAEz7xQ4WHlQs0vPVIVQpiY80AtL6ZZOF
 azc4bHbVmxbNpvsrDJ1khavJMUTmKwOG53mwMSCY+KXsfD7ycOcBe/4HMoP/C7FUZm9f
 ttpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwe0kSF5owPoGN4dnoe1ZkCNrkmXDSMvOMZ3WvvZx4GVhAimqHZ79SrRZBKMLd3zkTOSuydiwTH3DM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lP2Cq9g5FW9AX7208T95+FouG60Xdo7YnO+Go2tZD4TSycMInx
 GCV3a9kxG0jo2IfMNMFL9edBcaTex5ZOSBvoA7oRuXsZd7ocNZzxOgpz
X-Gm-Gg: AYBFou3B08nnqwkMHezJHheipGfjH+O0BWDJnJNl8qrBsZgB3+Vk0KSh0ppbhvW6EQc
 3IoqeUnteq7zKCcFstb/Qmj31/DeP3Swvg81ZRNSfJasrJfbKMsDUFNpNMGk/XufWYW8SehIqgq
 GHJx/cWbGSgaNz1PbGODA9wo7N+N45EGoXjgkYXSWAW837BU6KlEOaa207+xiJFQeU3jmBYHZvs
 fpv99ateuP4DZ9b+ILo84QRVbGViAPuZI7Oh6OrPp3Z/A3UxeZ3F93YrY3v9MvF8ieJ4CheiW0y
 3D4kTa/otJLrcw210wtgV0NPRf5ML1Qe2c0LCVTP84GIan3JIsBgJmAKTkPenvtaYqaM5FP0FsM
 r7jDbIUqvau7eqvA8cVuhZxkiTdoy7H2c4Y02f7ikdrcNTPhqY7CCWMprwUUR+C1bQBUyydfRCe
 SJnTUc0aWsj3leZMhZIMcvPUfATKUSVGywZNtTlI1cushPjdAw4KsbojAX2Lt7AIPjiRH/v87B7
 JcFwu/PH3W2e+Y=
X-Received: by 2002:a05:6820:1c87:b0:6b3:6920:4ca0 with SMTP id
 006d021491bc7-6b6fabe1ff3mr3531638eaf.9.1788523295847; 
 Fri, 04 Sep 2026 05:01:35 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm10164241c88.4.2026.09.04.05.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:01:35 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: fix typo in log message
Date: Fri,  4 Sep 2026 17:30:09 +0530
Message-ID: <20260904120044.14303-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120044.14303-1-hemanth.selam@gmail.com>
References: <20260904120044.14303-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Correct the misspelling in a message the user sees, reported by
scripts/checkpatch.pl using the list in scripts/spelling.txt.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
index 33c23532e29c..c0507d9193e2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
@@ -1759,7 +1759,7 @@ static int tonga_populate_vr_config(struct pp_hwmgr *hwmgr,
 			table->VRConfig |= config;
 		} else {
 			pr_err("VDDC and VDDGFX should "
-				"be both on SVI2 control in splitted mode !\n");
+				"be both on SVI2 control in split mode !\n");
 		}
 	} else {
 		/* Merged mode  */
-- 
2.48.1

