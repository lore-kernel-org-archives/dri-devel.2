Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD1CC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8349610E99F;
	Tue, 15 Sep 2026 15:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="iQU1MAc3";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E4810EC2A;
 Tue, 15 Sep 2026 15:13:55 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFA5L34098599; Tue, 15 Sep 2026 16:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=7
 t2g+G++R/ki5jideumLidi70xT8gp90Xsmvtb3vbC4=; b=iQU1MAc3OpXzPwv/C
 TqPuvfDD7lNmygjvbAm3egjst7CnukwSg+UDo/F0vGc3rJsfw6HYHkx2+wJXwRUG
 AT5nBp/efEcsV1dGpT/+zP9u/rqmfIWtdOEFUvHsX+Rzyi7c46QQpXAmnAuo9QYS
 JPu0qem9wsJhqyDSSMEz5XmA7rstNqD0HMui7G7AZrElkgZFRG/ZEeMHOvBG7A3N
 6nFAhOsGRa49YiyDVhi45fEmhwhs0tQWp80zlgIksQeK8hmAubw8XjUxp4WvfkMT
 LUXn+j+8GmACfJnP0ZX4ymyQ7zE7vCW/qNj+eHGYN5QzPLKHV86NEnaUdCdLJfQx
 Vlqiw==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q2e3n-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 16:13:41 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.6.60) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:13:40 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
In-Reply-To: <20260915-b4-upstream-remove-duplicate-ccb-control-init-v2-1-ba0a6ae63a20@imgtec.com>
References: <20260915-b4-upstream-remove-duplicate-ccb-control-init-v2-1-ba0a6ae63a20@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Remove duplicated CCB control
 initialisation
Message-ID: <178948522061.153878.5977074073357015071.b4-ty@b4>
Date: Tue, 15 Sep 2026 16:13:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Originating-IP: [172.25.6.60]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIyMSBTYWx0ZWRfX44XxVtOxGJb6
 8HMxdC74/BIHLFCPg/OmG5vWsI60VU5PvaTtudhJzqRE16EnoxCAc3gBqY7PBs2gi4Nmsw0TGS/
 joCwdD/rEYmVuLYPoM/Y0oRVvtlSxVnbTGQPco4rB9MxEwewB4Ja+9RL/fQG0/ZWtgPGq7bEHiV
 t2ghOJRJgO7QhaD5KEOcKuHc/jA8v6Gfq3UbnhZVLBZzo1IpR0zwF3qOI17hZNzI40BcGuNylf8
 QhLw9QfAsoELoDAyPBX0GnjNOljpddPA8WkDWtqynAOgrJfW+LDVJe3s36E2TLu0FQDVnrM3DiR
 +/2HPpDitD0xEBz1ngbdylo8Eu1P4EUg0Waj9alLIjRNiMNuucPEKtfaiYu/6Kt0ez4qjI9EX+j
 B207esNiLOov88N9lN/uKdKsZYxOd3cF1iXvf9dt0JvhKWabOQSvXdhHFPw/upBONV8DoS3IDST
 7rsFW1oUGIgLHd03b/w==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aa960a5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=hVUt1O5AELcA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=9Y9DRRKRm_cwRAEY0oAA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: WnFgYlvBVPHvxcRdkd27h9N7lBKBZEVx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIyMSBTYWx0ZWRfX8h1UFg4S7F7S
 ZgCQy3viuaUaESmPJLIoPIvcI46eIvn6Six10/RSzzOH7VE6x4tiYhS4N2Tl/3XcUYCbrUDsTgy
 qjn7oIq1yFuRMUWoNghxGMDH8qL1wlg=
X-Proofpoint-GUID: WnFgYlvBVPHvxcRdkd27h9N7lBKBZEVx
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

On Tue, 15 Sep 2026 10:27:26 +0300, Alexandru Dadu wrote:
> The same is already done by the ccb_ctrl_init() callback.

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Remove duplicated CCB control initialisation
      commit: 7d56d181318109ebf92cacb8b16a35decf592101

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

