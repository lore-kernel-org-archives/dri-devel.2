Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31354606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KFhXYTCQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G/SLa+ri
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B249112159;
	Thu, 19 Nov 2026 08:26:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D61D11214F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vEHa2935539
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6jiJ2cFfcWZ4T7THjimnFH1H/Fp94wK+5rOFj6cs9cU=; b=KFhXYTCQTzU0T9am
 L6oM9f1G5RQ6sARtwtFideE1kyur9o21yIa9sdtC5Zq+VG/Ike6NkZ61PhhcucNH
 cWcld/L6yvN//lclvNBM9SqahdS3sqrPfsnHCQ4JVGooEEEEyN0Tzg07jLExy712
 cpym1nc+LSb+sKC9d6kpMtmP7UnpDGx8SOG+07JCJmUdeP5sFwy4dbTq363ElvBQ
 axoOqJlAra1bua5b+coAmsNqtwQKk6A5hHkWmXt0ldEGHCoO0TjvPBS24DXZTSVs
 hdx41anuTnlg+Guw735+fG4nj4idVtQE7wuo91Gx9MCUONB7Ug2PL2xj69oX9l07
 Jg8Jiw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9ekcjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2c0e6653so344004485a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076747; x=1795681547;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6jiJ2cFfcWZ4T7THjimnFH1H/Fp94wK+5rOFj6cs9cU=;
 b=G/SLa+riauVISDqY3yUjpx6LXr6PJFydAcwgvios+9krMYWAKKR+0DAHnZgaqAduhh
 p3srMVMsJZH7s4IGNtuc0GYZja3Sn7QeSmXqKSj0/56LLrvHz+Kqg8VZdO2L9Kkg27l6
 CG1k2REBEYGfkQgwuIgP4wZRSzCHHkXI/wPfWzUMvcpgzJK6sFt002DLM2l2hsKFSPoP
 tDXtxVFBto9zewDw6mMW0KFhqSRocctC3hiCVVdd1pVEydJ/nwhyA98P3izh9SkT96Lk
 Cbeqi2SJOyFSvTNDkqaDTb6DM6nWlx7y6hyMIIjTiJ+xQtBjJch20/bsptB17hxsMJD8
 OpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076747; x=1795681547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6jiJ2cFfcWZ4T7THjimnFH1H/Fp94wK+5rOFj6cs9cU=;
 b=AqxvpLXmLDtLGqRMSRkbcL6TvZVV+izhDMTIFF/VijSUYvf/eG9Q21CWw+qi8tQcyg
 nRVz9nwc3C8N4WhtLKz1WrmCTnQ3y5w9ClPVl77LowBtDE3F1+wt4OH8auBtkMXQIxHq
 qFRlBc7zop+Cxy3JA8rcrtJS4kSjrBEapFa1KHY30Chveoo9iWo94jB5gdQRCMJv6Q0e
 6IS3hAeLSajsF4io9Fqei+v868z4o0aaSbgJErmzQdj4NmzKIsCAHjHunltpz2aH/aZk
 sWFh7QhC+sRm4WdCW+QHIunLNLAhk8V0Cqd+sXF/b0y2MUcEYG/96BYhUKYU3LpHHNZs
 bZlA==
X-Forwarded-Encrypted: i=1;
 AL+hErFTYeEWlkZ0RRJYGNE8EHxR+A5lW2wgNdgFbYA0FB3zsFCVDdowrwEIJ5Qfm/InFhWJMV+pGVrcq1I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z97Y8hQpWAz5N/hgR+QsRWbuMmxQcYp180UlCEMMT1pocBOAS7v
 kibXjsDdjEgI3IeZp6TFMuje1aoC0LPY1R3kVryLKAKaLxneNteIEKK5s8Ou/Ltr4ZDZkeoIwU4
 DHrH6ZAYtYV9G1d8ZCME1kRysZM7AuAdSmzbdE1lhtHUXJ/VBo9PtfND6o27dgwB5MJk29ec=
