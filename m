Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65016CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9447210E5BB;
	Wed,  7 Oct 2026 13:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kYRzPaBO";
	dkim-atps=neutral
Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B5D10E5BB
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:26:58 +0000 (UTC)
Received: by mail-lr2-f3.google.com with SMTP id
 38308e7fff4ca-3a77df9781eso23106241fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379616; x=1791984416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GDQwNh3Y7ViZN9kSjBt6rSxx3bjORoWLA033ou0tHZw=;
 b=kYRzPaBOsCSKqRQS2vizyZ55efSCQN4loX0skpAstw2U6ZzNey5M06/6QYaEtF1M4m
 +Xbjr8e2pRtiHW2jYY7A/jmVeqt1J3USVCyKtZndNO6QDDV0D+bObGUsKrXeVJm+kqkO
 l2Wf9oidP8YtSuhdRNj7iYl1FeLxwcSkZLWLxWMoKvwjX8h787KaOQBU5zxvH4o2CJw8
 Z+6YKAfSx++zHlsKiRNN2y5Cfah4UMQbawpOJkw9HlknDC/5/qa5CGfcrSdiDfA8nC2S
 puMSRKOyadqnKx5w7XMh9woZs2+xlAO80bbsM5LeqoEQxJCDRoIeeHbIyB/8qSJvsJa7
 rHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379616; x=1791984416;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GDQwNh3Y7ViZN9kSjBt6rSxx3bjORoWLA033ou0tHZw=;
 b=MZPaJL7glfkrNcEhadWFxuaHBUJGNSbhikpFOpEQ/vGZQiZnCZ2wio0IM8urUbYqLz
 GMtfoFkjTfNqM1dDRItkh00M5bPpar7QJl0OGaJwB7TZwWzpqDfWwMptAV6x6uVT7u+I
 J2V2IiJYViVfFcIPvQrlr7fo4mhprVA+5oZFsBD3wLUjmjvgqFIB+8sgHqKjpQC3hisz
 /tdT9hKxQzhJhi0ewgut37om9XK864LlcbjnUGLzaYyGutcCChzRG3QS3TdnJe0dKoci
 by7zA5003R1RqRFu6MgQL+gJA0t1zTKloeIXTnTdCBnQT2tESyioEK2VG9LXWCozRUsc
 Eb2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBysjK5syzo/yMT2oBMBmoND/i3zbaiBAgWU8x0lUWYErf5e02iwGxeHzvKFgShh/1PI5faNUCobevQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJRp+20FiJTiG/14tHLRouLcITzDtQCnDopSZw+lTsoHYM7jG5P
 6H6XTcoWT4BSdLjSMWACugoFYUXmOcHo8YAqbX4q3VJ2Fo2iqhQjMnsq
X-Gm-Gg: AYBFou0o2pR0GtRp3CPwDjy6laY9JzqaxnLN9zEXukDwNt1J+falETFPUquEzdCIngZ
 D7fAKfDUhB7ETYCLegxRq09QKnQTC32DB5XGa6zzOXnY4OSm/XGGWI5RGP7KjGvMrPE76F3bzOw
 qxrp0d5/dR3YORUx5VTjJJ4w3rmVTvZoVDJdCXPdXvDbxoiSm3lFxiocYwHVq926Z6Ux81t07sw
 aVzSFW+F6k5uXQs5EvJvreHEFyeXrBi/QINCRrUiXzK5oxc0yzrhoRJ2xjA/K8BYzb3CgSa09AH
 vbS0Kfj9yhTnemnBrJO6sHuKnjnvETSQGujkWJfeju0mxvByJt4TpbPdTDBSZIfqz+xLOlulZfU
 lSyDB4cfmOgKGRsNAld17BoRzhXWl+PqXLTxQZygMuPqh8PfVI0umhDEM6l0dALbGW90ZrDR4Z/
 4CHat4Kavpj7Z6qzmHZy120gEaF2JDNCACwJohgC+Ewbs4y2E31sP2u7qCAXYQfwwpaMNQ5Sjji
 NdHFVBHylZ9N/1v
X-Received: by 2002:a05:6512:3a87:b0:5bc:b962:ccb2 with SMTP id
 2adb3069b0e04-5bcd074b8f1mr877734e87.63.1791379616009; 
 Wed, 07 Oct 2026 06:26:56 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd3083558sm32201e87.39.2026.10.07.06.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:26:52 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Yinjie Yao <yinjie.yao@amd.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
Date: Wed,  7 Oct 2026 16:26:46 +0300
Message-ID: <20261007132647.121360-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yinjie Yao <yinjie.yao@amd.com>

commit 79405e774ede411c6b47ed41c651e40b92de64a2 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3216a7f4e2642bda5fd14f57586e835ae9202587)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63847

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f87d0f6ffc93..a094dd138c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -641,6 +641,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
@@ -671,6 +672,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
-- 
2.53.0

