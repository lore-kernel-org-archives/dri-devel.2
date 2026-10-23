Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D4606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mKdNy2wH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G4NRZuQC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDDE10E701;
	Fri, 23 Oct 2026 23:20:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FEA10E725
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvBfZ371942
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PImYCQgikueColtwmltOpJlwc8bGmhUG6ZJmVEsXAFg=; b=mKdNy2wH/sX7FwLS
 kKycPfqt4xGo39A76y/IZ0v8++1UOO+34LiPvMnmhjWa1C6P+7ksRu8YoIKrPRw/
 nIIwyhaLO9FEc/kI2+bQKpywHTVcr9G+rTsg93ybF3frNl8sx/28mD5QUZ2qTW/2
 4jABJFCUrqP/BsJp7BBiB1B6/y9bWUtRYCoc2w15sBgMzoGZ9CDiKjGnlQTH1mcd
 HA13RJDC7wDU+GmrmfEaT8OtTmQ1LYjfIhFNK4rypjqIHPSg0Q1rnku8LRMQn9fq
 ifLN9Ji71Pckd1c4KdLqdJuxqnnOpwToaDLI2k5CnZcS2lDmB7zdVb9vmC6TtlG0
 8SJK8w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas89bj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ce7a85f04so280009185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797603; x=1793402403;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PImYCQgikueColtwmltOpJlwc8bGmhUG6ZJmVEsXAFg=;
 b=G4NRZuQC1uoBQ5QDgdL6A38UDGjAg7wCubNzqvTkpffpI48AqBgNpAX8kk465CRC95
 vDybQ1GHudZCe4YnWZ7ZgIL4HXo7VkdMY5DriJGresz9J707+o4iOOc2G3SOn2ET+Pe6
 /dHGL1ezpUz0PosPyLkbR9gfiMJeM5FxDFQxyN+FXv1FafSlKszinZgSUVJxcvuimkIF
 1KafCwgZx9r6QoV0FYaCzYeYHxIdDPBPKa3Vz9rji000LbcPpAawlgiVAcXw1nkvRC49
 /FEgpXoeHyMRj1gMK/fADvY5jE8j4YWDSiUkp9zs5ZcAIWb8LzjSmmJZpz8NAXD0xsXP
 NzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797603; x=1793402403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PImYCQgikueColtwmltOpJlwc8bGmhUG6ZJmVEsXAFg=;
 b=v5OV/2Whhq14hE8Ybdz4H5qdTFrA2THmnHJPFKpk/1JUn4oL4ExjlIUZXMO+Vuzydn
 6q5dnydlXcnNONjZdOarcZCfpd5ixZ4IFJKD2TPs0xw+YbUAKjD8oEFb6m85Ah8Kodj0
 gjefpsVaraWVlVdChvlz6E/7HVXXoqEN0SVRw6Zla39gvJqSJvgspt8JfNfPav8CSUyG
 SafM5k1uHZyd2g1guoM+p+Mno5QNCZS0bCDF/1P8aQR/1UdA9UReR/PZ2EkQzL6P+v2A
 CoTKcLUaGyntAVi5MZhirlDG1C3sGhJrcAXUwgUTnIstFUtY3SDg5bMVYmy80aUD8yQN
 XANA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbd8vS5h91JJkixvrsaCz4RpskklyVkpPKK6SJqG84Cy6SVJWeCQYHiZWVNrNNxDvmzsYrT0ekc7M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ8uOVnF+51HaJBBsVLxbIBboGgELh1IIDmPxjDcYke+bBYmX6g
 yGnoB4wArituNzdHiv3NFuRcP9DIl2zA61n1fYsNCh5Lu1qFcypqPQPfeiWQULMOAMT0qjWuZxo
 9MTftWt1dx/0xnS86peW63VMYocOlxtn2uJgUaUYHTEg6GKoCVZzRmx7eFKi5bvNJnzbTETs=
X-Gm-Gg: AYBFou1qi+feFT30WgDNLEL0Kkox3Zen0TWFHeGmHiTHwcAroJ/sYOIpuNR6AMRkDzt
 dkl8GFyzHf9BtFkv1TFw8cdjS+1VbiNARfQmiuVx3EGWp6HyzuD8alRviwJRCP6/uaK7GRoCGy+
 Z7JM7s4ij2AMcS32T5qWeAglGt/uDGDjNF2zv2jkRBOBrrvvR0VKwBI+xbMPV1QYmL9qNyDjTKe
 JyGqYPRH5sFWXxGDq5BaE0l6jDJkLqPo8FXF5MeapopzU+IIPnxRNVFU/NZH3LoTzELWiefrkEq
 HjR6f+9P0eOgMmiMsMbFnsaUHKy6gjPV8OLrJdW+KvBckj+33toefB5MT/BSNkcSEocQ7aOrVuS
 i46APfXzWtsCkiqP6wKQ1nEzxzOCVYIvwmxlNsnnLFpyYAhdN0fYVc89fB9S4fKlCBHA9q8fFDY
 BeEaUEf+kHmHcG
