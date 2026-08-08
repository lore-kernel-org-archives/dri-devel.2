Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003C0C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A413D10E640;
	Mon, 10 Aug 2026 06:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMl/dngS";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E529010E521
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 17:13:31 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8ff88549786so5048376d6.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786209211; x=1786814011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1zSCFYsJi/YGsDjjzu9hgHmFBCe9GvVmfnZf9x92NT8=;
 b=MMl/dngSCfTORLG1fEzP8Wf49i4LFh2EE7U+SjG2JeWtObI5nm+vtwRurCPwXahEV8
 z7ka4xaZbNRvLo+EXLpXBp4KL5dWUdP9rRm9zQ2aQF/5Kb00HOpeizWFXEAGBweUEn0y
 ZWRRdfi/e1dY8RZVlv7EfIYI1XVUU42fHt1OoVLcYz1Qmk33k+s+Cfpuns0QaRFz9TId
 UPkmDVNFnwcp90/9XSbzFzn4xH/QbaYqC/bFLVar1YXN9EMJHQ18NYlqhLQDjhBfl7X9
 rEvWF2v4E2Sgjt1IrkBqpg42Yx398uv3a2KjIXtUToXmTL4SlhN6NbmO8cdP7ybJ68Hc
 IeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209211; x=1786814011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1zSCFYsJi/YGsDjjzu9hgHmFBCe9GvVmfnZf9x92NT8=;
 b=bVXsax50uCfCOGwt3c90IlqaCk2xDsIkH2ymuIrnz9YVe5gQ+rrdWJ4bhkM+UWoBTq
 0kQg7d+nDpNRb/GvL5jqa3OlXStnbz7PK6jfwDoz7lW11K3qHR8Q11RqsxfntFrKouk+
 ep9v6RyONmHZCXsW9f2+21Yok5hZ+yTuTccjiPMGO5bf/8cHPJeEb04J/ao1Ru7OMsNQ
 ZllE1CtbJnVHQVBR2Z77KZtWkDuca7MPmOBc2tiObqEvXciPTQWVEh3wsmksM/upA4uD
 VSXHeMO20B67TlXrvK/o/qYcKBCuH5AR4ssyVYfDjPY8Fam+ddrLx46GbGiq0ocWY5Ya
 xbhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOydjoY41s1gi+AZ1OKt6PAZ2bEoNhe/BqF7Cf08v5oz4LcIIOIgrZz7ojFXlRjQL2+gQVF02tMuA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoGyhKJx4oIUGCrcFNX1blcu2GAVi1fRB0wUAC+rV5C8M/M6b8
 HbJmrdLjtG0dN5cFpCCQzH90UbyYElblZ6GQoqfHu/HvgzqIGb/1SIWsjaB94UeDcx59mw==
X-Gm-Gg: AR+sD10k1QJFDAjdSAJXlkG8Nq7t+u+B14Dg37VSGQjQzstsG3JObx++LAA5eN3qYKh
 Db8NATP6YtueExbcNuF7gbAIaMKpNO/eQsLu+h3YmlygzZPGYlwrdb/+vf16pE8T3gu/xig0U+y
 7C20lLyvI9+Oqc1CrHKUDXOsDGfTlR5lfoc3CyjHGGvdlWen4f8EzlOu8wOhaaSRx6avTvefwHP
 2kZi9NbbFoMO/RROQoqfL3tkPEDGlAgDz27XyJbJEREWb3qiTC64x7AugmLOxRyd4QBWdQaWcEC
 y/dVZHBA2tMwiReKS6/ZS2fYdsvRbgTrfj2ys7XytsOo7pkUls0NUP+QrrdTqxGoBWa9AXo0xYN
 xZadti541XknsaSPkXxulCRwsN/7/BbLKAhpT7KirXWviFSQW4/cu1vsFVosh2g7EmeZE1/B/Uj
 EUVpVPSB3ADaP88y1JG46pdIiLJXEtLQmkJcbfLhnlGLXCTGVy/3MV2s0ilxXAOtaFaVQu+CoJG
 viOXR97EvavKmVh6S454GIpXhqDgmUrwmcM0gmrRGIhdlV/oSrB031okaRRGiyZGrZ1JrEs4w==
