Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA9DCA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C2110E202;
	Tue,  6 Oct 2026 06:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="biZY7E0c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aRE8VIs4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E04710E202
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:55:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966e6aB3661170
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 06:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F+E5bvzyn0WJx+xO/nk1xNk5AmRTXIMMVOaScAhU1lU=; b=biZY7E0cLXydbwnt
 HAtCDEkLBIjp3vbjMmVivvMQGR4Xf9dDyFeZf4CBlS24L9O3BdZ+VJwA98VnwUTE
 dA6wph3grtzc86fLfRfNM77d5VkSodAj2kCrWha/wRWBj21KUiVCNxg/pMrSk2av
 rQLXsDxRUWdOVHsANAWoOcRYHmfIdcJXI2KvAJzX7Nks10wshtPC6qaPZnlRuvoi
 WApay7aR2+IAovZHVDIAl8x+FrS32xp5IYP4da3r2CDUsXKROUYL5E/+bp3LWMzb
 DbMe6ZCHyD2EYBSg3HmlkmaKJHcT54Mks2BAJMJmhSguANpFz+vNg7yTMnbgMPh5
 HT1U/A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4j1nt3v2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:55:04 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf651b26c7so551473137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791269704; x=1791874504;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+E5bvzyn0WJx+xO/nk1xNk5AmRTXIMMVOaScAhU1lU=;
 b=aRE8VIs4Xy+wbcdTvBxFPZ/IzoVy7U3n9HP36VM65dCdtG5P8h38Av9q8vz9bjIZNP
 SSe9ic+vS/jWvvoXeZlt9kf/M/zEoqcVO9noYC555WuHYGvqTpLCyrVLDj5UJlOWtDnC
 k/LFos3mWhtLd7skFAMVRrwPOyKwQXdnLXWoE+gGaXKqBPkC6MgP4glw+DZBVpnbtl0m
 kml96ZnOlkitPCKOfF/3vsTF269yUsQmIB3mxswd5Q/tchtw4zUf8gPYwJLeO04vEVw6
 SP0hgfr6AdO7wOQPBSSxN45EhRkeHzR7JnLk4KwRfuo5dgR6fCdTOZbJ5EfrjPW1hPTK
 uf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269704; x=1791874504;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+E5bvzyn0WJx+xO/nk1xNk5AmRTXIMMVOaScAhU1lU=;
 b=AtwhIWB43mJFfhsDC/+sZzR9jEfg9Jxy9MhO/E56l2rvJc7jNnMvWAIHhVx06j6UM8
 0fRQb9XbbuLws5iWdEodgErpHuFPKHOmMmNqtNI2lxvBtHh0zeXDmoU93205cixDqeb4
 ZYdK41hRhFRaFVnlOyDAEJwhJWFeKhXl7SF52KDO2NvqN91kY++7gAA/j1CLP4Vs02zV
 rlE/oXX28a5F/chjv5ZwVT7ZY6gNYiEeCNxlhMdyZkR9C2U+LufoHafBtux3R9+n/+QB
 +IKZErgkwFJmNmM8710zGuE5U9SmpJ+lx+hfhYpykywz5dY71fxM91jEIkXuL6AZzmm5
 IhBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBznb4Oiy+80BI8gSKlviO6sTDAf63gj8PpP+Qf4GzrDfYvkJvj+xaBU8N6pBf2s4Zam9fx+3UMJw4o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKrKP57RQBFRXfaQ+14dMsEVv6XUt7tDg9sZTl4v8V22RAq5eaf
 KESSzk04s5+Zy+VOCIvr1X16stPeCpcAsU3KFpbmrku/25HbVt1KTIJojoDT/H6JnCA7k8BKq2p
 DLA94T8LpPtyeVAA97qIAUjPN7n07swPuseB/8MPlzw8sPZZJfp1AwVhJJwdL40I07DRppNo=
