Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC063C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42B310E7D5;
	Tue, 28 Jul 2026 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NcCH534l";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D9010E44B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:28:27 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso2314817f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785166106; x=1785770906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TtyCVpfIwq8dbOfs0FyryLYRFkfiNQaZ8V8GbCjDPSQ=;
 b=NcCH534lqL8UP6kkY3a+x8Hf97Y2LpjzNAFvctnskJXt0eoluN+YTwwA/IAGGlxRYg
 SLTmRfpyuJvR5XCBJRtfhH7/BhIbo9XeNDXJjPYa3BwW0h1NFWx+Jh2BA9SH4iR8uIMk
 67qkwi54QuEF/JXyj0a6V2GJL3YkWL+pjSrwcZJMQ5p/7qzV12mXQTKQlWdmi/CkRAhJ
 7E3CgQEcTvpCdy2f29MwseYLpaR4BUHqCP681Vbni0w2Q54evyAiwA6SIDbptqiw0dKb
 ncUaL6CeAXWSpS17tPtf2J5z4/aCljWC2A9jweuo/XzxV7eqFhxBf45CZveBh7hUeRnk
 MMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785166106; x=1785770906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TtyCVpfIwq8dbOfs0FyryLYRFkfiNQaZ8V8GbCjDPSQ=;
 b=Kjg1w2mtoBDAVxn45JUzWGeBdLRqXVqxDa58exuyUExH+ogelXzU5F0z9yXZwORnZJ
 UNGabJKXuG4qVlI2l543j/gjP0Rf33j5ejhg3QM5J06o0ewRQHUVoMXtBOWr+YwYa6uQ
 YFgMstvwMD8f2LWBJlayGy9l2krIaPxABbNxgl/kINw8MQWusv7+4YSn6ZnMCeEDek8H
 X4VhHSfP+sSfL4WxtoJ/PcPkTGhxfW4JC0drDyrvmJrysfP6dHVj+Xp5qrY+6OLoBKZC
 Mw3pPEMg4dqf7gvkjI1GGxBHn6wNWLO5LaoXNdHTWKZRuYLM0+aAj6dOqnWGMw8ywvJN
 uQKQ==
X-Gm-Message-State: AOJu0YyhGqM1w53XeMhcyadaP76VpzNbOUuT3g8Zxa+ZL8YuITp2e4lJ
 rTkAhQOzSb8CmhjbLACnNmvTIhkCeZV1HmGPlOoxzvY8/9Sny1RlzjfV
X-Gm-Gg: AR+sD13wjhXfKTmAj6uu5DEmgyNapmAeksf55B5+Q1qUAjxMQk1fHIm/+3/+uKvm9l6
 R2M9c3pOJ+TJYHUHHs9ACxOmstpoAMAtoDe3wfujU3N/nprx3fYMhfOrG0qcxgZcj4qOlADJev9
 cc+1r7lQ+SnJjZureUuzhGIewMIUc+FqISFJ6Gogim4l35uWxhgUK78DxbWSiEIW4qZtumDG/6k
 M3ytyMjjiC0rI16NmcpDKoI+l3hHV2AloO4OeSphYy3zHH0mU9vmZOAz8NWIW3l83eT9kO1yysw
 DeOQPc+B7DQhFabfcnJ1VyyTX7pg2mxEkehcy9OCYV2oIMIiXgrszDdX6CCM8MLgM708/3t4D2O
 t1VhrkIfG2f++IBZTK+VCv4mcPXaqAu5xqJUFgNTvnji1mrbIIleNrTWiq9yBIVnSZAyT/JkEs3
 76q1I9KLU=
X-Received: by 2002:a05:600c:8b52:b0:493:c2cc:aecb with SMTP id
 5b1f17b1804b1-496b570fc3cmr122540755e9.38.1785166105587; 
 Mon, 27 Jul 2026 08:28:25 -0700 (PDT)
Received: from fra-x8664.lan ([151.16.232.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b816ef8sm214838735e9.1.2026.07.27.08.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:28:24 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 1/2] drm/nouveau/clk: don't ignore RAM clock programming
 errors in nvkm_pstate_prog
Date: Mon, 27 Jul 2026 17:28:20 +0200
Message-ID: <20260727152821.128432-2-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727152821.128432-1-postadelmaga@gmail.com>
References: <20260727152821.128432-1-postadelmaga@gmail.com>
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

