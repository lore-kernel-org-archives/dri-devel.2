Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C026DD3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC7D10E06E;
	Wed,  1 Apr 2026 07:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NPcE9R+s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+EQEj3w";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C836B10E2DA
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:29:37 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6312U9Km719069
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qbS9+v2BBjG7zRi/OvSLkU/Ie2NFTC6i8v/tksgC6LY=; b=NPcE9R+sxT492Isa
 i5OQBCTbMTtO9lcB1zpvrVxBSX0P+f8FmzR0VjMiYhZTpwmS2pkjsq9Ue9systaC
 q6v2BAWitGZDIYjEbvx+hHVBK5jNCNm4z7A3PkN56LUmGbiODLSDXNdc49rzMf2n
 XJnaai8imJcrkEQg6Qst0M5I92ot7pLI+PoC4+cL2hY3kIN3cT0Iwuq5AEK2HEnt
 qZ+j68auShAi7HHvBihu8ZZzzAmviRU4tduhKUKilO3sj1wvXBq4hfS5B4o1PK/n
 oxOs1lIeetNdTo97b2qZTsETtWB6FKsEMEYL9WDMfWyR9+O0Uv3rIdve2BWdUPXK
 sKfgDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcsttgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:29:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso197053421cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028576; x=1775633376;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qbS9+v2BBjG7zRi/OvSLkU/Ie2NFTC6i8v/tksgC6LY=;
 b=O+EQEj3wG7bNQjCcvpHBteFaWTMd+tNer4IhOzyf5s7X1M3MIjFvS1JRaZ15lj7IkA
 sI8alqY+vWK2MmiEc+VFUJxmgE4hbJfSxeeVw6pzOHHpgmiuphPlLGvRwRb64HqUT3L2
 s0NHaucaT8e7SCfe3t2D7b82UTygsxoopztMeWKUm9awNkQV/xyHsLFXpVNYmdveltHc
 Dx2IbmmTrW1xOXYtkjFG91HvstllHRNq1yE32fUdR+9dlgkgh8C3GK6fIDOkGOwzfF4q
 Kx0j+Z0A8OSmrOqQ2+pBA/mVn4UpbaCTmAcahPoxdUHfSIhjEDpoCGyv0fqPh4+pEwx0
 4upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028576; x=1775633376;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qbS9+v2BBjG7zRi/OvSLkU/Ie2NFTC6i8v/tksgC6LY=;
 b=L13u09JfGjBKlXhAxt6Tc/aUsJp+oyloF5xscuU4WVRW3851a/lJTUgHMlMroJ+xku
 O5i9WEHLA85waoZVd4n4mMkj1yKvJy0qBPakH+AIbyoOeh+yTVLhNVgwxGbzKBCjL6PB
 fjwXUHw/l2XykPEIaLnX7i7LZKXpA+FsG87FEDtcintxvx3OykJ4WXelvY9FeVXAYjtx
 AcWC2hzMenuDma3i5KXspL9t8RwQK4QmnTa2NcCyj5RIT9y7kPupQ6CpYLZV9eFaSsI8
 fZ1i0VpuzzTA+MJ8jCfab7pBd68KmzAiOWWH7Ash0JKo9nf6e8GPSMwn1as7vrPyeqkG
 BtUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT3SNFwKYaAROZgFSF8ejy7XazmhTkYBtDMo/C92vTShoE4L+50U3weCJK8FdIngtdeRaN36n5/fo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvbedGFGXrFmZWKeoO4HEWQU8rxZLOgv6rbA6aptfzByEL9s70
 hgp6kUztDJy31uuXSY0yeHsFFS0bA8AIhvMOMlqusK+VBrnkpmiyjPzoZoAKazbLa5K1rTeDsSk
 zpupaen64jOZTEMbW977zJGESZKyWkEnfcUYYAGpizPRcQYDqoPz1V0LqOy5VcxLzvCBCd30=
X-Gm-Gg: ATEYQzxgSjHsFTa5EDxpWzU+o+tc0dxVaHE6BExkeKimVyhUl+JZPZv9i7UX7k63kD0
 Y7EHDVXGqTd6MT8hdxJgDkwiegK8HuTIXUp+KUbbgySjEv3l9eM3r8Gjl9FMk1xZ6YcE/iMTq5Q
 ar6brujDsuXO2R5mzOnDkEmW5vYN3+44WXE04OhXubGVXdBteVQOpRuUGubhNtbuJzDhy8uiafU
 DTO98KjNJhIT9UOw3oEg6L5C24ln5LiukgdaQQ95IGwSdCRZeyvPDUql4MsZ1B6wIZsnldrumwN
 A3b1AHfFk9QEso6WIfFUMJEm2+mBhWwGI6tYrQ3dW+nKPBN9xltJt8y0N8dkTnWu/w+fshikjp0
 5BfKhyqhUQUItLW0j7sI67yhk/Axw/KwNNILq50taA5mnpVF9p5Ba4KuLygXhRIq7GEJZNPBifh
 /DU6Uip4ts94189gyT48Ty1Xsm
X-Received: by 2002:a05:622a:259a:b0:509:379b:d4e with SMTP id
 d75a77b69052e-50d3bcd2630mr38914991cf.32.1775028576212; 
 Wed, 01 Apr 2026 00:29:36 -0700 (PDT)
X-Received: by 2002:a05:622a:259a:b0:509:379b:d4e with SMTP id
 d75a77b69052e-50d3bcd2630mr38914671cf.32.1775028575723; 
 Wed, 01 Apr 2026 00:29:35 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a073:af00::4c9?
 (2001-14ba-a073-af00--4c9.rev.dnainternet.fi. [2001:14ba:a073:af00::4c9])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c3d32cd0sm388804e87.8.2026.04.01.00.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 00:29:34 -0700 (PDT)
