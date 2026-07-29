Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86160C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF55910ECD4;
	Wed, 29 Jul 2026 15:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLW+n1ZF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H5x9V0O/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3997C10ECD0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:20 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3Ilh2108296
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rc/ljxoshAi
 Nv4QJKXYpPgimbLWzx8XhYbA7LeAuwfE=; b=NLW+n1ZFkIgpdJRzhttM74NX2Vp
 mV1yiw+VWqwLzB3KDZduqA0EQZooSt/+BsXgJV/1Auzf/MFZsG1RNBdmOybSY9ZU
 F5r2Q0/2NUjGeX2izKZiwKNQ5gzJK274JDmFKdZENGS5COmbqBk6N0/eeKxrudo0
 II9vU2lO8PDPymkWI8Ps9lLeu9K8GejOCicLOiwOiRwzttMJGijhmOZclegy0AqH
 HqspeH0mA7lp6z1+ERoosuxvBJFLZDAWP7BnY9CRFrArvxcL1R1mLJ5NA8V6oP+W
 RLTq0YeGeGEPtNFkHUALOUsaIw297ugR1lv+ZmQikDRXB1HdgshZSdE6Xwg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkds8g13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso1142310b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340639; x=1785945439;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rc/ljxoshAiNv4QJKXYpPgimbLWzx8XhYbA7LeAuwfE=;
 b=H5x9V0O/rVppS8pbtSNpl2TtSVXrl8l1dQA8gM1fUh2ed0NKcQ4EEXjIZ+cq1YhOky
 NN/nKYZcQGDJXCgSx9iokg39CRfbqPMrarIqHlScQbvw86K9xmw0p1ddM2Jc+IcCryYO
 Jv5zed10/B6oQVywoz1/jJ8LNO4AfQh5hWnWKfZyVHaSkn03ScfqWg67BIBRYflHf0H+
 GrayqJoFGWO3mLDtNaUTbbatWw+fI6MizkuYZ1sVPcrK4yzAGcJfRLyF34r8smYOaAfm
 GjluYNH3HXdWWwhJFzUi6eloTTbL1t8WpImjrps9xkrOD9rJ2udtQfQpIonu1+iMAJfR
 dWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340639; x=1785945439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rc/ljxoshAiNv4QJKXYpPgimbLWzx8XhYbA7LeAuwfE=;
 b=OlO/vg32H7J89VHaT/IXkvI8Xo59rMxdFSdbZ42MICChVghlUg53sByNIfFfMXJrCK
 QnbRfn9rRly7jN2K/LQG/QS3OglocQOnpBlcxLSHAG9jZq58bz+eipz7tnUa2GKDZBNN
 px+Etif65CaxfTAc6FF1DZBbHdrd02airW0YwWDzEGvmx4cW/D9kI11S2zTpvctn9Rio
 Q4ZZ4L3bwpgeJnXFuIhLblDKO6XRty/AJz47+1p5eQKTdmLsq8d033y9FZMzENGTBwPU
 rBrm7q81pdh3rNDn5SWjVjzkDiF7Ws17jSuB+jEMtUXSHRUB9U1i/Han0HjOYiMbV4dq
 NYdQ==
X-Gm-Message-State: AOJu0YzuS6mRKco8zxCpUY8jUE2F8wLhxC4H626IJQ0mXpxCzcPWjeEG
 lF8/GRDTIjAMSmuGY1xXiWngVY1rRLgMJQWmpYqEMcpqoIeUysJB3AYkgY97BHVNuA/pld2uhiK
 bqOB/Cu1fdEt36fF3hZNc+0G2f10uccsOON0EJlxgKKZbwszyH0xHgQUwW5H5YZAos1EJvAO2LG
 3ib+8=
