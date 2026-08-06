Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6D1C56207
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684FB10F214;
	Thu,  6 Aug 2026 15:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="obmfIlFE";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC69010F214
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:04:20 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EmgNo798764; Thu, 6 Aug 2026 16:04:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=S
 O2CyZ8OAs1jnwHQuP7EEWy9OpeLTrkPSsNNoCWe5F4=; b=obmfIlFEREcIEvR1q
 CKKgj+guJoOXEilfDoakTR0Hv4lnIb67pSS3NTavWUerPn+CdMDmWWkOxoOckJT0
 aKU1YCKed4sZjyWOnwymQ1P0XtJm7x1BmkQnNPiTT6AkQSBgIGAt/PFz5Jhmy54e
 I91JspO1jPK0Fz/VxCOoizqi6WyBuKrm2x9an9jDX6wsHhpDp4+mfR+Ok8V76dZp
 buXABi1LSJZiCqzRTiwV2PpsCyWtDHDx7iWJR5gjefvKacHWNYBuFVhVHsEEZ1Di
 nBVjgYBVIByLOhlu1rruCHhTgCqQurSN48sV26etv4b/vbuGaZDK4Mx5m0R+Oc2G
 XrtCw==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72pvhqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 16:04:07 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 16:04:06 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Matt Coster <opensource@mtcoster.net>
In-Reply-To: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
References: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
Subject: Re: [PATCH v2 0/3] drm/imagination: small series of fixes for the
 pvr documentation
Message-ID: <178602864619.161175.4320910165628325620.b4-ty@b4>
Date: Thu, 6 Aug 2026 16:04:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Originating-IP: [172.25.4.151]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNyBTYWx0ZWRfX15/sx/Kxm4pY
 3/k249cvzGamaZBuR71GsS+6jnQU9omNRqIXdMhlgqUzpqIU1QTdUdJqWr3UJHVnKCmDXpREzHn
 WSSMatTDkI/5qvEMxTcu118hmQTAIVo=
X-Proofpoint-ORIG-GUID: 7FtmWVXJq3X6O4w-W1LUukiiaKxrX8LK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNyBTYWx0ZWRfXwqWMJ0FK/Wtb
 VM29F0rL/ZHMxx9hNXCgeOQW9P214ygFo+YTcRgxp+bc5Ka/65hkkYXtJcbbbYXb2VpPk/Uu3pw
 iqa3I2uvHi1Vlmq1tIE62Zc5HKuX43sZOccBNzF6Ba3TNiROWTVuOi5j8IO3vx9phELT1y9GUy2
 T750gIb2LouPMadiDtBoOURmj6uHeso/tM2e42S/NjawajxO4QnN9v1IkWRWDw3I6eFbR7Z2MNd
 PXKeDpAa2j9VikMxfHF4gQEtA4s7oE5P59hM9DXuRrJFKIKC774IU1cWwWKfAlt2MM/lnVJXIhQ
 oB3ES+izmZ0UUlbNDpV/sG3RT+KzHXkYbgV0gpZ/qEP2kNcLDflhAmK8pzdndw+eo4nyguKvzmk
 wabk3ybM/s/Skywvn+NjnKBPCDr/WE6tv/xhr7gh0dRnUOAfrg7bzHkv12FFWhrTfJQUpxjT7+a
 +cSukz0cPsECCLaP7bQ==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a74a267 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=uQ84SqjMEM6cmUzHlGgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 7FtmWVXJq3X6O4w-W1LUukiiaKxrX8LK
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

On Tue, 04 Aug 2026 16:18:26 +0100, Luigi Santivetti wrote:
> Small collection of fixes for out of date and incorrect comments
> documenting pvr code.

Applied to drm-misc-next, thanks!

[1/3] drm/imagination: fixup some docs in pvr_gem.h
      commit: 11bc94f80a85dd77c40dbf099b9450b9279714e2
[2/3] drm/imagination: Update Rogue heap comments
      commit: 62481fecc36f0b1ccef674e03e2ef148eb8cbe5d
[3/3] drm/imagination: Fix repeated typo in KCCB documentation
      commit: 559b757a7122a2ead2e200cc735b008dfc074266

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

