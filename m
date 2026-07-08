Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C30C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A3C10E5FB;
	Wed,  8 Jul 2026 14:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9PTuMVs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HNUc5g76";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D4A10E5FB
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 14:46:51 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668D7uAV2678274
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 14:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vL4MQZJyYnOZgb+t9Slt97jlU8ZMhiBcIG4lPhLxhqk=; b=l9PTuMVsLQ/lb5E7
 FUy+YKYjhfuxGpV2yPYrT8cW990iscK3mTQzOIF8tGq/IN0UGqjuAyycToz5zcmp
 b5J5Ef65ekAr1pBRTSoIVmVaCAilH9sfGD3P2WGPIs887lWUsiNiEKklxBPgWTzc
 dEcSjBxCFMfjZgSkE9LOnrD5tnmd4F1z/y65PGB1QpI4IiFBzBbHqeO8mC3y1SyT
 VijYEMNHVsbO8/EMtiW5eEhFMLHRcUpvXEZ5J4PAOgvLKXcYGSY8gNO9U3ScfM0r
 JhbjreFoT0InUzIWIFkZZMGSEQ76sA922nbzv2otnraPB1TKtoPir2rkT9lzt6gG
 mmmXMA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5s8f32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 14:46:51 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-448d61d82e8so360852fac.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783522010; x=1784126810;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vL4MQZJyYnOZgb+t9Slt97jlU8ZMhiBcIG4lPhLxhqk=;
 b=HNUc5g7680iZXzjodGu6WAnJiCrp9dWF6+a0HFzAQUL9hTOeBoSHnG8zljDCJBrpdF
 D3Dr814sE2dkrPYXv3M+KzoNGXPPz9MFphsuL/nq61mREMjiFCFt7H5WYlZs7WoN3+o4
 u8qP8OMY9FvmR9hZ0Vu8oszhQxQvtCFlFUffGCB+85+eX4i2OMlBixaI2zycrxo+sxku
 UZtVRKNLwKW/okFrVqUzuGUZHP/mAqqnguwhV25d+dOO7NnxCTW4ME4SiTqRLTXfECoa
 NftddJz8PkcWFCPwUbPOh3mlBOChRHXS6YnsAloc873gsPCEuPFXTc0s+4AbRoMuA2Po
 i1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522010; x=1784126810;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vL4MQZJyYnOZgb+t9Slt97jlU8ZMhiBcIG4lPhLxhqk=;
 b=iSnWwIGAvPgrQ1VtAz5jv+eCWkkyapJ/LbmQgZffBPZquGvlFl12YxIPFTwXe/sF7H
 cuzeVQFJsoTX4LpBxO9/yo4fr7mFvwaJSSUFOlktwKMUTxApxd/VyWiY9HyZwU9FdcHr
 XUFbHKXH+RDa5ETZ4OqfPOwINolLrBFEHCIoQXvNj7AQvyZnt+Karf5S9k7EriUEZ3WR
 nJLRe4ym2K2YAJzdNydw9rqBuK8woDmFoY7WcckUDwyY5qLQnFGhmombzbWSGsKAY+St
 7lLq6LkG9hrEOLWUD97cxbgJFcufqpOCNKf3ujNovP4szd4Lmv4f+AWAeZWdkEW8cB7B
 b8KQ==
X-Gm-Message-State: AOJu0YwSKX4qV1xKcqZgKW2Qde61jSzgnc2H/QY7rxcSrT8sCnkoVRb3
 g0KXRlC7o8s4mSfaVCiRUJ3XvqSduqVQD63R5S1dxJ1W4xDEYPR2tlZlmVwlDJWjEMf0up4keWl
 b2cFUGvlauZrOarJecLjNmKjsxTFvzsejLJgdAsk4h5kQDKKCF6Zp1KpHBsvhrPlSrEPaQDU=
X-Gm-Gg: AfdE7cl/w2aJZ+s9VLVc46KuU0h1pZJgLOevhEWFDlo/tAymSJDDTiiDUgO6lL7/sjV
 /7xPsHZAvPcTyf+m2F1guEMjI+Z/BuDcJ+ANAV80qeRVAEog56j8SJsjGdl0iW1PkIeQzZsV/X2
 3JAYBWXAkxt+85HJXHml1OZY/xgruo7evnNWmnLRPG3wROmhRdOwpVSZZpTblA0AqHGeSyKY7+p
 5rVHUaO448KTLRSMmpKvwoK9V33K4dHVxYEcaSzduhp81Ar8bw7HwI6VS8n5uOefFuMejF0Uvpd
 drPefFugjfNhELpppiuxWn2j7A2nrfRjWcFghVzI6Ek0FjXy3KpkHWvjKGpDXp4it/J8zBSlfIN
 4vFwQ3nvBc+d93iM=
X-Received: by 2002:a05:6871:2ecf:b0:447:a321:35d with SMTP id
 586e51a60fabf-4516387345cmr1778997fac.10.1783522010279; 
 Wed, 08 Jul 2026 07:46:50 -0700 (PDT)
X-Received: by 2002:a05:6871:2ecf:b0:447:a321:35d with SMTP id
 586e51a60fabf-4516387345cmr1778984fac.10.1783522009770; 
 Wed, 08 Jul 2026 07:46:49 -0700 (PDT)
