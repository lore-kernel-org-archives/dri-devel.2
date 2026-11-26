Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EE606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=DRSBY9pW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C368689DFF;
	Thu, 26 Nov 2026 15:52:01 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDF789DFF;
 Thu, 26 Nov 2026 15:51:55 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AQDbcX81058347; Thu, 26 Nov 2026 15:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=5
 3Oj/yRs0kpXnPFhAkEDAYzbVUVIdGZkzC1jJZtJyy4=; b=DRSBY9pWKjux6CgF7
 9LR1C+ijbN9kW/TtkSZVpkL6ORBW+wvcJMczb8A7M8TsV2ZI0NZPsEaaTxISu5NE
 QvSmd6DZ6vbJjUfoow2woO3wwGy7VcvMid6lbJibEghLGBA4Rj9pP9fDbzVnBUWP
 zfbf3KvtydxQEw8naa+pQme9OrivHjAGIG5HUlkAf0cZWWiZEBdQMR0pSDeg5fm7
 9d4fWV/vZKeLEPVmcgfHB6QBEvo8FLxiGNld6yIOsRqZ80eZ8/X09hchhw0gdDf1
 xIv23R+BQVNIlDfut+bILvu2f3HptDKRYEI685nGRn3Y+FuoXVoWgezoIRqAA1yX
 D6cvA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j3491mf6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Thu, 26 Nov 2026 15:51:41 +0000 (GMT)
Received: from np-a-belle.kl.imgtec.org (172.25.6.177) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 15:51:40 +0000
Message-ID: <7c3674188150b6c7e4da1a7a970c53b545e732e2.camel@imgtec.com>
Subject: Re: [PATCH v2 0/2] drm/imagination: Fix leaks in HWRT data set
 handling
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: <shyckless@gmail.com>, <alessio.belle@imgtec.com>
CC: <alessio.belle@imgtec.com>, <mripard@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <maarten.lankhorst@linux.intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>
Date: Thu, 26 Nov 2026 15:51:40 +0000
In-Reply-To: <20261121-pvr-hwrt-common-v2-0-9f53bdf954de@gmail.com>
References: <20261121-pvr-hwrt-common-v2-0-9f53bdf954de@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MiBTYWx0ZWRfX8A+JB4QCoEdT
 MXanbnfsgp2Tdxb76/YFfyd6bX2qUyPmDz9grLpaLdFsknvX2B/GY2cFwgQykL2zjgf7kOI+Hg/
 88mr8CR3VcxUDXhRsFEl9oTMNirpmypmopuKr6iBjw17YmoBquWhPkh6PAyIl0kor0UGYQh6H69
 5NLXik5c1S94M/MaMF3Qy93X2Ly4TCfUA3ZRCuMa0R3CXznIYBSLgxLAqhfK8iT+x5D+UprybQi
 aZq63GdFMrc178ram4Dt/dHuyMNdQi5H/HtpQHyqLWhEhG8MjC0xHzu0t3+PMBn4m/jcM8t7NWH
 Uk6MrO6/fgWRgpBQTmbyyRiOCS0uJ29iZvHcoxvmfqryzWM5Zp1aPimMR3OLz5DLkgDY+Ms/7Tz
 0h0KkC8pYP0JVy/XFNf/GiV4XSAAuw1fixfR2OLXsLd6TILhH3ZpaYTNrs2MTKN09jIJi/P11YK
 26b5VpPYRnB8TkAm2YA==
X-Authority-Analysis: v=2.4 cv=OaENnRTY c=1 sm=1 tr=0 ts=6b08558d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=sxNTSC7i643Rs2yvQpMA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MiBTYWx0ZWRfX3/XDlbMSAAL6
 +L3hR/oQEGMdYY6w3mhtDoAmHvUN+cA6Kxx1TYmdDT/KFafLfPC/EQnq+HQHfMGvhOK9h3oPJmq
 +iCpNXAs3oU93NiWlDOhc5NY+ddqQeg=
X-Proofpoint-GUID: C82q8EMnvWk4Blgs-f2FVgUp_O5uVfjk
X-Proofpoint-ORIG-GUID: C82q8EMnvWk4Blgs-f2FVgUp_O5uVfjk
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Suyuan,

this series looks okay to me - thank you! I believe patch 2/2 might need to=
 be
rebased, the line you are changing got recently refactored.

Refer to:

https://patch.msgid.link/20261104-minor-improvements-v1-1-cc976128538e@imgt=
ec.com


This series is:

Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>

On Sat, 2026-11-21 at 15:47 +0000, Suyuan Wang via B4 Relay wrote:
> Patch 1 is v1 with the Fixes tag corrected: the error path that skips
> hwrt_fini_common_fw_structure() came with f1f55ed3ffe4, not with the
> commit that added the ioctl (thanks to the Sashiko review).
>=20
> Patch 2 fixes the other leak that review pointed out: the 32-bit layer
> count is truncated into the 16-bit max_rts, so the SRTC and RAA objects
> allocated for layers > 1 can be skipped on destroy.
>=20
> Found with a static analysis tool and checked by hand. Compile tested on
> arm64 (W=3D1, all files that include pvr_hwrt.h); I don't have the
> hardware.
>=20
> Changes in v2:
> - 1/2: Fixes tag now points to f1f55ed3ffe4. No code change.
> - 2/2: new.
>=20
> v1: https://lore.kernel.org/all/20261121-pvr-hwrt-common-v1-1-784ce45b782=
a@gmail.com/
> ---
> Suyuan Wang (2):
>       drm/imagination: Destroy the common FW object when HWRT data setup =
fails
>       drm/imagination: Don't truncate the layer count in max_rts
>=20
>  drivers/gpu/drm/imagination/pvr_hwrt.c | 2 ++
>  drivers/gpu/drm/imagination/pvr_hwrt.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
>=20

