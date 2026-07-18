Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094E4C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25BD510E117;
	Sat, 18 Jul 2026 18:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OPe5zs5+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZSvOjPt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE7F10E117
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:16:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGOjZM1179356
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tCNRVTRkp/G6AntkwvDscMObFkyZh4fS2lMKxSwqpm4=; b=OPe5zs5+pTUkQtnJ
 MynoCpHFquH225osLPTuLNdd7c4UDs9VsLgOQLa+C6aIstNdSUQcl/sXSepeEhpK
 UAq30piwryTlIEe2AIf59DLlsKr0K4LVcCs7JF1mbkY/ui30FeJXQtVReabViqRJ
 Vn1FVlpEm4rb8XetTnhNsVyYLDx0g80+3jbzE+Fv7dwKNtRs42eUaxTIbIMd1scB
 O8usezDnmh98mPQqQDSgxhVvbtSDod7MKCXY8HojVjYaHkKenxZlEpHASMfjNU82
 4eTmKgjDqFcZjGsiJ5J9KaQaGpaeFc97MeAf7Td7hO5wQEfc+Xu4mPqOsIwTUQT3
 ac1MQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc1b4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:16:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso79782495ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784398598; x=1785003398;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tCNRVTRkp/G6AntkwvDscMObFkyZh4fS2lMKxSwqpm4=;
 b=LZSvOjPtXJBU8fzsWzhG7fEkVyKshHEyt5+ev29Hwua/FTwfMIfs3HJbrMZfj5eUsz
 fzweE+5eKWqSkFdaA4CftGAqz4/qZkdVeEEXuBqrIDAIBdUVc/HsR1dMOYter9H03foq
 eHrzIBq1PqQ8gWAxsWoIwRKZTi585Jqt8A9GpwlOfG2zGmTwWj8LJrj/nQlXUbjbnz8U
 y/zptwv+X7ShyNxC3l4oF91LpuBjTl75g+2Wu9JFxEVtHb0Eto3uEnxD7ICQABmbssJx
 V+cHVzm+tXkWuWvdijVCXBQt9+/ZiasvJ3Wp4Y1qIWTSZd8hywpOKIR6uaW6WZHxI/Sp
 CZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784398598; x=1785003398;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tCNRVTRkp/G6AntkwvDscMObFkyZh4fS2lMKxSwqpm4=;
 b=rAccNPMPLSYNznRlmAJmiw1yX3Ps1B5Kwt3FUwNsZ3hTZGKPSArcMeaCyks+VeA0hE
 b3bJC2e88IgcS440vgJBRechfa/pIe5tyOGzToqiGD2y/SzSoT/MO9ofnFON7DBh7ZbU
 w5CarHc/6H+6/g16Em0NjY94wobZLvs0jomG/T9W+DBzS0k7WkhAnlxgpDiLIBHfcSsb
 yLvZKoE15Hk8HFLyM0M/1wFlHs/+1Bk1mYu+0ZjNoY1U1NkXiK0TGGWbT+6yKYPNxwd0
 E2L1OF6IlAJyvqArUujiA4z2C7NvS5gX3LFGV9h8O7hDGG/Fgfp/mpLq81oZ5g9C1/5W
 8dxg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6YwsfPB6maeefbolKxszSb0TByEgIi9itMcd5WEbYIPjsQHhUuocLlybM1cfgKcDHm7ZDlkUmrAw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2bIRkah37CYyBqgJwV3eWpEYlteKuQ8Xe6+X7iqzT76iRjdst
 gLFPAtx5mDN2HfRW1KMSTYDCuWInngcpzqHFELuwvyjRMR5ZW49NjkEAe19f0Rt+8VAODMi3Lnn
 yKhLHqQix4raZc2Q4SmRBC87HNiGv0ibbFGz1yNtWOkMj6tgwHcKQJR7TLmx3VoaGALKeeJ2qeT
 cvLNCc+Vcj