Received: from localhost ([151.243.38.149]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb13d619sm18125627fac.2.2026.07.08.07.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 07:46:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 22:46:30 +0800
Message-Id: <DJT9S3CQRB0P.982J925T9O4B@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 5/9] drm/pl111: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>, "Alexey Brodkin" <abrodkin@synopsys.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Stanley" <joel@jms.id.au>, "Andrew Jeffery"
 <andrew@codeconstruct.com.au>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Linus
 Walleij" <linusw@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Alex
 Lanzano" <lanzano.alex@gmail.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-5-b4e1ca053623@oss.qualcomm.com>
 <747ae980-9358-4e15-84e3-6e2f3e143423@suse.de>
In-Reply-To: <747ae980-9358-4e15-84e3-6e2f3e143423@suse.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfX/kBMCYvmBk8u
 AZwLatzkMlRBinVNVszCP106YAyI3atmDBZREoJ5ISg1/cfsO38e9ZiH2ibFJW3ozA2g0VUH2NJ
 du0l+9DN86CGqgUZmEiJqNHCMBEd6/rGA3k5lP5SfveTtkf/3OoRmcGyrWc3vEX+9tiLKIk0clj
 M5JoOhEk4GPyw45oxuMiTtSdggDGRCJle1HJ1sEq/Wzp12KKsvZ558zyR5TO53/JBSsCSMHiKfg
 fKZbPLVF1Uobla5jS7chr5/a5/s6V/yiYoYEnhYVV6NavOTgO2ymQ1Q3LoFw3rGs+jC0jlB8CTl
 Rm4DzP9fBA1xax1/KGZzzzEh4ga/dFIkedBs2vkoHgOx/WHllvCdfY8O5Q0rnAy4uc1I009X3XX
 guviM3M7UWbtu6fnJFyg/Kuxx6DBEs4kpX9seII4+To3X/1abTDOEMs7gI6Uu7JgajoAIp46loD
 dc7BRyVAiUeQYckcuvg==
X-Proofpoint-ORIG-GUID: ncDsRXNNBZbi9ldP8a6hiPsrL6gejeQe
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4e62db cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bxtzNzRwT3Q_vXoiTiMA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfX0VbF14OV5r7r
 0vg5qOX7guu/a0f563fNjPnF57qhiyobrDTk4l0pv3bYPI6z3wnrxFmhCClE/+bEEsBoMzgaPk8
 uVtLHDbokV399jR2pTlyIqS2Ki1B4gc=
X-Proofpoint-GUID: ncDsRXNNBZbi9ldP8a6hiPsrL6gejeQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080145
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

On Wed Jul 8, 2026 at 9:03 PM CST, Thomas Zimmermann wrote:
>
>
> Am 04.07.26 um 20:31 schrieb Ze Huang:
>> Replace PL111 simple display pipe with explicit plane, CRTC and encoder
>> objects.
>>
>> Keep existing hardware programming and vblank behavior, and install GEM
>> framebuffer prepare helper explicitly.
>>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/pl111/pl111_display.c | 174 ++++++++++++++++++++++++++=
--------
>>   drivers/gpu/drm/pl111/pl111_drm.h     |   5 +-
>>   drivers/gpu/drm/pl111/pl111_drv.c     |   3 +-
>>   3 files changed, 136 insertions(+), 46 deletions(-)
>>

[ ... ]

>> -static int pl111_display_check(struct drm_simple_display_pipe *pipe,
>> -			       struct drm_plane_state *pstate,
>> -			       struct drm_crtc_state *cstate)
>> +static int pl111_plane_helper_atomic_check(struct drm_plane *plane,
>> +					   struct drm_atomic_commit *state)
>>   {
>> -	const struct drm_display_mode *mode =3D &cstate->mode;
>> -	struct drm_framebuffer *old_fb =3D pipe->plane.state->fb;
>> +	struct drm_plane_state *pstate =3D drm_atomic_get_new_plane_state(stat=
e, plane);
>> +	struct drm_crtc *crtc =3D pstate->crtc;
>> +	struct drm_crtc_state *cstate;
>> +	const struct drm_display_mode *mode;
>> +	struct drm_framebuffer *old_fb =3D plane->state->fb;
>>   	struct drm_framebuffer *fb =3D pstate->fb;
>> +	int ret;
>> +
>> +	if (!crtc)
>> +		return 0;
>> +
>> +	cstate =3D drm_atomic_get_new_crtc_state(state, crtc);
>> +	if (!cstate)
>> +		return 0;
>> +
>> +	ret =3D drm_atomic_helper_check_plane_state(pstate, cstate,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  false, false);
>
> This is another case of _check_plane_state() running conditionally.
>

Acknowledged

>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!pstate->visible)
>> +		return 0;
>> +
>> +	mode =3D &cstate->mode;
>>  =20
>>   	if (mode->hdisplay % 16)
>>   		return -EINVAL;
>> @@ -117,16 +140,14 @@ static int pl111_display_check(struct drm_simple_d=
isplay_pipe *pipe,
>>   	return 0;
>>   }

[ ... ]
