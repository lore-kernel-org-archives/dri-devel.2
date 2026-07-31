Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58094C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E4610E1C5;
	Fri, 31 Jul 2026 08:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="dm5C0hY7";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D78710E1C5;
 Fri, 31 Jul 2026 08:31:03 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7trjp1307667; Fri, 31 Jul 2026 09:30:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=F
 Y8QcbSY9xsSwQXkRGtgGqa1+4xY5HAbKergOVNPGAk=; b=dm5C0hY79yF/3a6MY
 IN/vr0srGrBKdoHXENnSh8JScf48sVgK2wHXXNkXsX991dZH0orkn2H/1qV5SNmA
 4WEYGscwl2xUUEs/ue1vGgrRtMMLna9LsRCEv+l6+Z0rtLWBpG3QEkylf1PgWFs6
 WiDtyqrKZ22VxUnJaHMvL3gIVr716FKL4S9Y+xS7Lw/HQrG8CH/lL+/Ciy3D0NUm
 rWeKVI0bT3Tf9BP0XJBCZON28irSbALQ6ejW8oCr5yCaSvMycY6w7c+T0XS0rgD3
 zSf0S69inYqmWXQnfFsbZLunOvwFXpXCr7I6+C43YGlNzwmAoFnEupA4VLqHdmNR
 2Lu/w==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr2dg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 09:30:48 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 09:30:47 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260729-sched_timeout-v1-1-4adc801b1997@imgtec.com>
References: <20260729-sched_timeout-v1-1-4adc801b1997@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Set scheduler timeout period higher
 than Firmware timeout
Message-ID: <178548664778.48267.15281104918659418535.b4-ty@imgtec.com>
Date: Fri, 31 Jul 2026 09:30:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.151]
X-Proofpoint-GUID: A6-mN_5z3JR3bdTi42srUk4xp_PPW03Q
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a6c5d38 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=bqCa0nN3fnH4tW61TVEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfXxby4LKj95USi
 E4aiXX9u3MnlTGjvVoXE7ZN0MtywQ7mmmI0GtkFr/P27k7AuK+sYzVWBLFZIjI8iHOn3CZ9qm1W
 gA5drG2GYkolfBa9ehcnvXRurOwcHidfnQWKXY/JM9rm70XIjAZSkK+N5MLLeRFXsVaiEvhGpF0
 x0sAZyDsMCnjVNxadg9eMSYeA1QRe042gUHRMWEvMUxu2QQElYNmYz+ab+XcppyZdd1gneCGn28
 zZQssilK6QQXjVQ5RN9n5shokGCjfTPK1MfaiLjRqPF2mWPY2ZHM9qRC0DfZuqkNuncwxRjeGge
 CqtQij9ISaY/7wqJ6qgqGCkWiLUFKXhTQNLX8vfsUQyBX0DD1j+w8/n79Ml67LdPkpOqSrzBBvQ
 Ghd1DTjYp8rD1lgd9eLhqhvCSUjYFezm4KKVuqvo9SEVgQ3fzl1sWV+5N+RGmYF893tm8BmTAPP
 kOwKEd4cxuR3XVAZ68g==
X-Proofpoint-ORIG-GUID: A6-mN_5z3JR3bdTi42srUk4xp_PPW03Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX90d/lef4lnp+
 iNwWeQcCa/XGf9fSKUrLjoglHMVCeyU8WQEqCW7cRpgFFqSATBcjJIGfLNjgxC106HtTXHBkitU
 Legm6GA87+QZ+USw1liELV76F1Q1VAs=
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

On Wed, 29 Jul 2026 09:49:08 +0530, Brajesh Gupta wrote:
> Firmware schedule workloads on the GPU and tracks progress.
> It is also responsible for detecting any lockup and triggering recovery.
> 
> Update the GPU scheduler timeout to a resonalbly high value to avoid
> premature timeout at the GPU scheduler end.
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Set scheduler timeout period higher than Firmware timeout
      commit: 2224d6642136767ec01d146d48ffc881b55b32f7

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

