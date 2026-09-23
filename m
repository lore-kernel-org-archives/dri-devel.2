Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C406AC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA3E10EF5E;
	Wed, 23 Sep 2026 07:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s6ImteZH";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6014110EEA2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 02:25:40 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc5256c2a4bso260880a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790130340; x=1790735140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YgscQk7Ar8r9xNVFdDi2QgmLohb1qk8AI+LPa8A9QYM=;
 b=s6ImteZH/chSRpWVM/ZxnB0/3J362Vwzx7MKrbofMV2UPpuZp0YMiOCGLj/UqCsXd9
 U4JJ/UYqL5hMyIQEm5zUwFyVgbuXdrfxlT276E/aole3R82aFIguXUVUHX6q+i3Jez17
 P0fzTNK9REat8dcX9vwGKnQ/0AeRVXEZ92GlhE+fheG+5IOzb01rG7J16tbHn1Bulatg
 PKXck/jev6pjAL/XcUJy0D/O0JhjTbQZBiuhmBXFFa1DkT2XfBIw4c9bpEJzD+SfKE99
 WVbGt9r29IzaaOQjsycMBUU+B3tgTjz3pUHZdvIktRqYqpgRUJZlrmbJ3WreP5Um6saV
 ZfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790130340; x=1790735140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YgscQk7Ar8r9xNVFdDi2QgmLohb1qk8AI+LPa8A9QYM=;
 b=LKdd0ZDeaJgvZUkgI2r2Bdj3x8yyZlwos764DbZgg0JP+pnlvXqmETAFawrXq60Dsg
 peZABdPisxcJEVuFQnZgw4TT7X2bTtZupf6sBkKWtR3etuXDz6xlUdWykK7HsEIzSOS2
 JM8NKWs0NBeksbWkQ71KRhvT/fGdpO47Ns4Dcqc4fX3ha4nQOPcT1FpF19PqjlO6f2rj
 lVaosCx0GvfJ6v/Jwle8rFuCfj9wAtByaefnBco+fQmbVJvBKozsZpfmpu5ik5WBA2wL
 wPjUSpYZUnmN9qGbvtWtirF3XNtLc4Dv9I88RAxxFlEwfK6ltxjYSkixAA1Cq6PRjaC+
 jNGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+/HsExQpf5QLfWqtU8KLxPl/gTVVyDwAx7CI+n6gcobOuhbgU/YjtYYJfjKx5T9EoE+SKzdacHYg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kCQpHg6BjqgLEQv/A232LpoyjzP+XeIhqtv0yGb3SmsMDNm3pu
 Ug7OVPC9a8/tPq1mcc4T/bUk4adn0pshLqia54x/QON1p6Edw6FERXdr
X-Gm-Gg: AYBFou0pGi6AcdP03fGI0NTc2y8pcMzXfbaUdc3ZXKynmqa1jWs3kDlM46TVoFWJl6T
 o/heFypnNOFKGUFu3ABSZKCcgQntJAjPxwSA1Z3UB7ALgRQQZcmfDp1+1Xh79JCjJCbjFyUNxvw
 YwTmurmps4+gcqrFSRwOI4NttPkRWcPijoKOR3qbDd8ry8vnnqxf6djp5ZUtjVPNKzYIz/OB9A4
 zYAC3i1XZToWIqXMJkNvbuBCrJGHvZnbIzTCFRXFRXFIl8BnrO8iX3An91BFyF0+CFlKK0yLL04
 Wt/Je3cLcMxhaL9kWM2XdwSd/FlfgIP6odsQqHK0MAnygUJ/HpYqWKNCq9ztxF+6HIA9xA3B69v
 Q0IL2OeWOFhOOrPFF7rBrKKJwNtj9sOkaTtjcAw77fEKJrH9n1CE4kLMHMfyTg+L30T3k7lVfxV
 Dsn2g+VSsWhTBiPDGOBIdi651O8p4mz0HYbs3Y4OCihJa22QNsllzzNit/cYRhmbW94sKjgnv3l
 n0s73XtmPr2DRkqp3WcHPZYhRpa2CS/kXSHezSEO/449xcWCBMprD/sqpwKxKL6
X-Received: by 2002:a05:6a21:730b:b0:3dd:a195:fa16 with SMTP id
 adf61e73a8af0-3ddf82fd6d6mr1278376637.59.1790130339718; 
 Tue, 22 Sep 2026 19:25:39 -0700 (PDT)
Received: from k1832-XPC7A-R57-GD.tailc99621.ts.net
 ([2407:c800:5a41:af7:fd99:3ec2:4e58:1374])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f40839csm309403a12.30.2026.09.22.19.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 19:25:39 -0700 (PDT)
From: Keita Morisaki <kmta1236@gmail.com>
To: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH] drm/amd/display: Fix swap in median3() for DSC rate control
Date: Wed, 23 Sep 2026 11:24:51 +0900
Message-ID: <20260923022451.3346675-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

median3() is meant to return the median of three values, but its last
compare-and-swap step swaps b and c instead of a and b. When c is
smaller than both a and b, it returns max(a, b) instead of min(a, b).
For example, median3(2, 3, 1) returns 3 instead of 2.

_do_calc_rc_params() always passes 0 as the first argument, and the
second argument is never below 12. So whenever the third argument is
negative, first_line_bpg_offset (and second_line_bpg_offset for 4:2:0)
is set to the second argument instead of 0.

Fix this by swapping a and b in the last step, as intended.

Note that this change does not affect valid DSC configurations. The
third argument is negative only when bits per pixel exceeds the
uncompressed rate of the colour format:

 - 3 * bpc for 4:4:4, 3 * bpc + 2 for RGB

 - 2 * bpc for 4:2:2

 - 1.5 * bpc for 4:2:0

Fixes: 97bda0322b8a ("drm/amd/display: Add DSC support for Navi (v2)")
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
index b8fc27a5361e..657173d8081c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
@@ -46,7 +46,7 @@ static int median3(int a, int b, int c)
 	if (b > c)
 		swap(b, c);
 	if (a > b)
-		swap(b, c);
+		swap(a, b);
 
 	return b;
 }

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.43.0

