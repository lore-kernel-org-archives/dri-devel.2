Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FD6C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABC910E12E;
	Thu, 24 Sep 2026 09:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="qApJgsyo";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9967110E12E;
 Thu, 24 Sep 2026 09:39:16 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5d8kD4069879; Thu, 24 Sep 2026 10:39:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=C
 9afxz53kWiwqHYs7N+ZuK5JTDadYoL3iKBYCmYEbIc=; b=qApJgsyoatCIRzxqd
 YIps+WHdstifUPsDoh3tm/HNG+QIv1+MdddsyqtvfrWhLKqWNLHpmfCEjyaGlHdC
 9Z+UE15OHYGefJMvkmecPWq1d6RZkCiifDLSZ+lhkXb3uRabuq99l+YrqpkWmOrZ
 +zMQOYpORN/pVE/WJ7sKuSxc1cumpEW3LJzX94W2rMjKkfkfcopNOzm/hkj3dGsh
 64bDcByv+UIouw1pyy8HV3tdueFhAhy+aruNmGZzQH/56+tNGdCNU/hMAjOtx7qt
 G0Fns5yWQBNpRO3VIKceGV7YuoxdkURbav+CSoH/FfARJLNTCLqmV0HDLDxL/b4u
 8RpBg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gsjftmemp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 10:39:07 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.122) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 10:39:03 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
References: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
Subject: Re: [PATCH v4 0/2] Fixes for map() path
Message-ID: <179024274386.675834.13293711717587004152.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:09:03 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Originating-IP: [172.25.128.122]
X-Authority-Analysis: v=2.4 cv=GPKdgeNK c=1 sm=1 tr=0 ts=6ab4efbb cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ofw6MtmsdEsA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=cuzUy9uT74GBDvu7PNYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfXxo6SSKBpRLYK
 q/gJ/1Wh/s3yvkIzNECEzQrsqgaOoWMvwovMuh/rEJNwSm4Ts0yhVuk0fiOHScoFdyaBb3YD71h
 kZ1HMNAJQmW/w90/qMZI1waiQMKB8UQDAFZ1QkDjkAGuRpH9SVBUe+nq07z4VKklOWu4JSXX+kE
 sL7c0ZBlPcN/y36vYFiYaDlwxRmDM9DR/v3F3twwGZ75G/TnzRPqNBlWyW0w7bCiGUWvubDUkZN
 nGsbhXLiIPrtsfgS5hrT0mv4MPe/3Iw5kEFSaJmdhatRJC0yIFbFqNHLl/kWs+iAwE4OdOPzi8+
 5RwxKS5lRV6WBtbeKf+qLgt/4H+b5/64gHNJ+JGzUXkrt3ydBIthIB3UhnIEQ/tuss6YOeMgEbx
 6O26x6AoJBWzVvXygkb5khApLimtPmNz2t/IGc48zx1jpWqszvqNbng1B3RiMLOXfP9JWhNHQev
 2RazLgQffviMXqOTCng==
X-Proofpoint-ORIG-GUID: g52YinomhWfTFxcA5z9naO1TH8p1Zz4e
X-Proofpoint-GUID: g52YinomhWfTFxcA5z9naO1TH8p1Zz4e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfX52QxbV+EFxuE
 Zpzw7zSxICAul7BnAxXWnf6rQg9xFlQOB6Cn9dH6bYDH486cV7g+AzEwksmqlIFhW7HAVm+oBk+
 uyA9Et/qPzswnZnxwqcLaPM1eWvTa2g=
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

On Tue, 22 Sep 2026 09:56:54 +0530, Brajesh Gupta wrote:
> Two changes in map() path fix a kernel crash and a map failure.
> 
> Patch 0 fixes error path handling which triggers a kernel crash.
> 
> Patch 1 fixes prealloc page table memory requirement for a mapping
> which led to map failure due to running out of page table space.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/2] drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      commit: 7b824c293a6b56de8285a97984c507cba56bc4c4
[2/2] drm/imagination: Fix page count for page table for map() interface
      commit: 0a8224058a5835297dcf4a46bbcd16f77a9fe424

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>


