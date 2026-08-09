Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869E8C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4795B10E684;
	Mon, 10 Aug 2026 06:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OkmW724F";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CF510E15F
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 14:46:45 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso852613a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286805; x=1786891605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=OkmW724F0JUD82UYEoXWy7PXueY5VFVSLeBvYkewSc7MynWPupunMayesXRZBL/CmX
 J300Zk+POFnLne9XqFr8EamjN8gAfEU5mJ/Rftw72HpqH8dtjN0m74GLhcuHMrMakyDE
 i/dC+dMqa7WtpKWQVfiJMrPNZS7Vj82z8YBQu5J8qPtZ0fC4GTrLQX1OX1CoTsTfGupM
 h4YbNjNQj5qzcVfqV1/0T1KD1pLN1nUHhTcuE3JuXCusqScsVrnJBa6frYBLNubV6So+
 T6C1TCz/4lntgIAsN8vP3/Qw0xC+G/CrPhfANSMtcEoo7BkVe7GBJv31Gl+9KXZTRRsC
 oxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286805; x=1786891605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=GsNiwggBElqXgaFH1+9IXdC/6VATXFUagIUZeJuT81acgliKY4aeB11bPZDk/qkLZi
 7JDsmGpb6F6ud6PiWiAGlF5IIV7bAlXX6LcITNcFXckxdMPbdhaKNdWDIn5LIdX83PIw
 61NCE+EDTsYNakpopj00GQNrz4lIdcKj6Gbu/imaqD52XLN2EfE4n91ENwh4t91dzXZD
 CTjGg0cRxjmpOfIIaka98w4l6oMyj7ePuP8X/7q1ZE9DnginAzaAlc9bev8vsCBp6CNQ
 Vbx4s2asv/KkDLYTBXWmC6so6+vJCW2hVs/JRnRYf1xjCooeffRJErWBETVAcJ/8gKQH
 ki5g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrqw4gUURaPFi2WIpo5CkXDu7ArIeebSsJeqCEGa9emeZ6WUaIo5b78NOCjpK+ybEomCTDzAjuC90o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjR/up76oP3gcz/QgONFyuVQy/PVCe7NpRA9rapDjBolS0WoFS
 076PJ7Nbptg5OBI0goqwM//4RXWdsVLFOwghSJcJT6sUhJfa4UHIJY+g
X-Gm-Gg: AR+sD13zLrtLlhCLhE/CkmcZj4Kr24SQ7vCrlkpSkmSHFSgwA+CiuP3eiu/czwPTrXC
 rcazEfUibsD99xBPYaonkYvTfw8sRcBacS4szCLzVFMNeAFTVN8NBxa8xNHpB5PgnGKuSZa0j+0
 AirtwvyHqX9RLoaJmRicIzLuDhnKzggb8iD8Ph71FCZ9HCKJuK5pmv+xLmumXzh//keYbdoDBZ4
 IklzjgKTULRveJ62WOaYkDEtNHjsZPc5VXe1iNARj9csGP+F/C9w1Jzdkj+YsBt4Qb/S38qcoTN
 /PE9Wjw7t9ra21YP1xuXwjxFmH8aoo9p93Pgnzmb2FLnX0AGT7DAuFDYIEdTRUeJBjuEmu0mJ9b
 aa0vGFjqaVM5v1T4j3VQXMuyBcRSgFpb1wTbagrTP825ojnwbLruB+TyFLvkylnRF6/6pljcDHT
 fyBRS+1Kg+sf4/iU0Qun+5vwc+zDAeeab747CUHZkZ2f+ADfZrSHVRBXNxrxqitUjXcFVnOBiFD
 qsiscaw+LPoO0bLcjuG+w==
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3903c58bdd2mr36617260a91.11.1786286805186; 
 Sun, 09 Aug 2026 07:46:45 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:44 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 2/4] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sun,  9 Aug 2026 14:44:49 +0000
Message-ID: <20260809144451.35431-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
References: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
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

In aca_bank_hwip_is_matched(), the 'type' parameter is used directly
as an array index into aca_hwid_mcatypes[]. The function previously
checked whether 'type' was equal to ACA_HWIP_TYPE_UNKNOW, but did not
validate whether 'type' was less than ACA_HWIP_TYPE_COUNT or negative.

If an invalid or out-of-bounds enum value is passed, an out-of-bounds
memory read occurs on the aca_hwid_mcatypes array.

Fix this by validating that 'type' is strictly greater than
ACA_HWIP_TYPE_UNKNOW and less than ACA_HWIP_TYPE_COUNT before
performing the array lookup.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d0d473082431..c76664af9902 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -138,7 +138,7 @@ static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type t
 	int hwid, mcatype;
 	u64 ipid;
 
-	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
+	if (!bank || type <= ACA_HWIP_TYPE_UNKNOW || type >= ACA_HWIP_TYPE_COUNT)
 		return false;
 
 	hwip = &aca_hwid_mcatypes[type];
-- 
2.54.0

