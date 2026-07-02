Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A040C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD06810F29C;
	Thu,  2 Jul 2026 10:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="GIGFSadI";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2280E10F29C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 10:43:31 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6626MvDr1931364; Thu, 2 Jul 2026 11:43:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=E
 T8EzdBqy9srmOkq0lSzLi+wjQ+SbWBFKHkUtNhwEWI=; b=GIGFSadISBwdmm//3
 gm0gq/mZSEctTDB3lvwiTz6wGhOyzdB9gVcUJWtwI3DUqbp8XRh30/DKrFwljV77
 n7MDkChnIE0pocHHrY/D7vieyOegMW/NFHb/hgVlSKOgoLY4kMv88W7kIBtwRuqU
 TLmlch+UyOJHItiutVhdtEf0fuxJJ0AYzlrOWXCiwRZNnTa5ULtTluvHUASFQWXS
 egVjstwM48UI1mYQQNW2g4tpgMxw9NvGk8LZdqODTH355JRoIiEbqTILGbKm8TXq
 88OsSIaIYp7YPJTfq8nCKbXfRRdpgF2zw/jLnnzP4TCWeLx236t6ojaksOr+23JE
 yHzGg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kunakn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 11:43:20 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 2 Jul
 2026 11:43:18 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
In-Reply-To: <20260630-b4-sched_fix-v7-1-71aa39c62627@imgtec.com>
References: <20260630-b4-sched_fix-v7-1-71aa39c62627@imgtec.com>
Subject: Re: [PATCH v7] drm/imagination: Fix double call to
 drm_sched_entity_fini()
Message-ID: <178298899887.102946.11369640491479366582.b4-ty@imgtec.com>
Date: Thu, 2 Jul 2026 11:43:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a4640c8 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=ZX3hCQfB1uyMSPSD_xEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: tfFj7ORyzaS3sce9NutG9QM9J_bHkCN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX58l+kKVjVcDZ
 QpWz4rrbOcgXz5FoRRZAdrVtwM0APCYIqqTIQ0my+VYlaxeNB8KnIIn8nN21lf41162oMKhE1c/
 H/x/Mvzk5o1fuGvJWeyMsRxWq8xOLtFn1I913tnu9Uaw7aPrQhsV+FKUdbSayrN57thHX09AP0C
 FCoKF7TQ8iiGMIJ6Luk0DFyoQyd93Tu6rD4YsaAsm+6RC18ZQwo6mhD2kD72IDyY125SquUohMk
 J5V2dKpdz91vfLu7Yq1d9F90g5+G7LdJAffQZcdEPeCEIiHluD6Dou/1KXek77zLISoUyL4aoIy
 uIWzHCqpSBeHWKCy9s9zVDCg9flov2R6zgyMf0b+3DegWbTUhDsJn75b/gVp/gtEa+N3kEIeGdJ
 RC22BQnHgZaUhq7vU13xVMt6EZYr1nqpcLh/I8x6pbhTTR24ECYGlIu74EKdCczneO+gp6hTQYV
 lJB4djxcQMLAy0DAQvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfXy1V+AZBmHUlB
 NJepOofJFboyJi2uV8l+gv65XVSoUE8Dain0y3tIRguJV6Gg7LKqPVUF+TIYi5xK++UW4SOhwwi
 oZdecGdBmnwOr14rRVjP4b4BWCoBOJg=
X-Proofpoint-GUID: tfFj7ORyzaS3sce9NutG9QM9J_bHkCN2
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


On Tue, 30 Jun 2026 21:10:07 +0530, Brajesh Gupta wrote:
> Call sequence of double call:
> pvr_context_destroy
>   pvr_context_kill_queues
>     pvr_queue_kill
>       drm_sched_entity_destroy
>         drm_sched_entity_fini // here
>   pvr_context_put
>     kref_put(..., pvr_context_release)
>       pvr_context_destroy_queues
>         pvr_queue_destroy
>           drm_sched_entity_fini // here
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Fix double call to drm_sched_entity_fini()
      commit: 4af24c27a39ba147a613a09e10b9e0f7294524c0

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

