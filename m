Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6C2CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2944F10F5BD;
	Wed,  7 Oct 2026 13:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dC8boC35";
	dkim-atps=neutral
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A2A10F5A0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:20:15 +0000 (UTC)
Received: by mail-lr2-f7.google.com with SMTP id
 38308e7fff4ca-3a9a51919baso3200541fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379214; x=1791984014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FPdX/wtfrIoJuU3T/PjxExDIh/LQdp4FgVNwlqulZuM=;
 b=dC8boC3565ZhI1LLRMLwyQxtklo8Y/xFvIzHDszvNW9t0PNeb0RkvA6UBHudvzZlrK
 7M5jWZrwIuNEw67c9SoRO/xfadvbGO+nm46Pp4xtgnSh7KmLLTWzQcIf5PRCEtk1bu4X
 6+J/sbG1R8cW8iN8e6K6hZ6JORdebd3EBWk/+1jiDk1Pq0q9z25yPYtLVMuJexOI+iNJ
 HPs+46sxl2HsHV/z7sPH0DXDhqxyTETrELMMYkBs/79hFm18ca2KzJrPmjzDhB8B6XDg
 jmar9LdlDThNwe4w8jweJwP2+bwbb8cR8P02hE87Iu3iSrdXlMiGq0MFvltzkj2qW4BQ
 F19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379214; x=1791984014;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FPdX/wtfrIoJuU3T/PjxExDIh/LQdp4FgVNwlqulZuM=;
 b=d5gksx+fTKy1ZOAtFbyLIE3HzhROOb2d4s+9DwCjLGqA1DXAfMxqKV4kYVql2rKbQD
 RWIgGQTlJjhlMYFDu9XKb+iakanelRkz1Q4UvI0SE3908cO6egGA77GWvOustye9o4BB
 +IxWsJbx6Oi3en82We39NSB3oEtHx0SuLFUCnycxn2Q3WcHuoslNkQnew99pYMKV5B0K
 9gxwSY/WZmjDaJIsc9jDhS3HXPHBtdJ1pyYIelsGIxCOK/sNGBKw8vN4f8ohl4vwKQWT
 0JSneSPR3Lb2CqZjZXTFJ7nzkXrG+C7/UHCzmjJpYJAKzGjd/+9dj+MdFMryeXWxAO3+
 6dqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCSDs67aN77H3BvYRtBtMHCNp3UxQmPmjYOeLhInqsWXog7yDAh1jc86B4oEqe5ymXL9MTjsVPzXE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ96GRAqZiXEJdcoW/YcOEDbSZthNfm0vA6ci3zMewD2dwHhbsm
 IdfH3CGpVnnJiQSbYH5y5UeWQniC8fuTwTwUvgPTnTvTuxC4q5LzBEpp
X-Gm-Gg: AYBFou3jVU3YprgMp6MaGw443bETAmkeqvAo14LcvegKYmn6gmQ1ZwWmNE26S8JNhQQ
 zV8VMkiyW64b0gZCwHBS0gjpr1Pibzmx3polgbav0pv7e5FwZcRjd+HF2/WhlSMyR8dvedz4soe
 xfpjxIwpL0O3rFG81yRZMz38qvXjKzNZ6xmsvt7E7BbECq72tjYQQSmZQZJJnc0hvX1GzaiO53z
 b9/+KYJ+wPyb8HZ+bs12xwYXVf7dtxTLiYGqxvG3c2SY2vW1u0zejsPOOfAy9k2VPHwsfsWFcE3
 wJiTfJOH16SqUHjYA435XD+1jk7g0UvMSkkSqt66xWkfu67u5ekJptxqnIOXzNWba8L+CKcPjoO
 fjHOhJrrBsoyJcJuq8uPEAeBpf9wVzoJSwDbZBeRTVEFENHzvl38xWNWQcSaz8scx0GomPlyUS0
 cQgdlnFS6VR2gVtwlsn0vhTNJiDDeMsYTOFA7M0jdvkb8mi+zxnH9daftbVwyGnVvt0zEU9Z8jb
 wxhlz2Z/y6jbd1Gcw==
X-Received: by 2002:a05:651c:553:b0:3a2:f233:5c6e with SMTP id
 38308e7fff4ca-3a9a2c65959mr5044541fa.6.1791379213808; 
 Wed, 07 Oct 2026 06:20:13 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9a1a9c423sm6097951fa.0.2026.10.07.06.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:20:06 -0700 (PDT)
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
Subject: [PATCH 5.10/5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG
 v2.0 ring
Date: Wed,  7 Oct 2026 16:19:36 +0300
Message-ID: <20261007131939.120898-1-roman.demidov.nn@gmail.com>
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

commit e5f612dc91650561fe2b5b76dd6d2898ec9ad480 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 6ac27241106b ("drm/amdgpu: add JPEG v2.0 function supports")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 96179da0c6b059eb31706a0abe8dd6381c533143)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63848

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 3301ad980f28..af8f244e9c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -762,6 +762,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
-- 
2.53.0

