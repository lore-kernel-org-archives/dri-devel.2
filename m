Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C84606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gDVrfEft
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D61E910F9E9;
	Tue, 17 Nov 2026 23:35:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C9710E2A8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:34:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMfEbE269758; Tue, 17 Nov 2026 23:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7vVL+O22Fy4
 xfBwvf4r81a/dEA1a/72qiNfr/2FpCxM=; b=gDVrfEftvuTNSYjOmd5AH1TjJbQ
 +L2OKrQESZn5O/1d6pCsD3OJFsKZadQGfDBYTAu5Y0cbRpkqwmXas13VGahLrnSa
 MH2pbQ4I0Yk175Wx45rSkWdsBdPnNK+mjJ09kZD7iRelVpjq9yqOVjeCgE8T32C6
 xWk686uuxa6MmpP70GCPVbo9enQtKk1KrysOPZyzyH7bVXBWkxzf1IdtL+lgau39
 newMcHXS+2Gy+pngG7wTDD2rE/KMdyFSAQ8UVtai+IVBFLeGxp9y8Yrv3X2aGZbp
 t+XNgEj2dgnk70bD+RScITDI5MsjCsoQ0VhkBF+GrS1HrkdnHvBkM8yeTrQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvb85y1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 23:34:52 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHNYptR3572841; Tue, 17 Nov 2026 23:34:51 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6AHNYp7Q3572833
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 23:34:51 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id 4A5B722B03; Tue, 17 Nov 2026 15:34:51 -0800 (PST)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v4 2/4] drm/drm_ras: Remove admin-perm flag from list-nodes
 operation
Date: Tue, 17 Nov 2026 15:34:32 -0800
Message-ID: <20261117233442.407877-3-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: 6m6-wabHie86zbhek30JOYUGmKHXJrCo
X-Proofpoint-ORIG-GUID: 6m6-wabHie86zbhek30JOYUGmKHXJrCo
X-Authority-Analysis: v=2.4 cv=YfgodARf c=1 sm=1 tr=0 ts=6afce49c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=CU0-bA9xmp4BjaDge1wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MyBTYWx0ZWRfXzetd45caiFhc
 K3sfBgKGzY7piXS961FLZYMX9I1nB+rDWglIvPvn7QFJV9C1dd2/NnrvzyctQ+siqKRKS0SW/nK
 HLgQWeM23VJQFiaKjVqkMl+8tT6j+kA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MyBTYWx0ZWRfX8kHi32OXQjjU
 40m8hxmD77fHyoRzMCKQPNEkk+r0njOj2mAj1922YZH7vwBy7FvyRLvZhjqCRwfc3zfj2nXIsKv
 M3vuTVB+xJc6zXatNns3Bhn/J5ggv/ZVxUcbxt3jvfza0hOP4wdpxEPZAYitt2YFf3M1e+vtrtK
 fD1bD5lYgru5994LmBgMQPvXQmme1HFmV9rbPVbaYXWwdfxHaSExuDhkpLksEX6KPsveBrB0dml
 BLllVCR/vmPTJ2HRwRWlIUA50ZtRRh6enjz07C/F8Nd4hqs7dbPODBk2KxyY3Zyao/XOms0dTfy
 QLty2ffrr3LG6HyHSIXtDXnwjcqdteRhWyrEyKlgJVAIPDx4aYQ4jm+5W/I105tIa1zR+lBsMyW
 3kjPFoI+q3uwV856u2lITwmYgTDLAdpoEEz1dN3cgkJNEPHH1jYUpnt8zubL8Cb9NJZUcqMjJQu
 c9PVtYzt+rvxVTOjkpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170093
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drivers may want to avoid requiring CAP_NET_ADMIN for subsequent
drm-ras operations. However, userspace must still be able to access
the list of RAS nodes to determine the node IDs. So, drop the
CAP_NET_ADMIN requirement for dumping RAS nodes so that drivers
with different permission requirements are still able to use the
interface.

This prepares the interface to be used for telemetry by the qaic
driver.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 Documentation/netlink/specs/drm_ras.yaml | 1 -
 drivers/gpu/drm/drm_ras_nl.c             | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 4c2ac9a1ba3f..a88fdab7a1c7 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -112,7 +112,6 @@ operations:
            the node IDs. These IDs are required for all subsequent
            operations on nodes, such as querying error counters.
       attribute-set: node-attrs
-      flags: [admin-perm]
       dump:
         reply:
           attributes:
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index c9f5e0ceb3b5..ff0dc406c27c 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -46,7 +46,7 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
 		.cmd	= DRM_RAS_CMD_LIST_NODES,
 		.dumpit	= drm_ras_nl_list_nodes_dumpit,
-		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+		.flags	= GENL_CMD_CAP_DUMP,
 	},
 	{
 		.cmd		= DRM_RAS_CMD_GET_ERROR_COUNTER,
-- 
2.43.0