X-Gm-Gg: AfdE7ckAdA45k1Ldsa5E4iJ9+3OY1+uf475NrAw/RMRE9OL0BcKmxYfxb4DAN+3wKLN
 dy4kYxEK9WLXMVn1B9t90Oeqr0y6a3bjg+pNhJOQ8i2iLeD+Ri1Rc0N9tORJ7lG+yLEiIBseiRz
 ho4A0jIckYY8Yev8LwV5lFKlTiZiwlZRhIDVE6pBbvdavs06F+K/BexVM+y8C7kBNC6+3VeXdkD
 aksIhQKH9KSTXsN1f6DvnRd3rChHHMiJcEer2xn9UDl5A4GtCahyuZZKGFh1KXK2uGwb28aOWqE
 9TaQxeZPyCxCXehPVNRmn1nG3gZTZLN/gD9nQwSVpQg6wZhT9QViDqxl3ySC9xlvsjK4yd9Y9W+
 9rC0ABw==
X-Received: by 2002:a17:90b:520d:b0:380:534f:58c2 with SMTP id
 98e67ed59e1d1-38e4b59bd1amr7780801a91.30.1784398597660; 
 Sat, 18 Jul 2026 11:16:37 -0700 (PDT)
X-Received: by 2002:a17:90b:520d:b0:380:534f:58c2 with SMTP id
 98e67ed59e1d1-38e4b59bd1amr7780778a91.30.1784398597223; 
 Sat, 18 Jul 2026 11:16:37 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cd6e6esm16268841c88.13.2026.07.18.11.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 11:16:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 02:16:32 +0800
Message-Id: <DK1WICQ7ML3R.302LNW6ENFBSP@oss.qualcomm.com>
Cc: <Frank.Li@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <imx@lists.linux.dev>
Subject: Re: [PATCH v2 6/8] drm/repaper: replace struct
 drm_simple_display_pipe with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-6-1133a8fc3785@oss.qualcomm.com>
 <20260716092142.355731F000E9@smtp.kernel.org>
In-Reply-To: <20260716092142.355731F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE5MCBTYWx0ZWRfX3tc2hqIAsTtq
 rvk0IIhPOKCzC1UpelKOrul8AnHWiIHoyrTE7vL30qckwqY6v6i11LYXw48GdTWUHQqD8FkxC6l
 b9olYXt311HWrfX3I9bJ1v4idF+gw5o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE5MCBTYWx0ZWRfXxX1ChgmSk6Io
 clKkx5CUknZjMTI/Yl29+xM4q5fWHMGrCl5uFO/XGs86YtaEDM5XfCqZbDefUVdvxZvLlqDNjb1
 oorpyc8O8tAfyHLLRzQxiGPbZPaauPwfUsUaSNZzCP3Qx3Co85vBE00WqgYLocrL+rCWn/Xgsay
 3LKtFzyMya7M86r5E1pSg2LFw15K95iXVaAz9WPdUcyBthu/ET/elCAZHe2/AazwgNiC4QavPdv
 8x1IqYPgt9pHyLLnFEuNp1OIQ5tbCzQRdaJ8lvoJ2eJKsx4tjSn188WBseNiV8qPnr70eLLUWyw
 uWNpa5Um9U1V6VdtNGoT6HcUKnqEyU13Su2KXBV6zMAERGwEGmtH4NaPzK0sQwC1QYBAz34nXYs
 fB1c0tWEa7NXAj/+/lFeDqD8X0dJBRvUL5CYf37v/lvyVNDt2Y3uv6kdA6DVzQGO4rTPR70SoBC
 JPblkeHuWGEF9lTNF0Q==
X-Proofpoint-ORIG-GUID: sXqnKnaOR1SCSoGqOwZ-6mWeQ_AHabxy
X-Proofpoint-GUID: sXqnKnaOR1SCSoGqOwZ-6mWeQ_AHabxy
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5bc307 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wfJsz4XN5BKgQ9I0DyMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180190
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

On Thu Jul 16, 2026 at 5:21 PM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Missing CRTC active check in the plane's atomic_update callback =
causes the driver to send SPI framebuffer updates to a powered-off display =
panel.
>
> Pre-existing issues:
> - [High] The CRTC atomic enable/disable and plane atomic update callbacks=
 execute sleeping functions and allocate memory with GFP_KERNEL, which is f=
