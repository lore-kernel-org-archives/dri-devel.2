Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F10606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=auX5tk2z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E5510E3E9;
	Fri,  6 Nov 2026 18:12:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7903F10E32E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 18:12:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HtP033570512; Fri, 6 Nov 2026 18:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HjDGqDaci2e
 RrPFVvGFecTGt1syzyMZ+l7OOtX2jdKc=; b=auX5tk2zraAlgwz/hQ/9E/WvZ/H
 7EsYGt1ZZhrdTwVJQVVbhBpiWzq/0MZrvoaIhu5c90gQYasdP4vyRKNhqB3sYEjj
 ka6IOcdX7T8ZQnjTuPKNiYABH+gy+/Ql3XeBjkl4seRfQtJZSznP1KU1vPX91GOo
 4zfBCvhQ7q0NIqnSAvsFXkaEBw4RLmvSJ8ccq/LYCXz9djzzOJvL17nq7u2ZK39r
 6u9JCFryiDOALpS9NKlV2X1xfmwl66ybjtxNF1guMY9F6OThFD3x0UydtcMCXmgr
 FnAlUIjxFhOiVQkB+R5cjZSitkYQ5maVKm/mMnDRZqNL4XMCMqCUm2V9l3w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pac1tv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 18:12:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6ICZLs752658; Fri, 6 Nov 2026 18:12:35 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A6ICYED752644
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 18:12:35 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id CC00C215E7; Fri,  6 Nov 2026 10:12:34 -0800 (PST)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v3 1/3] drm/drm_ras: Remove admin-perm flag from list-nodes
 operation
Date: Fri,  6 Nov 2026 10:12:23 -0800
Message-ID: <20261106181225.3333260-2-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: MziZ_b_AQkE1hLsqK6BOwa0GUabMc6kN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfX01sjbgADHMNe
 ezFjqGQpZxcCujMslUnyhuxF8fMnFW8nVUXsYYYBuhRszvcNjI49xuvBi8sGQbrFtevtWS8AtNj
 w6i9ukw1EDri1jkUSAgHH0WoSiXj3blxB+x52Wlk2WSDNsjhX8fyncBYEtg99Dv9AwOUBcC82Ad
 HrsTUpTyfJPQoUjQ52c7l0wfOD7BZNHfUBd9mExH730GC8nhO8JI/YAOeQZVxnELRcI4v1A0YBG
 g6fbwPfqKrvpfT5Wt5aq3wpDOqV8MXwF5jhoZMiK2nakjJt3fUyZzidTk81L0CcQxe5iyz1Q20O
 2euAifAQqBLAWKiNxl86OfdBTR6zKJytGgCRlu0wEnDANXqn1g5eilR5cDFagVI8Yf7Qcf4qG39
 eA0slYz8hzBF8qd69f/P5xfKtYYB17kt/dhArU9TpOCGVk6xkf39OTo/YWlUJVYKdok/dqnq6uT
 cuyO6qPgoN3fmHEmQPw==
X-Proofpoint-ORIG-GUID: MziZ_b_AQkE1hLsqK6BOwa0GUabMc6kN
X-Authority-Analysis: v=2.4 cv=X7rHu2Te c=1 sm=1 tr=0 ts=6aee1894 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=YBg2WiTZAUqtoXgWkzMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfX4ABgrLa2Osyc
 5n0FCoQlbI+prLZx/DLhlR+3dxrS7m4UWquwEEyeAL4Dku83MTMZxwKAfPcpwUaF3oq39d79Phf
 tXio5QFzd3n3nKHfEyJtHHoa8hW8d5M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060072
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

Additionally, initialize the return value to zero in
drm_ras_nl_list_nodes_dumpit to avoid leaking uninitialized kernel
memory (especially now that this function no longer requires admin
permissions).

This prepares the interface to be used for telemetry by the qaic
driver.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 Documentation/netlink/specs/drm_ras.yaml | 1 -
 drivers/gpu/drm/drm_ras.c                | 2 +-
 drivers/gpu/drm/drm_ras_nl.c             | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

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
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b099eb67836e..4f4777060a4e 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -130,7 +130,7 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 	struct drm_ras_node *node;
 	struct nlattr *hdr;
 	unsigned long id;
-	int ret;
+	int ret = 0;
 
 	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
 		hdr = genlmsg_iput(skb, info);
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

