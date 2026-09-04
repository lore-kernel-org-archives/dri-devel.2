Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA759C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1381910FA35;
	Fri,  4 Sep 2026 10:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMSz/7V8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g5/0xror";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB53210E543
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:22:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIeh53565748
 for <dri-devel@lists.freedesktop.org>; Fri, 4 Sep 2026 10:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=B0FOpfvbCJVV80luCOgEs+44
 HXQFGx6sTBdAdN/+wOs=; b=MMSz/7V8MUl+HbVOcwKAVYa5rgFnUAdeZKBQlfsB
 YIvSX4T2vv3PlhSX8DNsPiLHNIq4MV3Y/KzyUuBcpEZnh8jZQsUT4ExzM0R/+boH
 +dTmIRTNQ/obwGufhAVXQrPRvKpnoLi+5pfOPRojJoKMLdU5TfZC6BAdTBkdvJgs
 V7l8JUFo73HM2V5RSeO9J4ithQWvm8CO+KpKjQxfqrR4t4CI06HVyR9GEmVPmAwj
 7Ti8bt6+uT8lzMYy47t2XEu0JANI4l7gzbDSNTZMdnhP0Q6uZOXqZ/Kj8YqtOHWy
 ggQCjuQo8bBtOSPjpev6ykytMpY1AYPoXHmPUygH+CoVTw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r17wf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 10:22:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so111711585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788517343; x=1789122143;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B0FOpfvbCJVV80luCOgEs+44HXQFGx6sTBdAdN/+wOs=;
 b=g5/0xrortb7brFFRkNdQywW3TXsbgun4E+e7K3BJo/BYEx8VrESJ/gl0WrQAyzcpuX
 a+hwwk6FViYMqZs8hATAqMgouNDHyyoC9iYLt1gG5TbYEZlMGQSUvV7TVJ+z6c4Kp3bB
 Lay3WQV7Q/ohsL40KHOxmh6jI2zwG4Lp4r6FZ7EJV5OJT3wxcc0Ewiaqd6Ut01UrZz6G
 iLKbDbznoO5AscmI7WoVamevk//tJGUq2Yt5yCns5+IaTincwFFfY34c5tC3wZQfC+N5
 uPS4SRoNF1ZlN0fMM/hygucSHCL4mrbMzdiCp/4VeaSirOkjDMMdcoRE37WHdPj0GMS2
 EYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788517343; x=1789122143;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B0FOpfvbCJVV80luCOgEs+44HXQFGx6sTBdAdN/+wOs=;
 b=JPznj5Qibmi+eewNYu6FUhwvrTaO72RiwAhyyWA6lvNx4xKurfmFHgDsaii/ENxgtb
 WfB0udpmxHGawgeW+CdmYaFJy4AkerhVtx9nkDey+SPtPbff4dbx++Rj5qU12qtsz5gJ
 8Xbr4F7QUkToJ8lduLe/lNHVNN7ygyCR2HvlaNKlmrwDp0apui975rmGZrRJtDW2tM3u
 393UuDpkhGobXCL/me2ftGFoced8im/YQbdC2OqFIyiHVLkdGABvp3IKDbKSj8tu6/Mr
 yNjm2VGOTItimGvibv9zOzKsPerBuVEWuLCDTCSGZ9B5I614LeiP66qNN0Ak5xgizNaw
 1vQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJk1uvSfIdCZlgV1sX4eSJYj8UMscpY45Bk9D6+doba/lgI06VOdrbDp3TAlcb2pHtILZNZBmSbFk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mOSLTWUil4BY3m6VsNdEo/mQtImXChrP/fkFpJrDKLRrsTIvby
 6wzO9kHAD2w7u6KmgAALP3d5OXbFoFVEMJNwg3Ptu0B+H62BrsWHyl1ASUmLfVfgfC0CRx9gqay
 gggnbRsEw2fV3X3TlancmwvhNbl7QIkBoi76NTtsLdbs03qHbkkZ6JNUchsEOiklo7FJ4TEg=
X-Gm-Gg: AYBFou1KRsFUHV6Hs/1KG5+IOyrifhSBdF1xsoKCQKpHLrGiPHcytchAoBhMQii32A1
 DzpJQlQyeqmAriZQdC1COxdZpkqImNUlvPiE6ef8b11Gp9ddYwcPQExy0vyIgsdqXkfCMXZ3cbA
 c3Ry2oofFQG+RtgG3KKq2hf5AtOeH28jrCitEvywU+P60UsxsNyf4O8y/1PJdRjOae7+WG7eL7T
 vKJpetXui+HExoQvWRvh5SxiEVx/3b8bXCqSC0/FINnKzjypZvrIYlwjt1Tbtr9CGrnVAZBfIJ8
 PLSOUlzLP94BxSWpUKunydObXueyTtNP+fllvfcezP+FA0pmXQdIgRotle2GSUSUOoIcRlpA/zc
 j0fcBA9SHLEEx
