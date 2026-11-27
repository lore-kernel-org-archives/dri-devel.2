Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B502606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KfKnyK9c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E4210E5A4;
	Sat, 28 Nov 2026 09:41:13 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F6010EB17
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 23:41:57 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so56882015e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795822916; x=1796427716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NQVMeYk3238ZN7qJr+WJxeI68VVfmiTTOo9wXCm9I/o=;
 b=KfKnyK9c16fAn8YS/6akkdadDjaYKLS4QQMPyV5ROdytwPk2aomE0CCwgGdTmqDGIw
 lLuWI0qnwBuA+ea28U/mDr8X9xGhe7MrxeJsjTQcnGTS5qxiO/RPs75bL2IBWyZh7juX
 eyFdP9dUq94XARQIOI3dI4vJ8fhBE4VjBCQ6YqnGcQtD63YSfyj7bzg+aO//ZL84s+N7
 LM5RGPRLISCVQgN/CmWdPbYOq718fecKc0RjouwSafc5LDM0F5Lb8L8w+Eq/iUXR6w1f
 z+2XZ+7BKwhTt2wIXn2lVmHyps5fMRqs8WkCHIQBp5xID1wtCbsUR2nk1r7Gxo6YvoCB
 788A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795822916; x=1796427716;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NQVMeYk3238ZN7qJr+WJxeI68VVfmiTTOo9wXCm9I/o=;
 b=QarxddwdzwXZMRGIQwd9GyhvcRAxY+XB86fWORS3p60yO0wwIAkl7hC4ZSYnVSrG/p
 65L/Irx0qgmeze5Zqgf5XiKVzafFujEmmIo4dtuOHDQwXaw2ofWPKwhEKeUxgeCQf+ez
 QWZYajfJY6VY08IdGkomobjaI54CATFLxm91lTbWzVS6NOeL4bpk3ECDbxHx9yaoGqYB
 XRSKKy2OLDQnCwhd+5qk0gphEgy4R8d3GvEtSaa1ZE5S6OpRLv0tiLndP+fImkpjZAzo
 521G1zkJws86tikIlG3ziLOFqMMadBleNvZaESBfPdbr15VUkOOnzHgBiVfF3fN2zziq
 X36g==
X-Forwarded-Encrypted: i=1;
 AL+hErEwx9rvw528rbfaMZMbOB03BEok0057sJ7b1AWnMYyGC5pmvooMokjuZkC7HkRL+HTe3ZldJWNlKSE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/a7etq5UtSVx/VW/8FarAJdiFwP2Zu1KlLyPscpLXI3JpmZ2Ni
 kvMA2Yo+gNMug8cFOjW8q7NWz+/6ore36KXsRlJXVk+40kQJd5l88iMR
X-Gm-Gg: AZFdTZfIxUqQSKaSW/NWXf8/YjwgoQZ3aS+piKFQiVVhg7EvJIBY4WhGXP8xtV/uNA8
 jzVJtarBWuz8kpjxyaetiquofDanIlRltzq0uLHK9iO8HRIU6CtfwHD6XpKMnwmrxMXNcjTntKb
 OymXSI9EnZAm/JObxPBW/rUNH4L4rSdig2Qhxk6r6bg4qD1RdkzcazBWujJSCXHIRgkHTg8OC1L
 4q9KV1Y170+EyomyLUkdu6fpay0efB1Yq8yqDUzXRo6YS2bqfMsEomXN2ZcmZpVmYmLhssV3V+4
 YuATNgvmf2jQygeaKml8to7Nx6kL8hiOh/ZFHsea8ylxmpd0PyzpiXXEt5rx6N+uRr4G9KQQF5y
 V2VBRPdj1NrFRJowfnnA6R3FTHBDWdh8oSGaBDD/l/zJ8h426Gu+CK6N92oDiGyJTSc52PtevRU
 BLbxvt7Iskv8mOu6Jk2JN8CZ6GfA58fFBWagBHdPEqwS1pGIyl2kZJ7Be7AMYhnJQzIgVpxhiCs
 VZi5z8zvA91LWkg4JlDSnhF3W01vwnLoBtmHCnD1ITs/PYiVilckf1aJf/BmJlrsw88uICQSSMZ
 2mk9gWKLCHzDzzVxffwciYgnX808bxWXA7etxcJBmswX1U3YKOi+DKb03IHWlnsc48rjeZcxOzi
 4e3Cx
X-Received: by 2002:a05:600c:5308:b0:4bb:76d6:1f5d with SMTP id
 5b1f17b1804b1-4bb887ca192mr532417645e9.2.1795822915457; 
 Fri, 27 Nov 2026 15:41:55 -0800 (PST)
Received: from utux ([86.49.161.202]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm789171825e9.12.2026.11.27.15.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 15:41:53 -0800 (PST)
From: =?UTF-8?q?Lud=C4=9Bk=20Habarta?= <habarta.ludek@gmail.com>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: airlied@redhat.com, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 =?UTF-8?q?Lud=C4=9Bk=20Habarta?= <habarta.ludek@gmail.com>
Subject: [PATCH] drm/nouveau: fix 64-bit divisor truncation in DP SST
 calculation
Date: Sat, 28 Nov 2026 00:41:26 +0100
Message-ID: <20261127234126.4539-1-habarta.ludek@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DP SST watermark calculation uses div_u64() to divide ratioF
by the total link bandwidth. However, div_u64() takes a 32-bit
divisor, while the calculated bandwidth can exceed U32_MAX.

For a four-lane HBR3 link, the divisor is 25920000000, which
is truncated to 150196224. This results in ratioF exceeding
PrecisionFactor and causes nv50_sor_dp_watermark_sst() to
return prematurely without configuring the DP SST stream.

This was observed on an NVIDIA GA102 (GeForce RTX 3080) with
GSP firmware 570.144 and a Dell AW5520QF connected via
DisplayPort. Video output worked, but audio remained silent
despite valid ELD data and successful ALSA playback.

Use div64_u64() to preserve the full 64-bit divisor, restoring
the original arithmetic semantics before the conversion to
kernel division helpers.

Tested on GA102 with Linux 7.3.6. DisplayPort audio works
after the fix at 3840x2160 and 120 Hz.

Fixes: 7e6bd6409b66 ("nouveau/disp: fix post-gsp build on 32-bit arm.")
Cc: stable@vger.kernel.org
Signed-off-by: Luděk Habarta <habarta.ludek@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db6..7634147c01ac 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1661,7 +1661,7 @@ nv50_sor_dp_watermark_sst(struct nouveau_encoder *outp,
 	//
 	ratioF = div_u64((u64)pixelClockHz * depth * PrecisionFactor, DSC_FACTOR);
 
-	ratioF = div_u64(ratioF, 8 * (u64) minRate * outp->dp.link_nr);
+	ratioF = div64_u64(ratioF, 8 * minRate * outp->dp.link_nr);
 
 	if (PrecisionFactor < ratioF) // Assert if we will end up with a negative number in below
 		return false;
-- 
2.56.1

