Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4FCC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F1C10F2A8;
	Thu,  2 Jul 2026 10:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="iToWrsHh";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE1710F28C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 10:43:31 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6626MvDs1931364; Thu, 2 Jul 2026 11:43:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=9
 d3DFK2ES30GSYFM9u4usLVNMyRKmU0KqwT5xpaKKik=; b=iToWrsHhcx+t7m5GL
 Fy2JcU0aWCPwVQ0QBCxQaMQtZeTNTdSNd/ekeOnn/KxRMsZc7hktVEuVgnsjyRXs
 Kdj3gFwZ9v/BnX0AGSoT2LkYkl+evhfqDM4fHH9ZniOmYv+t/eXsTHX9ReCwNArj
 MUGslezVUlgoeWqitjwGKK7KILQM4UBWpNE7+fpWRb7UgELXwsk6DDOWOj58HTpX
 kO6/8deW+B2/euMJKy1aUEz3WF/7K19ARxf0FhaKwh7OlTHrWdk1XJn7/sCkNGzR
 /3zzfR16WR5jafMrZeVsOv02HFFKTOv1PqXmtlxk0bUyvlzaeirfkTDGt6ileuhQ
 DB/nQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kunakn-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 11:43:20 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 2 Jul
 2026 11:43:19 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>,
 Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260701-b4-b4-query-v2-1-a1b491387875@imgtec.com>
References: <20260701-b4-b4-query-v2-1-a1b491387875@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Fix returned size for
 DRM_IOCTL_PVR_DEV_QUERY
Message-ID: <178298899929.102946.7502055249222283682.b4-ty@imgtec.com>
Date: Thu, 2 Jul 2026 11:43:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a4640c8 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=8z9WBaoFjqkDh8H9ZXoA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: DX_KPo1I1H9UdHS1Lo0cNm6s19xc8fMP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfXznmfC7bGntUM
 LI+YWVzPIuPt68DaN5/L1yYlt9eVB1EDC6eVV5zkr3roTapIxmGxbE7ZN863dTChdFr9Badpm3m
 4dgFfQ2Cuh/JeYo1Ipr+yL+PO0k40WkEKTCEsbGsnbbd3N8jIR/8P6eZk2mIN9h2zpfh47QOS6e
 70Mj5CP4yCGzdEiqrDh5ZoLQ1WPizB8AGpq2CNwQnLKnQlWSGmZPAQaD0SHR0LBNZc0scl+QUXi
 vUQoYNK1zo2O9Vn41+SesKorXHC1H0cfBfgiWH8HHkfsRTPcRQTmfrF4YnbHn+ex9OY0VL6Ge8s
 AdwR26LTd/bq2msB7sFhDqmjGL1hj5ZnnlskivhoiHq5MCUbSkEdWO9kacvx8Yw1AIS/IS28PMr
 TL9sl5NjKuw5HE1f1fb6w1hLajWkUHOzTGcyrZzabBWH49WOQlq9JQOqTqwJ9ojosxghWkBdU2s
 ZMAQm3Ie1qVwppzJxoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX/HJgbQ7dqxdP
 gE+RzZExyTBOcre4tc6F3yQJKduOvxMtRsZ3gLqnDiaeD0W1+kiWyMYEvqUTtOvRUB1eCQRJ1Uy
 DseeiFEUORR5nWEANGV/e7d1gIz2HYs=
X-Proofpoint-GUID: DX_KPo1I1H9UdHS1Lo0cNm6s19xc8fMP
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


On Wed, 01 Jul 2026 10:49:30 +0530, Brajesh Gupta wrote:
> For a few subtypes of DRM_IOCTL_PVR_DEV_QUERY, driver was overriding
> the returned size unconditionally. This would have resulted in
> increase of reported size beyond the amount of data returned to
> userspace when args->size < size of query structure.
> 
> Updated behaviour matches with the description of
> drm_pvr_ioctl_dev_query_args.size and written byte length.
> None of the structures of DRM_IOCTL_PVR_DEV_QUERY changed after addition,
> so change will not break any compatibility with earlier version.
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Fix returned size for DRM_IOCTL_PVR_DEV_QUERY
      commit: d431b4012fd22920523dbd2806da663c1048e386

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

