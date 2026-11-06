Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F08606D810
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PDiC4gNg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NlIXPnej
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F70410E414;
	Fri,  6 Nov 2026 13:44:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DE3112D97
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APDfB444231
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHBwADlwEkzpdYTh3CVC8KuWmqpeEYj9lfAptSkifbA=; b=PDiC4gNgTACQ/CD+
 f3uuSfxsKGX0CP4S3fWsaLNPgx3VC3hct/Ihq+YWpmaZISdIHLPTm6kCt2AyQNFZ
 FTw6kUJeVIccsQGq8zVQBnYkpvxS3gwOAH2pvzJ4TGmPtntKjvAdZXafnhzYxnHB
 O8/VPQRf9ofjXZnRRrIlNS9U7ScOzyTcxvK3uM+QND8wTi1nYL8hnbph2jsmaPCQ
 oy3bdZD5YiJjPCveKEZXnnBZiAKI+78Iopg/Ott93E/4U3GRv3W6lMFhpIkbiWiL
 vxAq/3KR83DVmDlK9cGkOYt6Ibr4J82iUbnK1mUw/wbm/IfvReAO/yuL2T2TIIuE
 s8o9pg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9u1fs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so152750185a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972680; x=1794577480;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHBwADlwEkzpdYTh3CVC8KuWmqpeEYj9lfAptSkifbA=;
 b=NlIXPnejXBuPZeeQh/ev2itrKaLpuUJiLKFvzl9vt1n02B426++FgNiFUif9ap9mOw
 Sbna4nvZhT58IhiraHhTbVOeviS8J06mIKMM7F6wCW+ry7p1bTg1FM01roqnLa3teDBm
 yk1pbwAzIU7QyntYpPRaYGakeLDSaHhYjNBpjhD9Rl35MxUElzqJ7lGcU9wsJ1TySnb+
 zhlBbJ/zCEuaIZM762ts9hJpo08gVOJh6479D2z8RgJ1s3n4vYbwIr/w4XJddnq1eVfk
 w8Zca6u0AXtdRWHmkWSNlfyQoNO84B3hR6gLullUMnqOClY2EeIayrwSKytSny/Os8fH
 sxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972680; x=1794577480;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QHBwADlwEkzpdYTh3CVC8KuWmqpeEYj9lfAptSkifbA=;
 b=TZ7VPPHCR+wZBddt5akR8HzpESIJsP9zc0/2gSx2XhgSdjJNQXNjvbC/p4oU93heiO
 +lwQsZCSLDNJSBescG56rNftUdZQd+TfIIrwk+b+XtAUb4PtxrPTkvu64t+uO7ub9zGv
 DTVYN0avlw2V6jVkWtoH5g9R/hpNJRZXEMeVKYWik4etO80BXyXWgQ58STc0PZgMpAzt
 39u3EVnKSrtq8eJmx1QfikP/q1/+IVQ0dH65xefWeV6dmJaqJvo0ndnj9naB3Iqi0tPd
 XRO0KI3jkzPpH2Oi+1J2+kRpjIYO3kuZJT7yLh5Nyq8/NW5NlaOunxNzi/4UhFDydRbD
 3+ZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByElJh2Gv9vaWzonbdKaCNnjuGeNgB8GBAXZgnWXT3Z/Zc5eI7mSaQ+uMA5v+SFrtbzhYq2qt8m/3Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Lq+vwU6SezTBHakmhHs2p9p72iSLa6l9ZKhsHXwxR2M0OnkCI
 lmWUO4te4X/Hghg5CefVLwY4ohabjfUUvQckSIAMD3c+DCABpyKKTwAKFsFMTylu+dyeGCOqN/W
 6MGNLx+FP0Dg/K0G8ng1RXxEkNcqQHH7AekUOkOi54sSRI1UKEZXTwugiV2MTOmLXpB9BjIU=
X-Gm-Gg: AYBFou0zJooFJ/nc+yRQnNYZtQ3tK4b6tKuOOT2aJ86hCNL+/H5+IZD5PPZhPAFopj1
 6NXXXRQ57w0CYGEpSOLMH1Fkjknp9tNDqYiNPObJHAZ4AMU7SpnVnW/R4/583gGvjLLBsRMk0RM
 ESR4kx5ziUJxAf2q3M3HMd7UEyt15LgFamQYmi8n/v5zAe58976pRQ8HdBHM+HOk7PagNWR2qQw
 wN+yZ2X5IsB/69CWH+PkOfYIEF0c1bzctBncy6Cl5/deDsm8poquPdt12HGI2qOpWOmXflDs/+f
 PBlDA+QTmJ60R8+uSnFHb1SyC9w3cmDS81qrOOQ0JWK5bA/N1WqRnobRKIl7wzO6WVbCuCoFgJM
 olygkgNz38Z13J90EFkFj8CsjVt5iXEM40HldS0yuqgdclow/wbt+K86stC9yDAaWk9NcnfH791
 AfKjUiFFWfqGNQAEOa3XyLloj9QIVR/lIPQ+xJflP2/q3BDCp7MS5nZo2GyuHyUA==
