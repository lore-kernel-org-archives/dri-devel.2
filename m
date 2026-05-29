Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8D8CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6109310FC2D;
	Fri, 29 May 2026 09:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCtNdVI/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jlPjS24R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B243B10FC2C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:53:51 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T696Re1931774
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0IspbkiTV956hCVyof6uvYh1
 3JnEd9wOiBLCsTcABCI=; b=PCtNdVI/XVhHpRvTWvzV8sExlFAyc/NDikFbFQc/
 1nwiqU5FAs8OcYLaj+/3ZZLKXyg6vHPWS17hQ1ROv4l30B0exEfUCbvwdb8vGtus
 EdKXaq4lmRThy4QUHKkvSCuhsHQiFi93BDg7a2GPr5FcpwcnzNuOCzx/hn4SUs31
 ZFqvU2vDup7by6LR86xPni5FXGvizgrV+OL0mmROFHjUHtKjWVIPg8aGb1QNcbPO
 eoCEAKFK9j6Y/KMMfYSBRG7yx9BjxxiQ4Ix9jC2fDe8uQv30kbbHaE4xeJlqiqDv
 J+JqKWs35imiSmS5nXy3LvpEEsc91TpVFzWQVsed+tzVZQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eesxabv5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:53:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d51ffb59so75087341cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780048430; x=1780653230;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0IspbkiTV956hCVyof6uvYh13JnEd9wOiBLCsTcABCI=;
 b=jlPjS24RElM/NiP/GQrc5v5cDAdlkjEFQv6xM2j3y7GFWY/LRfAAvG1voveB2pkC5b
 urWQi1WiWVgzdwfCo1O75Woso2IMjjAPcTDf+3MvBTbBD/Tr3k1YN1/uoZMDzR6/eG4a
 we8qiNdrhXryH6D/NpffIT0+0Wc/sB4xOPp8qy1G2cehsXHYAA9gY2yPNXSsWVVb494P
 SuUkg063l26R5j3g1nfJQWOyQrZYRjC/WUFhOCpn93Jchao1UYhljsgw4e7anc9o4h1v
 GMjXcACladFD/5NNojDf2P8cw/AGH95VAezvuMRW8H6SBytVrNY8O5mVUF0QyJsFCQLD
 HHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048430; x=1780653230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IspbkiTV956hCVyof6uvYh13JnEd9wOiBLCsTcABCI=;
 b=D1yPauZprnkIM3H8LrT4wmhGyt9JyuFaP+aPjDsGW/kdGq1h07GbcOmPM+do+g7638
 TVb9Xo9J67Hh403jevvXosQmm8vbMOYYTMkXrM0uarm7mZy6pVpXhp0euGVHG0PVKEOZ
 LIS6mCGmAwkdEWns/Xb/GDifVfhQYNBD8wZBc7LuYgA0V5KyJYdOFwxMvBYRVeVyZksG
 wEb8TbO3NwpbU8/QhM+DpwdZUe8jhRouwqom0uqm/BZJWSpR+j74w03k97CDj9hqQtse
 gwtnt1aixxMTzTMriIQ2/i126kRAdeX7Cp+8M8CQrL8MN5Hv0x/Reh5Xs89R+xoCZhNS
 Vd8g==
X-Gm-Message-State: AOJu0Yyzb4mKs4uqHqcttyr8Wh8vw/qj6IfYxUt/rMqR9RAUNuZREI2/
 9tXQ/eKDjKVLq2GfWBXc2e+KmXXiJDUIXJBegYTWGT/O5L9akdZd1PIqKGPYKCdg1ARwpbK2n2w
 2A0i7P8COaJrRIl+uhPdASIW0QP/1joPfsF1LqXb/PJ8KGRN2uWGINU/olFBcRODTXl5j4bI=
X-Gm-Gg: Acq92OGRo0nEiEKCl5wpTgtcAfQ2cMMNgH89URpYvlI1x8d2qxRWXhp79iYsPEeCxa3
 1DVAAov/sVqIHjXg+OGBUnD5aq49zO+hBJksqtD5BnEx/1/yhvLF0NnUwEMlVGTuznmRCr7mkMd
 CCqpPmv7RUGA6SD7x9n9KSsuUHYJBgPyiQmofob+Vy1aAiRWDJYCkqaq4I/xO4PwLftetmaU8cn
 4NyLzZi99KyEAwXsgeotjQrrYTLbNvIloxQvJ0HQvH/iOaoWWPcMoT2HE4UTc3jkpg++r9v7ui5
 6Z7ttchlo235/iwcbqvHrYGNxHQq8cGy0x2hv0mcwxHQrUoxcfJs2wOisKg4sjqe7fMc9fN3W8a
 lv0j5AkO311HAGAzzwYjnDlY6ALuD48n2ivhKLWTXoNyHb+SLbhslaHeO5553VLzmRPipJ/04by
 PiUoMF/JbgQGkJUwSaqF9uQ1IHPeiIKDIeR+XKQ6J5d0bHDQ==
