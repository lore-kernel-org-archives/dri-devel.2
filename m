Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18376CD5BA3
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 12:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB1010EC7D;
	Tue, 19 May 2026 12:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="nKH0mkEg";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FBE10EC84
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 12:03:21 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J9JZZN4122114; Tue, 19 May 2026 13:03:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=+
 bUrBzQL+gtAAEm8Rh9u8kDLGxnGdUCWhoslV8vNw5A=; b=nKH0mkEgjr0e2mced
 nNEuh0bVH9/0qOlifkzRlLn5v4teYboUoFJYc3x6HiKX4HTUPpTpuYLqsQ4t8tTP
 Fu27wQdoP6DyB873pNDGOaiGC8STGEUZxd3osvO/rFf2fMS+RgNINWi2zPQtbr1X
 gqt2DtSUjy1MM3lwWTIcZBUisB5X4sbkvOjQ7lYSvMmJfX44webUSfCSVc0gUMJK
 t/g5lG/yb6Rk+gn6+VrrW9DKkGNd8NrK0RkubKRQGZhqgGGBN7bMzX/zdbWsiZ3P
 4Otr6dhwCDhciS8xQAjcqmv3aGyGQLWLGLMMSPI8IgokC/ipCaMh1ycSB9lYzATF
 EYZ7A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjk1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 13:03:10 +0100 (BST)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 13:03:10 +0100
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.8.242) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 13:03:09 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Alessio
 Belle <alessio.belle@imgtec.com>, Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>
In-Reply-To: <20260513-b4-pvr-trace-points-v1-1-81222d1a4c99@imgtec.com>
References: <20260513-b4-pvr-trace-points-v1-1-81222d1a4c99@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Add support for trace points
Message-ID: <177919218931.44231.17828453838593428761.b4-ty@b4>
Date: Tue, 19 May 2026 13:03:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.8.242]
X-Proofpoint-GUID: F3Cgl8Mfu_XCXD537-AP_2eenHTULFmd
X-Proofpoint-ORIG-GUID: F3Cgl8Mfu_XCXD537-AP_2eenHTULFmd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExOSBTYWx0ZWRfX1V6+W+e++/+u
 Q0jmgSPG2pa3t7E6iiBx1V2kqeMLcTFE4FRLkqy0yUVIAhE4gwdWUqapY1qyiLuHSA6jIW7mUwj
 LmyMJRgNEn/eaQOG3ywEW+EZv4dZev2muL9+qYe/4bLNEu7F+ShpvK29YfpGnk2TrXgG3R2NyeX
 tziVviefIob2M6w+Vwf8V6h5H0FgcbEkeBX0/MldXqX0nPisXgU+q7R20ZEy0lJUn8cI8quXrHK
 BloNaj+ZLiJvTW9VUrrlLoq0ZVFQHXsAdE0iqBzdp8+WZqjIx5fBaA21iQpcxtyIeRKyQIEUJPa
 SXK9gL36uqS9N289k2eLtYUC8/i+JWBFCoJF0wwTdPKmQ/uoNIy4A44wXM+rDTTtAY7JqE9MHsz
 rNlNs++xpFnIFpjsMNAQeeyP0lgHCTHB3p9TsGayxol7Jo22+ttYLI3dOSZ9tTuE4Wyqh/Nuerh
 gxvmAC5jQ0z4VwiGtiw==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c517e cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=ojsSdSiVzWgA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=0iB9HyGsN-falOq-CGUA:9 a=QEXdDO2ut3YA:10 a=2zFLWz2JKXgA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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


On Wed, 13 May 2026 15:00:45 +0300, Alexandru Dadu wrote:
> Add support for workload submission trace points.

Applied, thanks!

[1/1] drm/imagination: Add support for trace points
      commit: c1079aebb4de218caa86c44f9a53700d1a582683

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

