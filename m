Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E5EC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E784610F343;
	Thu, 10 Sep 2026 07:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="DzFhTZKY";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BA110F345;
 Thu, 10 Sep 2026 07:57:22 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A7Ex6t1819620; Thu, 10 Sep 2026 08:57:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=7QjWMb9ZKUDwiFH95RP1smg
 tpL1nnRhIe6920/E4hyw=; b=DzFhTZKYhD00hFFGf1AxBc/QdqDmbHUewwTAHen
 F+NgI+MoYZ4TMA0QeJ7Bwa2xk2ypyZSGvHEtADgfa+U0S9a5fMcV+4DoN4MvybNj
 fN1dHZ/5CbHB1VHbRXK3JcuzV3lMjg+vQchHdXlZLT8skh9b76ux1wsC/+/+fyAH
 bBP0mwWmYQktklQDc3QulDQYCTFOHkhqceoEzWaXJUh4RMbgE+bqBeN/6yGLiYE9
 WBO2mpA75S/pLIf1ZtDgBrAIZqeBUDikEoHHAxVcG8r99jcMQW4OfvpyT0XcYv3u
 4rDt9nvh3kBpbJR1MN4D6YvApKjcRVzrwuiaRc+PNmw32Wg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gkk71r74m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 08:57:09 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:57:06 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: Firmware interface cleanup and
 improvements
Date: Thu, 10 Sep 2026 10:56:38 +0300
Message-ID: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZiomoC/yXNywrCMBCF4Vcps3YglqYlvoq4yGWi4yIpk6QKp
 e9u1NXh25x/h0LCVOAy7CC0ceGcOs6nAfzDpjshh24Y1Tgrowy6Ce2WOSAnrpgjttQKBYwvrGI
 9oWsxkuCaOdW+NiwzaacXM2nor6tQ5PeveL39XZp7kq/fDBzHB6FTLB2TAAAA
X-Change-ID: 20260909-b4-avoid-init-of-unused-fw-trace-buffer-pointer-ad76e5b57945
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789027026; l=858;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=OZjNLF8/joe/xN9JTvPqoL646UfiED62pe+qsMacBDU=;
 b=5KoCO5hxgz/B/O7KffaJTPlWLTMAVS/1DcH2CzhRAQba7UUQoEjqJs0trAYNH8NYaq1FhOpIN
 I0uYv0r6OGiB8ajWmBFKEI2LFZny50W2N3dfIlq5lJUn1moCypAIeFt
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4NyBTYWx0ZWRfX5RVY8vwduGMu
 0mY2wPpxNGLxHUYWbgQubJDdueDP5BZ1wIkUo3ktOv6iLmwoB/X32yOYgRGDwR+ORurhAj5COWA
 LqTW3RcfBAc66hyQUju6S8RZQRgb7bU=
X-Proofpoint-ORIG-GUID: 7NWqo0gB-AKc_U3--aOYfdkdvgYRN_90
X-Authority-Analysis: v=2.4 cv=IqGL47/g c=1 sm=1 tr=0 ts=6aa262d5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=VXORRRnKDO12mk7tN3MA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 7NWqo0gB-AKc_U3--aOYfdkdvgYRN_90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4NyBTYWx0ZWRfX6M0G0mJj4Rvw
 zEL8vAEHgpF+qR6EfLtkdt1MxqsvQ0nC4BJHLbmiXGYRYvIATdCHi7MnLo7AbAki/UKGE4QDj6w
 /6AvYi7mh4vnBaaHsa6evauLu0YLduBhptb3Z4kRiQPddD+72/rozoa/3PLDspJ8W3lJy/qZBIN
 VGEL3H1jvbaNElaM9B+L3xWL6p54XKjz/ZKjf/aN2EAQTaNAeXMOJIQDzr8jVH6XgxthDMSfU66
 SSpGO/Gx2XGAZ10YysSbbeQxiBa9fhRuDv1cRH6ChIpckz55VciplHY8HeCJ0nBVCaqE0GIbPc+
 6kwy/38cZ/UfGX6IEpcdAT8dF979NC26fbB6B6XLnDSWmWVgxmNWjRk/Z+/YXTo8RCgsYQkECRq
 7M+k5E6AQVdAEwwbhwwmfXE3zZk0yt/4B7vb0nO8cXpD7F48gIIuEtcN8G8qTD8tpXYeUK+i/pJ
 N0RyKP7Yt3wklptYLtg==
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

Series contains cleanup commits targeted to FW interface.
    - Avoid initialization of never used data.
    - KCCB member initialized in the correct place.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Alessio Belle (1):
      drm/imagination: Avoid initialisation of unused FW trace buffer pointer

Matt Coster (1):
      drm/imagination: Collect KCCB initialisation

 drivers/gpu/drm/imagination/pvr_ccb.c      | 38 ++++++++++++++++++++++++++----
 drivers/gpu/drm/imagination/pvr_fw.c       | 17 +------------
 drivers/gpu/drm/imagination/pvr_fw_trace.c |  1 -
 3 files changed, 35 insertions(+), 21 deletions(-)
---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260909-b4-avoid-init-of-unused-fw-trace-buffer-pointer-ad76e5b57945

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

