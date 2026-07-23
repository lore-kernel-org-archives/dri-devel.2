Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7ADC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2928710E32D;
	Thu, 23 Jul 2026 06:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivHbvVVu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dTGYKb0R";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF82D10EF91
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:16:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6AUga3268911
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uztIw7Y/czAkNHoN3VaLJJ/uxyGxSAro/FyBZ0TR0YM=; b=ivHbvVVu63S/vnRj
 W8dmUU7rP8j2FmQk6kGYReehwJvkW3fV9aGu3w1rNKNKQidIuKVWTlg38c3f8xe4
 oJEmBDF1m2uxMcPvw/MVbWNv0kIqKDFrmMvS8WsrRyDLy28Dhphb0GNFfaacRZ+F
 bhgvbWvKZMDvR8+WVxD6zQh62IghWBMvTNqzGVNgkfRcUvXAesCeH16HpYTzFLqc
 /ICKKstXafXvLKPaQrstqrf4K9Nxk9W1v3UkP5qSyREW9s6iET7rv23wDuM750ow
 vVTBufpr7WmKy34osr6OyZM2DxUNDMwb3/u086gsAtCEnwnj1W4RMqibzqXlwwI4
 tqmYiQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayh8jnq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:16:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e8004d60eso49690685a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784787365; x=1785392165;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uztIw7Y/czAkNHoN3VaLJJ/uxyGxSAro/FyBZ0TR0YM=;
 b=dTGYKb0RmmDUMNEdn6AY3P+WeFGsqMbOfPI9AsVZNNtjAtoAXIZucD13IgvvipdXFC
 OVf4snSYV97hGKxs+MeCG5aZyLWNiEjvxyI/a/w8GSHX0y9UV0P9v20+/jRIz+xhM5BV
 5RlsQu1VxXag0jfYBk49/1Jr4Ofc4Xr1AQdLQqyrbsuU1jRBNdO+h2dP8IRdhQUlx/zB
 WXNOCObm6CuZvjdIbou/A5XYJBtcFcr/kog0qUX/SEIXFi1QCYMFAw05WA6zWcvbJSVb
 HOtjWg1vKEEBcbRPe19LX60nXy8jjq2qH0Ytpd6uG5U6ahPg3S3ifW41wAkZZO6Tay14
 IvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784787365; x=1785392165;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uztIw7Y/czAkNHoN3VaLJJ/uxyGxSAro/FyBZ0TR0YM=;
 b=qEkCXHBC3K2UC1/aNBawsx1Twmsw0DlCn8AIcJ4Y1H7pWgqG8548ShORDF3I/aFMrS
 i2PkjLnlJjWForPXfv2wNNKDGX8j2KZp+8PtV/TC08D68cr3C01Ddno1caJkkNinyRrx
 UN58jCoJergUnnjAl1ASmez9RmVM+fTHNlqr38obP7YDiw5Uj+xNB2NSbi6rrdijTi82
 P282igGGTCSfzdGH9vclnL2If3FHpY9hXKH+TFWkStfZZcFgvBmxw9VDn8Kvz4rBqYV2
 VPQxKrNHRBnnDHae9W5hHDlqsiupytE4VP9cfBUgfJQtTVH7ewbdioSHAFTtk40oow2Y
 PIeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbbIQGy7zY7C+1ADTJ4OLPjMUraitX+0U2IesJl4hOK9gFBcNX0XmU5eVW3S7fwSAToBy2tdC2anA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0BpgaukVsRB/DLU+HUFxFZk/s+m+VzGWJ0Z+Lk0/4svcFeQJa
 OkzTwZ06CpFc0CFGDCSlsZaSkdyOvPqq6SWQ4GFiE1cFdrYSBzYAxQ13ehdD7+vSdx/U/a5ziEF
 Tu+Too9m4L/aw3yayv5aYKgMSBuqNjhYyCcM3yqCerRvGe4FCeSe4+EPykT0kghbnZ6T6XHw=
X-Gm-Gg: AR+sD13Wz/q87Jn15x3P4JSV+yPM8+XaoP5pCaFeTgDE5BWuWjgSCdONp6EhmpxqGnI
 1xovt/+pXU/nUmY/BmW7cMtwX2WjCQnhZqRxisAm0HR1TBTPCvTQ1PrmtQuOFzf3NR7A0WqR63e
 v3CbGSFoCux+FKaYBc6LVS7g9c9k7nce6C+9vRRkSF1W+QJ4vOIpRsAaVLc+HO8jkKFFx0JgEEy
 xQiDYa6IBMfRVAwhn639nmQDowmB8NTurIELaKdmha8TR5scWTkScHaKBhwBTvoXWq1XXm6yleh
 g1fFBODiL8evO29oxhaBeagXEK1Y74vtEoXmE9AirikTpABLkriecfi1Ode8V3pE6z0Mg2qayAx
 Whydt39XTQksafepy+HqLFHQ9Ghlm0uxMydvgcl4KhkX9v7H7kYU53jJ2TSxp4YxaTg==
X-Received: by 2002:a05:620a:1707:b0:92e:f3ca:2ecd with SMTP id
 af79cd13be357-931038f08abmr175251985a.60.1784787365191; 
 Wed, 22 Jul 2026 23:16:05 -0700 (PDT)
