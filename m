Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E81606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RgJL8IhN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516A4112504;
	Thu, 29 Oct 2026 20:30:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D81D112517
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:30:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjY0f2138527; Thu, 29 Oct 2026 20:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Qylvyd3LbkD
 ZI/YijqDemVIF+I1Y3GPXLKPWYRaVXZE=; b=RgJL8IhNjYvEKkzOOnmz/JYffVJ
 RK/PKKw8jJ28VmNZGcIsy3P93rXzEGFa4QdQ4WEzNKrpRoV4pzztIW22Sj0kgrWQ
 tzwKB4uiC5mIGycv1IAFgWa+YAAeJV6yk7UvesDopkAcUpx2Ax6VEKbzrVOCQnjp
 Bua5Pppb+ELMyoLka0mOoAQrY7igax6GpkEtPQBkAdVBRI2UFywiOtsB9m2ZB7zm
 snw5E6fupwKpqyx1gbu+w36RFJH7WvcC81Hi0BGmaqKoWr+opOxlDHrQyyRos+gG
 j8n+vp/ft3kK46Yx0BrkMV9u1f6fGIJYqHPd8Xcl4E+8fDdA375igt2evxg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a22nxn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TKUEJt2912025; Thu, 29 Oct 2026 20:30:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69TKUD832911998
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id D042421A84; Thu, 29 Oct 2026 13:30:13 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v2 1/3] drm/drm_ras: Remove admin-perm flag from list-nodes
 operation
Date: Thu, 29 Oct 2026 13:29:58 -0700
Message-ID: <20261029203000.1763447-2-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfXzlREBVT6OWVZ
 NODQe+SpyE+J0giwPxYdvYLQA1DzgcRQzs5hfyecUI5OjKSuOgv5ayIvjPVmENlz2FnWr+Rp2x/
 2S5Ynenymj3VqdBRd+0Dq/ppsBLWy8T0J8KUoedHIBQtxdMC0l4xEfeUvAW+kgEeyTdSyBO96b/
 1NwxZLgBf/2Mx/CK3W0ZlAsxsONUTziEJ5w9hQWw1pecA9HAWK8Frl8Hc1jdnnUxQtwAFfKUwHg
 pO/v6lkJg0SWANxR3MaJeaKhFNDcqUM7iSXCMjh4KLUZH/l0U02xr2PJNWQnBUTeUUyCJ7anlI8
 jjJZz9y9Ic5tHkBKtgzbjU3FOxSs3RvyFLPhlrXtxkQN0f7qwuupd1BH5JmBKMMeLef/yy6EfEY
 GtM67pi901IQeKcWScLYIwLaHDdsC/3wO2NcTk2Nrv9xUZYGk7P+T8t+uUJm5kTfTR+glFW2qQD
 GscIWhC2pkU8Pgt2FHw==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae3acd7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=YBg2WiTZAUqtoXgWkzMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfX4+Qi3Sc/Qh8d
 6B68um5zpMEIFCnnWi7ZCyKzu3j4bT8MQxHOU2qadj6VpH898431Dw+jifLmZyEOoLTlVRt088W
 482BcnPm9j3oDBWYgCuyB+P+7SB9pos=
X-Proofpoint-ORIG-GUID: dKAO__XuqnRjp1PQiCKwN-xgLIVBt3kB
X-Proofpoint-GUID: dKAO__XuqnRjp1PQiCKwN-xgLIVBt3kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290080
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
memory (especailly now that this function no longer requires admin
permissions).

This prepares the interface to be used for telemetry by the qaic
driver.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
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

