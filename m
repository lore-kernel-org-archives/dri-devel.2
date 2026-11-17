Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB54606A8BA
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=SaP5RLG1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCE010F6C3;
	Tue, 17 Nov 2026 12:50:42 +0000 (UTC)
Received: from smtpout10.mo538.mail-out.ovh.net
 (smtpout10.mo538.mail-out.ovh.net [51.210.91.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B63910E5C4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:50:35 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4jTPj51Yp0z6FGY;
 Tue, 17 Nov 2026 12:50:33 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 17 Nov 2026 12:50:32 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.178.78])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jTPj465Wzz1xp2; Tue, 17 Nov 2026 12:50:32 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 61FB48E2104; 
 Tue, 17 Nov 2026 12:50:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002a7f9e4f6-90e2-4150-b932-19985059a3b2,
 00F4D7524EDFA56606BD67631AE7EA1B984E627F) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 141.95.41.139
From: Natalie Vock <nat@pixelcluster.dev>
Date: Tue, 17 Nov 2026 13:50:07 +0100
Subject: [PATCH v2 01/10] drm/amdgpu: Remove unused parameter from
 amdgpu_vm_pte_fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-prt-explicit-sync-v2-1-bb3851cb6a0c@pixelcluster.dev>
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
x-ovh-tracer-id: 5591218938405806396
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGrAxNh0OCp/TgW8Z00538M1glw8EUMMtYMTQIkfoBlnYfE0vlSyw4w5uWuf/QyKUtvCHx7EFC1YQK9QJiefAOuQT22/RonVhgC56ibCMLxgK4dCCF83EYDfkamVxfHM+wyA0Nvvm7rS+sCNtJyY/Jb00er6pXntUGUJf0EYzZZCpUQzQXqPm/8qDoT803NDa4r5nrmdrrXIxHrrU/3K45uUM+B0+i0D8Teg3+rNFu/qNg8OzEHLmYLG3Bn2ErMgHoNASckJmPFcSnlHiSRHxWGk75pm1zRPdg06qGv5yp8rB45X+XQ8Dp2qVMqyf58e8qcwvzrNASxckuxfH4TwrY7agcpFqZtws4puYGXkKOCzHoj1xrXfRKMTavd6t0jQsywhTnP0TOmkDkX4jereRFgewxtbMoq5hDjd/XDPuEPILj3zbIOVe+nQJlXo88YnG03rmErpy2PsV2BbhKZnUaql/U/tPFYP+bRdf4Qm2QJJub8sXmDBoSnqz8iDio6uJwRSjix/tUHRRCNrrEFtmfchPitk0CuE5hTGAAjyVXshyjBui533KKu1+fjWj1UOlDK6GNfPlBfGXOerpTgcpqg4JE6WywdXd+ujgQfKWhJVFxxavZur39YKM49UGJok8u+4JK7mKNMtnr9IwsRK7rwXvjukPMf3OvgQF1LRsNHQg
DKIM-Signature: a=rsa-sha256; bh=7E3qIaNmaVz1QhOoJuZVv7W5GWmjavhGo5fWuOPFwyw=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1794919833; v=1;
 b=SaP5RLG1d/shDBVl4VVJt53my6q9bszysG7SsZ6dXGtqP8xZ4Y+GNfZmSshVcvmHotA7whEU
 SYndHkFMh+U3JOlssvNIHuivD4B/wCKf0pIjN9S/MTg3+k3kEYlclXe+tYH/NGo0ys+9y21ZW0H
 AcdjV4iPECqWp2ySvY9yoZO4pp4KckxbN5AocnAOUG96v8pRXClfxOB7wMpUESdeEfF5gysayEF
 w445Drke/24IVYmUHDD/sdhSfcwdrzzwATXQM6crI3L3q34JkcPO4BKO3LHVSi8nS7UVjo3J7bc
 MGD4t1NUuycE7gxvknctCuI2GKgY02PWSV5Hq5lrwX6ag==
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

Trivial cleanup. No functional change.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e26..4eae6a831b4ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -745,14 +745,13 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
  * @params: see amdgpu_vm_update_params definition
  * @start: first PTE to handle
  * @end: last PTE to handle
- * @flags: hw mapping flags
  * @frag: resulting fragment size
  * @frag_end: end of this fragment
  *
  * Returns the first possible fragment for the start and end address.
  */
 static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
-				   uint64_t start, uint64_t end, uint64_t flags,
+				   uint64_t start, uint64_t end,
 				   unsigned int *frag, uint64_t *frag_end)
 {
 	/**
@@ -825,8 +824,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 	int r;
 
 	/* figure out the initial fragment */
-	amdgpu_vm_pte_fragment(params, frag_start, end, flags, &frag,
-			       &frag_end);
+	amdgpu_vm_pte_fragment(params, frag_start, end, &frag, &frag_end);
 
 	/* walk over the address space and update the PTs */
 	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
@@ -932,7 +930,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			if (frag_start >= frag_end) {
 				/* figure out the next fragment */
 				amdgpu_vm_pte_fragment(params, frag_start, end,
-						       flags, &frag, &frag_end);
+						       &frag, &frag_end);
 				if (frag < shift)
 					break;
 			}

-- 
2.56.1

