Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D8606A8B1
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=grMd1WKl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC9F10FAB8;
	Wed, 11 Nov 2026 10:45:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF79D10FAAB
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:44:57 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB6Z9u7581030; Wed, 11 Nov 2026 10:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=K9t1L0eEjks
 dBZsZhvcTxG05ewTRA22gsv1oXPfTU4g=; b=grMd1WKlL1DyGPVb9q44nNb1sfd
 oUTscEx+8Y7owYw2ELEwl2OjrswimDxjfVZAfDJkhF4lS51aCOeLEZANdw4SMGwr
 Clbi7KKPamyLGK8wq661/a5gMaos91TMvPB6CpRK0u/P8uCW9p8pN3q6Zt24BreO
 UfRPC09D4JjQVmJruw6ZO0sQvUywRqszyLr+yl/xJoDJeOX2v+ZCZVYg9z6M81ON
 uGhipL8V4Xa6jNWlyQp0jKuwLzF3V0zwA1iiuH5oqXT7B2SmAcIbXxEn4IUcWm57
 IYhOjD4ILG6DFGr7rmqvJWVl5RFvfgEfDGICYfAs6ZV1OKLqhh2RvDyAf4g==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7prwan-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 10:44:51 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABAilHn010141; Wed, 11 Nov 2026 10:44:47 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-vnama-hyd.qualcomm.com
 [10.147.248.182])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6ABAil10010120
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 10:44:47 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4857718)
 id 4E77E21C49; Wed, 11 Nov 2026 16:14:46 +0530 (+0530)
From: naidu nama <naidu.nama@oss.qualcomm.com>
To: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch
Cc: Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com,
 naidu.nama@oss.qualcomm.com
Subject: [PATCH v2 2/3] drm/msm/dp: Remove redundant force_link_train flag
Date: Wed, 11 Nov 2026 16:13:54 +0530
Message-ID: <20261111104434.2222182-3-naidu.nama@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX2hrk5IH3mI7I
 bf0Wzwh/4/1sDR56flrvroBPvsBI/3IBpmUzw45b5mVzTPt78bccEr5Hyucani+JoLAAb10fuez
 Q+GPlCMWCsjo6htYzlaZkn7NKYahz6g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfXyhG18CF5/7Zp
 ZkO297PzgcU3+H+KPd/SKZA7v+C/bXkAwQ3DKjRlzP96WMzurrPZcE/PP13oJ+Urys7Ux9E4Rut
 PSHHOZbfjfs+ubWaLc64lP9Z6i+VxonFQCDJP1KBknZIjYP4OjYUu2jRbn5S7HNQ8nad5rI6pPb
 Vgrm4ClAK2YN5VCb1kJqlcVni8EbWQABNC3+LKa4X/JxlTiTkj1sqnvJqRw+mvuSpzcxk1ZpJBU
 +VvkKDBGEaoVik6/NoFh3yCEBf42M31LYj5RbFuGB2MscKiQJ6xxAJqMD5pQH0xOcScExliIlky
 /kCQg5XdDyDdqaF9CMIch9lwEJUM/l4YpnAlkCQud7MtijIl19LCg99eBBE0jQcZwQp3KkkI/eg
 Oy4InE8vQ6q/kHibW/JZEONKHIhtcUepC0HnVmO8dMMfru9AZZXV53ia2MqbHV4bpJ95ZCt0Idx
 5InMn9TY8Thf44N4NAg==
X-Proofpoint-GUID: rmLKI8a9wYoDEF5nY46EoqBOuXcGY8me
X-Proofpoint-ORIG-GUID: rmLKI8a9wYoDEF5nY46EoqBOuXcGY8me
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af44723 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=09fYX2rt6u7AJZvDyXUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110042
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

From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

force_link_train is always false when passed to
msm_dp_ctrl_prepare_stream_on(): the initial link is trained by
msm_dp_ctrl_on_link(), and the flag is cleared before stream preparation.
For active streams, it is never set.

Remove the dead flag and parameter. Stream preparation still retrains
when channel equalization is incomplete.

Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 5 ++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h    | 3 +--
 drivers/gpu/drm/msm/dp/dp_display.c | 4 +---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 47647fdec9de..6b9d9a76ba05 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2582,8 +2582,7 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 }
 
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
-				  struct msm_dp_panel *panel,
-				  bool force_link_train)
+				  struct msm_dp_panel *panel)
 {
 	int ret = 0;
 	struct msm_dp_ctrl_private *ctrl;
@@ -2608,7 +2607,7 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 		}
 	}
 
-	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
+	if (!msm_dp_ctrl_channel_eq_ok(ctrl))
 		msm_dp_ctrl_link_retrain(ctrl, panel);
 
 	/* stop txing train pattern to end link training */
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 80d9258501b4..fc884038182f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -20,8 +20,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			struct msm_dp_panel *panel);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
-				  struct msm_dp_panel *panel,
-				  bool force_link_train);
+				  struct msm_dp_panel *panel);
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			  struct msm_dp_panel *panel);
 void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c0c150e2c575..169938ba515e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -633,7 +633,6 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 	int rc = 0;
-	bool force_link_train = false;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 
@@ -651,7 +650,6 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 
 	if (!msm_dp_display->power_on) {
 		msm_dp_display_host_phy_init(dp);
-		force_link_train = true;
 	}
 
 	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
@@ -661,7 +659,7 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 		return rc;
 	}
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel);
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
-- 
2.43.0

