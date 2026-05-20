Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2E7CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BA510E05A;
	Wed, 20 May 2026 09:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObNQ5JYZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="km2P/rgM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7127F10EFD3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:51:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7Vs8j1636919
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=siatBOpPGw8rmWP4DIvno1Qr
 OxtlNfljAn3wDT8xX+0=; b=ObNQ5JYZc6ABlb6q/uDOe29sBQPntIPPFKxVtkBM
 AFJMsShGm2Wim4aUNLA+hsVTL/zDM+EKidNrj4e32BjcHuWwdxrgNPoCVi7fzgG3
 QplqR5NjaAowYcKAx+jUqL6v5nI3aGW2+bsW+6V1s4Ml3ro+FXYqXrgDgh5xbZ9Y
 Mp0d4KHA33U/nCZZvG8lScyENkzQSDtFlVWuh/VPEPGquGO1MFy6lPUEdUQRnJ5J
 smMA4Oo2a/mJhkO/ql0/1lI+9ya53XDUzqpQ04F/khEz3CR4CJ+nJdKyaiQo6zor
 7DLi5kpzEFYBHt0v4m6pwMtXeoR4CJt3y4zhcp7ge86fLQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sc0te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:51:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fbc70cfbdso139200431cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779270688; x=1779875488;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=siatBOpPGw8rmWP4DIvno1QrOxtlNfljAn3wDT8xX+0=;
 b=km2P/rgMKc16eipSFslCyQPL8wliU7GfMyc0GM5GjD9qbjss64OD34jxuG25ObxkCL
 51IT4dHbmIWxGFoK0QdEsR3XgdtbUmebZsMOSNNBhhwtOufwntCGv8HmMqtdQSy8VbgO
 HdmjgwAkBu0hcMwVlLAM1l9rARmpZQhd3KD/XOlO3TQw9XS0QSU65yvCRcSwlyJAR9G7
 WyDIFmnf32DUhfORF5uOtUZgvTe6/UwotlkLNAPpn7bOR9nS+HbUT4PmJTfjGQvpSe47
 C/vl3g6Q/5wMbP+oH/mQrnuuI75nAIK2k9oPouMvLp2uJci2NiAjoa2+zcVnln21vr/A
 mw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779270688; x=1779875488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=siatBOpPGw8rmWP4DIvno1QrOxtlNfljAn3wDT8xX+0=;
 b=lUPt4J5cadt9fjFmDIy7kMSul6WaUK4gSHZM34ZH1/MqS7OGOgN066NBI/nuSAWgmJ
 YQeaMqEONuSlmRkGiQfC6C4qXg1UiLLUjlEFwrrDZ1v3kJHd5sFIz5LE4+VnaWohuhz4
 8lr1+pWNVFF15EYK/gruB1w/MmVHlVFeEbx0KGGoG8/NrUTcrpRLT2AjxeGSgzgwDAk/
 Xmy5rt/fJUSDOEevDFUnyzCkifI9SOP09DUKQterMaKCnYy1/HP6rZox/W2tHYwvdUO3
 hI0GqLK3ZpKeL3+6mahJaEHEl1LoMGxmfMpUalgQfYSWyBe+lstNfQCPPYqxkaylj/uQ
 nrew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+iYYtObwe8iHddU/XzMnghON7Qo1ajp8lDVVhxzGAMuAYTewQ0/kl1SLjMzww3xkYVoSst4ffIWA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGSBqg9wQzTuNiv/Gla6jyER+35DJdde2s3R4GW9qr0C5jhEUw
 oOBgUSetoosE7F7mC4oT/CckO9SymrW2r7SNisjiFRZ/TuYE4TCkO1JLauA+QppD+HtW7/fgN50
 Lam9eYobeKk6/uUwClPDwKK1LSTL6DAvt63U5pehlqkAIm3AlHHt/TaCXrzPAv7pFAFv32Ks=
