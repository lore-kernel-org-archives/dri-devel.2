Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48A9C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2081110E737;
	Mon, 31 Aug 2026 08:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bfZgbNJ9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ficLElHy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F7710E734
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:31 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xdLm2924457
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 coR9yXfPqlPQFuihxmTff6nWiGvZ6ChE0ei8ghCFlas=; b=bfZgbNJ9atQBSs8b
 vUJaW7rVhSGCT1yWBJdtlr+S9K9SryPFTi5rB/v+5cEfN2oJPHvbMhTpe9UJ/p5y
 3QFRMScVXC/phEtZjD+T59zlJFh6JLQSXFGr0eCeVqsMQkL/EanBertWonmzycog
 y3pDIb7+jTIK6bm8KH9pAJgVvS6z0cd/zlx24Fe6wWUzrQBthlBcRUpOxjrcmLsC
 00IcNdYWClwJBAmiMYP/1OK4vvXfZEliLlduIBeHrswN+9Dbid63RUzg7UwT0QkP
 qK7fm//7YFczwxXgogkTzfUndOmJwMTSpat43XgEyNpJ9pM9nCUOcqjeguvdf3fg
 ilm/Iw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7w9nsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so280611685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164370; x=1788769170;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=coR9yXfPqlPQFuihxmTff6nWiGvZ6ChE0ei8ghCFlas=;
 b=ficLElHybLsVXfH7BxLWJL0NXhdNdAbcRzlAlhR80u44QbanA1mwkNQ5ookA/NTzBx
 CzFBJki78KBINTuCaJc9f5BMO4KMbhpiVNgXi83x+e6EahUkjMF5gu0edn7hHIqXxy1f
 ZVWR+vkS6vwJssZeuxI1Vhbd3tJZmSLshURMaC6VgQ/5c0AkPlm40ko6DmrZ2ZCkCOtk
 F/g2/OJyY8l2hi1IxGsHEoEqlKMMl7rZr5yvWEiD03uzgg5D4ohIMkuOqR2Gui8VnerG
 AszqM0vzJP0XJiczu2RdMVCIzhw9EEY9gBtCu/LY37XJEXtEL6UaDga4FjLqJRp/1U3e
 MXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164370; x=1788769170;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=coR9yXfPqlPQFuihxmTff6nWiGvZ6ChE0ei8ghCFlas=;
 b=VGKghcx4Qc6D3EPsVsOrOcb6R81MureAK5OK8xAg171Lq8y7/50+WxtX0dNf/Fy5U/
 VGbMwRve71O6lyP/OM3m28F8aS1wEfEcz1eWbC8vsDrrAnLRv05iT/+dSiluXSYY9eZ2
 BKczuZAVpVANj8AOuLyOpOpTUn62irnxuty4T4uvCs6f6OLqKRmzgLO+r2PlWdv/AQUz
 Q3w0XauIYLesZyfwD8ZndRA+Xyu/Cto+z76LvB8ntkCax3KauZLszA5NesQrMnZ329wj
 ZbdbqUI5DS9fPRmP/wus9c3+hTd7OyKHEPyneQDjT+j0VDVl23bB+mTH0yHdh8TdkDnu
 0c0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqd2nAFYVsuj6pFpqPkB0p0XEfswmFmgbQS4Hh/ILjBO+cSyhE6xBL9Ba9rJdNLED96hT8OHCI0zoI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mqYlBOAhjahSzJMotvF6nxSn18I9Kiupvorw0hQ+oqDYX7PS/P
 bhqHHqiAMaGMshDRxCrXL0ED8SjwRdG6eR4xRZl9pI25cZ6nvDbAyOZb9jsmlsHnKT2B0VwusUj
 5ejoUTZRME3uFnFj20wHIty8UuQjCqDoukodeTumKi+ANgUL/B8z3mcxw3NyZiBm1t/kAv2w=
X-Gm-Gg: AR+sD13c9obi8Qjbyyiv9nnRJYI+y6QqYyc35iEJprBvK8ULkqKuzvPO0iKOVu94UIY
 sKA6nF9ddByz2w5Z5rxgWY8gZIY+KvFtLIq7V4EvOMBuFi0ksed71mdkFZp/iFu+obqg5AFVtZa
 Vwb0FYyaFGgiYWL9yp/xxnPkTJc4Udxxto9qnOSuwzIszO9dvo/W7AoI8hOipqL2apY3rJ+s8Zv
 FD4t8H6wR6lQeDOD/17BZ4JslhkvYutFN1xPymgXrln0NRKukdzfictIr50afioIikS/ogz2c95
 gQ9yOuZ5E4nDWwmmSNrPJRWarKCl8x1dj/Gw2w1MvwOyXczX/Ha/zp9teDztRPub6wm5tX8HJTN
 soGqPcPCibSABD1yoA8O8Vonvpzi/UDP8cytC4f158bQ4AiCWXXrUo1gUl5G3L5s=
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id
 af79cd13be357-939138fc2a3mr2854265085a.30.1788164370279; 
 Mon, 31 Aug 2026 01:19:30 -0700 (PDT)
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id
 af79cd13be357-939138fc2a3mr2854260985a.30.1788164369773; 
 Mon, 31 Aug 2026 01:19:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:38 +0800
