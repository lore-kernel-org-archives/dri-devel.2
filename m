Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1160A6F79
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cQLzIrhS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aMBriu8g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C08112598;
	Fri, 13 Nov 2026 18:54:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9401112598
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFS16C1726353
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BZVUNIWMPuP
 DdEXUHU9zeRI/d11l8gukZD6tZvmKObo=; b=cQLzIrhSoij3Q3A92ujCBOk6ye4
 qmX/+gDp3wbXyaXnThiusMCKD3rVDNtY+4fr8xgyTpKSDW80LvkXAURGHSV25zed
 40dcT1HGZG+naWL+HVAdRSr3QovZKOb+WzNFyd2IfkBdjqdlD1S2oUQpM2GFU6tf
 jOwA4cYLo6OHq0gKz31H3gF5giQ7IhWrVmt2+S7bYLniTn4JqG9BqLikIlUn+RTo
 r8B9Rv85nFDqt9h7zPqSc9FpscA9TNPYOv6GFVawa5StM/DnjRgjX1GykyPffIG/
 fh/LWgFda52/cqPgn++nPXffKiObpwfDeLL+OI8dz51iCIz3A1OFQlHn4hA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bp9q5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so932202eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794596052; x=1795200852;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BZVUNIWMPuPDdEXUHU9zeRI/d11l8gukZD6tZvmKObo=;
 b=aMBriu8g5O9pV+e08GYE/NeQydExLIJkYbPmq8i9f9YCSwE/jBwo5I8lo59+p+EYG5
 IQwGdd7bbTHNUAlm07oVQzMw368hUGm5Ik1sX8/+4a0y8HKCgvOrkv8MGNQ1Mmucs5f2
 f/74/FZUGGGQcHlOfMsBwvUH0nif2TRZlFX8xun0OI8RexGc34hcwYvMtrAAIk7IITFp
 AKYO1eM/MlQSeuik9uzdDe9dB2ZviCzsEc1hAzvrpTqJfUpppGIkQiIOfI/jst3FTzDB
 AbbSYQnqaISQJ0R6VeIqb+UAct+0QoPCA3jKbjqcGlbpa3MnkCnJhdyrs+SO9+kf9Oqc
 NfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596052; x=1795200852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BZVUNIWMPuPDdEXUHU9zeRI/d11l8gukZD6tZvmKObo=;
 b=uPrLD3obIA0l2qIhTH7iCtFThl434A1CF6pxy3U4jkPOShj0eiZH8PYbAmaBIGQp5b
 KzhBhwK3keeIJOjO0nsruB1QSH5eoc8HjgUbtUQDwJPg69NbKAOrkAQ1W6bD3MoB/DEF
 KMh1ngBcT1tOJrJbsCf2NckP1WFOBzHJIcC6Yk3l/abO6ZQblxHgr2E9qVDMoVVcB09X
 v+OHe66sFee/hI8XyE5GZ751uGGJ5VzRiLd6+nFxCFvCBwGm4zvQt9+dFJqkZ1jFYury
 J6KcdvZJGLxf/x5lHYoHuRKE8GepGdUYMGZTfXLLwiAKc92RHlMDw+DLTc2YVxaAZLkX
 iXbA==
X-Forwarded-Encrypted: i=1;
 AL+hErH2yO6BrNSvggNHkv0hp9Sb5+6M8iWnSSYaIvMv63r4mDVH5JxIBqguYiQKT4CPKnvPOs+JEDFKhBo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/KWBSLlVIn4LgiF6WnIFRVG7MWPIin6Ce0/U2FVFCrkmmfZ9Oe
 X87CKmiZmzQA63zybZ/9BnR7RQq2Zd0YO47KJ4PfPOfFc2ZIqCgaRTXaOzJ08kH9AzJvt6cChGY
 KiRVd+BJZ7kCya1/+si4zIYPuf1J7A5YZggzySrShsMPj0x3gucrtT1VUz8nOOQCkeXuqf60=
X-Gm-Gg: AYBFou15VCYVETXsk2rZot+troFfaRYPxxL5Fem2MhH1HLTbg0o4WcLrM28bHQkYQ58
 h+HlE35Kvii0+1LCzyx3WTWQy7b+MK3hMxwX5Y2YrxRImtCeuVsrkpvnrEffaHykfHEPRmlEjfW
 BYJj4sOSsPGRfAn86nXn1fWj6b5gmhGjGAwofco7dqu/TrOMfe/bqir1IIgmGzwQt7kyCojOrJ+
 AOfk1HiQ9dRZwQ5PqglzrY1tLudf/vGAEd3qSemrsJ5fp6uoSX/0haXdNrf6iYfNdpGCCJZ+fPH
 OEJb5fptLj2F0qpVLcWblf8HmYh0b9lxbDm9UP4uFctHpnZADXgIVVYb6IVMfAZF2+BN2uZY23b
 n+J/xsDDsphcishPYu700Vn++KFu4EUTYgzbsFv0zPzR9C2wpeJZ6T38Fz+fP2ZzZvby1CuWOLr
 w=
