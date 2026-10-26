Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EB606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eORX3JeG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y6kZgXKJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E89E10ED14;
	Mon, 26 Oct 2026 09:26:48 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8405510ED0E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:26:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aUuE1708687
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jzEc9HqqeJ0Y72eXS6b2HTt5hh2dAgU7hXsaabSdUAc=; b=eORX3JeGKnCXHjc/
 T2mIhqF3pOOqpR9pZG3y4dGgQ8/I6cfuUi2jqYLVFdt7P8fHsYYDmOSi3Hl56c/m
 v2Q+hSmIUDrVD9SwcrBN9DBnVbkMAuBJ70+hbLY+sIOVq2B2xJk7kGKBXd0N0ueE
 1TFiWzxICwLe5XLq7gtz9/y63WNyAoq+gzJFqK3ixen49JSUAGsPEKV1YmBT4fiw
 v3lKL8O4hjjLrTBMNAM9mOpfl2CkYHnqNFoLgNXburCcLwa3Az2NicJw7LJKMEnf
 2YEhmjTw+bJ9TVASN8Y0lAD+qw0Nq2hYT+YoXKq11pyiiD9D5dLQkOSZhUoDz+cs
 NVCZ8w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd9rkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:26:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-536540909e5so12482991cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006795; x=1793611595;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jzEc9HqqeJ0Y72eXS6b2HTt5hh2dAgU7hXsaabSdUAc=;
 b=Y6kZgXKJbyygVvTHrs4T6qE6rKXSYpbZcKuEwofzcrMGbkhZT6kJUs5D4P0En+OteV
 uhxZHE95DOVuOEVmLijlwSqDB4PuCgTNcqFtOwpK6FapT+7P1UeZDbPfkOrUkOOZOZDF
 8jgY7Knb/x3/OgubA3//jiAXKF9tI8EqPy+XoQ7UwVb8ez878GAv2VVIwIC6pzErlCJ4
 dAZohz2M4O0WseDIIwycDhfvd3VLAz/s/bsP7aaywPppLgyt/PLhWI1BSX5go23vHqe9
 5kKC0JHcAtfhAtP1pMWqPv4xR2Qayt7XauRMlt0L7CM5ZbsKEfPBLzu854Z1jrJM/MBM
 VeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006795; x=1793611595;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jzEc9HqqeJ0Y72eXS6b2HTt5hh2dAgU7hXsaabSdUAc=;
 b=zvG04Bg0atb8foTc3bnW8niYszyiGDaSHnfy0L+3pG6nOStESKb7dljrjD89U01/vA
 RMwyJ9sueiRJZHPjC1Jg3LM61/jDOqX/ZOjCgBpd+iHDZzWkt+92SATN3M5vMVlylrXx
 VVdQ6S1kmlFgHvg5aNcYanMvZamtZt6LDNsa8DXb9ZMMbz0H84FyreD1S7B5IS+QdMy9
 xZsyKD9on5xByghpHMgdjh2oq2Jc5uZcbgU88Kb552SvxWpC7rgVXSbJedmxIHD9g3kv
 m5kYRWb8jrTJkK2Ud/8qNSTaaL/KcpW+fGdl3kjnLazelK8d5ZU/373zz7pwjdWGCExO
 jHmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVQ27CfElLUePGXod/fqwT3b8WhmSoA9NZb2Ps+2tuG9nfuevMSi6ucs9BXF+SAWlVDYZ3/tgsmp4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKvLd6NPvftd8fVmThf+oVozA+TEgY58jWtobxyx8nJ1we8SFOL
 Q5y0dKHl87onCcz+HgTqvlC7HctkQ7k2wngUfZNPIOYQ0JNv4+kCmpVkSrFFlbFJpSdighwiFB0
 R+SIkzFbDrZ66J+2JkOvHyVIIg0K3GJ79UmPeHwpvG08x9un+A1HDn48Ta3XS22a3nDbhKVY=
