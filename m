Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86F606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=v3QOpWh5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAC410EAA9;
	Mon, 16 Nov 2026 16:36:44 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBF410E9FB;
 Mon, 16 Nov 2026 16:36:28 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AGCQd1H4134120; Mon, 16 Nov 2026 16:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=Y
 LJoUU89ZGsCK2NZO6kWkIJ/kxhCMvVuD1RYH0B+ixs=; b=v3QOpWh5N54Uhr2NL
 pmb1gtAphcjISPZC3MsPqD0/xpH2wstKlcbf+CUMDW3kw73ogVxZz+JWNEho821i
 nEfRb49OzaIPr0GLbdxhQR2ct9qzqloG4CBOv24HX92/91pQWf3izQGVk+eQC6gB
 7thsc6theYj3bqdviIWhVXwoHJfAexOMR+K33mWQAETglPm4r8zHD1KGBjNd5A/g
 6fqTvvUr3kV2/eNtS22uxPIEORaFw0Sv0AhcdqKdOlUSZ8rpBn2StakeFJOq1tbd
 4yeLFxaTUVNJE25vA9ZovATiD+f5d4JXTaei6RvrDKBon9AwC2aBxExfJoHpfbBE
 nqJkg==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hxestsjep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 16 Nov 2026 16:36:20 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.178) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 16:36:19 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>
In-Reply-To: <20261105-document-drm_pvr_dev_query_heap_info_get-v1-1-b899401606e4@imgtec.com>
References: <20261105-document-drm_pvr_dev_query_heap_info_get-v1-1-b899401606e4@imgtec.com>
Subject: Re: [PATCH] drm/imagination: improve
 DRM_PVR_DEV_QUERY_HEAP_INFO_GET documentation
Message-ID: <179484697973.410388.13422245137747065489.b4-ty@b4>
Date: Mon, 16 Nov 2026 16:36:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-GUID: 1HpDm2F3_kQp23M7uTd6pQPLuWsuAYOe
X-Proofpoint-ORIG-GUID: 1HpDm2F3_kQp23M7uTd6pQPLuWsuAYOe
X-Authority-Analysis: v=2.4 cv=O8OsLx9W c=1 sm=1 tr=0 ts=6afb3104 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=vO48zYV2LvQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=jSLtM6S-_AGHOE5eHdIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NiBTYWx0ZWRfX9L2fGalIkrve
 P1cfyKfJrXbRNSBZ2UZ0jxui/f3nVal+c3AlAKQx/tcNdttBn81AhK1EGkqc1hgLJNbiq/p0luA
 3Tv7aenu0UdqulQB/ZPro5X+FmxuM3mvpNqdPxrdmV5rPshVqNPHL3fpgWRhYD4G2LOTFISMbda
 LXUiRgXwXnvSvVdRiGKryQFUbKXHys6MxCdwVB14y99ZymQ4L5ZhxH6musTkqyR13JexC+cHoiG
 wJcHX50HlA493K1xY+zrhEltFwfd8yorGvLxsuExFV1St/pP+a2sFMuRb2IoOvUKB7BxLFn2vHB
 mexPDZ0/EvyPzXyZWCY+kNCgKrFTLpjfOxnIaHaC6S/VKNP6YsdCXGX5T+Vyf8Ac42Y+TwdyNpI
 7GszTePFAWaOzSjmexienE7ZPIiQfUcwKL82QLunHhtKlm7Y+w9dxR+1xZCzwkBK71VcwOHbaFF
 prYZjBl3Cb/7rZlI+pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NiBTYWx0ZWRfX8uTyPd0PgRB7
 79QUQVigU8hjiIxrmKKWBmXLMpRvf3R+Zd9HIiujRdsu81Tx+xKwxtipNwD0pj94uA5sSbPTVam
 OTd5VLoptbGuxcXnZCgzSqvDS6g6p00=
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

On Thu, 05 Nov 2026 12:24:23 +0000, Luigi Santivetti wrote:
> Add more information about how the array of drm_pvr_heap is filled in and
> set expectations for when userspace and kernel run with a mismatched UAPI
> header.

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: improve DRM_PVR_DEV_QUERY_HEAP_INFO_GET documentation
      commit: ee1e297216f300160ee91dae0b53b3a42e601d1b

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

