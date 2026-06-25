Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B79CDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F75C10F300;
	Thu, 25 Jun 2026 14:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="NSMtUabn";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B27810F2ED;
 Thu, 25 Jun 2026 14:30:18 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P4JFRn405670; Thu, 25 Jun 2026 15:03:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=5
 Ogf5Wl3QQZvTKRAy4ITMzPaEdLMo0ILl6iyTX/9sOE=; b=NSMtUabn0lci5kpMO
 AUn3wuc/5H0a/VZn7CO2sT5aNvfH06GVUSeNeoZpFq1RIBQfUnukVGgMQcVB5m/X
 T8bCIEW/5VCmRJnS7yBXc6EpVfIctDwlAw3osrR19fvbXJYi/q/sNHnlfBjeds63
 Rz3iCqBc65G5kGBWH0Huoc6cZTEGdt9b89MIa/RiTDESM83Zv366bFCiqVO/W2nL
 bXa04eSlninGjUeonqkRaTfbhXk1YhP+afv5DXf7mFlgngmYccTPZjki03EBiX//
 h8FjPnAhPlffzhEfDc5Xa2Mn9iS21t10Byv1jsVw2JTHOF7frsVZiv3CIGcphZyh
 PTpgQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f0t728jce-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 15:03:47 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.185) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 25 Jun
 2026 15:03:46 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 25 Jun 2026 15:03:38 +0100
Subject: [PATCH 2/3] MAINTAINERS: Update imagination maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260625-maintainer-updates-v1-2-35112b2f038e@imgtec.com>
References: <20260625-maintainer-updates-v1-0-35112b2f038e@imgtec.com>
In-Reply-To: <20260625-maintainer-updates-v1-0-35112b2f038e@imgtec.com>
To: <imagination@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>, Alexandru Dadu
 <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 Matt Coster <matt.coster@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=matt.coster@imgtec.com; 
 h=from:subject:message-id;
 bh=273UYrDZLPZRLdQE9gl9FKkhwcDVtVsSfuVQnIfzmlo=; 
 b=owGbwMvMwCVWuUfy8817WRsYT6slMWTZmjq8+uCnbiXy8W9WgN8ih4A31+d1f404KbR1+zGpM
 2+eppSndZSyMIhxMciKKbLsWGG5Qu2PmpbEjV/FMHNYmUCGMHBxCsBEfHYyMqyPrpq/K2PZbxmX
 XY0fm/bv9G3pidjWZ/Ur+pf9R2eu8K+MDIsT99zkfRKn+v7t1bel1qdfF/d8+VX9lTu7t2mJdsA
 qLSYA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.4.185]
X-Proofpoint-ORIG-GUID: uETB7RQCPe1RhS5WYL2R2dKPQBKMS_gC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMCBTYWx0ZWRfX8+oXo2FtpFrm
 zRyczMqvwnV/BPKORQ+mLLIcdW/IxdyLki1vaKXGKxBxxj26xUl4ikwKp4A8Y1FyGyJxu5iGJkq
 AFgCBXYDUxk1xPZDh2m2DhgzqhUD9dM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMCBTYWx0ZWRfXzRRe6HiSypAh
 Pg1EmW3XfRYL6uU3h2y5quOPyewzH42Zn2IJJyjCBLO8hEw6rMAV2nALg4wxRhUtDN6fUYLVGos
 yCwDbBiLvqXr/P0VGuZQM8WNmpUNNVBp+Wwoqm8G2Ifl/XvCKeGlXNtnWSO3Lr3/6KW4XjvY8Dy
 qNMl3NMxIY4CQ9P9KMf/YzMBJizD2RB6LkdRWpFb5h9UTDjkcCda5QhKM2bBd57qbxuiCHFoA5g
 MwqDJHxivU7f5MVjUnM503Vob3peVZRAW/HefKMPdRxmgew1mgqMb0r0YrsD3muaOZyIaOXag7o
 9AVwyPZ0vYdyjwFdoXfJ0pKEN519pScsw4I3OYCeRKGIyu9pWhk0JPXcBsmGOASO7SqK85Qym8b
 2QCNRSJW4INjHMQY5e5zkyE+/1LpvmSginrlEzID+717EdP9XFuK0fl7i1O9iiW8LQwo3KkMq9V
 xHq0p2Z8e4C0thizGFg==
X-Authority-Analysis: v=2.4 cv=ee0NubEH c=1 sm=1 tr=0 ts=6a3d3543 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=e416AD1ZbSsA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=e5mUnYsNAAAA:8 a=r_1tXGB3AAAA:8 a=iCmMkxMm0QhFShkxjzEA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: uETB7RQCPe1RhS5WYL2R2dKPQBKMS_gC
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

New people are taking up maintainership roles within the team.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b45e60524762..fe02d1087ab2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12567,8 +12567,9 @@ S:	Orphan
 F:	drivers/media/rc/img-ir/
 
 IMGTEC POWERVR DRM DRIVER
-M:	Frank Binns <frank.binns@imgtec.com>
 M:	Matt Coster <matt.coster@imgtec.com>
+M:	Alessio Belle <alessio.belle@imgtec.com>
+M:	Luigi Santivetti <luigi.santivetti@imgtec.com>
 L:	imagination@lists.freedesktop.org
 S:	Supported
 Q:	https://patchwork.freedesktop.org/project/imagination/list/

-- 
2.48.1

