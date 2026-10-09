Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8601CCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DBE10E1AD;
	Fri,  9 Oct 2026 17:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SU9cqWEO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7224F10EAB8
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:35:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZVuI1016047; Fri, 9 Oct 2026 17:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8ph89gh2mD/
 bMPt6f2nHN70n+MOTT6spwmNgWcpdkG0=; b=SU9cqWEOzPcrQcT/dUW97hO6Zwj
 50l/b4IuQA1tJqrsmOe52Nrx/OO6WRFKjH1/p3k7vwF1VuHUBlMRku43iD8GO/Ec
 7F6MT+s03joDP0UU9Vuc+ZBEmRXhbhZEOS/8HEja4sFEaZ4EA9alXpJYihVf6FGs
 GDoC3JQU2H8iEc4BgN61NNasf2qvkHpB5CiALbYgwl6dyQeeZoycmcMdV03oCJbx
 dcFn/07QGXwe+F5KudNdxhlEGszyTPeLZzz5++Uhspzta0J0cCwpBjTHBRZsPcdU
 HbkqEHu6bfLmgRAw/pUIdoiG1+hjNQWrzbOF3AZvtccDYBnK7uUkt6Z8AeA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8800y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 17:35:43 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZAhq1107220; Fri, 9 Oct 2026 17:35:10 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 699HZ98f1107203
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 17:35:09 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id BF71D2222F; Fri,  9 Oct 2026 10:35:09 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH 1/3] drm/drm_ras: Remove admin-perm flag from list-nodes
 operation
Date: Fri,  9 Oct 2026 10:31:50 -0700
Message-ID: <20261009173152.2436195-2-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: i0MkeIiNjuJJjc6ilVwxMm7jP5hqSrKx
X-Proofpoint-GUID: i0MkeIiNjuJJjc6ilVwxMm7jP5hqSrKx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MCBTYWx0ZWRfX8mp7Gar8F3Ni
 SwI2N1Z5SO0OC2ufdEsn0p3bkVXTqfgXiD7ZpQpxXjQHEIt+u5KXVwYiF2cZMrFAAzKRyodU0KG
 dRo8xKVdHJIychUm+HoGreS4YwCvr8k=
X-Authority-Analysis: v=2.4 cv=JuNkP84C c=1 sm=1 tr=0 ts=6ac925ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=CU0-bA9xmp4BjaDge1wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MCBTYWx0ZWRfX6LFgAmW++LBa
 OshXmG51GGdF4bH5ua0BbzUKirgtRlEJJdaRtna0HEvuzzgpTJeQIWd95VRth4wTGxZ6j+gs3WY
 dEUBx6+x0hXftCJBAPPPeNLkpxUEhi2V45fQw1dlhgiiP7rRqnypOwkzs8l9yoPt+z+TrykfKIw
 igFWbttWtVlL0VfVGg2gl0frYBWqqzP0NS3DkDoSDpOm6OToLcqqJvDPh1X5GIviULJZzIKO4rl
 vq52lOW0aFyDdwH05aWr8hYV2vp2mqHMsd+nrjXIreihUwwW4GU4Q0gMNyDEGUZx+NaRRPoECmS
 tUOgDFiqI68TT1Tk/D2EnNvi6i4S9wpIRrldeh2tC1dgBx2kIeoMzjd29DIPQB1q+qYiXm9aYvT
 ijLVmgOLnahP/JuIDMQyKJDsM8NG2Z5sqaC40m91FC8bWp1NH8L5Erzpp1GUW101UdqRlHD/sMT
 OXycZjxXLBwFETvzCqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
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

Drivers may want to avoid requiring CAP_NET_ADMIN for subsequent
drm-ras operations. However, userspace must still be able to access
the list of RAS nodes to determine the node IDs. So, drop the
CAP_NET_ADMIN requirement for dumping RAS nodes so that drivers
with different permission requirements are still able to use the
interface.

This prepares the interface to be used for telemetry by the qaic
driver.

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

