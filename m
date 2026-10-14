Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7119C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B62F10EAB4;
	Wed, 14 Oct 2026 18:26:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E612910EAB5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:25:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb0Os905380
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TB1/Jegp7O8Osv6GN5Wh68G0
 kr7B/W4uFPBOAA+1Plo=; b=fEXzjDtTQZUeI6x6Vi3b3Ncqd3XpJlfmG3PqbyxT
 GpglkFOVJPRBnAMm7S/yuvD5+I6FyQEbpx8lXp2Jk9o2hdSTUfrsi8vFov+ds9YT
 S9ewBPAAV6QuzYhuhFkz67PjZva3HIsNSPkAB2VCPSJ6fFrst82VPmtwHHjZEkdV
 mTjFoU21ESRrEzBEXPRoWE49kcuL2tn0AOVeUriGkxmj1UPj4KGRlHSsbpq5UlcS
 XKC1LhUhyWTl+bWwa1ZH6PlsfOXx45N9JFZCCuAblmUoGyxzzBliiR/PQlg/NkNs
 FzMt1AgU5OwfAMuQSSiI29QgEph6GpCD+32H7eskfYON8g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p316c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:25:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso149357585a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002354; x=1792607154;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TB1/Jegp7O8Osv6GN5Wh68G0kr7B/W4uFPBOAA+1Plo=;
 b=WQ7VAC9LkEfNrDYQxmitgP1Urb7ora2yJw4RA1HvaTylLX0Z+t+EqeUhNY8VnDse0f
 QW2AToO2tzTWllOVfbr59p1NvncXMqxHXlSzSy0EXOwwzAdFC/Q0WtdqXR3OQDEMMmLo
 A0fjDEp5M6n6LecM0MZ9ruaat7GQBJJahbjAj9zckBovIfkEsqq48+vLjE/lyS6SOQeI
 UAGPPE79fMOSzujff+4uajvrKHk6V8yBtQCFoXZZys5u5hOUCGidMhSunaJMt1dpwDSX
 Hf6Bucij2iRgk3bk+ci4tRI6UbE2sAGqZvxvS4qgT9oauodKpis3ej4iW5MJAPVxCEQ3
 t00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002354; x=1792607154;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TB1/Jegp7O8Osv6GN5Wh68G0kr7B/W4uFPBOAA+1Plo=;
 b=UqC52srxoAw3V7Sb48drbe/lL2dW4JhvC4Sbxtp+Vzb5iMve+CP6X9RWpG/1aTHJlm
 v8d6ZjrNyjvb8JqbDmn2wfoGx++/VDcVmO0RYRIto6Pb5xnUBoWPAJEBy/8Kf+QZp8AO
 bGW4bimXMMhU6Qd5m6KvirAtr7P4LIlClRdcEzg6cpkQ0VJZgGzL47COP3bSC0yfrMDr
 FzG30Kxv3GpzZFtx8s1mF6qFqRnc5JWohrf6P1eaUBPYnoxMssgqVXjFEqoUZKUGMVBj
 hEDJNjZk6xtkVJXleROSbTzRMKyFFQ45SM0n4EGi5AOSZEE27DwOSbIZ6urPJw0y5HKe
 pLTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuhzd90bPSFzPePPlFIJdAvZF6a71C/BOZGfCVP7ecseE988FX+hPnsDrjCaDRxi6l9CwQRe34Z1M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLsWzyqGoQKicfBgRVPqfyqlozNfAWpFKUuEsZXz7RjRtxAvirf
 rfKLacyX3Dz4I73ddGSBbUfkbcMcoYs+4m0QX9fDjSqPh2521QwUuch0rAqzpL4Nf/Zckx8B9h8
 IfPNcwT8AFoPs4x0ckzn4VFxdxlwltXUFY/6sEvcLYhkf3nikbflPqJWdSuYkdKTc9XURRRA=
