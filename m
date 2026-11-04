Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFDC606D80B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0CD10FAA4;
	Wed,  4 Nov 2026 09:59:20 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0342610FAA4;
 Wed,  4 Nov 2026 09:59:13 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A48Llvh1967148; Wed, 4 Nov 2026 09:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=1
 fSsyTe3mItuPHE87AxLgFn5s/7wKS2nAS2QEjVqG2c=; b=Ir/v+qVpC3+WjiXXa
 U+p9GsmgquxtyeXgBYmfJPU5DOWTRacgPa63VL1Eda47a5M+9nfVImX0+GgOOvGM
 TjFs+CAcEUrxJhTwhM++TcbTDQ/va3um3uGj+IIneThS3eJHECXSAZ0b6Sof0R7j
 E35zoPCsACmxsEu3k44ruXGHoe2nu0+OE0gw7qPoGyZaF5irMi4ph9mHkYneaM8z
 xNUnhdR+IvBZb7eto/cVMperdr2RhC+rLiUZZzjW5yQImXG5gQzyDUxbQVJw1Zso
 FSfRzP9XL2H5+BOCZOywjCVDuRswjvcO4Xy7LzIMYL0PZVME+GZ7ZTqgIv1h81l0
 6K86Q==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hn7ft2yn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 09:58:59 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.95) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:58:58 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gyeyoung Baek <gye976@gmail.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261015-pvr-mmu-sgt-offset-doc-v1-1-aab9ba54b5a4@gmail.com>
References: <20261015-pvr-mmu-sgt-offset-doc-v1-1-aab9ba54b5a4@gmail.com>
Subject: Re: [PATCH] drm/imagination: Update sgt_offset kerneldoc in
 pvr_mmu_op_context
Message-ID: <179378633839.70737.2111025515404343629.b4-ty@b4>
Date: Wed, 4 Nov 2026 09:58:58 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: 44fq5fSSWgxarzsvZ3VRDWW2_Ne8Q0kR
X-Proofpoint-GUID: 44fq5fSSWgxarzsvZ3VRDWW2_Ne8Q0kR
X-Authority-Analysis: v=2.4 cv=HaSB3SE8 c=1 sm=1 tr=0 ts=6aeb01e3 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=wPtG3T4iTXQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=i62lKFUtsPXGxgjfG_QA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzOSBTYWx0ZWRfX9orxzUlgWm1U
 QsFhZ25HGJdSB82VEK2EOIC+iHzLy+z5Nr1Sry51Dwstykr7BOzzqzy5xV/e/G+XCZz/aKGWUTp
 ND1bUfI/Sb2wIGR0NdF72iJwHHX+BDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzOSBTYWx0ZWRfX+bXjpKbzS2bM
 +Tpl/6nKl0rmv+IeQX6SpR3/QpdugJ8FpFSVjPlZ62bMuHDpj111KLEVoZCNgpjHgkCqmWkqeNk
 5KJyp/T57frBtCthiVQ/xMw86aSHSVjhWzGuL4M4YqOLU7APlxTEUX6WWfGPA/W5W8T5i/gawaF
 AWDVSUt2KjMBJ3dWVWGWDGAEL5qC4OAUOQ4UuJrM6RHAXZPDtDodM4osHbLw2itYZe2S35FW8hs
 Bp4f8D85Jam0NjHf8lr+qmAedfRTaZrYzy0w1O89F/uXl7NDd5F/aqE9r0H1P9GU9b+9RCP/WK9
 ycTfEp2ews65tkp/sMI0Lh1uKZgUIJA+I95zwvxlMbe7XrnTbeQRcqm7DEnJVlUXvwuJG4f4lp6
 zXkYprBa1t59rBNUUbQd8JQef3rmr2IqM0Psoy1hkUXk5+CNXg7K057a0yN4cvxLoK+WfWCveS7
 UToUQDWxszVfMtD+d5w==
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

On Thu, 15 Oct 2026 12:48:27 +0900, Gyeyoung Baek wrote:
> Update the @sgt_offset struct member description missed by
> commit 789f290b2e81 ("drm/imagination: Size page table preallocation by
> device address").

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Update sgt_offset kerneldoc in pvr_mmu_op_context
      commit: 476d658928af91f5ccb455957be60763d8b00fd3

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

