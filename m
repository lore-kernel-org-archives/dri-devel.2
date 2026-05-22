Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E2CCD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 07:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21EB810F4EA;
	Fri, 22 May 2026 07:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nuPUmRr3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B31ek6g7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A995B10F4EA
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:58:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M2qqP83673883
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kxBZMjXWfEDezTxhg4NXRbYWC2H2xYO8KsQ+Odv+Xpo=; b=nuPUmRr3EY5asGTb
 lm33cvgGHMoqefeW+ED9j2GIonpRmQSfAB1mFs3S+0j13/xQ0zZTeyHq0CR4Hf+T
 ZmJPCHrY3W7SV4H15GIDOcJqbq3jJOxWes79HqcgZ3dnDQnGNFB1YItcUc7ffiGl
 PGri1GJqDyQlheewdPUQ0ObvAOl5sJA4R3fBBf5zBjffCodkWBROe4CG3XVsCgAI
 k+CEYCryoFJqAS7p3npIxxsZZgK3Brc4AV6hM9q9lmRyskw3KdaV2ha35U8jFM6q
 fWqKv65+x1RaMGBQAiN/yGhsy8NIK/jpR5LQGa03CC/0ILjXEAexRhhXi9+wa1F/
 5QaiLQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea4dc3j70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:58:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso129963685ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779436693; x=1780041493;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxBZMjXWfEDezTxhg4NXRbYWC2H2xYO8KsQ+Odv+Xpo=;
 b=B31ek6g7DK217nJgSHASWOyokshWTsFNH69NT6ROSumaFDTYJjEoicYtQ8/5uctNE2
 jj58f/eA81GaoagKGsqRKb/nTSlEVKg5lJn+OetVfSQwf+5uaBiuyoOirEl8bQZ4wleB
 1Ry8kVBkmzoEOW2ZZnbYaLwm/q4WzVb4jXzuFgZqZMu40arTKXO44abvVsUWrM9YLI4C
 f1piuf7ahfQFAqEb74ZbJGAVat8oxaG1PI491YeMfWwZ/zxtwuckFJKPRXGWsBFwuOIJ
 pF4uEhSzDdggMvc2XxNc/R1mGbbSVFlbII3iv9SVVRQEwM8CZghAtObZ8TOFt3cVFgJ5
 ESBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779436693; x=1780041493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxBZMjXWfEDezTxhg4NXRbYWC2H2xYO8KsQ+Odv+Xpo=;
 b=THGVL/j7vn02BzXWC/MD7j08XSoZoFIHd0DOwG1S4XrTDRRntJQp3iOkZo0am3tmc2
 Gt0I3HybchFwuRLI7JDTppZ2m9pQmVkIlliTcGvQti2YD+GyolpHOA1AOP8ZqlgBK+Ty
 4M5f/AfGmofUzXJEvam6Pdkp78/eH2N81sEagOpuEw+oLEDZGNjZaQx6SQ+uc9JTVw4U
 lsJAZVc/ZfzlQSgB7mXIkhX0UaUZ28hSzEPNLPbQnAj4mpzTKGMiqJ7dLhwVocHn4K9v
 Vqnfip0HU+6yHqq8yrYaWPiVoeZMytHaS0sIozu+GZCFeBzge7xL/pg1iiubidMWZMM2
 NiDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ta8bexQ6GmehgJiYziYEfFahXBdwOO7OpizJFfVzQ8GLx54BuAp1qwsCALCguDk+FmVbvxd3233k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNybbK83TuZjEfMQn6zZ7Fo3BUa5Cu+5QjUOX8SLtk5auzNY1M
 h66mhJUxJAF/l9ADPhJcoDRZXCZAWVcZiZ+Zez+CoID5l/KipjGMidRRg59KkyUwwfl0kW9umYk
 92tfAVKMphIAgGyp3/FsHq70YPELdlbHE8/kQBA7Hg95mDyd8rzHPCPUP28qa6U6VVsOQGdI=
X-Gm-Gg: Acq92OFPSYcwo+2ASiE090jAf+nG3LMSMD/ln0/FKeM4BnzVc8azHCnpT7EboWZM4nQ
 YOK1ROVNQ5DZ/BXK8AAAV8q3CsaohqIhRCrW4mJH/vSH66L8vcs89juOBRPS2u+LJm7RFQdRol5
 xxOn4MkI/MpMC3nqqkXBTMQpQ8+Lp2IofKIADmSPl7GIYEMwqPzGBZ/cseuPpzHGjw98Q6S1i83
 ZvPWIaMRgNTzdDqqTdo9DULCnBzDRu4UfOnkqTo9laWE8zMZlCj9AZJ8MMJMlnUTG3M/3fpnPAV
 L7kHUfRROS/9t52u9DdHBuwF5vtGFSI8LrLSoRbydtEj1kxe1GjImjd3pSBUEKJsYevDw2mQuiH
 gmbpI1DjVnITURQAUwGMC8tAtlJesDj6LgTBrBSqkUSw5NdnP177Ccm9L9JRukXWePv6XrjG26I
 3nYvrz/dunUuiMPo+BJfB+ETfP/2Wr
