Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC51C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72A010EAAD;
	Tue, 25 Aug 2026 15:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jkrB5NDN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJSwDpJa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF5210EAB3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 15:10:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEUsJB1153772
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 15:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x0A9btRvyQfNGEMbRXj1NIxUjbY9mjUOkIxhGDJcN9c=; b=jkrB5NDNepVjLYDj
 eZeRB8LkZxGejvAJe4aqukp3qAgik1G7tK3pZCaYJIBoP9TI5iirYJGJce4+O/92
 FVDnX7WS8XThY20+BsebBDH1Gxv+yNjcrfZny2PkhrmmuPrciEVVSWpYaIohFY54
 JfnYnDdrsY37MePXeXbQMT+0lDAcqyhJA0VuwEA2hFF69Ozr3ePpgvPbn0+f7T+p
 YyTpBU3cvU9NPUVLpqxjHUg0akgpydNF43QUSSAjnldeZ734llwFi2A8/D9MloH/
 uP48yOqvJ9ZoMOx+0RAs+V0pky/sjHvhIOqDriZzaXAaqCgi25qLwpcoBPgUHwyc
 AudaDQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93xxtm5v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 15:10:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so12162520a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787670623; x=1788275423;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x0A9btRvyQfNGEMbRXj1NIxUjbY9mjUOkIxhGDJcN9c=;
 b=LJSwDpJaefiHjb3Ol2MwyBJM1ddgrw2/zDLs2vjlCyUwCYRi7/NLsDY8+4jb/awI9f
 e5SWoHUFZWnDy0+YBdFe6h2asApxG8enEjy0NPYVDMSBEqAjZDAWZJaKL+eb1gOjsRc0
 jylQ5EVYxJawaOsvTZg1jcFukEqft7vbimoKHAZoCXtx8qhG0ff+mw0YEAR3VtPJSl2R
 tTNluUnwzihuoyGb0RcsGiY1chOgmWLW9HiclUYoVfeYrt2oN+TN3BTf8lcPS4kwfBzc
 skzgvOdv+BN+hlO+/KCLgnyUT5eOOreinWe2JSDB+bAssqxvfSnT+VPnJK2wkueAZRWk
 vGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787670623; x=1788275423;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0A9btRvyQfNGEMbRXj1NIxUjbY9mjUOkIxhGDJcN9c=;
 b=PFNiTC9YavoNJ3j6gAId8zFf7TBH12aXKahOwSeKlb8JCuX9L1FvBWaZ0DcmuKvQ0h
 LrOeXmr86PRaWp5KoBhUXrE/0lJd4Kw0hPskeFUE28UhjiA4bzB5uU3qPPjPXyOUID1j
 uWOg/1q/k+9xWEutgTyF58VARJI7uDZuX1so5bnF7rOJEYr3fO81MB10SX1/i+PxyXnC
 pGoZfILg46h+COshfvYwCfaX5M5IUc3mBzBTLDvz9oVTDC8BSpqWSYWNyYYpa0WrlcRr
 K8izI81sxZ7WpmDdmHBDPw35ZaMWF57jDOcvdZM+MXeC33s20/xb2fj9OmS09kXuFVOs
 IEmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrolF3dtTynhwB4Z1R+h8bu/GixtSaKaxdduiUurCJYgNrmL6KO1xCXNKa4j3040Sj6JZgIjoR+tY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m2ZFT7OifhwXSqZ1wx/3KSv0xIeQ9l7KyhvelPrha/EaMqaNGC
 xofi8q05nxIQBQAPLxoSH56HU6hN8o/vld8uZvKkU0xsTuTnTmcQhgKt71a3DMBp0zF1lSZP3QI
 VQ66xgn88qGlAKt0NVDzCcvWc5VW6nEYOw18W42SLR0Mp22ym+oqnYFfrngUdZCiBxcERalw=
