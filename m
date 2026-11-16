Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE8606A332
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mmVTds2r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WJkowAvs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F1810F2E5;
	Mon, 16 Nov 2026 16:23:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FFE110F2D8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:23:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGK5Oc3692941
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BZVUNIWMPuP
 DdEXUHU9zeRI/d11l8gukZD6tZvmKObo=; b=mmVTds2r5rkgKTwEnGI5LCpN5b2
 /tLsDWF6guoPca0gYr5QEN4hCVmdEc+pATQVG1P751FBpszfBZsJ4Wybc7N//Cyq
 43ND00eDQ58lfF/yy5tgXS62HcNfy8tR1JIkrA+VHr+eEd8xANlKBfWkJcFZ5j4H
 zeGe2aop2OFMX+rcBxESBd3QXyhNOIS0pEoUptM9zXiDPChmK7gDObRqHAG8TYph
 4v9/DfUuuNaEQj3EDbVGsS9aHrWhzrkEJn2bcONk/h+wY9NimNbIfnqZK+vAT6+7
 R4/5QQkkWc8KSYkzM2upY1JO0UgXH0Hz7eOs39KTTK7pf/GC77z+GqgB9bQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f810bp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:23:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3425098ae4bso5057eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846184; x=1795450984;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BZVUNIWMPuPDdEXUHU9zeRI/d11l8gukZD6tZvmKObo=;
 b=WJkowAvsCr2QufS6qFTyq+fWGXNFHnwLRSV5vBGGTIMQQWGXE+TcBHggmh9ymWS9po
 EDH6fzT3o1N5ON9Dbq5m4kGc9Eq2QbNeYi9St5F4FWJm5Fmh12ppWYZwWXaZh3Cu6NHY
 f2pdRdC00nbzMvK9vJ6q0qiDVvINF2mkeBSWH9DnVYG86gBvmGv4AcRfKEO7TYI8LDRJ
 fUm4Vvt+Gi62+gN3Tc/1/Y8HKSJKghhwwfU7E7dY6Rr4Csvm7VC/LydKE37NwAIny9nr
 U3x2BWkr8+XXFp8rlWsHxHd7d6at00RIglUskmQGtPDoIKuDbLn6kskmw9+q9zAy5JY/
 5e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846184; x=1795450984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BZVUNIWMPuPDdEXUHU9zeRI/d11l8gukZD6tZvmKObo=;
 b=gpYAVT8rY9Yryf8lCME/VD/q/zJ/3vPgZ0joS2mAs11l6jDmiCIUcXWOxU5x9i6a+A
 F0S28M0GTdCw7si2t7CsZ8MKAvgag0JJBeUoSeqyEnUSrWw/3VblvvPvuy8QZmp7ivLM
 oYVvCtehxP7MZowtCsDzTQCRmQ/MRv0qPJn3yWNLisw1OtZmloXgBsjQ9kzsOzuE9xNS
 vH1QVbkf+1ta8YNJR+yMYFHuiS0eNHOlQnKXZQVRQFwURkGM+EAuzpGY5P7YS4BuUDnQ
 OrJFtu49nqmJ4uMa4+MhimkrgXiC58okyVeIZ1FgFVltcpJwsErutvGeGXGUmfulZSpJ
 ovgw==
X-Forwarded-Encrypted: i=1;
 AL+hErHRSbkefnb00pUg7fBU0ad6Mw7QjanDyG2sanIkAICx8jwZG3+oOU8xtbxPd32USi37J5Q2Of/mgo4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/bhJim06QvSlHp6BCBeSoc8hIguU7eaDcHjNN8WXQeZhuprWfv
 eUjq83I31oJNTe2NfgjRK6s3btufyFxogYFrpgMOtq43bgBLoN5x+1AkjltOrzPNZ4SY3T0bvaL
 4LgWQx6rMrLTXXO4FQAt3Yay3VqyESuAPRmi4/Rwz1SPOrn/xW+x0Rn952MPYtkpJ99hmWww=
