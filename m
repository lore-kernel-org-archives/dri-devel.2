Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E54C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60A510E230;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nJv56ImD";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20BF10E664
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:10:37 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso590027a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789200637; x=1789805437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ukdiol5JyLif0T2tj02gnGl5hqC6N0TQpHgMhHI8Wqk=;
 b=nJv56ImDdWst61wcmKyaj22YvUJwWT9CqzXfIlAYWvLaBnAJGPSZiPsg34SWb6RnOH
 nX2X/pe3oIwkvHDTdRwnyqBJed2enU5V/ZGr3OOjvW1iaWjgivs47TUJZRmVY+kgYUOl
 iGJ5NtSyblX0ofOJcHOawVb1134R3aKXiJU3Y7aiIY11K+nq7IzHIoNJqA+HNFC2ZcCs
 PwTnQOyWK7UhI3ELhKmEoleNpNm8UrJmbv7piz0/iOOFR0lFZZqf3qbEe7ZdXVWOt6lR
 2DLEo5f2O2mtQMHI4ECqaqEVD39euFNMBddNJnOwuKswJY2v5/kYRaARAAFNcVg6XsJC
 qk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789200637; x=1789805437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ukdiol5JyLif0T2tj02gnGl5hqC6N0TQpHgMhHI8Wqk=;
 b=c7PHcCloWislG+gEvY1nrh38/gg4Oe3UsqAAFJ6serxv+iPlMW1BDIBxWWQsk2G+rJ
 fKssRcmsuGx+jCiYFTueVir80pMo7W4imHO8eXm1qiD58w2wxR0hG8b6LqrwH8iHtJ41
 Y/0AnHopQNXe9qK0pEnthHMXbnheD44+2oEEjJpzVpRaUrLtAsdQGkDFPvKH3zNnQb8w
 1e/NZINb1qwR3Db9lom+o6YehQLQFdXhemHe7f313amblMQFs1YDetpGF3/WC5VpPyz1
 pam9qk6Yxp1fD6aJOPLYd8beXWVpQoa5NjJJHRspwStgwjjAXSds+rbT916gJcoJ0tFr
 2O3Q==
X-Gm-Message-State: AFuF++l2jtLB7rpHOVXkbrZ8i15fjNLe1xM09rvRUACdg7lCc4n3G/tG
 dSNgpcCwDTRpe29V8nNKhjrMdXvdwWQatHmoCo91tRoThiCAlp6EOQMT
X-Gm-Gg: AYBFou0LNK1kzpdpGyCTflvAwxxMBBEPILpTV0dkWVHd2e5d6syMq8hdGLaZA69IrRU
 1wbyGAYjdQjn4r5xOQcpCeaYQL+6WqdLD5E0FUDhypvezBXcK7ZhzM0iOxlN8RxChyTxEWlX3hP
 TpdzpIr4Z9/ioX0hKuPM+KhrQYmgMotJLDRqsWhQ92PO4tj0F3MH7fWBdxOXXH3Vvu0PmwmV17q
 LRbIRrOiy8nyJA7pa8bwQH0Tmw2mgYWhUdtB9QfI0756ATnAYTUBn+j0whLjvDWXaYqr+aRY0uK
 UE6z6+Ijq1FL+/6b/dNmL9sItUr6JTF71krQGCh1L98wCnrXCxNwFTCPTJ5YnMfgLBGbchBtGZF
 FiMW75AuK7G5UBf0N5wmhGMiwd1j68d9Xnlrv0Qw70YeZSc1TOnAhAVCrgYXYXtfjXu/xs/mxEO
 3W81kTJSTTHMEGrT4pFYEB4tr+1UDlkhqcvL99RJhSWfv6MDAlSnRflVc/VZo+zJM6JE0p9tXdY
 BUZLNvyYUo5Me0NCmUqYNBSmDZ1wv0p5Bllt4NepKd0wCvwrf20OimDsqYZrNMqqhaUlTlEh7kA
 +UaqFedLzmtFVBIKoWUSfC6JZaC6xsKxwHbS+AkQk7o2
X-Received: by 2002:a17:90b:3c03:b0:398:de23:9af6 with SMTP id
 98e67ed59e1d1-39d9c1db154mr14531954a91.15.1789200637023; 
 Sat, 12 Sep 2026 01:10:37 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db7ae6d25sm982474a91.1.2026.09.12.01.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 01:10:36 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 1/4] accel/amdxdna: validate the command payload regardless of
 the size argument
Date: Sat, 12 Sep 2026 20:10:09 +1200
Message-ID: <20260912081012.2274075-2-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912081012.2274075-1-0xiviel@gmail.com>
References: <20260912081012.2274075-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

amdxdna_cmd_get_payload() performs its bounds check - that the command
header's count field does not describe a payload larger than the command
BO - only when the caller asks for a size:

	if (size) {
		count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
		if (unlikely(count <= num_masks || ...  > abo->mem.size)) {
			*size = 0;
			return NULL;
		}
		*size = (count - num_masks) * sizeof(u32);
	}
	return &cmd->data[num_masks];

A caller passing NULL therefore receives a pointer into the command BO
that has never been checked against the BO's size, and no way to learn
that the header was malformed. The count field is written by user space:
the command BO is mapped into the submitting process and can be rewritten
after submission.

The one such caller today is amdxdna_cmd_set_error(), which reads
cc->command_count, writes cc->error_index and reads cc->data[0] - offsets
4, 12 and 28 into the payload. That is safe as things stand, because a
command BO is created through drm_gem_shmem_create() and its size is
always PAGE_ALIGN()ed, so any BO that can be vmap()ed is at least
PAGE_SIZE; a zero-sized BO fails vmap() and is rejected by the !cmd test
one line earlier. This is not a fix for a reachable bug.

It is, however, a validation step that a caller can silently opt out of,
guarding a structure whose contents user space controls, and the safety
of the only NULL caller rests on a page-alignment invariant established
three call levels away. Make the check unconditional and report the
failure to every caller, so that the guarantee does not depend on which
arguments the caller happened to pass.

amdxdna_cmd_set_error() is updated to handle the NULL it can now receive.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 5315466..163b5fc 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -106,17 +106,19 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
 	else
 		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
 
-	if (size) {
-		count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
-		if (unlikely(count <= num_masks ||
-			     count * sizeof(u32) +
-			     offsetof(struct amdxdna_cmd, data[0]) >
-			     abo->mem.size)) {
+	count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
+	if (unlikely(count <= num_masks ||
+		     count * sizeof(u32) +
+		     offsetof(struct amdxdna_cmd, data[0]) >
+		     abo->mem.size)) {
+		if (size)
 			*size = 0;
-			return NULL;
-		}
-		*size = (count - num_masks) * sizeof(u32);
+		return NULL;
 	}
+
+	if (size)
+		*size = (count - num_masks) * sizeof(u32);
+
 	return &cmd->data[num_masks];
 }
 
@@ -159,6 +161,9 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
 		cc = amdxdna_cmd_get_payload(abo, NULL);
+		if (!cc)
+			return -EINVAL;
+
 		cc->error_index = (cmd_idx < cc->command_count) ? cmd_idx : 0;
 		abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
 		if (!abo)
-- 
2.53.0

