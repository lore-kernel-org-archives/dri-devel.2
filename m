Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19E5C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D03510E2C7;
	Fri, 21 Aug 2026 09:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZy9BAPH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bOU05aG5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1A310E2C7
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:27:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MJfW1551014
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +BDrUQKgKdHEQVLENw0WmZLwq0k67Ge3cu3zKv0ARXc=; b=BZy9BAPHjLbDvU3m
 Qxav+Kvj4Oqxj1Wr70S+yX/kwZx9EMHN73YaIzfQGYBQsZd+HpU4GX94NlMvWhgi
 HiW0FX03Kk196Rq2F4Iv2ftfFsGDWg5fn3asLtgzX4AZHShTQJkOOjpJcQ0nQW71
 v9TsMDkGuYB7s6aSl+doRtlJXQrf6schKQzdEWnnxgMYBib2fBXSH4TaVlEzoHSu
 L7/ihDsPyD8kNjnULYpKXXgunu/UfGOTeWc1MFLU0dBlji4E15ZbJQt4Yyid3YDw
 X6cHykb1iEWglfRY+P8VdXmsPnVgM3r2F1VFBfMPDTT8cjgJTS6lujLXvdGOZRpa
 GiMuqA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6d069hn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:27:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so1821269a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 02:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787304441; x=1787909241;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+BDrUQKgKdHEQVLENw0WmZLwq0k67Ge3cu3zKv0ARXc=;
 b=bOU05aG5Ma2sq7un2mPn7OktCNGW3Gwi4eylvGdOYArsXrGmfYkaIiGtrVAzNp/Jwm
 Envzl/eb35NFJgwxgzEtZUHE/v0M1UR8nyx65zDJLDdGYjgUJsU4/VMAaozCZVqSdMTk
 DNVH6hUQLlSNOiLCvH44ZniO2L4AkxmCualQuYuzD9sITFHS6fxT6//h6qj2MgxS/uBT
 uvYIMylqQbDuF6UrGXsE4SMqUdPE/iEt5HrXrko0Vm65hbba3D2weel9iawvfQvCpdrS
 OTOmh/tfUCEZZtjXYV0YB7b+FxH6LDrZwqJXXHLc2yweay0SnjUbSuJMwEor7qWalWtr
 8PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787304441; x=1787909241;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+BDrUQKgKdHEQVLENw0WmZLwq0k67Ge3cu3zKv0ARXc=;
 b=bm6BdVWwA3xJW0GIcXYOPiYAf+RB9GL5kwGuwwFBX4xRqfM3pUT08hI+R1ek+dc2Ot
 yO00pFfH25x8EjYDhgizKAZ1pNZgh/yVOCv+XrdfRbsaZKCMxR+6ThfxuwYPnVzD4zBT
 5kU2HfAkI0HlcwwuXFEeVu7+zNnbPenCYicJHpxSC+IqzZQ5r7zhI4V+xmvgswZnsyXY
 Nj0WyEpNAF+VltbLrjrkzDT/An10z8v2Z59aYz8aawLVKjEPNbpM6h81xNonho9axs4Z
 WqE02rkupWNdQkKi6fwedgltfTVLST3SVGZP1++E09uFn4qQy7oq3s2t4OeI8LfB7deA
 DNUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpX78qZ2sE/euKzvkHN6HZDHFd1I8lR3loBZ0aOFTCkdHIAoi1e33OLBWlZdogNMfPN+MU2Isp6cnY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++keDhJ3xqw9JnfhdV9KNoUzvd5v5fEyqCf8SUujYi/8tosK9Wug
 K52cA7CGjVic0dhLDf+NSipuKNpwwZiX9KPTcWgZ5CekGbqQbkINodHfbWxHqMUwt3Xfo8jK11e
 UySx73JlC5CeLPktQ+Fhn8rL//7yEpd03tXOrW8VRe/ovke+VUsVB6nd4b/Qu1RZHA4H0Cdg=
X-Gm-Gg: AR+sD12eaUKGp3IuQO2C10AWE8KELl2/YYHt8QY8Acts2mfRdG6waLBKSE22p1XXEEm
 S7R7w46MF26jv5oFHX/1EHq0Xdu2r0J8a339NbkZK18YuwcTbkCMyy8lvpkMzL33oQ7JhY3VlDi
 k48sHl3K6Cd9EFKs3RV5OzmJXAMDNVxqsOsnY0jhn1XMqpS9dyZhpadGaXWr+s1ayMtFe7ed7yF
 PJFxnZrqgoe52xUC2h/X9QeGqZUOumSmffJ5AbGb6IRXMHaKgmj1VkBhdaofxv6akH5rpGfhE74
 DW5L3d3tuKFISJLsKF8JWCQ0oa4CtC8Zw5Ns9TdtNxDokUke89FL2JdmXgZNN31BmZHsbLu1+iO
 NVSKOPE6+6h7K9ZjAHvQrquKBqLE0jZ0bC8GZnPx7EqKEDuIpDd6unSJnO3JCHLXGXm8e7wY=
