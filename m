Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AF9CA6011
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11EC10E89C;
	Thu,  8 Oct 2026 17:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNtoRA6t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="De/JAk3k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE1610FAA1
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:24:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVH7i2299407
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 17:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OwpqtceDom1aGkBdN5g2SVPWt7IlrevNh3IiJviiP98=; b=jNtoRA6trUQqsy2/
 WxSedGq8gkDGU+gQNQSq4r3TloMX6RHsT/PBakkw2u50DJrnrYWypcvunISk29ub
 GBRriuUWzo8shexE+AG3ILHk3eRtuFUdzQebTSLVdvED65DbkLqJhicohffPnThV
 pyiICire5tCpnUTLNv2+pF/E9UetRvAB37eeT4bV+YVGl/6dPoDRmPJitDIVbnOu
 XCUkxbBer8mIsrx75vLdgU8vP9Mevw+KVSZjaFUsWVgM84ECY4e7q//HcAXqNpF8
 MuwpqzoSBYDQYii4WuNMQ3FZavpJeiEy/ZmBnjs3PdoM3BJmbnxosRoDJN5PyGoH
 HHR64A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2uymx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:24:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so8922387a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791480277; x=1792085077;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OwpqtceDom1aGkBdN5g2SVPWt7IlrevNh3IiJviiP98=;
 b=De/JAk3kILwMMQXloLb0cg3WPcBqkqNZkeufnTN7S0cKoSL1W/9oIY9M2HyMWsFcPa
 8v2HWyl/AreKoj1CuYt7LnNRyXg9qD0ZuTWEbWw+ztqGq886DjHGsCXWYTEU44nBYZLq
 IIVuttCF/z+hhxHjoktZ2406UBWzgMH5ezX7Tj3HM22/6iX5XMfSc+u4HZzyoLwKFxpb
 7r8suDRZvsOpBzkuRpHUGwsJ9sdQ619pMwOd53/4eKB+yyKCqXEd+MZ++UROZ7WNtVcz
 neptztbnZuU4DNEzoe63uTm0Zo7HJ2L706Lfr43KFULWw+q5oFUcVmaeZ0QJ/P0pDEqk
 +mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480277; x=1792085077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OwpqtceDom1aGkBdN5g2SVPWt7IlrevNh3IiJviiP98=;
 b=IVM8id4WdR16TxPuBpKBzjxdremDMWSdti4NYPOcuYinpkZXhOgpsY8fdRIySyURaZ
 uj4s5ANJm6F2FzQatS0iIpoJtafNnjZdHSGvWRFtoX8jkeYMMviCKRaonG3WOvwq0aMx
 J0kPop/RWioFDDMElAUoSBaZ6G8DwzzrqLD22JrnInOwWgiiAZMF430kRDOUZVF905C9
 U+7+V8dlRTekJPPxoroxp8BWBbIjXO9Hv3P2RNDUX/WnVSMJCuDKZkD6vZeoaFpU6KWz
 58AD5chkrq7ssbHBZa5nMByhCGO/NOmCP4olxu/wKAzCboNQeoOV+6vcNcBYlOPBwXjA
 VQQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxM1Usnct+BGrH+FrQUDPfHBLl3MEh+07ODb6J8EtUFAHxwdV3K3LOuYyidpfnHZgAfIgR6skHYyF4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKOPQlQJ3tRawvuafiMFbONs+Bdnup8/FVBCmv42S0kp2W2XC3A
 vZSV0gQ4aqMUQu8FgqIT7kwDJi+Ma3kw/H6cF+wu4N20exdYbOZ79+LaS6hnbBj0Z1UjiNETMv1
 hWhBARNhaCY3EvZ6M4kyxLQr9OX2D67M106dzXoygoEMDfVGjdYcSpy+g78q0wptGCwqGjGA=
X-Gm-Gg: AYBFou0PMam9dq7RvVwXFzvKFNwtlL+5t1ePwCQM/HQceNrCLjK6q8X0O+mdaACC4X6
 iNsJKr4cTGJHrxJHXVqEMDH2yiMRCrXb523Y0hPoqk2MWwd96C+ER05DRTXXphxZtLH0c8GHNsf
 7cgmUYMQezl4TEmGsUR052StaFX6GoshITjAsUFIKyQo44MHZBNq2tbqE0Iznfh0JC9t+uaYW/R
 SIwaWyXtelhIkb+Aed9A02gn0dQITRuUr0vy8Zc4Fdn4eTL3ydG2XIiGoeunUExAVl3GE79lW+B
 9evgvjRwHL8tGYr+GsorBA3hZSiZK9oUeb1e7K6Qu4RCFyUlVO4ImGVCSe31GbWQyjwLaiVVziz
 2vY+tdKhsA/NPo/6cZ9zlV48PNA==
