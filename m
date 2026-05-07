Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D414CD3446
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EB010E1B3;
	Thu,  7 May 2026 09:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0yWSjm1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iIeTNHLA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308FA10E1B3
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:33:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477pYYk1424511
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=p/Ho7py9MiPYxtx/jbI7IYgI
 F+TetToz+1Y6JO+q05E=; b=D0yWSjm1FIb2yCtVyIJqHqyBlfKYPqSMncPJUl5J
 DT/1ZQdKwzT83F+jmUygArnLKl7i8weSjrxUJX1bPUt/QJhvSbAPSzQVDrQpv0Qj
 q3W/fwvWLV3FFF5xtA5jVlp26tTu52k0hZFPTJa3q920j8PuM/BDwwXeg9rj8rrt
 umCO3qUtHXESu3ql1WySQ/2VZGFvkRwS4WyeqU41fLxaRppQYpySoSgcmC64zntb
 qo9GmZKvLal2rHjf3mk8C0Los29D6nfRmFat2mN+QiEKrosXdG7JbQYDFwr2xH8a
 lz9ke0/ZWrK9XR7yGNsZOSOTHkdGhq+MVzxd3NyI9WOJXA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfrdeh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:33:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514551d5f2aso4488641cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778146391; x=1778751191;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p/Ho7py9MiPYxtx/jbI7IYgIF+TetToz+1Y6JO+q05E=;
 b=iIeTNHLAnaM2bFs6WoXaf9ACImeVMMMPBiRB3iIlf35l2V5LlQIUdxxNuHpr9k9wa2
 NqA+URKaJksklTRTHIGDuQZhUxeSUIn45OWLGL4vkhZhKfMdz7IdkAAQtsCsYFaznKN5
 XjLYybrrPqXFRdNJKV75gDilxTqzdNe5RRCkPYNEfKxNpwHFTz52JxZFiq0c+A+31GTw
 oRfGI0oBkjNtLAUyOpN1BCtwwL2Kth322/PfvnEqZxvb8XCOtiXgy5WnCC+/ngxbrGkf
 AkRs2lrxs7Kt/25+uzSqPLTzk0T9euMsrzw1z0MRp692OK05lwnk44Rj8StoCbgoV/ud
 54EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146391; x=1778751191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/Ho7py9MiPYxtx/jbI7IYgIF+TetToz+1Y6JO+q05E=;
 b=eKvfrCbc9sXggZs/0RfxS4HLPk6tqrA3JTXjUbJ0bTqRpk7QGyMOcezGxnmMUIGrfN
 FFB5e7nM+5hyqS2dB3ShPaXE+IWM912sSguKzOkEpjlnYpthd4rvVvyOjCEGtlHZUg+a
 eqCVyuO0VMyIraUG5x51Ouc0pTBDbapBiLBWCnSrnirNoCB1zkWG1iTfO/pMfEF4tPOi
 WqplvdIYTA6SmdahfD6RFw6c/1dtD30ptk+dWk6uX/RSpxIh/YwYGz4xX69aGt8jqAHF
 iERwAp/FZSLXn4ZRgzJOaGzW3XQuE+aQrU8gquI9OUVPy/pBuP7I6UjpJMoJCrhBTdsV
 mBPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JNfsUzUV/MKjaOCHnFSLOB7sUE1ad+2ZiKBoWYDOzkIvAF9FiTaftz7ee9pvwq0+Ir1RBy2dugdo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgCkJRJfu2MXfTLj1L6H9FYnVv5Wwvekj3hsCskrc7HO2BK2dj
 ofh/qnTgTlgfqDJ2+P35VCjAqRgpoE8mN85qR2WysY88pS4fsLQY/Rq3G9GehXgp25Nj5WH1wZz
 iLHFySKz4dC3rp+ZbbYpJ3DM2lkyg5LUUMxx0r5vPyN3cCPNATkOgdv2I4pJr9YIU4skywXE=
