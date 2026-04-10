Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AA0F44840
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834EA10E225;
	Fri, 10 Apr 2026 11:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="enNkEy4D";
	dkim-atps=neutral
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E8C410E225
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 11:21:00 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A8tWQm1652784; Fri, 10 Apr 2026 11:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=zwZKyIDlmCYAqIPSz8Ve7PUxMbAGJ
 2nRrQPzzlqez9c=; b=enNkEy4DDpo81IwZUm0NFQpT7OPg1sj1WJIrQDip1lJpg
 xIKy/VXWTHk2xOcBHrusQ5AgzuWvvTgGmENpASCNw04gHCy99s+y3JFn4n7+VIUY
 nX9WG+sNf6JgIYAhEMVyt1kQfbWAkl+SpQ/UKaIYNUEnwDJaibXWXeskly1O+xZQ
 I48vobJObVzFG5l5rXHVIo+DtzsI82Ix10I7J9rhovxq9ZkTHH3veQVUnvnEzBKV
 6h8cFumPgom5SoihSJDIO/sOyU7qzhdab+d8d97KPX4r6RcaxgmnPCSv4HRu99WV
 c5+m4KCD+C+C0p0zOAX8x7EUhnfChSoNHG2rxjgcA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa1bty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 11:20:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 63AAC06Q005304; Fri, 10 Apr 2026 11:20:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ddgxt2dbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 11:20:55 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 63ABKspm035529;
 Fri, 10 Apr 2026 11:20:54 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com
 [10.129.136.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4ddgxt2db5-1; Fri, 10 Apr 2026 11:20:54 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: maciej.falkowski@linux.intel.com, jacek.lawrynowicz@linux.intel.com,
 quic_thanson@quicinc.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, ogabbay@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] accel/qaic: fix incorrect counter check in RAS message decode
Date: Fri, 10 Apr 2026 04:20:12 -0700
Message-ID: <20260410112015.592546-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2604010000 definitions=main-2604100105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwNSBTYWx0ZWRfXzDibhzpcgZRN
 fjjLDQziVdKaguAVutGACtsZzBQFoIQJ2Xq2fjCJ4s/oOBtDD9RUjBl5kQbVgn4Gz+SQ/QKK1QP
 dYZ4XvHMzeeYJv0EX9F70MN+vRp/vopeNUKfs4eMH+R38bUtpEqW/pL+Ixf9sDIj6MrAyZ9ZtVX
 nIpqjM9wJhM77Mbx7dBuX+3BwlIP7ONb+ZxCyfpTI6kUutOQeRmk2cURcRS/o5grGKYLDtGKWeS
 9EOUXlOwPBc8dqFKirTwPXc2O8+MWBlzM0Mq60uZIpwMqUfmAMaD0seXR6Vp9aVvqOnXn1Ygxyz
 eRGr2ZDlerSdrr5hJcFc9H7ZXxvAnIFqPNwAYb/20CHh7J6tQKiyphof0fS8uLpu/agBwNEDyYA
 zavoUP0G5UDhDnkE1PvKmwDqmzvhVo5nP8Sw2M/nOsAy03FGFJQmSjQ8wkG9SGCFMwo49xehRd7
 iY6Jw8TSvC4d3CgcYLA==
X-Proofpoint-ORIG-GUID: SW_1tgM43IlsRxM3yy9AIXRVfov5J4cU
X-Authority-Analysis: v=2.4 cv=MaJcfZ/f c=1 sm=1 tr=0 ts=69d8dd18 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=9Lnulk2YIXN_pJ_BdG4A:9
X-Proofpoint-GUID: SW_1tgM43IlsRxM3yy9AIXRVfov5J4cU
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

The UE and UE_NF cases check ce_count against UINT_MAX before incrementing
their respective counters. This is logically incorrect and prevents
ue_count and ue_nf_count from incrementing when ce_count reaches UINT_MAX.

Fixes: c11a50b170e7 ("accel/qaic: Add Reliability, Accessibility, Serviceability (RAS)")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/accel/qaic/qaic_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qaic/qaic_ras.c b/drivers/accel/qaic/qaic_ras.c
index cc0b75461e1a..6791af366cba 100644
--- a/drivers/accel/qaic/qaic_ras.c
+++ b/drivers/accel/qaic/qaic_ras.c
@@ -497,11 +497,11 @@ static void decode_ras_msg(struct qaic_device *qdev, struct ras_data *msg)
 			qdev->ce_count++;
 		break;
 	case UE:
-		if (qdev->ce_count != UINT_MAX)
+		if (qdev->ue_count != UINT_MAX)
 			qdev->ue_count++;
 		break;
 	case UE_NF:
-		if (qdev->ce_count != UINT_MAX)
+		if (qdev->ue_nf_count != UINT_MAX)
 			qdev->ue_nf_count++;
 		break;
 	default:
-- 
2.50.1

