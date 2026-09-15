Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D47BC88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492AA10E22D;
	Tue, 15 Sep 2026 02:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aMvznSet";
	dkim-atps=neutral
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3149A10E22D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:27:51 +0000 (UTC)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a2ff16c0e6so21977141fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 19:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789439269; cv=none;
 d=google.com; s=arc-20260327;
 b=ZOIszF10FqF1VXY6+iAMzQmvU4sNQNu+9UyFXxIb/n+iD4n5LIq2wpFDY1FBEY+GHE
 GXJGnQG1slKvmuYQBMpzKOI9oqHC64G3ZcEEm1yybo0r1C75Kt5Vc1WFu/OX/opulXl5
 xEdYhCQzPHFEbytEaNgU9bLbWfiPBzndpp8zxOqXRYxc6rjw1oDQg3Mr8bavuU6HKPM1
 1kVVIhW9q3v2VG/88kinxCMIdlImyqmYnXL2sQnZVR/k4w3zcLvXZszLlTnL87m4h1Yh
 33drPTcvalJjvovja0iSYlFz5zNTtlS6CHry6SIojnaKRhtDvinCw9CT4O/boTSwx4mq
 fEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J15/iUq4hwNLgoAFGv+hkuhgPnyH2Vrei6Sk5/otKgo=;
 fh=xnE57VS0CJF1X7XeJDIb+Dm2/1pEw2cL+LDFISQTG2Y=;
 b=rjJouPdcuJ6m/kEKUHJDLa2Oci20eE0HSMpa4VXVzwQv6QEnRp/ZNTHECgBa9J2h5s
 KGiLzdHg9BW9E9xKpNkrbGcKFokTrHpNPJe6ZDrLDorVb5l5E3Ilp50QdrawlN56GnkG
 AtzktjlnYvh5JvtMFPKSYKcXUZZ3WZV332BWSSzTatgwhjMMEwg/Ewqt0aZQ9zg3dT+q
 kQihlyK+9IWxiuDDyxtJHHlUjDuKVXDxPZq15YNEHzO8k0MA3BN13mRS2Y+KrGccMtFf
 8kSlpz1IPzYLU9rlzCQIfKMEvP+KJrsmRFA0ePPD7eAQol9VaNaXt04CUMUUN/j021cD
 fMtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789439269; x=1790044069; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J15/iUq4hwNLgoAFGv+hkuhgPnyH2Vrei6Sk5/otKgo=;
 b=aMvznSetAlW9NyP7S2D+/Y6LPFX3l+8XSjqJoIgJQukFVEIj4VQBk2ouoWv/HtVX7j
 EDYm2P9I3MtLFsCNAFJhxwyvC5qYL5u5fGOi2739M/3SWnZoFgByabk17uOKB9goWH3r
 Q41gH9M8wyfyY73P0jj1/XWB7Nxe1lftixuNsjwBs0Jq/4+N17FGzIohousgr/fkNmjs
 TubaqRrPUTh/iFEe4cu2wdM7yax+48FIp477hvV35X22WGl/EXMHPzasV7Xidg4jfDj0
 yjbPe84sHWdgbF4sC4sZBC6+fjiPO7Po2pwCjwDwG7Hh1sSKDHF9u0yEdxKW7PgAPqho
 RQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789439269; x=1790044069;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J15/iUq4hwNLgoAFGv+hkuhgPnyH2Vrei6Sk5/otKgo=;
 b=11zTz++rAU5cURjFwqhKYwaohcyXbcpgsGQIFWhqfTehF9YS4BBMWKBw5GsgQNvbN1
 4FWWJH54xpeOjK6ooaZjgALhh66CPb4DFmKO6FIo3gRY7iTbQKQg10K+VSHeiZbpDfLU
 8il7vIhb+ABaPVxWtkGntwa/0oOjNLSLrMXIo2xCsTU5/VNnJJtH6M1Xo7zSnlGNea2U
 VjHQR3clI5peK/GEJizSq46UG6Rgn5pLNR2s9LyQP1zs+Q9M7z4hhgQky+OZ0kM5Q4g4
 aEL+ie5+N0a+Cv1HBiYTjZH43BNWWgX8YaCIMpJeH2ieGuUjhaRNNwfEn1eYvObp1AbB
 Yd9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1GRBqzTAd5gQUSdiVsVIPia/q5vMf+WYAqPFF0Vq8ymCTYV/C60Oqn2mg8+GmmvhIFReri0R6eGY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0xvr+QAHLxgBheGs2iUuMHpo7oNzDU+vDwtti0lcDpi93ef8B
 cNyPeE/FnKXbA98xV1ZY+77tVHWWITGbnu/5AYeDbxmmSFvCjkNQXEV+vlawWtbp/2p8GBAfkvU
 Fg0JJ33VKsLODKkwDBS4tSSRopOwL9is=
