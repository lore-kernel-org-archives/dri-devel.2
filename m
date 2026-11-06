Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D80606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pdnvFZ5N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BPlQfoHy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB1110EACC;
	Fri,  6 Nov 2026 23:23:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6691410EAE2
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo2qj2084645
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lfoXwA9UTdo
 ZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=; b=pdnvFZ5NNh5JpRIbkvzKkmuRAF1
 5dWEByr97pusP8voRwwuJ8oTU47S6O9wCGV9dAYqR1lGVFr9k0sKh5C+/RoSbmec
 +ZvEOCNJhvQUO7wZrI3e99t9YO4fixPO41EP+l56+SkPMUGuUSRGkmv+mYyvxn3C
 0lbvITCUswoKqpO+DHRxEzwdNe1+NofcjGHS+ENjHuEOcZv3MuCebtByCmE3bBDa
 geq7o7i9XkUlu/KfuyIcjNDJDowlqciKNbOeNRhumCGcOdF+wJUnIOiFpn6u3Pqa
 u77afprU3oQBukkN9mhFg/CMnhLVGhnmtRdazH0kSla5BouWOTMIrmeXugA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsm6m8ymm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso695514a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007372; x=1794612172;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfoXwA9UTdoZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=;
 b=BPlQfoHy1OvVOVdTxzLDqTFj3M8CnBqHTHKErOQ0f/qynBSy15dKcyg9bpmCIRikgV
 x8nWGW2BR9MmfBr4ru8zONdQzYz4gYsnonOeDUXIEi/MISn1vOWiH/eOVcBr/GliebLC
 +lIntB4DrXjVeEKfr/KGKMYvJI+Ik+C0P4Fw4CyYvIRNnJkfsWjjTsCp0+wbWaivz5x7
 ni1+Qyvx4gnITM6zM+m84c4xJbNvRfNTL+R6oCPZpP28kePF6blrpTLXC5VBGCT4ydWQ
 rSdpRXO4RuOk4PV8De2oBSpQibdAqPFFqp4KBksDYcywbmn1Y5Fo1VzLf/t+KyyL87hG
 UBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007372; x=1794612172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfoXwA9UTdoZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=;
 b=TizW6qklAkVCnJ0C5uRgWohTG+lr6ABE60JbvbCH7J46j5v2+qRm1cloAGRPEW9nzw
 ivgpapE2/E5sBsxO371k7E6AA3qKWHPUbha1MGPWovnMsZGVC9xMnU8sYdJgoIn4+3NQ
 v+fmlgnftD+Wo3dyEQBzXbrWXTYutdv1puWaeutECPz7+//IXdvinl1WbT7tMXSkGxK8
 BS3BohrhBqkErn8naVjSACyOVRb9zIRq1awls9AZ1TRAuA7CkTNzRoyZPdk2ukxV9cOP
 Lvqi0Tqtfe+ykHA2CaNnxK7lC59sJfIZCHI2kW+bphJ3cygGctkokwZPCZocOGZFFIQr
 kmyw==
X-Gm-Message-State: APuU4Z9EjVS74owJIodkjsHsq2rm3Nf25Fh0Us8+pgaHEe8iLO6J6ecI
 ruD4pNIOnBtltLczYxLFdc1Pwfdp2bLO9AogaNRb4McYJimBLE9wZXnu7tEEPS7Z4iJvSNUP2Wo
 G3tgq3BzX23ts81bhKOCH30JtjK5fRlGeOyOuaogT2bbf4BxsBShJsqAdLa+UI4JDzfTnWNW1WT
 ys3XgWrQ==
