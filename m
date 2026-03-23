Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6539CF4613B
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C129110E06C;
	Mon, 23 Mar 2026 15:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="SrVT868X";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E61210E043
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:14:22 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NDMQhq3740823; Mon, 23 Mar 2026 15:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=e
 LLIOSNlhFrN3uw67tNtIMm0sd2yew/T1IZnF79EgtM=; b=SrVT868X2e6GGjSJK
 ssdXR6ERfHDagENVhyUkNwEvVIBFeEQ44XP/C80DYT8QqvjzhP7RX5FbvuB9PYzS
 yHqcPXY5EBj9Jdd7H9lUwntLLxOlhEexu3RLlH9tGGnbUlZIRZ7et7yrqVimEI7/
 mtztLcGQ8HcW+2ZV0rN/TXrGSGZQQQ+gq4/0hJEvabHoz5dPMJbtqIhWRiZ6liSp
 ipv3BqCuu0jfx7I3aoDjk4QRxxWZmTH+Lf4Hi86O7yaAYTWpyOFGXUgfmM5ufLSu
 OjiBFRyWk5uw/PchliiAl2OmlOMaZDQj6mfgklbjKrGoQYGfDuYpizpzGEFIdV7M
 Eu84w==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4d1m9v1tt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 15:14:04 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 23 Mar
 2026 15:14:03 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:13:53 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
References: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
Subject: Re: [PATCH v2 0/2] drm/imagination: Improve power off sequence
Message-ID: <177427883311.5888.856167998023902743.b4-ty@b4>
Date: Mon, 23 Mar 2026 15:13:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Originating-IP: [172.25.4.249]
X-Authority-Analysis: v=2.4 cv=OeWVzxTY c=1 sm=1 tr=0 ts=69c158bc cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=gXNtStLRdRagsmVLQjQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNyBTYWx0ZWRfX8JqCYE+hH8b6
 B8fKhVPkxeRk79qXDxOBfeuT4zY44srArq3Ya1umYJgtao66v3wTjESkkOG756LiLi6epHkvwL2
 6PlqLI4Lowy/kB6rFJORnCiP3AhTyCq1h4PZOdVlOkJ2Ztatd4JAeINAwfpMbBEdkrVUddBHdh9
 S47YfZspUii+6DvPkMo3xkgWpg0tqcM33r1qdkDdVIxCxxiF6CCwi6xvqEovwbDRz4xtqjYjVxR
 VBA5i3q2vvb1vAkCwc52SOKPcB+0ldOqmZrkQ50Fo5fWSxlVx/zdODD49SmHkUJvCTBy2RsstgO
 pDp9HWEyt+6A6L0DvlbJYJ3O4WIIeN3nQxcxB3RBYV42sH2vrQMPsGVPl7vMUGTprm0A3myHRd1
 7NMsLfUIe5wQb4AbDvGjc9Jy3n2M6hqDtyCKWmRDziT8AMNHdjx51xcLJuYyl+LIi+TBZg/PHCL
 P+2JW44v4EGG9zH/ekw==
X-Proofpoint-GUID: WYaE7SaEYwVa11_eGhUNT8vOWdsQwGKT
X-Proofpoint-ORIG-GUID: WYaE7SaEYwVa11_eGhUNT8vOWdsQwGKT
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


On Fri, 13 Mar 2026 06:38:23 +0000, Brajesh Gupta wrote:
> 


Applied, thanks!

[1/2] drm/imagination: Improve firmware power off for layout_mars config
      commit: 51e39ceeca7e85a3b9ca533502a404eb5f3b0f02
[2/2] drm/imagination: Skip 2nd thread DM association for non META Firmware
      commit: 62a6f98cda4ec75107e96571346349a649fc63d1

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

