Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6D60A3816
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fcyn5uXG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DgQDo3LU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CD710EDAB;
	Tue, 10 Nov 2026 04:56:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7536210EDA2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:50 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4ALOX1208150
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6jiJ2cFfcWZ4T7THjimnFH1H/Fp94wK+5rOFj6cs9cU=; b=fcyn5uXGlEOxgr7J
 vKYy5UxYs/jvQMDXNuM+6cIaRvZRTaZpS/g122vf2JHqTWtWL8Ohl5S62Vyh9zgu
 EYDiopSocboliLclnveumNfe2DM/lCGizlSv0Je+AYac9T8Y3nPabbowX7pVrbG3
 T5EqHZeg8cy5BoPIartY48aqyV+LCDSSAG5zR5GyX1cQ++2s0vCVptsRyF5oeFrj
 If7fYZ5DWHn32t2/z2sVW818mMn4xdymBUQZZoSVUgpBk/dxTixGHW0iQ2UOr3ZG
 kwI8wauSDtTpeKB5t3ltKI4oNFYfwaPuEQZJAnu+9Cjh/+265T2CU94EWoTtekCX
 UQtuIg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkhf9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cbf2fd504so306275585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286549; x=1794891349;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6jiJ2cFfcWZ4T7THjimnFH1H/Fp94wK+5rOFj6cs9cU=;
 b=DgQDo3LU7rK8TCu/iCKdLqeOol0p3VaPNu9v2UKZ5+yXvy/hAM9LIto3T5o1IQup6D
 euJH/2V0UENhxiVxq43RPq+vsRYap01V1ruS7M9XSOhloY/GziXQuU83wVhO7snL1A7y
 RqG0Iqdky8H5FFm9vVrGT8n2/kqJsftytcJDhrW3xjvJhlsmKqGWq5vSKH1LYq1ZnPWa
 WADHNnEr1BeQNeXcSvQcnqxthXl6/qtnDzk3kwvD5j7sslqeic/h2YoCBAD5l9Jl/a2o
 zQtaTyAYet69whw7dskNgs2eIQOSAIrqjDWSzkAu9WwRDFs40S0FFHIhWmjYmVT93cQy
 ndtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286549; x=1794891349;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6jiJ2cFfcWZ4T7THjimnFH1H/Fp94wK+5rOFj6cs9cU=;
 b=U1eJoXA50spk5eCW9q0CBi3iPAHAX1on7fIhmxWEModL2eQ4+DpG1i0XVHr3wCNcFp
 RrQBOCWYCpbyjl1m7remmapRTB0mDMXBu5lhhFrT95qncSUtY1voU9TkWl6PQra3WY+B
 Pkk5+cz77UZB7819xouzGvN/kXIZ3KSHoHmELKDxAzZgSEn8gwgbdd3zua0IY6DYaJWy
 Qx+8Dw/WZYXNQSOg0OZm8Sjwe1frs6uX9xnHHW3/bTCye2Ji8ak4NKNIJsdqB7r9W7PN
 sHO7c+4x3+aRcCJQHOVKFKhJ+4u84bx/ovz5nGYnR0O3dWNsw9dfnJwvZkhq/dVFUyW7
 YtWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGHxcGaFzikfJXWMHUxFENmk16yRozP/vXrsWryVHW5c7SHJsSqQdqrvOpZbO51ft8Qv+MYzZYKsxc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8aO6SegA3CLqQQGyg7T+wlNRfgxd9QzPcb22919IHnB7Uh7tFy
 Rs8om4JhQ3uDju0X33ukv7dFUx4U8s1gjwob2suyfKDC+9YVVSDddqVOwBIPNwi+F7Xc3qXYzLV
 sQOwovrKjgcxmMscn7IFsW52JVbxkuT1ozhkgXQk5o3i3edJaB1FQWthGRHnn9+BSCl/YHco=
