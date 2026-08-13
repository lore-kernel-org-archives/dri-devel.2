Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8028EC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F7410EBC1;
	Fri, 14 Aug 2026 07:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ej4OyhJv";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41AFB10F2CF
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:27:06 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so507132a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786620426; x=1787225226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yedogQjnb5nGvW1U+3x4hYyDe/AHyo+j+5EWGorL0yk=;
 b=Ej4OyhJvYeaj+T9LwKMnU/vy1x3sQv/60qrf9arEGugORQzyFZE2us/UdBYo631K+6
 BzX6gc90hwsyMjVoYTufZHWOiVKmOpS//UdYMMsVglEQOrKy89hKbgt2/4YLchVqrJFs
 Jp4Uhiiw3NhcCODps+se/9h0gekvaJJYtj2RNJgKT9jIKhlBlUCQ4+G+X2hMPADruhO4
 RnqtCm+mUXlmlzRMoDSljI6eV39SgfxwClPDdF5yTbu9hibYxzf644JeM1aTtEN7OEZ6
 SWSNzQj2AkFFtAz2kj/b/EmgYXVZDNsB2CSGfOpnNheY94BDJDPSPbp0/CTBcBklsZ+q
 PZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786620426; x=1787225226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yedogQjnb5nGvW1U+3x4hYyDe/AHyo+j+5EWGorL0yk=;
 b=JUvpEGwsRQqhHQrCdxT0k8QzGvQasX2eFlr3OxXr6/xmhHyZvJot38rF+O9KBhn0F2
 jpVtZniIU3nq6nGVMX0PpltKeOKK4H3P9tmcetELzddJ93skS63ktUYIhFir8YkEDkjW
 F7W/Pi3G39EAoRwUOUEqQ0PER+huKe0Rruv6KgXog95knr03w6d2sYmKWcE7Q/OaZO2Q
 8cVaxq4kUdycFqV8kOZOFswfBq9Y6y6eZ5c+oUhuijYxKj8zJ0bzVFv2Y3nU3Pto/ZqI
 nbZTfz9/d89TlXe7FpX3kyhWgs3IU6hJOkQqVM3kJOvB95Bk5Eh+aZ3Wef1TmXN2sHk2
 gs5w==
X-Gm-Message-State: AOJu0YwzSontjXE5cXHcvBNZM+Ne8soVwFk7bNQPCOPSM6P05/CeeShM
 3vzJeJajy/cY5TYrWX5fpURHLJRqgZv++MW/2zKwZOZ4nrMzBLmBDDGU
X-Gm-Gg: AR+sD121JmdLHJbYOYqRp4EudQD42HjcwvupyjzwGkmgBIDnJAORclNlm9dclJDYy1W
 dqq9G5GrF9Di4l/HeM9DjrBGcK7P8ZKIxq+B5VH6H7nyEO4Cw0i+ZxnuSoHOkxkrRqvVIqaQFiq
 E9m9xqX1uylj9TzYK/WaOydleQ3H/lH23SQrfe+u688FSvoL+0iJiJL6OfSAloDROCKv9JOHnMd
 0P5ejCDgUH7iDv0P/DxLgMANGU/28kRZjsUqLFDZxZhevfl/MsN2rdqrQxjJGCMF7/er6U7DPx3
 g/xs+zTNBqNlgEqH47hqvz4qOMx/tqha5XD6VgX9ldbP4n7FnTZRgBwE23E1C713v0aqp/29l/s
 Gext3GYhpZjOcq2grq9hnYWgbaFmilxMusl5vKCVJlDBdNrnbYwQTl4C1OVpufMAjijNk2LcXsy
 hRG67+WEzvS2UihhGlAR/OBGAcR4gHzsrAgDZpA9DH6BACsZlB1G5SSKmikFB6RgBFVIpKJl0Ly
 rpFvl5x+xnI54mNthps2UhMqMqP5xbPhRI=
X-Received: by 2002:a05:6a20:3d1c:b0:3c3:791e:5e0c with SMTP id
 adf61e73a8af0-3cc5531808bmr6904887637.19.1786620425563; 
 Thu, 13 Aug 2026 04:27:05 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6a59d80sm894282a12.11.2026.08.13.04.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:27:05 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, David Weber <weber.aulendorf@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Avoid modeset for ABM changes
Date: Thu, 13 Aug 2026 13:26:34 +0200
Message-ID: <20260813112634.11455-3-weber.aulendorf@gmail.com>
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

ABM connector property changes currently set connectors_changed on the
associated CRTC. DRM treats that flag as requiring a modeset, so each
ABM change tears down and recreates the stream and visibly blanks the
panel.

drm_atomic_get_crtc_state() already adds the affected CRTC to the
atomic state. dm_update_crtc_state() then copies the connector ABM level
to the CRTC state, allowing the commit tail to program it with the
existing stream update path.

Stop marking the CRTC as connectors_changed for ABM changes. Continue
doing so for scaling changes.

This makes runtime ABM changes practical for desktop power management,
for example when switching between AC, battery and low-battery
profiles.

Tested on a Phoenix1 system with DCN 3.1.4 and an internal eDP panel.
Changing ABM through the panel_power_savings sysfs property was
confirmed visually and by measuring the resulting change in system
power consumption. It no longer caused the black-screen flicker from
the forced modeset.

Fixes: c5892a102182 ("drm/amd/display: Fix dmesg warning from setting abm level")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 13101a6be437..40099bff153a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13168,7 +13168,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 
-		/* Skip connectors that are disabled or part of modeset already. */
+		/* Skip connectors without a CRTC. */
 		if (!new_con_state->crtc)
 			continue;
 
@@ -13179,8 +13179,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
-		    dm_old_con_state->scaling != dm_new_con_state->scaling)
+		if (dm_old_con_state->scaling != dm_new_con_state->scaling)
 			new_crtc_state->connectors_changed = true;
 	}
 
-- 
2.54.0

