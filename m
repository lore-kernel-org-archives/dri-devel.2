Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05448606A69A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l2BL9GBK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=At5VIrgL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5706110FB0E;
	Thu, 26 Nov 2026 06:32:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671A810FB9A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:54 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36Xoj3024036
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 obwlnMkjoC3GVhuJ8eqS1mhshuqTDQ7x+oKEZyK4Nbw=; b=l2BL9GBKLXs887F2
 sLqje7Dq6r9V4WZ5Xnvv1YrGUb9S/WkxwzcCEQau3Uacff//5mVTuLHAtxBoA6n5
 El3q6WkqxpLGOjsUkIM4ZqMBvy0wWWk8DfWlQ9/HjYSD0M1uZzaxORxyHG90mDwL
 MfXx41rkB5N+CjNvefQYLiyZ+kOFhZSOIfDb5tGmZX5s7nICFRkA/4ITUFoSSyb4
 FzUt1xJFPg8w87az5Y8gy66E2i5GuMJ6QEeBCn6ALmkSKzrGK514d5XX28jZzRY/
 kBJjAkLanu5P7Ty0JdJhT1rCqrw5yRiZDxs/XHq3COxZ7/27q/f6YOQ8pqtsNSFX
 iQnJLA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vatknb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2f0467a525eso50565295ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674713; x=1796279513;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=obwlnMkjoC3GVhuJ8eqS1mhshuqTDQ7x+oKEZyK4Nbw=;
 b=At5VIrgLVw4b9nzL65vD2tLXIyuGWphs1RyN2PaOI+eolet9DXj2RUJGdGcAKMNp4f
 a6W6Fu89iAOW8o4GpHdTP+dV93R42B9IIhZ7shMVBmSiPjH/qEsjXZWBzuXHVYwsKxAO
 urjaB03l+RdcbuAX2VPfvHK6Tf0KZtshXHhEQura8Jtve9ip1qxH/oLorCP8wUIbMqjt
 DwpM1KOvLBD+GD/tNGWgFlXcU8VSmMJpA/6ja/9MY6B3Tl1LWzijSSGYk2BEFyNfqhCa
 yqo9R+9iBeVppSF2OZazYwDtlxmODt8Ir7LLh2aLWQ3xC/lTz1zbZhd/SxWQN0fJHBfm
 wLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674713; x=1796279513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=obwlnMkjoC3GVhuJ8eqS1mhshuqTDQ7x+oKEZyK4Nbw=;
 b=IzpsDq/DhZEmiBOYrHB6RIs9bZ8goh4/P1AxhxLCsUcf9NjNDOIP/omQIddkV+MIIi
 QkkhtLYeOpPTHe9daP3YQUjydn9qHYgH14i3M4NXfqclCTwXP/YZq749lNeXCjcsCgJq
 CA1zyakj4x+phxiylxIw/fZSncq+fFux2Z6ZRLRIqRLGVW4rA0h32fzUlOOZNlF/NDhr
 z7jP89TFbRKsR0LZU9miyRWZH13o8AOdZTlUo3sbX5Io0pv3qZaHQXH+DzNszqBjQ09X
 gE2fJnP1+F6Bsy+GkBJIgVLXGWN62fHLrM6IfR1fW8K1M0uM4ffcuwENy2EqjzdyWVce
 4BDg==
X-Forwarded-Encrypted: i=1;
 AL+hErEk+EEo350G7+31KN/8EYW3SVthTZcw1fsuU0GuuqgW0Z92FemE6PsiiIH0umYySzZIF5Zkyfh3TSk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/TjlhWpVdEtGGhzIbdxnVz64ZSUuGKOJw8eR4Vjz8/Fpq+5bCi
 aKLNx14f5UHzmu0RmO2v/enkGCC5VE3Ka64PAwBnqdvx3r18pmO2h0Ul8F6KZL+dtS4NFQ6KwzA
 GDvIsBcgUg9EtLt8uhRVVSsdN85fNlLITkX9yBJMNIX3LI+ywTwsFquszqBDp8jxrMH4zsSc=
X-Gm-Gg: AZFdTZecd+1WVY1IDYSuP/f8F11ridg3SM7aY8rR7rLulqr0KvNzF7LlMTNS5UNGgdt
 cTBQtES7cPpYdJVco9NiQFPFOJeP+DwA/2PIuO8CYurfDotIGrty6QW5c4YTZY2/oekzJTYZsfI
 jAR2iCIcy9pWNGad6XdvPmlWTVQUNgofA/6/4i42K1eys8FNxPtwtd2ONy4/oPtwCIil+1D3Qcu
 P+ZtbTK4Sf4JTa4Ok1pz6D582c6jGBhwnow/uBPH1L6sbXIz3Ockext5R3O6mh/o9n86saPmWLV
 S42aIUM8wlTDv4JIFRVbfxDv5g0SpFxdqAIqFrXR3oq/yDeYq/kBcPztJbBcodPE40sx0ENJe/9
 mG6/kn7i4/JDR6mh/gCxXvXdXBAEYw3YfrnKBhu/euqrSPKjjqfXBNoDy+gfs/39ffB9ElJFkJJ
 lVdVC7oGA9