X-Received: by 2002:a05:622a:4cca:b0:517:14b6:a2a2 with SMTP id
 d75a77b69052e-5172dca0112mr25716691cf.27.1780048430319; 
 Fri, 29 May 2026 02:53:50 -0700 (PDT)
X-Received: by 2002:a05:622a:4cca:b0:517:14b6:a2a2 with SMTP id
 d75a77b69052e-5172dca0112mr25716531cf.27.1780048429927; 
 Fri, 29 May 2026 02:53:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39659de42fasm1502461fa.19.2026.05.29.02.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 02:53:48 -0700 (PDT)
Date: Fri, 29 May 2026 12:53:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v4 4/9] DRM: Add support for client and driver indicating
 support for luminance
Message-ID: <3wkg45a3i27gmmiryrafogdhggp2hef4o6d6lxvxhoafcavhjs@vpk5wwgt6ulu>
References: <20260528054911.1513208-1-superm1@kernel.org>
 <20260528054911.1513208-5-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528054911.1513208-5-superm1@kernel.org>
X-Proofpoint-GUID: mG5BfPfXgOTUZRFSGuNlrJzePw-grOsm
X-Proofpoint-ORIG-GUID: mG5BfPfXgOTUZRFSGuNlrJzePw-grOsm
X-Authority-Analysis: v=2.4 cv=ZdIt8MVA c=1 sm=1 tr=0 ts=6a19622f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ws1xHSm7LW_IKOyM:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wEWTZA3UIbUYeBXJOeAA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA5NiBTYWx0ZWRfX8bA36+22jren
 xCNu8/NZ4ZoCpX9P62LPZevdDsHuN02Nal1sN2nKZLdwGAewDs8Gw5GMQ7p/xP0oz7rgqzJY63c
 tcFIixf0lcufdv3+u+K6XFOoSrFuP49C9UynaBzSDJZb8HZ9nUmr2T3h4zrES9hNFfQTHNKz/5g
 zMPN3KnSWcfy6+mnH7MwjuIwcxf0OccRUPja0Pac4wKvTpaHKbpXWErI8aEOw3lkj1jMBpckjac
 SkRTh4hGSIrSwrLw3FLXG+Cl/LHhWdERKW5J952PmcZl9zk77Q2hEy5qWsWIMyxG67GZIRQtMFw
 l2bsnBNnGyTWWn3YInrvGrwUi4hdkgugcTsLi9RNRySxn229HQy7up1PcgTtcNgug4js9NCFfJM
 Q+ikxTHvRtWw2aEXhxaJUu/FyrLmKJ1aoRS3fVPsnnhfgw01ZGeloO6zFWmk8PM2I50DZprcDl0
 NXgfZvmo2QLs6/MLnEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290096
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

On Thu, May 28, 2026 at 12:49:06AM -0500, Mario Limonciello (AMD) wrote:
> The legacy backlight control interface can only be disabled when both
> the client and driver have agreed that the luminance can be set during
> a modeset. Add capability for the client to register and for the driver
> to indicate support.
> 
> When a luminance-aware client sets DRM_CLIENT_CAP_LUMINANCE, each
> DRM-connected backlight on the device is marked as taken over. Writes
> to the legacy /sys/class/backlight/<dev>/brightness attribute then
> return -EBUSY until the last luminance-aware client clears the cap or
> closes its DRM file. The takeover follows the active backlight_device
> when drm_backlight_link() retargets the link.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v4:
>  * Update unit for luminance
>  * Disable backlight of other connectors on same CRTC
>  * handle CRTC disconnect
>  * Make DRM_CLIENT_CAP_LUMINANCE actually inhibit legacy sysfs writes
>    with -EBUSY
> ---
>  drivers/gpu/drm/drm_atomic_helper.c |  1 +
>  drivers/gpu/drm/drm_atomic_uapi.c   | 59 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/drm_backlight.c     | 41 +++++++++++++++++++-
>  drivers/gpu/drm/drm_file.c          |  5 +++
>  drivers/gpu/drm/drm_ioctl.c         | 17 +++++++++
>  drivers/video/backlight/backlight.c |  7 ++++
>  include/drm/drm_backlight.h         |  5 +++
>  include/drm/drm_connector.h         |  5 +++
>  include/drm/drm_drv.h               |  7 ++++
>  include/drm/drm_file.h              |  8 ++++
>  include/linux/backlight.h           |  8 ++++
>  include/uapi/drm/drm.h              | 10 +++++
>  12 files changed, 170 insertions(+), 3 deletions(-)

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK

I'll perform a full review later (hopefully today)

-- 
With best wishes
Dmitry
