Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D10C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9E310EA0F;
	Sun, 13 Sep 2026 20:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDnVStjn";
	dkim-atps=neutral
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3D510F73C
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 02:30:40 +0000 (UTC)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a49a10ee5aso1217131fa.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789180238; cv=none;
 d=google.com; s=arc-20260327;
 b=hPWnc4ikDcBV1rvNtT8rtGUM4NwnSTk3NZyA9Z2XO99Q+JbcqQGT21otgCdKNFxx5h
 zb1OjVBJCllc2bb5wjS1sYxchoyHPcU2p+W46BRhRLBlK/AG6WQ57LklO5qhsW/O1V8y
 VH7lxN3J7voAt7QR24KMTWfb20g/fyLJpbJn877AHzogwASbsANwfS7oLrh7LVA5Wulv
 tYRYxqnOCXF0z5Y58zE5Sxm8dL+n7ZctqaNjWKkZlS4sh/Wt10RPIIJoYho6/5ggNieG
 fNJL64Qtx1NWZ8GXvjvgxdW+Ki4355mE/JFrQo33OsQIIy3vfWdOMWS+4vbvjFVLuFin
 5iFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=LhlEYDWQpemuIMnWvpMSCy+QwKP38TCR3oYFVMnKb9A=;
 fh=b60aZ9xCaXKydTNF7kk7DCFd8YRFSlYgMAWiuApPLtY=;
 b=c0tb7VP0RyEs3vG6rgIwrrOPyUjgbd/3vvIqaxaOtfgP12oJF4MGrGFtk8qrjyS1r+
 dqs3bXrepvKSX/fBJhC9zg/PBYjSPfTOMb3mQrdRB5QE+/BNqGj9H6Jpfwm4JmhhnT2G
 JuMmGQErUcLhNIaE13HHS+kxXDKuuKGF6phhjoGYjWhEuX0MsUGH1Giyxxti139xZqOu
 cG1bsYr7apnpfWpY36pJJ7jkgsU3RQKMtLs4d9AczOL/M90qISL71+7/LqnMD2+bfyGE
 OPle2DvuutCxfvRuKKNt5yCaJ3RdjwJNX9FWWIfMSsDoLS12ElGJnVjrRa+M+1M80CuZ
 kN0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789180238; x=1789785038; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LhlEYDWQpemuIMnWvpMSCy+QwKP38TCR3oYFVMnKb9A=;
 b=nDnVStjng/rUn32PabZkEJhl5ZypfdBZXAeb2uTUvZWP6cxIXMQictZwtQTFST0uFn
 lDN9UnPHr/nT6xaHOZ0Nu7rxcUF8t+PAcD7IqKgT/c4RKIsH1GBH7Fib9q6P9/4P3CAY
 aHBbrTrbAZg0WxsN9UavFWDbwfhHb/+tA9Ga8Y5OxQijtMadohlRFknt6buvIHI+noqP
 OphznEND91DANZ9JAxrb+DWtdXEkwpDORPLuUprVXJnBL8wncn77eT9iHvH/XD9xASup
 XKvadfUOS4yIqZD832o45lDwcPYWkWJdMV3NXOGwlECWTJU31eqekQbC5+4ChihfUdH1
 ur/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789180238; x=1789785038;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LhlEYDWQpemuIMnWvpMSCy+QwKP38TCR3oYFVMnKb9A=;
 b=VyPYCqps7fjvt2ZhdJjX6Vhrl4x39XYvrztOQR7F09Pf4+BCZpzYo4uAeW55mfqr1F
 +NZ6UTjJjkv7gpGtqm4gvHf3dbDtmiGhcYkEpq+s8CNSmu6om8oBeGipO0npnmqbitfP
 brehYWnNZC0JJ6ijFIXVgvEgiETfg3qKQgpXYLn+At1ztdpI5z0L+Rn7+RQrAf3J+oAi
 TeZ9FSQ+SfVwMHSFREvXUxUqnXPXZnMXXN4/ucvhiYGe20UOLMlWA8gdwDBZ5Hs6RD9n
 vp7Jce0pfBLN6llD+6jecOImWbGrQCb9uguJzkJPQLqqDENbnpO2yZy1Gh4OX/ohTfXX
 fl2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCLzZ56viVk68LXbNdtGewp2s5nLiz10jggGS/Hp69vPk0Sns2GpuYOxv6IhV2ra8vp+7Y0dHpJkw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKcKHr9QfcIZUvEHY/IGu8urBNsez3EDA6+40Pk9JWeMQO1Ee+
 3GeMCdjapQ/6UccHuwqrPPpDhtV+/ESclo8Xzy5jtROngMtjTAX3RcOqvasPzY/2f0hrmmFGOE9
 oNwKuo0GtIZLJBZF/+wOn6b9AO3oJv4Q=
