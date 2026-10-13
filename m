Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63815CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6CE112155;
	Thu, 15 Oct 2026 07:56:44 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB04E10E882
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:01:28 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so23671895e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791900087; x=1792504887; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ViTWpehkUTNRhhx96u8NdBVsVZbPiHx1y/c2M4wY64Y=;
 b=jRVlnioh4GGa/VWFL7qF41aKB81rflnIGo6aVF2HEl4TstSfc97k5W8SShf2RV8Xz0
 0veV7jCd6i4SMg7XvqcPUo2IrPMCxHPXKYspBZ9UR43b3Yb8dLxQuYwF8UiNA2dsc+zT
 92/bbtbSl8dRiMdcT7UCmyS1qu+QoHQvOi584GtV/uz5V1wpYCnhZ8TKc1WBcA5HAjP5
 o+q77oPtGiOMNvLW6i9QyZ0nAosyajycuB7r8L6jU5OKvV7RUVn9CRR8vABH9CXBRQVs
 jIOH2q1ki/LhcL5TYK4uzzBy+ypyoAy/yn1VEPdp43tjDfereq+HTHBoQRe1dHFgff2R
 M3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900087; x=1792504887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ViTWpehkUTNRhhx96u8NdBVsVZbPiHx1y/c2M4wY64Y=;
 b=1WibQvk+DqjJWci6E5K2QZ1AXc7fA2n6fxReuZSLD45ea4/slZccbprPWh4E+KIuCL
 n9+oKicb6lKi/3M7e9YSZomvndUaVhEuOhUS9etDzpELFQyeVpBkZ3dBWHV9odyiKeYk
 Ok03UynjchRRSfXPmcZorQw1JuhGWF9LDqGOmC6jPEvCN7HsYNZGjCajdcZppSGm5zQu
 4gb14HvAciTfab5wnSX3OuXkvPnToLxvTMonCyz+vaUxRJf8dkHquZ5vp9N+uKQOK6e/
 8dDgGOq2gam3FmaMsiuj9rtf6WGTfHmNyWVHLiJt+U5hYB1+0lDztUXTaANoSqGFqV92
 lFPw==
X-Forwarded-Encrypted: i=1;
 AKwUvByHqY9qG7AvZEqOnyuyir4Xqzaie2fiuI5yC04jcPtXzuOh1PexCGG1k7FVHCU9XvKtABtvJEMvdFQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIAgnk+mHXY9l5B7dhOw5knrsO50kmufc9UgVTfy54wJkM9AT2V
 KQ4npINoZhvxcNyJpC3LvMKrq9YtuBEV8K346lCnzmqWqhmwFLWEGXKp
X-Gm-Gg: AYBFou2+NapgQ6Vn3It3M/Nd3ilycgpMap8vtoxLHxeuyxtITlWe0IwAurJCY5R3YZy
 BLfvt3dWfh6XVXB06cS++F7W15xU4e6M7hBxGVxEuv6cj6gdvoy/WO7X6MOTVm1fPc4qf+EsebW
 3NVEAp7t+K+tABRP0lhvw3PXp4CgCuCVPoXsMkvhJJsyb5MRRqRUe00osef5H/Q9xNBbik0zbS6
 0dWJX8o5HBJ4ntdyJ97TJaKUimc25PGzhgHCcv91JIuq1aumG+r3EZQ5cJUKX0jWX/O7pp8YO2A
 qXpIxQGZfBHSWN4150VZYGJMpUpzcHnvI+xh7QbHQCDxKrsRf+AwRYzrRC31Wt6K+pN+9m/E1PL
 vQpR8uMm8hXnoDWju4Bgt4k/UtNw9l+qEEhN6DFRrhfP4QkDE5hUzml/pSlI+XlmsA5RPpvcpab
 PPP1Zf3eSnLPgUHwKCaqPVGLj+7Yi5oaMknUrt1ZyIgwTKUY59my3CLvswWyvktiB/Rwa8J+rr0
 /LKG71qoI+/pz9ykg==
X-Received: by 2002:a05:600c:3111:b0:4a0:1e87:910 with SMTP id
 5b1f17b1804b1-4a18e4cb7a9mr257096075e9.20.1791900084826; 
 Tue, 13 Oct 2026 07:01:24 -0700 (PDT)
Received: from potato ([31.176.175.60]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72d2b13sm304691f8f.55.2026.10.13.07.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:01:19 -0700 (PDT)
From: Omer El Idrissi <omer.e.idrissi@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Omer El Idrissi <omer.e.idrissi@gmail.com>
Subject: [PATCH] drm/amdgpu: remove unused tracepoint
Date: Tue, 13 Oct 2026 16:01:03 +0200
Message-ID: <20261013140104.32179-1-omer.e.idrissi@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Remove unused tracepoint "amdgpu_reset_reg_dumps", flagged by UT=1,
from amdgpu/amdgpu_trace.h

Signed-off-by: Omer El Idrissi <omer.e.idrissi@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index fcd4cf2f4cd8..6fecee5be1ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -564,22 +564,6 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __get_str(ring), __entry->ctx, __entry->seqno)
 );
 
-TRACE_EVENT(amdgpu_reset_reg_dumps,
-	    TP_PROTO(uint32_t address, uint32_t value),
-	    TP_ARGS(address, value),
-	    TP_STRUCT__entry(
-			     __field(uint32_t, address)
-			     __field(uint32_t, value)
-			     ),
-	    TP_fast_assign(
-			   __entry->address = address;
-			   __entry->value = value;
-			   ),
-	    TP_printk("amdgpu register dump 0x%x: 0x%x",
-		      __entry->address,
-		      __entry->value)
-);
-
 DECLARE_EVENT_CLASS(amdgpu_userq_queue,
 	    TP_PROTO(struct amdgpu_usermode_queue *queue),
 	    TP_ARGS(queue),
-- 
2.53.0

