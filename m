Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84172CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 20:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D1B10E04F;
	Sun, 10 May 2026 20:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQRJATqA";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD8E10E04F
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 20:18:25 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8b5de17382cso26048516d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778444304; x=1779049104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K67pIs/nY03A+3XziFzgPYzBlsoSwWL+5glnFKhN0Ic=;
 b=jQRJATqA8wr0teKo+7fbOXl3PayPbEIMnpeJIjLkENjDeiSvGKI3/BGB60kF94Rs/q
 hXd3fKVSnmdkkRjaF13fJbCcoQ/YLhI5nUTY6LFhyuB34+sA6/Vw5PsC5VvUTWqTyKAV
 6bU+eE0nkR/+ptA/l20cWR5YUyFJQugoPTTXKbBbuNIEKOguFvYZa3KAAYG0R+v5CZJh
 mPM6oSnY/5eX6UIvYhoLiosF3ZAyK7mMINuidi4oNd49PpLMayprIVuAYbrnKmfeUx8m
 9wR4qARdxNeoRxmSh/EIJ5kI09dUtvshB/8gAoRy1LHGd7lJFHMDmS2aju92hmGlAGRD
 7uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778444304; x=1779049104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K67pIs/nY03A+3XziFzgPYzBlsoSwWL+5glnFKhN0Ic=;
 b=ig2JqpY9TJz31/bRLI4RT5kOJkVwnn2i+eb+PUMNWmbesaXHMueuWuCmrqpCPtRcFd
 d3QaeXX02pHNhStlGjP0zAxHC8V+4OQQ5vuvhZmpgc/P05BKn/q/g+3nFK06vn4Y24ia
 qwQ0t4vCFRIhtTz5Lz3nHoJ9f2GFqv9kThr3s6a1Tase6opMB87SJcqS0M7DhJSzqXaR
 3Sm77AHXz3TFqNhsnBWQO56JONVeOZnD4adHqUwuKVpOlCfPlzDGQYfGmuOE1A79kV1q
 MTNKFwiWDLvNi4LKoYUixwWyAB8lVXXfk8lQZ7v0s0iWa7TQN+sbT/u4Eg7ZOSKG/zcx
 ybhA==
X-Gm-Message-State: AOJu0Ywd7pI5/wg8PeqoW7CDO8qXxSYPzJ51qaqRhX/6yCmI402fZn0o
 r8QcNhmkEe72ePacjnezCcb7GLWXGnXDoyUo2Pnodfavq2KpQ5lt4ES48LiUAo9cWjTV6A==
X-Gm-Gg: Acq92OGURVmX3vXMQs0A9jApOBkZs5QMOcbnMROYGXUx7jDgzBCaBJFK8doaiTNyRGK
 wQupK4ze442RLmeHiOO1qPug3Ibkw2HGhijvqlyJBM5YMKBEVOhmFoVkp9zJxI8W7fcHspCJJC9
 q/GE5JgBT+M6N5j6oABLEyIlfG8HPS5YBSrNjZjV1eZSCe3LcI8FMAUQleP9rJXRANRqfxqrN5I
 /PlnSp7sLtR5v6MnWdk3Boy0n33O+dRhQB3C5T8Y3vwcwhzt2fScT2ZAskZCUhNBeB6AeQ4JKqO
 w0Ref6eEMCBGOf1m0tzeLmEHIisZhJOkBmWlwxPAihPNvaOae9TXjOSsQ2YdO78osGTetnRj+3n
 o3Z7gj4lopS8rr1kCtyXiRQ6XBselbDmpNqtPLgX575lfY6M182SrFtUan//SCH2xYzfKkuw+Cc
 bqxtISEoo+5bjZjow4Hoim1+FNOsiICmo0qsdv4YKdCzTS+V4i3PRX4n8C6JX4Qr0nwzFnNYrYA
 Z2pGQc1mJOJdIx+ziwaEuBNUKJX
X-Received: by 2002:a05:6214:5e03:b0:8bd:4bc7:e19 with SMTP id
 6a1803df08f44-8bd4bc714d5mr285979606d6.47.1778444304161; 
 Sun, 10 May 2026 13:18:24 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3a43636fsm76040566d6.21.2026.05.10.13.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:18:23 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, lyude@redhat.com, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband
 reply parsers
Date: Sun, 10 May 2026 20:17:33 +0000
Message-Id: <20260510201733.2882224-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
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

drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
message and then unconditionally does:

  memcpy(bytes, &raw->msg[idx], num_bytes);

without checking that idx + num_bytes <= raw->curlen. raw->msg[] is
256 bytes; if a malicious or misbehaving MST hub sets num_bytes larger
than the remaining payload, the memcpy reads past the received data
into whatever follows in raw->msg[].

drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw (noted
with a /* TODO check */ comment since the code was introduced).

Fix both functions by using a single combined check
(idx + num_bytes > curlen) before each memcpy. Since num_bytes is u8,
it is always >= 0, so this strictly subsumes the simpler idx > curlen
form and no separate step is needed.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
Changes in v2:
- Drop separate idx > curlen check; idx + num_bytes > curlen with u8
  num_bytes (always >= 0) strictly subsumes it (Lyude Paul)

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 170113520a43..9416a48804c8 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -871,7 +871,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -907,7 +907,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:
-- 
2.34.1

