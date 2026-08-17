Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3E6C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F98E10E7FA;
	Mon, 17 Aug 2026 14:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+ZoEklJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iPKkHiDL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B56310E7F7
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:13:42 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HD61Nh2329809
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VgQVHsT19L5HSw7LtJPGoHYvBVum+1zO+UvRrJRep48=; b=o+ZoEklJksEw/ncN
 m1jTfs3bIKwuuaz1OMVfbhk4qYzCNquZtq6rH+QF3FKYLwGBk/XUs7hsdxTmp6ZL
 nVMT+VgqjkpkT5JTr9cNv0ucLoAxTLPJ7ADukQCm9riwyN6iDDb/DvZPqIPAtVug
 Qiwr1spnQHsuRby5r2G3MrtTRNqIHFmtqPXmUDTXaX62Vjs3AXlpWP/nMGw2ionP
 DZ40dbr4vrFWv+gdDj42AIcwFN7ozF4oplv906j4j4ue7iGrMViXQOrzSWlqydsR
 Xgk5Iz3/MQsTeVOwdV0RWyDUPb5j7EH6/PpkavDld2I7oB+SF4SFrwcdjXMHkSxh
 3qo+wA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3vght0ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:13:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-73761f92dd1so48190137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786976021; x=1787580821;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VgQVHsT19L5HSw7LtJPGoHYvBVum+1zO+UvRrJRep48=;
 b=iPKkHiDLGaeZXj+mXJvKsuxQOT4VBtiN1yJl0jZHjs5m46bYxApn/+2DM5hPFNhkHl
 K7ET3OBoUcBZYg2/yGkgOQXslfTJYSzQewSIcXMm2a74wAO1CsAYCKiP+fKutZ13LxRz
 t3pSZrTYeFP5iKTEMIhbt5ICFpF06k+1YI40EjKG/QtOlHhbouqNTS9X+koI+68mCMHg
 l7PJn+bUTmv/rPJ/MeE7+6vQbYvCu5/cVn4BSD7RcWvPhrdfX/uYJDnCGBetGvsXGHiM
 t4eeoqYAz/CQOudrBtuUF5SpeNWhufYztVTmPnpz73PyKbGf14p4MxEJQgQ6LuEoL0H7
 E1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976021; x=1787580821;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VgQVHsT19L5HSw7LtJPGoHYvBVum+1zO+UvRrJRep48=;
 b=dJWD1elSs9UzUtfmc6EA5R21e63Iw5+bD33swhSiy4aHmuqhnEyLBidM4owdmPAhuE
 H9rQ9pNBM0Duq6IMOtUDt7Iv3zdvSJy6sN0f9yePSoC712lcLtgQYlxK++YDelXptcFl
 b5Q1aoW03KRmk/ZcdaLJTp8L1LOPVth4qP6nRAUexH0rqE/kpTaIVEtavDF0YcwkSQ8A
 XMAFxUWPRS4MrYVut0CK2lRknsupFsRBi3J/uSPJYpixCCsxv5ryNuvcHPZkrJzHNKXP
 6RCMitA/awLdB++VfyQoDmpbtV4OF1WJ33HU94oKLgvEJtJa6mErwazUNiZXY6kdlH6n
 qvDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro11cqdjfBwNGUMKot8Vfx0/jrnc3rTQ2t1voaxxcATtNb8J4UQzgivrhJMqgUze4/EKM3GldOmbWU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU+wjcCd0Dy/UyRCRdaW1oimCGbAFac6jznrvfpXLrNb3+RrNL
 gtOhN3OVOBT/oMRFCiC7LqeOkRKihjAnJUN0U8KFH4WRKj4ZoyZ4KWXsgqjC2TjdOVQtAozsvXe
 8tFLN8PpvhnPUtBd1fhGdiRUKgc/j4x+0pEUcZewz36JWnhy5xCLFwUgJIpnC9qBhXUeay2g=
