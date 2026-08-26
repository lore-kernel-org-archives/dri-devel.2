Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C3BC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C4510EC2D;
	Wed, 26 Aug 2026 07:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkX0GdGJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JX5+msXD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8AC10EC2A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RcGL3794487
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sCVVlm64g9ttdUSzI+YrZMU8ZmRwF/FCIwqoHT7K4tk=; b=NkX0GdGJj+0XNxVL
 2WkX1NQRcYRtbs9JD/a/aNi3dgkasD1zZTYZbSVoyyYsyfSpULnd/gjRJ+O15Ral
 rsY8ZVbKiisVFqtzjAR+QU9y48AKVX4aZtyx6y8j312fLckHKfdtBDUJVTp6cQp7
 oRAwSrvbHzL8b7g3l4gSHT8H+jmP0lAFipikHLAWETo1s+rD44xDbL71OIXQ6pYL
 P0/gR1PwO2jf3LiBMukCae+a2bYoGOKTNLKC3XLfmAl6QMIJ9zZPRpSy/uBmHYCD
 Ig6T21dPz5uhYvqRkc5LB6kdqVokJJ8iR1J2ubMnK+YzjR+Osd9Ntv6shjNLFqZF
 tF3/XA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx8na0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:48:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so2141184a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787730513; x=1788335313;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sCVVlm64g9ttdUSzI+YrZMU8ZmRwF/FCIwqoHT7K4tk=;
 b=JX5+msXDIxQE+r/ShFIdm3U891DCsIQQRf79NPOyORK9R2GQB+zYjSmlFblQny8ArK
 P50U4yb8SSdIq/K+J4UyQqDJQ4sigwPgvNisGYSSFF7rJUkb+kbOCCxYzSn5qI/4enMs
 GgLwBkgjysN/Ote3DvUh3R3QipeMG9HY6u+/LQALHWjmmvTTaqJnnm+lqMVyNBCWE9pD
 Sye8/9bZR3Dt4DvXCP3qAkOPpiSDGkCha4AXH+G1XYRMATOhsT+8Hp4iwBvQivTT3YyS
 Y5dUZ2KiMxY6xExOhB/etorcxJlPCpdCQYYu3Vj2iG1G3VZBZaTq0HrZximKTrEFbow6
 qp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730513; x=1788335313;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sCVVlm64g9ttdUSzI+YrZMU8ZmRwF/FCIwqoHT7K4tk=;
 b=qsD2zg3DOXMKHpnlD7cunQhTXWHHWXce2GAZth1m3jUs2nCEaDMQmUjTN7tvV3s6d0
 vmuadE9qdYYpqQp0vlJ+YseknEjOa0+rsb4sND1IytL90jlWnwzHxUgJ/SfCOiqK0dE5
 /XqO1mC3qY/WO34gfXqz4QbNJhXCxP6xI8tCiVa4RK3PXcH0aM3NiAuiZvGfTOrz9jLy
 Lb8iRMxR6ij4ufuOGImxHulB9S5p6mc7Pn9J9xsSQtYS15Siwfp9TMT0DEGbNEsTuhVr
 nEOhXVdjS3+1O/IwH18Y5qKXk97o34zRfRX7dUx8OtYgLOyPKELt833jRG3xWQkH8V0n
 2CZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rps0sdc8rqEKAwW4N1x+VBSpWy2aX+Ba7vVHw7X6NKUYBd0mK3ixjr6CRRJ/IL5WdFcmJfC+4l/jqc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kZD8fOB7wbq+G/oz0p5O/eKqkkJcZsUmhYale0khZCn1NfBunN
 uf867PeK+NigpcwqSvzvO4nTacN/yLSPwB3SPzQXi47lo8wFSkCrzeORr6rTPVzOJ4MdMttegti
 fsrt0Cy5Y0vuaexy6d9tinH7pO7kdOZtqk4DQ3B9weIDx6+Cp0mmKc98hwq74pT9GK/GZf2E=
X-Gm-Gg: AR+sD10KElNZvz2rEee8TXjlrIWiCqjHIzeE+htFyePEwq0LTYrVzisPwj1P7Ltkyjr
 PZTsEsmGxnk21xD2FY4bdgsMb88vkYAbjoEuqlMXLy7p1HRHMOYG276/U8AjVqRHRMULt1+SmA4
 4L7jAnjx+uMDC1oEwTcbFR3oE4aIckY5JrZh4JwD9VYWAK3uHrtb6QqfD48BnOZ4o/rWBR20pxC
 5sFPTwOorSjIoWT76bXU4ZqGJmLfv9sfLWs3DB3XQr1GsnXPI5oaNlkcsNwxs8IhNSkY+Q73Jll
 XMcxW7lsQPFZEl6Q4HziNEPG5YIG/kzItUJPsLil20PyCW8dLRW0L1atInt54csM1jyf/uhdv78
 x23eO7AXv6nIBX+ujbV7gBdb+pkfGbJEFdO0h16ONpYunKqCSQw1Xk+fO0qw910PsZZNDzUAU
X-Received: by 2002:a17:90b:4b8b:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-3966d402835mr10357186a91.7.1787730512557; 
 Wed, 26 Aug 2026 00:48:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4b8b:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-3966d402835mr10357118a91.7.1787730512146; 
 Wed, 26 Aug 2026 00:48:32 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5832bsm3060969a91.15.2026.08.26.00.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:48:31 -0700 (PDT)
