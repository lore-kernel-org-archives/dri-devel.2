Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8C9CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE0110F2EC;
	Thu, 25 Jun 2026 14:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="O36X3r75";
	dkim-atps=neutral
X-Greylist: delayed 1590 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 14:30:18 UTC
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4923710F2EC;
 Thu, 25 Jun 2026 14:30:18 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P4JFRm405670; Thu, 25 Jun 2026 15:03:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=c
 VifmQeVBQ7jaUQB2tc7mKay8LG0Nz4zpkDoJHyb40k=; b=O36X3r75CqIgtGshq
 mdY8P3UJXefk7LO8psOojD0c3pXReMrwTMgjAygVvs7wf++WA181qtkFbxnoLZHp
 iYr1gWPmIdV3ptnP5gb2FoMCpocO2yMGr4BA8muEf+gtefyjJ0HQCbcPXd2OF20Q
 sBhOB82jYS+eHkoAFcvB8V7vspaxStXADCmlnMMDpJH6RjDLsBnQbJE+alHkr7jC
 ro3uQmR04MTz93hepCmJJcYCVFaHAw4Oi5w9E6PVp1UdTkNiDbr1zwu24dsuPtrt
 iDYIKL3XkL8aGv/djvrIXAvMOTQZgzYVCezM6SzfoRhDsBL5vh8xXw0u3+aVRLSL
 muUUQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f0t728jce-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 15:03:46 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.185) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 25 Jun
 2026 15:03:45 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 25 Jun 2026 15:03:37 +0100
Subject: [PATCH 1/3] MAINTAINERS: Update imagination details
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260625-maintainer-updates-v1-1-35112b2f038e@imgtec.com>
References: <20260625-maintainer-updates-v1-0-35112b2f038e@imgtec.com>
In-Reply-To: <20260625-maintainer-updates-v1-0-35112b2f038e@imgtec.com>
To: <imagination@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>, Alexandru Dadu
 <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 Matt Coster <matt.coster@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=rSOo8mnMdehp5YbyAmqspv3OLoMm135DnGjaXJIK1Ck=;
 b=owGbwMvMwCVWuUfy8817WRsYT6slMWTZmjokLTft/Fjf9zqPxezRjuroaeJfXBaXLtaq+l/Xq
 /Fjo8m6jlIWBjEuBlkxRZYdKyxXqP1R05K48asYZg4rE8gQBi5OAZiInS0jw5OyxTcuaXlWsZm7
 Tg8UiH14Xe99wuLl/1UkV+6XWHM7LYGRYZ5I3o47V1Yni878L7dC7ciToCadZwK5D6Yyz+l8P/X
 rBS4A
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.4.185]
X-Proofpoint-ORIG-GUID: wm4W_tdl7nZTh-KRBJI2kCKzyC2LZT1L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMCBTYWx0ZWRfX0r9N0aJbQd1F
 G1VZr4sar2NpVbmhgGnijWQ1nWk7etE41/EUtcuAkA6QH0tGIlW4MmL5d4E7UdgvawvbLWsy6F3
 OisE5EZpdxIogBU9be0db+rRGCxSfcA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMCBTYWx0ZWRfX00b82d7FE96W
 Yc2hMoaaNgJJm2QxCpQWVbC2qRWVZx0RXHpLgVzh+lbWss2rBMAf0QAEfzhaF9vFlQ/YrZ47vj7
 OYdWt0v8OcGN5ZArXw49QAwWCR2ZqJ3MvTcHWl8MhumRH5jsVsvvXkoN29Ddgo56P5/Pi3D06H2
 NsgFbx6tM6aDipmBK/9cSn/vL8EW32tFHkeYvSgCT88JdVI5EtaplU4V18yMFs+O47s1PH+NOhr
 XPNW1ZpDVB8QcAJUzV7nE6nNJvm0CuMbtc7usBwOMoNaDcHPFvsdHimOSXV4/liTmNEVBXJgl8T
 4gyC4pziW17U4/qGZJQAchm79FA83y2+J3XpNDJB3okcyOCUvjeb1LXp2GgCCeRnbawQOnK4c97
 E3iZrB2vw946TSvFqo994IuTZ5x7G9a8EUTtW+FaWN8oGZYcM21qLP/EYAN+xn55ruDtrPHtrIf
 YudLbsr3KwNFGk87Uaw==
X-Authority-Analysis: v=2.4 cv=ee0NubEH c=1 sm=1 tr=0 ts=6a3d3542 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=e416AD1ZbSsA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=e5mUnYsNAAAA:8 a=r_1tXGB3AAAA:8 a=YL6Xjd1eAAAA:8 a=Z0Oc3OuMG1G1JZ1n6sAA:9
 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
 a=yLS1KB8ZbIgHeRWbGdJx:22
X-Proofpoint-GUID: wm4W_tdl7nZTh-KRBJI2kCKzyC2LZT1L
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

There's a bunch of useful information missing from this entry, flesh it
out and simplify the dt-bindings pattern while we're at it.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 987635948cde..b45e60524762 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12569,10 +12569,13 @@ F:	drivers/media/rc/img-ir/
 IMGTEC POWERVR DRM DRIVER
 M:	Frank Binns <frank.binns@imgtec.com>
 M:	Matt Coster <matt.coster@imgtec.com>
+L:	imagination@lists.freedesktop.org
 S:	Supported
+Q:	https://patchwork.freedesktop.org/project/imagination/list/
+B:	https://gitlab.freedesktop.org/imagination/linux/-/issues
+C:	irc://irc.oftc.net/powervr
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-F:	Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
-F:	Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
+F:	Documentation/devicetree/bindings/gpu/img,powervr-*.yaml
 F:	Documentation/gpu/imagination/
 F:	drivers/gpu/drm/ci/xfails/powervr*
 F:	drivers/gpu/drm/imagination/

-- 
2.48.1