X-Gm-Gg: AR+sD10SFce/oZcfu4ztGzdc6PAsrwo/Jp1eczv0aukD7JbPTpWiMZFJxFeFR/Vu0Ix
 OlrfYsxpUnGj0uYUuo5bdGHSdZxGimq103VnHBQp/eThnnff9f5vrW/6JCkN2+CwIpoBGN3/5u3
 dTObkH1Kwbj7eZQawkMvMU/fi17qf2n/Sb2hqTGfEvv0hOGK1crSX+FyhEQF7eW5d5RbHfJhTPg
 4eIF7Kk4tkSZYpc/SQmpljIX7YQqUDajqvEOSKVWx6a+/FM2u73d2qYOcgdGwZ+VvHt7B9zH8bU
 LLHOo/zOC9kpiOeCnji+kEJq8prh+naHUtlEG8kuJwGMMifIT3UwFVBa03OtJpW5jMLbmvnJqhM
 AYPYlMcA5R+RdU8+uzx5O2XYX
X-Received: by 2002:a05:6102:6a85:b0:739:de1e:6c28 with SMTP id
 ada2fe7eead31-76f281993fbmr1995152137.0.1786976020676; 
 Mon, 17 Aug 2026 07:13:40 -0700 (PDT)
X-Received: by 2002:a05:6102:6a85:b0:739:de1e:6c28 with SMTP id
 ada2fe7eead31-76f281993fbmr1995147137.0.1786976020212; 
 Mon, 17 Aug 2026 07:13:40 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2185b97aacsm34235666b.44.2026.08.17.07.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 07:13:39 -0700 (PDT)
Message-ID: <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a831715 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=sndJhVXln6Iqe1BNRX4A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwOSBTYWx0ZWRfX5OP7dEWYMLiR
 6VsSqebWannqwrEmEAmNlkvqLlGFBJcezH+IjyTuxW/N3bkJ5TuI72IJ90qMYuCa0bIsMdZC3B7
 7HCKH24smPHfHE3PU6bpmgEFtV2GFtw=
X-Proofpoint-ORIG-GUID: l0YU0fJSdkJVcyH3QnlrCtmWq8Aibtai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwOSBTYWx0ZWRfX4sZcBzjuTDV3
 AmzYEe9PcttyYUBAOWEfFshh6+h8MalmkVaF5UvyEyebQFO17shiPlKTxIcW/hmWAgrgiRHpNOd
 xsGWk/QJhu8CNN23nfhH8JKqR+jS/TMyZHpoMAyJm+bX6P5pr2lvG1xIpZljwHWZjrBEbhl8GW9
 dj25niB8HxTCkoimPa8KI2zp/AzgtQdO9JzOzWRQhMTa54qo60lXDR4w2IkkbnVyQhHdvlO+0lA
 uLzcLkN98K1ql8VZFE4/Oz8HL8W4wpEJruakvvcvQkMTV6Dox9oqPKYhM1yZfv3NWVANBVmZK+4
 omn1uOdDg8WBXU6iMvx1x11bpmTTo/6yGxmwCJoge0iYPehDwDOnbgJmvmZQsG14Hdy4d3eqQVG
 Tsnrs5UGHJskgko3+rUWY22GbVMZ23WkF9iNsrm+mBo3F79Fd07fE4uOXUe59si4VrEGE0eMrWs
 pWZI1yVts6WnP/K35wg==
X-Proofpoint-GUID: l0YU0fJSdkJVcyH3QnlrCtmWq8Aibtai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170109
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

On 8/13/26 9:44 AM, Yongxing Mou wrote:
> 
> 
> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>> powers a subset of SSPP blocks.
>>
>> Can they operate independently? Does INT2_GDSC need to be
>> powered on after CORE_GDSC?
>>
> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.

Is the MDSS any useful if *only* INT2_GDSC is enabled? Can the INT2_GDSC
be enabled itself if CORE_GDSC is off?

Konrad
