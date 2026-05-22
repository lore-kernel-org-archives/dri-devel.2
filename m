Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5408CD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 07:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EFC10F4DB;
	Fri, 22 May 2026 07:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oc0WJNdn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="enOivVOl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166DB10E10F
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:52:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M76H871297965
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /+kkrFn/2fpFebovjxuNtM7tsPmleNa8yjdb4r0+/EY=; b=oc0WJNdnU8tNCcgY
 eclAJMR9Rcte+e0KYLcpxlyxqLODoz3Bk+Tv1MObz+gOW+FwLfQ8xsuWJLYJrwCJ
 uKsR0sayClC+iqHM8CA8ntWJFDqr3FHZ5fCntYXspM2NEcE8ACRbY3x6xYxbf73h
 yH6kBDSMlA2yvd02DSWGLTNnknclkniLnj4u7frKEHfcEI8FDW2H7UymFLIdvkCD
 YQ97OJHHvhK39ekNe8lBz4U6CV8kIEKMSKpt6CYm47jgL7zslMkn+ltLuFUgRzVM
 a4exMTITGQ0VtkSxq3i9/VMkn+xNzvo8U0j8hgWPMbQo7DRQFgzF78uUlUlUtnyH
 F/2Uxg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah09r2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:52:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b9fe2d6793so162201895ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779436325; x=1780041125;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/+kkrFn/2fpFebovjxuNtM7tsPmleNa8yjdb4r0+/EY=;
 b=enOivVOl91m7GIzgKV9d8dIzT41tE1GuH/t7fYT81NwvaUG8cWPZWwvDaExqxQ6fig
 UtABJGqgtWhohToKZqmx4RuSCAsFNnCj6AJpRvuHwVfTNCnvpnEyaNnVkTfamp5RRqZe
 1pZzl+xVeotH5LfjuEMx6KKksMd/ngDUmbjxQvs4VVHiSsPLVhYsP+KBYRqmOMU6XCCZ
 Vymnr7HHNRl1AGcoOCM9UrEXx9L6Sel1bsygtsenbKW07J5SO1kswBq+wVSrp9n++mKu
 ZZhcWD9VaW3G7Z/MaIW0D6i+r111IXbTbXfbAQcYkpPYTrrqt0rEmkEKaBD5Gvb5bbtZ
 pizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779436325; x=1780041125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/+kkrFn/2fpFebovjxuNtM7tsPmleNa8yjdb4r0+/EY=;
 b=RjcznGBghiRzH4TwhQwodgyqtyANR67vZy0iq7IycyVtR6LqtQ76lyAGJScRSRa65G
 0E+/oQZqCITi3GfXCFoHAM6Kq+sCtDuXGeZCxdRtUqXDGmQSu7mqz4wnS0yfVJ9p4/SO
 0Yi5MzELxtDWtt8PdHK2FukdiLVhmXNSm1WoO7ONtD4yNL6ug1wqZry/VX/X2R2SBFLd
 x16R9xBFszEBnHD1TxrgGbPFplAtWvbLZKJ76oa/AN/N/t7z25F62utKizUHtXA7mZrp
 4zxmnaWwExvBcaC29VugAQL2vwzNpGp/XC17J7AEfTyG+JeSv+9zLubgq9+tZz2/URC3
 2rnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1gowFX0Xh1/y4nf5E+xNuEQvUqhFq5KRdygdSFLxymk9MzHlGuddFizRWyDzp7vP/RSCWxZf1JU4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxF/Npcgnn8vx7jHNgp+MaYNRoRqIUFhFTDxyWEykOk8aebQpoa
 IbbJ8EviAm47QMda2RS+cEs1VQmA+GiUuERl8W70L/lnxVXGu93b3OiUpNYBAbeH6Fh6chKFVY7
 F58p5YPuu3+tlYxyikUCkD5C2LybjEpssHmjbqp5rKusDO9SJShSUZOAAYYgeVeCNNniRubM=
