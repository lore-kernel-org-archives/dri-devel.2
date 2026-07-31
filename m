Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19538C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B2E10E1D5;
	Fri, 31 Jul 2026 08:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="vFA3Dr9j";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D5510E1D5;
 Fri, 31 Jul 2026 08:31:19 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7ucSc1309197; Fri, 31 Jul 2026 09:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=E
 76smia0eoDVyfRD/IwhMVtksPjmoREi/+oIwBxRp3c=; b=vFA3Dr9jURkFq5Zm5
 Mpi9WsHWRmGGTtclZoSDB4xRV9iSLEjy4VV3YhvfWdT+EZ66zPQfSwwzmDx8aWSr
 oOoeIUAt0+nPKsqNnECHw1HEdw9GiQEN9yV8etq6UfbWfF7zNh18k70RjNBo1XIQ
 2S7/nGrk5bMFNTihZehtD2SwfAw6hZhzSxVuBT7GQZO7eyh2c9xzXiI06AIQvptJ
 7zN1DKQC9QCZJOuwtsYfjdA9x3OrNi8B2bKhzk7DOnrzMJ8O9WGmcXPA5JAJeZxO
 5ekVuM0qU29WwzPE1hpzpLscM/VyCsGnDiPsJAwgMWaqYXgoq0VEWaIPO0rk5X3q
 CEYsw==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr2dh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 09:31:12 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 09:31:11 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260729-b4-pvr-device-features-members-reorder-v1-1-d2e18ed8cd5f@imgtec.com>
References: <20260729-b4-pvr-device-features-members-reorder-v1-1-d2e18ed8cd5f@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Reorder some fields in struct
 pvr_device_features
Message-ID: <178548667132.48426.12752129232614984912.b4-ty@imgtec.com>
Date: Fri, 31 Jul 2026 09:31:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.151]
X-Proofpoint-GUID: u4ZKzjm96FgAZW6j_H5CvqRH0HBh9HTD
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a6c5d50 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=k4jkiuy8PZY5HXJIuwIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX/8qUms7mMQF1
 qggD2kOWne5QhZEMFV0R0Yf8c1AeIItx5JrG2yKXFQVfaz8H6sbH8qB6vOMnMySUgpRK78m0A+Z
 ZLzD3UpkL0SX/Ccpo8hMd2myo/B/b9YwFXPLxNmpZpljP58mbscMDgX2LLCHaT8AJSceOR+49eU
 on4c4GtfAHa1uVPVqD/QW9THTbqOCiPyViujMQLjUvsQsnjZLmeBnC/D+SUDSJBJQSvCDXcW9z2
 NHrrAxogUb9fG78rQnQ95nfIHM8uDjb/gRcJjYzh+Z9/jw4RGNPYvCCFOVd04ftD+yoBbOq5itC
 Ln7U/qK6JasGh7KjGRlrjbwYiMZ4s3kkqdh18tYuXuxFBwAy53GEh6oQYFrS4dtsLay+oIrb2d2
 EuQMlLRQf3AGsrF7SSe6GSgIM09pMYmeylpryW7tZGTxiuje6CRsN8FwRKN2GPPxpZHjQa0RP7a
 IBqb88TiTIIRuQatnkw==
X-Proofpoint-ORIG-GUID: u4ZKzjm96FgAZW6j_H5CvqRH0HBh9HTD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX2/wDPifCmajZ
 xRU7uMWnhkF6FhuU2EGT2CCdUVNhmVJG3di/MFKw59M3f3jY+DquVCmI8C2l7WUz//iWpP6ZwD6
 sjbKrvZZUWPGjgJMgykrLGKckpZ/i1M=
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

On Wed, 29 Jul 2026 15:40:25 +0300, Alexandru Dadu wrote:
> Reorder the fields of struct pvr_device_features so they match the order
> in device info enum found in pvr_rogue_fwif_dev_info.h.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Reorder some fields in struct pvr_device_features
      commit: bc47d5937f21c5fc94504f03e18f1adb56d97634

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