Message-ID: <56ccfd0f-fad1-4d88-8398-71ac6f09a4e2@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:48:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 02/25] drm/msm/dp: introduce max_streams for DP
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
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-2-2ed6aee1867a@oss.qualcomm.com>
 <anxxmx4qfdil4chif37e2xzk3juuvpnqdoc5mg3jcbdkoaa5rg@obruztrgljpp>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <anxxmx4qfdil4chif37e2xzk3juuvpnqdoc5mg3jcbdkoaa5rg@obruztrgljpp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8e9a51 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kAGuYKAZhE7RxPx42BAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JCKfV7P5miCVXuVXuSyJCft23oebmD9i
X-Proofpoint-ORIG-GUID: JCKfV7P5miCVXuVXuSyJCft23oebmD9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX5JWJ3Ee+L55c
 /r5v3/76bO1dT2eDoUvXWn8JqXgb5u41JduYaQXHbFv6r1AU4gDPBZ0nR2Cs99O4LV7Ft9/yZ/Q
 wfUbvI5TvZt+iyi0cNGtgLycvHMEfT6NhVAX+XR3U3HC1gizTzm9Z8dXfBee0UNRSlgIaJEvEr0
 8EnH23JUcm0Y7vu1vXUP0vahlhwxB/pOpNLmxwrrJoBSY6zOPGwRaBOp5EZVat1LIIp3E0+8eoo
 xKYdfvpXuUM+xhiY/xv5GBAN4IThlopPmRFY1+Lq2WigxEPeId7mhA4+FmTIMAtXXXIXduOLf7M
 edgBAlVBjeSZ8veYJpxRTVUK/pu3iBUDGvz3/FxbXNhH/NWHK7N+JFokuDQvB4VPKRmOHOpbMpq
 4pkLwVHyAlXWFjcCB9vQGg6SJYiLEZqgEJbYhxcMIEssRVgizLlPYjKRnIMikpFzqekj+UpN47r
 OnK5iJXg8sIg00Mei4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MyBTYWx0ZWRfX3gh87FqsIhGP
 eqp0Q8klxTJO53P2xE96BtyjryS9S5kKoBhkmoezUXa+cnvjDTJyPGRbeDO0MFQD8utfaHk0JhH
 lL5hdx0KrFRLHmiVahZfHjSTdonUwtw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260063
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



On 7/12/2026 7:17 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:23PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> DP controllers across different SoCs vary in the number of concurrent
>> MST streams they can support. Rather than hardcoding per-platform
>> values, the number of available pixel clocks in DT serves as a natural
>> indicator since each stream requires a dedicated pixel clock.
>>
>> Introduce max_stream to capture this at initialization time and expose
>> it for the MST module to use during setup.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 13 +++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
>>   drivers/gpu/drm/msm/dp/dp_display.c | 12 ++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   4 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index a475e787656e..68fb4facb056 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -127,6 +127,7 @@ struct msm_dp_ctrl_private {
>>   	struct clk_bulk_data *link_clks;
>>   
>>   	struct clk *pixel_clk[DP_STREAM_MAX];
>> +	unsigned int num_pixel_clks;
> 
> Squash num_pixel_clks to the previous patch.
> 
Got it.
>>   
>>   	union phy_configure_opts phy_opts;
>>   
>> @@ -2754,6 +2755,7 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	if (rc)
>>   		return rc;
>>   
>> +	ctrl->num_pixel_clks = 0;
>>   	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
>>   		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
>>   
>> @@ -2766,11 +2768,22 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>>   			DRM_DEBUG_DP("stream %d pixel clock not found", i);
>>   			break;
>>   		}
>> +
>> +		ctrl->num_pixel_clks++;
>>   	}
>>   
>>   	return 0;
>>   }
>>   
>> +int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *msm_dp_ctrl)
>> +{
>> +	struct msm_dp_ctrl_private *ctrl;
>> +
>> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>> +
>> +	return ctrl->num_pixel_clks;
>> +}
>> +
>>   struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
>>   			struct drm_dp_aux *aux,
>>   			struct phy *phy,
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index be0d89d60914..305add3dcd93 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -55,4 +55,5 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>>   void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>>   
>>   void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
>> +int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
>>   #endif /* _DP_CTRL_H_ */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index bb243ab09e66..9cd243411e44 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -87,6 +87,8 @@ struct msm_dp_display_private {
>>   
>>   	void __iomem *p0_base;
>>   	size_t p0_len;
>> +
>> +	int max_stream;
>>   };
>>   
>>   struct msm_dp_desc {
>> @@ -578,6 +580,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>>   		dp->ctrl = NULL;
>>   		goto error_link;
>>   	}
>> +	dp->max_stream = msm_dp_ctrl_get_stream_cnt(dp->ctrl);
>>   
>>   	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->link_base);
>>   	if (IS_ERR(dp->audio)) {
>> @@ -1178,6 +1181,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>>   	return 0;
>>   }
>>   
>> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
>> +{
>> +	struct msm_dp_display_private *dp;
>> +
>> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>> +
>> +	return dp->max_stream;
> 
> Anything stopping the driver from returning
> msm_dp_ctrl_get_stream_cnt(dp->ctrl) here? Why do we need to cache it?
> 
Got it. Will move it next patchset.
>> +}
>> +
>>   static int msm_dp_display_probe(struct platform_device *pdev)
>>   {
>>   	int rc = 0;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 43ed79093e24..d3d4ab98089d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -26,6 +26,7 @@ struct msm_dp {
>>   	bool psr_supported;
>>   };
>>   
>> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
>>   int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
>>   bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
>>   int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
>>
>> -- 
>> 2.43.0
>>
> 

