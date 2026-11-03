Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B35606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eyY2rMRs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eUkl3oK3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312B210F938;
	Tue,  3 Nov 2026 23:19:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A644D10F935
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:18:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3LKeBY854649
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 23:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UUiqxGBqlqk
 yCyP/zaZbA61tDabtLvEYu68IDkN9RnE=; b=eyY2rMRsHR+6K+KS2DA9pqAm79T
 QYEZkWpfV8Bp7J6OfSwwJWCQ1mN6w0cPm17EnEqiHiJDY5VmLljBwLe1s/Ov5JvI
 8M5pnabqhGkW97h7lgR8EDZJbB3rYpOcPrM5uc+b0qbOtlHNsMUPselLrEsl2ulW
 2O6Jth7TI8I6ZbbNeImELx0NF6f+IQPrKVWqsnGHzyrijuzYuNLIhuWhCjLJKa+2
 pOcLwLfUB/xNjoMAKJFdt3dGZIy23D1zQxrEiX3VPaGbk+eZKDxlHjSffw9bl9EE
 2NGlyb9Bl886Wk6cZcN+wWT98sBRl17XDEJYYVIN6SdkJWtp+BIWVgnj+FQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuv8ffj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:18:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ea785a4decso266585ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793747937; x=1794352737;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUiqxGBqlqkyCyP/zaZbA61tDabtLvEYu68IDkN9RnE=;
 b=eUkl3oK3Ooe34dL/iZHPAzpGnmEilUAVq2+6G8vip/siyugZrrKevEHvhONIpOmpfR
 5sKGLkbu8FupreyC1qdBTmhHYPAW0rDriOcQvCh/T3o80AphFi+trWYi2aMMRZ/kYB0j
 DCNnPx9fW5GVLURar3X2DCHeVakXKtTLdU/1TBpA5LD7qdWo0Ey9tmwqlaC6Up6zkJR2
 3oeMQKel8tUasnBbUq8w1+ganDCWtu7bpXoR98XmcW/xUjqBnokXXHQRIb7H/nHBzLpj
 zG27kZ/WV9c9F/nY2sAEe1k0JH4HQc+G2wjO+C29IzM2vIaTji7knhSjoYd2h00/o4G+
 IYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747937; x=1794352737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UUiqxGBqlqkyCyP/zaZbA61tDabtLvEYu68IDkN9RnE=;
 b=pw55dP0yaNlnge2lPtWOo48UWoVNmt9UWrMREPH1nJnK9knzkzDW2KhpFqIj8iaCZj
 MTB4GojrDPTnglQAelzONsSIqiK7D1aNsgRVuv33f5pkfF3p3fBJLOTtT9WCLVNgSiBz
 MYyCwAd9V2X9xulskoUFomS51rBntUhcpW3gtOg5aEtRhld9vP+uOQCVC4Nw81nJqu2z
 x+xReXW4wuvUZjfV9mcBqC/B9TBBpZ1CbtgFPCbgQrPVF+7cRCrLWjZvQSbqZed2V+kh
 WNlo01JR7YkdBe82yRk85JvPAw9/Pu9f5cJAIRmU8FXIZv7p/eUMEgjEltogxrHmkP4U
 eJ6w==
X-Gm-Message-State: APuU4Z87/eu0ZKXN3+rGJolMjHU+foUbcnA0DPMUusG5V/6B9UeCOVGj
 ESWPbruODKl6AR0DYAUKfWcHBmy8TFWvQKvUHQd7iJM1ix8Br8L0ZQ0/5vLNQaobBxbFmMwuFxN
 l71aS/U6W2oslSbSDbqLEJbnkI0NVjYgLjlXjpXlHT4t3Ygns8UzeN7CgREfpccQ2SNw//bg2FF
 8tUF/7xQ==