X-Gm-Gg: AYBFou0bYMUbVG4E3cCUXrFXPmLQffh94n7Zzwquq9Q176teQSWKSjAWb7RttUoSbXh
 wKv9NaDYKwN0IjyGGrK2khbHUHKcTgimnCVfjr4gl3T5hmjsMEhlTOFjZFemJSoUGuCDCfGY8lt
 HJEx4af2+/bx7F5PuIQjQH16YR+LQFDcOKf9kNhcdVRPiTSoWaaaoTCKNeuhldOmFeKvcwqx/zJ
 9dUUJukK6mmgtHznFPCkarTY/pOCM7xSffzo19PZyBMIO3IEX7Y56KGbFp2lbcFCbq9uv26ws8C
 uFU25GLIM64yF84CNC7GFft8yU+YV6Vgm8Nujd5BFI41V3+paKaNTYTBlU6Yu9MrOUlx6uFcw75
 PCvZvS28iejZWUhum+q033JH8gPrDygU4Ejjh4G4iyRpPEAw6OTSgnDv+rqREXd1DDk1c+nY5Dd
 ARQslaXovI0f+4
X-Received: by 2002:a05:6102:510f:b0:7bd:b263:14c8 with SMTP id
 ada2fe7eead31-7c245cd99b1mr2427448137.30.1791269703876; 
 Mon, 05 Oct 2026 23:55:03 -0700 (PDT)
X-Received: by 2002:a05:6102:510f:b0:7bd:b263:14c8 with SMTP id
 ada2fe7eead31-7c245cd99b1mr2427421137.30.1791269703136; 
 Mon, 05 Oct 2026 23:55:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e303fabsm52162651fa.21.2026.10.05.23.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:55:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Joonhoe Kim <26rote@gmail.com>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: round up the compressed INTF width
Date: Tue,  6 Oct 2026 09:55:00 +0300
Message-ID: <179126968608.1110179.1395537655224906644.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004102758.84436-1-26rote@gmail.com>
References: <20261004102758.84436-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX0B5KHCZiK9mN
 OLfOTy2S0919eKX4EN2Pc9eP+0g8y+g3pszWviZBfYvNDo2b7CcMXNhuDyzoY80NB8kSyEyAc/G
 vLdgHZXxlHyon1gFsSmqphabIvxftzw=
X-Proofpoint-ORIG-GUID: pzhhdKfKyhseiX6ijg49UcNBO5Eu9rMG
X-Proofpoint-GUID: pzhhdKfKyhseiX6ijg49UcNBO5Eu9rMG
X-Authority-Analysis: v=2.4 cv=F4fC5ahN c=1 sm=1 tr=0 ts=6ac49b48 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=y2x8obCdhefAC7Ej7jcA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX3K7Fw5tl8UEx
 gh+hbMKeGuIIDFx5dE8iypisuhpk+aiKYH6REVbzq68uUlaMIho57P6Pqtc6rghBvreV46STecQ
 28UUbUlHLP1Cs225+UGbe1FhqEoiRWSLqh77juHYOTbXE7EJaMm21Bd6Cy6ka5ENS0z/knKwmbY
 0RInwEPm4pgPm/T72wP2vMnIVP/KQE6RBxr8luk6iZnEOihp9ZNHG9ht3439iIknSyfhr3CtvKF
 kwwm3kah0SfHEa8yiaUvzWxMAlMvpDFCzDZTc00uATNHR87ZL2d2tyONj/Kyvi01XGk1n9h2OBo
 FQwCy7d5icw2btVUvheqJsYmOtI/XGrE2NNm9NU0LCiSOVS51UmWKNMrlxRNCdX+DQiTLmkuZKl
 i6ZjtJlBMbhpm4GULvCu7Kq/qQthSeyrnpUptPDXIW/RE/ssGEXJzHZsMZthsI62NhV4hCNqJ1w
 5HStjmn7UJQS5KOs5iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060027
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

On Sun, 04 Oct 2026 19:27:58 +0900, Joonhoe Kim wrote:
> For DSI with DSC, drm_mode_to_intf_timing_params() scales the INTF
> active width by bpp / (3 * bits_per_component) and rounds down. The DSI
> host computes the same width with DIV_ROUND_UP, both for the pixel clock
> (dsi_adjust_pclk_for_compression()) and for the active width it programs
> (dsi_timing_setup(), from bytes per line). When the division is not
> exact the INTF line is one pclk shorter than the DSI line, and the DSI
> FIFO overflows.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: round up the compressed INTF width
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6b93e8b453fa

Best regards,
-- 
With best wishes
Dmitry


