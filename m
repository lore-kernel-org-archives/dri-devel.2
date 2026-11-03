Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541E606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSFzNgd8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gt5vh0hQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E27810E110;
	Tue,  3 Nov 2026 15:42:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 820D110E110
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:42:44 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3E9stN2727611
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 15:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qg5aVy+S20ZvI0/BdN6+9Xr4hUEBJxVpKOMywluWEWc=; b=eSFzNgd8x3l1FanO
 GtqqbgWVVKkmVE01+RwG2kPpF5vEe1oOaxs8rw5fnzj1+WqU2s281JyMim73XwAh
 nn8KUV8hlyxdyyHAkbmThuamyDcBAnDbTkxn0THh3vajtZRasghaVFSKhNgvUJeq
 4zXcM8/IwwwfGh6+OMzDDed5QxIeSc6cK5scq6pF+h7LpefGYnJKvl4bnsDCDjKg
 mv1BxE7wnmoZsqB6Wpi3l4gh2CwA/kV99+spaayhSQu/F8RFtFxFlIfBmr3iAu3o
 yJIcbF6hHeXl7/mlsO4HFUipExI68GlG60qDJ219Rcfqfn+tx/hxVMIl4tktT6Yi
 1L9W8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bgdks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:42:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad840053c7so3379199a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793720562; x=1794325362;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qg5aVy+S20ZvI0/BdN6+9Xr4hUEBJxVpKOMywluWEWc=;
 b=Gt5vh0hQYj0WTtxbviWv0ycc6pv3EwD4pkV7RdHM0FhAkqCOX8TdSMe62kL3z7QHg/
 ohumAkgnI73DE4tdDohVpNpL6+cegM1dsu8MxUCMW6dMkfiapCjNSOt5bilyesVPBIO/
 4YagH566/SkiBuN+3nHtBDf0JIRid6yxEFVGVLJ+lQYZeSROit9M4ZhlYnUMa/ytyQsE
 B0FziNzzJ7D/BVrpC+IiBegMv3sKcu/GzRYCAdxjp+sP4ecaEd0UMS4b1Jw07temQNdh
 B2cEOUzNV3c1UkXchlr/q3UGL/0vdM3ZpR9AwPPnWAXELAJ26gAQTss4t95J/WVKLFby
 AaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720562; x=1794325362;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qg5aVy+S20ZvI0/BdN6+9Xr4hUEBJxVpKOMywluWEWc=;
 b=HkmTPj/Zc1wFA/O/DSPQ0MQcydI/LvAlcUxupAUDRx2w3DC88X6rDEif87xXncndCK
 ubgZtByabTxIv38GWCvCkygcYd/OrYKJX63d+rZf9MjOuLqtGunKX4Cl8VDLc7kqToUj
 kLWqSeRz1DjeA17G9xrIMrKtcOtsyBVdlQvLmE2Hn5f2cN7vR2j2hWKWZsejA+e4rCkr
 EWC+4EB+iNEWToKc9vWdmpxRP+6xcedUky5AiIb98L+NY0Yzwygj3M93TemNnh/Dxo7w
 wSBNbfocOYqOvZpaiaRMW6VwaSzG6AWR8iuKrN4FZueMpTfh2x7AWULCvcCkQLFv0ZXg
 2vqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6XOnvPQreeQ9EWdU8PKyCFjVhL3pIMxST78y37T1QiibbrDkxflZDlyxp6LwhMEBkvYmt3CeMIPk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8i4ZVyOKbXKfhBRrzSLAjsr7Q3O/vi7BijvvIFzYyGYIzMOSTM
 nRfknxEdRhIo1MGfgSY2L94+4Uu+96uksD0Li01NRnyABV+i2BQzyNM9w0EAPdIrdQ9bQY9afjr
 I+a6FU9fOxy2QXUn9oq2EVdZEyFrNDXvjw7zgUDXCxJI0sXfwCv7j6gmqGN8295xRKCCsFP0=
