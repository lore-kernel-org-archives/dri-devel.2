Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9B2C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC3310E670;
	Mon, 10 Aug 2026 06:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GW753bvW";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE3F10E15F
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 14:46:54 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1009237a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286814; x=1786891614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DbPrDMI/UNfpgAnDfLZbZKEr3Nfo6jVgSwQlTScmMqI=;
 b=GW753bvWm0c5Jl5CIkCusAWMTsNVKBUSgwzyw0oIByp1EXQrHEN/75C5XdhkDv4yJB
 woex/IiCjKBB0vfow6h7aFJ6/oAMZDP7EPRPblLgcm99qB8fe3+Z4P2wUgqpDHMsZ6Lb
 xsG3TcPmj5C8QaGl94zLsOJTPAtPonOWEPK4lO9KkPAWK6dANq1a1luMTq5wbJkOjyJB
 FdzMgNGTFSG7IZuIcLVEaywV7jfBqDxaIHDsRxi1kkqrsnvvtqNIvr6mZ5ofzNHJ6z0Z
 /T/lDJElxk4Y6iEKwj2VuLjQ2Las96DjjaFKWUqRidYxwjy9guncmzJz02a0oldX0T+c
 Fa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286814; x=1786891614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DbPrDMI/UNfpgAnDfLZbZKEr3Nfo6jVgSwQlTScmMqI=;
 b=HDNt/mkZh1DFNphmkzvYlaEf76ZvaZyIKhqjyjmYTPyaPLOymjScIuNUEc1irbfcu7
 k5C4QbKRgGQBmvxJBz3Q2GibaLYFrTpxoOmDa0cnGFwRo+chPfFpfaPndK/GIB2d7UPi
 vFKvq3WNjppb1XZuFLzuHVRJvmhPt/OKvGG20iP0N4DfgXox/pz/sMH43hQPBS4FTszk
 IFKeixFitsqzFjclQNNNRQu5SjfnttHlDQhnxbg9p86JMvE9rBBhbGNGZ0UhkSibK+Ks
 4Q9PHchnLazX0vhFATLkKHrxcUhn6Aa69BTRKdBcj4pndyhy+2etXyeBZ6boQ80/QJtR
 0uqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmRMTmDXZAcZIxyj5+7Z6npD5+i1+yhNpMZVPSA4YwqCnkcvVBjInRkgmf09DDB+N1IiUDPAA686s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/bY6u+fX3FaMFGrBQjMNhPUzv9l9bbC61fRAPQcjseFkrJi9X
 IxalQzjYBy8CtACwtXwA3cwFuQ4teXKbGWD/+EmWOLOKn/texXGn6y2S
X-Gm-Gg: AR+sD10T514IRGg/9YeB4q/rfL3/1PJXfgxtQnBMKsvGenUK9jkeCqt7cDzselai6cz
 gHkiRJDW73xw1hVDw9bGTxf8Sd3p/sSQTev2e59UMqbzRjZkvETqMnLTU/wsIbplpIZZHRTCj3f
 KW9msR8Q+NkOn0UPoeYyYJF+XtMD3ojdyFikAejRI7AsaQPf1TlSG9fWHnHR4SoSKkc0fUc377Y
 vp2WYRmTPvl/UkLrGNo5+MbgPBy28HuHw4GA6+GvMIS9qdZPBoWtGoJWIuy327V1AYfRk0Brmk2
 GXn6tXm9PkG+bby6XzjcYJiKcCJO2LyQpaPuLm0Ji1WA+dqv6TBIRp86I0MBxXf9tu/GSdXtoxt
 YthhBD2oDe3V5dSUpQpBTT8EqHjqoUO0YKiBxVVdAJJou6KNVOoAN9hMpp3Q5sLt3pMhdasrtSL
 0yuamoP7j8JU6ggThCnr7h0kSj46P0i1w4sDl/05NoTRix9Gpc7lQPoZdiHet9l0V9ixD7KwBfE
 s6TQi0QURs=
X-Received: by 2002:a17:90b:4e8d:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3903c58ed40mr36373724a91.10.1786286813705; 
 Sun, 09 Aug 2026 07:46:53 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:53 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 3/4] drm/amdgpu/aca: Fix inverted validation logic and list
 cleanup
Date: Sun,  9 Aug 2026 14:44:50 +0000
Message-ID: <20260809144451.35431-4-sreekuttan2156239@gmail.com>
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

"aca_handle_is_valid()" used inverted list-membership logic. It
returned false when "!list_empty(&handle->node)" was true, even though
a non-empty node indicates that the handle is currently registered. As
a result, registered handles were incorrectly considered invalid.

Fix "aca_handle_is_valid()" to verify that the handle is non-NULL, has a
valid mask, and is currently registered in the handle list.

Update "amdgpu_aca_get_error_data()" to reject invalid handles and
return 0 rather than "-EOPNOTSUPP". This allows global RAS queries to
safely skip non-ACA blocks without treating an unsupported block as an
error.

Additionally, use "list_del_init()" in "remove_aca_handle()" before
"aca_fini_error_cache()". Unlike "list_del()", which poisons the
removed node's pointers, "list_del_init()" reinitializes the node as an
empty list. This ensures that "aca_handle_is_valid()" recognizes the
handle as unregistered before its error cache is destroyed.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..d48f2c4d6c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 
 static bool aca_handle_is_valid(struct aca_handle *handle)
 {
-	if (!handle->mask || !list_empty(&handle->node))
-		return false;
-
-	return true;
+	return handle && handle->mask && !list_empty(&handle->node);
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
@@ -599,8 +596,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!handle || !err_data)
 		return -EINVAL;
 
-	if (aca_handle_is_valid(handle))
-		return -EOPNOTSUPP;
+	if (!aca_handle_is_valid(handle))
+		return 0;
 
 	if ((type < 0) || (!(BIT(type) & handle->mask)))
 		return  0;
@@ -716,9 +713,10 @@ static void remove_aca_handle(struct aca_handle *handle)
 {
 	struct aca_handle_manager *mgr = handle->mgr;
 
-	aca_fini_error_cache(handle);
-	list_del(&handle->node);
+	list_del_init(&handle->node);
 	mgr->nr_handles--;
+	aca_fini_error_cache(handle);
+
 }
 
 static void remove_aca_sysfs(struct aca_handle *handle)
-- 
2.54.0