X-Received: by 2002:a17:90b:1c03:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-395c3a017d9mr8566283a91.12.1787304440613; 
 Fri, 21 Aug 2026 02:27:20 -0700 (PDT)
X-Received: by 2002:a17:90b:1c03:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-395c3a017d9mr8566185a91.12.1787304440127; 
 Fri, 21 Aug 2026 02:27:20 -0700 (PDT)
Received: from [10.133.33.40] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4be44fdsm2509958a91.12.2026.08.21.02.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 02:27:19 -0700 (PDT)
Message-ID: <ddbb42cf-ca4c-45ef-94f1-d7c8c7bb53a6@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 17:27:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 03/25] drm/msm/dp: Add support for programming
 p1/p2/p3 register blocks
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
 <20260629-msm-dp-mst-v5-3-2ed6aee1867a@oss.qualcomm.com>
 <fvbqltre4qqdf3ss6huv3wz2exd6lin46pykp7ualvr6att4og@4ti6htrtcnlm>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <fvbqltre4qqdf3ss6huv3wz2exd6lin46pykp7ualvr6att4og@4ti6htrtcnlm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2OSBTYWx0ZWRfX+57rOieS+xju
 AaXedmXafImKYAKQyQJ85uo5ntAgPblIRxQQXCIrzOtljbhETxa88U7G5BpEdZxrfWaqM7PAhxb
 j7KJVPNzSUYKfQxrFjhxcCx+O6fby7WjCvrIUet3sthKwmUdwNMlB5SJATMntorLUOUIkJZKy6W
 rE6pM+tMxjJ/6Sc6Ro9A4889yLKvmb2vvgJxAtVLvX9hhqz2XbLFMrfD3RUGSF02sRjERV62kVc
 JK2hwQjDhCAXZ08YXat1lj0TGFn/4UgQMncpdwAjj8lFN0wzPPxrBvD3LvZOBgu3ALaYjEGWW7p
 erdAzxxwMkC2CTqK78RU5X89j93FheiUKPjp8L7qm6iqe6q6wgWbLwAVOiDyhfI/zU7UXfq8rAT
 Mb6xnxvvekUx+hnzh8Ny5B3YJbd5U+hyWxtvuzoZmhw2pfXOaPzRPiT9qAwhZolbI+iCpyy4YfP
 sgMdSLifnYgbYH3Ssqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2OSBTYWx0ZWRfX+C7YG6BYkgja
 gtxL8boFTK84QfhxUYVzZR98H4nZGI0hNwFBZvxTsnI4NVav+qYTu9m9uWbZFZDommjv/8Eql8r
 wPdPeSl65gdX1BXOnTPxDtem0WowVt0=
X-Authority-Analysis: v=2.4 cv=DdQnbPtW c=1 sm=1 tr=0 ts=6a8819f9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kZxiwz9scTa994qyGCgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Ng6kSvX3XEfH9LVqQUqflQ8tSIrSuvL_
X-Proofpoint-GUID: Ng6kSvX3XEfH9LVqQUqflQ8tSIrSuvL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210069
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