X-Received: by 2002:a05:620a:468d:b0:93e:920c:c00e with SMTP id
 af79cd13be357-940ef8fd21bmr96414385a.21.1792797602775; 
 Fri, 23 Oct 2026 16:20:02 -0700 (PDT)
X-Received: by 2002:a05:620a:468d:b0:93e:920c:c00e with SMTP id
 af79cd13be357-940ef8fd21bmr96409285a.21.1792797602192; 
 Fri, 23 Oct 2026 16:20:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:19:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:35 +0300
Subject: [PATCH v3 02/14] drm/msm/mdp5: forget the hardware blocks of a
 previous bind
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-2-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8zzii9JdhRdB7nBZfP+Qff9ThpfwQO2kWqv8U5qv/u0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uO+QiUAi8caeeJrs1U5ahmbNpXVYKhX02Xv
 hohVY3UYMWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrjgAKCRCLPIo+Aiko
 1ZhUB/9FCfpp6kqbpXO1FdSNPOOBOdObQF4s4CoMcDGnbhssHsdSzjl/fZhMtOXIHxXOigdjEJq
 Y1EQldjBwSpggJYu5aHSRglselo8o7y3l/DtPyoUaHSijACh1TdH2VbJmL1F86SASURTSkWhv77
 M40b+aGboElMBGcXCYfp+vAhcLss7R85o1T5gzzHGKkTml6JMEOiFfeW5kp6YDQQ7i+e8oQLaxv
 shMMhIp7aZ1YLBAAo6um0L7wfAgc1KQNNVAQOmjqxjL6XaDEorktGjIW74fBEt+yUF4ZrQfD/fT
 QDe1ShH6DIht3O6nh/Pjz+vMS/fHCllSTWn/MUl7IWqZaH40
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX1shhQsqltqGO
 +JeitL105/FaXRB3B6cwPyr4NgX5X/5d62SAw7YVT/8ujo9cCMaG8mnM5KArN+yRyGEQ2hSUmUN
 qJvxUXXr/Syz/6k4CbB15AX9cqlTkq8=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adbeba3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=X8-H6Saci9yJdrauny8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXziRWh6cNYSsU
 qaiU1WolA6C1939KqhS48IzaaaABSTHvV9w8ykgfgNG08bk//pBuQI1IPyAdAdMZM6daUrDut8L
 8KBxzhPNffQsPQvnEG4bLt58haff6qMtJh1mNgOyV3WhJ3Qhpstltf0DVL6c5EJRJxkF8hkhoG0
 qSrQ29wTzuy9TOOQIidCLQIVl6ZMj+Wf1GY2/RQ2UgK7OhS4G6MNg09Buv97Pt2QX0+SwipoMec
 AceV1ijVJQe4fZjRURyVQC0DoAtg7Np2JH8tbnuad+WVP2HZ7t1P5BygdMYvmrqrG+umhqGiOyx
 InH/jj3aZ2Fm6XmFDIS3/XhNDeu2ecMKFcXwyxnGJa7781UfKrauCKisNW5rb26yB6USRt2Y4bw
 QkVBXExNuoiBdUNQkbMKqxhqL+qBRwi+/kedpdcrql4aeY05NZMxOMgQ9Dsijez3mNZ5Z61mCNP
 ptBu/pPXWKybsEsPCHA==
X-Proofpoint-GUID: Zs641wal1sIl836az17NL9TpVXxmo4In
X-Proofpoint-ORIG-GUID: Zs641wal1sIl836az17NL9TpVXxmo4In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

Binding the MDP5 driver again, after an unbind or after a failed bind,
corrupts struct mdp5_kms. On DB820c, binding it after a failed bind
oopses in hwmixer_init():

  Unable to handle kernel paging request at virtual address ffff0004d411f9d8
  pc : mdp5_kms_init+0x264/0x7f8

Since mdp5_kms is allocated in mdp5_dev_probe(), it outlives the bind,
but hwpipe_init(), hwmixer_init() and interface_init() still run on
each bind and append to the hwpipes[], hwmixers[] and intfs[] arrays
without resetting their counts. The second bind writes past the end of
hwpipes[] into the fields which follow it.

Reset the counts when the hardware blocks are torn down. The blocks
themselves are devm-allocated on the MDP5 device on each bind and are
only freed when it is unbound; that leak is left for a separate change.

Fixes: 1f50db2f3e1e ("drm/msm/mdp5: move resource allocation to the _probe function")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3934cd060b27..085c23820f46 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -570,6 +570,10 @@ static void mdp5_destroy(struct mdp5_kms *mdp5_kms)
 		pm_runtime_disable(&mdp5_kms->pdev->dev);
 
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
+
+	mdp5_kms->num_hwpipes = 0;
+	mdp5_kms->num_hwmixers = 0;
+	mdp5_kms->num_intfs = 0;
 }
 
 static int construct_pipes(struct mdp5_kms *mdp5_kms, int cnt,

-- 
2.47.3