X-Gm-Gg: AR+sD11pjkW6CXTQheMWuXsbxkB9fpqadLuxBLR42nZFWg9Pd49EC6xcpx+rEAHefH2
 y749sNbXmgCYn+1fiuek3SkFZe0vULBtfxZ+UrHKAdiSuVLVjjfQXL9iyB/vwXRJJ6myesoT5c7
 AsQS15DH3FQD7+Bk/ktyd5ltjKl5h3TK3IlbcucpeOTb69tphyTFXZ2ns+qNgRc//ZT+Fwq593w
 47akGyCxIt/25HRxiIGwd7IDNaTWLX6thra89PzMa9yGZE0+kUvvBMRmfmxbyosqCWeKZe/RECM
 DoIiQ8apNeE3lEdkhNE7W22E65R8S3ih178fWY6dtZhgDD81eRtLNXceWEFPSgjpIZ5j6en1BvH
 qiXDdzj9p6b9OFjnEEFrtuE9HvFgtD3+Ubh9eLYuyMk4/pXs=
X-Received: by 2002:a05:6a00:12e6:b0:846:2f3d:6259 with SMTP id
 d2e1a72fcca58-84e932c6985mr7407584b3a.57.1785340638999; 
 Wed, 29 Jul 2026 08:57:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e6:b0:846:2f3d:6259 with SMTP id
 d2e1a72fcca58-84e932c6985mr7407543b3a.57.1785340638600; 
 Wed, 29 Jul 2026 08:57:18 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea7344ca8sm1211056b3a.21.2026.07.29.08.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:18 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 17/17] drm/msm: Fixup invalid overflow check
Date: Wed, 29 Jul 2026 08:55:54 -0700
Message-ID: <20260729155609.20190-18-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX4AxB4mGvSigU
 9c8YNMgxt5yhwPkxisTxgwcR4pLDhbl7lQgK/mSlzB6Hhbrykf3YSO1lDkdS8EZFzNa+adQzc16
 mofZg210oJTbEfbemRX/K3wHz281GQA=
X-Proofpoint-ORIG-GUID: JkXTM0EHf1ZFcCcRiui-gak0nAMXZL4I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXwxVtGMjyzJvo
 l9orKstI4S5IGvt7WS3Pz2jGkRCDiouesLOOs7WrsVdqfEO3M4aUJpKbjE6S2UnprmdjWgZXAt8
 sKTW3Wm/jbS29X7d3evFSLxbfzKIijt1tMfjYphrpxQQNEb8jfuZqFsr0q/LiuI/tZbFhwIr1FH
 k1r2ADFmfuILqYOuQ5nJOxZUUKcXY/nISUkvycb+hA9Tl3lJI0/ajVDJVhdXoNVjtaTn0zexRKw
 kHA2ksKJE5W6BKSI6v0zkXFM0NdXEuDAaxNVNDnaPZw0FUiDv60JFRelGpnuzJBn0UabwXrQ5Ms
 NxZ17lQXTneTpySuu1bILubv7t0ptL+/GEYCgYvSzPMk3RgT86yMqGW72nif7C1LUvavYe4aA7d
 gGi8xVp7IyuQMTEKr00mnVOyPrHD2HB8W485CLHVlmB7VjdZukEvocRL6HLjDjmEV+0Pj+Ha69i
 UeA3BgL0a4Lth3Nb+5A==
X-Authority-Analysis: v=2.4 cv=VJTtWdPX c=1 sm=1 tr=0 ts=6a6a22df cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uVkA5J_fsNn9jy38BCIA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: JkXTM0EHf1ZFcCcRiui-gak0nAMXZL4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290127
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

On overflow struct_size() would return SIZE_MAX.  But kzalloc() (and
friends) check this already, so we can just remove the check.

On the other hand, we should be using the overflow helpers to calculate
the cmd array size.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 6b0bee6c39bc..5862db05297a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -36,14 +36,11 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 {
 	static atomic_t ident = ATOMIC_INIT(0);
 	struct msm_gem_submit *submit;
-	uint64_t sz;
+	size_t sz;
 	int ret;
 
-	sz = struct_size(submit, bos, nr_bos) +
-			((u64)nr_cmds * sizeof(submit->cmd[0]));
-
-	if (sz > SIZE_MAX)
-		return ERR_PTR(-ENOMEM);
+	sz = size_add(struct_size(submit, bos, nr_bos),
+		      array_size(sizeof(submit->cmd[0]), nr_cmds));
 
 	submit = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 	if (!submit)
-- 
2.55.0