Subject: [PATCH v6 21/29] drm/msm/dpu: use stream_id to select MST interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-21-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=2465;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=82JlyjBSKXtodVZFszzb+1Hgv/eaaH0tUVHNO5mb/CY=;
 b=x/s94i0DeCe3YCVrBsDph3VVcytKBs9B4N168dh61yZiWSQYSPFF6vUmEMwi5j2EF6ftde2ue
 /EtHpwp9m+RA/NZc5TUdReuV4pTaY1MbGQv3Omr6axIuDc6CT8fMyr7
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a953912 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=m4XVQ0OAQ8bppu2UB-MA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX46faE39cFiqX
 jVLd2rPGXfraVkmIT+ln8/FnTfnXL/4wJl3HAzKOdrOhRxIrxOjPSmG/seRvA1Oj+HcAWHK9Ukf
 lkgCKciAVyw1lymVIgKorXEvhW1OYeA=
X-Proofpoint-ORIG-GUID: U4J4dLggSRcgUwY1iF4jvX8a0e1asEl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX1Z6FOSgcTEiZ
 FB305iV2AH/gtHhfqAo9fDqQ0g/BWA9ojl5U1wvfbKn29ePdINJVeGTTd6nNvWFBWVWFxdmSPHs
 oXowDaOElsBegLtX/kdZ85KzGTPrcEvOsQQXTyAAoMMi6LSX3lN98rdaJPpX3Q8TrKsPndduTKO
 VZPlft+X272o+UfY/uHtA8dNhdu3deEYNQGNKKhPn6FvpQg3Lw85FnK2c5o9G0enKdh2fxuLg/1
 Qj63BmMAJe27mEWh7ONPTKmD4LF/nySQyn/KLv+lscslwQuVhaVAnP3uPs/fTSWsYEYNDEAmnd3
 QpyZhQnTRz8VWsrrDg6by5bBgyyTaACgZV+Uj23e4Kz9jsV2BRR3otDwREm78K4EiE4j+/lONsk
 CEda9LkNbpnA8y8/R1fgig72BBilrZTkG+xvI2QGQbF59Wmq7nAXBZlfvIKKV162Vjc8TZnQYZp
 PMml2iFwd9M6GIiVqWw==
X-Proofpoint-GUID: U4J4dLggSRcgUwY1iF4jvX8a0e1asEl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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

For MST, multiple streams can share the same DP controller, making
(controller_id, intf_type) insufficient to uniquely identify a DPU
interface.

Add stream_id to msm_display_info and use it to select the matching
interface for a stream.

For DSI, eDP and SST configurations, stream_id remains zero and
behavior is unchanged.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 ++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 91cbb0ca521b..004d5fc460a8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1439,17 +1439,18 @@ static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catal
 		struct dpu_rm *dpu_rm,
 		struct msm_display_info *disp_info, int index)
 {
-	int i = 0;
+	int i = 0, cnt = 0;
 	u32 controller_id = disp_info->h_tile_instance[index];
+	int stream_id = disp_info->stream_id;
 
 	if (disp_info->intf_type == INTF_WB)
 		return NULL;
 
 	for (i = 0; i < catalog->intf_count; i++) {
 		if (catalog->intf[i].type == disp_info->intf_type
-		    && catalog->intf[i].controller_id == controller_id) {
+		    && catalog->intf[i].controller_id == controller_id
+		    && cnt++ == stream_id)
 			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
-		}
 	}
 
 	return NULL;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 4942097e7613..9972e209bd58 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -28,6 +28,7 @@
  * @h_tile_instance:    Controller instance used per tile. Number of elements is
  *                      based on num_of_h_tiles
  * @is_cmd_mode		Boolean to indicate if the CMD mode is requested
+ * @stream_id		stream id for which the interface needs to be acquired
  * @vsync_source:	Source of the TE signal for DSI CMD devices
  */
 struct msm_display_info {
@@ -35,6 +36,7 @@ struct msm_display_info {
 	uint32_t num_of_h_tiles;
 	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
 	bool is_cmd_mode;
+	int stream_id;
 	enum dpu_vsync_source vsync_source;
 };
 

-- 
2.43.0

