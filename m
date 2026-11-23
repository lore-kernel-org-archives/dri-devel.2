Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DC606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=SMDAfiRw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F204310F335;
	Tue, 24 Nov 2026 08:43:38 +0000 (UTC)
X-Greylist: delayed 1197 seconds by postgrey-1.36 at gabe;
 Mon, 23 Nov 2026 23:50:19 UTC
Received: from 14.mo582.mail-out.ovh.net (14.mo582.mail-out.ovh.net
 [46.105.56.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B352B10EB80
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:50:19 +0000 (UTC)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.110.43.45])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4jYMCY03l3z5wng
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:12:09 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-n2gw4 (unknown [10.110.113.233])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 66D91C237A;
 Mon, 23 Nov 2026 23:12:08 +0000 (UTC)
Received: from medichon.fr ([37.59.142.112])
 by ghost-submission-7ccd8bbbb6-n2gw4 with ESMTPSA
 id d6SJDEjIBGt/6wwAptLdCg
 (envelope-from <abo@medichon.fr>); Mon, 23 Nov 2026 23:12:08 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S00638d761f2-16f0-4401-94fc-3894c6c03bea,
 37CCA9C64979178E7EE002A225CEC70DC41E3CED) smtp.auth=abo@medichon.fr
X-OVh-ClientIp: 88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH] drm/amdgpu: fix string format compiler warning in
 jpeg_v2_5_sw_init
Date: Tue, 24 Nov 2026 00:11:50 +0100
Message-ID: <20261123231150.26328-1-abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14431785008803896926
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFbv8Ldzvhjq6+ciFMpsxrcpPjt60g7zCvbjwdf5C9XrNRXRGWKvQjxaiWrFuBi98y8/hSDDh39MxgUMpAYWP1cyffaS5H3EKPZAwQC7OFLQTo93N6TWT178JtPG2Jko4z4tFM8cgUmn/UKN0i0xuGyAg4rIzlf/rBCQ7CQyfBWXWGxOmLuoPfd/4kVctJbSLFAzwgLvoqK+1IxNbQSGFFi3ICXNt+iQDuSAIPfM/ojc6z4ibnYg/pXbwnsHUOsLil/nPgjjQv0Mdlur+BLVHicRIZOXCU0r6ZLEIn6qkpihRXaJcFZrgXNSt7wuz0ID6IUhGEeWT4w1sGxapGf94S0iKlEUnRASU7T5bmB3awT7FjsmKCFVmUA9euxp3NR5wDxCJiLaeMl5WL1F61bsDC+RYfhfCwJalSa2BQBi6eGCZH7Bgki002xF4NhDPCpLae8U6tWx2d4f+ZWf1XgzmFNwF+bqO347hWsN2zV1ZhZOvZ8n/5Zk9pujuM+rnr1mLj7+3LTqzOmFJltBl1ZyRTC/Nbv/9YzY+J3w+e3eGWOePEesmm7FE3z/izcgs4J1V+g9Cbu+gjf+uhBJ2Vnx+yM6LkKAQPCKZhOh07tb9O3SrdrDQFZz7JLdvFI+8AI5MDyy/jGiqgr/bl6OOnWogQENuCUcb0XjnlGZtVhvwKjUQ
DKIM-Signature: a=rsa-sha256; bh=YqtWFMi4WX+Edietr0UX7f8ovLfKQkVWxUMWNsH9G38=; 
 c=relaxed/relaxed; d=medichon.fr; h=From;
 s=ovhmo3801317-selector1; t=1795475529; v=1;
 b=SMDAfiRwD7nVJpElGrU3/XJt+MWYPd3bwSNFM2n/hONg83J7CTUiLwNvYAi4nWoTYmwCDNf5
 qo8UkIfNY9XAXIvwUXArybW9j0pYipilp33uKCx5PULQefPXHU42LEFLWfy/eYiJBBN3YvmVIK0
 TLQrWnNsLUEorl3QkwvqMvID7xE2xTZ6sgt1OjnDKLx6vC4PusTxIcHp6KqtQ0KJI1+59cEQTWu
 IWBjFBniR3QvVFZ8wkizy7x1rgi9SDjPMVroAuhHUYlippu2wjI5WAvdk+cM1WjuD7hDry9Yr5N
 1d7iywxreVryy65mXF4yzSmu9Zls7sQwD/5X9Be0p3Qfg==
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When doing sw initialization of JPEG for v2.5, the formatting function
snprintf is used with format string "jpeg_dec_%d", where d refers to the
instance index of type int. This leads to the following compiler warning
with several GCC versions as the compiler is unable to derive a safe
upper bound for the formatted index size:

drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c: In function ‘jpeg_v2_5_sw_init’:
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:68: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                                                                    ^~
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:58: note: directive argument in the range [-2147483641, 254]
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                                                          ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since no VCN block seems to have more than 64 JPEG instances, it is safe
to change the format specifier to %hd which fixes the warning and allows
to build the driver with CONFIG_DRM_AMDGPU_WERROR enabled.

Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 966a8a7f28ee..e2ba58cbff5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -149,7 +149,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
-		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
+		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%hd", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
 				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
-- 
2.53.0