X-Gm-Gg: Acq92OFWcEms935mz7qXE8Fyo75B3aCcwubbJ8RG7WrB2EJSOT+ZFHqLGkYjHgXCYsy
 kFzgYdkTheiwtFvl6xT1MQ0TqwIoXB8BxXix6lg+jS4jCacsoyrXIWOQy7hZUE9zrUdCMXmF4pg
 p2wZM0TU7HzMFYKmdAiuamfIcc8vPNvp0i0lm75JVQB16kr50eAJLfJD34LbV6+KWFkqGRB7Un5
 P0ph+fHw9aGb3xB2USycGVg9g7FhDiHrgp4Kxz0bAWGKbh/csz1x8wKyGv2bRXJJjENRxoH2g8y
 OCR4+BbDKA8WhA9KyoMg0RWqapDqmmXw9S/jDFJ3CfO/L3UCqHd5xpDUNk83A6uNYz8a1JE04ZQ
 oM2VMfBNS3g456ZOJ1gkokQ+fjqN9vFefYRjlqT+RpuQuG19VbgM+C1O6tIzO/9yVB7utczWMHr
 kiximaNtADb4u2O4PAHA==
X-Received: by 2002:a17:903:1a07:b0:2b0:52b7:e82 with SMTP id
 d9443c01a7336-2beb0699574mr29375265ad.16.1779436325245; 
 Fri, 22 May 2026 00:52:05 -0700 (PDT)
X-Received: by 2002:a17:903:1a07:b0:2b0:52b7:e82 with SMTP id
 d9443c01a7336-2beb0699574mr29374925ad.16.1779436324731; 
 Fri, 22 May 2026 00:52:04 -0700 (PDT)
Received: from [10.133.33.148] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b303bsm9592715ad.38.2026.05.22.00.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 00:52:04 -0700 (PDT)
Message-ID: <083fc602-7549-4abe-a11e-51dae9fd0c8f@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:51:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/39] drm/msm/dp: Add support for programming p1/p2/p3
 register blocks
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
 <20260410-msm-dp-mst-v4-15-b20518dea8de@oss.qualcomm.com>
 <zputabw52nsba4ddwg7gd22tyouobkmlpq6blos7w3kx457otx@gitmjwroo7ou>
 <55081f4d-f1a9-42c7-a1cd-cdcefc008668@oss.qualcomm.com>
 <qslmbwi3xwdlc5fac4yjbxf5neckmiuy74en2wiccv3gos65ey@twcgc5wrayrh>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <qslmbwi3xwdlc5fac4yjbxf5neckmiuy74en2wiccv3gos65ey@twcgc5wrayrh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3NyBTYWx0ZWRfX0RQrzQBQR8nc
 tKkkSpkkG84u450Zn4MwdJI/Dw/p7OyIKphTdb9d43PupeSQRaWY5Erzl12iKGIeDo8ICwAfRtn
 l5z+HMWE4+5dSQDZYdrsoebQyLWr7ZdENszoMAdPmfbgB57H50D+1IzDpr0I01+BVggQqWn41eT
 T/uTNCvydrWZ8fF5gquUrNo0TDXYrWxDwx+MffJiuUxdK4hB3+F/HvqelA9SBiHquFRdT1ZYC94
 kq/ktmQwf/Id6KuKQfKeK8oAL6h+WteQY9xueSPJKB2uLB5W5iguQDlerG5KtFwpAk4+TfkmV2n
 Fj/o2jXdLU4itIer1ehILEcXbX0vhXMwmadPV1YrcMO6CkrlLJD++UbMaThubINBoTCas4d0liX
 D9dtOLSHx4Y7YiYuf+b4r6ew++rEkqKUW2QR/jffO7l/GAVTukVES1pMnW+XX3KmeMbHC+TKCAs
 RRsKd/k28UbYY1i6ARg==
