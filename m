Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA0A103A9A0
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B444E10E6C2;
	Wed, 25 Mar 2026 02:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWYOWnCw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CdappRfR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729FE10E6C1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:59:11 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJDjpf3984442
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wV5/ZuuC91zLDNx+7e4SnT
 PPCzXtvZtWdVpISbaXSrw=; b=NWYOWnCwIKheRGJhrTbn1qF6WkoND46RYB9EDg
 tRxvWS+6zZ2xvGzt2fSFGs8OI/r/VplFDjZ7PPA6be4VGfGBFVPRYICn52uF7fDJ
 9t+v2MAZw4S9eTd/UPEfUDrGBZOZWAuRe4aYodpaVkY42pP1ghbcVC50GKAyAEWh
 DQAAoRKa/coDaU+UUebdKExJ+D8Up5u9ViVVGoutD3E5JBEWKC/oXS6J5p68Q98l
 QKP7mmmbW1KIpMBWb1qlO/PGIm5rVsqEMqsLgqjOE+ZdJ+DiuaMd2hkpJqbKsTJy
 5ZraHlSa9v2+POm619IIv+JA1SQusTyus4lsfsg8QibeUYBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p833yjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:59:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4b81c632so73766501cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774407549; x=1775012349;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wV5/ZuuC91zLDNx+7e4SnTPPCzXtvZtWdVpISbaXSrw=;
 b=CdappRfRQHFWY2731cA8DRdb3jNpahQLfV5CNoIR0Eu+aoQc+ycQEphnxsGzzAVr9M
 4LxpC2MKXnN/jQMHLDa6G3/7YC6YLW8kNg4CFcK9rTVIsPnhQCOwI13lAZSHePlle42T
 nEztpCEsVxlKOpBlaQUUNX23QbPkQPH3pebLwWQmn6xvESOSHQI6QVPwW+FCIDBCnKzr
 nCEzKDAbW0bXLNXnwsEsawz2BmpkpKbcu67b/q63Ux74TAdrpWvjmmZ8DURFF4kK3UCY
 igla2yecCJZOpFNtsSKP111avk1p9fjU0HJTKRMjlRsgGEYZsVmiDTH6TPH9TGn6W9FK
 izdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774407549; x=1775012349;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wV5/ZuuC91zLDNx+7e4SnTPPCzXtvZtWdVpISbaXSrw=;
 b=lRDTyki7+Cb0LXBkdBx2mBQwukEoJm86OCOAMMkX8eP2qbd9XcREPSS/U/ttyNb0t7
 gWJkONtnEmnUKw/NT6F4Na6oxlQSR9GBWEmBHzARHYk/i6bZoTpG2KoVAoBWnXrHP0ts
 /jMwxsZ5kc1zdCw9rMnPJV6E+d0ntVzRFWDlze/mjTrO9/sq2YZouoXNZo5+cJxygAfU
 xZc2Omw4Gef658tLwTAMz1u/M9NIpcchkqSatLG8dArafl0KqniK+GF6wVen/FopV00g
 LREdIfqF4MYAMbcqOVJ+kMo1EdV4/oLcConBUx30XlHp6e/Tt8OLSS6MSigkqc1lTpSH
 wDHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUecY5+R8iZQKuNDl25zIp1aW3lyqUZW2DM8FWPhqP8tNJtqLiAmjJwse7iMjeptn7PAexqguHc2HI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZRKuPjTzAkSpvZbORMXyKROLEHB95Nl+m4anwZLzhiTJztlSs
 K8DB0mHrnGGjr0mRiUWFjzELO7s+yIW9m4Jqr1LYMkXha3WqYkt45subyUyuhQUNE4B2x9+d5Rh
 g9tRYQ4sZTG5rvaXsnKh9Wn8aEb/5XQ1Jn0zuxWVSB1fzgbQSPxHNb2EFdFwJTwq2dNbaCRtL1y
 jP9og=
