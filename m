Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48A606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=tqoJfQzJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510E710EDFA;
	Mon, 16 Nov 2026 09:45:20 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29B510EDFA;
 Mon, 16 Nov 2026 09:45:13 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AG80UB23603101; Mon, 16 Nov 2026 09:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=u
 wlku+mx/ylkmsooxeq12CxejkDxtyGY4wsS07M470A=; b=tqoJfQzJwwC3PkKZ6
 gUJkD/4crQpXNH1Je5uJyrO4D9iz3nHBIoRBWToowjrg+/qa2UTsNlnlwM/IAbtN
 sl5adeS/XDQenKnWaJw2bSS5RcXlKEXIlkRcC9fglKtGdsBx9ht1DhTHkT8G+JoE
 cGM0sgfiUeUo9trithFisTod8oWndfK0sOcJuPBZVQJ1Ka9CIBnsVs/XsVrMZudj
 pFbJUqQ3EREQNhHk4KopSiBkxhDaEDRvoKN0ekQfDG3aa51SC3qPA3wA9GnuATYA
 Wt5z3A2TMki20nbhq3vIXvdxnT2FXpNw+5dn7a76wnI9MlkiSL50cdRSeulS2LUp
 r+c4g==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hxgky1du2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 16 Nov 2026 09:44:56 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.178) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 09:44:55 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>
In-Reply-To: <20261104-minor-improvements-v1-0-cc976128538e@imgtec.com>
References: <20261104-minor-improvements-v1-0-cc976128538e@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: minor code improvements
Message-ID: <179482229566.106842.11479170967882718232.b4-ty@b4>
Date: Mon, 16 Nov 2026 09:44:55 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzOCBTYWx0ZWRfXySgh7owXSWF8
 fbKJEWdylZryqmvX3bUIBQ+kPmb04ZNIBvu8B5h1v6RZNcMrfhAbXAYQI+I70mdYdlFNbd7T/zK
 3qFMVJ6FBpkhbEZqeQeGeyOuNdDVFTlOoPNAx8ysOof4kfz6pgxi3tOGhnTsM6nWqhFXyYK+hrV
 OWG4/2v+17jKiktsAzIStnma2NChbv2WW63mzvJwps72sICl00S/jLLlZnO2VNqHG++MmMLe8n5
 m2XCi4ync8B6WoJYp8GDzlpKXDjsodstCvU9+i546l61SAZD9pTjip7t0zEM4geYaFzDlDT2AvK
 4yCU9Ng/ly6Qi1FM9yeBiDGVEwCEJzitR0p9GISvXwNzsdFCd8dUkFyWs67RIV/iHVXjv0HTCO6
 xYqnQEM4RHYHRh1YCDs/EF1fj+1/0Oi7zUDwgIneDSnyroExu15JpWI5DhxqyL0xfhV1ga/4JuH
 K/P7Q4hgFQeEdbM+80w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzOCBTYWx0ZWRfX4jGMzxYluZm9
 wpGi6mLQnsRwqSC0iYLWU160ycpkx4wZesjP+uch43hYcBlAAmdkGTMfdh7tuqjm4pq4pSC22Hu
 l8/+yZwXcMmjxEfPCN49xM3w/WwYA9I=
X-Proofpoint-ORIG-GUID: iimnhAt8x2W9wrvm1wOHYRQEDerupV3T
X-Proofpoint-GUID: iimnhAt8x2W9wrvm1wOHYRQEDerupV3T
X-Authority-Analysis: v=2.4 cv=TbsDJhQh c=1 sm=1 tr=0 ts=6afad098 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=vO48zYV2LvQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=CDIPUTPqv7TuzClm3FwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 19:28:15 +0000, Luigi Santivetti wrote:
> No functional change is assumed in this series.

Applied to drm-misc-next, thanks!

[1/2] drm/imagination: switch to inline init of rogue_fwif_rta_ctl
      commit: bf17b99b1139ad6cf8fe15852761f19de448414d
[2/2] drm/imagination: drop unused arg in free_list_create_fw_structure()
      commit: 4a6c269a742fc4de2d72cd1d291175186ae8d435

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

