Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209B2C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2300E10EA27;
	Tue, 15 Sep 2026 15:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="jEcL5cdp";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE34610E99F;
 Tue, 15 Sep 2026 15:13:55 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFA5L54098599; Tue, 15 Sep 2026 16:13:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=q
 j/r3fgW8Isdkdf/XC23o6hAyABbc/h25tHRYCNDU6A=; b=jEcL5cdp+WZilb/ra
 0AZQEUTbrXmWVvk48ixAmrTD2csXB7C/rNG/bd1axVsgyVfjBadUPduNo0lIOPma
 25+rLGDG8m98zoy41zJqISIckQdmSBq1Omvz0UQ7c9GtH0Ty5phzSFcd5vRecAUV
 k7Hj/9GERuEStai/QX3pzaWqtQkqyjVfwUm1qmhDsAUnezKhm6GSHWGdWhvpzKeA
 tGxSwDcP4w7OsImTRXLebtF8uL/Rz9ZrDx/5rwvnkDjqN9xKQGn4mWSosjAZW8cO
 WPw9elyMab8gguM2Rl+nOEa1pWkER7arYZP21CSEPtQ0fIyM4LnV5F9D/xfc5aZ7
 XaRUQ==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q2e3n-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 16:13:42 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.6.60) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:13:41 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Matt Coster <opensource@mtcoster.net>
In-Reply-To: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com>
References: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: Firmware interface cleanup and
 improvements
Message-ID: <178948522129.153878.14998918131309775012.b4-ty@b4>
Date: Tue, 15 Sep 2026 16:13:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Originating-IP: [172.25.6.60]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIyMSBTYWx0ZWRfX8iwZFaVnwgQY
 ahNKbweKSbsJwWNVLDrxEc19Go4H5TZjKK5tKYMuXnnOS0AACZFiiMz76iUY22KHBw+/AM8ERy1
 8nYrx7Fy26IO+LOQigCmeQpseAyI1GOaxhv7mPmX3RGbbpkPK+lSUPYexay8JSusTZvyxTWLWpZ
 1dQ46OIN3erVQDVdlnaVflLSu2eITN3W9yjLWP7+KC+MnGoY27lLu3h/MaN8nmudAHV1IpMbskI
 E10RmRr4PVJPtnEFjgu9yWwMvkJTwayJloR4oGmubNqz1E2zb8YlGVgR0gUmoKcAHh2iTXkQ6KY
 5XqkFN2YMckIHwpQVKozYEuOG/MKh6mbt0GUZD299JN56M1dTkE5bMKhoONef+4OzvWGizjnxBn
 WJPG/X443rlD6HHxVLvm64Jsj870I8jhmVY6o/Rkm023BQeMSeTbxZYHcbkproYsacNSwNbuvTc
 YqtIH8ZvGLCCBoEdrWw==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aa960a6 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=hVUt1O5AELcA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=xeOyCs4oyGzV7JhTlrQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: RLbHYDb7B7kKRc137LcEzYIAR5t5HOcA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIyMSBTYWx0ZWRfXzJQGvhTZ1owG
 po/0tu1Ovy7a4la5nG20cHK8/B4aamrdx8dcuudBPyXYH5Uhwnxc41ssyi7r684vu3wFepVxDyo
 iSXrhUY0Ghhgt1GOPRxJdazb7JEWSP4=
X-Proofpoint-GUID: RLbHYDb7B7kKRc137LcEzYIAR5t5HOcA
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

On Thu, 10 Sep 2026 10:56:38 +0300, Alexandru Dadu wrote:
> Series contains cleanup commits targeted to FW interface.
>     - Avoid initialization of never used data.
>     - KCCB member initialized in the correct place.

Applied to drm-misc-next, thanks!

[1/2] drm/imagination: Collect KCCB initialisation
      commit: 05cce7f9b638536c544328ea135edb864f503aa5
[2/2] drm/imagination: Avoid initialisation of unused FW trace buffer pointer
      commit: 109f4e9010c37966d59780f7c76064581064b7f2

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

