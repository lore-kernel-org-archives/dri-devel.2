Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4F606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tf8SYeTQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gCDWZYV3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20278112D38;
	Fri, 23 Oct 2026 23:26:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4F4112D4A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:26:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvCwh4006342
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZeMHMSFZZC5kzxTACMlu2/mr/ht1FGhdzncsmsVNro8=; b=Tf8SYeTQdKU/p1x9
 LUs2p0qlQ8PHEy4xAaf6997i6QkTGmNoIcnsOujVth0yszkij+32PGdB/q6ujVRI
 4Ffsn0/tGNlCw0T2aDzasCOBZNO9OEUm//P+/nxoRozNR1tj0bWI/mAg1otfAGuX
 Rt1bYgTK6bX+LJHoFZw9Z8Ottqt4oMa+wvQsT2F+Hd3Ulv4KimGxGiroACIN4BPt
 uPs3foOFQ0P19MgvK4h/gEVMgit6zoS+M7iGZIQh/VHzU8TD0pDcYlb+3udq6rEN
 Pd42N9R4OYymE4N9w3BllRf/GPt6UYysWgyuQNj7BCEl0Zg7lINTwGl9bhYyaN1J
 3Q9+OQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn26et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:26:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f568dee56so55283585a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797961; x=1793402761;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZeMHMSFZZC5kzxTACMlu2/mr/ht1FGhdzncsmsVNro8=;
 b=gCDWZYV3Wr0A6HDPleK+1CpChLQXJgGK7CusrD2bFld0k+AtmCLampDQxx9vnvCAf7
 l9q2oM9ht4qzs8H6nqj/MTJxeGVNMlyA6/FL4dTaAJSOyROtoflJV7XQ2fnhYgPKHSjv
 QNgGs7zLpbL5ZC8odheFtWK3rmkZdtw2YDLxZLbAolHM/v1Wzk6V8a0Yh7M3Ee2oO67a
 e//Jm5w/SfmrQbcTR+QgY05Dm3oyzEsmHTvLUSi1wpb/4UeW9HnAPsXQ+1nEQP8FNlP/
 KesnnDCI64vZEhQcSPtqrLYGW0EXd8JjosXfALEnMA2ZgM16XDtvw4Ao3vTBH+vfoqip
 nCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797961; x=1793402761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZeMHMSFZZC5kzxTACMlu2/mr/ht1FGhdzncsmsVNro8=;
 b=VogT6xaw4WzLCLWqRgtZ6NThkacu/WYnk0QSM4Jahb0Lm+gP6FakxMDSb3/mjMtLmG
 fj+HZxdSuPKksN0DD+J3efYLHqYc6KYePx/jxf3sXKdGg3XqGcdUZcPajuSdismL7Tkp
 +0whiNT0oG6GCfbU+iBRMWHOuh6vSv2SGetEEh2qQWC4cOQPsbqf4OuaKvML63H659jf
 3mli4mm5JSMNhdGy98QwICVl5tq7cZPsB0gImgMyu6pqvdljKL2amh9S4jVtkyoN5m+q
 TYs80zvQMDJwnLTtoR2f4L9IPeV/iBBlRAg4ljnkAFlCEBRm+Asrzyj0wBBID+Wvzrfs
 7hzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9hMJjZPFgdUIPhOgBv85mOiWH5FNBMOFANTD/lrZzTOFApstOxV2gXb3sSfvrS1tvbVnIAoBm3CE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKIPqR6O2ea+l1Ci+r5DlRqg+7eVY71MA7v58veS6bhLJgbgt3
 L7bH2C7nDPwgC4n2N3Hwxmx6Ma5Jul9LVcZzYoW3lezNM6Gfx1qCcRDSzYdv1Jga0+LcAHv9sp5
 1gE6Kwq5S16e9u2/zh27MOVY1kC84eGBQIzL4qdihYUPv7Dr2gQVERtWQm52oUDj3Od8ydxg=
X-Gm-Gg: AYBFou0yGYnW6pkHshPyfBJu9+yE+JPRswns/7E4aIwNtrHiIJlyCUq6Cbut5LWRdBO
 unlLatb+L8RfXWMmQwcbkDks0Z5b/XMbrvPakiMYDwaMFSxHccR2jOZO0ORdiYgVmfaP4HihSWK
 uUZ4eBKjmxlWEp5RCXBAKoN8kNigZkwZptDbX0e0qHVTt+Ras+Rj5r6oro5HunWprX3kGpvf4Cu
 ake8bhzm2HE2sH+8j3Fg7ofOg6ZerYmDNVt70tcZFukzVhWiTmenV7AlC3CF+PPqhAnGQhFUEcM
 sd3nJVa3TI1k5UINTwKefDxHL9koECWiFglqeTgixirTn6j/0TlGS3j4N6j+z8eGzKRE5ryra1a
 mJtF6zKoU6vyN4oYoYlYn6W4xo8CvnXyFPLXuFEMdqXCDfjsRb+nWy1CxlFHMAH6CexBukCbmMy
 kbSNQRMC+2s4pm
