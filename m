Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853FBC5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0303810E663;
	Mon, 10 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hkj8w6/M";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A81010E043
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 22:30:04 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso465063a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228203; x=1786833003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=Hkj8w6/M+EoSdmU6hDAXRZtn/TapTAcQuPpNcTCQpa4fB5XeSAo2DFME5mScCYDR0Z
 +7QyP9Cm2aXJcojjnyIiVge3v1NGpYk0zP66aEVWmdUFQBP4usrUxri/LNNlm9XBprsr
 5G3j8W5QSG6FDAkaWPjA33f6LbKix/EFPKi4vBpAEdcqFMCZs5ZoSboOctPU3MwJKENJ
 +WE8sCGvWM4qOV+bdB4x2WHWnC6c1svshQQHenlrGEepNpkx9MENWy7uKnQXiqKFZF+J
 B5uy86870x3FFQmrQyH1191PLHWRCkrLKEeQ8m3l2/efzKLPoVHLcCTyCpCo5ZDBzIeS
 bBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228203; x=1786833003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=shSoNXqjKrDR9HxkCAXL2cDtiA6JgrDZgFhzls9DwXz/eVQn4ZW7d67pFiRH0aTF3e
 rZOQlMQ5iaPwQj7Hg7f9JUZig4mcl2OA8cCRGegxPYBvy2Okq7E2X31P6j+9PFJDQlF0
 AkfZW9138tw2QcFmm8rbSwS1Ffy1j0OebWeT988blvr2DW0q+oU9yQm+eL0VinQIgkkH
 t2732IvDHffCVWuGsFSXvklOrErpzPLcer6F0Iau6Zwz1ZQ7AQiQ2Birkfen7ErTw75V
 JGULkLqh8E3L3ZMStyUt+MTdQbzrj4F2/d26tPb1g1gk30Uu6gJY00eK8LxLjaHmkta5
 FVuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpobgKm4Qy16izqBXw6zzOihKNACi1/KKeVzxx/RNDDYGxvx+e5/P3CGY1WAzuDqtioe+5fIX4QAIY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx41b9GJqWK43t/jkmUHe7hye3nvasgvSRKjfgexxV43C7nbnfT
 LSvI8L2tVjIjSU4sxUTVuAJkQNfJP4EOcXZoGrd2AiWMoo6l5bi6H7S+
X-Gm-Gg: AR+sD13hTB6k3Wr12Q5TxfqxepaBc5HVwGAIBlCr7uG9Vdbm3qi3ww9FK1Nn/oeAs0c
 KLkJl86aNT59GxVvNMmlSLP+ayTzcoxq4k9L5cB1wI72+3SCZTxFb+pNAGK/hQuCR7dYrJ+Wne6
 hK857D8/+L9RZiLqxSDejhPaBMXMl32IPr1EKajV/pSDsiU5ykpLSDQ4ZyH/TDnrSg4kLl0SGRN
 pS2z2spsJSUDHgZcCy/2goTFWCod/uxUxmAm+7KVZANjAWUR+/WPk+TYb0QFT79EUHlNBC7HA96
 IVXEVhjS++12Yu9RyQuGZFI2P4noWTzohJ7QgkBz6WuJu+SJhR3GbGOrMfo0RgUIBQuiehlYhf+
 12yEGbSFkMuoQo0IXRKCs6MJA0K3nkKb+4Pgl2vtCvWUvouaDOYTca7DtMbhtMyccHMIU2/ShMx
 FYdmRMr3QyLYFlO63ZzBkSKYTQqn5EdFI2Oah9lpgdAqtT0KuSAR9Tu639XuFpZkEGYrjFYSAt4
 DqDWNUgqgA=
X-Received: by 2002:a05:6a21:6e0c:b0:3bf:c223:4640 with SMTP id
 adf61e73a8af0-3cb85f4e199mr40663547637.32.1786228203504; 
 Sat, 08 Aug 2026 15:30:03 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:30:03 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 2/5] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sat,  8 Aug 2026 22:27:39 +0000
Message-ID: <20260808222742.2859-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
References: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
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

