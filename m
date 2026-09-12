Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8AAC88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B753210E9EC;
	Sun, 13 Sep 2026 20:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HiTW4Qiz";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F35410E664
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:10:51 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so295111a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789200651; x=1789805451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0GoExsibafFWCOKZx2T64mk+4e5+1pi6zhVko5O9cFc=;
 b=HiTW4QizWgAf7Z6kDQiMfh9BNxMuA9YnnH85NUqIVQIqzeBcllngf8j3jIEMkWkCag
 tDRfz9lFT56Zk+Hrp9IzhQlsW7JsJKMPl1zK4HmXPwRFCr6wjpdsMn9BqEyFtayqUJn6
 IppfgTXxlFedbYgWK3J6s0rkRVaVC++mmryS77j9o+jwcQR9NZTTy6xE5LevNHGCjIcT
 4MErX9WLEf0VkIbjDYhHSG7OEGCV7wHnBdo/tDNn8qMxIAUv2fdywYSiKJGj9rbnxLWB
 coF1xw8YW59PpZPVh/rE8uuTZVJE4hzcmeGWPQpGRyTQue/ir0jKrev4EXMIHSJRsCgx
 Pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789200651; x=1789805451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0GoExsibafFWCOKZx2T64mk+4e5+1pi6zhVko5O9cFc=;
 b=Fe/mEOcEB33B9gMvQyhDM7vDpfil+nZuIgfDnAWIHq5MPPv6LcdbTvMT/DIY8e2hAq
 BhJ23F6oo/TKV7KtHadtVVK05TTTIHTxRmbNcwAP8WAS9hvyWxjAiF4nxycKRcIh1XtU
 2276GmXUvhN+9s64RBIz0GAQEEx488ipAwrtjBPqMEIDBxT0jXI0p+4lgwRuBWg+sDzx
 iVma1xSzAx/UxPQJN9ntgjE5XO8gY7qtw5nlcw2B1II/Rl1EGdN1TovF17BPsY1b7bOY
 y9Z+4LJ6+uFzCh496gdBshfVa37K4PC3EWh8xM28rv4OPlXBsu2y8qairVk0pc4p82X1
 9F3w==
X-Gm-Message-State: AFuF++mXuPl2h3g8kz1qDklEFQvIdb25jYKGqXmdnRdHUzexYOrNDI1v
 Q9R+Kb1TepH9UGu3JKIwblqAz+T7oI6oe/s+eZauX4c3M/0nmUMNNnnR
X-Gm-Gg: AYBFou05kkmPhi28Fh25G1HXINuW0qMhiGxc2xtZweyRX65MJocLYC2ismrmEiBgeC5
 5W36ea8yPOgmNGWqGLVcgsewxQjpJEjNBTuVXKASZ6mtUr3WGmtRBgfq7PStAqMappLAxDvK7At
 2J/djNsZJJoRux+vcHhs/vASKnrMXUP0p5e4B4/ltc1BAbOv9dxvBzuHqYm9kEt7fJQUMX6epim
 4GzmGqTqFLvSKqFGtLO0Ujy/hEiw93FWJfMdDG3Mc9W0CbwyLQ+iW4+OtpdHcr2ScIwOcbzse5o
 YsrNgNP/mVTSDGQAa/vH5ny7SxgW/+If7u0Ddm16QgF4uIMZ9RW76P6036MZDSjiM8J/fRGvkZL
 7sU0smxbO3xZ3/2yN3QJAvwRpWbD9Zi4Hq5MYOToK2HC0YF5/HPafo8M3uE/4tlEHc4vgJiQsu5
 ouiq7Fp4i0IqT9Rba34CQMdS/MWWZjybz9gafe4pLW/zdkp6/A3cHo2pVHRdTi3NYowrnSpkJX3
 /m/P6PQZKERa2hB+RB5h1P6fdaPwMLpDtUWVMO7Pw+9CWdqcNF1NyATpIu2A7lS5zSaeBj2yE6G
 6hOe4WA7mXYOTFdeBd5u0bH3RCcAa6+xYErh+/Q5knpq
X-Received: by 2002:a17:90b:1d82:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39dbbe8b88bmr3419988a91.3.1789200650925; 
 Sat, 12 Sep 2026 01:10:50 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db7ae6d25sm982474a91.1.2026.09.12.01.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 01:10:50 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 4/4] accel/amdxdna: check the command payload before using it
 in the exec requests
Date: Sat, 12 Sep 2026 20:10:12 +1200
Message-ID: <20260912081012.2274075-5-0xiviel@gmail.com>
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

aie2_init_exec_dpu_req() takes the payload of a command BO and subtracts
the fixed header from its length before establishing that the length
covers the header at all:

	sn = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
	if (cmd_len - sizeof(*sn) > sizeof(dpu_req->payload))
		return -EINVAL;
	...
	dpu_req->inst_buf_addr = sn->buffer;
	memcpy(dpu_req->payload, sn->prop_args, cmd_len - sizeof(*sn));

It also dereferences sn without testing it, although
amdxdna_cmd_get_payload() returns NULL for a command header whose count
field does not fit the BO, setting cmd_len to 0 as it does so.

Both work out today, and for the same reason: cmd_len is a u32 and
sizeof() is a size_t, so the subtraction is evaluated in 64-bit. A short
command produces a value near 2^64, which is larger than the payload
field, so the test returns -EINVAL before sn is dereferenced and before
the memcpy. The NULL case is caught by the same comparison, because
cmd_len is then 0.

The guarantee is therefore supplied entirely by the operand types. A
later change that computes the difference into a u32 first - as the
sibling slot-filling functions in this file already do - would truncate
the underflow to a small value, and the function would dereference NULL
and copy from a short payload. Those siblings, aie2_cmdlist_fill_dpu()
and friends, all carry an explicit "cmd_len < sizeof(*sn)" test for
exactly this reason; this path was left without one.

Add the explicit length and NULL tests here, matching the siblings, and
add the missing NULL test to aie2_init_exec_cu_req(), which copies
cmd_len bytes from a pointer it likewise never checks. No behavioural
change is intended: every input rejected by the new tests is already
rejected today.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/aie2_message.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index 3028968..ab9e7c4 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -556,7 +556,7 @@ static int aie2_init_exec_cu_req(struct amdxdna_gem_obj *cmd_bo, void *req,
 	void *cmd;
 
 	cmd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
-	if (cmd_len > sizeof(cu_req->payload))
+	if (!cmd || cmd_len > sizeof(cu_req->payload))
 		return -EINVAL;
 
 	cu_req->cu_idx = amdxdna_cmd_get_cu_idx(cmd_bo);
@@ -578,7 +578,8 @@ static int aie2_init_exec_dpu_req(struct amdxdna_gem_obj *cmd_bo, void *req,
 	u32 cmd_len;
 
 	sn = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
-	if (cmd_len - sizeof(*sn) > sizeof(dpu_req->payload))
+	if (!sn || cmd_len < sizeof(*sn) ||
+	    cmd_len - sizeof(*sn) > sizeof(dpu_req->payload))
 		return -EINVAL;
 
 	dpu_req->cu_idx = amdxdna_cmd_get_cu_idx(cmd_bo);
-- 
2.53.0