X-Gm-Gg: ATEYQzyV904tOAbnxQ0JzI8Fg09cKRUxV41MBW8UZC+g5CTYBBg55lq9MczRibDSViv
 Nx1QtRL8gYqTSOWofU8h6UZadWC2ufsL7lc4hILZ9yTXkIa3Le0cA1xX+61b/XY1HwIfDYE7T7L
 IBZtmaJyGzayLK2Ph4xg7DIKiy97S+Vx1Ut+FNmUrKVXIKloYQsBbBagc2SZuUhz1440RSi/OZJ
 Qor1qpqydgx3YM8aLGBFU6NQVZUZUOXtlU6Z6uwDbpZrhc2jj8aKiluBK1hwEgKk72Ie7VgavUH
 DuRDUpVEVOlHtBID3otzFp/eCuPSqcdHFm0HfO/zhUWUxvo7Wpg3xMzHJ+ZhM3O/OVKere2dbpj
 +5C4RI6w84XOJUChNpq4ZCSG+4e+m8dcISl0FL87KZWsN6/+IehQFsSNSGzdIWn8QhoCTcPiF7e
 2g/zFr36MWIVczFHeY+DHil/ffsnrdKodDn7I=
X-Received: by 2002:a05:622a:7009:b0:50b:3a6d:db5f with SMTP id
 d75a77b69052e-50b80e9fa72mr20441351cf.64.1774407549519; 
 Tue, 24 Mar 2026 19:59:09 -0700 (PDT)
X-Received: by 2002:a05:622a:7009:b0:50b:3a6d:db5f with SMTP id
 d75a77b69052e-50b80e9fa72mr20441171cf.64.1774407549057; 
 Tue, 24 Mar 2026 19:59:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a28e890ec8sm2278129e87.80.2026.03.24.19.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:59:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 04:59:02 +0200
Subject: [PATCH] drm/msm/mdp5: drop single flush support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mdp5-drop-single-flush-v1-1-862a38b4d2ec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHZPw2kC/y2NwQ6CMBBEf4Xs2Y1YgkZ+xXCgdAtraMFua0gI/
 24VD3N4ycybDYQCk0BTbBDozcKzz3A5FdCPnR8I2WQGVaprWakanVlqNGFeUNgPE6GdkoyojVX
 3qtZW2xvk8RLI8voTP9qDJekn9fFr+zcCvVJ+jEcNdCeE/ewcx6Zw4s456GmN0O77BwJrXECqA
 AAA
X-Change-ID: 20260325-mdp5-drop-single-flush-bdf2935bfbf7
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6042;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LRaUhUC19UOUkXS5dvPplXuBx0t2aGc7Jxfm/5YZeHY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpw096GOTKcKP1kjTp+BZKi25rWFZ9xbmwJUAo1
 y607cdkKJ2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacNPegAKCRCLPIo+Aiko
 1VlnB/0U2RQgVvktqX50lomOi8KF5ZmNREpIY00e//ZjjafJn+bSZ/CRjPrYq4ZvtexbAb15lzJ
 iojnXzAn051yPNeHsuw2Ayf05Z+i7pA/fkxiUyqa8EnOfevbRSqZdKZmr2Sp3gj88rSJDidZh7B
 b0guEzEQ3ycoR2acs8Dro3MM6nOP+ujdBccYhkEsJ9oOsZqd9VutEFAOb+R3OBk+dKf4y+/g5Gx
 D4bdxiWGshEZ7zvOLJ3H4BYqSxyKutpGWBUZbFiGu2XRHZbBOBmi4EnOdGYhNA2pkk2YcGigvLc
 g5WbkndUxn4r5QryZLXAjx2Z18HM1QXfoMJj950+snneLLJJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMCBTYWx0ZWRfX8HwZ2mZeDpH1
 skHMqEB4bevyrpPk2NHNaVaINK2+Bi3lCaOwAzlvg3P2qr5ABJHK4uILDoyK5ytegVxbf25B02m
 yeLY6lh0JZH8JrrMa8ZlNbDt56NG8mANTsnWYCRUavhkBK2RjCmc0hdize9bXdjf5xvFDWG5hPF
 9ikHy5vM5Rg8/WUJNM7TpCGPPP1OaapflajM293Jmu53B3QEmOFALtSz0CuZ2N9ewQxs6ljfB0g
 xHh6oz7KcOea30ujF7xVwkFsg7vd4S8bV3yYN7DrPbgTzcXXwDzhSMnOHkk6IXiJzkuKeNxhtzS
 RlH/ntxFtsNeUUKw+/lAogybvqLpeeButtBodmGIUXEUPo5240H0NDjIlB4c28reYhP42BcVqbv
 9gijo0wRKdxtHN4ab1AxDzWfQze5WRlchg92S3eg6d2oM2rDi0LOsw17RYjG3Nkiw9mYKLf8/32
 Aum7DTwTferrO/xNwJw==