X-Gm-Gg: AYBFou2xKo6V+zg0Ho7gVoH2AE2qYNYRcv88HkNyZyQimros/4wxuxO1gVmmjBKmvqd
 PKMhaiNg40Pe/b4IiVtaWx84AtCQOUz8VEf5D2uYtuzXPOqNDCH84kDx4cqEY67kglO1haitK4N
 eZHSm9enyrhseOfshW82Ry6Cp1Zda35Iqa0PvBat9MchehNOuyfhdQma/qeCWWVEuO7TB+Axz5v
 SSvzH403i1oWMwGo+MgW673ZE+3T2jexkRh6k8BYOJBCGzuWY+N6koS4hWbEKmsSzhKkweVquZs
 Lp/n7tw83M75Se/GCHENtn3x+rA68dv0Qmyp9YLsWYP1ikrS1vk0yHg4rBnqV8tSmyDI4ViKPqb
 4pT7CcwKovp48WjSxsUMyTw==
X-Received: by 2002:a05:651c:552:b0:3a3:74b7:fc0e with SMTP id
 38308e7fff4ca-3a5c899c408mr7848431fa.26.1789439268807; Mon, 14 Sep 2026
 19:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJxfpZ+AzJnBCw-jP5_E8FH_+cpCE68FCtf_tsi9pt7q=P2Dsw@mail.gmail.com>
 <20195022-cf18-45cd-829e-b2866e7a3080@amd.com>
In-Reply-To: <20195022-cf18-45cd-829e-b2866e7a3080@amd.com>
From: Dan Himebauch <danielhimebauch@gmail.com>
Date: Mon, 14 Sep 2026 22:27:35 -0400
X-Gm-Features: AcwNN1Ugx9kcCV2VjGKc2mgeTlJvZfaWap9VfMR_r6vEKfUTuZChjFWCy53hf9g
Message-ID: <CAJxfpZJDvFuz40a-euL0jRkPBR82M8Y5NxBrpABeP+EZScFxGw@mail.gmail.com>
Subject: [PATCH v2] drm/amd/display: invalidate DP CEC state on s3 suspend
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, bhawanpreet.lakha@amd.com, 
 wayne.lin@amd.com, george.zhang@amd.com, jerry.zuo@amd.com, 
 chen-yu.chen@amd.com, ivan.lipski@amd.com, evg28bur@yandex.ru, 
 Kun.Liu2@amd.com, mario.limonciello@amd.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Amended and added issue link, thanks!

From 2916fc883b80cf106ba2b06d8dadbdae45eff7db Mon Sep 17 00:00:00 2001
From: Daniel Kurt Himebauch <danielhimebauch@gmail.com>
Date: Fri, 11 Sep 2026 21:11:10 -0400
Subject: [PATCH v2] drm/amd/display: invalidate DP CEC state on s3 suspend

Some Linux HTPCs with discrete GPUs use active DisplayPort-to-HDMI
adapters to carry CEC over DP AUX. This provides a CEC path on systems
where the GPU does not expose native HDMI CEC.

During S3 suspend, amdgpu invalidates native HDMI CEC state but leaves
the DP AUX CEC physical address valid. The adapter can retain stale CEC
state across suspend, causing transmissions during resume to fail before
the adapter is reconfigured.

For AUX-mode connectors, invalidate the DP AUX CEC physical address
during suspend. Normal connector detection on resume then reattaches the
adapter using the EDID-derived physical address.

Tested on a Radeon RX 9070 XT HTPC running SteamOS with a UGREEN
DP-to-HDMI adapter on amd-staging-drm-next at commit d8ab7636160e
("drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12").
The unmodified tree reproduced resume NACKs. With this change, multiple
cycles showed Image View On and Active Source transmissions.

Link: https://gitlab.steamos.cloud/holo/linux-cec/-/issues/5
Assisted-by: Codex:GPT-5.6-Luna
Signed-off-by: Daniel Kurt Himebauch <danielhimebauch@gmail.com>

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
