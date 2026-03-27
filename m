Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1745710F286A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77A910EEBC;
	Fri, 27 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffk8pkOC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gB5j49sy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2E110EEA2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2haT083249
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a6kRrSPpI+U7LkLwcOn9HsFVFBW06sGA4X+7KKxW3FE=; b=ffk8pkOCOEg500SK
 3ZBeKv8gBYyO5RoJVU8iwZcw9akd6XyrNKrB8AbpDyS4Hpw1SzadOQa5K32o34Qg
 LXXkqthS15doki42Q8HbvxIBY80U+ygNHQS8QOULwaL2V0aTVueL6REz2l6OLJOu
 0rBMQZyIZhsbNxI/v2Ay6eV5EpqXCCGhiottuFxOUSpqmr/FxYtGdzYukL+Y2nkB
 ed7EHHKt3Lnc2TyhKOIeSRJr7w4hINmKpUM7QGU0ebAxJ+/HJB1nMbLehUJeF4YS
 kO6UILrezHtqAuKuFrwLkb19PubbE6bTNc0hhjpL5EOoXbm9kYIPZ0GbY7DqC4DP
 p1ruIg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx39sj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so62987291cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640880; x=1775245680;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6kRrSPpI+U7LkLwcOn9HsFVFBW06sGA4X+7KKxW3FE=;
 b=gB5j49sy9K6zK8+nEzDOD1M/EPtiqo1GuuQb814fZ4RABW7EAKH9Y3+JTPQX+2R1KL
 7PAym8052cikO6iAQ/aFdgkNPT3g22BlP5bwm3A/yMsURkznafLz0QBlixRzHoDs2B3S
 WVTZumQZe+h9I8sqVuMT+LYKOFTjJDxMfwIE/9S8+7FDsTkn5FhqkSL7S7gntWEDiUJx
 auJ0SMK1Mh9f7W2B4xBvGAHfbtOIiepzp135nKk7nbrp/tvqon+NC3/Nkv7BlUP6y3AU
 cA20ZF/XHWZwqejjdAbXuTcdOhUFxmax2sRdcTEMN5rS/c6wHSfbJDNe6GBydlpIJc2c
 XjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640880; x=1775245680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a6kRrSPpI+U7LkLwcOn9HsFVFBW06sGA4X+7KKxW3FE=;
 b=STeywa6MUtbmf7NUpYLUoV5PS0FjIsR/ackG0lWz6u9TVBRqJILsuNlECuxvm/MKFr
 mt3erxEbxZV3ba/OC0n513URTBhON3eJ6PVn8n21X3KY9c1wH42pVsmnV4w5q9QYm6uD
 I12FbEXmr/p50eI2+OBsTv6Kd7ZqW3uBxvYWY2aBirzft1I14M6AE6FcECOthKy8HPST
 mnnrmaqfGccWNwpBeFekR6H79re0PcgNwR98T80ugU+iakVze/I1zvura5zA02R0hgYb
 Bf1b37grcmS9OFXXK/1wIMwrBSCe+G1+LcVloes02hsNxB6K2y8KNj/M0XAIM5kaOgSz
 OKOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEQKdwPIGUOOVxU/bT/Nb25vFWXGPlxnirPCZ2bpPcf+b+hjL4ZpVtfadSg/ti6D/7CUs7c4NhJrE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbvbVO2p8lvfgigR+zs04ypQAcXS6SiblivMBYPK7L/7STXW5g
 Xu/IlmGqpFK7sX1fpf1t7ZqKB6c3gN2L3hVC1YfEMoVuTVU0h5+dyUobWLpbVP6GjOo1mx76AEr
 xeTf51P3qtmjLhfIIundIBNROg/5YQcNh5s/ohyXo/HIFQ37tF5gtO0s2frjnu1goXMFPlQY=
