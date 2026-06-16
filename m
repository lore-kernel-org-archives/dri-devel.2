Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8FDCD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C7C10EC4B;
	Tue, 16 Jun 2026 15:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FUBGBwg/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D74410EC4B;
 Tue, 16 Jun 2026 15:13:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxqXW3986552; Tue, 16 Jun 2026 15:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nMfMGCWOd9H
 89jromNavrfYC39YmqX2k1Df5HgZ5blw=; b=FUBGBwg/zNLo8IX3Z6PfkpQSOCj
 f4lghPf3k6R7BERSDK9RGeOjSw0JFKJSNmpuM0synWdSjDmlvhGkCBbjszSk12xp
 aX4abhJh49pd37Ds+Gpm3HHknnBJCp2UkImHtHoU41bhEtuWcmA6gL8qySNehztv
 c8fPeSPhGf948mm79OxpqxRPLk+G2+4ZNpw7pJyZSOA5ZS9zClC3Ff50KTFmWJbc
 XBFiyXLOcvXmV6jeA0hcLiEUhhpTzW1gO9D3cNjIqAU11i/n/K6C7TPUh0Qp3gZW
 6WdX1mR3hNbMDSH9oVBvAB1et985Ex2+cuc9cGgTlSedYGlX3A65ugXULGw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52ttw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:13:03 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GFD12k009993; 
 Tue, 16 Jun 2026 15:13:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4eu371bkc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:13:01 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65GFAnTa006281;
 Tue, 16 Jun 2026 15:13:01 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-kumaranu-lv.qualcomm.com
 [10.81.89.194])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 65GFD1Pl009939
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:13:01 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4187942)
 id 6EC786E4; Tue, 16 Jun 2026 08:13:01 -0700 (PDT)
From: Kumar Anurag <kumar.singh@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kumar Anurag <kumar.singh@oss.qualcomm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v1] drm/msm/dp: return 0 from audio_prepare when cable is
 disconnected
Date: Tue, 16 Jun 2026 08:12:52 -0700
Message-Id: <20260616151252.3599089-2-kumar.singh@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616151252.3599089-1-kumar.singh@oss.qualcomm.com>
References: <20260616151252.3599089-1-kumar.singh@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1NSBTYWx0ZWRfXwrJCmUPA1xwT
 z3i2wNd7m+EDQzPJOyxgQhoZAFEVvQXXl9mI2tuVVJ4JGPD9kUebZUbxwXm7JhKsMejMHh2PiTC
 IoS7++iiViWaYC4uUfwaMMCYmR0vnsc=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a3167ff cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=2H7k_GLycxiurF5OyM0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1NSBTYWx0ZWRfX4HBJ0ApSavLU
 bzD41q8q/0zNQIkHwZc1vfT7D/6x/9EKcDXRF+XIZokq9yaYwqnAOaUEsBfSOgP7qtHHiOLk9Ro
 tzlXmUx43eq32BxiqsWpObJQpe8AkkYpsZwBY5OyUFtYS0yOXrqfadyk/rxIxVnW7Zvg4dKxpZL
 1bF6SanhSMNUqiBwat6viSORQiiI/bu+8mlwFeaxClhar8yBr13S4OSUeNWUptdVALo8hs8zqpm
 ddi6h3GzR32O99wDrBc7Cmn/HF6hD9DkmnW85P0LEYT3c3gMeP9pSWCGvpIFzYXZ6pN2COU6smh
 P+KkMAEQBOM/FiLu6U8PZoQjvK9eDsaAnvJODVX1ax7De+SGJJ8nbeWyjyhbzRPhwFejW3od4nX
 ARNxCDvidRI55+RGbrDrW0uDYXceJ6n/cb9kA6HSFRFDEwC9EgTJAwVPRTY4TMFOjuRkbF0YETJ
 4l3aVswKxmDXJ5cQGUg==
X-Proofpoint-ORIG-GUID: f-OW269UIHsxnv8beBXd6lU3WEo2F_Pn
X-Proofpoint-GUID: f-OW269UIHsxnv8beBXd6lU3WEo2F_Pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160155
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

PipeWire treats a non-zero return from prepare as fatal, marking the
DP audio device as a dummy sink when the cable is unplugged. The
active_stream_cnt guard already prevents any unclocked hardware access,
so return success instead of -EINVAL when the link is not active.

Signed-off-by: Kumar Anurag <kumar.singh@oss.qualcomm.com>
Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 41018e82efa1..df222943ae57 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,10 +284,8 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->power_on) {
-		rc = -EINVAL;
+	if (!msm_dp_display->power_on)
 		goto end;
-	}
 
 	audio = msm_dp_audio_get_data(msm_dp_display);
 	if (IS_ERR(audio)) {
-- 
2.34.1

