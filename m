Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F4AC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC2A10E023;
	Mon, 21 Sep 2026 10:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Y8K3qTHC";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A293210E023;
 Mon, 21 Sep 2026 10:29:32 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7csqV1943936; Mon, 21 Sep 2026 11:29:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=A
 dfKd3OpJhYuGuPouoCLeQGoC1E0KgvcmTJpMq73Z4c=; b=Y8K3qTHC/chh1lxBI
 ziq86TcePEerPRaLDpaKPIbjtqwanptc/RmrPOADW+eBxLP2EiJM/P4Dsyi83j60
 tQ1Uo/PN+NJQ4mbdwz4VmpmGAGL9jIzg528B5LW938Y/rDrBjvoUEpmJmJLqi7g8
 CK0WwGjSMXyxLTiX4CF+nPQIE8mAJQo9ICS312nVR4DpAmuBjD+kQQNXE7zaXmrF
 eOAqAOKoxjEbgu+djPW2Y8zmgV7INYXU4B8/LFldQGpV1s5u3yTtOGOpYxIhBMBb
 213sDeQJvs3KU+n7AZ3Ai2rT0xHkVZ3GGHJe58SiMPOSf6/nC53j8Sif2S/savrz
 YqVjA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq1dxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 11:29:11 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 21 Sep
 2026 11:29:07 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260918-b4-submitjob_tracepoint-v2-1-d9b104de07b8@imgtec.com>
References: <20260918-b4-submitjob_tracepoint-v2-1-d9b104de07b8@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Add job type info to
 pvr_job_submit_fw trace event
Message-ID: <178998654775.160053.17042385965289272906.b4-ty@b4>
Date: Mon, 21 Sep 2026 15:59:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Originating-IP: [172.25.128.225]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1MSBTYWx0ZWRfX3Hlu2fAF35CA
 +XvdVRRnBateNT/zJ19jdqmHms1YpXNf+qiMQC4NKLN3zG6Rel3b8ut0MSsqqK53gdY1I4IiZL1
 YlTEjP9VMaPxngFHk9DW2HlgoQFzQVCEk+xOcmDgELRvOJlKbpJ5YsXNnjUPJpBkzJoAPJXeh/q
 TAH4wsF9ulj/K3nVV6rOofl3ubn+ZoCTgpcxeiyxZJfdk38IF9IDjk198DsPRZ4Tk2I8MLkWbc7
 Et8/JUY6IvH4ljWyEivxEKVc+OTA9OCxTek1xXJZZM/tTht1Jbv5/AuBjnzjiYe+RwE/StqPh1N
 P7/ZTrbDCIXPHhp5Bdtz8bnNtdUFjcudhDXIV1c+RXB83KWW/ggl5S2kHOXvX6lsctCDJZjoww6
 BzCo0ng16zbPrapncEpnfWDyu733QR3Js06jM9fjzoCp+H0HN3Y3cZKh5hRq1n6OdLCxJq3Vi4M
 L4kUYoKgksQYKl9+Sng==
X-Proofpoint-ORIG-GUID: iMSI4Zy_93EtvDKa2Zxo3Kul1E4hFxZs
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab106f7 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=R08nAzAhPX1NFywbOXUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: iMSI4Zy_93EtvDKa2Zxo3Kul1E4hFxZs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1MSBTYWx0ZWRfX06mKX9/VX89X
 HxskzFgun+qmZRNoP8z1Pssjdo743wgZxWg0cO/nRohEsTFYQFtWqyFLqlI42T+SMMYlGhjcNb+
 Fyku9yhCt9JRyMazF2haixHEL7LIb80=
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

On Fri, 18 Sep 2026 09:56:34 +0530, Brajesh Gupta wrote:
> Update trace event pvr_job_submit_fw to additionally capture and display
> type of the submitted job to easily map events as per type.

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Add job type info to pvr_job_submit_fw trace event
      commit: 402491eefc5ea9a40e19b08dccf0c045aec4efc2

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>


