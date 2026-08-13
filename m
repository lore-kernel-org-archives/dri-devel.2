Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E93CC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D7010F1A4;
	Fri, 14 Aug 2026 07:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSUOzEXG";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87ED10F2D2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:27:03 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso2757041b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786620423; x=1787225223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NRGBrMNvLSobAjKhMm1lIf6g/DD55p77HOff+VMHwOw=;
 b=GSUOzEXGHDGDfqUpCxTuhdKXfDDk6MkZ/vdPpeymS5eSH5IoD7P7SdTE75aaDqawzl
 qlW+rU9UUmKSNS0Uj+/mcL2uxaeJV/MiEHt0Y4ZGaVj43pIM0MmkOzwxykcdXRnIUv0z
 HHXTukLxlx6gTNGRk/rxqTpEHAtouDfUiUW/IvcivK6eC88USirKXAJU1anaaQQNEFYt
 dMrJuP2mhYlVpPJZjd/waidX6+osQMVDNDHmYJ56MaEtrQm04ZvEMCvQVFqW3Pb9+KKz
 BLFc6re6qHsWf+BxUQcEG/v8y3wTVwvYgqo/0rV+eD2VUH/yy2S4Z7D9DrIzS5JWELvY
 bymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786620423; x=1787225223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NRGBrMNvLSobAjKhMm1lIf6g/DD55p77HOff+VMHwOw=;
 b=np2QoOCQ9J/OLIufNltNiI0rCcA+g25jtS1eL4WvhMDZThtTsHdzr/pXMjNm1+tuUK
 32eFgAGM6kcY8hid8cgZHrAuOj2n38To35DyuPmOYd6tHsjkWJTay9Lh98DQX2dQnPEe
 kq1stPQxKlKslaoOWGKfTiwRYCFc3MQ9YsP4FToiYNrhtkUVHP2tDNMUcNtcHGAVKi7B
 W5W5dhfsE257aEgNBaZ02eQWAIHKH6FRxuW8f5tzyaWwxTuwWf1J3O9JH7Xy2tYarYX0
 j0uOMSpwFJC3y83SBDfvqgHi9yLS3ewe+X0NAi2uJSRReguW5dVrTS7MW8VEdac3zwOh
 f4JA==
X-Gm-Message-State: AOJu0Yztfvmh/gtI12x7l/4QD86msdCMFxgDGENMa+ai15z+2o0zk+ye
 AZvvd9oojnL/yIlrCo3+NmcTDCgV11vJ8gHgepPwSBJhy2T3JRI7jU8v
X-Gm-Gg: AR+sD10tXTnVMhnigGA+TiiO8DT+xAcz31a4XadnaQ4MHAO5MoqyaLMhwLA/PXh4/35
 gKRdzwjZ0n+x7tM7GNfpKXiIwSJd4G5vxlfzR9eSyt296MJME3g7CHwpFK+w9Tmgl56RJnIgTVd
 yIsfNoSDbz2YYkkmJd5jVW63DrsQyGhS3oyPd4dSey3gNuz05lmH1AkXv5j+LNT3xvk3f4dl/zW
 qVK2pnZMGOUB6kM7gBHqK8qcBi2aBwZraXXm6P2dzWKuRU9SvIvm7tAA2hOSmq8e08nDNHf6+ll
 X1XNrl4U5LeJj/dWI494ZnSB9+jlDmJczLg+yS8IX1sCRJ8awE2hl4vWNLWPk2U0ny9kTlDI02J
 JhZSZ9xf4j8YyFmCY8BwnTc5BPnIm0GdAdA1k5l300fr9Ozg+rv3LDTD2r+Nrc22uQuO0LZj+tq
 BSVUd1qqACGx6QMtH2Iw1KUiWeVuvBGUC1/jp9CMrcXR2M5RRU1jlA3yZflR9PjEqyVYN1hHpUq
 hynN9zQacz0MvJvGa4DXwAe
X-Received: by 2002:a05:6a00:2999:b0:848:788a:e7f9 with SMTP id
 d2e1a72fcca58-84fc6dc62cbmr5033736b3a.18.1786620422989; 
 Thu, 13 Aug 2026 04:27:02 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6a59d80sm894282a12.11.2026.08.13.04.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:27:02 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, David Weber <weber.aulendorf@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: Skip connector updates without a stream
Date: Thu, 13 Aug 2026 13:26:33 +0200
Message-ID: <20260813112634.11455-2-weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813112634.11455-1-weber.aulendorf@gmail.com>
References: <20260813112634.11455-1-weber.aulendorf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

Atomic DPMS can leave a connector assigned to an enabled but inactive
CRTC after the driver has removed its DC stream. A later atomic commit
can then change HDR_OUTPUT_METADATA or Broadcast RGB while leaving the
CRTC mode, routing and active state unchanged.

That property-only commit does not require a modeset, so it reaches the
connector stream-update path with a NULL stream. An HDR metadata change
passes the update bailout and reaches dc_stream_get_status(NULL), while
a Broadcast RGB change dereferences the stream earlier when comparing
its output color space.

Skip stream updates until a stream exists. The connector state remains
stored, and an enabling modeset applies it to the newly created stream.

The crash was reproduced on a Phoenix1 system with DCN 3.1.4 and Linux
7.2-rc5 using a one-shot AI-generated DRM atomic reproducer:

https://pastebin.com/KxT1BcSs

The reproducer first sets HDR_OUTPUT_METADATA on an active CRTC, then
sets CRTC ACTIVE=0 to remove the DC stream while keeping the connector
routed to the CRTC, and finally changes HDR_OUTPUT_METADATA from one
non-NULL blob to another. The last commit does not require a modeset and
reached dc_stream_get_status(NULL) from amdgpu_dm_atomic_commit_tail().
The same sequence completed without crashing with this fix applied.

Fixes: b232d4ed92ea ("drm/amd/display: Only force modesets when toggling HDR")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1820547b1dde..13101a6be437 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11519,6 +11519,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+		/* DPMS-off leaves the connector routed to a streamless CRTC. */
+		if (!dm_new_crtc_state->stream)
+			continue;
 
 		scaling_changed = is_scaling_state_different(dm_new_con_state,
 							     dm_old_con_state);
-- 
2.54.0

