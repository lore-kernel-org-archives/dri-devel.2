Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C926C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B884310F28C;
	Thu,  2 Jul 2026 10:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="VM352Nll";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2500A10F2A8
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 10:43:31 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6626MvDt1931364; Thu, 2 Jul 2026 11:43:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=Y
 GoGQ2Dd5wvF+n+UbUvDIuLeDHM947pWIHhw5b/yMyw=; b=VM352Nllvlq5bldvi
 tXWDrvA8h4zpR749Qvb691CytLW/74EOVTWo93DsjHfVPtoZJE4CI/yd1dd9M+qA
 OwnQgCX167jcnkPGOm+8zcA1BQ0Yszt84CciZK5GLYjQlzQp/gfg7y94HTZLJ26l
 SrKSiDfH/E1oy1DizQolxQ1j6Bk01sazObAtSIgH3zQcMNEMwXp25UT2wU4XeQBh
 AiH1QjgFRK2l0dRBNls2h2FTFMIgRzmhDyPI826IBk2hvyEXc+T50biQvRjMUWXo
 BDhwU8mb3RSZtAa7BDGS+KD2f2Xc7mB6AoVLaxxkRKg8owP+oCRtkJgFH4njNJ1L
 D4I/w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kunakn-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 11:43:20 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 2 Jul
 2026 11:43:19 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Shuvam Pandey <shuvampandey1@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Donald Robson
 <donald.robson@imgtec.com>, Sarah Walker <sarah.walker@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
In-Reply-To: <6a456012.eb165e5c.113c2a.b71d@mx.google.com>
References: <6a456012.eb165e5c.113c2a.b71d@mx.google.com>
Subject: Re: [PATCH v2] drm/imagination: Fix user array stride in
 pvr_set_uobj_array()
Message-ID: <178298899967.102946.10188226714183419327.b4-ty@imgtec.com>
Date: Thu, 2 Jul 2026 11:43:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a4640c8 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=P5ZNOoLRPLbA7G_RXJEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: u8VTaf-suaT-E9jg4__zGsHHx888B45Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX2mpPP/JBMZwV
 Qurx54ikPSl1YyHMmMfONTj2JkubDSApNkZKYpApGRnHfqlxB7sWRy1PtlcJC7eYs2UpaaDCvI5
 rqCJJvM4PnypUI+h32ItEbdGGaqn/mdaHWzsvPioGSbUzf7r+QZR7gj/7n05ef6QTugCN4hKeMS
 04MNxdDAIDvc2OwA5vI3B5+re/1CKZTr6E30Yl30qoxDAFRwkbVSP70He+HMW6FNirZloWlq77U
 472VgReWBEL2ywrr/ckXp93XUmEkPqTbGI8QiqfbKTlYEOxDCp0hRHE8cGPJfD1/lWY+TGfPwoB
 P55OAFBbLKRH2qeEvUtgtlkbSq5/T7Ht1qEC41lrBdykBje1HFhSrnP4LWgr4qziDApppkGJn2k
 9eoIiBRYuRFspjfl7mEI0i/HGhDdrMr/S5YQDoS9/foObJNj3h4ZUV/SZMYwQOf7axe5Jt8K4si
 MV5Ql33XMmFEKyRbdwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfXyqUnR4AxIUj6
 rMKsSnDqDcYQYYlIQKdOjjLbp235wPhBVJi5aUHMOCVDiH0UNw7do/8wuO/OzAVECCPRyP/iwhj
 0GjMpy9S/ieU9lNDQOKn+TuPLPRdWJI=
X-Proofpoint-GUID: u8VTaf-suaT-E9jg4__zGsHHx888B45Y
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


On Wed, 01 Jul 2026 11:44:34 -0700, Shuvam Pandey wrote:
> pvr_set_uobj_array() copies an array of kernel objects to a userspace
> array whose element size is described by out->stride. When out->stride
> is different from the kernel object size, the slow path advances the
> userspace pointer by the kernel object size and the kernel pointer by the
> userspace stride.
> 
> This reverses the intended layout. For larger userspace strides, later
> copies read from the wrong kernel addresses. For smaller userspace
> strides, later copies are written at the wrong userspace offsets. The
> padding clear is also done only for the first element instead of the
> padding area for each element.
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Fix user array stride in pvr_set_uobj_array()
      commit: 8dc8f3f4c2382fb7d1b1986ba8f33a2466cd3d7a

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

