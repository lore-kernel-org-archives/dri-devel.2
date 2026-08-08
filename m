Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A3AC5B56D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92B610E639;
	Mon, 10 Aug 2026 06:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qti/+lS9";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCC310E091
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 22:30:17 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso645732a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228217; x=1786833017; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=donWOa9YU7cxTUOyT0FxOO2TlG0hwlAfCOqayTIhbbE=;
 b=qti/+lS9/RIKdZkMyVl8UyF2dQcM6MgQqm64pnW25Mvrzvtt5FqP8LbVEyKcgve2Q5
 Ws1Rwi5tkkPunxQ4MqIzvrzVRLLtwPoTimVoNP4A30WSs5G+waBeRkpQjs3Zfnn6pWLL
 X4qbYOtQ9uWEL8ICcakoYDVANJ0E6ZKK0spTTEhZNtLRCMIBvNmUlCdTeyTH5ccKdDTC
 EPEtaVp+IIW0o5VXNeShL00eepUXsmPtaujMzY+unr1opEPT3g47YDqTpViUJaPFNy9M
 5X2zWugApNoxjYbNFj7yo8hOW78Qe0S4Gx7K/GRvUfhkWiRck0B46qXORsAKpRK745nq
 kpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228217; x=1786833017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=donWOa9YU7cxTUOyT0FxOO2TlG0hwlAfCOqayTIhbbE=;
 b=ILWLjvaXKWXeY245nI5+cjVsTfzGPYnzvE7gOxz1BECT43SSeb6ojg77yLj+lOzJGS
 ZRnJnGx+gJf+Udq86pV/d7Y2A53/UtH1C2jW/fZKKZcH9Q2cRhk8xt0SndZEamxfx2uN
 pfqUf/P9TnZILArAQf/iPJD+iOtKn071A49ZW6TkbNGSq5km9+i9FAVEuxb/3f7Kn2fP
 wvsCaCic7DFzWTD3lSvHcz4MSBOnDgyvTAiHRHRajScDdIauhKBB2UqB2hMCQ+at6SsH
 wji5C/mbyEEu8GEQ5FEBprsiMCZ9SV3QSS54qxpoD9GknbsgxAEkZDRaUh+l44EmPFSH
 7atQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rode+yUu/MxKU5t0oZmQLrYeDvxCwrOVV/jY0l0wfHcQ5AlW9g0YLIteYX8wUaBiEgp9/5kVMuPFwA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywe8dLJfDC7w4m3dnkokigSmC3OKId3dMa2PXygtIumNu069RdZ
 UMuDug2RAErZsfQa7LdTJiCQ/K8VHMviU7iJv+EeBoplqGYlGPdRKxKo
X-Gm-Gg: AR+sD12iAHWhFdz9c5hII5MBUFRB5gzOkEgBkOSH/PJyz3hqa9aVLLvauQQLQQdfMdV
 Jp+lD9ZMBop1uAegiwrSsSBgdOLDiGPYdW0UKEQ54DC9gHsvPgTmI47TCt6G7da4U/BRjPMSn8K
 6gAPbklISKZhSexRByLJhiHswPJyxzOTb9wm4NpUBoJqRnlcOzB5iSF5oIxOixrlxjglyKO+QZo
 J8JSaDKNyMTQFQdgECDFdd/zP5PmT6EIbwUc21xG8vuX9qRY3uHGl0TWRsUieXdSv3tlDDgcXyV
 eJ9CiCkvmJAkQyXR7n/h91+vSp8BfG7g87owNqoBsoOfo+WBGsOg9WucBVowzyOUQ/X6XIK27Xc
 EQCoXfq9rJ6n9mAaKpNDmN8Y0CjJULqwAVyrNu6O9ILMIiqBjZM3SZsoCYomgvrg/uhWOQ2qDhI
 +8gMAM8Yb/Ke1hYfQTJI1yJo+GaEHbv7v26UwVYoFEEg58iJEGXw4yf7YxJ2uuYUOHCl1vGMT9/
 t0Lp5vuZF+uylH6yDWfVQ==
X-Received: by 2002:a05:6a21:6b16:b0:3bf:b9de:8570 with SMTP id
 adf61e73a8af0-3cbc03b55demr16594991637.19.1786228216955; 
 Sat, 08 Aug 2026 15:30:16 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:30:16 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 4/5] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
Date: Sat,  8 Aug 2026 22:27:41 +0000
Message-ID: <20260808222742.2859-5-sreekuttan2156239@gmail.com>
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

aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index b4c1438a56d8..f22b58c559b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
 {
 	struct aca_bank_node *node;
 
-	if (!bank)
+	if (!banks || !bank)
 		return -EINVAL;
 
 	node = kvzalloc_obj(*node);
-- 
2.54.0