X-Gm-Gg: AYBFou25wcK7ZL8ReBa5HBaK1V9+u33d9YuzwpZaCOfMy66UQ5tgWUz6CAV+qjyGm7N
 IKBUkqtmASQPu+8XZz9/CJAvMFBMdhKhR7NsH0ETJutMyY5kmSnkdQ5UNFck5bRv4Qt1k1biDe7
 Fj/ennRatfwLSUiXxWtZnTfdcdbEufxI15d6Btqcr8sNQGJeqEDdOewFjvOeTgviAQ1Hg/WTNwh
 J29ihWrPoQOswnRGlCc1+cbcd2hv1ZeQJIb0qNSRw6cILjzJUBUGJIGtFsYszJYLjm/vZ1w//Ta
 JIxdmxw1S0u6rSSXL42p1O9m9DMQtOIwa6dsVHK5hctohdrLHrc4ms+Imbo3xgSQ8Ntj6EBa0bm
 Rffx0N6Gvpb9o0MRCB1u1avzsfZk0l2nBm+chbqa/mjNHINvdhmScAKvmc8S2ZO+Zda+9pY3j5C
 lMllyS5jQlBCU4
X-Received: by 2002:a05:620a:648c:b0:93a:82a:71e5 with SMTP id
 af79cd13be357-93ebd22377bmr2680943385a.19.1792002353871; 
 Wed, 14 Oct 2026 11:25:53 -0700 (PDT)
X-Received: by 2002:a05:620a:648c:b0:93a:82a:71e5 with SMTP id
 af79cd13be357-93ebd22377bmr2680938385a.19.1792002353313; 
 Wed, 14 Oct 2026 11:25:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33c12bbesm815152e87.11.2026.10.14.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:52 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:25:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 30/75] drm/msm: dpu1: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <p2apwz6iujoeclp6k7trkwfnwmld2ikg375zdgdvj6m5tojc2p@juhdohkoy2ua>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-30-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-30-586c9c026823@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfXyi0AultKnH3h
 mzjbb8PduRCFABWxfHqAYs717bT4EV/kRdX8QcLHWNTD6f6DsWV39sSgTts1Id5UXQe70z7G9sa
 VH0MbTjbiPAQqCFacBnmWg43o7pEC9s=
X-Proofpoint-ORIG-GUID: cxtv1AHF5Gsjf5G2OISFT3HgFk9ghtbm
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfc932 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8
 a=uh-rAEkd9rr4pKaSMd0A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX+qc+NKOwMopU
 Gxo1dWmiKw3UbS5GT02Nn8564cUaN/Wc6nK+I6CeRRxOmQAALSF9JriLsDA/kph5GSu6O3a3z1u
 votowPAQ4DSGxdDi5ftaEP/hm79lCMqROj7kjSg5XLvS+RT1cfdCWnd8T7PxgSO57wIXRf6vShL
 oEEOuev9eyiGqkAcLC+O/lfrPtun8MmYlQvK5lah92WXoMPnImsGnyu3ThAhIVie5QksIWZe/qJ
 i/f/QZ4lFGba/1VNRlPck4v4hKu5diTgrcOSQIS1Yr19WKkOQKU/c+oiphkcLrn9jRoAYDF8PLc
 PalD3rwEOjH2LDqY3ql1IoPMSCdzJ9Kg9UcS3uuWOqlMxgX25USf9kla9bd0QEBzpFbdUWqxLOd
 PI4A8L2uQI35RrdQMnWOSNemkUelU8ZN4LSzQbmHCNb0M8puRitamvRtaQmA1w+4mOevHBaAiuw
 BWXhYkyS7L3eUHt1zXQ==
X-Proofpoint-GUID: cxtv1AHF5Gsjf5G2OISFT3HgFk9ghtbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140073
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

On Wed, Oct 14, 2026 at 07:26:53PM +0200, Maxime Ripard wrote:
> The msm: dpu1 connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