X-Proofpoint-GUID: Y_AKbsgwK_P7ZWGjRZS_CFGnod-HvZIG
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a100b26 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6TMII061o9s9I29nBW0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Y_AKbsgwK_P7ZWGjRZS_CFGnod-HvZIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220077
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



On 5/21/2026 8:20 PM, Dmitry Baryshkov wrote:
> On Thu, May 21, 2026 at 07:50:30PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 2:07 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:50PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Add support for additional pixel register blocks (p1, p2, p3) to enable
>>>> 4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
>>>> and msm_dp_write_pn for pixel register programming. All pixel clocks
>>>> share the same register layout but use different base addresses.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 40 ++++++++++++-----
>>>>    drivers/gpu/drm/msm/dp/dp_panel.c   | 89 ++++++++++++++++++++-----------------
>>>>    drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +-
>>>>    3 files changed, 79 insertions(+), 53 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index 7984a0f9e938..ff506064a3fa 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -85,8 +85,8 @@ struct msm_dp_display_private {
>>>>    	void __iomem *link_base;
>>>>    	size_t link_len;
>>>> -	void __iomem *p0_base;
>>>> -	size_t p0_len;
>>>> +	void __iomem *pixel_base[DP_STREAM_MAX];
>>>> +	size_t pixel_len;
>>>>    	int max_stream;
>>>>    };
>>>> @@ -561,7 +561,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>>>>    		goto error_link;
>>>>    	}
>>>> -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
>>>> +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
>>>>    	if (IS_ERR(dp->panel)) {
>>>>    		rc = PTR_ERR(dp->panel);
>>>>    		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
>>>> @@ -769,6 +769,7 @@ int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
>>>>    	}
>>>>    	panel->stream_id = stream_id;
>>>> +	msm_dp_panel_set_pixel_base(panel, dp->pixel_base[stream_id]);
>>>
>>> Hmmm.... Would it be better to set it up differently? Allocate one panel
>>> per the stream from the beginning and then simply get the first
>>> available panel when required? This would require some minimal resource
>>> manager, but then we won't have to pass dummy register base to the panel
>>> code. Or actually allocate a panel when it is required? Do we need a
>>> panel before atomic_enable()?
>>>
>> In this series, panel come with MST connectors, Because the connectors are
>> dynamically assigned, we don’t know which connector corresponds to which
>> stream, so there stream_id and pixel base address are dynamic.
> 
> I read this as 'streams are dynamically assigned'. Connectors are fixed
> and created for each branch point / real physical connector. Streams are
> assigned on the first-serve bases.
> 
Thanks for pointing that out — your statement here is accurate.
>> we have 2 optionals here:
> 
> What is the runtime requirement for the panels? Are they required for
> parsing of the resources or only for the setup of the actual screen?
> 
> If we have 5 monitors connected to a single DP controller (via the
> complicated topology), how many msm_dp_panel instances do we need to
> handle the case, present it to the user and still let it select only 4
> of them for the video output?
> 
It seems that if we move the link-related resources from the panel into 
dp_link,
struct msm_dp_panel {
	/* dpcd raw data */
	u8 dpcd[DP_RECEIVER_CAP_SIZE];
	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
	struct msm_dp_link_info link_info;
...
}
  we would only need to assign the panel during atomic_enable / 
atomic_disable.
This way, in the scenario you described, only the final four panels 
would be exposed to the user.
In the current implementation, the panel contains link-related 
information that is required during the link training phase.
>> 1.panel come with encoder (after bridge remvoed), like that:
>> struct msm_dp_mst_encoder {
>> 	struct drm_encoder *enc;
>> 	int stream_id;
>> 	struct msm_dp_panel *dp_panel;
>> };
> 
> This sounds like a good idea. This way there is no additional resource
> management, etc.
> 
>> 2. During enable and disable, allocate and release dynamically.
>> would you prefer which one?
>>>>    	return rc;
>>>>    }
> 

