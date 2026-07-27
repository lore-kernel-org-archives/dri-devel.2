Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BF2C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4429D10E7D8;
	Tue, 28 Jul 2026 07:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8he0zfu";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B34F10E46A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:06:02 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so918760f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785164761; x=1785769561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TtyCVpfIwq8dbOfs0FyryLYRFkfiNQaZ8V8GbCjDPSQ=;
 b=J8he0zfuaUnX64ekTEtpxZR+aw9JyELiisd8s9jp+7pXfSj5OAMKG10gsarwUYrCGp
 gBlJ7vcyWWECF6pvPXdOVoIHM2eFydUCTp50XrfFaYF1v2ttqDckQfpljxuAazci4t7w
 0CK5q7ThJwjzR5JZfuScz0SZ/CVCIiwBBRQPoTUpzRkpAxS7tKZbCmL8A837sOmmmceF
 9iJkYijLMzNehSTKcjcwQ+6Hul4HBqlP1Da24jZbz1qcftV4BC6cqZCOyk7Na7aA14O4
 c88KW2SBk5VI99MHKgECJEbM0AM3igp0j7BIACv+D/43bA0KkEE3uAtx4lWuDN48L0np
 h5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785164761; x=1785769561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TtyCVpfIwq8dbOfs0FyryLYRFkfiNQaZ8V8GbCjDPSQ=;
 b=P55XJEAak6S6mBVvUj6J42qur7NdDTl4b2DDCjThEXdYWqIFQMeQgW7QLgk43171QH
 4wNGJ3D0EhCJAc8F1L81H0g3sbZWwv3bPBcsTa7FvJEX0VWebgqLKb3ibmHSQPLJpSul
 TZWePONunwSHMko9REx7eqtEX/Edo0vaEBGDQaV2gc438EXG6a4bvU0uLkl9pECCRiYg
 OHKNsVEAC+VwYMU83y+91EitKNdg7RWrbeZvD7FWN9x2p76JlCHakXoTQvsTtwaYkkDo
 TBAR9sjVXxfLuzXLq7RrcJ10nL7RlB7OkL+sV1qW9Cs4m3dF2bhMo5HZac70KaHWSUdq
 z4mw==
X-Gm-Message-State: AOJu0YwBhD2XBBJjWJnHunJDUL/lviwBa92QwMACJwT58dZwzk3S+N79
 dFKdalsjiRx+nshsLpzGyaKqkyI4rMfhjQ3VpUHxI5AZAZLb4bEHZtrQDuxcHXay
X-Gm-Gg: AR+sD12OzLr3SRgbYI3PZJiVpSlvQleRXoDH/P/0s5jjpo95ngqjReb/OzmtUvUOY2u
 tmn7L31CAvoQdkviD9XRj3ebFr5hSqARjhSxpjjMNvSgNBps+KjipRqZ7PyYinAuBiG8MCyNIrs
 sw4wAoYJK8zlbrdRzfu9m5urBPxKEmQ3aa5RoI0DYOvNTrFHPoDk3/GfOLeaQLXRU0AB/0GRBMB
 LfHE6PELap4hT4THWJoMrZhNEWzR+cxZjjxLlmfr86nTdZR6VQITPtBVDftzKar3lZja+ARJAO/
 BDFKjLofbccjFPQcDeF4OBSNg5cS8ziGakeDESCdqh18T+8CKLW9NyRwEqGxsG1eokeaAJ/TbJ5
 xhgsujFxs0dzX301GIclVFnck7EWKorEa9n4CTdLh40BXtItSq0cgKvyeI6ONp3GVgqXbUqjdnN
 y+IBjzMJN1r8xIgpw8Rg==
X-Received: by 2002:a05:6000:1867:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-47f9fc82a3cmr11583384f8f.4.1785164759376; 
 Mon, 27 Jul 2026 08:05:59 -0700 (PDT)
Received: from fra-x8664.lan ([151.16.232.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm54242960f8f.7.2026.07.27.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:05:57 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: [PATCH 1/2] drm/nouveau/clk: don't ignore RAM clock programming
 errors in nvkm_pstate_prog
Date: Mon, 27 Jul 2026 17:05:45 +0200
Message-ID: <20260727150546.121357-2-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727150546.121357-1-postadelmaga@gmail.com>
References: <20260727150546.121357-1-postadelmaga@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

The RAM reclock loop discards its own return value: once the do-while
exits, ram->func->tidy() runs and the function falls straight into
nvkm_cstate_prog(), whose result becomes the return value regardless of
whether ram->func->calc()/prog() failed. A negative ret from RAM
programming is silently dropped, so a failed memory clock transition is
never reported and the core clock still gets reprogrammed on top of it.

Return the RAM error (after tidy() has still run) instead of falling
through to the core clock path.

Found by Sashiko AI review (https://sashiko.dev) while reviewing
"[PATCH v2 2/4] drm/nouveau/clk: don't use the pstate cursor after the
loop" (20260712123616.1180830-1-postadelmaga@gmail.com) as a
pre-existing issue.

Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
 nvkm/subdev/clk/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nvkm/subdev/clk/base.c b/nvkm/subdev/clk/base.c
index 44dc86b..737bec8 100644
--- a/nvkm/subdev/clk/base.c
+++ b/nvkm/subdev/clk/base.c
@@ -298,6 +298,8 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 				ret = ram->func->prog(ram);
 		} while (ret > 0);
 		ram->func->tidy(ram);
+		if (ret < 0)
+			return ret;
 	}
 
 	return nvkm_cstate_prog(clk, pstate, NVKM_CLK_CSTATE_HIGHEST);
-- 
2.55.0

