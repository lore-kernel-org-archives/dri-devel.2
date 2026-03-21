Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9175C1093170
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D676010EB69;
	Sat, 21 Mar 2026 05:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gAHnRJtW";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7445010EB65
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 05:20:47 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso16915075e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774070446; x=1774675246; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1EKq1vLfgwYt/zYwN9FJYIigJVZ+pwHlskrnj75NFik=;
 b=gAHnRJtWNrYe0Xrl7F6d2/AW8wL9XnNcAhacRQtyTJfCaGvP2MbiXW8SSqhxAC8n3N
 +krqQYLC61OW6iEBLIoXPyyy0krW2rGK9zL4wJjwaANl4wnQ9B/1rzQWt6uZd7G/eWlN
 G52Apaxu1oCiZ5PpTQYWcNANPp3qIroSzVlbtQ6fbSwUieybtY2DyyLwLTl93G9E5FAe
 en2lapb6e8MiVo4BOXXqoBodAmdoZiA539Uemt3TPyNkZzF37thokpbvzT3p51q7uxX5
 PdHlHNeOuW/ZgLZLJOUt1l/cvg7+Zab0+1inTZYcerFKgm0/dyXaGo4sxU/cyGWxbb1+
 Kfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774070446; x=1774675246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EKq1vLfgwYt/zYwN9FJYIigJVZ+pwHlskrnj75NFik=;
 b=oqPvzOJ7dg9z/ZT4fuKTqlhNHF9sjzOaxLoC8boQ9cCOEdNB9fN5iREYMV0tJetQtr
 PXadps3SzVVDaevZtAbAXpNkW+qD82iplYo6cnS5gVeEt+q2PNabwdTsgi73355S9yDr
 udS4F+VgwdlQq7VDIhCvfm18bSAlP0OexQTjaB8iirQFT5oVU6T/DBXxFAgGA5BRbINF
 /gEgbBm3QvwI5+D+tAUNiqI5yjO0dtKH7TQNaPu6OkTnxPU8uxQWP7KJTtPbmQaTgD3z
 S0fMW2s0Q+8ac9xZuJZvCDfxZW8mubAtfzW11B8CYz6abEwgEG6qx07voaRN5d4frrJq
 UxyA==
X-Gm-Message-State: AOJu0YyqhKuGTqBEvhEvSJfh/uk0yNpB+0pr0gIYbVoyGi1gjUJba+/6
 qCx2DaqHAbKFUF9pzwZE7wr+Jco3ohOQIwEhVyjiGs5xPWMMWpxGS6p/
X-Gm-Gg: ATEYQzwm9fqi9cBy4UP54mEoXlL9r1IEsmr+olX03ji5uostyWDLn3AF6Ttq4q+z9Mu
 LZmWa6b9OkSHr1V7Xo4xwUtwGiY78uPyU3sp9Ea19M8IQIVB/5UFqsS/a4vFceGpEzjlA6m86Cx
 ehaEifL0zXc2DO/ynPFwWWTYFFR76muJVq3dTK/V0TEQYdDLa1j3O7x5PWrk8CA0jbd+hb/fNKm
 elOrWTfZsWmzk+1dhVFtJ+sLjS85kxUX2G1AoOME9nPOFOZIJdYCVxN0ilOZV1Lh4WhGmUi/ID8
 grAojMKd09rltnyOp7cdYd4X6dKTZ+YllImribtCQpQfGjE25zx2tnH9rNXObBDr28tRAJCX821
 jXx4aJbQuvvX5wwta++cZ5pqi8ZuxVNyoPrLu6rQBABVoCWSw1sHFqCkIOAtmnIXvWnqS0B11j5
 AsYgozGW40OoVzt5vKYDgb6rNFTaVxr8PQ8D57N/ob39o9Pf8fvbBBn7a2O4UiGlXQ1Pcbnwdol
 BuoOBtcvQ0exo9K+IHmwjMXKvah1rmBjpnvRCUVfb0RWSUlsuUO9oHmcFcOYJdt9LKx
X-Received: by 2002:a05:600c:3b07:b0:485:5ba3:37d8 with SMTP id
 5b1f17b1804b1-486fedab1e5mr73958065e9.5.1774070445643; 
 Fri, 20 Mar 2026 22:20:45 -0700 (PDT)
Received: from groovy.localdomain
 (dynamic-2a02-3100-5a1e-5a00-2fe0-b647-7443-5e95.310.pool.telefonica.de.
 [2a02:3100:5a1e:5a00:2fe0:b647:7443:5e95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe032a55sm208361275e9.7.2026.03.20.22.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 22:20:45 -0700 (PDT)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, mario.kleiner.de@gmail.com,
 stable@vger.kernel.org, Aric Cyr <aric.cyr@amd.com>,
 Anthony Koo <anthony.koo@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Change dither policy for 10 bpc output back
 to dithering
Date: Sat, 21 Mar 2026 06:20:33 +0100
Message-ID: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
round") degraded display of 12 bpc color precision output to 10 bpc sinks
by switching 10 bpc output from dithering to "truncate to 10 bpc".

I don't find the argumentation in that commit convincing, but the
consequences highly unfortunate, especially for applications that
require effective > 10 bpc precision output of > 10 bpc framebuffers.

The argument wasn't something strong like "there are hardware design
defects or limitations which require us to work around broken dithering
to 10 bpc", or "there are some special use cases which do require
truncation to 10 bpc", but essentially "at some point in the past we
used truncation in Polaris/Vega times and it looks like it got
inadvertently changed for Navi, so let's do that again". I couldn't find
evidence for that in the git commit logs for this. The commit message also
acknowledges that using dithering "...makes some sense for FP16...
...but not for ARGB2101010 surfaces..."

The problem with this is that it makes fp16 surfaces, and especially
rgba16 fixed point surfaces, less useful. These are now well
supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayland,
and they used to provide more than 10 bpc effective precision at the
output.

Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer,
e.g., gamma tables, CTM, can be used for color correction and will
benefit from an effective > 10 bpc output precision via dithering,
retaining some precision that would get lost on the way through the
pipeline, e.g., due to non-linear gamma functions.

Scientific apps rely on this for > 10 bpc display precision. Truncating
to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
down to 10 bpc, causes a serious loss of precision. This also creates the
undesirable and slightly absurd situation that using a cheap monitor
with only 8 bpc input and display panel will yield roughly 12 bpc
precision via dithering from 12 -> 8 bpc, whereas investment into a
more expensive monitor with 10 bpc input and native 10 bpc display will
only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properly
set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc out
precision) would allow effective 12 bpc precision output.

Therefore this patch proposes reverting that commit and going back to
dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bpc
output.

Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with
a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer and
measuring resulting color precision with a photometer. No apparent visual
artifacts or problems were observed, and effective precision was measured
to be 12 bpc again, as expected.

Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to round")
Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: stable@vger.kernel.org
Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Anthony Koo <anthony.koo@amd.com>
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c9fbb64d706a..29db5404c4a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 			option = DITHER_OPTION_SPATIAL8;
 			break;
 		case COLOR_DEPTH_101010:
-			option = DITHER_OPTION_TRUN10;
+			option = DITHER_OPTION_SPATIAL10;
 			break;
 		default:
 			option = DITHER_OPTION_DISABLE;
-- 
2.43.0

