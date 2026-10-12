Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE630CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D07F10EF44;
	Mon, 12 Oct 2026 08:44:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0ABB10EF44
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:44:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8cu6A955691
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y8ppqiJky8MVWsFGfbBMBrD30oFhk9S3lgnHFDVpbFg=; b=TI/f+71ocIV7xEfr
 Pz6XvHWCbtyXpQ6j9aTj95e0Obnxj9+0i3IHjeSyQFzOhBBj4HQ5PYvQwY30Ru/L
 aB2dlzbnkzkZFMG5Gq87f/EX4eC12TbD6y2msF06FhmEB2cuC6QnLD+oVZaWxxdd
 zOuW+71vcucC0RgQMsrL2o8anEpEhE+NbincLPbf8ZZTcZySjG9J6Y663YqQEtf5
 vBogQf8albLnUCLNm0RPou5kN3zTaHRHiakJqRfn3OAelU3MKsvgwpmsQu3lAGjj
 YiT7TPQSbvHf7Z9D+bPpyIw29IRlBcICGubmon8TkUGdvIUiuPZg0voQY3IBwiLQ
 u/DTgw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7kr0rn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:44:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so2440357a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791794654; x=1792399454;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y8ppqiJky8MVWsFGfbBMBrD30oFhk9S3lgnHFDVpbFg=;
 b=fsbnWNlIyZtMYKhZ0Z39vvN0IKi2cECXLkzV0AkWjJOmdGVRlV8COJQeZaH76xmDUi
 uFLDyHiERgpPLHlPl4UWvHRF41NxNHvYFs7z4xIfj9f3gcfaLSQDW0n5naJ/GOsCN+xi
 KBQb4rcMObJqK9ab4o5PGleaSVDyFc8P6PMYMEwmdy2X8jBBtyxB9L6weXMKlkqkVOzi
 aAbnxE32+zg5UHRUIMhdadZMW21EmD8KRHh05N0+d0wbPvOih1FOTU+xePO8h9Dq3kYj
 ri19FUjt5wZd/lg6Sp1itYjSnFZpqnt15NPphNt+P3MGnlY+X+IFD0AWCv0vC0QCkbUv
 y6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791794654; x=1792399454;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y8ppqiJky8MVWsFGfbBMBrD30oFhk9S3lgnHFDVpbFg=;
 b=hrMMLVZECsBmNk71Kw9mhsCNzJOrOB+nk9seo7smnNBr6IDz1pAWSbOoZ8a9zzsgfp
 nrEoEJOBjXO4XPDzmag5tjPvVF+70/P6nJ6rt8zQdw8Ao8VyXfsCVgBsh1yKx2wBXMC9
 ql5MmHQ4IPLVkIJ3JCD/j7Mzj2SBmhagU2QB49vbwciWcFbk/BF7kKhDbittqEUa93Na
 ibtv+5B/slvAdEG9CK6+XDeXGcYCTR2bW/R44YgggyeO4H1WAADp9tAh3A3nf1BPjRbz
 Qgx4DGr+htG4QLCbZxBmIDOUrCJn3oOG7bLd8OU+Ms7ou79qThjdegQm3koNGLffQDq9
 wRMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJsOUWLseETOXYDlCgE1mp5K/W3X4nkwPWDsv5i5Ap7XrgvRQzOII300NBWexPECmRv12Zs7jzEvE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLLAxDezL2vKLaupbE+YdEAk7rzON4a/SVsangEMBfeIkJdqTGg
 v2vfZU4bZjeamwBPYappW3Ps1zfJgZCGOfpbFYgSroaveSEAzYw0lnNRqLzE9iLD/nWOwXBWVJq
 OBNHF3z9+PLXpqyM1mkPiSL6mcV6jqjjsj8Vloz3dvAf9ZWfYcaKIqPAJaVoZsPNqmecTqsw=
X-Gm-Gg: AYBFou0W5fEZOrrVn4EdrQ83ShqIh5HbExP5KxDDdOiWHHwOGdEmvv1RNlIKxOocqxH
 kAuh7exvdLU57TDmkPzhZ23t/y0OZt8JUZwgEqY4X+ay9t7t118xuIwBdO50je2t2j2CYej+a2o
 bK0E1UxGSIW/Coo/o9CGyOuPtBDRsBhvNH3Hy0+cwMxfi+2r5+URK187qr2FfVWxXraAmTWKDkq
 ynzg8kodAnBWmyUzfTfezGXctvZ80f7SGJ/ngPJFrFmZylJb1rJ7sxTQFBFjV69KB6PZqnJZI66
 8vIYbO9Xym11f/ZO8vZDyVPtuKGsxJG5If6xXFeCkq06qyjDtVvnaViQ5z+EDn9JR1hTKLLMaqm
 lBj1xVFCkSsAUeKpZi4biNRnz6pBZTk1RIcY25tIVKZqrziWYcn+fuqQp6lbmyyoFLfohMw==