X-Received: by 2002:a05:620a:4505:b0:939:fde0:a71b with SMTP id
 af79cd13be357-945f3083a8dmr383470085a.0.1793972680035; 
 Fri, 06 Nov 2026 05:44:40 -0800 (PST)
X-Received: by 2002:a05:620a:4505:b0:939:fde0:a71b with SMTP id
 af79cd13be357-945f3083a8dmr383430385a.0.1793972674705; 
 Fri, 06 Nov 2026 05:44:34 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:07 +0200
Subject: [PATCH v2 1/8] drm/msm/dpu: fix the comment on the RGB UBWC plane
 count
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-1-82949f88f030@oss.qualcomm.com>
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0CAHkr5CD33DFJQjC5hRRncFTgq+EH4OMdHJOIvKkuI=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9bbm+u31IRcrVrNKNJqtGaz6SLp9phvTb8z3hYdeC209
 o5mk65yJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmwt7G/t/tSJYm/8LJ5kX9
 id71W+ebyB+zmaHiP3H17nien3X3Ejhb2zfMi2ieabxH+UjZJjEpCZ3Gm7689oWbu2T8M/T+tSf
 8++bNdbZ8/XG5VZv28H98fJfVfWaqkMg1EdMYu1yll7+itxU3HfFvfD5Z8cUh3qvf2LnXZ0lWC6
 umqAd18Mtt5Ny9ovsYXz+vcYXHX4V9xx9VfDdkvFP59YrNHpf8vUyWYWlb8zZrivcxRE6JFSs9E
 fHGOrK9PDc66f0qwag/yhqHnho5na1gWCZ9K1jEvTR2ugG78oFpxnnzr/Q9SjyhMFmsdK7zBaVZ
 Gq3W3nLLP3LWagowdnm7/K3tk1jn3JLNza1tzyT9xgAA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX54wJw22Wv12A
 74LUX057pzzNctZqXEJvLZp20prFL8bVzuKS40o+BJUwQWcwmA/Yyhjn3w1otsb6HvUckvGFeub
 EZ1nwYwaAiLDS5acrhhCWjIpD88cEv0=
X-Proofpoint-GUID: pdP8AptJszZou9LwjsxEront3P_zhCFX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfXxzp267AkIK1T
 WAMGKSzeChbpC1LcKEfRqslvOh+u28SY/LzIDs3pIhhwM13ewW48io/8lroqnju7oybUTOgEdSn
 T3op1O6+58kiLyodHWa+XQaV9tcWS6Worxxf8OylPfOSIQd5TlSBMiNY3vj4mhKHbk9bfoXtNf1
 dAb7rvI0vRYhPRBj7qjeS9NF9+26+qgnm3zUirrsGCfd14/i035rQCjxwdP6mECVMZZfhtmw90r
 qL6+zOG/+Z6F4GIS0RtqtxDcQxPLMjfXkl1MblfvlN2WRESVfs5AkxuykzoPKmAHCgsH5Ib1Nlw
 S8WNY8rIV2Ds1YYavNlhRfYzhnosnd/kRpXpfuGh9aLVQagpj10ZFgw2p9TJg1o4HQcrk5VNITI
 lF4sA5YfKA2QOXTTyot7KcQjKm0LM4cCEEntMmvokFAFeK5t+oENRRbK8URsHMNqXAbuaRckyE4
 U42jIgXl2I7i3E+G+0g==
X-Proofpoint-ORIG-GUID: pdP8AptJszZou9LwjsxEront3P_zhCFX
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aedd9c9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=53nbmNL_gIBj0mvaGlgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054
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

The comment above the num_planes adjustment for RGB UBWC formats says
that the uAPI leaves plane[1] empty, but the uAPI has nothing to do with
it: an RGB UBWC framebuffer has a single plane, with the metadata in
front of the data. The empty slot is in the DPU layout, which follows
the SSPP SRC0-3 address registers. The RGB metadata is fetched through
SRC2 and SRC1 is not used, so num_planes has to cover slot 2. Say so.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index 590922c4f69b..a8e9a69834af 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -126,7 +126,7 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 		if (!meta)
 			return 0;
 
-		/* uAPI leaves plane[1] empty and plane[2] as meta */
+		/* RGB metadata is fetched through SRC2, SRC1 stays unused */
 		layout->num_planes += 1;
 
 		rgb_meta_stride = DIV_ROUND_UP(fb->width, 16);

-- 
2.47.3

