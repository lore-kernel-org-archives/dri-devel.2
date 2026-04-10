Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A216E99046
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0823010E89F;
	Fri, 10 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s9kUcvMX";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7A410E05A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 04:19:04 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8a58057d7baso18959176d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775794743; x=1776399543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ArSw/Jy6VI8sSzLBGSoBorIgScihUu+vrKWP2sPCXow=;
 b=s9kUcvMX+cPeD60xPTZqEAqR+f8yU69hoijwpYepr7eSRzZEo6wbqpyoHEytI67981
 jDRg+EbK4+pW6OsJjW9JvIcX2KkkpTvmqC/Vuq+QzUfG8cNkXlIZrnKpbKF2kn/dJuFH
 haG9SkxLpEEg9CmaAR/uecW5Sv29Qfv+ZN7TBYXflbOiB3p6ZlIy9HB3BwRht4gbZQlC
 gwv2ZuZcjIgEdTmg29cT3YAWtMv2Xd6yuT2y/6jqCYPjWTfxoEGCIBopr9PTjExtF8I2
 7JBDn8e6eQWp5oyQhm1Fi0rQGgLP9sLEWEHkjaK/UCEPcuy4pEsJbHpgX46aRRGAFv+e
 /0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775794743; x=1776399543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArSw/Jy6VI8sSzLBGSoBorIgScihUu+vrKWP2sPCXow=;
 b=jyz6eRz6j8P+JsjV56tdjWIwzjDdSDDEW+G5taF2Itrw3tkfOHYElOnZOwBrfR4aPU
 sd85tYOUzdG0vG99Mbe3roAGCh9tEzYrcZwaHz2cGlMZ5gbBymaRDhm7KDPkBCFGZUTl
 os60hhAb1cOITie7ow+61qikSs7tOTQSwLm7X5M7rDGfpo4hyZASuAiTRpPbHvgd44Es
 yYdmdb5pUB1BuDu22+iaS5GRbyHNSrMAX5Ct17UH8NZiS1Ujp2xcFGr87QxPgMrdleK4
 yuRNz7fTcOrbtCU+Z3bNf9H6yY/9BosdsCuSZG4Q24c56Vbip5NOmwr2feS7Y2rTuev+
 Vl1g==
X-Gm-Message-State: AOJu0YybuYBJUJoni9a4uYwsvzMRytY9DmGWGv/2FXWVhhPDdGNPGryB
 FblmruYVaw/qydl2q50FyEqy9vkbIcy2UD0rqEMRFv+5phkW6UMV83v2EGZmU5fo
X-Gm-Gg: AeBDievAkyCppuCahbxXcPGyC4OItubSeRm+1k0wwDY8uwU9IQoWnJo2dtVnrkUC+5F
 DrGwgiAK8Glo9c49SoJzqgf96tQDYdNlbh1tOhgJhmLq7ZeTobIUv2uOYWgP72PTR8Lpw2vobB6
 vx8C4qJ5yaasZe1w5+rlW/p9W7aCatPh5kwqNXhZAaiKoVRuj+Bd1i384DGP2tKSQj+72ycEkx8
 ColGxOpZYn+SSD2eQq2hX7DOIJxH+2sWHU1a16JnWWmQAj6kny+zvdYwD8hR2SHEZ5TQ4G7VI/Z
 zARxrIuEbyqeFDsaDtrLPRLOUSE25gVHDUzkzn5T+nOIA3p/gU/VEMSryvZBe75V3XtgCLD/VM6
 fw3MHYCu1c6qyja3+gsDBmBwmtavIR0P+uRwdm33IEg/zIvrehzBP3l5SIfdrTnkqtBsUdP1CbL
 dyH7cM/C3FRO6/i19HBfH4Te2FyjVvXgWHFowE7xH6fZyE5IcLgXDHiF/MiAUi6EDCUCFUjtgHw
 s6yo0lnrPc3+e8sBV2lOCqk5EfQ
X-Received: by 2002:a05:6214:54c4:b0:89f:123c:4d9c with SMTP id
 6a1803df08f44-8ac861ad302mr23047736d6.18.1775794743411; 
 Thu, 09 Apr 2026 21:19:03 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84a104ddsm12905896d6.14.2026.04.09.21.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 21:19:03 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] drm/dp/mst: fix buffer overflows in sideband chunk
 accumulation
Date: Fri, 10 Apr 2026 04:19:01 +0000
Message-Id: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:48 +0000
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

drm_dp_sideband_append_payload() has three related bugs when processing
device-provided sideband reply data:

1. Zero-length curchunk_len underflow: msg_len is a 6-bit field taken
   directly from the DP sideband header. If a device sends msg_len=0,
   curchunk_len is set to zero. The condition (curchunk_idx >= curchunk_len)
   is immediately true, and curchunk_len-1 wraps to 255 (u8 underflow).
   drm_dp_msg_data_crc4() reads 255 bytes from chunk[48], then memcpy()
   writes 255 bytes into msg[], both far out of bounds.

2. chunk[48] overflow: curchunk_len can reach 63 (6-bit field). chunk[] is
   only 48 bytes. Multi-iteration payload assembly appends 16-byte blocks
   until curchunk_idx reaches curchunk_len, writing up to 15 bytes past
   the end of chunk[] into msg[].

3. msg[256] overflow: each chunk contributes (curchunk_len-1) bytes to
   msg[]. No check ensures curlen + (curchunk_len-1) stays within msg[256],
   so the memcpy can spill into adjacent struct fields.

All three are reachable from any DP MST device that can forge sideband
reply messages on a physical connection.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index f2a7dbc5e..5261a4a54 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -789,6 +789,12 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 {
 	u8 crc4;
 
+	/* curchunk_len must be >= 1 (min 1 CRC byte) and fit in chunk[] */
+	if (!msg->curchunk_len ||
+	    msg->curchunk_len > ARRAY_SIZE(msg->chunk) ||
+	    msg->curchunk_idx + replybuflen > ARRAY_SIZE(msg->chunk))
+		return false;
+
 	memcpy(&msg->chunk[msg->curchunk_idx], replybuf, replybuflen);
 	msg->curchunk_idx += replybuflen;
 
@@ -799,6 +805,9 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 			print_hex_dump(KERN_DEBUG, "wrong crc",
 				       DUMP_PREFIX_NONE, 16, 1,
 				       msg->chunk,  msg->curchunk_len, false);
+		/* Guard against accumulated msg[] overflow */
+		if (msg->curlen + msg->curchunk_len - 1 > ARRAY_SIZE(msg->msg))
+			return false;
 		/* copy chunk into bigger msg */
 		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
 		msg->curlen += msg->curchunk_len - 1;
-- 
2.34.1

