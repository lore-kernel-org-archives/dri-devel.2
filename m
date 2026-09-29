Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B0C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA2910ED92;
	Tue, 29 Sep 2026 08:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="LQQ9WNnN";
	dkim-atps=neutral
Received: from mail-dy2-f20.google.com (mail-dy2-f20.google.com
 [74.125.229.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 929D010EC69
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:12:14 +0000 (UTC)
Received: by mail-dy2-f20.google.com with SMTP id
 5a478bee46e88-344447f9c3dso1446062eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651533; x=1791256333;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tYBLb2quugyRTAsa7b71SM3DW5Wwgo3gafQib73WBzk=;
 b=LQQ9WNnNZiFbr0NlWb62sqagmpgMm/Q/vSH9zKjSGDxsx2Fv45QsQMudINfUuIn5zL
 0PZI/vxjFbl3N0YjiKRAU+IRlIgmrljWXOri8HOS8He1AGvysCfVkGMHZk/zzYwojKC8
 n35ANyuDT06MFk1clTLcasr6Q/7QZR5wjZLw8oYV5LvB1BtImTxSxseca7nRtMeANXOz
 l/+Bd7Vtt2bEumvCM8X57J7B8rCqdAw0ILl4fImrAfqUUh+IaVLbvrrJhYeKS82rrIny
 01Vc8OHrKh+tgJzs8QELH8EG5qFUxoB1Wj8xwoiI7uXxjVGQ6JhSfHj14/jfV4lHUXke
 NEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651533; x=1791256333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYBLb2quugyRTAsa7b71SM3DW5Wwgo3gafQib73WBzk=;
 b=jjHyQ3jHfla5FN30cYqd/aPWO7bHyDQSUh30x+BddIxIucqDw7YdZwZjW9iryN6dLi
 oHridausHZFVbBAvxCEtd/CCrMuQKlqXfqdTA63coikZeefRWUz/Irp1f5N+WEl1tWxZ
 P7ozhvUuIWhMzPxBObs5geRrsbpW9Jx8SkOHO9nTNywKhY8l17rQNgixX/vTcFWE4d0x
 TX9UnBFLMeyhmyjmSowk8Vfy9UazF4yiZPEHTbKe8MOgCRt31VOUdyWboLUqhvcLWSZl
 7+pvScaOnKHWy4uqLEm4KPsQqAF+rbWVcZz6zHnmK4rzenfFuoCsahUkLYIEiRtWfRNY
 0sqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQYOdXk0B/X5SJt90xZig9UzGfxNBQeHa/gDMgktY57yTGnvYMpWwH7ndMPopLwYXpJB4DT4z75rM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIGyqsLFr1f+15sDwCtD36dQxlvUaSGKqnMy7ckSGGGvTvD1Eal
 QbhbfvHQveiPVr8w2yU66b6m6yakZKVQkBkoiHtj4i4GMOvjFv9oi/HbM9TRq30xItc=
X-Gm-Gg: AYBFou2eU+kw4i5ORfiCeaZS+HpGA4f8/pFfhGKCAjT0OuZRl3WM2Dgq1/xHtcFwE42
 W3zOncEwAs6aO2SseFXMUaVN/4SLmxbGX0mlEiC3uO6wo80rxk1NKjjoOoIxzaBZPx2s3nofd5J
 RQ+MDIrchSp61+EUBKz7VstEt85wgZ0Yft9w1jpXlyulWWD3F5i+6Yeko4TtSb7ZrxL6PqnHV5O
 PlBPVrIGq9/pchj6fclt2tgM3bwnvo50cUOermJRd9PqzFn/Yl+IlAWYvqTVUNFgV+NLZxNmGPT
 hQGQO7odJeMY4IiEcSam+al+inLFGBlMVjOhXmfjkvyCEtvnL7cCGHab5SDrQu4SNEHnz4italb
 6TrUQl/EeTWWsf1Wj3K76AQTqUlrStvmgKhYdghGJoYP/BMG3doM4ApSsthOlo+uKAWF4QJBakX
 L9/QGe+VF2bKCnyFlFBChYbutTqv1lsMV4lxGgzdTABAISrnVaqlusZksZxzb9qvZi3J0CjV6NU
 rln6OlPWZ88Yi0SYXXIeDUENXPA5GiMnJzmyR6hWcRfQvHo09a2fXhjmG0bTH5Vn30WxLDqxXAI
 8FJsXg==
X-Received: by 2002:a05:693c:65d1:b0:34a:e4f6:4a5e with SMTP id
 5a478bee46e88-34ae505937fmr2051657eec.24.1790651533232; 
 Mon, 28 Sep 2026 20:12:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-343580930e2sm22425259eec.16.2026.09.28.20.12.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:12:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Ensure array index tg_inst won't be -1
Date: Mon, 28 Sep 2026 23:12:06 -0400
Message-ID: <20260929031209.87164-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 687fe329f18ab0ab0496b20ed2cb003d4879d931 ]

[WHY & HOW]
tg_inst will be a negative if timing_generator_count equals 0, which
should be checked before used.

This fixes 2 OVERRUN issues reported by Coverity.

[ Backport to 6.6.y: mapped the newer pipe index and helper to i in the
  older acquire_first_free_pipe(). ]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-46730. It adds upstream's zero-count guard
before the fallback timing-generator index is computed.

The condition now avoids forming timing_generators[-1] if a zero-count pool
reaches this helper. I did not find a successfully constructed in-tree
resource pool with zero timing generators on this revision, so this is a
defensive match to the upstream check rather than a reproduced fault.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-46730
Upstream: 687fe329f18ab0ab0496b20ed2cb003d4879d931

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 84474d5122284a..1f576b2a1960fd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2354,7 +2354,8 @@ static int acquire_first_free_pipe(
 				pipe_ctx->plane_res.mpcc_inst = pool->dpps[i]->inst;
 			pipe_ctx->pipe_idx = i;
 
-			if (i >= pool->timing_generator_count) {
+			if (i >= pool->timing_generator_count &&
+			    pool->timing_generator_count != 0) {
 				int tg_inst = pool->timing_generator_count - 1;
 
 				pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-- 
2.39.5
