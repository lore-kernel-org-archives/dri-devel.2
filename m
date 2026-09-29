Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A5ACA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D345E10ECB4;
	Tue, 29 Sep 2026 04:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtg4Ce3C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hBrFOqda";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABF610ECB2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:08 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T474tM2686131
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 coR9yXfPqlPQFuihxmTff6nWiGvZ6ChE0ei8ghCFlas=; b=jtg4Ce3C+VddnagB
 y5yyxDtyLjA3367sOVMchEPAOl4ObiXbsO4/cvLLkir1bYaBo+iHcOaqIGhVEUVw
 R1SaLWYQrQqQGe/jL69J5DXjDcwOx2wNrM0QN3BWXM8A+rKJK72imewp5Kblo9y3
 wksug7aERHWlkIDRWivU2k24qpQbhS84nJcUSDO0S++aih+4LrbjYSQvgahkEVE0
 oAhgFbQ9e6KpjpkH9g7QJakT37kEkMXn9E6VW0P3MbRLttFc3hnMr2YBOG899C3v
 N4rNJUPsgrMb+WPmuQ11Qz1KZbPGmwJiYC52Q2+sA0z524VEwsrPmUO9+YyX/O3c
 MJYcVQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mjgr4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530e0cb072eso70869701cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656087; x=1791260887;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=coR9yXfPqlPQFuihxmTff6nWiGvZ6ChE0ei8ghCFlas=;
 b=hBrFOqda1KBgZRt5ujUSkKPiMZ7F5IUB56fdxCp5sm/yVQD5mHIEJYiAWf2ZHvtzzc
 RkaLw28F2xpMDAZUhojondquX6qYQKK51tdI3g93zmDJnRVgbdKvoCngqcJr3r85zMoc
 UfVlxO1eoSnm4iufVUPhg7Th0kzrME+ML3eYja6Z0l0WXqE2SwykwvBUA2dJ+Nl0tjXU
 MJBMwY20AdFrOWE88e5cj24MJbrk46FZBiUDn56j3z8m2Movehm6v2DDWsUyA35yxIQE
 BYHCB8g5B5yqMVt3uE5iCXO9GZDlt3Tp90Lo6BwjrJ4mI3lBCeLo9CEbShF0BuaSkfl9
 LiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656087; x=1791260887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=coR9yXfPqlPQFuihxmTff6nWiGvZ6ChE0ei8ghCFlas=;
 b=l2wOsBi9qNhj03h2eHtlV8s8D/JjA50mVaWpklFK4v7IMGZxMh7y8SgBUpCUOhmwzA
 w8CTJOnoCVCv0mYi6egSVbrgDMNiFrfA7eyW9oN8wIjgcfCkp8WqI+6Z1Tin+xJNR3R/
 CjIqUKUp1ebMEsM2tRcmQVF/uLqwUz2sZ7MPR8fTUv5BJ57hfmWN8Wt32i36DPuN5Amv
 0p/K/KwaRa6EQQaZn/FBN/w6s/Eh3udl2aREbWP4iNiT3T1aJPiJ9xwv13Oe4JjY2+t/
 7HiWYBrHL5xEz2WQ7X1/FkaZ3BeFOtb6pjyvcUdbFgVlfpEON3Aa4LKReDyWLHnjgrHh
 HVmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGBM1zoJYUBbRRRjArpcW5TMenIevTlMD/28rly1cAcBlJOU8BNj0j8pVBt5QUI/1T8Puollml7rQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nJOlnvolo/2g/te76ba/ryTfFQDbLmnDvYg3BPmYcNJ6Ve2xJ5
 tSAn4TJ/LQc8YXxsH3Rwby3JgpJLJS8ozMGET595cPnForIE9XKeY7pUDu0vJfI8xOrKu/n1GSO
 hWgxdIxbnjjiv+3q7Az/KVz20PIjY7heujigw/t8wG88PKV7c3euoS13iK6JM4M2AcQhucVU=
