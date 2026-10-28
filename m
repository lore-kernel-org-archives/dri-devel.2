Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E20606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=LGyd1Str
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869A410FBDC;
	Wed, 28 Oct 2026 12:09:54 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA72E10FBEE;
 Wed, 28 Oct 2026 12:09:47 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBfSQl1071483; Wed, 28 Oct 2026 12:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=0
 HLaRvrg+jl3Zxb9AZyjzDR0FZQPetkXt6VlqhhlGEs=; b=LGyd1StrXhjsnDGgs
 CIB6wNIvPza2XZIM3DWrE8u36AwPiBPWgTAN+SjVhS+KI6bLCyDycsJRG4GryZXt
 idEPU+xLoaNQ6dOSodfYIjFoYJb9yyNaUcFUzoKiMVEWcjAQXJ5u+PoCtY4Hziq3
 cLANp2c/G04eb8UX75s8o9ZRLAszDtTKZP8mS+vHWdI+OJfuQZ4woeAvtv6+DHrL
 QHaJiEs9x4bP4i0JR3kvqepWQrxWGG2+Qfj7iYm+wmQM0fpMr5bv2ATnwLl/NlJX
 DTH2gzTNymyglRLuXtmIEguBld11pgZYxZMvhwRrhv7l7kMuZnGusxiyLx1QFzPm
 JP9Pg==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hk4168exc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 12:09:39 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.210) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 12:09:38 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: <dri-devel@lists.freedesktop.org>, Rosen Penev <rosenp@gmail.com>
CC: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <imagination@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20261005194127.151181-1-rosenp@gmail.com>
References: <20261005194127.151181-1-rosenp@gmail.com>
Subject: Re: [PATCH v2] drm/imagination: simplify pvr_fw_trace_seq_data
Message-ID: <179318937874.184022.1740380316769591198.b4-ty@b4>
Date: Wed, 28 Oct 2026 12:09:38 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-GUID: z1JiCtqXW1WrcZmI9mQiOc88j6aDrIzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX02X1LANHBf17
 vS890HkUyKOb5Tcvp16rpXbe+ONC5HRF2NeoCPyjqKRQFL9Eg76t9kh8Y1wKBXMAnMniI0+wc5u
 5GAx5YW+wMqONfiUgsWJf1KS4axxIAYjKCEz3E+dtLTC5ucdptIaI+jRg/J5cL9dTJikYu8Ip0F
 /t2AN1mFxZ1JO/loMNZRan225K2rZjf/tovJ4BO68d9V8jItik244sCZn9LRVANc3BxdJ2fd+84
 yrsTy7TEvX29kJZcsIU99TAiV+ZcV/18psJu5w4fXoyJqUe7yV8GZ74kFINZTBSrA3Dd2jLHyr1
 vqZiiRsBwlSowgGODynn9P7QsFtbbPJSp8qIRtWwSW+0vmbrbBcVa+oWO6LHPNi+WxTektNa0Td
 jxH4n6Cbj+KP280A1FC/+Ul2dSAOP2COwLRzoBEYEpMAVA+qULfV4T/cvGYZAkZ056xQohPyEls
 U0xB6oNrSXRsTKdXZtQ==
X-Authority-Analysis: v=2.4 cv=apQnmiZV c=1 sm=1 tr=0 ts=6ae1e603 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sooSunb62akA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=zec_S3E7ITbJX9_FcKEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: z1JiCtqXW1WrcZmI9mQiOc88j6aDrIzv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX2C90W1cZXGJ1
 hS6u0qrsD2PSfLqj98H7O3TBQPK/9ejgCnrGR8oSGGJpANGir0BX+Bjom2KL2eg/qMl6Uz1Qjbc
 Bt7e+qkMAWeDkM3a7Js440Qo5yDAQJQ=
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

On Mon, 05 Oct 2026 12:41:27 -0700, Rosen Penev wrote:
> The trace buffer copy always has ROGUE_FW_TRACE_BUF_DEFAULT_SIZE_IN_DWORDS
> entries, so embed it in struct pvr_fw_trace_seq_data as a fixed-size
> array instead of allocating it separately. This removes one allocation
> and its error handling, and lets FORTIFY_SOURCE and UBSAN_BOUNDS see the
> real size of the buffer.
> 
> At about 48KB, the struct needs an order-4 page allocation, which can
> fail under memory fragmentation. Allocate it with kvzalloc_obj() so it
> falls back to vmalloc in that case, and free it with kvfree().
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: simplify pvr_fw_trace_seq_data
      commit: feaa32dc98090b2f45f7b6f179711a6640169c1a

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