X-Received: by 2002:a05:620a:1707:b0:92e:f3ca:2ecd with SMTP id
 af79cd13be357-931038f08abmr175250385a.60.1784787364665; 
 Wed, 22 Jul 2026 23:16:04 -0700 (PDT)
Received: from [10.111.173.228] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f6a0411dsm343863885a.22.2026.07.22.23.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 23:16:04 -0700 (PDT)
Message-ID: <0436a2a6-4a4a-4b5f-ad53-594781cdc914@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 14:16:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_enable
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-2-bea261bf4e7d@oss.qualcomm.com>
 <20260720063317.CFCFF1F000E9@smtp.kernel.org>
 <ldznbgwysgo4ya6h2s57wytjjhhljkfyiagrce4z2gvty5suye@bdc3gfzl7xff>
 <fccb4620-d5b2-4a49-b703-8725a863c540@oss.qualcomm.com>
 <i4h4amxstadjomfd6i5dkgtjdnre23ugewvlsffajfdelwmyfg@kpex2duwixxl>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <i4h4amxstadjomfd6i5dkgtjdnre23ugewvlsffajfdelwmyfg@kpex2duwixxl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a61b1a5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T-t0yevPL1h59vvOJvEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: UQfY_Yufj6jt1p44JLz4BgRQaWmE3dxn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2MCBTYWx0ZWRfX4b0kQg7RWnHu
 gKyKEl9YzpLuW3TVks7uiuqBgXCJjRtoPohtEDS/A09EhG936SZWx3PjqRRhGt5sAvYp5XdUFNf
 zgOzjB91m487Fl5rsrND/EfMamTb70lcwFeoeKdHWH1aRGd770FKU9hCox0d6ShaKQId4iWqO6P
 CiNGMHw2ZtwrklP0fAwk3nMl6ELy8w/A7tngp+QVdlxGEw1Yr7T1UzLpfJBqt5Ley6NMkUpTfrL
 znU/iBxb6Do/AHqiKFLSLtWdJUTj1Ih5CmAaIubeW60oWxnKJ15e0403IBn75X9bo3lh2lysW8V
 nQsP6skXR6ERI9lCl/DjmSpExYJ/T0nOkJiWYmtzhwujFpRi26RbktsCdrDu7xt2sYk0s/K3pxM
 SVNNKmsCMnaBywOC9XbxlLGlDWEIfSPEgscNQM7gFsbtTeXqKrrFcwfCDBeWU87aOHsy9kkh5HZ
 ith7TQTwisGS2xXfMug==
X-Proofpoint-GUID: UQfY_Yufj6jt1p44JLz4BgRQaWmE3dxn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2MCBTYWx0ZWRfX5OEVz6WZzCKn
 CROdWfzlD2gw1frnZW2dSByqbR84i/D8aPDY8tY1MoVrWgbLkqMYAfp8CnfwQO7LhuzWRviQh14
 s3l1I039dfSXHJSb9HcI3bg1XiK+9RY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230060
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



On 7/22/2026 9:11 PM, Dmitry Baryshkov wrote:
> On Wed, Jul 22, 2026 at 06:54:56PM +0800, Yongxing Mou wrote:
>>
>>
>> On 7/22/2026 2:47 AM, Dmitry Baryshkov wrote:
>>> On Mon, Jul 20, 2026 at 06:33:16AM +0000, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>>
>>>> New issues:
>>>> - [High] Moving mode state updates to `.atomic_enable` causes the DPU encoder to read stale wide bus configuration.
>>>>
>>>> Pre-existing issues:
>>>> - [High] `mode_valid` incorrectly evaluates wide bus availability based on the currently active mode's state rather than the candidate mode, causing valid modes to be rejected.
>>>> --
>>>>
>>>
>>>>> @@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>>>>    	if (msm_dp_display->link->sink_count == 0)
>>>>>    		return;
>>>>> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
>>>>> +	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
>>>>>    	if (rc) {
>>>>>    		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>>>>>    		return;
>>>>
>>>> [Severity: High]
>>>> Does moving this mode setup into .atomic_enable() cause the DPU encoder
>>>> to read a stale wide bus configuration?
>>>>
>>>> In the DRM atomic commit flow, the encoder's .atomic_enable() (which executes
>>>> dpu_encoder_virt_atomic_enable()) is called before the bridge's
>>>> .atomic_enable().
>>>>
>>>> Because msm_dp_display_set_mode() updates the format state
>>>> (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420), the DPU encoder will query
>>>> msm_dp_wide_bus_available() before this new mode's format has been stored.
>>>>
>>>> Won't this cause the hardware to be programmed using the wide bus state from
>>>> the previously active mode, potentially causing display corruption or a blank
>>>> screen when switching between RGB and YUV420?
>>>
>>> Indeed, both look like an issue. Please add a patch before this one,
>>> adding drm_display_mode to the msm_dp_wide_bus_available() call. It will
>>> solve both issues.
>>>
>> Sure. Will update it next version.
> 
> I needed to pick up your patches, so I ended up looking at the issue.
> See https://lore.kernel.org/dri-devel/20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com/T/#t
> 
Thanks for the series. With modeset() moved into pre_enable(), this 
issue is no longer present.
Do I still need to send a v9 to address the comments on patch 6/10?
If I send a new version, should I include the first two patches as well, 
or only resend the remaining patches that still need changes?
