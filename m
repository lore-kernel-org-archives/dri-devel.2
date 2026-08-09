Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71365C5B567
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711EE10E645;
	Mon, 10 Aug 2026 06:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AQAMmFj5";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A579D10E115
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:37 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso8552025ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265377; x=1786870177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=AQAMmFj5pQNZsVpQum2+2NCnuMuBbYHYou2ddQaOBfONDF7h2NmYBDFNJU4NQi9U6Q
 HqPz5jf+ACDR9AxsLGt7iYD7uF7lk4AVof5/+HXDV6LZzkJuXcAfHmHYYLFVe3YLJITZ
 qVE7/BVqu5uWVq2Uw74ofIekXk5WdUEcZgnbyGu3nBAKSCDo6iUzLxnMabKzBXtgL7UA
 IYqW6T1ilFmpKdzEOhbYAGBSHbviJ29a/P+2+0QdFlK/PCkHTIhLYsvehJvyp6WWCBRi
 guBsM71m7l+NbuwfWgTnUlAseu5x5ucGrZPJyUL6LhIss8T2z1aUpmw6ZspB82wnRi/e
 sW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265377; x=1786870177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=GzTLchlAOpiBwnhK/c6ZfZzExVXYJkyMoHCMPrrXWolzWxEA3ORWujr7L3yL919wbP
 tOnDbkW9hBaDPp0XnA9LZPZgP3Jvxy3yWOtKSzCxL6aiOfapt4XKOGNnJ8OkVhh9c355
 2NXvUV0xcVEp5EX/L3KsQmQoubuqteP+0S8Fxl+l3K1MgE+VkVyh/Pdm0n1jo8j44+S0
 uDQB1Q7Vjk42eJ5F6pFDUW76bvd0NgYo2ml/yk5EMeBiPjPlBI8cvXszH/o/KBa8hipD
 ur07/nmfSnpoM2gvPG5qxj4YR7/Ndz7M3sqyiKkFreA8pspdUq9bqBA4EKNJmJS3iFU1
 l2aA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvhlLTO6f2H+PKUJulgCEMcr5woqER4hrDDNEqiadRNyoqequX6op83EDAXLtP+QJxN64XNEqGXVw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzaasqD4fU0PUob2V0TmCifG5wW6ydgEjYtdC04RM7O5zc2tBY
 r/Gfj8QsVgAOPK7COCZvkSkc2VvyVtnSRrTGBh69TMoNbqpoH5X0HxrC
X-Gm-Gg: AR+sD13szQpuK8DDy6hXBhRBuXHFdYlAdIWLlv5wlTTJqC7EE/4D67qS+bMmXHreMsK
 E5XCXfvrQ4O7RI2SCnoNhlMMPgtSJOsp+UBLVPoHpQF424ScXtDmhLLI5JOoPh9T2L0wCicoTcM
 dP36B8VAZsRZ8hbpcYxK0khdYn5F9xIw3gAkzic3pfs4jR1sCxZvo+aEKkRrWYiK+moM3o7+vxk
 WfCahysGQhP96xayU18HCsALpjsN7/qSWzUp7RdwzjPI34ZDDfySRkC2PWFcTkH3/UX8iaj/Q1p
 WqFaAO2MULI9/aApckMW1KeKrIGKjCmZZCAPBHybR2KluzypXIqrH5ENnd4AR7zuz+3CsS93xp8
 lacjGU7X1dA4TT3UsJb7rYZTORw5v4KTVCQ7n5HRHfCHVU2dbpgmCxB6KWt6wq3sLSqVcJ3uFRm
 J9hBqSDlB112emWAoGEcEKtP3v4SU/b1WEYwTjr1Xuh54m7GRrWH8gO29h5LRxR65ll5SyPm0s1
 YqEYPPoQn65L5vPHMsFfQ==
X-Received: by 2002:a17:903:46c7:b0:2c9:b48c:fdec with SMTP id
 d9443c01a7336-2d0ca75d2admr449178665ad.12.1786265376710; 
 Sun, 09 Aug 2026 01:49:36 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:36 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 2/6] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sun,  9 Aug 2026 08:47:31 +0000
Message-ID: <20260809084735.9743-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
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

