Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570BDCD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC9D10EC49;
	Tue, 16 Jun 2026 15:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ez4FUjsk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9830710EC49;
 Tue, 16 Jun 2026 15:13:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxWq13731534; Tue, 16 Jun 2026 15:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NGCTyYltHtin+edsBwFNobrH2uF2WSC4Gqv
 rDXhOO/s=; b=ez4FUjskBKAMM8IX9hyZ24OA5asajAv2nUG3D5ksiYiKf7sT3J4
 /MfOe3A+F0ZDh2EjJI3tSJAnrJCx4IKa/MDMJDS+uz51scDaaFu7nUoZ6VEuV5sE
 caFjUuj2W2bnifuJ9d32qzcKavVuEBUBcdYZr8JHVTRfCB+elp5VGQt05UAhUjzJ
 F91+pm/UzuYP+EFW/VA/2cN+tX23jeeVrqusPKNrdGNt/8uhJFrMBMw86ZcRWG9l
 t54PqJXgAZDi/NR9U65RXHtqQ4ZwUZ0NnyNKbmIdFE58Jy8e7fjEKWCE5mdA5VB7
 7TLlQ5Um2khYLuAdlgsir8RhZ3q+T0NGpoQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1yst28b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:13:00 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GFCxHe009579; 
 Tue, 16 Jun 2026 15:12:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4eu371bkat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:12:59 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65GFCxDS009483;
 Tue, 16 Jun 2026 15:12:59 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-kumaranu-lv.qualcomm.com
 [10.81.89.194])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 65GFCw71009380
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:12:59 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4187942)
 id AFFF26E4; Tue, 16 Jun 2026 08:12:58 -0700 (PDT)
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
 Kumar Anurag <kumar.anurag@oss.qualcomm.com>
Subject: [PATCH] drm/msm/dp: return 0 from audio_prepare when cable is
 disconnected
Date: Tue, 16 Jun 2026 08:12:51 -0700
Message-Id: <20260616151252.3599089-1-kumar.singh@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: o1NDbWc_iquCSxvXsJYvOBoqSMXT37Y8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1NSBTYWx0ZWRfX4BMhFA9Sib/T
 AW3x8FvkLvQN5AZyAQiyf86HDKu38qr6F5NhrOPWEuVjNaBlzwAKTRq+stPvEY6NzGbsXos0cw2
 JmW3RFR87ahTeQchnfLoAVbECdoRSI4=
X-Proofpoint-ORIG-GUID: o1NDbWc_iquCSxvXsJYvOBoqSMXT37Y8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1NSBTYWx0ZWRfX3nb4aP+sNPda
 vFqi2Fm140mbOYU4/wX6wcP/5HqP6jo1P0djvfNhMpau1FPqoM6lbU4/ha1t7d1Ts64jziPFysu
 Mzmd+ebo6C/fBJsV313CknOV7CmjWlGznSVGpjhKcw08aRQJNbeglUD6OqmRBx/5MR6K0ka9ipD
 LAk2xw+qE8NLQkWT3bpj/tCo3dP2TVAt3ExpHlqwJV1MADYURrHZnmmHeEArUGT4znPCbyCYIle
 jlw+E3gbZkxRI8ugZXcew6A8yMRMujzHmpdOqYmyDZwdX8PJ0LmPtsKsCAB0B0MAx1fN4K4qNnr
 9jH74sQFKcuKJCOKridQduR9MYdd9bvN6R2g7dMNpxzHkx46FqQ7+JklFhSnOTP6aQgFazw+0DW
 EdeRhsgYFc1e1SSfqubDE2BtQ/6DstrUz+WQBiQYKj7sJ3mdcapyAkjuIitk24TMtD71OfyM0x8
 6rlTtLDG+14yRb8qOOA==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a3167fc cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=CIlbYoHKnxLhYvk64zEA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160155
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

Signed-off-by: Kumar Anurag <kumar.anurag@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 035e230201fd..8118130a3220 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,10 +284,8 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->active_stream_cnt) {
-		rc = -EINVAL;
+	if (!msm_dp_display->active_stream_cnt)
 		goto end;
-	}
 
 	audio = msm_dp_audio_get_data(msm_dp_display);
 	if (IS_ERR(audio)) {
-- 
2.34.1