X-Gm-Gg: AYBFou1zRQGt19klFJ2UbgbapAWYgmyMvlDljSxM5WEQ3uAkxVMUzVwedvjMP19UQoz
 KfVvm3gRSaF0UICSWXdbCh8aA4lR3GGNL/Hoiv8Nm25plSAf/H9aCR79JbxIetrS0e0rq1If/Zj
 YNH6Dtv3NYRxZsDMphvC8deUTn/zUPR3KS0+BvGRlwCYeeZWyymcLfNPKVGSBau5JTXcRBuhpZq
 NcCLrwZT7fDou1ar4V/N2IONSUO8OygjJZiE/SRZLkvg1gdIdSLgKT9IMI4B1OfzGml+eC7+GZ2
 eOromP84OqKs2rdV3uFPBiPIVQj7yTQWKvqitgZ9M9LTEEeRxQ6+HwrBGPBB0MD7Os4bu9akOTP
 911eEZkPzUQF+wsHKNt+W59ebqvdlOVppUfH0PGFtjSVwGtDbRzmFxDHiyQmYu7bU7vNHI2iqb5
 WSBiz/qdCoGTXeJP7A8jvSNfX38l+3SIvCmlL6
X-Received: by 2002:a05:620a:700e:b0:945:f0ca:436a with SMTP id
 af79cd13be357-949995f71d5mr967528185a.2.1795076747413; 
 Thu, 19 Nov 2026 00:25:47 -0800 (PST)
X-Received: by 2002:a05:620a:700e:b0:945:f0ca:436a with SMTP id
 af79cd13be357-949995f71d5mr967525885a.2.1795076746972; 
 Thu, 19 Nov 2026 00:25:46 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:46 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:17 +0800
Subject: [PATCH v9 15/29] drm/msm/dpu: use stream_id to select MST interfaces
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-15-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=2469;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=wXTPAT6DXirv1p5bLwSDFrvILw5gZg1C+bWv7KYQNRg=;
 b=pGhF5oxPjBqKieRi1UII9nLYtUBklqY94eIK+ZbUT5+y/21cnuMDTorlDwTeeNkkKloGBcoKx
 NblVFGZ7aB/D6rwCDl3N1HOfEgsyOuX2VIUHLrAXuKYvDll1opId0OC
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX2lxkwhoHzvLu
 kFqxDVAjQMFHzWB5bK/0RwOoKtaKcCWUCKWAOKtj4PEkC2IRBAPy2iiFpF/Ff7S+RntOLO1uHn7
 cYj2tOjTr/t+KOhg4E9+PmYCjeFyTGsx24yJp9quvztOOcieXTOTjt+k/TgCBVzlHcUdyUwlkBO
 CuUmJnMrk/tHd8kGBwXZZWOfjOKIOqoHUosBP1WLcdurt9D1DXgP/So669lBbh6Re739eDOwT3f
 eNYEkklYVncJxcNrK9qnn1xtS4Z9ijK/4zN+c1CD8BCcLlS45EAewApO0l68dDJ3qvjajYf/c/3
 bNTnCr3K0xUWgD1VmaDXmPaGQ2x6U1sfTAHgd32aylHVaomVA7lvCYh3qfvjDTn2SUp0i9e24Q4
 9BI0tqnIv5l+K4OsrFX4Zx8J0nNJkFw0Np98OuCf1IH1LcQrRw4bwQ9GfYxGigzvQkbL5evzwrH
 QhYw5I2lBeXmt86vVQg==
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6afeb28c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=m4XVQ0OAQ8bppu2UB-MA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TsdDToSv3ZL6pzHIBzA88jcJO_0IujlS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX87tjPUyEmbAq
 ZVBOKluGPnMRkx2ABAP4zqmnoSfbZ0p+Wmc4GDtP33gDtsVicfcfgvsZYXpAq4OcbDj9vY/jNAG
 XmVvZGHObryo7ioWqI6qBGmU4XwXRFA=
X-Proofpoint-GUID: TsdDToSv3ZL6pzHIBzA88jcJO_0IujlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

