Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=GcwSHRu1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BE010F2DD;
	Tue, 24 Nov 2026 08:23:12 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7851F10F2F3;
 Tue, 24 Nov 2026 08:23:05 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AO7hor33490018; Tue, 24 Nov 2026 08:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=+
 lB0qIYI/uTFr9P55v+/IWmV/RBbTeTLfzExy9APUxM=; b=GcwSHRu1RrLLvwsJK
 AAszIL2ncf/yn2lbDQ783VeZr4DGtCL/uU6ZJ83M/AKlNNcOzVWE9PMZ03PJcs+v
 bqOfX6wYUVuK47jbYST6iO6Vs39dZXvzLBfTfLFtdVUTLgk1WxbWiwYebwwIkTU4
 GhbGY5cMe57TMF83YBqq92NEch3ZapGS65VrKjQdwxFWB1OpueDmul+LbohaY0BF
 SdpghDaTU3ZPr/8VbNpC+UIkN6Zj9agp4CiPMeYNd9Tx2FwJJ2N2ov/lLwIAApFi
 1OIr2+GA1NAe+/8W86Kgye1N35zirEncoq9sckfeYEX/b8t2euchF2dmgIbtPE3a
 01esQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4j32ev23kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Tue, 24 Nov 2026 08:22:39 +0000 (GMT)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 08:22:35 +0000
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Matt
 Coster" <opensource@mtcoster.net>
In-Reply-To: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
References: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
Subject: Re: [PATCH v4 0/5] drm/imagination: RISC-V and META firmware
 interface updates
Message-ID: <179550855515.553125.14973110047433852790.b4-ty@b4>
Date: Tue, 24 Nov 2026 13:52:35 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX3xLW8kDiKZny
 pzlgA/m8MpTShOQsfONqSEAcTepgDtguhEDCsampD/Ja17GkuUAW83GOOIHkZ6XqOMavplItAfq
 u/U/Hcx0KkDuGxUHlqxoq0PUi4JLkSU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX0cAKPrQZFaRf
 U0+zDi/HU6sfNVMnXoXgGW2jqr0SzyIDcp0HPKMkJID6SXbVj4MsnRE/kMGow0p4ujSQ70jSG/e
 HHdhSzB32GgjfR3urcXvcIUuUdGuJMKPBOS+TgIjEAYoFGY89KbcBt2GQ20lC8F+t2nRoiYFskg
 19feJhOXT6AOWm8wbPKANGVqpK00sW+u8ZYmaGfAgcyfBTdZKpQAIX8y5sNer39zWv/MHKKt7Cr
 /3+YkmnrZKwm4WwWVH+Y+DGzFiZZhA1Vgt8eOiYB/v2LIwJhE7DhRVgdeG1hQ/QeogdeoI+T3Ie
 AhQoVeADJErfkx6RVhV86W/Vr634RN0tnbEQ8Gon++MyLVIDBBO64UPC/HV/F+ISBrmbKRTRHfs
 qFnPVxn2V8IBJKvYmDaIC38WK6TgTSoKYtyFHGgtTVH59sIcStoBDSYus4ukJUiBFv9uK0gtn6I
 JyD7SkTxgKvGKLdehcA==
X-Authority-Analysis: v=2.4 cv=T7AZ3PKQ c=1 sm=1 tr=0 ts=6b05494f cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=b4IBWIOinYyicvjhWD4A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: DFY79QVYbJn3aGu_YdsitQqUhvNz5qNf
X-Proofpoint-ORIG-GUID: DFY79QVYbJn3aGu_YdsitQqUhvNz5qNf
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

On Tue, 03 Nov 2026 11:00:39 +0200, Alexandru Dadu wrote:
> Refactor RISC-V and META firmware interface headers to have a more
> generic and architecture independent approach:
> 1. Limits access to the RISC-V and META firmware respective interfaces.
> 2. Aligns RISC-V and META firmware headers with the other processor
> headers.
> 3. Add "_fw_" component to the headers filename.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/5] drm/imagination: Prepare heap config header for multi-arch support
      commit: 78739294551c39d6c082913afd45166102c81bd4
[2/5] drm/imagination: Limit access to the RISC-V firmware interface
      commit: 2f42457ad97a6d3274196e6a825763d9d51d677f
[3/5] drm/imagination: Make the RISC-V firmware header arch-independent
      commit: a2eb58c3919aa45bd600c3c092ec301ee96f715c
[4/5] drm/imagination: Limit access to the META firmware interface
      commit: 780a9c551157cd373cac647b00a2c18a440ee49b
[5/5] drm/imagination: Make the META firmware header arch-independent
      commit: a70a2efe98a999f78a307bbcd933bfccf22f0672

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>


