Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E69F8FA94
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E4510E8D7;
	Tue, 21 Apr 2026 16:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="piYuSDIR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RimywCL+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721FC10E8FA
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:08:37 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LA2jI41809737
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kBePGaVYHXLdWyRMJebFznjl
 7q7azdqgDds4a1vdvo0=; b=piYuSDIRShi9VMg4C3Sup8gt3YMFe+LnqiRrjuCU
 YvnfghsB6pVooXNm3qkkNnTkkYOgJUnofzscm5oqDMD+hc+xNGUVh8LsZflk9S0u
 os9E/biPuDkLrUe2607Sg2aGREiv9H7/M9uSW9ZY0xdbLDbmys2SY7Zmbd39lHhk
 6LY/FrQ/YQolNMsRXjVkZBDJrk324UZP9VJtWFs8YS0DgtE+QR1tX56YaK6zeDXW
 WLPio9MDFzYGWV20xOUb58FUdctgkn6ZUZ15OjiuD0FeDYtItU+H9TJp1muG03kB
 wKdbWnG3+4NI3dTiy83AV1yNUKVYgK+2hNfLvxlHQo7Mpw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp74xs72q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:08:36 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-479d900bee9so3670043b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776787716; x=1777392516;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kBePGaVYHXLdWyRMJebFznjl7q7azdqgDds4a1vdvo0=;
 b=RimywCL+jvoBFpIalrystiH8Bo0NAOY7anpaSOCXbJTBRnSxX9vqMCBhBnd762kYga
 v5jbJy4bS9WStfXAnQmR4w+jwlBIYuX82wnO5htTN6ZnCo3stO3cuAQG+lrHMDEN83zQ
 DkHKRoXOvn3p+zHjvssTcElNCBY+CEEF58oOTqb5L7v+FuH+ospCV9YPazvhmqcNcjwA
 x4pzgjoMTHrpSJeHSwfEnSavdZkQNuYEZ0AEIv+gTfum0uo91sFBBEpXG7x+sBVOZj2i
 nnmi3lP1PrywI4alRlqW/sxg97vXq42YbZR0BxlnoicpS7SAnT0kTRBPw273hLZvP3Uo
 /V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787716; x=1777392516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBePGaVYHXLdWyRMJebFznjl7q7azdqgDds4a1vdvo0=;
 b=Ek+3A5g34+Hby2vHQK5PDLqMttvJ3qCgF5mast34Q+GxMYJKuMwvD0ZwEFNvwTarVQ
 nxq7Keevl8hAU1c+TvqDa6B0ezMD6kJ28uDEcBQJTMYyxYscka6MCZqRaaqz/Arwjolh
 iLvxQIEee0D11xfQmr2NtPzmB3w99RgBciv8hGQJkMEudUDb+LJTEtTZBbFxA8xxt/9G
 +7lPID9bLW/3Mtj99heXAv0Fa8EVipHUGLy92OJg4hHzhoBO7j6CDKvZElyM3dSYk5xs
 ydCaW/eq7B0xkPewk5caKgB0pUazIrGsxw3WfRheWlscJPUwFHw8SQR8lbyu3sdGVtc6
 iWdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N1WsaZiMyCoDkhrb6226caYeNbVSU6B7d7eQut2oN+Uj3HwUDfiQwdH7xxLn/EUDqHQtZui+wzyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yypooh77BOVl4MjeUGwLxDv9PNnlL9lpjLJhaAasWRm0TWvCbpt
 yDVRcKJxXOGFRNh7/v/kRNuypu4ti84OZ/djc96XAwb7HhO24/goNz5tbEwvGjcVTTXDejlkBzZ
 El5u5wb0Uxt6CaNWRt2xcMxByRY6gqxCz//LkyA74SWpjuBu05+G8n5Xt2C6lAEXKzVDH3Ek=
X-Gm-Gg: AeBDietTMHupsmMlUO3OlSWCDblEXxMUSZAwn/lxXdp4yJeTkntN/B9Bv3EjpYX5LnN
 776L1q1pETVXN7QRPfSR+vr8c4sn8YzghEcuQLyEc5O4D9N71dcKR1XoQvJRj/7clisaFTvSnh1
 9VW/Nv+7w0RkdymSXH4kvTDN48MPALW5WTjp6kg1Hl/yQyLB3jwCTXTCpk4h4a2W54RKRMupZyF
 kNdFbjmnLiPME6q5rCDNNMqMBA1wE4WT2Pgl8+WJ7eDr8s2KVDyd+vwS4M61LW1Fk6NG6puQu6F
 cAgWnKTXr/N+2fk354WDIqKQxcjrhEeO/JMQGJ1KHaj0U1rc9J0/XlOWBDT98os7+Y5CbNompiV
 TxYi1nnFN/l02Soj7zbUEoJJJXMvIMgn/MkJKljUcyoiVP67f+c9spKf87IMi/pcQRTAe4jj9bd
 KQd0363f23ADqXySaESQaHQG1k1Je9TsJbgQr2pW54fjzIlw==