X-Gm-Gg: AYBFou2UFz4BRsXHe0PWlinzgnfcbc5BoBmHCvYlTxXo9N+CQtTezdqTgAbCUsXZkBy
 7MeYhnM8XSeHN/9wm5Qaf/BJtGudNQ55ca4dMJZ4FtEkW4a/9gciIg/ymadlKoI42Y+OO6AFfsR
 7Tfx67rGkAd23q+jrORcTYc3IDjFOZMcFiyTUdT2pqgu6qoSmSmyFSEUk1d1vRh60m9GmkKmNYo
 bgDl1wzTvTeQ3cb68+ODdMO8WcwlGBn7N407TaEBQRiOgROsE/Hdd4yad+/cb6h7bOrGAJV/9In
 C7vIH3tGeZrtHyLwe9w8CXaUMvnN4AJn/bPliKCVqdWGJT3NCldnpKPMXMz1JaDkgX6Hvcjgm+E
 TrMey24bpkVixy28yvakL7MTajec/7YxWkFOawjA67yvIblRn12HARPabE47g/sPSbCBbsFDw8G
 /t4dJ4PYX/eLUJ4T50+ryUnOQ3dFgwID+jvWWaqVXd9/KaQ21HRo9xa2L5eg==
X-Received: by 2002:a17:903:324c:b0:2e9:5876:17f1 with SMTP id
 d9443c01a7336-2eb364c41f8mr95274145ad.23.1793747937372; 
 Tue, 03 Nov 2026 15:18:57 -0800 (PST)
X-Received: by 2002:a17:903:324c:b0:2e9:5876:17f1 with SMTP id
 d9443c01a7336-2eb364c41f8mr95273965ad.23.1793747936806; 
 Tue, 03 Nov 2026 15:18:56 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08fe1e4dsm358665ad.21.2026.11.03.15.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:18:56 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/6] drm/msm: Hold runpm ref in set_sysprof()
Date: Tue,  3 Nov 2026 15:18:40 -0800
Message-ID: <20261103231850.17493-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aea6be2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=TtZx0lvJKI4lzRINSrcA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: cIwKZjzBkhnp9iKm_37BCunRSBjP1SdW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX/qAty3OktMWj
 auBAT43vePmZvAogzcRw35wuJrFUvxSF+yVAWXVKXpWrDrMzf2XbRiiHxVl1DcP5p/qE5F4/Zai
 ayjb0KnJveKUzg4HELnquHjRgPjpgek=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX6bqEe0UeEZHw
 OU/Nu5o5y9MXCICJ37Bui/kR3SvHhaPOg0r3IIcbUTXa7lksWTXGmWgHpt/jTJu6pmWQ5/krB/6
 wtftJEEqam4Gy5nVg2O5B4OhbAZ6Qwtch2ZyXkCt1m/qSUk+erj+zLZ/plV8bKFcemlj28LK2Oo
 ohi9Hv/mYUBJES4Tan6VOtRUwiEXreNPj7HqlGFY4AJPGtam9c3eb+alMz7p2j+3m6PuEXa5k8O
 iffe3xZHOVqjRn7z8K6V/MTGjKUE5uV/i3W0Mf5INpRfv1s/FDLOJe6/QWBRTVzeCYfb6n9qFdh
 A1KwfrDdlrZ7v1cGVUQkLU4ZdkMKQ01ZwZo3vHZB79erEKWil7OBS+z+Qb0kVJnAit0kHxH+QWm
 w2IhEHYhbASKGu8hhJs02am3RNBwGBET6bf4oOjX/Tf0ymOtMjXt92gOKIaY+t0y7n1YXeS4jQd
 a2M3VPgi7JowHO5MXJA==
X-Proofpoint-GUID: cIwKZjzBkhnp9iKm_37BCunRSBjP1SdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030092
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

We should be holding a runpm ref when we try to set/clear GMU OOB
requests.  Apparently we'd been getting autosuspend lucky before.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_submitqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index d307cdd17d90..e3e7c401fa5c 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -9,6 +9,7 @@
 
 int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sysprof)
 {
+	guard(pm_runtime_active)(&gpu->pdev->dev);
 	guard(rwsem_write)(&ctx->ctxlock);
 
 	/*
@@ -21,7 +22,7 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 	default:
 		return UERR(EINVAL, gpu->dev, "Invalid sysprof: %d", sysprof);
 	case 2:
-		pm_runtime_get_sync(&gpu->pdev->dev);
+		pm_runtime_get(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
 		refcount_inc(&gpu->sysprof_active);
-- 
2.56.0