X-Received: by 2002:a17:90b:4d86:b0:3a6:d8e0:c359 with SMTP id
 98e67ed59e1d1-3ab3a2fe039mr7006572a91.2.1791794653599; 
 Mon, 12 Oct 2026 01:44:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4d86:b0:3a6:d8e0:c359 with SMTP id
 98e67ed59e1d1-3ab3a2fe039mr7006544a91.2.1791794653066; 
 Mon, 12 Oct 2026 01:44:13 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3abe588fa31sm5195536a91.14.2026.10.12.01.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 01:44:12 -0700 (PDT)
Message-ID: <3c28f89e-8b49-4937-b4c8-66da180a5706@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 16:44:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/35] drm/msm/dp: add support to send ACT packets for
 MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
 <aolbmfnrk6qkfifib6bmhslaro5z2734ydfip4mnn3go4efpsy@2d4m6nnh7ogv>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <aolbmfnrk6qkfifib6bmhslaro5z2734ydfip4mnn3go4efpsy@2d4m6nnh7ogv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX10FL31HiyCf2
 q51Y58QLCifS7Y2r4lutihhb4ul7yTuiGICfh1kRpL0ih+UmxwMhOB9R8D5WLWoprWWjqCZOV2U
 ComuFM5fZHAjTsXKGcUK1MYzMJBLwgFnjDoars9uVr9DufFo6oMisCIBLMDW45gtn4m0j3VX7Y8
 zID0+A3v06cyrSGqPmRSewV4B+5P3sP9UlSYVB2oBpNd6yAFhdHlRTPfds9qOJi7oNft8AEB1L2
 eK3F/euRW5ZhcPT2zEvu0npTRDokcgVRrEl9urByf+bvq9ZWZe281Q1HGkrirC/MFCZU3b+dsOH
 CabIGypClAhp1YHlWaOXnnPESeW+j/d5eYIh/NrcBLKbMrwYg1iUIEs5dfVEjlzWnsiXOUNNHIz
 1B9VvJQIccbJUyqz8j4MCHPUDRlWUsbsE5W8+XLfQqq3UeFxlFtWlqCbl9aODTbn00oysegLcOI
 h4TERc1gBr8e6azJilA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX1LBkDiuKAB1y
 ba6UNDfuj/10+vgpuM9IqwGTSVcLUmF5/iZLLivvbN9IfOV/onkxKdMyeCKhcue6OJqmEOKHT+p
 j2XJ5SsCgIFHXPPfuZZ/ZRBoQz0cZu0=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acc9dde cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=G1Bnig19-K7uSukdqRAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3lLA0eithVguL5R-GaNNm5Eu6XqocH65
X-Proofpoint-ORIG-GUID: 3lLA0eithVguL5R-GaNNm5Eu6XqocH65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120034
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



On 10/1/2026 6:32 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 29, 2026 at 12:25:32PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Whenever virtual channel slot allocation changes, the DP
>> source must send the action control trigger sequence to notify
>> the sink about the same. This would be applicable during the
>> start and stop of the pixel stream. Add the infrastructure
>> to be able to send ACT packets for the DP controller when
>> operating in MST mode.
>>
>> Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
>>   5 files changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index e1614bc49a7c..65d22505c2b6 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>>   	bool core_clks_on;
>>   	bool link_clks_on;
>>   	bool stream_clks_on[DP_STREAM_MAX];
>> +	bool mst_active;
> 
> I really don't like the idea of having this flag in two locations. Here
> and in the msm_dp_display_private. Can we have it in one place only?
> 
These two fields are intended to represent different states with 
different lifetimes.

msm_dp::mst_active tracks whether the DP connection has an active MST 
session. The controller field records whether the current 
controller/link is operating in MST mode and remains valid until the 
link is shut down.

I agree that using mst_active for both fields makes them look like 
duplicated state. I propose renaming the controller field to mst_mode 
while keeping the display-side field as mst_active.

Would you agree with this change?
>>   };
>>   
> 
> [...]
> 
>>   
>>   static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 83117e7619f3..472429d09200 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -19,6 +19,7 @@ struct msm_dp {
>>   	struct drm_bridge *bridge;
>>   	bool audio_enabled;
>>   	bool power_on;
>> +	bool mst_active;
>>   	unsigned int connector_type;
>>   	bool is_edp;
>>   
> 