Message-ID: <0009a801-8f58-487c-b5c6-5b264393ef25@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 10:29:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/38] drm/msm/dp: add dp_mst_drm to manage DP MST
 bridge operations
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-28-01faacfcdedd@oss.qualcomm.com>
 <h22zh2zcgdcv2k3mxc5rslpfd3xnerjfailehtaw3wbtpnisy3@s56vudwvoh4q>
 <cdb5b1e6-baaf-41e8-9133-6889b5e686f6@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <cdb5b1e6-baaf-41e8-9133-6889b5e686f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX/QSCIET0Gxwm
 9XqaCXdCUmPwseD6eBUbL5wxRd0kRqw/AFt8hww42NbDnU+mOLr7qpViYkLsW3LSe79e/fivrFZ
 5BYXTnisiKyVj/eew9M7yL6U0CvaMOEbz9OK50tRpytKqRRareoPdEFJF7xORUi9puQ4OdcULQw
 y4SIVlS34f5EYGh9wXhsqoBMdOLpQnUqIFotHVj41IzZfiHZJsET+adQc/EbYSbfupj2gUHugf8
 qX8rcYHu5z8DxSTpn1C7huTH2MNfF6mBL+fDB50QjzOPzpIOfqG1QrT8ZJT8A6yI4B0YPkP9dC9
 W5K+iyYwB07Txn4728rxEl9CimjdJb9d39kODM7thkMgOT2spWrFHMdWdfWeDFjSPllKSh2S3ws
 XNl3sH0qCqonCIMsKkfF9lLd5PRHDijQqLTiQ/QcVHdYjrIU/nybus6L0TvyUJVR9kNZwFSQUv6
 sa0vlcGvhSzOO7xhhng==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69ccc960 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=nlcTEVPeAIpjwhky54wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sJKEGwYFdNOg9gwidSL4HJAyqEILED7t
X-Proofpoint-GUID: sJKEGwYFdNOg9gwidSL4HJAyqEILED7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010064
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

On 01/04/2026 10:07, Yongxing Mou wrote:
> 
> 
> On 8/27/2025 1:36 AM, Dmitry Baryshkov wrote:
>> On Mon, Aug 25, 2025 at 10:16:14PM +0800, Yongxing Mou wrote:
>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>
>>> Add a new file dp_mst_drm to manage the DP MST bridge operations
>>> similar to the dp_drm file which manages the SST bridge operations.
>>> Each MST encoder creates one bridge and each bridge is bound to its
>>> own dp_panel abstraction to manage the operations of its pipeline.
>>>
>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>> ---
>>>   drivers/gpu/drm/msm/Makefile        |   3 +-
>>>   drivers/gpu/drm/msm/dp/dp_display.h |   3 +
>>>   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 556 +++++++++++++++++++++++++ 
>>> +++++++++++
>>>   drivers/gpu/drm/msm/dp/dp_mst_drm.h |  86 ++++++
>>>   4 files changed, 647 insertions(+), 1 deletion(-)
>>>

>>> +
>>> +struct msm_dp_mst_bridge {
>>> +    struct drm_bridge base;
>>> +    struct drm_private_obj obj;
>>> +    u32 id;
>>> +
>>> +    bool in_use;
>>
>> What does it mean? In use currently for one of outputs?
>>
>>> +
>>> +    struct msm_dp *display;
>>> +    struct drm_encoder *encoder;
>>> +
>>> +    struct drm_connector *connector;
>>
>> Why do you have connector both as a part of the bridge and bridge state?
>>
>> Please describe design decisions in the commit mesage or as comments.
>>
> Emm. i go through the msm_dp_mst_bridge_state and msm_dp_mst_bridge.. 
> Can we just drop msm_dp_mst_bridge_state? just track connector and 
> anything else on bridge.

If something is being handled by atomic helpers or being computed by 
atomic_check() for later use, it should be a state. If not, it can be a 
part of the single bridge struct. The most obvious mistake is to set 
globals or object data in atomic_check().

>>> +    struct msm_dp_panel *msm_dp_panel;
>>> +};
>>> +
>>> +struct msm_dp_mst_bridge_state {
>>> +    struct drm_private_state base;
>>> +    struct drm_connector *connector;
>>> +    struct msm_dp_panel *msm_dp_panel;
>>> +
>>> +    int vcpi;
>>> +    int pbn;
>>> +    int num_slots;
>>> +    int start_slot;
>>
>> I'd definitely prefer to have payload pointer here, if that's also a
>> part of the state.
>>
>>> +};
>>> +
>>> +struct msm_dp_mst {
>>> +    struct drm_dp_mst_topology_mgr mst_mgr;
>>> +    struct msm_dp_mst_bridge *mst_bridge[DP_STREAM_MAX];
>>> +    struct msm_dp *msm_dp;
>>> +    u32 max_streams;
>>> +    struct mutex mst_lock;
>>> +};
>>> +
>>> +struct msm_dp_mst_connector {
>>> +    struct drm_connector connector;
>>> +    struct drm_dp_mst_port *mst_port;
>>> +    struct msm_dp *msm_dp;
>>> +    struct msm_dp_panel *dp_panel;
>>> +};
>>> +
>>> +int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder 
>>> *encoder);
>>> +
>>> +#endif /* _DP_MST_DRM_H_ */
>>>
>>> -- 
>>> 2.34.1
>>>
>>
> 


-- 
With best wishes
Dmitry
