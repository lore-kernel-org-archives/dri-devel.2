Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C48C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B3C10F1E2;
	Fri, 18 Sep 2026 07:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRbfhgr7";
	dkim-atps=neutral
Received: from mail-wr2-f43.google.com (mail-wr2-f43.google.com
 [74.125.225.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F92C10E5EC
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:51:58 +0000 (UTC)
Received: by mail-wr2-f43.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so10798f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789681917; x=1790286717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OBna6qkqR2LOIJTkCDKUQXTi19qvcho2o29JezHr6+M=;
 b=XRbfhgr7bdYuO8sJ7G/dzE/mr4+LgSeGWJlRjE8FNtOBfzd8zltapgnZXct+acrbYG
 vPFBCkixINyBzv2I7Z+67y/A6n2xnzNT9+4UIKf+3sA7qFtknaQnDQI+D6Hgqa2nmTtL
 UkbRYCH1EnoyhHHMdJG23SGd7Ct33kFcOYD4LxIeBqRuA94UxM16PeQrsu1Lkw+dlZHV
 sVmOS2IzqrvCDyyf8mzksPNbtrvlQeL6CAoFk/BrnaIg+yz1lnOV4Jo5U+Ipc3cZxD5p
 HFhbyUQbuF7elmplVqwxjgt1nvFiK9Yff12ld/9+dr6Z/OeTM/yqAMolZ+p3nAElbxvE
 KRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681917; x=1790286717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OBna6qkqR2LOIJTkCDKUQXTi19qvcho2o29JezHr6+M=;
 b=b2kZyK+Wy1FqPjW2JaGZOPVDL4KWCi9/25Ikfmmu/OBp5Qy6APuIzYD1n5j2F/G79p
 /UDpnBe6mF4Wdgr+8jZdgMGXeuqMMqY4FmWBMizq59TFqDLcWux0Ifv8TnsYN6bas0m2
 +pUEEBxBANGzLAv/VchjIiIRV9oi+gkqrXv0LC/oZHvNeOLNGV5tRmxeW7DL/Xk4aO97
 mBwiGj9bBkmYy3PVuwj2vphFOPRYyGC1r+AB/PWChU9Ab/Kir3KHpyV/5N5gHK6kFo4f
 /p623YKTDOP+DIVMr2Z39Fzffw0+AttUrALDIlwTooZCC/KYJohNz7g+FwssfCC8uMfr
 nDUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGGE/0HVlJQue1g7hC9HK3yF3jopx1WOiHPbWht4o4YPWwNRa7ycStFG3yrZo71FlAhuj8yQxCd2Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n3QByXI6VzXM/EBFnHtrf9G6i9J0PMlVNtJ2pXWWstUjBAuDoi
 xSUULnjMAU/YnCffSLueF6kjK2skIOGRHxcNZFJhO5SE2qs/O4QlLtqR
X-Gm-Gg: AYBFou1p5ebnvacWlC0viLnl0mv3OUc2metP46fjv/T5KPShUg7Tv82MTvDg/vGWGvY
 MLWvdfMWLwNXfMCWOisBtwwOG3dsn9PDhI+bKhX3D1GihcLEs9RgDFJaYs/lc0YemiMeUAYymIz
 Uy8RSltv8CMgGSnNH9FZYm8WJP9F6+95LAnS3tSwwnqZpUEP00RssLQbCPxk2/rrU9ATwaHLX9Z
 zKMOBg4ZKQK02mcudbJpBFflSB8jPo8alMiQdEuLidDfp6fA44mdqQPgV20hsqyjIOfqiEUz60i
 qP2dTbYcETS2sOk2WdcDVHiGhlVaxpYJSOUwfMjtgnfFi2PPLbjPY9Rooqs9AgDSnV1B8K1unyA
 B8012n5j+KmEbHPyMY28/ELZzHEc3iomnqP2Ik7AjoLm4Qu6zjEq3ulz6bJd7dI5nqbxkSLD4o8
 SzMO/ALxDHpImFGWzqwBBNm83MGTFeNj0mCpBs1rFFdvRPcLNWkS0AoWfmkGqtPb0UWRik+zw+r
 gWUfWpV9yEBUoPrlmbpf+pmF7oW2tfu5hNYqpVRz7tHoHH6VdtDXv8IFfFrYA==
X-Received: by 2002:a05:6000:2505:b0:485:8ea0:da8c with SMTP id
 ffacd0b85a97d-4871dafc15bmr673423f8f.16.1789681916606; 
 Thu, 17 Sep 2026 14:51:56 -0700 (PDT)
Received: from kbuild.local ([46.10.181.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm19736579f8f.26.2026.09.17.14.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:51:56 -0700 (PDT)
From: Tano Dzhinski <tano.dzhinski@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Giuseppe Ranieri <giuseppe@ranieri.dev>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tano Dzhinski <tano.dzhinski@gmail.com>
Subject: [PATCH v2] drm/nouveau/disp: don't reject HDMI config on cards
 without SCDC
Date: Thu, 17 Sep 2026 21:51:14 +0000
Message-ID: <20260917215114.1136715-1-tano.dzhinski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917135051.47683-1-tano.dzhinski@gmail.com>
References: <20260917135051.47683-1-tano.dzhinski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

From: Giuseppe Ranieri <giuseppe@ranieri.dev>

nv50_hdmi_enable() passes the sink's SCDC capability from its EDID
straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is no
hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
configuration with -EINVAL, and nv50_hdmi_enable() returns before
hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.

The result on such a card driving an SCDC-capable HDMI 2.0 sink is that
HDMI audio silently stops working. Video is unaffected, and nothing is
logged, which makes the failure hard to attribute.

SCDC is optional, and the hdmi->scdc() call further down is already
guarded against a missing callback. Requesting it on a card that cannot
do it need not invalidate the rest of the HDMI configuration, so drop
that term from the condition and let the existing guard skip SCDC alone.

Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config method")
Signed-off-by: Giuseppe Ranieri <giuseppe@ranieri.dev>
Co-authored-by: Tano Dzhinski <tano.dzhinski@gmail.com>
Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
Tested-by: Tano Dzhinski <tano.dzhinski@gmail.com>
---
v2: restore Giuseppe Ranieri's original authorship and Signed-off-by
    (he posted this fix to the nouveau list on 2026-01-17,
    https://ratatoskr.run/nouveau/2026/01/16963412), per Lyude's
    review of v1. Added Co-authored-by and Tested-by.
    Tested on GK104 (GTX 670MX) with BenQ PD2700U and EW2790U.

 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index 377d0e0cef84..9887b3898505 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv, u32 argc)
 
 	if (!ior->func->hdmi ||
 	    args->v0.max_ac_packet > 0x1f ||
-	    args->v0.rekey > 0x7f ||
-	    (args->v0.scdc && !ior->func->hdmi->scdc))
+	    args->v0.rekey > 0x7f)
 		return -EINVAL;
 
 	if (!args->v0.enable) {
-- 
2.43.0