X-Received: by 2002:a17:902:cec4:b0:2ef:f392:38b7 with SMTP id
 d9443c01a7336-2f03f1a1841mr216412175ad.24.1795674713078; 
 Wed, 25 Nov 2026 22:31:53 -0800 (PST)
X-Received: by 2002:a17:902:cec4:b0:2ef:f392:38b7 with SMTP id
 d9443c01a7336-2f03f1a1841mr216411775ad.24.1795674712566; 
 Wed, 25 Nov 2026 22:31:52 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:31:52 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:25 +0530
Subject: [PATCH v3 17/21] drm/msm: Export GPU component matching helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-17-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=1633;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=+kHZ6OP8gcD8pNbmCuB0Bs0MumxiGgHxobreJFpOXLw=;
 b=3pGTZXEIQomPo58QAYimRvl0pzI/Q2Jyk4johiZeBLOcZi0M1YjrV3Vw/j14XFIzbrcxTGQhe
 bv/vtYoQfOGBxQWGelLfLKDlhbSG/r1lhDKz6ZbhAoi+3cZ6ozveD4j
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXwOJFdrlnqzgH
 8zl880BG2PLJ3xB4ALqxIy3OB5iXK3BYcf3UO0ZAJ5lLfzEA/hFsCh1NZ0mzxEEApjwq9h87N+B
 jEm2Ymznvr/4LoVd0ghjeAwIZDmPxhI=
X-Proofpoint-ORIG-GUID: LHImU0oToxkvLeabuRLAI04u3gmdH84C
X-Proofpoint-GUID: LHImU0oToxkvLeabuRLAI04u3gmdH84C
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b07d259 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=a_sH-KrDn922EyEOKHQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXzPiIAlZ456EM
 OjpnPAgJ+O+rirTBTS0VWCFYBokDV7uSdHwyB4e4PzBXzOn4bwISvfoegCEiicPQ+HO4nQ0BlJC
 KX7/TK51Q4DLM8hhFM0g4gebuFA3by2yjoRYzSgtbUkM/wujmeHOKT77Xca67X2wDv6aq3Au8L6
 zIoJ4QEGqBQCbpcvtTjZM5iLdM3hIx94tFAPDPO86ga0/XH2ghHoDLuvWpp5Qu/HYTc29qVBAiE
 7jnFPzpGO2PFNuyyY8+6zjfxOz6okxejgqzkYnjB0LGsBWG1nSg6MvwVd/M3GO0rK65wiIC/oT7
 tUnxgCF+KkrlPcJnGhaY3F29tbYHHkSpz6U9BnLCrbkP92gIVKbLiLcLm4RjQqGOMjeBSBbd7tz
 Iv3FUsrCisMvurtwXZON3kylCzuG+diXj2Lv2BV9xLWp3939CykoPfjkTA8ukrf0Y+H2u2VQdGf
 szjft0PTYNbzTIorcsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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

The DCP DRM master needs to reuse MSM's GPU-component matching logic.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 6 +++---
 drivers/gpu/drm/msm/msm_drv.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 3675df277f6a..bb383bb0fe8e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1094,8 +1094,8 @@ static const struct of_device_id msm_gpu_match[] = {
 	{ },
 };
 
-static int add_gpu_components(struct device *dev,
-			      struct component_match **matchptr)
+int msm_add_gpu_components(struct device *dev,
+			   struct component_match **matchptr)
 {
 	struct device_node *np;
 
@@ -1154,7 +1154,7 @@ int msm_drv_probe(struct device *master_dev,
 	}
 
 	if (!msm_separate_gpu_kms_components()) {
-		ret = add_gpu_components(master_dev, &match);
+		ret = msm_add_gpu_components(master_dev, &match);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2840e8a5052d..aa5dfd82ac6f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -523,6 +523,8 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
 /* Driver helpers */
 
 extern const struct component_master_ops msm_drm_ops;
+int msm_add_gpu_components(struct device *dev,
+			   struct component_match **matchptr);
 
 int msm_kms_pm_prepare(struct device *dev);
 void msm_kms_pm_complete(struct device *dev);

-- 
2.43.0

