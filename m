Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC660A2630
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=pdWZLD5n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA5610F52F;
	Mon,  9 Nov 2026 20:36:24 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1B910E8D0;
 Mon,  9 Nov 2026 20:36:15 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A9Jxrvm3422877; Mon, 9 Nov 2026 20:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=+qwa/QpSDJbuRk4RrmcNdhE
 SzchNoi7TdB6SsEyKC3I=; b=pdWZLD5nWz69Z+7KSyG4/GXpVXznQFxCdBmkPh3
 beOPJnxPjXT5H8NhUli4en59hMk7gHnveWac6wGgB4kYf6i+qf/vZth17I/zMVHZ
 dvYMpk9stFqB+pqmahkqaouugmHT7Thdky0WHiGR7isatEOqVk+RTxKuHeyV238v
 6+eMk8tQe7cbdCJrkU6TKjpKFm7R18w1Nnr6z2WBne6kEWpop74eOvAG0pEs41YA
 Bdhm15BJ8q8a072mfa8DHq/N1O3kIGl48fxqMNL80qd5nG56qdoCspTm3yTNfBxL
 4RHisxVSRUaY9Dk3q1rvatzu6+giObkZuYU2xyRjlpOdLkg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx1tk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 09 Nov 2026 20:36:05 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 20:36:04 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Subject: [PATCH v2 0/2] drm/imagination: improve UAPI heap and static areas
 query ioctls
Date: Mon, 9 Nov 2026 20:35:20 +0000
Message-ID: <20261109-ioctl-query-count-stride-fixes-v2-0-228ea0e28dc3@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgu8moC/42OQQ6CMBBFr0Jm7RhaCaIr72FYyHQKY5RqW4iEc
 HcLXsDly/95/88Q2AsHOGczeB4liOsT6F0G1N36llFMYtC5LpXKCxRH8YHvgf2E5IY+YoheDKO
 VDwcsDk1hrCZtqYIkeXneguS41j8OQ3Nniqt1bXQSovPT9mBUa+/vsVFhjrqxVWnMkaw+XeTZR
 qY9uSfUy7J8AQV4oCDfAAAA
X-Change-ID: 20261104-ioctl-query-count-stride-fixes-43b4df2c2fc8
To: Alessio Belle <alessio.belle@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794256564; l=1757;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=AhKY/e+/K31ucN7ZgOqLo5iQOyRSxGxgR9Iewoj9sLc=;
 b=E2LwqUxj8yEu6GwwdjBkPR0WhQpEY22ENV+nH5igiQScUQ9UcqJieHs6Sf15rFhmRkuSc2M1l
 l+fgZkSk1nFBMLCqrvm5XOsmDHyfREiClPUUb6MJbCONSYr7w5UqeAz
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfXx5Fr/tn7zpOt
 xqwUV6Ii6tx772kloqs7V/j9I1MpGLodMkji7okx42NS72H3xsF460jH43MSoQQwJ34VmC62WG4
 z+3Pl8Ki+PZRJ/X6Y9CVclIo/CRATMU=
X-Proofpoint-ORIG-GUID: Q2_NQMvh7IlA0kTA7kWotLqcdzYrU6Al
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af22eb5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=e5mUnYsNAAAA:8 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=lIUuuAuNjz2pWeUZIKMA:9
 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX58SVUuQKU2uK
 sE3fqrA0gUbGkKGaxLOYrdkyLJGnpcrjsxKyv/eF4alSNYiRtasKJhmEDYMkcISOVF5iQXVGXCL
 7lp2VzEoYQvbtQhpxhdPMYY+SFDUxH545uDBDo/X7DWuK+XnJB+G8GF5UW8XXOiym1fv4xth4om
 1rVm9ySygVhawkO5sP7st88XzBV7MsWE76PzgWYmTGIxw/2EjK1BMCKcETKpaHeBGFsTpR5Gon2
 CUeiABiixkur/qzkw27geTCNTtEMWLm475zFClB0CPBICpxL9o5qO6cZeAJdNLK4UUOhCpcyc5V
 pAoZ6KdCs1vzj3jFqbQ2JQbSxCtOqQzlXI76A9wW6lITpxImaX8UdWo4ipQgMh2FyOtzgXdnPf+
 Vg14f1W+tLtkYKVJQEviDNOhNEfU1B0Km/ZtC9xR8lPz8IdKlO/BSLOlB3DQh5GePrK7D60fDF7
 MVgMW0yrDln22tpQXow==
X-Proofpoint-GUID: Q2_NQMvh7IlA0kTA7kWotLqcdzYrU6Al
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

This series is about better protecting userspace when either one of the
heap or the static data areas query IOCTL is made as we go forward and
extend the UAPI introducing new heaps or new fields to their related
data types.

Please refer to each patch commit message which describes in some detail
the nature of the issue and the solution for it.

In general terms this series makes the UAPI more flexible, introducing a
distinction between a legacy (or minimum) and a current (or maximum) value
for both the stride and the count that is returned to userspace.

With the new pattern in place, an older[*] version of userspace defaults
to requesting and to obtaining the legacy (or minimum) value of both stride
and count and this makes safe to update their maximum value going forward.

[*] before https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/44456

Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
Changes in v2:
- Rebase on drm-misc-next only
- Link to v1: https://patch.msgid.link/20261104-ioctl-query-count-stride-fixes-v1-0-2bf86dd7cf29@imgtec.com

---
Luigi Santivetti (2):
      drm/imagination: clamp stride of heaps and static areas for legacy UM
      drm/imagination: clamp count of heaps and static areas for legacy UM

 drivers/gpu/drm/imagination/pvr_drv.h | 33 ++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_vm.c  | 32 ++++++++++++++++++---
 include/uapi/drm/pvr_drm.h            | 53 +++++++++++++++++++++++++++++++----
 3 files changed, 108 insertions(+), 10 deletions(-)
---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261104-ioctl-query-count-stride-fixes-43b4df2c2fc8

Best regards,
--  
Luigi Santivetti <luigi.santivetti@imgtec.com>