X-Received: by 2002:a05:620a:3726:b0:93e:fa30:f1da with SMTP id
 af79cd13be357-940ef8f3bfemr86920985a.45.1792797960605; 
 Fri, 23 Oct 2026 16:26:00 -0700 (PDT)
X-Received: by 2002:a05:620a:3726:b0:93e:fa30:f1da with SMTP id
 af79cd13be357-940ef8f3bfemr86916785a.45.1792797960036; 
 Fri, 23 Oct 2026 16:26:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:31 +0300
Subject: [PATCH v5 10/10] drm/ci: mark pixel-format tests as passing on SC7180
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-10-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=clQthlwXzRhi1W3zRpYrUTaCyBOJES7iCNAqF5m45Zo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+ztkv4NiwBFqBCDxxLRw9rvtynMFjCU0KE3s
 6VAiCiEaU6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs7QAKCRCLPIo+Aiko
 1dW8B/0bQcLFlB+5tLCLM9nYzJOPpsrZrQa9AsHn+vKjiIP2KxVZXJA/E8U3lyX0K4fD88A71Ne
 E9kRm0YSh0tOXWaewb+RZVtlzQb+1JypXYhNReacBAJFlZkklzs3jQPmLMqLuewfqbGIE0Dq5zO
 5jD/So3gHPJMKFmtjYDLbqpWOHHrlEtSvFs6OcWGiifutSPM02wZruZqmfopiC8AiLblKgJTyAM
 NAw9KO/zXitLx+OgUc3xwjMgDqBqsRXwdri111IDa06lNlsqqHsqWniYGjZK75sDpxh4XbKdqZY
 xOH2m7GELqW5Zp9CC2+a6rJqXBtawww6aoJC2OtivEv1B2f5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXxu/MuqSXDyG6
 BRBt0+IB5e3br0M/Fk8Bl5LYi2Zgw0zjIoCxSOQ0tsYAZwCgJJbcbiPJOlAuRFlTKkIXyrh8wX4
 x+1FJm1W5lgjc4ZhEwPb7b0VE67DG6XNL0kC5drCq65B9BW6cAaWDWMNCAw6B+TqakL0dkI14CN
 GArfFxY+Bt5SPFtpLVbleGKtCWdhtiLi/dcX3ZodFZqZ2Vs7n6PpLU1JIUdYgmQL27iUeWoGFoP
 1EEO+t9prCYNPP17qZtFNreUQerIa5M8b9KJ9/cPQFoEJ0YmqNczb93Ifplt94ZEPBnPJmEJnss
 1OFzYIS2Jn9VACBMfxoJ6VfkOcvlKcvRZUz+h6feq/8JBelp4qouNxrq7/4+UU8KCswGE1w57sC
 j3Y8giEujCnYR7bHfH1E8GtTb7o1Z9Wl7m4+4OFcZeuO3+QSz9Rp2ZCP7XZdUBmVo9uXgiCoBBw
 jOElvznmn3EeyFoyN/Q==
X-Proofpoint-GUID: jib7TTrplf9Dl8vI-MT87Uvr1iFN7PN8
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adbed09 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=fLdCUpYKHvtX-iCVteYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: jib7TTrplf9Dl8vI-MT87Uvr1iFN7PN8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX5If3sgzV+tJL
 Y55Y2hPB+B2HSACk0CTVpcIZhWprIy0FwmYMRleJIC1XBhElr0rDtHKiPFFBTWRs9jBIRNB5ZeU
 6cLXsGUKtsGp3BYSKwn6E/LfB5YUO8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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

kms_plane@pixel-format and kms_plane@pixel-format-source-clamping timed out
waiting for the first CRC once the test had set a legacy gamma LUT.  They
pass since "drm/msm/dpu: only reassign resources when the encoder is
reprogrammed", so drop them from the expected failures.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
index 2daf4ab879a9..ea3013faa37c 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
@@ -18,5 +18,3 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
 kms_plane_alpha_blend@alpha-7efc,Fail
 kms_plane_alpha_blend@coverage-7efc,Fail
 kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
-kms_plane@pixel-format,Fail
-kms_plane@pixel-format-source-clamping,Fail

-- 
2.47.3