X-Gm-Gg: AYBFou1R2C7OenHg9tLI6KJo1FlQPZmnajYjmZUnL3+ubFMFJAY4UdWxsO0Huhy6rsA
 75LKZLlqzgCa8mIKgF1umkm6tw9f48X8FRBB+iUIeBhOK67ZFc2hZFDPw3DPoCSBKr98wwU1pE6
 50kiNmezNyrY2T29oA4VvKLPFWLbFfTZ4WPSV7VzDX07waPy2VA0JWU5VH4NcpXGWuYiSyVbg64
 QN5I2YN/40KvtbYvdEz0d7ak4hf+d9xh+S8ocmCMlyScSk2y5Q59EH2Ip5+Z5XHbStn1UE2C/ok
 qgNPFb6VFVdvdK5+pzQPX6SpcbC2jbV1w+tmJ5awSIHWb2o9WBzBKNCmhzlDKdecWV89CdoNhYR
 oB7fT98k4oj+xDy1BNF1ycN89srcQonydDTW6TmetkWeyxCIxrcnMGkwrmSOEtr6fuz+UshCnM/
 FPpGTfAE1l5d/2KPzvLy0FlwCDWBoFHjaoUcnH
X-Received: by 2002:a05:620a:31a0:b0:93e:95ce:539c with SMTP id
 af79cd13be357-9479f1d7b57mr250437185a.2.1794286548812; 
 Mon, 09 Nov 2026 20:55:48 -0800 (PST)
X-Received: by 2002:a05:620a:31a0:b0:93e:95ce:539c with SMTP id
 af79cd13be357-9479f1d7b57mr250435585a.2.1794286548408; 
 Mon, 09 Nov 2026 20:55:48 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:48 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:36 +0800
Subject: [PATCH v8 15/29] drm/msm/dpu: use stream_id to select MST interfaces
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-15-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=2469;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=wXTPAT6DXirv1p5bLwSDFrvILw5gZg1C+bWv7KYQNRg=;
 b=VsbeXqnUOY9/AUHHQoyUfMEWeUc/SwbCyx2IzG5kK6Ql++PzgvL4QgTPtFQ5yV9/u+fSkKYSM
 rL8TwbxXiOAApl5K971OC5RESgCcT8zBNT8tDsh1364ws2iMPuk6nWL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: VUl4rWut5YmWG_4oTVWPWE7fXJCaGQM_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX6Xg/QP2w+Cpd
 +zpTnIWXOwluS8RteFnhxk7nGw0A5HbDJKS5oEVCT3yHzyatLGu+RgFIi6X0/iu5fclu0EMJ9e0
 Xb0P0o99Kj8kI+IyWICYqxKGv8UbRt4=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af2a3d5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=m4XVQ0OAQ8bppu2UB-MA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: VUl4rWut5YmWG_4oTVWPWE7fXJCaGQM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX7WrEDCqUgdKO
 2U2/1lLRCNJTDXYb2/xmROsrhBLYsfBtOu9wlT2v0icNwmbirYmNw80BMFAY1Rvy1rwxTjg61jk
 pov6GRd6Els5vdYNz4TZl3SyWFMf9F03QSBPM5Kzncsqs7YTjnzh+27unTkfR/xw2Nmu4GA/LBJ
 5xZMZ6wT6YjY8GwCSh29qbmPhUkWime2if/JgziE5x1O+MTCJW8GM33KIjFCfEci78gwKUSEZZn
 fKgp8UNm90CbCVQrPrfkG7S7RWamj19H19uuiOp6J5qDz41c7jp1P3gpOWgDsODMi7wGEvImecD
 u5LVMd/mzvMx3sljdUNOzYJWoloN57tdKCXDRVWurmLm2FNbiE6XXdz8GTl6QJHfngkBBhLb7h9
 adwnCpTyIo34o6+KaYLetAv/vUTVxodFy7bwylFPBMWTohUS6PUSfeKsLF5EQCICFxkUBzNhgvP
 Y5pdSNQtIgy2kS5dGAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 5e1c98371181d..a8dcc8c684eb2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1437,17 +1437,18 @@ static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catal
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
index 4942097e76137..9972e209bd580 100644
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

