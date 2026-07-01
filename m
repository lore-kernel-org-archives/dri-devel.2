Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398EBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CC810EDC6;
	Wed,  1 Jul 2026 06:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pKiG/dnn";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F9F110EDC6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:44:47 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8478cc93299so148813b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782888287; x=1783493087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zr+rNtK43qtc1F/vQgzrjcPmk3IPAkJ24rsdBVmNakY=;
 b=pKiG/dnnGqRUICEeNJTFcqaASqL0U2SkEs+l0lwPZTmSaRxgaNB3rRTjZP5kDD+jHS
 5rscxEnERuhSJODg0Px7vukvppbXCEVorMQdIgm6aQNyboE3quEoyfBf+z1VvlHe82fm
 rCGxAyvrl8HsvJ3r+tWa9BV9HWwQMJTd/qmuOcszXWHWQsnxuefyoRC5vppuT099K+mi
 9Mro0gBNsa+vPdXXjzu6J7mAYOtc9wv/NNHntYEBZ5YZsN3LJqSC3Y7cdGmx1n3/lbpL
 h3cnFwRpPRefdH/wPKrvduWSEC7j/U4nABSi1aAF514izoPA2+/Nnt+lhglDI/bvKk2P
 tQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782888287; x=1783493087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zr+rNtK43qtc1F/vQgzrjcPmk3IPAkJ24rsdBVmNakY=;
 b=XEfTZwfbPztbu1gm5+SMYt2L/pljLY3mVeBsm1y/TSROmrpvH7dKzzav3rOC2Om5Tv
 Z8OOFLICZ/64dRcHKTIiVGBxnbPzqW2/EDfHLP+eVb4hOlum5emEPARAWOTncGRd2djZ
 9EuhwwCYfERrTWm70NScAvuukyhDKHVPUYowSvGq8x2Eol7eeDWhtR3rOdLEffmmVz40
 oigHo4uly91jzS70upX7O2seQ5yEj18RgN2UAxwtTGrbzRCKLW7ZW8PIaZ0qzrQ+1gQn
 kZ4dpxAtHnOhfofVHlEqEXE2voUx1gbjirnbddkdkPE+j7cQ8krOqKHEz4oTPLDc8AoC
 g0lg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8oWVYMyi0nwVAY0JwjN1P5lAICcCwsR1q5FNQ6y1/BDYyXq/FyLgcllXAGwWG8EbelfBQxT5UAyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLJIXKuaVLsN0hPBpMehisS7IU9dJoRBnpczy0DujLpYT8SYnR
 pw3F1sf6Hm7c+/ColVs1qIPtdUwymc+kBfTwjcmR4leYVu+zRey/rERn
X-Gm-Gg: AfdE7clwMhEXV0p9yD7hkLMV7rRhSMyxflVrjt/Gz/RSm9aIZ88QjEbXecBzg73fs2R
 k3lhmc3oqG2NOeXpERoU5H/umEfEGdigHXKw446BhuCXRmVd9Gmt2mKc/luIbMol+X/snaYyVnk
 HEvyl6Q+b0LeDmvb6vdFYwh3Y1ZonhfOfvhScTdylrd3COzfxylN60Fm8oaOoCISM+ELMyEH/1x
 f5TuEZRK0XXXuEqqnqzES8bgwNs8qHuGgFdNkRsGc3l3VnCjj+FYCBtNuHx0zQBjeLVkiV1/1eW
 7MjHFQf4RJZaPs0WOf9G+wM6DZ46yah+UONUOz4H1lih/LN95Ns6We5Cxwd/tXGEka8ICIfWZc5
 CnIlxMreR+EJRS16tSkGFFtuRwiqfcmRVEq1sZiSr0NE6HJAfnPVU/uH7ad6AzWfctP8pv9yb/K
 euAPiNqWm6NPqydyEECHc75Sr6oso+7rbZUFDNDVz8uy5ygaxd
X-Received: by 2002:a05:6a00:1302:b0:847:9565:7a58 with SMTP id
 d2e1a72fcca58-847c0948eb1mr253384b3a.48.1782888286685; 
 Tue, 30 Jun 2026 23:44:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847a033a7aesm3381170b3a.46.2026.06.30.23.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 23:44:46 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Kaixuan Li <kaixuan.li@ntu.edu.sg>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: tc358767: clamp the reported AUX read size to the
 request
Date: Wed,  1 Jul 2026 14:44:40 +0800
Message-Id: <20260701064440.1541418-1-maoyixie.tju@gmail.com>
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

tc_aux_transfer() clamps an AUX read to the payload limit:

	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);

After the transfer it replaces size with the byte count the controller
reports in AUX_BYTES:

	if (size)
		size = FIELD_GET(AUX_BYTES, auxstatus);

AUX_BYTES is GENMASK(15, 8), so it can be up to 255. Nothing clamps it
back to the request. tc_aux_read_data() reads that many bytes into the
16-byte auxrdata stack buffer, then copies them into the caller buffer. A
reported count of 255 makes the read run to 256 bytes and overruns both.

The controller should never report more than it was asked to transfer, so
this is defense in depth rather than a live hole. The reported count is
only lightly trusted, and the check is cheap. Clamp it back to the request,
the same way ti-sn65dsi86 does in commit aca58eac52b8 ("drm/bridge:
ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer").

Fixes: 12dfe7c4d9c5 ("drm/bridge: tc358767: Use reported AUX transfer size")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 4097fef4b8..26ba5a6c1b 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -527,7 +527,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	 * address-only transfer
 	 */
 	if (size)
-		size = FIELD_GET(AUX_BYTES, auxstatus);
+		size = min_t(size_t, size, FIELD_GET(AUX_BYTES, auxstatus));
 	msg->reply = FIELD_GET(AUX_STATUS, auxstatus);
 
 	switch (request) {
-- 
2.34.1

