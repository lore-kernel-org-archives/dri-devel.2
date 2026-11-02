Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFF606D80B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qfm7HRpK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=URnwt80C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FF910F26A;
	Mon,  2 Nov 2026 22:05:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F5110F271
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:05:11 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2LIEHH879654
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gIzkbjDhFpI
 59wKeEOyvGZrWbWXse9FWOdJm9bjq3As=; b=Qfm7HRpKQ5VZqEMm+FWJ+oU87zt
 DAXYsKUehoT6EzN6nBis/jo0wPujP/mUDElQijsYDUURNNsL213xNOF9gC48Vj6b
 E8H+gsvwski5SAknyOF6apNL+DtnezzJkzLf2kpSS+s1vYUDNUE7O8pHzFqT6WR8
 GNqP93Vw1DAiSQi1yCAGffHLdrRpfpp6ugmHoskWHDJyHAuXqZpzk2ShnSJWGyNE
 vOETjeXcdNlsd5usYeMv4wMUYHiepbRkgtoJvPlII1OwLip3tFBxPhK1f3P3JMmd
 EmVkGpUex/65EgS0IBGCnPn9I0BS6sXp+eHqiaXi5+T0sAAvzUNzfkQqw9g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2acg4jv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:05:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ada6ccd402so2905046a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657109; x=1794261909;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gIzkbjDhFpI59wKeEOyvGZrWbWXse9FWOdJm9bjq3As=;
 b=URnwt80CT/CO+LuPp9M4LYgXORYSthw30k3ZWB4wOWOIdVEPjtS8L46QKmGgR12JhR
 maeD2vTnYQsLUAkaVDtNDrpxcAOkY2s/JTH3xltRxEgIV5sd7lDS+0Vz2v8C9L4wQj12
 BV+dWh49LNiL8szqb4oBNXqjCSKLpIj5xlmxOP2A88ZdqMu9V0SYyZBqJ9tK/Aijhjjp
 Wq6Tp3mhlOpZs2P2AH88l0SE82xsNEToP/yRQnmFcJinyPyPoxn9N4lp55rOeDG5HLSz
 VlJT2WlXrxFZs8UPGxWGK+f4rTj+ZwMhgrFnil+ww4ShwAotATlj4A9bMjDkY8Tuhw5/
 QfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657109; x=1794261909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gIzkbjDhFpI59wKeEOyvGZrWbWXse9FWOdJm9bjq3As=;
 b=vRJTObaNHpUKcjQ2P+hU41DD8CMPtvyJwhyGhF4Mudtt436GJg/O2d548u9JS02OMl
 AryXQsfWbFMLGiu0qI/NonanVebLDwzNk8ssGfd8tcIpaH67BroY+nM6eoA4LEXKe6YW
 yBO9/6TgYY16/H9if/LfaWdYqVnp5LqqTUMbQtyPZ2Scnb6Nit946tj1jnAaeR567Y+g
 F2GqhAiriGKNTK9XjLsEriUdB9VgisMgxVORx3T/+QQfHpO6Wgx7UY9KJhnMk2CppDSG
 C8HVw9dmSqfZ2qDqdhqdl6VWf0ZQ7st/Irjprx+MVNGx4qY9rmThgS7Gt7Em/jkuFqLc
 g5JQ==
X-Gm-Message-State: APuU4Z9SIR6bHced+GBN8cznHe4JBfdFYLif/O5SFI66qxmSl8amXa99
 QzkjNn048MqXH6Yw8mTZmseTGGTzKXFNVQH38YlEodSoh1QlZ3J+58zgWCC3Xj7v/b+Nnz0hHbU
 79FDCNWebNJXF87HDLS4Eqd1uYwkuskkAC59CNBArdnXCMwtLaqy5lfFYAaBb0k9twIaoGaz9n5
 RlyXBuQg==
X-Gm-Gg: AYBFou0cDzffgpsADxzoK936YSCZkvetT4ufQOk7wYP2EhxJvCOr0AcXC7dLaIF9BbY
 RaFJcZUrqJCf6lLS9z2587JBnWKbR3OeDDj8eIT6mjRhHGeTUJ3BuaL44iq2FLEAMQDz7UFIGfc
 xM02GMHQYCkX8yrkdbchgSiiAR6dEBAZxP8bhjpITPdIMrlV7U73DPdrireEvP+xaoXJ41mBIf7
 b97ey5hlavTNtpPMcjf6bdL2aq+gQ0WWtpEDYBRU0Y0kf9ajcMxNLA2hurvP5JgVzOmqhZeOpEH
 SRpJuXHVFRaYFGoJn8A5Ks0+E8fEQ12TkG3YztpC+tftRz0ES6yz851itJL2TJAHfPjvcwdbvld
 +dYHQudvTtiXLBFZ1L//XWdRp/ZcZeIrKkRfiPjsCbe+m6KY/NyUpqkn/Tyyi11Q6cCyKMRChZp
 egZuOBhK8b7andkzuiddM4KrI=
X-Received: by 2002:a17:90b:4a11:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3ae896f8539mr8634108a91.18.1793657109373; 
 Mon, 02 Nov 2026 14:05:09 -0800 (PST)
X-Received: by 2002:a17:90b:4a11:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3ae896f8539mr8634079a91.18.1793657108947; 
 Mon, 02 Nov 2026 14:05:08 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85d24261sm9255505a91.0.2026.11.02.14.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:05:08 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 15/15] drm/msm/adreno: Remove temporary __maybe_unused
Date: Mon,  2 Nov 2026 14:02:59 -0800
Message-ID: <20261102220405.30730-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae90916 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX9+mqhrFqPv8s
 c4wpr4l5c9r/JJpI7gFI6yekioF7NPYaefEBGBNweapS4uwHEA84RwBBeHNJbMHkeS/MKbCVe2m
 g4qeMp14ONQGRAydFfnnKUf+pdKvIq99L/U/Al4AFdwQlkdqYOLvsKmGm56BU/HawdfFK5eXqbW
 SYpoR1ficSI3SRCeOUuboHCCpAgZjHdQEvzLghBP2GI3VaOVVe+IWDQdhDFvgQ2r0JLmqOmC/SM
 KoBKWX88OaWm69NUCEYcyz0bNcsnI74FEiZBNBR+1Tymnrz6YIEpOu8BzRI/FHxNkAdsjZ30jfI
 OoCvvoluJ6lXDdeS8af9ow94tsPSoD+1YTSGaiTIHRKANeDqp1s7hy05viRWlQHWsTSsBsoEC86
 ldm/QlCur2yYzUeQx0wig7T0KjlDbX095flb3IoERdMgQ8DJPN3cGYfuw+IO8s1gb6V1ZS2DXdr
 vwDelcSJMRlONCTZArQ==
X-Proofpoint-GUID: MbTuhaO12Nfvomwp64t5Q1H3xZghXXao
X-Proofpoint-ORIG-GUID: MbTuhaO12Nfvomwp64t5Q1H3xZghXXao
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX7KnFHk3jBBE4
 0J4sZOkqplA7L2uaxT5x8bgstH+GGzlySVcOz0m1mHtRG0yhVKPY3pJkNZ9L84elnSGcfPS8x+n
 Teflt4INkZ4iWIlNf1qlLyRH1YuiCwI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
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

Now that is unneeded.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ed83dd927b54..3ef3ac2d86f9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -170,7 +170,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name __maybe_unused = {		\
+static const struct adreno_protect name = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