X-Proofpoint-ORIG-GUID: KV8Hnkepf7nTvB6QBZuG73022PS2_oqW
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c34f7e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=pd6Mq7pKhYQ23eImG-cA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: KV8Hnkepf7nTvB6QBZuG73022PS2_oqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250020
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

Support for using a single CTL for flushing both interfaces was not in
use since the MDP5 driver dropped support for dual DSI configurations in
the commit df3c7899946c ("drm/msm/mdp5: drop split display support").
Having the MDP 3.x support migrated to the DPU driver the single CTL
flush is applicable to the platforms suspproted by the MDP5 driver. Drop
it alltogether.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c | 90 --------------------------------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.h |  1 -
 2 files changed, 91 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
index fc183fe37f56..1eca140616c6 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
@@ -17,9 +17,6 @@
  * a specific data path ID - REG_MDP5_CTL_*(<id>, ...)
  *
  * Hardware capabilities determine the number of concurrent data paths
- *
- * In certain use cases (high-resolution dual pipe), one single CTL can be
- * shared across multiple CRTCs.
  */
 
 #define CTL_STAT_BUSY		0x1
@@ -46,11 +43,6 @@ struct mdp5_ctl {
 	u32 pending_ctl_trigger;
 
 	bool cursor_on;
-
-	/* True if the current CTL has FLUSH bits pending for single FLUSH. */
-	bool flush_pending;
-
-	struct mdp5_ctl *pair; /* Paired CTL to be flushed together */
 };
 
 struct mdp5_ctl_manager {
@@ -63,10 +55,6 @@ struct mdp5_ctl_manager {
 	/* to filter out non-present bits in the current hardware config */
 	u32 flush_hw_mask;
 
-	/* status for single FLUSH */
-	bool single_flush_supported;
-	u32 single_flush_pending_mask;
-
 	/* pool of CTLs + lock to protect resource allocation (ctls[i].busy) */
 	spinlock_t pool_lock;
 	struct mdp5_ctl ctls[MAX_CTL];
@@ -485,31 +473,6 @@ static u32 fix_sw_flush(struct mdp5_ctl *ctl, struct mdp5_pipeline *pipeline,
 	return sw_mask;
 }
 
-static void fix_for_single_flush(struct mdp5_ctl *ctl, u32 *flush_mask,
-		u32 *flush_id)
-{
-	struct mdp5_ctl_manager *ctl_mgr = ctl->ctlm;
-
-	if (ctl->pair) {
-		DBG("CTL %d FLUSH pending mask %x", ctl->id, *flush_mask);
-		ctl->flush_pending = true;
-		ctl_mgr->single_flush_pending_mask |= (*flush_mask);
-		*flush_mask = 0;
-
-		if (ctl->pair->flush_pending) {
-			*flush_id = min_t(u32, ctl->id, ctl->pair->id);
-			*flush_mask = ctl_mgr->single_flush_pending_mask;
-
-			ctl->flush_pending = false;
-			ctl->pair->flush_pending = false;
-			ctl_mgr->single_flush_pending_mask = 0;
-
-			DBG("Single FLUSH mask %x,ID %d", *flush_mask,
-				*flush_id);
-		}
-	}
-}
-
 /**
  * mdp5_ctl_commit() - Register Flush
  *
@@ -555,8 +518,6 @@ u32 mdp5_ctl_commit(struct mdp5_ctl *ctl,
 
 	curr_ctl_flush_mask = flush_mask;
 
-	fix_for_single_flush(ctl, &flush_mask, &flush_id);
-
 	if (!start) {
 		ctl->flush_mask |= flush_mask;
 		return curr_ctl_flush_mask;
@@ -588,40 +549,6 @@ int mdp5_ctl_get_ctl_id(struct mdp5_ctl *ctl)
 	return WARN_ON(!ctl) ? -EINVAL : ctl->id;
 }
 
-/*
- * mdp5_ctl_pair() - Associate 2 booked CTLs for single FLUSH
- */
-int mdp5_ctl_pair(struct mdp5_ctl *ctlx, struct mdp5_ctl *ctly, bool enable)
-{
-	struct mdp5_ctl_manager *ctl_mgr = ctlx->ctlm;
-	struct mdp5_kms *mdp5_kms = get_kms(ctl_mgr);
-
-	/* do nothing silently if hw doesn't support */
-	if (!ctl_mgr->single_flush_supported)
-		return 0;
-
-	if (!enable) {
-		ctlx->pair = NULL;
-		ctly->pair = NULL;
-		mdp5_write(mdp5_kms, REG_MDP5_SPARE_0, 0);
-		return 0;
-	} else if ((ctlx->pair != NULL) || (ctly->pair != NULL)) {
-		DRM_DEV_ERROR(ctl_mgr->dev->dev, "CTLs already paired\n");
-		return -EINVAL;
-	} else if (!(ctlx->status & ctly->status & CTL_STAT_BOOKED)) {
-		DRM_DEV_ERROR(ctl_mgr->dev->dev, "Only pair booked CTLs\n");
-		return -EINVAL;
-	}
-
-	ctlx->pair = ctly;
-	ctly->pair = ctlx;
-
-	mdp5_write(mdp5_kms, REG_MDP5_SPARE_0,
-		   MDP5_SPARE_0_SPLIT_DPL_SINGLE_FLUSH_EN);
-
-	return 0;
-}
-
 /*
  * mdp5_ctl_request() - CTL allocation
  *
@@ -687,8 +614,6 @@ struct mdp5_ctl_manager *mdp5_ctlm_init(struct drm_device *dev,
 {
 	struct mdp5_ctl_manager *ctl_mgr;
 	const struct mdp5_cfg_hw *hw_cfg = mdp5_cfg_get_hw_config(cfg_hnd);
-	int rev = mdp5_cfg_get_hw_rev(cfg_hnd);
-	unsigned dsi_cnt = 0;
 	const struct mdp5_ctl_block *ctl_cfg = &hw_cfg->ctl;
 	unsigned long flags;
 	int c, ret;
@@ -730,21 +655,6 @@ struct mdp5_ctl_manager *mdp5_ctlm_init(struct drm_device *dev,
 		spin_lock_init(&ctl->hw_lock);
 	}
 
-	/*
-	 * In bonded DSI case, CTL0 and CTL1 are always assigned to two DSI
-	 * interfaces to support single FLUSH feature (Flush CTL0 and CTL1 when
-	 * only write into CTL0's FLUSH register) to keep two DSI pipes in sync.
-	 * Single FLUSH is supported from hw rev v3.0.
-	 */
-	for (c = 0; c < ARRAY_SIZE(hw_cfg->intf.connect); c++)
-		if (hw_cfg->intf.connect[c] == INTF_DSI)
-			dsi_cnt++;
-	if ((rev >= 3) && (dsi_cnt > 1)) {
-		ctl_mgr->single_flush_supported = true;
-		/* Reserve CTL0/1 for INTF1/2 */
-		ctl_mgr->ctls[0].status |= CTL_STAT_BOOKED;
-		ctl_mgr->ctls[1].status |= CTL_STAT_BOOKED;
-	}
 	spin_unlock_irqrestore(&ctl_mgr->pool_lock, flags);
 	DBG("Pool of %d CTLs created.", ctl_mgr->nctl);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.h
index 9020e8efc4e4..0c45f7874c24 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.h
@@ -35,7 +35,6 @@ int mdp5_ctl_set_encoder_state(struct mdp5_ctl *ctl, struct mdp5_pipeline *p,
 
 int mdp5_ctl_set_cursor(struct mdp5_ctl *ctl, struct mdp5_pipeline *pipeline,
 			int cursor_id, bool enable);
-int mdp5_ctl_pair(struct mdp5_ctl *ctlx, struct mdp5_ctl *ctly, bool enable);
 
 #define MAX_PIPE_STAGE		2
 

---
base-commit: 6efced27f5df9d7a57e4847fe2898cdd19f72311
change-id: 20260325-mdp5-drop-single-flush-bdf2935bfbf7

Best regards,
--  
With best wishes
Dmitry