X-Received: by 2002:a17:90b:48c7:b0:3a8:495b:d65b with SMTP id
 98e67ed59e1d1-3a8a04bd8c9mr5760829a91.5.1791480276960; 
 Thu, 08 Oct 2026 10:24:36 -0700 (PDT)
X-Received: by 2002:a17:90b:48c7:b0:3a8:495b:d65b with SMTP id
 98e67ed59e1d1-3a8a04bd8c9mr5760814a91.5.1791480276515; 
 Thu, 08 Oct 2026 10:24:36 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3277c459sm47228a91.16.2026.10.08.10.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 10:24:35 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 22:53:50 +0530
Subject: [PATCH v4 4/6] drm/msm/dpu: filter writeback modes using writeback
 maxlinewidth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-lm_fixes_final-v4-4-fa986071c3c1@oss.qualcomm.com>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
In-Reply-To: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791480250; l=1605;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=xKhHPbKFhLL4gdnufa1GvpLiPv0X7mVU1jtEuTWW/j4=;
 b=eDuowAHuuxNU8vFBxCO997pMI1s6lyVxVNzDpxSs/SBlCVdZSTXZ4IPtBAFuKKDEbqXUNJhbI
 2TRhfhVfGjUDtsdRXA+HAbqWbmBRKT9l7Qd0sIPZCpZe8fQsiZ1GYRz
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX4g23U6Ev7M17
 FP0/RoUlvXx7rcuOH1VRdvKRtBtw3LrAWKodDclIoEu59e6eq9cb6liugtMbzVvU+OIU8XFXtGH
 RRL4pKfdZrMwOoAiFO4z799XHcYARd4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX+1hvborvNAWY
 ndcWFJOyrbUBiCd2InqWoN94FNnKiVVwTDEqQ1IZkWI5WRfSyaogc+9lIbgl3EVpCWMGFrVEMia
 hOPdJq3l4cyX523u3YVhJG5l4ZcPba/gIzhsfbfVYvHguT4pi85beblyi9UUq0NHhB1Ryz/RmDl
 rycAqoTBf55j/+cDLT2qViUIWWXkwHMh+Lw6EHYCE90cUd9Gzcyc9gZ8VXEJX42FVO8LOaR+NRz
 n+aq2BzU00zlq0O2pQq8d9QaEmrlxJAgAO4xcqXpfMtA+KD1/YqNZWUavpEEaRBu9CO0iLNIu47
 mqDLuj7gcKhRVdVHmctrcNzNM4QGrAl9k+J1kx7t0hPm/a18ZORQ5debP72x6N8Rp2auzSL5a5o
 Wf6CWiStD/HzJ8pNX9idthi8mznCXn452IQPV3gfeZgCB+j4gvcTYnkaF8s6g7hpWHmmBF8BaAu
 +0aq8iy6dmNVnnoZ5Yw==
X-Proofpoint-ORIG-GUID: szgSKUlAgURbg2UnPSHd2Rw-CK3K5QtA
X-Proofpoint-GUID: szgSKUlAgURbg2UnPSHd2Rw-CK3K5QtA
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac7d1d5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=K26iOwrG_T4ePdtMxkgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080069
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

From: Jessica Zhang <jesszhan0024@gmail.com>

Maximum width of the writeback mode is limited by the hardware buffer in
the WB block rather than by the LM properties (LM doesn't have an actual
buffer). Use the actual hardware limit (the writeback maxlinewidth) to
filter modes.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
[DB: fixed commit message]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index e7b09013ae4c..a31b6e2f5cf7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -15,14 +15,7 @@ static int dpu_wb_conn_get_modes(struct drm_connector *connector)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 
-	/*
-	 * We should ideally be limiting the modes only to the maxlinewidth but
-	 * on some chipsets this will allow even 4k modes to be added which will
-	 * fail the per SSPP bandwidth checks. So, till we have dual-SSPP support
-	 * and source split support added lets limit the modes based on max_mixer_width
-	 * as 4K modes can then be supported.
-	 */
-	return drm_add_modes_noedid(connector, dpu_kms->catalog->caps->max_mixer_width,
+	return drm_add_modes_noedid(connector, dpu_kms->catalog->wb->maxlinewidth,
 			dev->mode_config.max_height);
 }
 

-- 
2.34.1

