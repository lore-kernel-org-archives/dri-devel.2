Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C3606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NXYmwNRB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vbt95MD9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFC211252C;
	Thu, 29 Oct 2026 20:18:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84784112509
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjT7H1657149
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QGEFaZFYDRa
 QbRQD6wVlp2pG82rEYBh4up00CriDTqI=; b=NXYmwNRBkc84Ed4AGATMd7TBtS1
 vxRu1m4eCeR3Eqbppb10/R90dXZ/pwlzl8QfgAp/vS8Xzq68VfFKTM90Qxjkjv3s
 cIYk3adlJ/aut9W5vkncufqs7jQXF9lv0Eg1Bm5gHGYAmIH3xD7tM3Y5buqDG05g
 E+1lEmAwj0OrFEm2p6GODHtOo11kAhnA2T1SmufoxfCw1i3QRHmouAOGyoNAONUP
 ITXMknc+MYm0KobEQ3uMnGiaAz/xDaiGswoD9xuVOrWHgj4TfFps1lQGvPKuEk+i
 zPjBzkmorz9P5Z0f//Yc8757o3SxzWweFFQdrE27xSyGtxEiCs6Qt5i6F6w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmaunhhb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ae1d132d52so7677a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305104; x=1793909904;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QGEFaZFYDRaQbRQD6wVlp2pG82rEYBh4up00CriDTqI=;
 b=Vbt95MD9yCPz5vDk058rLjAGw7I6vBa41iqChZIWtc4hSBvIgbXXx5kUajCSqczSGA
 1dotlcC6RpjfQKHkSoVltZ2T0FF5ZfnBnJIv5rLhVyMBr5vJ88DCwD25g25BlhLATuqb
 VRPUpHDaUoWDeS0XXgZ1YmLvJmKxpO70cVLqqh5c0FtnZt9NYVcQ5FAwOrkdA4ARKutd
 AsHtG6MeRr0VooBCkU1WKWxHWNDtGz+vo+4vm/hK2gKDW+ZNPzPHF3u5JSMFbIRSu9BM
 4BCY8T/6qePMoRQYt2r/O1XRAb/yQrz5Lfz5IMe7XpDK0Ycv6vbgm0d/RI2cZ78bn/Ez
 Vcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305104; x=1793909904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QGEFaZFYDRaQbRQD6wVlp2pG82rEYBh4up00CriDTqI=;
 b=i/U9EeoNbDHzSQr5DYwtGtOPgOyUZRlKI0vUN1/xegayiNcHc+SwJLqjYYmqDtTSgA
 2vcQMWKO4nsAOsJ8EBs6Kfmzpi+8WBj0nv3EFPC5quCpoxeLnMyB749e+G4miZp/B/M0
 wkH8i5Gs8KBj2gIetWD1/HmznUdgvrnqEvMZmm/Aj5TR9+8MCpxk8NyZK0Lyz5FW7Upo
 BDpHQmML6IiwS4Nc/f07k566vAP6BSy1CtqQ6OQ2zsIT/vb5+NmT5FrY5xC55pofycq/
 kFbwlkmStyHUXfiprznkJ9X5kjG7ef43MDiTo4ns/2xkgk3DC7IeD6VKBYouV7SW7fhc
 AXLA==
X-Gm-Message-State: AFq9FYLEhGDDOEOkzGuCkar9M/2ovWDjZ6qIMx2ON2oMCdf8tIVvInPR
 sfQExbhzeF7v2eMHSlLl2VmP3uYsghtBWY7gd5sQMGU0AHHJ3p67hOLGNcKIJBMZce+G+bLqu+u
 UdfBdjizUIesakL0W1vLqBXwo4sNQIufcYx1tXF745VwJs+0vehXmyCRSd1Q3VhnRkflW1dk+Cf
 nm5s4=