X-Gm-Gg: AeBDievnnz93VkJGFMSvu8nt5vohVZ2/8dnq/j0A/hmLYjSOJYD4kChJIbXt0Um67dC
 UmhiVgeL73FSHHDeCY1OTN2ANB/7bMPIV2NIwJxjqEHsZE7rwYlWZWeBBZ0KRSigP2yd4AzGoIL
 4ZDUqTRfOAQeeTPxz/5JWQE895Ig29fcgdjo+9hazFd53i3n4RwYYqQt03Fmgj059lfLLvRSXti
 oxxP02aYFxyn4UoMInHEqDsJQq4/meuUKm7cwyWQsIFp2P7h2CR6L5rPIfMrUsxDwRPStzYDU+v
 0BX4oHPQY/2obyl4xmGlJgHofMmRF7C2JxejbYDxLKT8/LWaOt4A2f6nBfRg6buZ8Hc4qnatvgB
 R5Pb0XCWyELRbUJRbzWqKC2UcM4RrivyCyvrNGMzBXMwsfQseeCdlk3xzyU9TnGkcqBC9yl7JN0
 3BmKkXx5tBVg0C7x7PpUQHIuGPYflZiOBPRkHRtmn0yYtPMQ==
X-Received: by 2002:ac8:7f8e:0:b0:50d:912c:c2cb with SMTP id
 d75a77b69052e-51461fccdb3mr96615471cf.42.1778146390478; 
 Thu, 07 May 2026 02:33:10 -0700 (PDT)
X-Received: by 2002:ac8:7f8e:0:b0:50d:912c:c2cb with SMTP id
 d75a77b69052e-51461fccdb3mr96615181cf.42.1778146390049; 
 Thu, 07 May 2026 02:33:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a86cd8fce5sm4125177e87.41.2026.05.07.02.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:33:08 -0700 (PDT)
Date: Thu, 7 May 2026 12:33:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v3 2/2] drm: verisilicon: add support for cursor planes
Message-ID: <pxpebdkn2sdoksifdwszc3lleesus3xvtx4n67iozbpdgnprla@4xfkmqyk5vjg>
References: <20260506175610.2542888-1-zhengxingda@iscas.ac.cn>
 <20260506175610.2542888-3-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506175610.2542888-3-zhengxingda@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc5c57 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=8tcSQ5PN2yeH2YuI0mUA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5NCBTYWx0ZWRfX1sHVtOQIkq/5
 8jGHJ+0JfSlFD/CSVEu1zcg7euQmRu7J6OTcJsjeln2mZhLMNQ1zlijHmyxlCpb56g+7CaXsfUo
 5zvq428VwHJxOPVc56ECYkAJIF69nJY9/twnMZU1zIfyfpCYGXJElTN6tIyQE6X9hU+BLZrAUEy
 HZZhOKXlGIuVH48z3JzEPgzcaZPgQnoZX/L2MNQM/Rl6bKaPpIhdF4WFvbP7ybYQ1X1/mwoBLF+
 uROx/4B9mGIUBr0OwlV62lPyk5m7Y9x1gLxQBDDr5MO6+HCKW3byGb/2I+qT44+BrfQZxNzR3Dq
 M9idncuiw5c9BWBcJtgxjqutqF/RdZisgR27Jt6Tq5D2GAWISSk7xPkzU+1NZgS8UGbrXY6C7BH
 rrK86OYctphacUBOrmuwnPixm22oBTuCPbCZa0qQSpLb0B7b02/FhB/+YqcmdeacKT+2SlabcHi
 3stnl8TQ5+0h+avG/zw==
X-Proofpoint-GUID: lyTyE-XJMyojMgqdOQdDVjPTzPIr6F7s
X-Proofpoint-ORIG-GUID: lyTyE-XJMyojMgqdOQdDVjPTzPIr6F7s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070094
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

On Thu, May 07, 2026 at 01:56:10AM +0800, Icenowy Zheng wrote:
> Verisilicon display controllers support hardware cursors per output
> port.
> 
> Add support for them as cursor planes.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
> Changes in v3:
> - Moved the validity check for max_cursor_size to
>   vs_cursor_plane_init().
> - Removed NULL check for new_plane_state->fb because
>   drm_atomic_helper_check_plane_state() will set visibility to false in
>   such case.
> Changes in v2:
> - Use is_power_of_two instead of switch to validate cursor size.
> - Remove unneeded format check.
> - Skip the whole validity check if the plane is invisible (previously
>   it's only skipped when the plane is not bound to CRTC).
> - Explicitly set modifiers list (linear only).
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
