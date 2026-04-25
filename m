Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10728FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 22:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4A310E4B1;
	Sat, 25 Apr 2026 22:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PV4I2IIp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E661C10E4B1;
 Sat, 25 Apr 2026 22:08:55 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PGODhY3318020; Sat, 25 Apr 2026 22:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EZAGOMZ6HDiKA/1FRIc3U+qu
 HUCplRVf4aClKoDuOR4=; b=PV4I2IIpQpYLofzoJszF2bgTn4BQPP2a7tcFCxes
 8IiQ/Yua5LHLEN5uYudYknMyZovbzV+iQkuhLXNRZqzq3jNeQ764HVPtRcnR7hhR
 r2hkLghEZpGmoqgNtYnmA9hyuKpS8N+9PdliFhPLhxbzKRhAZ1QjABwHvzQvYExO
 7ZzyGaocRFlmKg/9vuW7sM3OiGCxadz6AVU1Q3PzgNetNSmaBc3F0PfsXpuJOmnH
 xwmp/BDbnLSRw29kIr6iazwQWO1aiUKNWcKFBWxp+2TV6wSmasvZPbQlhHWeSdtx
 D1rDgHiJ6oSmxry7H/iDulVR/l7lROL5zyUs4Vhir5bj0Q==
Received: from apblrppmta02.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkx9shh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Apr 2026 22:08:54 +0000 (GMT)
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mdsor-hyd.qualcomm.com
 [10.147.247.245])
 by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 63PM8o9s009397
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Apr 2026 22:08:50 GMT
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4770534)
 id 691E53D1; Sun, 26 Apr 2026 03:38:49 +0530 (+0530)
Date: Sun, 26 Apr 2026 03:38:49 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL init in
 bonded mode"
Message-ID: <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
X-QCInternal: smtphost
X-Proofpoint-GUID: pTuXkFjXbPsmo9S6yGLqg4ff65BphqtK
X-Proofpoint-ORIG-GUID: pTuXkFjXbPsmo9S6yGLqg4ff65BphqtK
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ed3b76 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=sWL3POCLmivdAm_R0d8A:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDIzNCBTYWx0ZWRfX3drHoF1sZDT3
 WAz7Gu4sVrI4VgrRhqyYk+RGNgalS2DVkji5LFuJsqrIbSj9lAEXJLzMtvZlTv0amLFm9PznCgk
 lMQ2Ife1LL7peLSSfwurt5Hf9ijOJe1yRZZyF7Jwfow2zQgyWYT9twSAkNJ0O5JKQTVLw3JINa4
 PrE/uq6kXhFmwcZdsY3M3d+K9wrasZCdUtmYMIwMhzmgJG2VRYd1ARLKK00CLdyy3Kx+XuFnV1W
 1VRJe9oEotJPYmwTeadAcX81G2keGux11Ka0jeebJd9f1pfkhAWkIBAhtOXIJVFwYKaotdXHQXy
 B0RGuteybzeLOlJfj8PlzDpVERYhm/f5gGDvCR39DvJlGk2fjaN8DDtXP1B+Fq9aLO8MAjX1Pq8
 bFE2bRZa7MgfZy18+pA5nrArC6ba+dpdvTPBSGcYo4K+pRqkDu8ZZGAM0cXLNy4qXj+E80d2lVI
 egPoTro1F4NqqiRE8tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_06,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250234
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

Hi Neil, all,

We are seeing a regression after:

drm/msm: dsi: fix PLL init in bonded mode
https://lore.kernel.org/r/20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org

Issue:
- Resolutions are broken after this change. Like if we try to run 720p60 it will be 720p30.
  Even though the byte_clk is set correctly, the bridge is receiving half the byte clock.
  Some divider is getting set which is causing the byte_clk to get half, ultimately fps to
  get half. Some other resolutions may or may not be broken

Reproduction:
- Used QNX RB3Gen2 Core kit with lilliput display and lt9611uxc dsi to hdmi bridge.
- Run 720p60 usecase on hdmi with dsi to hdmi bridge.

Expected behavior:
- Display should support the expected resolutions correctly.

Actual behavior:
- No display on lilliput display.

Additional details:
- Reverting this change locally avoids the issue.

Could you please take a look?

Thanks,
Mohit