X-Gm-Gg: AYBFou2iE9tqMX4Ie+I67DrdQgD3MC13pwaS7PEJwlfGLcMeHWjgmPfVSMkAx/QRb5v
 FKng0KoqXCKRTyZkITDhtUlEIlHhYg7B7VmG+Loxrdf54Hfyux2j387zd8a5jU/mPomcymkE7hM
 0SomjNcf4I87eM3ByVzWee8GKHLe0U+nUDz0/7y1KNo57wxx1Q0xzOzBNM1XCdqcvTQgkWUKlR0
 1SvwksCrBbi5o3l+zAwIIKX0b1ICbzkP3dSkHIs+uITqwruW1/xqXQ03JcWxodgOCtqV+AugIgG
 GRomaPE5xHxM7jn6n/PnP6hBRDuU2UMzcESF0M9Ooj5Qf/7SlIhsAkWW5r9KbEkImdCwxcEGG7b
 mmU8UyLmCzS8G5ALI4ccw1YuU1gJZnlpNxUdM5G67cEK8BN5gXH2J8rvJ6nmeTOQ=
X-Received: by 2002:a05:622a:99a:b0:533:3aa2:d8e0 with SMTP id
 d75a77b69052e-5333aa2d9damr113330801cf.55.1790656087260; 
 Mon, 28 Sep 2026 21:28:07 -0700 (PDT)
X-Received: by 2002:a05:622a:99a:b0:533:3aa2:d8e0 with SMTP id
 d75a77b69052e-5333aa2d9damr113330571cf.55.1790656086805; 
 Mon, 28 Sep 2026 21:28:06 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:06 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:45 +0800
Subject: [PATCH v7 21/35] drm/msm/dpu: use stream_id to select MST interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-21-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=2465;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=82JlyjBSKXtodVZFszzb+1Hgv/eaaH0tUVHNO5mb/CY=;
 b=75huUwdtfb27GE2zMYuYJme5I2ccgY0Sc4CV9nSVhK7uu9VmXXMVqxJgzh4uu8WVlNecHh1vD
 +CS8TqQbzqJACtDwwLmoqe07j0xZpdIuQ2SLXcoqvjzy+B4ReuGqQx7
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXyMzF/h2Fwlyb
 8Ajr30c5NeRZaH8sV4FMMMYKyypMwyYnDFwu09YsSZqvydmbdL+sYvyL37SdpifOgKAM/3YEpbK
 m/fjzOZp7ZDyaAcRbSW8KeTZ9AeIAcE04kczdVyZzcclpJKWfa1hZs4fnldszt/iOk9a/JCphUw
 lL7vOALDXJltEO0l8oxK7EEq7g4byRlxiek9mcMbyuzp0ekUkjJAwLOPb/cPV11GiJPoti+L5Oo
 9JV0kVX0o6iEziIIk2qCs8yaUrFQZA0BinROcb+rz+yusCmFqO9VRgz+rwPK4niUCNl8SVLx/A5
 u6TfkQ5jDz4I7/3UO/iLDbdxGHFQzZcIPCwykpWZYWLtw6iTHrZOPOqHRC5f+B5hIBXW+PEmAjK
 Il3+mFobZzccjs+h7bJCYWTk+QZaQzFz+aEq5GP6uUhzBxXZdNEEVXaipf+yDGVmFcoD1QG1WVe
 VU8GHOB1WePQM+LS4QQ==
X-Authority-Analysis: v=2.4 cv=OdgNnRTY c=1 sm=1 tr=0 ts=6abb3e57 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=m4XVQ0OAQ8bppu2UB-MA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXxh6PaJhWePkI
 2rSPATHQNawBGLqueo61Zlp15+iP5d2voU6hd7aig8nf06hDDKvJG8lKVc9rsKplWMJn4KnBQnc
 IsEUal0VRdb+qolkbXbV1agrtDo5Iv8=
X-Proofpoint-ORIG-GUID: d1OQ2wgMcb9HdNvoE6NNRV9l2zRKIYWT
X-Proofpoint-GUID: d1OQ2wgMcb9HdNvoE6NNRV9l2zRKIYWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

