Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38441C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8820F10EC3D;
	Wed, 26 Aug 2026 07:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWltw3kN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPZMTvrL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEE910EC3D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RusM122870
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S0XsFRYzKpYHY56wQV41jHqVJYDkSElvSQdFTSDDPBQ=; b=FWltw3kNKLHZMZ4X
 L9DWqNwFEunZ+Cqoal0VdxlemRCJfXre07Eq0TYh/CFEsffOeh/2fH1QHTWHfTdc
 cmN1mRWpRxVTrczd4A+mLwdyuyPh2Z7VcvF0Tur6/8l1ASuUFvjwbJFkY284WI7u
 v5kwaz2d/zEXHTd2M1ovRzltgOtdbN5gkvdV3gscaXNEYMdaIzdcjmIkh3JoQhKV
 LInFZc7syDAuG/6HbSDh8seaSOULqMnR6VGOMf2ELb2znoWwEGILJ5bVC61emVyd
 2PR06bi4fC6m9NXMTzj0ElZVwcPh+iMzzN667wQwLK6DKmHCivd49K9X0qBm1OSw
 OvomVw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mtjrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:49:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84e4ef9a74aso1373293b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730554; x=1788335354;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S0XsFRYzKpYHY56wQV41jHqVJYDkSElvSQdFTSDDPBQ=;
 b=JPZMTvrLzRvC/jpEE61WWMvCsmuiZCNHsrtoajL7DnLj8kfU6QLvW5cdYYaOwv8j3w
 DcR04c7IVjBQKdVjlcdZkEtecZvHxie4RNaX6g9EnmUSHaBeLPrLO+ggu70bHXn9yY6J
 IPdYPs8E5c+hlQjs4s9C24K3t/wunn1OiHLwtBJK6E6/REbaTVphltTAApdnG14MtjZ+
 74KmG4T9k3fJD8JV46LCe2qLRZnL90rltU1Jb7F02u0QUpKh03oupKu53Se7oYRuN/OK
 JKi1GFZT/ceLHQvtrUIM4CCyY5zs2K8RoINRxJQXF5iteaTVvbiHsVsMVGo8FtcK8wHD
 w51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730554; x=1788335354;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S0XsFRYzKpYHY56wQV41jHqVJYDkSElvSQdFTSDDPBQ=;
 b=XdoxFnHvyQSIi15ZJiEphI0rKMLVZkArUJO3uR6YilukjZZ8ZFvyMaFtiuFkItSe6X
 4IUC2XvlCfiHm/WgBpYc+A+fenYIamFuIvpQJno6RF+J5iqlDswHDWX28PR3b549gJFN
 1HML8ZvPXGiQvL77mbIGWhxoquI0HG+ebywUZLh14lwPrjqaTtcTBRBLSW8Yp+kiAVp1
 ePToAkLRNX3awOgnC7lrL0Uuny4yMptYpsjfnmjAV+elfiIlXu6m/qatCV+eI9enPUaz
 lkDg40JYhK4lEGvcN/1zL/I0hS+5rvn3H89a7/0wUE9FKds28Jy8bU6KIp4BYIT/hVtM
 mmiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHJwzTldeT5RsVnYk1dzY6XHmZzHX4ot3DuVKn5P34sYlvyIbmKxQ4pekgDiIbA4780lEWeD7px/Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPX66d4319ko+t31NnL7IKwD/81r4ehg5HEHHvifOhyWgO1pMu
 ooxaVSt6zqLBXHI5JK89Slz7P9xTIHtj985Ek4wecJfY6fd4OzAPp/Ya8x3fG5PuK3rgyJtKN7h
 eH/IkZWqo32NV9v8vaijHanH2k+pW1KWmYxP+ppX5j+QzmOBis+pGvj11p0YuhtYfdHzooVM=
X-Gm-Gg: AR+sD12pHq6NnQ2F2VpxINaDpUKZLrR+CrPhaIOZ2faO9Ga41KvU3sKNzpE/H/67844
 3s7UOlWbdhtHD6KBvyMFsq3appqyKJ9wz9uCA6x7CvsxxFtfKrM1depKEOY7E3CNSbzgvvRVD+n
 lWZV1oelBIpSXcnJHbojbnkwFgGdJ8HCJgedF0dTWXWHFFU8MQMXmMy3mOMn/KAZeGW9mp/1ff2
 V3Oh6cpagLo04E5pdzCFWHCBbV3WdpBcSWkfdOXjHkqgw+3e0b9kJBrNqRV1HBn2RWV0mWr2sTY
 vrVtBRKobh2Txqo/Wh2+YEXrIiaNkQE8GHZPOsSQ/CaIXN+yEFFZYMiccEBqflCXnmSFXGKO/ER
 Y3dU5f5vuDSb2DE9EivFPwg5492jWTgOvGp9WWUPLV//IDPg8onwKzbarhHOrwXXdztGMTPbw
