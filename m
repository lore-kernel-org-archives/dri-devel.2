Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0ED606B219
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=LAe47/dh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7044B10E214;
	Wed,  4 Nov 2026 18:09:20 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C4810E567;
 Wed,  4 Nov 2026 18:09:13 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FobEo1657645; Wed, 4 Nov 2026 18:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=pjNsJuSyk+KdbCQYEO9VeI9
 WWox/RTBAHSmTb6zQJyM=; b=LAe47/dhSBhE5lUOSiImuv7IyUS8QRSs/0//D5z
 NCTBC/qCU5cjPhzBNhVF3RUfJgSv+ZNCE/uvp5EAmrZQOrfBS6cMhZY9p2qEAzHI
 xBb95QuWfM50dSqc5p/NAxZWqcVE8y4XVORDZhua5ZmsDr8rQSdwgaj9M8fk1Tna
 Ut3Q2UPl460g1mgNm0pbd+Vbdm1uub+oh1dSs4Vs4TqFsCUxSoSm1UHKlukjAoOq
 dW9hY+QxghPtS9x/f32dvfNrvXO84c3QUuWTcmzijbR1wRSMfAtOQDqtypMnaKoa
 pnIsHyE0j/2m7fnepzAujauJsh4EWNM4+clnU+G79648eLQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99wkmed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 18:09:04 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 18:09:03 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: improve UAPI heap and static areas
 query ioctls
Date: Wed, 4 Nov 2026 18:08:13 +0000
Message-ID: <20261104-ioctl-query-count-stride-fixes-v1-0-2bf86dd7cf29@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1062oC/yXMQQoCMQxA0asMWRuY1iLiVcSFk6YakVaTdlCGu
 btVl48PfwFjFTY4DAsoz2JScofbDEDXc74wSuwGP/qdc2NAKVTv+Gysb6TSckWrKpExyYsNw3Y
 KMXnyifbQJw/lX+iP4+lva9ONqX6vsK4fCeHHnIIAAAA=
X-Change-ID: 20261104-ioctl-query-count-stride-fixes-43b4df2c2fc8
To: Alessio Belle <alessio.belle@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793815743; l=1593;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=xQyPxfd4QGmnSCNzsGAIyncGyvz89flV5K4WdxnoUtQ=;
 b=vURyLlXd1KbmpdGbNbV0E/f4Y5JsIdy0/d5KRvc9lxpE3cEkMrBct7urdbDXlkRYT/I3B4YKO
 YOjVf3518MjDM/++S0/zOHN1DPIWHyEKnuJO6KaX6SdQTF6wwcz3nn2
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MiBTYWx0ZWRfXw54tsl+tYKw1
 oBRookO87fdFX1Hx7/hylm2AowTbKY/HzxYN6bRNB6wURci30vkalkglQXnkOU34cM9deBfkrsO
 AUaIYhSIdij8Zt2xoHuhoKsrQDwx+c9Z55Ms2snI/YNGuD25ory2JFf0pW2TACPgXGfulQpHnSP
 CRew19/C0f1pfde5bf4xSSKp9S089RSUww+FqOiEjVnMqAVq3nnrulOS1dNbNmApPgiQqIYB5TB
 UjDorXYGuOnAI/nLy+CLElxHPameANxRdXyWMvzfUwD2MLntFr/72rdnzvYu7GwjT+VJ0SZVY6G
 MLK9diAwzhdfr4uyBVR6yx3VpoZtBHYJrNwwEhZ9cUF8wXQwzuIYQjp0F6WNrrko0NGr+Lk+Jhy
 MYuflhFLGWAhyAjT0HX567knzp9Gi2poM9xRYOGgj9iDLuhspVvOpudhR38amUSMT2380KCPz6J
 D51wwMYmH9csW6hBfDA==
X-Proofpoint-ORIG-GUID: -17OB5HslvA0FV_h0hOc548wq19sqg57
X-Proofpoint-GUID: -17OB5HslvA0FV_h0hOc548wq19sqg57
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6aeb74c0 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=e5mUnYsNAAAA:8 a=r_1tXGB3AAAA:8 a=lIUuuAuNjz2pWeUZIKMA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MiBTYWx0ZWRfX9wjciJamEXhT
 pkO21RaAz0XrFhPnDCX2ndvhl4ayRLKMLMb18Oo6JDQF/SF3W6/Vy2h4wFaKved5aLv7/UNd/Gn
 +SR2nL7LX7TMI5NbqhMw3SrqO/4PFdM=
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
Luigi Santivetti (2):
      drm/imagination: clamp stride of heaps and static areas for legacy UM
      drm/imagination: clamp count of heaps and static areas for legacy UM

 drivers/gpu/drm/imagination/pvr_drv.h | 33 ++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_vm.c  | 32 ++++++++++++++++++---
 include/uapi/drm/pvr_drm.h            | 53 +++++++++++++++++++++++++++++++----
 3 files changed, 108 insertions(+), 10 deletions(-)
---
base-commit: 33ed26235db93162935d1719bc6f538c384a2fd8
change-id: 20261104-ioctl-query-count-stride-fixes-43b4df2c2fc8

Best regards,
--  
Luigi Santivetti <luigi.santivetti@imgtec.com>

