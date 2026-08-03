Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3878C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC6910E392;
	Mon,  3 Aug 2026 10:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="kGS+12mP";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E65B10E00E;
 Mon,  3 Aug 2026 10:30:07 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6737ZLZk652790; Mon, 3 Aug 2026 11:29:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=4
 Xz45P66kgy2KqbSnZjfRVqEpqUwnoGGdKNT/6LnUE4=; b=kGS+12mPC+1wVqD+7
 ATUFSNTRW8mr9l44+7jMZpL3QRwoJ3vKEvjlhQSvmdPUdLLCgavHlYV84x4ne0V9
 DtNQ51foABCsbZQ235xNb8OByYLOytXX1OrwNkcfgPGYrSf3ttQNeEGYAJX10y+T
 N1G8ndjIpxz8SHXWyrv+QMIMOSGbZJpC1a3kFF/qcNALlUwRaKwX3oouQlpsTnls
 jroR/AHNV0dC8Hn6FPJ7jwkGSFhfFi+eqFfUdPCgyexgS2xHUWPEQh9ms20s2uei
 RMPgxS4uEiSv2rLi3rfU5e7HBdZ4/wVBoGTy4ii7c4DbStk/+HuYqDxEBxmHJ4jA
 FXdhA==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72psccs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:29:59 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 11:29:58 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alessio Belle
 <alessio.belle@imgtec.com>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
In-Reply-To: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
References: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: Tidy-up firmware interface checks
Message-ID: <178575299848.80848.11796688985313316357.b4-ty@imgtec.com>
Date: Mon, 3 Aug 2026 11:29:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.151]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MyBTYWx0ZWRfX0mQuXk/jNpf2
 eEQjqK29uppYFAEgVD2rGjeejXCcCASTGm7TFWadhUXH7j/zYEriUX7dyKvBtUMw/X5eNr64ZQ0
 AWUL0xdHJjzh6ToT2qW8cD9bZu7nCNk=
X-Proofpoint-ORIG-GUID: BsnxxOQtHC2niiy7XGTBgMpey8cevEzT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MyBTYWx0ZWRfX/pdQA4382bVG
 u34W+tDOFS12lGtg2MauNoMzoqpnEjB5tu2hTJ96JmWXwZuqJb1TxZKqQrqBg91BOfytIYjsyVx
 pe2Ksd5nCQlHuxnVLntjgH647wzzLe/43l8gLRREl2svsUapi6cuzFuNxrc1gOfG1Y3nguZTiMf
 BlNKPh7yMkeNJ696s1av+3IRY3qCb2+HLKCkdSIVTLyvTgSYHSBHFKB+WPNY6VE5rzSKa3IuOgY
 PwIl7wgWUlRX5QPt31sZ5mbXIUk0BUbyvT9XOLyE8pFcBBOxwoTxcTzccSeTMMNJC8HS0vepein
 Iye1CyRlsIKm/rhGRvscxPens1S+pIKljNrc96ppOl77hbVudmPmoB20YP6U8ScFmJrvRzFnY9Q
 CXSiWvK1Iu5R0Xh7t2Yg2mOEP0hSGCUWGHbg3R0U4Rrd6ucrBZ/TkIsIsgVB4ZfjT+jtVYp1HVU
 6R8YU8aY77/94f5ssyQ==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a706da7 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=XMby5x-gFRhWGDQU36QA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: BsnxxOQtHC2niiy7XGTBgMpey8cevEzT
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

On Wed, 29 Jul 2026 15:57:05 +0100, Alessio Belle wrote:
> The same macros were repeated in multiple header files, and another
> header that could have used them, didn't.
> Move things around to to sort out these minor issues.
> 
> Strict checkpatch reports "Macro argument reuse 'member' - possible
> side-effects?" for FLEX_ARRAY_CHECK() but that's not a problem here.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] drm/imagination: Move all FW interface check macros to pvr_checks.h
      commit: e0c92f0f9e200799eec6ba76d921643fd5b9f2b2
[2/2] drm/imagination: Reuse layout check macros for MIPS FW structures
      commit: 173dceaed68eef074b77278bd92e6fdb4e09606d

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