X-Received: by 2002:ad4:5ca9:0:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-908813d33e8mr359375546d6.32.1786209210858; 
 Sat, 08 Aug 2026 10:13:30 -0700 (PDT)
Received: from JesseofTheNorth.internal ([2600:4041:502b:ea00::1408])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a93258cbsm34265286d6.33.2026.08.08.10.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 10:13:29 -0700 (PDT)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: skip PUSH_IDLE when the link was never enabled
Date: Sat,  8 Aug 2026 13:13:25 -0400
Message-ID: <20260808171325.133041-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

msm_dp_display_atomic_enable() returns early when link training fails,
leaving ->power_on false and the main link down.
msm_dp_display_atomic_disable() nevertheless writes DP_STATE_CTRL_PUSH_IDLE
and waits for an idle-pattern completion that cannot arrive, so every failed
enable is followed by "PUSH_IDLE pattern timedout".

Every other step of the teardown is already gated on that flag:
msm_dp_display_disable(), called from .atomic_post_disable(), returns early
on !power_on. The PUSH_IDLE write is the only one that is not, so the
controller's runtime-PM reference is then dropped without the link having
been taken down.

On glymur (Snapdragon X2 Elite) the consequence is not a warning. The SoC
does not survive it: TrustZone force-stops the SOCCP and ADSP remote
processors and the machine resets silently about 50 ms later, with no oops
and no panic. On an ASUS Zenbook A16 (UX3607OA), whose eDP panel does not
currently train, this reproduces without any compositor or GPU involvement:

  # eDP enable has already failed with "Failed link training (rc=-104)"
  echo 1 > /sys/class/graphics/fb0/blank

  [535.645455] === marker ===
  [535.694833] qcom_q6v5_pas d00000.remoteproc: fatal error received: \
                 sys_m_smsm.c:512:TZ force stop
  [535.694875] remoteproc remoteproc0: crash detected in soccp: type fatal error
  [535.728857] qcom_q6v5_pas 6800000.remoteproc: fatal error received: \
                 sys_m_smsm.c:783:err fatal notification received from TZ
  <SoC reset>

Gate the PUSH_IDLE write on ->power_on so the disable path is consistent
with the rest of the teardown. With this applied the same sequence is
harmless and the machine stays up; without it, it resets every time.

The unconditional write dates back to the original DP driver
(c943b4948b58 ("drm/msm/dp: add displayPort driver support")), but the
surrounding code has been restructured several times since, so no Fixes:
tag is offered.

Note that the eDP link-training failure that exposes this on the A16 is a
separate problem in the glymur eDP PHY and is reported separately; this
change is about not damaging the machine when training fails, for whatever
reason.

Tested on ASUS Zenbook A16 (UX3607OA), Snapdragon X2 Elite Extreme, on
linux-next next-20260803 and next-20260807. The machine has since been
running next-20260807 with this patch as its daily driver.

Assisted-by: Anthropic:Claude-Opus-5
Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172..5d2ddf180 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1458,6 +1458,20 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)

 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);

+	/*
+	 * If .atomic_enable() bailed out - link training failure is the common
+	 * case - the mainlink was never brought up and ->power_on stayed false.
+	 * Driving the PUSH_IDLE pattern into a controller that was never
+	 * enabled times out, and .atomic_post_disable() then drops the
+	 * controller's runtime-PM reference without tearing the PHY back down,
+	 * because msm_dp_display_disable() returns early on !power_on.  On
+	 * glymur (Snapdragon X2 Elite) that combination is answered by a
+	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
+	 * There is nothing to push idle, so leave it alone.
+	 */
+	if (!dp->power_on)
+		return;
+
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
 }

--
2.55.0