X-Gm-Gg: AYBFou3zgHKkm4rJ4i8eVK8EaPpsdHrGNOIduiI4+IYXmgV6cslZNbffjBIy6tWO96q
 oGBkP++4nyd+RgIfVUZJoNynX73BErjBw6cpU5nM2FSlwM+V1bIF0GnTxP/eOVwq/bIFP6amYE2
 +7KthduKYkfAB2F4z9pT8qMAKg8K9y7Pyhm4xjnK7GFGJEozZvOx+AV4cwMnfkWh2e4h/BS6bGF
 jV54smxosCuLA/kZ7/kLaHux3dnnHgdJrmo1em+zemnZVOYkg2L59uTUgvy/ugEDJyNcf5OSNK4
 LxMlgkLP8PkG1XFDEcsf0TdbSRdL3g6o2E6/k3U+tFpK4n877wG1idiVLpnd2Ttb/zosxRbArW5
 25xbtRqPvFhkFNFgkrkMfgFBnHMqanf2y2YRV959IsSkFcWK9vkaUnxvvOxT0/A54GuV0aYd39G
 I=
X-Received: by 2002:a17:90b:5807:b0:3ab:be66:ddbf with SMTP id
 98e67ed59e1d1-3ae8981dd4dmr10490378a91.54.1793720562092; 
 Tue, 03 Nov 2026 07:42:42 -0800 (PST)
X-Received: by 2002:a17:90b:5807:b0:3ab:be66:ddbf with SMTP id
 98e67ed59e1d1-3ae8981dd4dmr10490349a91.54.1793720561587; 
 Tue, 03 Nov 2026 07:42:41 -0800 (PST)
Received: from [10.206.96.127] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c7dea24sm4786035a91.5.2026.11.03.07.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:42:40 -0800 (PST)
Message-ID: <719999ca-28b7-4c71-8d85-87c3faaa121c@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 21:12:34 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: restore GEM-related IOCTLs for KMS devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260304-msm-restore-ioctls-v1-1-b28f9231fcd2@oss.qualcomm.com>
 <CACSVV00Z0gDW8aGOvO_YaB6AZ7cOR01mTsCHZvxp0qeO85Mqdg@mail.gmail.com>
 <puvl5tg6ovr45oncwcvx5phrkdp6uv6mrtqss2i6x6wsmeixaq@me3hztknlscc>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <puvl5tg6ovr45oncwcvx5phrkdp6uv6mrtqss2i6x6wsmeixaq@me3hztknlscc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfXyNIHL9X7pJFq
 5ftl0TLobLpjMgq9kt4kivpyX4Z8Y3WLkeGcPpHRUw2xxelqo/XPac2c4YVCbwhTPjqOcBtKy2Z
 WBqe1e1e3xdNglx5OqTuzO10x3vbCNY=
X-Authority-Analysis: v=2.4 cv=Xs1vqlF9 c=1 sm=1 tr=0 ts=6aea00f3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=G6p25mnS-FJF_-mfOFUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: WUyVT4JhL38qRizFBykpPi3SZgA9ZEz5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX6YDAdlEbNSeM
 VMmBBIr9cQK4cJeffV/JoXgr0wlqaEOWUGrV03qpUpPyzw5ayWlyb8+rtlDoMA0NsUK8UHnUDHX
 vKAeOqDbqmsVjWb1D2FU1L5DUrcMUWpMduZH0+JbhvFHvYFHlnMWy7OoTTseSG2kHP/39RNh3w9
 Fl7Wwl9/1d9td8U59fh0cDJ36yjHPzGStDfbKN9CRIO/9yGcMePnS+OrgBH+8Ml5GMnzlbJ2/uT
 MJKyKlKfTPMlNm4TUNV5Dxbkhk4Ab/RczErW3GqEVqU472aSCFVkzFq1SMMuOAwFDxMVChJNOG9
 +hXE3LarKbegVyA9Gso6lY01H3I/duysa9V1T0VZJ89XlsyJXxFcpZ4mgSjbvP7Ax/+em8+Gnej
 LcAKrHK5ztzT5kpY+soj/OLtGZMn5HyHvd7gnOEYwg7v+0pjwDobZZuwoSim17gPQMBlZa+AhIp
 Dmr+m5Bwjfn3oxBsWoQ==