X-Gm-Gg: AYBFou0yYcnfO/L/JS+BCokcFYO8yZuW9Wb6BJWM5jVhVjjYF+wCO5kK1becCpZhdKv
 4/gVcUGWAdwLc5xJupLC0eFaBYTquLb4k7ZHudxbTVUYGckQdbk7NgMahzn3u1sz11KsKihlSOA
 8YAQpL1AfvHcjt5T+SsQFuV0df3NSpq7lIK53SrmHIyczKej7UNU//aOqbRsKgqUWkF6283p+mW
 3yCqjhZCPqdApyyxQ6/4GOi5SAGtoAHfb7U8reBVHerqlBZDJCXlIQy/8bKQ++/EekOkXV1VEcu
 t5FgrzjZEoKbrhCG0zfJdscAXieRSMID2rHDrLSEZWw/5+spWJLvPIuoWb1Rze9XJUJmOmVpGZq
 EDN3xGfsKK3Dlq3Pndm2SFF2Uch4PPcIkq15hLHsY05uYLCYGYUXa2cNT432sr5a0V0ZOPQpeqH
 vdXFEzFj+qrmJ2SnCPzDqlcQ==
X-Received: by 2002:a17:90b:28cb:b0:3a7:ecab:c4c7 with SMTP id
 98e67ed59e1d1-3ae89767d80mr73847a91.34.1793305103579; 
 Thu, 29 Oct 2026 13:18:23 -0700 (PDT)
X-Received: by 2002:a17:90b:28cb:b0:3a7:ecab:c4c7 with SMTP id
 98e67ed59e1d1-3ae89767d80mr73815a91.34.1793305103000; 
 Thu, 29 Oct 2026 13:18:23 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9426ffsm5548239a91.7.2026.10.29.13.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:18:22 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 11/16] drm/msm: Inhibit IFPC for state snapshot
Date: Thu, 29 Oct 2026 13:16:21 -0700
Message-ID: <20261029201730.151754-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -xAGj_Y9b2kqHyn0CYb3f27Ad4L8N_D6
X-Proofpoint-GUID: -xAGj_Y9b2kqHyn0CYb3f27Ad4L8N_D6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX1OJl8vflFjVn
 8c8eqjAfjgptZlzzJ5obLLL4A6/1oHIE2S0Jh4tokti2XoGTZ8WsXV33nigjSywWZNB/UBLvdft
 faEkkrjOaQ90ApWAaUzMTd+hjHm4U0ax7o6A2MyPCYWq9B+SXmBqsoEOrH+RrVzR456o0KPYUui
 nEhAgUkKJOzAP5aHZwY15J7pD3iSflG5TNBuyWKMyxgf2uXaYs16qW2DmeYOkFdNpMwQtU2dhCr
 ccWNDnPqLiPQkFEzZbDGOX6/HKffr9Kq0P/Su2JJ5RPOVPJSAs4G5tThHb43AhXvyYulDon8lgm
 0z8Ig23EBLVl82wH2Sf2TCAwX+iUnMQ1o+0FOVI87o0mBUY4wWWf47ZRczz69Q5cf0tnfZcolLp
 SPuApujNHvtiUyENTQm6tmp7pqKOcwF/QbDpzOlZvNeEZ3+Ea4r1UbJmoYb5uORd1Fv2Zq6mZDv
 /XkNNQAYsgVgS5hbr6g==
X-Authority-Analysis: v=2.4 cv=It2L47/g c=1 sm=1 tr=0 ts=6ae3aa10 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=eWlSUfSnBrBg5eVjM6UA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX6qyxKLxeJyoV
 /WwRHCHnhTel5HDZ3XxM0ZKpDvdFWkzPlA2evGpKxhFhFKNvZ4V3Do7EThwg7KWPAe0cIlKiUZO
 RA5UVWhj94stVSLYyshsFZDXp/9/DaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290079
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

We need the GPU to stay awake for this.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index f12701e286ec..f068315541e8 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -86,7 +86,17 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 	msm_gpu_hw_init(gpu);
+
+	/* Inhibit IFPC while accessing registers: */
+	if (gpu->funcs->sysprof_setup)
+		gpu->funcs->sysprof_setup(gpu, true);
+
 	show_priv->state = gpu->funcs->gpu_state_get(gpu);
+
+	/* Re-enable IFPC: */
+	if (gpu->funcs->sysprof_setup)
+		gpu->funcs->sysprof_setup(gpu, false);
+
 	pm_runtime_put_sync(&gpu->pdev->dev);
 
 	mutex_unlock(&gpu->lock);
-- 
2.56.0