X-Gm-Gg: ATEYQzz33ZlA4KcMsxxbMIoWt3hLr13hal5moFlzCLoWAtHG2SJV8lz7WKvG0hjksMz
 BAa4e1LZSEClt282O8DtCGGgCntfqftvLUbAqwpMiVb3mauS1mP2cYApYpdUdHNx3giLa4wkAMV
 gqC/JGnf5aFUSeR9Gf7ksEi/O0XrwVBtG9q1sqdyhp/oMN44OhjdTayXUqFiVPZbbhNlPQyjhMZ
 F277VyWp7WpCWkG10nfVfFVpyj8AC60zeplE0ep2cvkiCf7yQiRUvE4CJiASd3O1T8QGbkiFdvr
 nsI7SroevXORUfB/Zm0zSKaMF9MunZCRMByUsEcbVK83gzUHdCL4lfd1sh0bKwdcWdQ1XoryMlr
 4L22xZPCWtIk/f4Y/3iMwUn52jlZJScNyu9vaDVGjr5r8KEy/QTXrbMHs4SBtaqaQFc8uRRukZ+
 hlf5OUVsorYJ04FBT7Rk6ubX9yVZ+RUO+y
X-Received: by 2002:a05:622a:5518:b0:50b:509e:7920 with SMTP id
 d75a77b69052e-50ba3923ae8mr54201751cf.48.1774640880322; 
 Fri, 27 Mar 2026 12:48:00 -0700 (PDT)
X-Received: by 2002:a05:622a:5518:b0:50b:509e:7920 with SMTP id
 d75a77b69052e-50ba3923ae8mr54201481cf.48.1774640879944; 
 Fri, 27 Mar 2026 12:47:59 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] drm/msm/dpu: use full scale alpha in generic code
Date: Fri, 27 Mar 2026 21:47:43 +0200
Message-ID: <177463970861.3488980.11178737973899269892.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112-dpu-rework-alpha-v2-0-d168785911d5@oss.qualcomm.com>
References: <20260112-dpu-rework-alpha-v2-0-d168785911d5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6def0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=TmsmrAseboHqPPC52pMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: Om-l0MK2yyFPiN6bNkbiypVR_Je0PD_0
X-Proofpoint-ORIG-GUID: Om-l0MK2yyFPiN6bNkbiypVR_Je0PD_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX5rlyalaGH9fG
 ffWh28b2ASocweGu/zFduTOtQE2vlquuXMy2O+jfHzrZZFIjlgWnYNoGyJVQ/v3WLVWda48ll2v
 iWBCijZXJ03M9uAiSRHrD0zlZNKzcMpNCf15t6b62HXjxpgr7JfVl/2TpKi8rQ7KpJTvFcnViwF
 4MJvZDxZkhvs9ydLO4KAELP03w0dLTQYwg29QhGOlqctFUU1AQQorGYQsmDYUzD+Zdrt6fXj/mw
 vdSqMrRfFzBg5OLZU+P5p0uawAOfNYi12TzVIfefmC8SkZ3UgNOddXgEPa6gResNFRJy5yTx7ns
 K+3uJajS7YoDzPl3Lhgq7XeJaNmWYiSUvt6Z60h2mwIlzTyH/eEnzzmhRhC1WzYv7eOQ/janJdf
 09H6DiI73I3JYetqYQxQqqv5nlNgqN71L9auuUn6EAtAxgnBXV4xR6Ti8rYLiswg1ujDBpH0SBs
 ipA4Wo1t4cJ1gSHSY4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Mon, 12 Jan 2026 05:23:29 +0200, Dmitry Baryshkov wrote:
> Both _dpu_crtc_setup_blend_cfg() and setup_blend_config_alpha()
> callbacks embed knowledge about platform's alpha range (8-bit or
> 10-bit). Make _dpu_crtc_setup_blend_cfg() use full 16-bit values for
> alpha and reduce alpha only in DPU-specific callbacks.

Applied to msm-next, thanks!

[1/2] drm/msm/dpu: simplify bg_alpha selection
      https://gitlab.freedesktop.org/lumag/msm/-/commit/eef07fd9aa5b
[2/2] drm/msm/dpu: use full scale alpha in _dpu_crtc_setup_blend_cfg()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/7fe04c7c4360

Best regards,
-- 
With best wishes
Dmitry


