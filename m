Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD36076344
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=JUAPggCd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F6C10FE3B;
	Wed,  4 Nov 2026 19:29:24 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6B610FE39;
 Wed,  4 Nov 2026 19:29:17 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4IQOql1937786; Wed, 4 Nov 2026 19:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=v
 j63XZjrRsBLKMwj5zFh117oEylSKYjK6R9AqrAcI+E=; b=JUAPggCduijanZUKj
 KhycSTXxKmeIj5zKlObn3OmwCCXq07WxiIWnd0Q0LtySMSGWEFPWK8Ltx6dI1NVf
 rOFt2bFGsG2Yki6bfVyyX4e8F6h+yB5WhwVHaGrleUfVnFS6fk39/HEN7yBQHKUI
 UYNUrWmwGhQztT5z0vJm3SkMJFw8OTiHhXfWBbN46eANIko3B1XzX5nSQxG06VrF
 fiVhA2jjoQY2p9bdzxg8OWP9r5sDpTcTJNOjkjdJv78J8xGlHHzHMbxX4xaADQi+
 qpE+aO2kNf59Z0NATCbEIujFCs5k01lA3LAivu8M/iR2FJ0sz85aFaabv9K65i13
 mbQiw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99wkp2c-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 19:29:07 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 19:29:06 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Wed, 4 Nov 2026 19:28:17 +0000
Subject: [PATCH 2/2] drm/imagination: drop unused arg in
 free_list_create_fw_structure()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-minor-improvements-v1-2-cc976128538e@imgtec.com>
References: <20261104-minor-improvements-v1-0-cc976128538e@imgtec.com>
In-Reply-To: <20261104-minor-improvements-v1-0-cc976128538e@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793820545; l=1108;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=vELnxPJbq4O7mrL+U3yTA1RXjiHosyK+YmMBxB9BLOc=;
 b=9NPEMbI3uNivRFannGQ5fVeBRpdLcWpf6F7a+gN4lc9Mye5tGNv7RXEzz18Bhxj9nN2BevnWv
 zKdRXMfV3UtB5o2qHnbCioWkE8OGAHW43o4SsGxNQAS47L4oL/j890t
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NyBTYWx0ZWRfX8I3GmfzXYFI6
 MeqvnqGLS39r2Gh8LVUG3Ri5bqzlbo/xFZcK5nsK77AhDehEeCwXhsKDTF/vrUhkB0MLLplMJd+
 R0hP/gvGO0Q5d8e4Aa65iJMZg0jyAxrxT3psGdUMEOxF4XinEoaUZhU8/+E2nyHOmQ52/38BOW6
 ytPHmN635kFBWrcuzT0zDt7po8woTF9VEukxGa5CVPE0Hfehl7wjZj7yOOh9NbTw4LgGxIMy9uy
 bfv3Yg4OJjTBphcYqwzxOA9fi+5E3+0LJ5+nhRej7p9ZD3HydixjhNg52A07gPKZfy/pdTcKR5L
 YCUCnvd5c9CNyTdNg8d2QyfxZ44XwdAs5bqvMuPjU5ERCsbFfyKHGMtOZSlDTH7MBxk/oL1mdlS
 bMORhVxu+BPKrpKn63r/iuKiYZgWFkQBtPq+XqQK32dC8mwPKrsHw5HGWUpCVDe8YsUTNMy1gG0
 3pL2grV4OCTxsn/Cj9g==
X-Proofpoint-ORIG-GUID: gXpXMNhn_2M-PpkWMOtQ7kpsP-GGM4do
X-Proofpoint-GUID: gXpXMNhn_2M-PpkWMOtQ7kpsP-GGM4do
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6aeb8783 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=tz9w47gtXuNVomUU-VMA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NyBTYWx0ZWRfX58Bn2t0LqBxI
 Mh3AD0eC/tOOw1LXP0sGieMmlR3bi2a/CYrHd8oJLalmRAX2190ZvgYkzoz4m2AdJfZc0DsIIjA
 oesCeHLOpdZaaYRRbAEH3LJD/24NoNo=
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

free_list_create_fw_structure() doesn't need nor use the ioctl arguments.

Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_free_list.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/drm/imagination/pvr_free_list.c
index ec02fbbe0168..5ad262ee24f1 100644
--- a/drivers/gpu/drm/imagination/pvr_free_list.c
+++ b/drivers/gpu/drm/imagination/pvr_free_list.c
@@ -193,7 +193,6 @@ free_list_fw_init(void *cpu_ptr, void *priv)
 
 static int
 free_list_create_fw_structure(struct pvr_file *pvr_file,
-			      struct drm_pvr_ioctl_create_free_list_args *args,
 			      struct pvr_free_list *free_list)
 {
 	struct pvr_device *pvr_dev = pvr_file->pvr_dev;
@@ -443,7 +442,7 @@ pvr_free_list_create(struct pvr_file *pvr_file,
 	if (err)
 		goto err_destroy_kernel_structure;
 
-	err = free_list_create_fw_structure(pvr_file, args, free_list);
+	err = free_list_create_fw_structure(pvr_file, free_list);
 	if (err < 0)
 		goto err_free_fw_id;
 

-- 
2.43.0