X-Gm-Gg: AYBFou3yvni+b/KI49kltl51/RWJLAGzdD4D3CL69SBcNwmgtJy9PWqA14xzMrXaOof
 wGnogFf6OCmKbVfztnReon+9zfbkaej435K5yMKFAOASP4tw1FwqvjJXhf/URTJdsbH/BSP4+VW
 i8ItQqmvaf35TK4lpQKBsRRllMKltAYyZg5Tux7yohMHaGLSvbLQb1Ol9oXhzniodxsm5TSG5kc
 PFA1o8qKq0mgL2dVXMVxAu8CqomEC5pd+YOWLZ7j+mVrhZxr+yH3rtrIync9MjQKF81/EMNHEW8
 4sqF5N60Ku5M3WsdDX0RNO4k1xjmNbkdSlLZ3+w1XHH9b4DfTyTx7ak=
X-Received: by 2002:a05:651c:b25:b0:3a3:7681:6d67 with SMTP id
 38308e7fff4ca-3a5b37ef2f7mr1209821fa.16.1789180238192; Fri, 11 Sep 2026
 19:30:38 -0700 (PDT)
MIME-Version: 1.0
From: Dan Himebauch <danielhimebauch@gmail.com>
Date: Fri, 11 Sep 2026 22:30:26 -0400
X-Gm-Features: AcwNN1V963IeDUd-QUldO-pjWGCQZiXzrgoLRjiqt0-JerrHpoXg4IvNra2ffgs
Message-ID: <CAJxfpZ+AzJnBCw-jP5_E8FH_+cpCE68FCtf_tsi9pt7q=P2Dsw@mail.gmail.com>
Subject: [PATCH] drm/amd/display: invalidate DP CEC state on s3 suspend
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com, 
 wayne.lin@amd.com, george.zhang@amd.com, jerry.zuo@amd.com, 
 chen-yu.chen@amd.com, ivan.lipski@amd.com, evg28bur@yandex.ru, 
 Kun.Liu2@amd.com, mario.limonciello@amd.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

HTPC setups on Linux with discrete GPUs can opt to use an active DP to
HDMI adaptor in order to carry CEC over DP AUX, as most GPUs do not
wire up CEC pin 13.

Currently under s3 suspend, amdgpu invalidates native HDMI CEC state
but leaves DP AUX CEC physical address valid, which can leave these
adapter's CEC states stale across suspend and make wake transmissions
to fail before adapter is reconfigured.

This patch allows invalidating the DP AUX CEC physical address during
suspend for AUX mode connectors. Normal connector detection reattaches
adaptor using the physical address from EDID.

Tested on a 9070xt HTPC on steamOS and UGREEN DP to HDMI adapter on
amd-staging-drm-next at d8ab7636160e20bf6a2ad69cd975f4d63319f1d4 where
unmodified tree reproduced resume NACK, with this patch, multiple
cycles succeeded with ImageViewOn and ActiveSource transmission, and
intended behavior on wake was observed with cecd.

Assisted-by: LLM
Signed-off-by: xXJSONDeruloXx <danielhimebauch@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0b446133edd8..919394778a25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -372,10 +372,13 @@ void amdgpu_dm_s3_handle_hdmi_cec(struct
drm_device *ddev, bool suspend)
  continue;

  aconnector = to_amdgpu_dm_connector(connector);
- if (suspend)
+ if (suspend) {
  hdmi_cec_unset_edid(aconnector);
- else
+ if (aconnector->dc_link && aconnector->dc_link->aux_mode)
+ drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
+ } else {
  amdgpu_dm_hdmi_cec_set_edid(aconnector);
+ }
  }
  drm_connector_list_iter_end(&conn_iter);
 }
-- 
2.50.1 (Apple Git-155)
