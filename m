Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64B606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=GPJ/fK4u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E040B112EE8;
	Fri,  6 Nov 2026 16:25:03 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E6C112EF6;
 Fri,  6 Nov 2026 16:24:56 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F1mTY3667811; Fri, 6 Nov 2026 16:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=L
 wVuwumg6MVzaxXGuVMtoZw9nRxEua1k0xUsXPLfG3g=; b=GPJ/fK4ueVzk9h8jh
 HpkAcIQjgI1Cl9F05sMidAKV/aYdhNWm0/oaCsSxkgTGUNrks1EBNj1XkNUYAerC
 KZ/dyNICXM+y6D5MqnVq3KmtGG4it2OfByFlR9HrcCPtq//EfdIdZ12fCCNQrIZd
 OqsE9iyVrZcvuoJ3urroCb/U/vigX+7xO6r90TnxYDb0GZuv3LqztCcwt//DqMip
 imwjouwCX1yYnOqGwIuqcYWAyIVVNgjfpi/vbVuKt1fLRffhIXX+IQMZb+NNbh0J
 nJ9s15/EqjA58s2dCKDRxeY1ZoH5l533jL3T+fGZ7JAhL6VKoJId36NKqjFndXZt
 jH7/Q==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hry5g0qwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 16:24:42 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.219) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 16:24:41 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261106-fwversion-v5-1-d0074f992e75@imgtec.com>
References: <20261106-fwversion-v5-1-d0074f992e75@imgtec.com>
Subject: Re: [PATCH v5] drm/imagination: Support for querying Firmware
 information
Message-ID: <179398228198.293284.1425834279889546916.b4-ty@b4>
Date: Fri, 6 Nov 2026 16:24:41 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX6gO/IGV2FNfI
 3tumo8BWPzk5mybu34QBzm8zBl3Psa1Gu0xWvDQ66g8XV/t+1TZSGIEVITgNl908CiQJomVMVsW
 dVH1S3yUTLg7uOd0tXe2p5wsGQfDm3vPcrVpiKd3hxWUiHHOGY+imSEZ+6GrYPVxJQhARBO5dmI
 9jf4XApW96om5Livpu/ohmxdHCC4ROJ6wKilIbRAxFHwqg6r2HvxbfdJGcXpnF5L1tgRKl0Yxtw
 OdvB1QdFS5+5FhBpA7R3Wgum1RU7o6+JqVrc5gm1WfLuVNj050iMnTf0tvfHQ0relOOl8uvMb6s
 jQ3UOSgc1aS5SCT8/DU/x6a6f21c/1s/3KcnUA4HfUbY2XIHbgY84rXPm6WVADB5tLzpryplPQJ
 exy4ZmtUX1fzsSawwog81joA9CE9E8gO9/V20A3rl6cCw3eh0Z7Kr1rzs6bEwy+wsFBcfL+y4+C
 K3M8FQo9RXtJJ5w17JQ==
X-Proofpoint-GUID: Yjtk28LzhhvzQ6ADqjR7bhFO6t1t__Y-
X-Authority-Analysis: v=2.4 cv=daIVTnXe c=1 sm=1 tr=0 ts=6aedff4a cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Sf2g2yCNzfoA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=gQUwrIzfNSe-QFhc_YEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX3J575n8qASX6
 zrAtNvpkLO7RRE1bKCBr/+DcAEA7ygdqc1l23dvwY2Lmn9BBvV0MJn//k2cmz/rhlx5fvZ7PNF0
 t8lSKra51G7gnPlgYMsY7Y96+rWgj0k=
X-Proofpoint-ORIG-GUID: Yjtk28LzhhvzQ6ADqjR7bhFO6t1t__Y-
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

On Fri, 06 Nov 2026 20:12:23 +0530, Brajesh Gupta wrote:
> Add a new subtype DRM_PVR_DEV_QUERY_FW_INFO_GET under
> DRM_IOCTL_PVR_DEV_QUERY to query Firmware information. This allows the
> userspace to detect any bug fixes and features present in the Firmware
> and take appropriate action.
> Currently it supports querying major and minor version of the Firmware.
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Support for querying Firmware information
      commit: de30740dccd882b8177f260e7d8e26ad60f7c677

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