X-Received: by 2002:a17:903:2c04:b0:2b2:549f:7d2b with SMTP id
 d9443c01a7336-2beb0596f55mr27972625ad.11.1779436693302; 
 Fri, 22 May 2026 00:58:13 -0700 (PDT)
X-Received: by 2002:a17:903:2c04:b0:2b2:549f:7d2b with SMTP id
 d9443c01a7336-2beb0596f55mr27972335ad.11.1779436692784; 
 Fri, 22 May 2026 00:58:12 -0700 (PDT)
Received: from [10.133.33.148] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56958d3sm7780935ad.12.2026.05.22.00.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 00:58:12 -0700 (PDT)
Message-ID: <33ab5c3f-5a6d-4d81-b310-760ac519bfd1@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:58:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/39] drm/msm/dp: introduce max_streams for DP
 controller MST support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-14-b20518dea8de@oss.qualcomm.com>
 <s32w4u44y4jhuk4c4qxsytat2pdiskzuvbozklhofpjh54r7pc@2i6vvbaen2ur>
 <0e39dd9f-9858-49cb-a052-7d0791b694af@oss.qualcomm.com>
 <p3jfi2cxevvdtqathqrpnxdkzrwuna3hojovfjvdni7zvjec24@pyvaubeq77qk>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <p3jfi2cxevvdtqathqrpnxdkzrwuna3hojovfjvdni7zvjec24@pyvaubeq77qk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a100c96 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=tbUuAszfmx72r74QhgEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1AhJCVj3zTWeQxb8loQ9R41_AyBpPBB_
X-Proofpoint-ORIG-GUID: 1AhJCVj3zTWeQxb8loQ9R41_AyBpPBB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3OCBTYWx0ZWRfX7UmPD47vyIOI
 p92q5aJ+8ji+5n5eig6pBncJK4SdEInCpcH0B9sZgTu306S9lux6c801UxIvOcbf6TaLZhjTG5T
 ujQbv21o1RaW3uccz/v6mdFLAgUA3JFTQdHLj49VvvlPbnGa4oTS/TkQVcbCqIoXqc6k+LJVPZ2
 A5G/BWv/P5TtyDsPUubcz6Gps9rTxSGshv1Ocqlml2OuDie099vM6SWZfzE9lKRgGoaZESdwxkW
 5HXgiguR0/r+Cb6u9ESXRRXx/9omK81klejmP8GEOL40D5y1+dnhxHuTvd+/Q64pEnMiPl3Fqwg
 6CPWNN0VOxlrjRp+pA1/qQ+rvKM43P8mkbetrZiVe9bHBtpzipEsW2IIX6OPppTX1m1kM2/tpZu
 kixB/IEYgmhOYj2drlEsq6CYW4ea7JmM/U5h4wiNRNCsk7ZwInXbndQxT98zKQAsQ2F+wxk1iJl
 DbN8B1w3PVfJYUU4QOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220078
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



On 5/21/2026 8:07 PM, Dmitry Baryshkov wrote:
> On Thu, May 21, 2026 at 07:34:32PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 1:59 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:49PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> @@ -2740,7 +2741,8 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>>>>    	if (rc)
>>>>    		return rc;
>>>> -	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
>>>> +	ctrl->num_pixel_clks = 0;
>>>> +	for (i = DP_STREAM_0; i < max_stream; i++) {
>>>
>>> Why? I think the code was fine with getting up to DP_STREAM_MAX clocks.
>> Sure.. will change max_stream -> DP_STREAM_MAX next version.
>>> In fact, I'd rather use that instead of the hardcoded value for
>>> determining how many streams can be there. Think of the old DTs which
>>> didn't have extra stream clocks. We still need to support those.
>>>
>> The current logic only assigns num streams to dp->max_stream when
>> desc->mst_streams == num_pixel_clks, otherwise set to 1 which mean sst.
>> I would like to introduce a switch in the driver to control the number of
>> streams, rather than having it fully determined by the DTs.
> 
> Why?
> 
1. In some scenarios, even if the hardware supports up to 4-stream MST, 
we may not want to enable all streams (e.g., LeMans: 2xDSI + 4xMST + 
2xMST, but it only has a 6-layer mixer).
2. Currently, the DTs for all platforms have already been merged, and 
for some legacy platforms, not sure if all platforms MST will work.

If my understanding is incorrect, please feel free to correct me. Thanks.
>> Do you think it would be acceptable to use:
>> dp->max_stream = min(num_pixel_clks, desc->mst_streams)?
> 
> We know that num_pixel_clks <= desc->mst_streams. Otherwise DT is wrong
> and should not have been comitted. So, the min(a,b) has a known return
> value of num_pixel_clks.
> 
>>
>>>>    		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
>>>>    		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
> 