X-Gm-Gg: AYBFou3jwzEB9JSlYqjRy6mau0lsZnkxx1fD6VzvFh2/Amlh3zDBvR7y0drYuQwYe0W
 2St7fb67NpcIQKH2WICRkcdUS8PsoG+uW+YY0zV7hPwdZjqd5QbCV3Cnm5D9OOhzfnQ0JN9P2en
 5NEJluIQVx1gm5gnZg8B4JKSja254Zc4xSF/Wk+d3vvxQxMdTQnEZ49foFzPuBcZY/MKqLivNjZ
 C/5ZvdiLCLOi0l5QxoVcN3X3m9LzoNzKzlMWdk+QgsS5fa3+fASfgf/KuXrLCb3kawZTPjcd6ke
 PMpM/uWE6pQzs6w0aYLHZLiN6I+81/dRtZKoq6jZU2TBBoxOUSXwWCSdhrq5k3OJMebHjPU51yq
 BWEdP0FlRi/v+xxIuJIGoag==
X-Received: by 2002:a05:622a:e088:10b0:533:6948:3d2b with SMTP id
 d75a77b69052e-5383b3c5463mr93659001cf.1.1793006794805; 
 Mon, 26 Oct 2026 02:26:34 -0700 (PDT)
X-Received: by 2002:a05:622a:e088:10b0:533:6948:3d2b with SMTP id
 d75a77b69052e-5383b3c5463mr93658671cf.1.1793006794302; 
 Mon, 26 Oct 2026 02:26:34 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd5206dasm299771366b.33.2026.10.26.02.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:26:33 -0700 (PDT)
Message-ID: <19d36d36-cb90-444b-b3ac-d3247db852b3@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:26:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] drm/msm: unwind msm_drm_kms_init() on failure
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-3-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-3-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BKZvIKiioN5ppKU9VLfT3GwxnfDzI3dI
X-Proofpoint-GUID: BKZvIKiioN5ppKU9VLfT3GwxnfDzI3dI
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf1ccb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=86llG-C12mwX39I2B_IA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX1ZCPxfTLTQub
 CjojqwmPNfagdam2Tgh9UirWgtHATznJMWPLD/Dy/V9nviUGIYHENCZPPct8Q8dCEio5/V175oX
 tZooJwy0974jnq6ygeVTCFGWcF/vWFM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX6t8Piy6KKXYC
 JBuW357nLiXU5+s2nCKh2dCXzn40sXgDh2ppz0EZrhdfTVSsWqLkPVH14Arp6s8m3dn9mwmjexz
 0VaEZ6UwiKsUwx1/gLh3MzW/xF8A2iKmy34j5tEW4oeIpZ/pivUkfpfZbJKplOcjrHZPig2FBUV
 JGm1yTzuaIuTrTjbd8w3eRc6LgHtY6FZZWIDLmLmE9dWjPH4bgLP0DaHx4ri0G+AxtVB6aTDgEL
 VgjIZP/7nh0FUvWbtq+cKX+0yAL2tEicJdfeZLifd/srSOeBeWJfwDnpGa5ZdnZeGYzA/eO5J4L
 3ttDmbLWepppYFR5K5oCLH2cCfKeYe/gWDvA+r585k30kn+o17KPLn15ByJSfs0I94xUFZx/FVl
 28o/F3POUmDlRVyzgJFdcOFINtK/Fw+YsT7eYpOpxTHl6oThZq0FkxvPE1xppKNtFiQ++7LLwwe
 Bg3a2K29F4wxpeXrcmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260037
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> msm_drm_kms_init() leaves behind whatever it has already set up when it
> fails and lets the caller sort it out: msm_drm_init() jumps to
> msm_drm_uninit(), which runs msm_drm_kms_uninit() for every device which
> has a kms.  That is the teardown of a fully initialised KMS -- it flushes
> kms->wq, calls ->irq_uninstall() and frees the IRQ, none of which exist
> yet when the failure happened early.
> 
> The kms driver's own init is the first step which can fail, and since
> commit a409b78fcdf7 ("drm/msm: move wq handling to KMS code") the
> workqueue is created by msm_kms_init() rather than by msm_drm_init(), so a
> failure there leaves a NULL kms->wq for flush_workqueue().
> 
> Undo the steps which have completed instead, and let msm_drm_init() unwind
> its own error paths rather than calling the full teardown.

I *really* want us to get `impl Drop` soon...

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
