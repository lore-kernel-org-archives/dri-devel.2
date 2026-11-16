Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A75606A891
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=b9mBPRxX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED60310ED5C;
	Mon, 16 Nov 2026 09:44:40 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CA810ED5C;
 Mon, 16 Nov 2026 09:44:34 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AG7XBIJ3597227; Mon, 16 Nov 2026 09:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=F
 jbSO+RgrtL19gcVmttMmvvQbFFoCqkBFwijKrQXmXg=; b=b9mBPRxXhKOUeK3Jj
 J3lLxblXMoxnFFDwH8H1FZWet2uNSaMdHWaAw8M6u2yBKP0eJP8lMkA1Zqz+0M7u
 7te3rZuYFH4ed4+MAIl2i1TcORLgomWjXTUjkgRguP0BXBzu59POn/zWswFA7E+G
 3BvWGE0EMMV6v25e+S1VrI2Ng3ygiLS7j2KWZazWz/aBpWUFmoMryCTTQWAUy00U
 xzDagTdug0G06e0C7ENbBLmkGBNhkdofAmdQ/DNPAIOtPz9jUFJBeLhqrKpASLpK
 3Qux9M2XjzB5+1lxrmPE2ZufgA4eJozE246OeN9dTajl7/GK4Utz9aKHMdP0TNVt
 qV50g==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hxests96t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 16 Nov 2026 09:44:12 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.178) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 09:44:10 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <frank.binns@imgtec.com>, <brajesh.gupta@imgtec.com>, kernel test robot
 <lkp@intel.com>
In-Reply-To: <20261105-fix-sparse-iomem-warning-v1-1-35c13069f271@imgtec.com>
References: <20261105-fix-sparse-iomem-warning-v1-1-35c13069f271@imgtec.com>
Subject: Re: [PATCH] drm/imagination: use appropriate poll function for
 non-iomem
Message-ID: <179482225088.106632.17342660080318939552.b4-ty@b4>
Date: Mon, 16 Nov 2026 09:44:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-GUID: PIontu4lxkKpR3ce8kH0Qygnud-sakwv
X-Proofpoint-ORIG-GUID: PIontu4lxkKpR3ce8kH0Qygnud-sakwv
X-Authority-Analysis: v=2.4 cv=O8OsLx9W c=1 sm=1 tr=0 ts=6afad06c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=vO48zYV2LvQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=SQe5uPct8LeOVvbmQgUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzOCBTYWx0ZWRfX479g7rS7bYci
 C06JpbDhtdIVrDL//vai+7jBAoIjPsaFEiqESntiUw4OxS/tjyBx9239+yQ+x4fNWaVVCYu8V3R
 7g5sS7VJ9KzDX+VRD0leC2dbSf4AqUKE1OEsd5/Sw3rAudkdcdTXDMbhavg6iXGV6GpWWkjwxGJ
 UYrwY3rBCF1HxaGtkBPErfKZ4f0p5Q00NnSN+hi7QEy8xQlFjs8QYoAsWoVUUUPgMpxcdRkqZCG
 Q71is4NeYmQloSwkl/F4+ZFaoYOWIN6qyyKIb5a4vW28qO1IoPAVLRef01RXKGI7smcEZyHdb+l
 6FS2alZGrDi7QM/n+41r1eJmRaPPq4uYj5wLfXaQQ8DcHqf6XB+2FoVzc2LttqrjSOHPXrHj2Dt
 +2Bi5/G3NN59O8hObZpps9jXTNW88aFSsHkzEaxqaItrCICQsBmkHe/NFMP9WdE3PgnJtsj/Tob
 CaPchi+eRwFkYySWDXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzOCBTYWx0ZWRfX71Ynx9LjYkdW
 U8YkeO98WI/8Pn83rS6hhLrXAQXqjEXIhUdQseufwsHhaWe0PwkkO+PZNqRPfVWI+8OGdc8Y42R
 /qQHicYWSY1EBO7bnmMZXPGrBv4/t9Y=
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

On Thu, 05 Nov 2026 12:25:37 +0000, Luigi Santivetti wrote:
> pvr_power_send_command() checks the contents of some memory on the CPU
> that's written to by the firmware. readl_poll_timeout() expects the address
> to read from to be qualified with __iomem, that is generally used for
> registers or memory that is accessed through a bus and other than regular
> system memory.
> 
> For PowerVR in particular, __iomem is not accurate as the memory pointed to
> by can strictly be system memory only.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/imagination: use appropriate poll function for non-iomem
      commit: b1e4074bfd00bc7dcf760c8eeb9b694895e5296e

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