X-Received: by 2002:a05:6a00:2342:b0:851:c2a6:172f with SMTP id
 d2e1a72fcca58-85373bb5653mr9072549b3a.7.1787730553726; 
 Wed, 26 Aug 2026 00:49:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:2342:b0:851:c2a6:172f with SMTP id
 d2e1a72fcca58-85373bb5653mr9072431b3a.7.1787730553215; 
 Wed, 26 Aug 2026 00:49:13 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cd8a41esm588474b3a.29.2026.08.26.00.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:49:12 -0700 (PDT)
Message-ID: <4b15dc5d-d9ff-45b9-b46e-e36319ff0570@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:49:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 17/25] drm/msm/dp: add link_ready to manage
 link-level operations
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-17-2ed6aee1867a@oss.qualcomm.com>
 <2ciespht5pfxvqnrik4a26drkmow2ilvxbkcnpt43jprhndryq@vfetl33dz3yg>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <2ciespht5pfxvqnrik4a26drkmow2ilvxbkcnpt43jprhndryq@vfetl33dz3yg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX2jZJ6RPyJl2O
 o0C0XUTI9n/sDDxLu9LA5RQJ1xq9jnb3t3KPOUR6XDIg9sjEtSzlPr6Os++s0A/WQuqExMXofel
 Zza1XPT71dRDgMIb75vUrlG4wYS+SzY=
X-Proofpoint-ORIG-GUID: AGhWUNUnNy0VpOB-AG8z7jMG_JPpc27_
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8e9a7a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=e8pokjpGc4Y85sSXAHsA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfXysKIkUMzS/Db
 ow3LPFAUFXJAM1FBOyf8GbH0rgnwbIFjWTbXulsgsh8WuN5B7qYgEBKbKcU+pGMI9YEpaOCWite
 JXeG7yoHlHetAlwDVySSStPKZA26oVOGIA/sKI5w9QlUIDdL5VFHm1ZJFiyJatOOcy2FalE4U1j
 FtOjOy4N/JwhVMDtGxHO3r1wVLnjxz6hfC1M2p38eLn851eor6dFMVtjuEsXWdBFd789vj/NcP1
 1YJaxMs0q4IT4CP22pNrGDEvzMSrsrk6W5M09aVYnlbxzxNtOdRcOH9So1n4iIg10s36J9o0L/t
 mmPzd18HAED3ranSJBuG+b2VLg9AXHObSnws1p0DhJS05xalbhB880AVPSiO5NYFgqe1UKxpeG+
 VUyI/m+ZBs4gU7eGCi0Q6ayVJr/wOz5LNbfBVlAwwsHmf57fa6GSZrvvOpHWk8isNHvnAWxBDke
 JobvW9MiZYu863BWfxA==
X-Proofpoint-GUID: AGhWUNUnNy0VpOB-AG8z7jMG_JPpc27_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260063
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



On 7/13/2026 7:46 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:38PM +0800, Yongxing Mou wrote:
>> In MST mode, multiple streams share the same DP link. Track a link_ready
>> state so msm_dp_display_prepare_link() runs only once per link and
>> repeated calls are skipped.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   2 files changed, 29 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 2a74302bcb7c..d56ee10ee065 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -702,6 +702,9 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
>>   	if (msm_dp_display->is_edp)
>>   		msm_dp_hpd_plug_handle(dp);
>>   
>> +	if (msm_dp_display->link_ready)
>> +		return 0;
>> +
> 
> What kind of locking is protecting this variable? What prevents it from
> being accessed concurrently?
> 
In MST, the entire function is protected by mst_lock, so concurrent 
access to this variable is serialized.
>>   	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
>>   	if (rc) {
>>   		DRM_ERROR("failed to pm_runtime_resume\n");
>> @@ -714,14 +717,18 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
>>   	if (!msm_dp_display->active_stream_cnt) {
>>   		msm_dp_display_host_phy_init(dp);
>>   		force_link_train = true;
>> +
>> +		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
>> +		if (rc)
>> +			DRM_ERROR("Failed link training (rc=%d)\n", rc);
>> +		// TODO: schedule drm_connector_set_link_status_property()
>>   	}
>>   
>> -	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
>> -	if (rc)
>> -		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>> -	// TODO: schedule drm_connector_set_link_status_property()
> 
> Why is it being moved now rather than in the patch where
> active_stream_cnt was introduced?
> 
Got it. will move to that part
>> +	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
>> +	if (!rc)
>> +		msm_dp_display->link_ready = true;
>>   
>> -	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
>> +	return rc;
>>   }
>>   
>>   static int msm_dp_display_enable(struct msm_dp_display_private *dp,
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 676213a48089..0464f8941e8d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -22,6 +22,7 @@ struct msm_dp {
>>   	bool mst_active;
>>   	unsigned int connector_type;
>>   	bool is_edp;
>> +	bool link_ready;
> 
> Please group the status variables together.
> 
Got it.
>>   
>>   	struct msm_dp_audio *msm_dp_audio;
>>   	bool psr_supported;
>>
>> -- 
>> 2.43.0
>>
> 

