Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C2606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LqDnmnG0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ep1ex/Ts
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AED4112A02;
	Fri, 30 Oct 2026 21:21:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723B1112A10
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULBbp9237972
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gIzkbjDhFpI
 59wKeEOyvGZrWbWXse9FWOdJm9bjq3As=; b=LqDnmnG0tWIWwKsZq66bHJAvSff
 M+1GFxdYhjPiJS3A1FoJvviSxWCP2fuLEmzmLMmWNLdb//1BhQVw0N62wAGLXKc8
 KRuSskhukULUuaC1BWqUiuOcsel5GfJofIOX1/fWhhuyWDhDFUH7eXhD8xeZUnuZ
 j4EY+bIJFuWjMNKTIrOucCjeoUNFYB6ZLY82CTQGJkoqU3mVmHZr6gtLy3TgL/c1
 wXpX6Wr5HpHiPJFatxOk8dxBvryuRVUIzt0+EScQiIQK76GWJ8KKTJyLC/GaudZK
 7tLWSKRYhyeNdcGz2Y4SHGqXJJbhF3FPH2G9VZFO2Hd7furn9A20sV168BQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x001et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd6969473a4so736972a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395227; x=1794000027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gIzkbjDhFpI59wKeEOyvGZrWbWXse9FWOdJm9bjq3As=;
 b=Ep1ex/TsgzzsDcrqfNht1OtZzsh2NV4CEJbItwAIJEztqZ6nYO5S97YNB3tlr8HVI6
 hGcNbmowCqsXXeDjc/dSmJdR5//96WnK0OocwaYTLG0l6LNd8pLgtoEerQp2P1ePGU96
 SLugFzGZpBe3S+0HabLM9aIzIcEQ4kNVkxXoY5CWwR1TiMYpQoOJzW2AjnrPngaEgDxL
 OozZa6GE031eto+6zqi0TJUGqMYQqSHR8vtm5Q/7EqEHxESOy9NoBcRMNoHpOcbjjn0Q
 ve91zI+vvPW33IfiJ7kKoQwNLsZnyC4TNHTSUS3rJGGzgs2dVQzUgzGEx/I+9xzPploz
 4FjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395227; x=1794000027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gIzkbjDhFpI59wKeEOyvGZrWbWXse9FWOdJm9bjq3As=;
 b=bOoxGlx9bFw+0IMp6idimnyAmndg8PU7+w8/msviB/sryArOE0xfDzDyF8ArGHn48C
 JJNKj5fyzMM66rv2uNtvrT93Ut9Zgxekvdr2i8i6eIwdZE8svlVaaq03ZwUVpgDF6DQx
 vA8ItTo1wHTByMTPtjXOv+u/7vtGoe2QcfaAU25yVYBboGRxis98/qJAdQGFbbbxXKUd
 7mSr9l8avj0ULO3FyshoXIlLnZUD24b7Gvp9A8MOZZkBjrcGG9/CXRxh36t58VxeU51D
 fAq2Q3MHYjc4WuTyyxEtoNgsLJbOlVWQqMIVfLA/LGdRSB1Wz3nc0m0dW/B+58jxpuyJ
 UtpA==
X-Gm-Message-State: AFq9FYJwdBj+7KOgvbburtcVOWmecCLXLRuAidRWr1hu5LTqML2pErQC
 fETf8eSoZfXtuJhVHSmn1BHMy7LCeYJXMkPm8hc+rRGRC1IORKvI3YA5h/Vo7wpjQZjJKhwFNh6
 2Uz8M/fLC11LXWnS+gNeXAUuvQTFfWG6/iT3ILqYlADu+s+nKUIZEkhqltEPrT+yt5JNZea5raZ
 s0xvQ=
X-Gm-Gg: AYBFou0h8vYGeXWNQGrTBBIBpyj2uF7reVa096NjaWV3ZexxeCuEfJEkeuG7VvI5hdO
 jAx9QhjiluzyTiPW0p6OYWisyrGLx7Orh5jRfPuVxRK5qIkGR99lIJxg2SAorBQheRxM6198aLi
 UGGMIn5inms64AWFJbKlhe2Pt9Og3Uq4F05mKi4qNIWjmkD0O1ECN/4F1QDmFjTokcqPkWp8lUI
 Za5Cd2g8fTi/wt6kxhjv7QKuby2sOscMmryV9IH03M6B2DpHFhqS7nDHOu3I9414LMwlyQT9lK/
 LHbIeJX1lXMMHqKQPCqUitkSZu39ahjjUeRoLQVZb8bEo859ffZYGQGlVMfOc6//cV8OwZtPunQ
 6LA8QTHTOx4zo046L2P2zCyl6omS8gjzDSzWVjAqiqVFv1KR+Vy56eMe28FtIXNyInyVyNdOujr
 y+lqQ5ZRA+S6lue7dkjcBt4gA=
X-Received: by 2002:a17:90b:2e90:b0:3ac:86a0:5764 with SMTP id
 98e67ed59e1d1-3ae898311b8mr2636516a91.64.1793395226695; 
 Fri, 30 Oct 2026 14:20:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2e90:b0:3ac:86a0:5764 with SMTP id
 98e67ed59e1d1-3ae898311b8mr2636495a91.64.1793395226269; 
 Fri, 30 Oct 2026 14:20:26 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e973ac6sm10464840a91.11.2026.10.30.14.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:20:25 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 19/19] drm/msm/adreno: Remove temporary __maybe_unused
Date: Fri, 30 Oct 2026 14:18:21 -0700
Message-ID: <20261030211928.45761-20-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX/LoTP0m1peMt
 Y7dIvA2nS5/5K0PWhw+bThBBWADvEbX7USmlfWgG5knMDAy8zaVzrL2zqehjn7as8VcdtPVnfa1
 8wOdc25rNJ02llQyL/y1IzYFRebG2yc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX0/QgQdL4OYHK
 sNEHAXbQgy4D5NNI4X0VbXp5R+8Jj+fRxmtOZjoTWeoK0uOOXpn9VFsGTCQ+h3jGAe1fYID4A+t
 1hVrr6gj0QxkS5FTOFzBi0E2iHV0d40NsHJGrXaBHepr9Yk5DFjCY1W6kNK4gBxjl6a5Sa0RHWO
 DJy9hq3TBOYdvrntJSVJRMj6TLt+pFZ7OPPCRNDHO0IB9M0BQRyuSZK1++0alP+iFo5dh1Ut6Fw
 DBWYxAfJ6N2pd85r424V7l/J92D3THX12ScwCPoByZldXHzcQ3QyEvJwsfBLb0z7ZuahRTE0glM
 o6Ih8LG5Siu/SHwv14xsCdpFq7rVSCzQnN/Le0yB3+Z552awoYKBM4yq4PynUEueDM5CJt5tOdG
 ZwHkIeDk4Qmb17HEBwEJqfTo4X3AUw==
X-Proofpoint-GUID: fjfqG_lWGkq0PCgWbBjkfPVHTxIimMaK
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae50a1b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: fjfqG_lWGkq0PCgWbBjkfPVHTxIimMaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300085
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

