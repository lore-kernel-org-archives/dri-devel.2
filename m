Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769CECA9EBD
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C201010EA8C;
	Fri,  9 Oct 2026 17:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMVaN8Cz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF2110EA8C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:35:55 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZSPL1620332; Fri, 9 Oct 2026 17:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=hfDRbIVDvoyy72MmzalTRQ8ok3oTjReeawC
 AV4tNXco=; b=MMVaN8Cz38skAZCJDyufjg0bIWxiggCwfHgZ/TBm59lcgEDWCgN
 6PaZ53kd56Ljn0i6mXcOhxcHY8k1bTF2gL/EALKfjt9COPF4YyQixDl+6CzHGRom
 omswCdtNBdkTkancYh5nV+DMuQ9Ugwedi50yN3Evv7pWhsPdGC9U1UqPdi0JsT6A
 gmzlOZXMXhlA7da5LqrrEc4bCGSAymrt3DAJmHuKyVB7PdpwYolyxWVaCUjr+CKj
 dY6++Pk8StxAZ0NVSSLWQGq+TVR3reXiGi7XYgpVCN7cxN28rN5CZo2hb3ox9TwC
 b3FpmjQ8wxbz20iHWL/Dmva7l+0Z8U/vEnQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7002b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 17:35:49 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HUmQA1186375; Fri, 9 Oct 2026 17:35:10 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 699HZ9511192880
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 17:35:09 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id BB4BB221BD; Fri,  9 Oct 2026 10:35:09 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH 0/3] Extend drm_ras for qaic telemetry
Date: Fri,  9 Oct 2026 10:31:49 -0700
Message-ID: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MCBTYWx0ZWRfX/vPqdDC9RrN/
 YtuNnMM98AQZBX1U6u39OY6RgWW5usIu/7lt6Mnxzm0y8SvzZdkzxGsxUEnZIgOv8C2IGfjR7Jv
 SJmimbpa2EDqBOnScLz+IswWDqDvLxsTDsG3u1AzbwgtzpiQ8arul0RtPWdjPxgNoyjIVrrSveg
 L73CC9PZ9fobdTvTXdGoLLUvzdmU1/5xfdVBwbibX2NxzD5sdeoLHX/6zIzBIQwNw/WJnmDW+M+
 Q7MMNu+Ab/GzQQyLvImsAB2YY1M5ooV2xbMYNGT7LGHpA6GtV/GDSiI4oBwH7AfzM0qJ1u11khy
 GBKUMG24gkz0T2y4H9H8ygtJQKPbOfDYeIs7HBTcpbsOFiGoYdrPi+eqOXDpuEEYYl9YfPPGro5
 XKcwag/BPvgzAq4KdQCh8K6+q2Oy8VTJbEVf88x8GnmhEGKaCA3YKK3u0unufFWQUxtF5k4m3SH
 WQZzm7lYTeu52+nmK8A==
X-Authority-Analysis: v=2.4 cv=Zt94uN7G c=1 sm=1 tr=0 ts=6ac925f5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=LHmS43p_Y2w_anzHtZ0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MCBTYWx0ZWRfX81FtWbv8fKB4
 x4YscIEG1o9HvOv4hGBPKk74G+shYBPgwJwdUs7jXzKQoJPjcS14la6ZEjYZ53DC/C0kAUpBA07
 2670eHg9pUPvlMx4SAmYkFy4mUcDjyI=
X-Proofpoint-GUID: w3hP71m5MYF2kiH-kIJKpRVWnhDhNv-O
X-Proofpoint-ORIG-GUID: w3hP71m5MYF2kiH-kIJKpRVWnhDhNv-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090070
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

This patch series extends the drm_ras netlink interface to include a new
node type for telemetry nodes. Telemetry nodes support two operations,
reading and writing, and drivers may specify an optional predoit function
to validate each operation.

Telemetry read operations take the drm_ras node id and telemetry field to
be read and return the field's value and any status reported by the driver.
Telemetry write operations take the node id, telemetry field, and value,
and return only the status reported by the driver.

This extension removes the admin requirement on the list-nodes operation.
This allows drm_ras nodes to be discovered by userspace programs for drivers
that do not necessarily require admin privileges, like qaic.

The new drm_ras telemetry interface is implemented by the qaic driver, which
exposes the telemetry fields to userspace and enforces filesystem-esque
permission checks on telemetry operations in its telemetry_pre callback.

Zack McKevitt (3):
  drm/drm_ras: Remove admin-perm flag from list-nodes operation
  drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
  accel/qaic: Add callbacks for DRM RAS netlink telemetry

 Documentation/netlink/specs/drm_ras.yaml |  56 ++-
 drivers/accel/qaic/Makefile              |   1 +
 drivers/accel/qaic/qaic.h                |  19 +
 drivers/accel/qaic/qaic_drv.c            |  19 +
 drivers/accel/qaic/qaic_telemetry.c      | 463 +++++++++++++++++++++++
 drivers/accel/qaic/qaic_telemetry.h      |  18 +
 drivers/gpu/drm/drm_ras.c                | 193 +++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  31 +-
 drivers/gpu/drm/drm_ras_nl.h             |   6 +
 include/drm/drm_ras.h                    |  39 ++
 include/uapi/drm/drm_ras.h               |  14 +
 include/uapi/drm/qaic_accel.h            |  28 ++
 12 files changed, 876 insertions(+), 11 deletions(-)
 create mode 100644 drivers/accel/qaic/qaic_telemetry.c
 create mode 100644 drivers/accel/qaic/qaic_telemetry.h

-- 
2.43.0