X-Gm-Gg: AR+sD103bkOZLRZEIKdOAmJoh4ZKsRQMsMJ28A3mYLtS746fG7VxyvGFOy2OFrOa3kG
 9/PRxtOExgFUM2Y5WDQRADQy0NSGjpDdM9STTHD8v7j9LkdovYhqyZo5sMFlI2LX8M8URRErXAl
 AtsNpTuaPW/d/FtZfMz9UxNjz17BFtl1SbRZ2JQezyNDP8jX6cQo4Z/JqPUFjnaY5GMAT8HR60g
 mfdh9z3lCBxFukyXea0R5lz2BtXNp1ozPwMoNCaIsAMdVsq+ngRKtSNeSU6htYY9UbO5D4zLs1+
 7sEg+igq2oolwHPqtAmd+IV0rah4osI71bp40XQo6vRGb2uai2Tfa8FW/KEN8JHocHMHBN4olRD
 e330gA6MEM/g7Ssf54YNiZMFESY0=
X-Received: by 2002:a17:90b:56c8:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-3964652108bmr15862970a91.12.1787670621400; 
 Tue, 25 Aug 2026 08:10:21 -0700 (PDT)
X-Received: by 2002:a17:90b:56c8:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-3964652108bmr15862841a91.12.1787670620891; 
 Tue, 25 Aug 2026 08:10:20 -0700 (PDT)
Received: from [10.204.78.62] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm1927178a91.2.2026.08.25.08.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 08:10:20 -0700 (PDT)
Message-ID: <a5bc4ee3-2c9e-4098-9ce7-08a71d2f7058@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 20:40:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: advertise linear-only modifiers on platforms
 without UBWC
To: Nabige Aala <nabige.aala@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260819-remove_ubwc-v1-1-5357d5cc517f@oss.qualcomm.com>
 <672f91dd-749a-4448-ab32-50ac064a4b98@oss.qualcomm.com>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <672f91dd-749a-4448-ab32-50ac064a4b98@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX9Iofa4WKVUUI
 3cy192ZLzWDMLDGTA7EC+q9kB+FRCRTt3pFWXarGoX16H/3s/1z7nEjSnTsYXQOwj3ONirl+nrm
 wkLI2zo4sXHMV038W3X0XzCxSXNEeek=
X-Authority-Analysis: v=2.4 cv=EOg2FVZC c=1 sm=1 tr=0 ts=6a8db05f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=INP11UExdj8QQtfJzOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: FeFei9SZAJc6wde_gX2iu73SuyC8Zqii
X-Proofpoint-ORIG-GUID: FeFei9SZAJc6wde_gX2iu73SuyC8Zqii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX2yjKBql5DYqe
 wHlSPTiIbfpd+0ETMT2xylgzqEnG1M4Ex2jczV9tG1R54LZuNyTeD3PTGD65/ZboGvWKjJr+kiG
 av+8oe/qWpNRz571ypLcvyw3RZxDGAquK3FMRvzqDkA1iZrrGH/51rJHb9z0vpJp43JAJKq77A8
 f/Zm+KnH0lo8qyXpgNc5A2ANcDPdVsnEtQxY6mEgCGdwkXCzvE6/MXCSoM8v4wRYFVNy9Zs4QLY
 cFsl/k5bFhJIiZvax/p6yrzTBrTjnYXd4uuda74xNqH3mx/WBc3JOIq9/7JKs0rOEgv0jZ+GDYl
 69n1VWzEbOUckyEobYfSmHHWQQbEhV5SBM/1uwCLKL6Gx5VC7iNXUGo4icvDQIiGRzch3o0CzTo
 O0q7Pu+HLQ0fXN3oJ74BYId7sk7LjUfIqnBwnHeJr3eEBI4HCJF+ZGQk3WcAB/gFvwZQ8hvRGkM
 KFbGaeKx7F3iUNvuvXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250128
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