X-Gm-Gg: AYBFou0ahjr15Gke6pW9LMqsQTKIMuemcdZvKYnILdwNzVt233GyZVpZS8ajkApxxUV
 C9uLSjwwNU2cEsMXl8iqQ9eR2YMC6oFZ+1+DCrSSWpt6rhaPAFiwN3F1GP4A4JvQdKFZWoRu5rQ
 FhL8k6DGk/tcwuO7/EKlOAvxDfM7O6zMrUHa0Ey1TcLrelXEAZ/HrZPUOcFP9neS0kveh6P0heW
 fgOwJONG7eKtEMvrikEToE1xt/qV/FILZtnbCvA9I/TgSp4yomgwzq+ta7KSWWjmR2u8dOPeg4f
 M37WQV2jM3S6xRhvRHuVErT6XKa9ayM2BbaJa1U8lbQCF+kVTFNlj6x6/hLhptZ8BUpgBHQE/xo
 QyjTM+WxYMmOX20p2XBfboSwaS5veLUtECNXbfsPWb9YVZE8Zlfb6JEnFd2lJd22kXeDEATt+m1
 bgX7CipnXBMdzLZeT0kn5+T6I788oIX6iCLrff7MThf7027E/h30vT+cNtZqlCPA==
X-Received: by 2002:a05:6a20:938a:b0:3e2:100b:1043 with SMTP id
 adf61e73a8af0-3ebb2a24b25mr3767358637.42.1794007372264; 
 Fri, 06 Nov 2026 15:22:52 -0800 (PST)
X-Received: by 2002:a05:6a20:938a:b0:3e2:100b:1043 with SMTP id
 adf61e73a8af0-3ebb2a24b25mr3767342637.42.1794007371878; 
 Fri, 06 Nov 2026 15:22:51 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b359dc9156sm1003773b3a.36.2026.11.06.15.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:51 -0800 (PST)
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
Subject: [PATCH v7 09/15] drm/msm/adreno: add temporary __maybe_unused
Date: Fri,  6 Nov 2026 15:21:01 -0800
Message-ID: <20261106232220.47602-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX/6uyGnqm5YEb
 g5ASqXU1MCFOYM/6R5CDlH+CV6d0MWyuon8/QSEPjVgEx+eU0f4vnXID2NPQVck+mT6u2jSFOZP
 MXIhRq3/wGVkRgEv8/cXaFfy8HDOZj8=
X-Proofpoint-GUID: lbynr0l7ljy0DG5DT3WLJZBTxUvDsYy6
X-Authority-Analysis: v=2.4 cv=S7NMU4sP c=1 sm=1 tr=0 ts=6aee614c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=5VHPQfPT90DSkkNPp7MA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfXz6cK2ikByapb
 zdL4QLFmJTRpvQNe3YcGX0p8w2YhlSFbf8zkkZHo/LMmDHYk7XrulJk2iQXd41yZ4TJ9L0bktdh
 yUDs5l7C0fubuO/qcuHUR+KdkZDryBJDsR/ye2HwKZFE8nCkdd70+I5A7ta9BvCeRg716AxaTjg
 5rHumHcoEZKHpf0e04j+T/W/3eB5FkSwD92iUFMre+PCWWafmbYqb2BKduiiQf1/zR04bGL3ZlH
 IktH1tDT8mJ3yYoFtZ+17E0iwoTNcZ3z7266As5fVomnNZTwJuzQmPilCZaAuAyvD78lzvkqiTi
 n9ZEPaGo0q2iR4EOXwoqqrlq4TP+Ihrn33UJODkeCbvvgG2wlFrhH4H1ITTEKd4SJPmKAuV4QQH
 N4EUr538sLtGvKy6vtezTtLoG7hIWSqK9R8vBu4gdBeom4b7D7HonMzq15Z5IWA7bjE1BTpUUf0
 rpUtm2DlEv5oiRXMSGQ==
X-Proofpoint-ORIG-GUID: lbynr0l7ljy0DG5DT3WLJZBTxUvDsYy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060093
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

To keep this series bisectable.  This will be removed once there maybe-
unused protect tables are gone.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 9e0d37ec9c15..2408adfeeb23 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -168,7 +168,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name = {		\
+static const struct adreno_protect name __maybe_unused = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