orbidden in atomic context.
> --
>
> --- Patch [6]: [PATCH v2 6/8] drm/repaper: replace struct drm_simple_disp=
lay_pipe with regular atomic helpers ---
> commit 3d9748839d37276a557c720301a5a848296e54b7
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/repaper: replace struct drm_simple_display_pipe with regular atomic h=
elpers
>    =20
> Convert repaper to explicit primary plane, CRTC and encoder objects.
> Keep shadow-plane helpers, framebuffer access handling and no-scaling
> plane-state validation from simple-KMS path.
>
>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repap=
er.c
>> index c8270591afc7f..7057075161c4d 100644
>> --- a/drivers/gpu/drm/tiny/repaper.c
>> +++ b/drivers/gpu/drm/tiny/repaper.c
>
> [ ... ]
>
>> -static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
>> -				struct drm_crtc_state *crtc_state,
>> -				struct drm_plane_state *plane_state)
>> +static void repaper_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					      struct drm_atomic_commit *commit)
>>  {
>> -	struct repaper_epd *epd =3D drm_to_epd(pipe->crtc.dev);
>> +	struct repaper_epd *epd =3D drm_to_epd(crtc->dev);
>
> [Severity: High]
> This is a pre-existing issue, but do the CRTC atomic enable/disable and p=
lane
> atomic update callbacks execute sleeping functions in atomic context?
>
> The DRM subsystem explicitly forbids sleeping in CRTC enable/disable and =
plane
> update callbacks. However:
> - repaper_crtc_helper_atomic_enable() calls usleep_range()
> - repaper_crtc_helper_atomic_disable() calls msleep()
> - repaper_plane_helper_atomic_update() calls repaper_fb_dirty(), which
>   allocates memory using GFP_KERNEL
>
> Since these operations are now wired directly to the standard atomic help=
ers
> which run in atomic context (for example, during non-blocking commits), c=
an
> this cause system instability or deadlocks?
>

I think it is a false positive.

>
> [ ... ]
>
>> -static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
>> -				struct drm_plane_state *old_state)
>> +static void repaper_plane_helper_atomic_update(struct drm_plane *plane,
>> +					       struct drm_atomic_commit *commit)
>>  {
>> -	struct drm_plane_state *state =3D pipe->plane.state;
>> -	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pl=
ane_state(state);
>> +	struct drm_plane_state *old_pstate =3D drm_atomic_get_old_plane_state(=
commit, plane);
>> +	struct drm_plane_state *pstate =3D drm_atomic_get_new_plane_state(comm=
it, plane);
>> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pl=
ane_state(pstate);
>>  	struct drm_rect rect;
>> =20
>> -	if (!pipe->crtc.state->active)
>> +	if (!pstate->fb)
>>  		return;
>> =20
>> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>> -		repaper_fb_dirty(state->fb, shadow_plane_state->data,
>> +	if (drm_atomic_helper_damage_merged(old_pstate, pstate, &rect))
>> +		repaper_fb_dirty(pstate->fb, shadow_plane_state->data,
>>  				 &shadow_plane_state->fmtcnv_state);
>
> [Severity: High]
> Can this cause the driver to send SPI framebuffer updates to a powered-of=
f
> display panel?
>
> The previous code checked !pipe->crtc.state->active here to ensure we
> do not update inactive displays. During a DPMS OFF request,
> drm_atomic_helper_commit_modeset_disables() runs first and disables the
> panel by calling repaper_crtc_helper_atomic_disable().=20
>
> Next, drm_atomic_helper_commit_planes() will still call this update
> function because active_only is not set by default and pstate->visible
> can remain true.
>
> Without the crtc_state->active check, doesn't this result in writing data
> to dead hardware via repaper_fb_dirty(), potentially causing SPI timeouts
> or driver hangs?
>

OK, I'll restore crtc state check here.

>>  }
>
> [ ... ]