On 8/24/2026 1:01 PM, Nabige Aala wrote:
> 
> On 8/19/2026 4:53 PM, Mahadevan P wrote:
>> Certain Qualcomm targets like QCM2290 and Shikra do not have UBWC
>> support. On such targets, advertising DRM_FORMAT_MOD_QCOM_COMPRESSED
>> in the supported modifier list causes userspace to attempt UBWC
>> allocations that the kernel rejects:
>>
>>    msm_dpu: [drm] *ERROR* unsupported format modifier 500000000000003
>>    msm_dpu: [drm] *ERROR* unsupported pixel format: AR24 little-endian
>>
>> On platforms without UBWC, only advertise DRM_FORMAT_MOD_LINEAR to
>> avoid exposing formats that the hardware cannot handle.
>>
>> Fixes: 71c5c23be874 ("drm/msm/dpu: check ubwc support before adding 
>> compressed formats")
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/ 
>> drm/msm/disp/dpu1/dpu_plane.c
>> index 7b92082d35a6..c8bd034690cb 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> @@ -94,6 +94,11 @@ static const uint64_t supported_format_modifiers[] = {
>>       DRM_FORMAT_MOD_INVALID
>>   };
>> +static const uint64_t supported_format_modifiers_no_ubwc[] = {
>> +    DRM_FORMAT_MOD_LINEAR,
>> +    DRM_FORMAT_MOD_INVALID
>> +};
>> +
>>   #define to_dpu_plane(x) container_of(x, struct dpu_plane, base)
>>   static struct dpu_kms *_dpu_plane_get_kms(struct drm_plane *plane)
>> @@ -1836,7 +1841,10 @@ static struct drm_plane 
>> *dpu_plane_init_common(struct drm_device *dev,
>>       pdpu = drmm_universal_plane_alloc(dev, struct dpu_plane, base,
>>                   0xff, &dpu_plane_funcs,
>>                   format_list, num_formats,
>> -                supported_format_modifiers, type, NULL);
>> +                (kms->mdss->ubwc_enc_version == 0) ?
>> +                    supported_format_modifiers_no_ubwc :
>> +                    supported_format_modifiers,
> 
> Can we just pass the NULL here in case no ubwc modifer are supported 
> instead of "supported_format_modifier_no_ubwc"?
> 
> would not it automatically handled in this function 
> __drm_universal_plane_init as default_modifier?


Thanks for the review. Please drop this patch - it is not needed.

The commit message was wrong. The modifier in the log I quoted,
0x500000000000003, is DRM_FORMAT_MOD_QCOM_TILED3, not
DRM_FORMAT_MOD_QCOM_COMPRESSED (0x500000000000001). DPU does not
advertise TILED3 anywhere, so this patch could neither have caused nor
fixed that error. I pasted that log here by mistake; it came from an
unrelated experiment.

Having re-checked the current code, there is nothing left to fix:

    - 71c5c23be874 already makes dpu_plane_format_mod_supported() return
      false for QCOM_COMPRESSED when ubwc_enc_version == 0, and
      drm_plane_has_format() consults that callback in preference to
      plane->modifiers[]. UBWC commits are therefore already rejected on
      QCM2290 and Shikra.

    - create_in_format_blob() runs the same callback for every
      (format, modifier) pair, so the QCOM_COMPRESSED entry in IN_FORMATS
      already carries an all-zero format bitmask.

So the patch's only observable effect was to stop a zero-format
modifier entry from being enumerated in the IN_FORMATS blob. That is
cosmetic, and certainly not a Fixes: for 71c5c23be874.

To answer your question: you were right, NULL is equivalent.
__drm_universal_plane_init() substitutes { DRM_FORMAT_MOD_LINEAR } 
when format_modifiers is NULL, and this is documented in the
drm_universal_plane_init() kernel-doc.

Please mark this as Not Applicable. Sorry for the noise.

> 
> Thanks,
> 
> Nabige
> 
>> +                type, NULL);
>>       if (IS_ERR(pdpu))
>>           return ERR_CAST(pdpu);
>>
>> ---
>> base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
>> change-id: 20260819-remove_ubwc-0180dfb2908c
>>
>> Best regards,

Thanks,
Mahadevan

