Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A31C54F53
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840FA10E7DF;
	Tue, 28 Jul 2026 07:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UganyU/t";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB76710E453
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:06:05 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso17552395e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785164764; x=1785769564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgMfUYC7ZpwL2pGUZegRGSOZuFsMOmvyJZY8xkpkpds=;
 b=UganyU/tfjumEe0NnvH5j8WkpaDIa6EsrG8EcWlBCr8qHilHV/iSNvkMeufF3Gqy1J
 IGlAjouu16mhH+VScug8T1ppX7RLYrt0hoIhpWV8jAO7fJYWBznRCond38COFmNzlGDv
 SiY4peS/5EyZBzHFv7VgxYLoYAAVLLCM7rIfgkv0g0rwIUvFbGEyb7zAsazFvUPYd3WS
 p4+ON/t+OEdGGhyRyPjWlWqmpFEvqcpYwPwLT4fRoP+W7jELK2ksSu8MN2XEYBndFUWi
 sST9jiKU37hTRgl0wPFQOXBUaGv7hoTeNyOXJM9HhtFlFccL49dK4S/pDo0LuSVKAyWJ
 xbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785164764; x=1785769564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgMfUYC7ZpwL2pGUZegRGSOZuFsMOmvyJZY8xkpkpds=;
 b=CzMag3gsrmtufIVGzZa11TRHsvmSGhfkp/gj9eW7VqlpKRcQTAZSl5F/o80Y2VaHTp
 dfcbJo/p/CXKNdsTan4FL7OdjOotldf5yeCz8q1I6jV6Th8Vw1Es2Sg1SfzP72hCYw47
 XYRSXvNJNaonljjZ06uzyeaQWaIl4ZIROLXwSru+aG0TcDHj56APG5e7PcyGmIjvIkeh
 t0Ax/KbfazR12pY/DNOXpLKBQ4g8J/eoz15rZXwVrvanULw3XrE9fJjt8yjfX1TIMYGF
 LZrGreTgDqubFcbKU1x+S8cWHKeh9JOwmIVcbTbXT1WEnBtK1hKTveNP/AzAJzWVGBrz
 2FTQ==
X-Gm-Message-State: AOJu0YwG/qboz2JQkLb7sV+lz7UVA9tYjHcmJdtpkGLQVa2TsKSK6jbu
 eF6kJAgdKYO5uv+GYZ2kI8yHDly1lxFIpAVGiXCkgmag1yyL89qdn7OblvitplON
X-Gm-Gg: AR+sD13f7zYaDCr9du1F8BijZhhIUNgarCT3ktNRaL1SG/ua+H+azHWps+pTu1l2giC
 qJj5ySNkNRINDo9dj3QUVOmfvjZjC6KjZ5GDORilUgPvwcS3BgPxmnA1pDf4RrfvozlO6unXo3P
 u7Z529+ueWx2/Ny3ErLcGhadA1MWcdYf+w1WsqOEWTB0D2mwUeH37Ugc1HnpKlaKBIH7RbVVb9s
 6QtZjiaPpCPzUxnvghe8Wy4VoclhsdOAeIq/cwCuR7EpJ11Q5JT21NuhGaiq+9rHKNWFKq0TJg/
 INZlJ8t5vCs0u5gT5toQUFFwe0gH8m8CQg++G1CjfHgi8gDSq6J6zA0lhxrRTKR9MZECagUdmsc
 X5nt1hj/JNIJcrF8gKVJhJsrLYDs7ewzoPhtmeButq20i6swcCRI1p/w4r5mzvoTcbdoP7qEB4/
 bPLtk1ZzQ=
X-Received: by 2002:a05:600c:190c:b0:495:495b:9248 with SMTP id
 5b1f17b1804b1-496b79068acmr104556845e9.4.1785164764177; 
 Mon, 27 Jul 2026 08:06:04 -0700 (PDT)
Received: from fra-x8664.lan ([151.16.232.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm54242960f8f.7.2026.07.27.08.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:06:01 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: [PATCH 2/2] drm/nouveau/clk: only update clk->pstate after hardware
 programming succeeds
Date: Mon, 27 Jul 2026 17:05:46 +0200
Message-ID: <20260727150546.121357-3-postadelmaga@gmail.com>
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

nvkm_pstate_prog() wrote clk->pstate = pstatei before attempting the RAM
and core clock reprogramming. If either step failed, the software state
tracker had already committed to the new pstate even though the hardware
transition never completed, and a later re-request for that same state
could be skipped (pstate != clk->pstate would be false), leaving the
hardware stuck out of sync with what the driver believes it's running.

Move the assignment to after nvkm_cstate_prog() returns, and only commit
it on success.

Found by Sashiko AI review (https://sashiko.dev) while reviewing
"[PATCH v2 2/4] drm/nouveau/clk: don't use the pstate cursor after the
loop" (20260712123616.1180830-1-postadelmaga@gmail.com) as a
pre-existing issue.

Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
 nvkm/subdev/clk/base.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/nvkm/subdev/clk/base.c b/nvkm/subdev/clk/base.c
index 737bec8..91c51d4 100644
--- a/nvkm/subdev/clk/base.c
+++ b/nvkm/subdev/clk/base.c
@@ -285,7 +285,6 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 		return -EINVAL;
 
 	nvkm_debug(subdev, "setting performance state %d\n", pstatei);
-	clk->pstate = pstatei;
 
 	nvkm_pcie_set_link(pci, pstate->pcie_speed, pstate->pcie_width);
 
@@ -302,7 +301,11 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 			return ret;
 	}
 
-	return nvkm_cstate_prog(clk, pstate, NVKM_CLK_CSTATE_HIGHEST);
+	ret = nvkm_cstate_prog(clk, pstate, NVKM_CLK_CSTATE_HIGHEST);
+	if (ret == 0)
+		clk->pstate = pstatei;
+
+	return ret;
 }
 
 static void
-- 
2.55.0

