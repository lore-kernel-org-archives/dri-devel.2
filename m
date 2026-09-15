Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315ACC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9802B10FC13;
	Tue, 15 Sep 2026 12:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDQxxHON";
	dkim-atps=neutral
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC6410FC13
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:14:26 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id
 2adb3069b0e04-5b76694fb7aso729699e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789474464; x=1790079264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hT109/DKD8D3ImrzvgTZ3A2CRXv9GUhxcQttm3TUwyQ=;
 b=hDQxxHONauGGsgYgKg+NR58zgeQNy2X82s/K4l9I7AdUABc+gEHDyiez5IuATTEo+E
 DTTk3ObigaJQinQePrM28oUEttvPuyZm8GJPrZyb7ueV8FaootknCrHoxR+hjmWnCUUe
 M//iPTklXoWeEjTlYLSRFd6/rFjb+0ANrkeHBlrts5zP7iW5T7ufbSnwK83jK1zImyJW
 nIqQUHgeplUlxScpgSveG2mymOO0EWfYR3JLuzkjnpnFFUrqpmpk2SYZGYX6HNLZmIAo
 aLnpSGNpENNjykr1SvD7ttci0ZmL9i0CnCuQWJ0NOAQgM9WS3T3IyYxzaOldKG5h1t3v
 v41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789474464; x=1790079264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hT109/DKD8D3ImrzvgTZ3A2CRXv9GUhxcQttm3TUwyQ=;
 b=VmxvglYczjHD/MO+eMhrUx7rhBsJRBOZhW9aDDD3+KmyJarHL/FFV71wGefmR519f6
 RH9yels46CyvV9sejeYLxXDj6eaQUvaaYoWDVmP5K/haEjmyeT9LqPk73oX8O2xlcVVZ
 yaAthXg82wPxCpa6q+YPnoaQRrJrAWMx16npmNol9MF2LImSngF+FT8nzKBunc8gJZr8
 1ctelsI5jXJ0p82QSVB8R1ZxnRxwFVdsaSMbtZPhm2iwifmC10kRo6aeUkJM+XfFZBWL
 xCujcXSgd/KiMyH2kV3D6TK0ySBdOmcau2N+DW/D6uo7jcuZgmFnzRv+PbM1WMXv///c
 sMuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+TwaqPEC/MSsmZtf60EIrQoHNs7c9/FJuW4IBGTDfHB86SfhSikWrXK+5oeKkYjtdpmEAhEdD6rI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++khgEEkrrtbxASQtFlgDkhjQEGo7HrqsELrB3C/bUPKdFyKT1nM
 2vdEpnctAuWbMuWJOgXf4wUIdcnaUdGuXOw1mUvuaTvdX+HijEK87950
X-Gm-Gg: AYBFou3fOq+r1TSQRNC8VvrOB4ajYPmI09IaB+OQZdyG0TDNO/MMFVhIaF2RIuuhctF
 JgUI6MKPIofR/2YVO8iLzC+CEIxIkHDlb7cwkMsLz/E4xHn32KEiuKD+zatn3TqgTNGnVTeL7lc
 rq4vhOoDMOopFxKwEbdMjHQ9ftQRnoawL01mMtxsArkvkCZob3N+IbMVtRUkSi1gYVno+dJkXz5
 74Fp2UlxcOvu7rwL454WjuwnapEc9oryA96IsxLfZifqqX9OZugVcWM+ZK/4Vs13l8EdEN9wevk
 prxSBEQr1tfjmZxJQVsFNVMYN1Fu/YMPbVOGGAs8gHW0OC3HJjrQGRbKlxnaLn/i5hICM5QLZDY
 aQU6qwImbj9ThQ0DqEnu0Xhxdcb4t3TQYG3U7s8jtHplogLR6bvooriS+ORM+TzXyit6aOyyjWY
 XTLnajypuvQnlb4uAD5U7DUV5rFEXjmUj2wuhJGWTg/Xj2/mati8L99o6bC8xhL4NqGDgEutyEA
 eASs7wfA9AFOXkK
X-Received: by 2002:a05:6512:6ce:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b8b29d4641mr846404e87.0.1789474464385; 
 Tue, 15 Sep 2026 05:14:24 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b3a58fdasm446114e87.12.2026.09.15.05.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:14:24 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Oded Gabbay <oded.gabbay@gmail.com>,
 Kent Russell <kent.russell@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH 5.10] drm/amdkfd: Check for null pointer after calling kmemdup
Date: Tue, 15 Sep 2026 15:14:03 +0300
Message-ID: <20260915121405.107068-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

commit abfaf0eee97925905e742aa3b0b72e04a918fa9e upstream.

As the possible failure of the allocation, kmemdup() may return NULL
pointer.
Therefore, it should be better to check the 'props2' in order to prevent
the dereference of NULL pointer.

Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2022-3108

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 86b4dadf772e..02e3c650ed1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -408,6 +408,9 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			return -ENODEV;
 		/* same everything but the other direction */
 		props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
+		if (!props2)
+			return -ENOMEM;
+
 		props2->node_from = id_to;
 		props2->node_to = id_from;
 		props2->kobj = NULL;
-- 
2.53.0

