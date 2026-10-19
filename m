Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7006CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A9110E0DB;
	Mon, 19 Oct 2026 13:27:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA67210E0DB
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:27:46 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JCsUdF2483450
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VzSWM0qjlnwVL0p0Q5tt8OPvdg+HopCHeCS0win3WeQ=; b=Du6rHsLa1o+uVv4p
 avJ5ig2JCVloBqKJXUcI7LZN2UAmOs5Z9/hVLb3EY0OdtCg3r+fi7lk1QZwdkF71
 QeBQQ2UTYFWuMGPuVcm4Us8405DUS9oSO3i9s0IeSyZqar/4kxPe1VA1gxbz8rFD
 mkZFgguZ7SUc3WIpvtoiEy/R9pCtv8Sjgoejt6luPrLdExbPaOdJjQklWq9MLo5A
 oMyelj06IEX0KvKAI8q6cCuxp+bdDQhafdcMzoov3Fn8k5qRXYDWPcSOpGQtjllC
 Vrn9XfKytotRmcO1WuFYktDi/mwzdCt9Skp8635KX/odZzmBqmAoZvIjNziaB+2e
 6TQJxg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfg4ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:27:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ea8a9cfe6so83399585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792416465; x=1793021265;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VzSWM0qjlnwVL0p0Q5tt8OPvdg+HopCHeCS0win3WeQ=;
 b=Th3wruMTgt5coeLhbunPo1Dq19kXHyteuBmTgi2WGBdC9HJEGl3jk5aQlGC6iSMkk8
 X3iZkhY8QK31R2w2+1MNSkhcURbCIDEls4XO9XejHabDj/sDE7L6nO0cNrmFJLLH4+BR
 PtKcGO2PvuxYSczZWBcSstOqizjR5/PbFiGKXOe2BaqY+RBMst+BgsT3LZqHSDcYepNX
 DL8yJwV/jV6h7yDYAeAHuT+KQMqoGKaA4PM+2vZzGE0+AfpPJ2MfqNrZwxI9qQ17xfB2
 FFnqSd60H6Ti29VPtYAaXLGMxchiCA0nveUCWBLDpbYoKm4nCj9+V8mZrcMbtZn16acy
 AdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416465; x=1793021265;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VzSWM0qjlnwVL0p0Q5tt8OPvdg+HopCHeCS0win3WeQ=;
 b=lO6F8j1W2CUgytbnU/m3QsMag/UbAumkOLj74p+qccAqG50g55Hhml7vkICkS/KjOU
 6e7SWD5+eEi1bRX5rBDe6PvXxYiTaXrjn4dG0Oh0KA9sIRQ+yCVCDDOKTa2L4iTtBVCf
 8+CvOxn4Txy5WrgvPbKPPVUFaqmJZXOTA9CXH5EwwluNq6uiuYON6xzONmo89IBJ8bxM
 bDPYjl4bbaqlj90Ig+BgoouqTtXfcTklWdfvECuyNpOxe4IeYmOWcqJy1wNbtvxzDlFC
 yQfvTJBn977bUf8hFb0JZs80nqs1pND1ay60Qn/J7hp+bkairySRoHHulcX7zhgfxeTP
 +XSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXT2I+QjvAd11HR/dN4pyicj69DcUXSs8kGmzWTswnIBUh+07at/oOtHBBE24CZy0tCJkfK82HSiU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlEje6RbnZZaAVX3AnTvg9Hv4udw8waYKQ6c9ObT1SV6MTua9f
 IfHxcsnMk9Usi+zG4Hk9KCjvs7dMA5WMF68qpe99buL8G5WZmTsnDfNgJbvK9/0Q2ext1ZAxK0d
 qPRv+I7Zt5rSdZo84XJpviGASDfzFtfp6YXtUSKkvoMzeHqKdgfBZb5x7L76MwuxpDHyBqag=
X-Gm-Gg: AYBFou1CL2EnucSixXvRpomy6ER21RTz1u7CUavt5Mxa89C1wAPKy6bTIAplkzOPW+Q
 pXWS38k8VtpgaZiw0/ZZUcUucc7YxH8FHq0w4B5/Cq6jweg/O0RG+n64F6q7Vg27dQx9voLY8ur
 dKAHIheOdKKRYmp36YkbuN9dXx2LIkndJBWtiJzy+sMHx5tqf/z53ulP7X7l4j4CYhEQO1IVEvV
 IQmGOyagf/ab4o62p5pDL1Eb0lC6JtfRqjkB/aCQ962huVZnvrMaKl76AJnxgjTgYH6ZlO6L7TB
 eqsHIBLYmg0sEiGAMGGb4WDtutU9nhY+euC8fD6nOQUaxwz2YhvDDvAdZZi2bXY7uUl9MwKmQj0
 QXzru41P9xoUBnF9powmWWQ==