X-Received: by 2002:a05:620a:6494:b0:939:7b8f:f244 with SMTP id
 af79cd13be357-93980379a06mr510424985a.14.1788517342683; 
 Fri, 04 Sep 2026 03:22:22 -0700 (PDT)
X-Received: by 2002:a05:620a:6494:b0:939:7b8f:f244 with SMTP id
 af79cd13be357-93980379a06mr510416985a.14.1788517341941; 
 Fri, 04 Sep 2026 03:22:21 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7710aa5sm59464915e9.7.2026.09.04.03.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:22:20 -0700 (PDT)
Date: Fri, 4 Sep 2026 13:22:18 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kavan Smith <kavansmith82@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] drm/msm/dsi: round the byte clock rate after reparenting
 to the PHY PLL
Message-ID: <2gqk2imrel3bwt3ezkccimixvfiioxp5eeiaznzlyejgkhmave@7eh5o6ms3rns>
References: <20260903-fix-eliza-dsi-v1-1-3474a6c9f2e0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-fix-eliza-dsi-v1-1-3474a6c9f2e0@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5NCBTYWx0ZWRfX58nAUAK8QzWh
 pYib0u470tru4eTBaipMFcs/iWiNx1Dvro//diFrRw2B4oJV6Ri0PwcXo6t8zB5ymAuVSecHQpc
 VveiUgLBBIUGzmuHjilcVrLImx8MZks=
X-Proofpoint-ORIG-GUID: S4yf-T1fJIHG9EW6maqKLetBU_SvtF9f
X-Proofpoint-GUID: S4yf-T1fJIHG9EW6maqKLetBU_SvtF9f
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a9bdf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=df3BZnECoes8ZJFSp-YA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5NCBTYWx0ZWRfX2S5IElh+Dk81
 7iJ8JfxF7Z9S8KqbtN6BCIAXfpGaskiRsk30aurqOL9CCVZ5THLepGShByjNl7pVJ8VOQwIfMWI
 I92vdEGq+TmtAjazaO0JQtPPklCsuT6Uyblb4nolUmcSqraSx8FC/AhI8KMuS+8l7OEwX9iqO5e
 g2lKFqTQvcO/avK5Y3ifqlGm4fxW6l6vhXf6/V8beghsBKv2w7Mm8EIUB62+m2LoygZGHGqEoi/
 qXCqc1GqqODbfA7okVcktYwG8ydGZWGTaAEBIrwkzlt/K7ndQoXIZ5/bpeFkIghik6oiWpfIKTQ
 VIlCMKN7Cv6qB8RRQrlH3+mUS7a56xnOWOseYfaKkJae2hENtdTY14qoPLItgiIV3hBfONECEWH
 3CnD+jxd/SgeWxBKEadUl3db53nairf55+o+0PaiirGsjPnFLtfYCSBaqPOvCzVvtE3WCKshz1J
 e0sSMcroNXNvc7WUBEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040094
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

On 26-09-03 15:19:10, Dmitry Baryshkov wrote:
> DSI 6G v2.9 hosts (SM8650, SM8750, Kaanapali, etc.) reparent the byte and
> pixel RCGs to the DSI PHY PLL at runtime from
> dsi_link_clk_set_rate_6g_v2_9(), after the PHY has been enabled. However
> dsi_calc_clk_rate_6g() runs earlier, in order to compute the bit clock
> request for the PHY. At that point the byte RCG still has its reset
> parent (XO), so clk_round_rate() returns a bogus rate, which then ends up
> in the PHY bit clock request and the PLL gets programmed to a wrong
> frequency, breaking the panel.
> 
> Move the rounding to dsi_link_clk_set_rate_6g(), which is called after
> the RCGs have been reparented to the PLL. Storing the rounded rate at
> this point still makes later link_clk_set_rate() calls no-ops in the
> CCF. Derive the byte interface clock rate from the rounded byte clock
> rate, otherwise it would keep requesting the idealized rate and
> retrigger the PLL on every transfer.
> 
> Reported-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Fixes: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested on Eliza MTP.

Tested-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
