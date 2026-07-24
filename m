Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CA4C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E649610F320;
	Fri, 24 Jul 2026 08:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="RtfNEkn7";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D8210F320;
 Fri, 24 Jul 2026 08:00:49 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O7Vv3E012756; Fri, 24 Jul 2026 09:00:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=9
 u9TbNeMTSewIOxrna5HSE5r7SQWDsc9KN44NkGmu9E=; b=RtfNEkn74ArX6aHjw
 Fjt1+yCBZM8YjAWG/OgZo2HhipzCiJKqYPAT+dhWqkCfz40wVXnNH1ZjBsWKmRM/
 WZ459Iabj+ZiGnDPre3kw9UD70kyBDLGxBoaSkYoCTmpA02g7RxmN14jIRBunRrt
 w7JN+i0aKwiqZCtbIDk7qU0f8Z6NPI+sTsLvjI7bSFgoxfNpAiz1YVEJ0t+m/5BZ
 34gmpiUgiXC25OlxV+v0xBGKEGTMJ50Gs7MchHBcn/5f9fnnmPH/5cB6GzWnZJMw
 xCluB6v+CZ/hIJuaa2ekrgZYoWWVL/V8re1PqaxWtX/Z39xVa/tQV6rltlYdg2VK
 0kh0A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fhq52bgua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 09:00:39 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 24 Jul
 2026 09:00:37 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
References: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: update BXM-4-64 MC1 support
 status & GPU support docs
Message-ID: <178488003797.43576.6485440942998677610.b4-ty@imgtec.com>
Date: Fri, 24 Jul 2026 09:00:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3MSBTYWx0ZWRfX4+RQkHRFk7rw
 cYV/qL+FY/9bKQRK8kI9BCUTxuTB4NCX2R5b1Uos6Kakq+CzFsPzrZ1PbOgUWnsKFjazmyE5RPq
 UNOsdtMGMX3sIA1jjrKXP7CsVdccnBa4S7sywKbVs/D/vKGNJDKoNFNIaMyWJAa+rXY0DZYutvQ
 zXudgcedRZMkflo3rG2ql4T3PllMmlh/4VOepV/O4Q7/eMMWTpLuMh4U3krDVulNB4sxCWCLhSl
 /ZZOUxg3TvjCaY273pGD2eIzVmPEQy6tE9oJI3cVDHsUgI7PxcN7rQv7lOVUQMbVhpFXjZiNQmX
 4rep1WoIfkfWierLTy33zxFRZ6kQXoW2jXrah7qWRr/qZDzCzVRLzSKMo4eH3OQM3dVXYk9agsW
 22aHc1Nr6Nbe6e4N9Xc9R+EPsaBTAVIMW+etg8EFLZWpteihzfgVnzDgrLXcpVcvLt3Tj7ixgQl
 F/uSrmlloKXt8NSWTDA==
X-Authority-Analysis: v=2.4 cv=B5+JFutM c=1 sm=1 tr=0 ts=6a631ba7 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=3nK9Oi-I4VOrm7s85ZoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 7ZjOo9t_D6zlIq3EeeWRs_LchaaimLkZ
X-Proofpoint-ORIG-GUID: 7ZjOo9t_D6zlIq3EeeWRs_LchaaimLkZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3MSBTYWx0ZWRfX1LxwPYDGykvx
 dfJXfIpYUqdLtluKWmfQdvEQBpJlw/VNs5AmIPYSx5PuUSKrjphRVc+PG9tjRP2+yoGYiQq8HCH
 9OLH5oKWgWJ/OdLgVb0nMvl9DgwKySY=
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

On Mon, 20 Jul 2026 12:37:11 +0100, Frank Binns wrote:
> BXM-4-64 MC1 (with GPU ID 36.52.104.182) support is in pretty good shape now,
> having gone through a full Vulkan CTS run and there only being a handful of
> failures. The firmware was also recently merged upstream [1].
> 
> The first patch in this series updates the GPU support documentation to replace
> SoC names with GPU IDs (BVNCs) in order to avoid the documentation getting out
> of date / out of sync with what's supported.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] drm/imagination: update GPU support documentation
      commit: 9b33d8e063f62074b729c52b052cc306b9369714
[2/2] drm/imagination: promote BXM-4-64 MC1 (36.52.104.182) to supported status
      commit: e55fead22ff9ee047ab9f1903860c4b43043514e

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

