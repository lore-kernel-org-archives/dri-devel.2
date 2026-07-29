Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFC3C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E6910E081;
	Wed, 29 Jul 2026 14:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="dxyb6x8k";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF6D10E081;
 Wed, 29 Jul 2026 14:56:25 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TEL64G1014198; Wed, 29 Jul 2026 15:56:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=F
 T4t0HpKGXhyoDaApEqLlKTEY3zvVaol1te0nu+DdCY=; b=dxyb6x8kHXtwDqUGk
 +qZF5zZvgRbh4FWdBvsfXSvrY5qFjxg51UvRdZiYy6Y0xbymCI0kHQeaVev6nQDa
 z9xcFsWDERTbzWWDFFMsvWUFIzCF0CPY5pC94fdaYj3QwGTCQXwU87/2UGRQ1APe
 7Vm1JmvJnts/0A1p7y1VdJ1bfGYcrsIXND6tCvThs9KxZuV9yAvyTWWyVghknyed
 qxsDJMQ/xy72KcoHfxK2tzZrIrKHtahcv39amVbHDqAQUuLeisSz0rc9O5Ius6Ed
 3zXz1S2WgR34eEk4VFetVLQaVigL3ESeoInMn4dQxPfqggaFHXLEqIpXnzELAPK5
 q8Gcg==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr0htn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 15:56:16 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:56:15 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Coster <opensource@mtcoster.net>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>, Brajesh Gupta <brajesh.gupta@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260724-b4-tracepoint-fix-v3-1-8f8e5e8179d3@imgtec.com>
References: <20260724-b4-tracepoint-fix-v3-1-8f8e5e8179d3@imgtec.com>
Subject: Re: [PATCH v3] drm/imagination: Update the trace point
 pvr_job_submit_fw()
Message-ID: <178533697571.386129.12957790392805634417.b4-ty@imgtec.com>
Date: Wed, 29 Jul 2026 15:56:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.151]
X-Proofpoint-GUID: m27NF8bVW6L0qm9VvlWds2IyD86PdfG4
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a6a1490 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=mpCIVVyYDcOB2u8qxSsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX9DGEGtdTnyaC
 8opqKSOvlnR+gJQZaLs1vxg5tVVRxU+mfgXUD6+ZGYK0bvoNSdg0ga2D+0XLmUox+V9/lU4B/Le
 6JeLRIX+v+rWooXoDpdEVStWMLHXCY/B8HsZFxIkj9NLVFzyDke7sU3y5lbyixBTMbhErF2Qb0G
 vPK1iSXE3+bHiWQMgKHI61i3+SZyGSi/TK8t95CD/x1kK7f1EhrUkBzYQgl+obqwq+xBIMCskNY
 MEIA/0sKT8oS+ZLITQ6CSj1ww4X9HMbw1oLkKqkXBU2ChsJXSSDGTwzCvQ1Wf3Z8knf6nfWgk82
 3lTvO99Rxk4jPxrw/dd+Ruc+7A12LzlxdvWGWkb4lUoEiasTZYVQEqFJmm3vLwWCK5AXPtnf5Vk
 ovMR3Y2Tt1ZyAPxC65YvJ7pv30yojnHZzZJUrz77bpCWJJVDeFvBoRX/ds4HABe8kk75JEO9LQ2
 CzzUG9qIPtfn+K6pIFg==
X-Proofpoint-ORIG-GUID: m27NF8bVW6L0qm9VvlWds2IyD86PdfG4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX7DUrQaHX8zb0
 z0xaIBpAOY0Vtd9nobQy2FYXvCwKhihSrEZJgdUeCIMvED04hqEkEy+BXqy1eRjgwG25QlLv80O
 OySUCbh0RjabSl9cMlo2U2Q0DVnMIfE=
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

On Fri, 24 Jul 2026 20:12:12 +0530, Brajesh Gupta wrote:
> Trace point pvr_job_submit_fw() is used to trace job submission to
> the FW. Currently it is recorded when a command is written to the Client
> circular buffer.
> 
> Move trace recording after writing command to the Kernel circular buffer to
> better represent command submission to the FW.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/imagination: Update the trace point pvr_job_submit_fw()
      commit: c256bd486855d8948aff29e0c97d50712da4e85e

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