X-Proofpoint-GUID: WUyVT4JhL38qRizFBykpPi3SZgA9ZEz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030062
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 3/5/2026 6:14 AM, Dmitry Baryshkov wrote:
> On Wed, Mar 04, 2026 at 07:57:34AM -0800, Rob Clark wrote:
>> On Wed, Mar 4, 2026 at 5:34 AM Dmitry Baryshkov
>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>> The MSM GBM backend uses MSM_GEM_NEW to allocate GEM buffers from the
>>> KMS driver, imports them into the GPU driver (msm or kgsl) and then
>>> uses them for rendering / blending. Commit 98f11fd1cf92 ("drm/msm: Take
>>> the ioctls away from the KMS-only driver") dropped all IOCTLs from the
>>> MSM KMS devices, pointing out the need to use dumb buffers, however dumb
>>> buffers should not be used by the GPU for rendering. Restore GEM-related
>>> IOCTLs for the KMS devices.
>> We shouldn't be exposing DRIVER_RENDER on KMS-only nodes.  If msm gbm
>> is allocating from a primary node, that is problematic, since there is
>> no guarantee that anything but the compositor has access to the
>> primary node.
> We are not exposing DRIVER_RENDER for KMS-only nodes. I'll check with
> the correponding colleagues, what exactly is their use case, if the
> allocation is happening in the compositor or in the app. In the latter
> case, I agree, the buffers should be allocated from the GPU.


Hi Rob,

In combination of msm-kms with kgsl, wayland clients allocate their own 
dma-bufs (typically through EGL/GLES on KGSL) and pass the fd to Weston, 
which imports them. Weston is therefore not allocating client buffers. 
GBM is mainly used for Weston-owned allocations such as render targets, 
composition buffers, and scanout/framebuffers. It can also be used by 
applications that allocate through  EGL (GBM-based path).

One additional consideration is that KGSL is not a DRM driver and does 
not expose a DRM render node. Since |gbm_create_device()| operates on 
DRM devices and relies on DRM interfaces such as |drmGetVersion()|, a 
KGSL device cannot be used as a GBM device. As a result, the MSM DRM/KMS 
node remains the natural GBM allocation point in this configuration. 
Thus we need to add render support in msm-kms driver.

Thanks,
Mahadevan


>> BR,
>> -R
>>
>>> Fixes: 98f11fd1cf92 ("drm/msm: Take the ioctls away from the KMS-only driver")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>> Note, here I assume that dumb buffers generally should not be used for
>>> rendering. That doesn't seem to be complete truth as Mesa kmsro on MSM
>>> devices uses DRM_IOCTL_MODE_CREATE_DUMB to create buffers for resources.
>>> ---
>>>   drivers/gpu/drm/msm/msm_drv.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>>> index ed2a61c66ac9..f82c9a36a166 100644
>>> --- a/drivers/gpu/drm/msm/msm_drv.c
>>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>>> @@ -799,6 +799,14 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
>>>          DRM_IOCTL_DEF_DRV(MSM_VM_BIND,      msm_ioctl_vm_bind,      DRM_RENDER_ALLOW),
>>>   };
>>>
>>> +static const struct drm_ioctl_desc msm_kms_ioctls[] = {
>>> +       DRM_IOCTL_DEF_DRV(MSM_GEM_NEW,      msm_ioctl_gem_new,      DRM_RENDER_ALLOW),
>>> +       DRM_IOCTL_DEF_DRV(MSM_GEM_INFO,     msm_ioctl_gem_info,     DRM_RENDER_ALLOW),
>>> +       DRM_IOCTL_DEF_DRV(MSM_GEM_CPU_PREP, msm_ioctl_gem_cpu_prep, DRM_RENDER_ALLOW),
>>> +       DRM_IOCTL_DEF_DRV(MSM_GEM_CPU_FINI, msm_ioctl_gem_cpu_fini, DRM_RENDER_ALLOW),
>>> +       DRM_IOCTL_DEF_DRV(MSM_GEM_MADVISE,  msm_ioctl_gem_madvise,  DRM_RENDER_ALLOW),
>>> +};
>>> +
>>>   static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>>>   {
>>>          struct drm_device *dev = file->minor->dev;
>>> @@ -868,6 +876,8 @@ static const struct drm_driver msm_kms_driver = {
>>>   #endif
>>>          MSM_FBDEV_DRIVER_OPS,
>>>          .show_fdinfo        = msm_show_fdinfo,
>>> +       .ioctls             = msm_kms_ioctls,
>>> +       .num_ioctls         = ARRAY_SIZE(msm_kms_ioctls),
>>>          .fops               = &fops,
>>>          .name               = "msm-kms",
>>>          .desc               = "MSM Snapdragon DRM",
>>>
>>> ---
>>> base-commit: ac47870fd795549f03d57e0879fc730c79119f4b
>>> change-id: 20260304-msm-restore-ioctls-2a1792311a09
>>>
>>> Best regards,
>>> --
>>> With best wishes
>>> Dmitry
>>>
