Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1959CC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07E910F66E;
	Fri,  3 Jul 2026 07:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lsv+b7d2";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A133D10F58D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 19:45:47 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-37e1657510bso262324a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783021547; x=1783626347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cly/nd+WtRjsO5TA3lU7g6oCqpic1LOhtM2jPoyTuQk=;
 b=Lsv+b7d2fGYvWRIU+v84/0i4zb7u5Ux4eay+Z7CEG3/bNxE3ve12H+HVFG2mzK77K3
 WGHKUxrA3mXZmnAXnb/zaNiS+JeqDIefgYlZ0PY4i7bBaInL6wJBYtYDAodBANkp6L3I
 ypsi2OyQ8BU+cjMZNEeHO7HxSi02eBBTrTEtCtiZrLxZZE89WhAGbAtzCsulSOjkjeHT
 NlGFSJme1ddmfaB5MuczKwWMIDSH4rzz22kkUZZeofrg1igh8VnslEllmCjlEvnKydQo
 r9lcFbtfPX65jqbyZEo+xGLZic/ukeTD+EmCs/CwDTeVNMvFZPyqfWLCbVazUmLK2Ttx
 Pd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783021547; x=1783626347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cly/nd+WtRjsO5TA3lU7g6oCqpic1LOhtM2jPoyTuQk=;
 b=fmFDG6CiHl2H1ivv0gNHMTi+68P+4zLMo/9fB1K1gZTVEfHfz1ZCYEiJUBTx/Mjsuc
 yTuhHOCPzHWXJTAIQ8MdhuQ1+bj8zNVwLRpbzgIQtlBCTuL7nULXC3lIHBdcZNIbX1jz
 l0XfTYfmRkrT6jyJAMVtOYoTXCK4HIZ6NoRw5jtranroCdd9UeJMb9UE5pYzGB5phqzP
 lTLFkHCqKGTnLhVSX7B9ecmQERWmhn8Fsf3z2aFpbc/6jOTVMcQe7TS4K5Gjtb/s5eqV
 GSdeS317987S6zsXdYN9ldaoj/ArjCs8CZ7K/eY93SkOigLtngglSHtawmskczpdBfUH
 BWSA==
X-Gm-Message-State: AOJu0YwjkAQ6KKmBGkxnjKJZiV7R1ledxYjlDP76s3I4ru0kDEGskYPz
 xg/WCzuIAv/iip96tr9JS9+EIbcDJzkdadJNnVkyIgJjQX1ybKABUPdi
X-Gm-Gg: AfdE7cmpKJo5BmpRsJ+XwnXQHTaL42jICGUTo9QnYSv5A+HC8MZJNJ+8q//2yRxM/e2
 Y/ZloJpX/jAY3dyHH0BObyKt0xcr8ttoSVCIGKLHJizpWTlJcfVrnscv+r8PoD6oCNRNGPdhlfa
 7bc1QUUdv3XF5FD6cMg/L2QtYXmOdqNvoPoJ08EeA5orlVNOECcGUgT/tupX2ydsFOksYj4RI+4
 AHknpiRmpu+bKzfhcDU7MXIljYNEgc8XY65+knpAUj/idgd5xVV/Ba3zY1zBJxuegVOkOJZumrL
 un411ti6Kc03w1xMa0+rBmkfD3V6qck2prG3qWWEwrYjUcDHz+rZOFSZWhRY6wuFw1AonJgw2DY
 z6FSXwsv64flad0Ug7DuYt1hmObKf2kZLlSf1Sw9ioLvqbRfMkykZM0QZf0r/aWI6Dzr5siUmOE
 N4GlN8pUYJibh1ZfTS7ylxATK9KzUHxCYpmTr6gBqAp1ZCDQuVl68uGIj0d5lSdA4kptuBj2bne
 c+1U/QASTlYnQU8z3waR+H5otLiJHwHgbE6usCQOmrVH1OiHPg0Yys9MXYWCDovI4Psio3/MNOb
 M4PtcFXmfW84BAeuyKkppPaVHJbsIw19nA6KH5tjR+jebfBZ
X-Received: by 2002:a17:90b:2791:b0:36d:de94:f31 with SMTP id
 98e67ed59e1d1-380aa1f87b9mr4934895a91.7.1783021546906; 
 Thu, 02 Jul 2026 12:45:46 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b85de12sm12578844eec.12.2026.07.02.12.45.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jul 2026 12:45:46 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH] drm/nouveau/therm: remove unreachable fan update branch
Date: Fri,  3 Jul 2026 01:15:40 +0530
Message-ID: <20260702194540.65127-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

The fan re-scheduling logic sits inside an "if (target != duty)" block,
so by the time the inner if/else-if chain runs, duty can never equal
target. The "else if (duty == target)" branch is therefore dead code and
has been since it was introduced. Drop it; the two reachable cases
(duty > target and duty < target) are unchanged, so behaviour is
identical.

Signed-off-by: Anas Khan <anxkhn28@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c
index f8fa43c8a7d2..c4aaf7473065 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c
@@ -90,8 +90,6 @@ nvkm_fan_update(struct nvkm_fan *fan, bool immediate, int target)
 
 		if (duty > target)
 			delay = slow_down_period;
-		else if (duty == target)
-			delay = min(bump_period, slow_down_period) ;
 		else
 			delay = bump_period;
 
-- 
2.54.0