On 7/12/2026 7:23 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:24PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add support for additional pixel register blocks (p1, p2, p3) to enable
>> 4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
>> and msm_dp_write_pn for pixel register programming. All pixel clocks
>> share the same register layout but use different base addresses.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 40 +++++++++++++-----
>>   drivers/gpu/drm/msm/dp/dp_panel.c   | 82 ++++++++++++++++++-------------------
>>   drivers/gpu/drm/msm/dp/dp_panel.h   |  2 +-
>>   3 files changed, 71 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 9cd243411e44..74f481a18164 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -85,8 +85,8 @@ struct msm_dp_display_private {
>>   	void __iomem *link_base;
>>   	size_t link_len;
>>   
>> -	void __iomem *p0_base;
>> -	size_t p0_len;
>> +	void __iomem *pixel_base[DP_STREAM_MAX];
>> +	size_t pixel_len;
>>   
>>   	int max_stream;
>>   };
>> @@ -564,7 +564,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>>   		goto error_link;
>>   	}
>>   
>> -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
>> +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
>>   	if (IS_ERR(dp->panel)) {
>>   		rc = PTR_ERR(dp->panel);
>>   		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
>> @@ -850,8 +850,14 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>>   				    msm_dp_display->aux_base, "dp_aux");
>>   	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
>>   				    msm_dp_display->link_base, "dp_link");
>> -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
>> -				    msm_dp_display->p0_base, "dp_p0");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[0], "dp_p0");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[1], "dp_p1");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[2], "dp_p2");
>> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
>> +				    msm_dp_display->pixel_base[3], "dp_p3");
> 
> It should be:
>    for int i = 0; i < DP_STREAM_MAX; i++)
> 
> Also, you've just added a NULL pointer exception in the crash handler.
> Check for the address being non-zero before adding it to the snapshots.
> 
Sure. here we should check NULL pointer and also check pixel_clk[i] 
status. Will fix it.
>>   }
>>   
>>   void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
>> @@ -1131,6 +1137,7 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
>>   static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   {
>>   	struct platform_device *pdev = display->msm_dp_display.pdev;
>> +	int i;
>>   
>>   	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
>>   	if (IS_ERR(display->ahb_base))
>> @@ -1160,8 +1167,8 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   		display->aux_len = DP_DEFAULT_AUX_SIZE;
>>   		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
>>   		display->link_len = DP_DEFAULT_LINK_SIZE;
>> -		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
>> -		display->p0_len = DP_DEFAULT_P0_SIZE;
>> +		display->pixel_base[0] = display->ahb_base + DP_DEFAULT_P0_OFFSET;
>> +		display->pixel_len = DP_DEFAULT_P0_SIZE;
>>   
>>   		return 0;
>>   	}
>> @@ -1172,10 +1179,21 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   		return PTR_ERR(display->link_base);
>>   	}
>>   
>> -	display->p0_base = msm_dp_ioremap(pdev, 3, &display->p0_len);
>> -	if (IS_ERR(display->p0_base)) {
>> -		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
>> -		return PTR_ERR(display->p0_base);
>> +	display->pixel_base[0] = msm_dp_ioremap(pdev, 3, &display->pixel_len);
>> +	if (IS_ERR(display->pixel_base[0])) {
>> +		DRM_ERROR("unable to remap p0 region: %pe\n", display->pixel_base[0]);
>> +		return PTR_ERR(display->pixel_base[0]);
>> +	}
>> +
>> +	for (i = DP_STREAM_1; i < DP_STREAM_MAX; i++) {
>> +		/* pixels clk reg index start from 3*/
>> +		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
>> +		if (IS_ERR(display->pixel_base[i])) {
>> +			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
>> +				     display->pixel_base[i]);
>> +			display->pixel_base[i] = NULL;
>> +			break;
> 
> Here we should differentiate between the address being not present in
> DT (which should be ignored) and any other errors.
> 
Thanks, got it.
>> +		}
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
>> index 745ee6976897..238920c45261 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>> @@ -25,7 +25,7 @@ struct msm_dp_panel_private {
>>   	struct drm_dp_aux *aux;
>>   	struct msm_dp_link *link;
>>   	void __iomem *link_base;
>> -	void __iomem *p0_base;
>> +	void __iomem *pixel_base;
>>   	bool panel_on;
>>   };
>>   
>> @@ -44,24 +44,24 @@ static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
>>   	writel(data, panel->link_base + offset);
>>   }
>>   
>> -static inline void msm_dp_write_p0(struct msm_dp_panel_private *panel,
>> -			       u32 offset, u32 data)
>> +static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
>> +				   u32 offset, u32 data)
>>   {
>>   	/*
>>   	 * To make sure interface reg writes happens before any other operation,
>>   	 * this function uses writel() instread of writel_relaxed()
>>   	 */
>> -	writel(data, panel->p0_base + offset);
>> +	writel(data, panel->pixel_base + offset);
>>   }
>>   
>> -static inline u32 msm_dp_read_p0(struct msm_dp_panel_private *panel,
>> -			       u32 offset)
>> +static inline u32 msm_dp_read_pn(struct msm_dp_panel_private *panel,
>> +				 u32 offset)
>>   {
>>   	/*
>>   	 * To make sure interface reg writes happens before any other operation,
>>   	 * this function uses writel() instread of writel_relaxed()
> 
> Hmm, so the comment talks about writel(_relaxed), but the code is readl.
> Is the comment wrong? Or is it not applcable and we should be using
> readl() here?
> 
The existing comments no longer match what the code is actually doing. 
We can fix them in this patch. How about this?
	/*
	 * Only reads a configuration register: no DMA or memory ordering is
	 * required, so readl_relaxed() is sufficient.
	 */
>>   	 */
>> -	return readl_relaxed(panel->p0_base + offset);
>> +	return readl_relaxed(panel->pixel_base + offset);
>>   }
>>   
> 