X-Received: by 2002:a05:6808:d54:b0:467:237e:ba47 with SMTP id
 5614622812f47-4799c870d9bmr10161286b6e.1.1776787715775; 
 Tue, 21 Apr 2026 09:08:35 -0700 (PDT)
X-Received: by 2002:a05:6808:d54:b0:467:237e:ba47 with SMTP id
 5614622812f47-4799c870d9bmr10161245b6e.1.1776787715259; 
 Tue, 21 Apr 2026 09:08:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc672sm3869507e87.34.2026.04.21.09.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:08:32 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:08:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 0/6] drm/msm: fbdev: Use client buffers
Message-ID: <pcbuciyme6uh7hmduzzykuyacwelope6or5durvddzwfandtvb@wfjyexsjra5x>
References: <20260421125733.209568-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125733.209568-1-tzimmermann@suse.de>
X-Authority-Analysis: v=2.4 cv=Vq8Txe2n c=1 sm=1 tr=0 ts=69e7a104 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=oMqSzAFODtequhd9pCgA:9
 a=CjuIK1q_8ugA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: m9ND153Cq-VpxFmr1J6RHooJHy26nOFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MCBTYWx0ZWRfX1XJzAdWj/1kJ
 qjJv3TxHRU/o1CPK0y3ssJOSw9jpU+1vgEu1bYGiY7ZMBy5Hnp5GWDfkrEPi7oAfnhaBU03LNSD
 3kIxK4leD8TjOil+rdpqet6ZvU5o+hLboMxXZozALL1DT1ajuY4Nbn2U7aIgKp006GP/G1ZLNmT
 AVnrUBQxzZyDaZ/yUM0SmHLoYjCueOxT9+pB4PB4rveK7jwnrdMa25RFlbi5fsHJXTojFfs7FHF
 ehczgLmWb06BaBLPETwur/h9jdcIE+AcsF4jPc56nFvYjSnAQszI60eL6icw/ZxHXRXmN0OdPje
 SGZ4cae7FGJXrcZSprky2pJoyWp69qtiVTUOYefuIuVSQNZPi+JlHxGiwbZrGTn97B8ZcZW85YH
 kgHOCmankvtZgvuT3TDHvFQWeFPcYaVOmTyLdYjqjOc5dIDi8IMHVV1P+6/CijwU8dyK2e3yJTd
 Wa/kUXeIPZs1J/jNLPQ==
X-Proofpoint-ORIG-GUID: m9ND153Cq-VpxFmr1J6RHooJHy26nOFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210160
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

On Tue, Apr 21, 2026 at 02:51:13PM +0200, Thomas Zimmermann wrote:
> A client buffer holds the DRM framebuffer for an in-kernel DRM
> client. Until now, msm created an internal ad-hoc framebuffer for
> its fbdev emulation, while by-passing the regular interfaces used by
> user-space compositors.

I assume this was somewhat because we supported using the stolen memory
for FB. Support for it has been dropped when we moved to GPUVM.

Rob, would it be possible to get it back at some point?

Thomas, would the series prevent us from using the stolen memory for FB?

> 
> Convert msm's fbdev emulation to use client buffers. Replacing the
> existing code with a client buffer allows for stream-lining msm code
> and later also the fbdev helpers. The new framebuffer will be registered
> against the client's file and will support handles for GEM objects. It
> is then just another framebuffer within the DRM ecosystem.
> 
> Patches 1 and 6 change visibility of msm_framebuffer_init() during the
> refactoring. It is the easiest way to refactor the fbdev probe helper.
> 
> Patch 2 and 3 inline the fb allocation code into the fbdev-probe helper
> and fix it up a bit.
> 
> From there patches 4 and 5 convert fbdev buffer allocation to common
> DRM helpes and client buffers.
> 
> If all fbdev emulation helpers can be converted to client buffers, the
> emulation's whole framebuffer handling could possibly be moved into
> shared helpers.
> 
> Thomas Zimmermann (6):
>   drm/msm: Do not declare msm_framebuffer_init() as static
>   drm/msm: fbdev: Inline msm_alloc_stolen_fb()
>   drm/msm: fbdev: Fix error reporting
>   drm/msm: fbdev: Calculate buffer geometry with format helpers
>   drm/msm: fbdev: Use a DRM client buffer
>   drm/msm: Make msm_framebuffer_init() an internal interface again
> 
>  drivers/gpu/drm/msm/msm_drv.h   |  9 ---
>  drivers/gpu/drm/msm/msm_fb.c    | 98 +++++++++------------------------
>  drivers/gpu/drm/msm/msm_fbdev.c | 85 +++++++++++++++++++---------
>  3 files changed, 85 insertions(+), 107 deletions(-)
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