X-Gm-Gg: Acq92OEXgpcbzyvanxaaiPecQDBwhXCQ0+u+FxyQE/NC/utTJa4wiJDM5ZafzRP3x9l
 a4jtQ6Pu/8D2UTc/d4A+nzNz/0fgXj1tS2q5CUjDI1F/iFwWJCXSZeQCegqMGlw9YYtMBaeXRFG
 nd1Mzpucocgc4qy+KVzza8wpmlnaG4hVthDZMg/29aJZzlNaVtLHoGGb8IsvMYQ9Di8No0ylCaP
 sA4jJlWFfudWEZqnTTYUalltxz+wH1teTJx1UQrG29qGGbzbBlH+CiH1rfmzTAkCcKaRydIQhew
 8NT+FIvFJ+DbNRv1/wGp95ZbSb9dKRh7TVewAmLYi220fte3D8HOKF/IP5WXnxhtSJez9lVT2Lq
 uun3YLoxl20hdaWy6z0O/BruHG33ekg1NVfNT0d2eYAg3GZfogjJJC7c6TYDHB+HqHjY+DOGI3/
 gDgIRT5bqpx8rojMrUXVSCDZCeit8TF0WaJQY=
X-Received: by 2002:a05:622a:8596:b0:50f:b9e6:e056 with SMTP id
 d75a77b69052e-5165a1e6733mr260905131cf.29.1779270688059; 
 Wed, 20 May 2026 02:51:28 -0700 (PDT)
X-Received: by 2002:a05:622a:8596:b0:50f:b9e6:e056 with SMTP id
 d75a77b69052e-5165a1e6733mr260904851cf.29.1779270687637; 
 Wed, 20 May 2026 02:51:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958828151esm27360061fa.3.2026.05.20.02.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:51:26 -0700 (PDT)
Date: Wed, 20 May 2026 12:51:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Brian Masney <bmasney@redhat.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 8/8] drm/msm/hdmi: Use the common TMDS char rate
 constants in 8998 PHY
Message-ID: <leidzvcfcchnapcqstv3p4xscqvkbhjikyrjupndg4on3nvkpd@xsgpai44xrhh>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-9-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519144712.1418302-9-javierm@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5NCBTYWx0ZWRfX0eCvUKHpCMn5
 yVBiODV5RUxtjgSgFjHlG9Z4owkfxQ3ZxRgt/AGiT8txyokpLxkp1/c0mE5LFbGPyFUtH3/aCFI
 QcI7j+pL38kBW/v8YMnteZMq5IEN8zEtE8tjwkUtgCRvI0JOopQkDK6ei4Oz1NphVgiYXeBAwts
 ih60yEUZwdZ7Cw7vcy4Z4kzoZVuX5so7Ov9BWdzaJ1HSDij0d9Guv2rdyTRnnXZam8T2IswLTw3
 Jt1+FIWueIUTpP0GAcfjQLhErPzWmZFZ56pfZeDPxKaNunEykjE4Gn1lEPkxA9h3mgvCeNO9YKQ
 qdkBW7ngyRc2MO4xKJhBD/qOVORCg97CZ/HE4EdYaMNprUMyBQU0NF+QtaNgZylooTX2FXDDzPB
 VAtKaDXova2gtRIfwS2rtB0fmG0/ngJzUE/2I6GCi8vfRLg9TRSO7mYyuGk+mHPUl3HtcIPDR/H
 4JZ5zqYjqzFYPJfiXwg==
X-Authority-Analysis: v=2.4 cv=Oc6oyBTY c=1 sm=1 tr=0 ts=6a0d8420 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ZqDtBnPIfa8uGWz8rTwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: daB7hhPdhH54h6M0Xsh4gmrJ4CsQXPIZ
X-Proofpoint-ORIG-GUID: daB7hhPdhH54h6M0Xsh4gmrJ4CsQXPIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200094
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

On Tue, May 19, 2026 at 04:47:04PM +0200, Javier Martinez Canillas wrote:
> Replace the driver local defines, for the minimum and maximum TMDS char
> rates, with shared constants defined in <drm/display/drm_hdmi_helper.h>.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