X-Gm-Gg: AYBFou2kJXWoC4/UWXSi/zx/zuMUvd8+IOoLs5pzAFL5czUawivOVbYK7dyuhCDLNFT
 zra8YAJLU3VZhggRSoIufXi13MMaYKCbAlojkT3kZ3jVxz+RIkFPOabP/2PZpleTosq5+36qxEm
 jjcuCvI47bkFtwpDWByhE4z66Aoo0tncZUUhxBynvl0QrEKBNzR7mFIgVc9qdepd4UgA/YW71BI
 JRGTWbH4wIdfFPZbFE7wl4xPfNxDOGlGkjS4vt/WcDYTKCPc0jCqwS+R/TllFHZwjm0Qt/NPJax
 F5/MzHRUu6ZsIaWtcBeJ3yoTt1EQSIRK9qy2/I2/48bdBBX49GWYo7w2M3Hz3j3odwNir0hamRP
 lPvL685GzTmC1/qOrkUKWEosw8nEWK4XCG0RBo0MUuJEXdf6NFFkhrvTzoaEFil80DDL0lgepFP
 HE
X-Received: by 2002:a05:7022:f20f:b0:1a9:4d51:8c33 with SMTP id
 a92af1059eb24-1b5030b1230mr11218997c88.18.1794846184091; 
 Mon, 16 Nov 2026 08:23:04 -0800 (PST)
X-Received: by 2002:a05:7022:f20f:b0:1a9:4d51:8c33 with SMTP id
 a92af1059eb24-1b5030b1230mr11218947c88.18.1794846183414; 
 Mon, 16 Nov 2026 08:23:03 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm38623826c88.5.2026.11.16.08.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:23:03 -0800 (PST)
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
Subject: [PATCH v3 6/9] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Mon, 16 Nov 2026 21:51:45 +0530
Message-ID: <20261116162148.2864501-7-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX2S7BVbS51WnD
 i/O9fNRzEOMvWNgHnvpj50h+5C6d7u4T4Wj4BEg1ubrrHMUD2YbwPZJ1ZHeBrQlZictwYBD1JLc
 zX36lPpiotOjTy2oljTUfEBsGSDp9sM6nA6kYku9DyBSDjm2hAxMWg955aLpg2803vfCoCKhB3+
 yEQL3uO5vIWMnPVdTEn6SuzXwBOhnOUdMYsdtYF/uuz7D5/lBo+n+p8jqao0wSsveMGXMxUAfUR
 dBwIUlNVCXZIQmqFf3z0Xa90keqhDYBFGNLd1Asch9OxmwOfB9EPJ1O1zVSgiCuyLreQYTCufry
 C23w+vpZbAjiqDC8wMmXcL/KFZaC7y1N0/JEmDC2cdK+HLtMJBKtJsewcmvjsp/aQRb5wseQBUo
 aNzxOW3w58AEvXQLrOZIxGumr7EE5yTEzK5msOEYdVfx7Nie+EXtASyrTS+XxHXSy7eEiichg5L
 xgbLwbcuj29XBQaBISA==
X-Proofpoint-GUID: Hqhql58iIHbDe_xo5gLtVTJqh_kE0puC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX8grcfFwum2ka
 PlGRwqJT4EZ21CiMpJbFasr0QXZ8NnOFpwQUcQfqw9kmOeHL+/1Khwi2HXXiZ+BUojhOGV1RqH3
 U2xyoorJZJTJXteVR5ow3txicJ1i9g0=
X-Proofpoint-ORIG-GUID: Hqhql58iIHbDe_xo5gLtVTJqh_kE0puC
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb2de9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=ee_2aqc6AAAA:8
 a=EUspDBNiAAAA:8 a=P8P2WCEqvqb6tQ3B-mUA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160064
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