X-Received: by 2002:a05:7301:1527:b0:36c:a26f:83c4 with SMTP id
 5a478bee46e88-377e101681cmr5885949eec.13.1794596051420; 
 Fri, 13 Nov 2026 10:54:11 -0800 (PST)
X-Received: by 2002:a05:7301:1527:b0:36c:a26f:83c4 with SMTP id
 5a478bee46e88-377e101681cmr5885896eec.13.1794596050515; 
 Fri, 13 Nov 2026 10:54:10 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:54:10 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Alex Elder <elder@riscstar.com>
Subject: [PATCH v2 6/9] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:06 +0530
Message-ID: <20261113185009.157893-7-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af75cd4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=ee_2aqc6AAAA:8
 a=EUspDBNiAAAA:8 a=P8P2WCEqvqb6tQ3B-mUA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: Sg-do0pKkR3RrAK70ST66ynLIOaLcBgs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX2JCgEiPVSKj/
 jUnBPa6FMKG+IEKH4Z26E5UUKUE08hpMPQCvPGX33gmd74IwedlbSmRCfb9KivgBOmUVCuxEKKc
 DTgSL+VMjiBGwmmGsIKTSLhZ9i4eGPQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX05fieXXF6qgG
 SA1H6OIhm9cwoH8GkqozM1hdCG3tXLIjQsk7/qzfQHINpX7B4wwN7ofgUKZ2auYp87CefvQIH/l
 ydb4RqHC4sETpopt/pTshDugD+ssRAkMAS7XaPHGWixRFEeCI+N5PkbEKGCLmAHfCmQ54S8j13O
 GBoWrndy2tYK4uKQcU7/fGdmHSFX7+BvhX9Zlj2x8Sq+877P7rvOwYX6q/suI4i585g9vcwsgUH
 pINjcHYdWGuM6hZbV69JDpBOxABKUtbAswHm3DxqS5XnuGfwsoMeCHFKOJmUKqhJW53/9BVi8D0
 fBU7bBWggBJVZmeBb/COg0rC48JJHPgyROMgRRav1OGYiHli47dqTnqx+VWuNH/ZKOCw7YAcIhm
 YumoE0QPrMogPtO9FKgr4pkjsgcQB7h8IE1Oprpu5bz+Ytep8u0m2e+0VbC12tsbl+b2hMVMlxv
 YOdNBRuzaOMEFeWcV0g==
X-Proofpoint-ORIG-GUID: Sg-do0pKkR3RrAK70ST66ynLIOaLcBgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075
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

ipa_firmware_load() calls qcom_mdt_load(), which bundles metadata
initialization, memory setup, and segment loading into a single API that
does not expose a PAS context. Later it calls qcom_pas_auth_and_reset() for
TrustZone authentication, which is the intended behaviour. However, a new
qcom_mdt_pas_load() has recently been introduced that works with a PAS
context and can handle everything qcom_mdt_load() provides, along with
additional functionality such as shmbridge creation and retrieving memory
from the shmbridge buffer when the same remote processor needs to run while
Linux runs at EL2.

Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence with
qcom_pas_context_init() and qcom_mdt_pas_load() and
qcom_pas_auth_and_reset() with qcom_pas_prepare_and_auth_reset().

Acked-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/net/ipa/ipa_main.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 14ac2d2faf7c..0a37741c2285 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
 
 static int ipa_firmware_load(struct device *dev)
 {
+	struct qcom_pas_context ctx;
 	const struct firmware *fw;
 	struct resource res;
 	phys_addr_t phys;
 	const char *path;
-	ssize_t size;
-	void *virt;
 	int ret;
 
 	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
@@ -615,24 +614,18 @@ static int ipa_firmware_load(struct device *dev)
 	}
 
 	phys = res.start;
-	size = (size_t)resource_size(&res);
-	virt = memremap(phys, size, MEMREMAP_WC);
-	if (!virt) {
-		dev_err(dev, "unable to remap firmware memory\n");
-		ret = -ENOMEM;
-		goto out_release_firmware;
-	}
+	qcom_pas_context_init(&ctx, dev, IPA_PAS_ID, phys, resource_size(&res));
 
-	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
+	ret = qcom_mdt_pas_load(&ctx, fw, path, NULL);
 	if (ret) {
 		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
-	} else {
-		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
-		if (ret)
-			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
+		goto out_release_firmware;
 	}
 
-	memunmap(virt);
+	ret = qcom_pas_prepare_and_auth_reset(&ctx);
+	if (ret)
+		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
+
 out_release_firmware:
 	release_firmware(fw);
 
-- 
2.55.0

