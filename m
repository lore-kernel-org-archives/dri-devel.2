Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F5606A88C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=e/AoHiFX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E9F10F6D1;
	Tue, 17 Nov 2026 12:51:15 +0000 (UTC)
Received: from smtpout5.mo540.mail-out.ovh.net
 (smtpout5.mo540.mail-out.ovh.net [51.210.91.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED9910F6AC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:50:43 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4jTPjF642Yz458C;
 Tue, 17 Nov 2026 12:50:41 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 17 Nov 2026 12:50:41 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.164.208])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jTPjF5CRvz6Mcl; Tue, 17 Nov 2026 12:50:41 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 37F278E2104; 
 Tue, 17 Nov 2026 12:50:40 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002e72ce295-6303-4761-9ac8-396144a4a0d9,
 00F4D7524EDFA56606BD67631AE7EA1B984E627F) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 141.95.41.139
From: Natalie Vock <nat@pixelcluster.dev>
Date: Tue, 17 Nov 2026 13:50:14 +0100
Subject: [PATCH v2 08/10] drm/amdgpu: Only reject conflicting mappings if
 they are not cleared
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-prt-explicit-sync-v2-8-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
In-Reply-To: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 5593752213594399036
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFzrqAtohLkNGuEsTTEjYMhBXNnnBHtHlXr82nHvl74y1Ds4tD6gdWQIaN6znA7Kc2nICootiOIoSAJoKcVZ8rp5U8FkQRKMJum8l1ZxWsZwER5yGYoBenENgWUQWXXug7JLluPG10KRnjqE0Kl5lyuRTL9VhZuq0e3C3svIXTECxKlIwNHUYB90fgRdOu4jmnRBd7K89RJpSkmSRbgHrKuLzypMaeM+5cWGVoEQ6oTTWmE0xsU1QcbwOiOtQDCa9y79/2I+WiEsDNrVYvE13m5UVyUDABHZc4Hc/c4Jw8MovzmfFeZ3jJoX2OJg+vRzVsjxv9Bo6Lkb7OTIXt6tahruBKSJXd1frBCMIUtoQCy+C7504Jy32p+6lzhWbfMdskv3EcOtwx7pv2ZuAbVwEKrtp3lLzlmcdfWCXL+s0Wsov8JUbBWyNFm5BENBh5zzCUCUqBMp66At9dJEPpil4+I9kr3JOlAoKavRNj/zDiny3xUiESkrZMk8ZGilLmHFXLPF9j3cVIQ6jcPJz+mfeVEiNKYhdHFYKNhnZoloCLrwzxolT1bmYc3fkUCVF+N4n3+n/ZPrF0ZYaCf4Uk8nNaUpBxxssLk7sh51aMp6kIV096rw/8hgcz3pogLUG6R74AptXZrBUDOJtkmlC8KX2HNMC8a2IA12wvOzRg0/QkA/w
DKIM-Signature: a=rsa-sha256; bh=oKG8bZbPJkZqBB4dDTMC1BMdSM/9p9YYhbNghdpN2KI=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1794919841; v=1;
 b=e/AoHiFXGZpzcdjJ76XVs4FBFFWRFEVI+sDCpAIvVgzycjmVBOR1l54f6rMRJO6CGDywUpdS
 e43l13Ahpb8iA91VYFCgOq8mJcmrJLAdqCwrSZ9Y0KCkR906JpescoTq7agESVyarJst8SGv4GF
 0KqfzVMYSFslFnoS+IICkfjsPoqA9l9gHDyXCCZzJVvUDbH0jWOct/4c9I3FK59g5EOm+7ov8dE
 dGbSL3NW+3nC/AaUG3BY3d2jPvzW4U2Mk9DJfaOcpCLohC390H8N3UjTF0hdnU3Aiv318pThtk/
 BxSSHl0+xfYTFQOBZac5FJ1JLHRQMoQ3tHD3CQzB89lVQ==
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

Cleared mappings will not immediately disappear from the VM interval
tree, instead they will be in a pending list. For the REPLACE_MAPPING
op to work correctly, skip rejecting these conflicts as they will be
properly resolved later.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ac4a1ed9b1196..491f4b50f7602 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2241,7 +2241,7 @@ int amdgpu_vm_bo_map(struct amdgpu_vm_update_ctx *ctx,
 	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
-	if (tmp) {
+	if (tmp && list_empty(&tmp->pending_list)) {
 		/* bo and tmp overlap, invalid addr */
 		dev_err(ctx->adev->dev,
 			"bo %p va 0x%010Lx-0x%010Lx conflict with "

-- 
2.56.1