X-Received: by 2002:a05:620a:4402:b0:93e:508b:7800 with SMTP id
 af79cd13be357-93f29a21553mr1469818485a.0.1792416464345; 
 Mon, 19 Oct 2026 06:27:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4402:b0:93e:508b:7800 with SMTP id
 af79cd13be357-93f29a21553mr1469811985a.0.1792416463768; 
 Mon, 19 Oct 2026 06:27:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b1347sm4058496a12.12.2026.10.19.06.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 06:27:41 -0700 (PDT)
Message-ID: <9ee7225b-588b-4253-b766-5e6ee6dffb04@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: keep vblank enabled when entering self
 refresh
To: =?UTF-8?B?UmFtw7NuIEplc8O6cyBNaXJhbmRh?= <ramonjesusmiranda@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261018155423.1299629-1-ramonjesusmiranda@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261018155423.1299629-1-ramonjesusmiranda@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ycVIsYeIOfnZneLi9pRSnztMvlzhnifF
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad61ad1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=v0c-XO7ZLijyoodaFGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MyBTYWx0ZWRfX/4g4JGRiH6tQ
 wvUqUEvP0ZEw8M/7t8c2ZiavWbK3mPeBCqmI2MiWYKCrhIViN/QdNRIjE2sUpMnjIWT7ypHJbuL
 lrUBb3y2rE1q6GjjV+zSFrV+OR37KSS/d1Xw84bqZ5NMId1dQ3rKKl/8Fsxor1maJoXCJcH8zbd
 GFyaDJ0sECm9vLljr9SYL5jyT2958sLh500zuxqMGd/ceLy/0ratdwSR4E6L8xaG1mQIQtiCEiK
 2X3tmJc7mmtjLBXhM260XtM1rhGwLKf+jcSCrcQnTk9bIzrbn9SBKPEN3bha3Tnr/TsupNDLW2T
 KLGtMuCOo4jUtAQPgcHS2irvWVVKuThyAKkGxBTw2L/1epLdlddT/WyJ6yIrREQrE1ykPSEGI33
 9QiTsCBhUUhoju4ppZt4PgUpQkeSgtfkoSApGDR18Rb0xJnm7RdVGoyDm0R6Xt7FT2uyjkv5AU6
 3Oodo3EAf0DQYv7EWFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MyBTYWx0ZWRfXwbtlmk3yJE62
 g0bWwjKKjX5+MzHcWUzc9GzR9ZYl9jJ7WZi7uS6qM/8v9bwPRATNiywRY9t+jM9WrLz5scR6Q/6
 QgbnPHo9wm6rVAGFXE7Lxm5RJ0VWvUk=
X-Proofpoint-ORIG-GUID: ycVIsYeIOfnZneLi9pRSnztMvlzhnifF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190053
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

On 10/18/26 5:54 PM, Ramón Jesús Miranda wrote:
> When the CRTC is disabled to enter self refresh, dpu_crtc_disable() only
> checks old_crtc_state->self_refresh_active, which covers leaving self
> refresh, and calls drm_crtc_vblank_off() otherwise. The atomic helper
> then expects vblank to remain enabled for a self refresh "disable" and
> warns:
> 
>   driver disabled vblank in self-refresh
>   WARNING: drivers/gpu/drm/drm_atomic_helper.c:1296 at
>   drm_atomic_helper_commit_crtc_disable+0x1c0/0x1f8 [drm_kms_helper]
> 
> Skip drm_crtc_vblank_off() when the new state enters self refresh, as
> other drivers supporting self refresh do. drm_crtc_vblank_on() in the
> enable path is safe either way, it only drops the reference taken by
> drm_crtc_vblank_off().
> 
> Seen at every boot on a Microsoft Surface Pro 11 (X1E80100, Samsung OLED
> eDP panel) with eDP PSR enabled; with this change the warning is gone and
> self refresh keeps working.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Ramón Jesús Miranda <ramonjesusmiranda@gmail.com>
> ---

FWIW this is not enough to get self-refresh to work on the Glymur
Zenbook A16 and the 8280-based x13s, the screen stays black if
there's no updates (it worked on the latter in the past). Dmitry promised
to take a look one day.

Konrad
