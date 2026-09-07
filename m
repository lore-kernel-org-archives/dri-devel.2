Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68930C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953BA10E6AA;
	Mon,  7 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mGqvbNxu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TcBz49r/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5284E10E463
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:42:08 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68777LFi3363503
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 07:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 njlZCbPIISB3WKsBk7Jb6TXF4jvL8mDDC++k+1h911Y=; b=mGqvbNxu3XVIm+ju
 ZvWYo9o/QLbl7wOQ4TeVKhBhGHEgAjREC3zz4d8/6aP70WwlPMGC4IVNX1yxmXy4
 PWF/UuhSJldSkPtd/YmEpieT9f/LL096gXYIjPLVxXXgE5ffVXXp+fh7f26HwpCy
 pxDAXhFeox1C6FgpS94WC15zc2irgQ+AO1cioGCQoudpwVBTtrJ1pU1ALakhjqUJ
 l1w9zAUKXFaOe0C0o/33xhTBKNcbw+j20MRzhhyvrwGuu5I+7GW4yzLXGsiqUdNJ
 fhlPO4RV3Z4QVkWV0uooore9uyUmZDwRNIbClkztwNI1HhN35B4Quu5m4beIJSP+
 S0HB/w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj0u1j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 07:42:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93821883e26so58817985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788766927; x=1789371727;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=njlZCbPIISB3WKsBk7Jb6TXF4jvL8mDDC++k+1h911Y=;
 b=TcBz49r/x1XrgMWQGrj6p80VnDVeOMUKFoit5JAvOxHHhVGjUcQ78JPltwBVvkO3/U
 hN7xfUGVozU3dgP0DA/Mm/H3HBXASriLUmG0jfWnz4k/c03U9VUZNi/M233ScrY34Z0s
 5pjywUjVibpYTxqy/yIYoknRvOrdfPcgkLumUq7Sv/AZHHmYFlk+8gxX++wG2axoLmQq
 ibD+Ghs8VZdn/JkQtW7AcFFhuA7Ps7uWb0KayC8smM8tVGfjweEsRruNJ8zjsXx7zM/Y
 0wJ7fVpZQ8Hq4+UaFzu9qQe01GmS9VEumkc7/lfvz7uAlLKHIN/kUrG/3DvCwbxN//xE
 Y22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766927; x=1789371727;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=njlZCbPIISB3WKsBk7Jb6TXF4jvL8mDDC++k+1h911Y=;
 b=JDd4c91Nmgc3TV5Ns2sHUnkqVDoqjpqr3WMw0UlAExIUlqe0h1VRCOFKdfRVZddX1+
 HTjfS/saexrHVxuZDirsbqlMdEHjp2D5LxgdntS8zQmMKuFRecqVaDhqjuQf5OjhT8F6
 HRkT86ZUDB/35vgk4uc0NLkb2eHiyUU2lWImrr4zHoF6A0+yEM8VgkgaEkp2RoskUBaG
 RPd5Ocp26Nq4h7z87EWZYYCcvxIsrpFxT+dmvxcFDBEWcdECjDeNLREHCs0lgJML3uud
 Y12js4o1u/iIhtUibVHfxRyOsMNILkJkCnfMUENnpDK9lDQt622gvfBRI8dtg15FhVeI
 vo1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQx1kSEVPgqI2U9ppDMPzl7bdCbM31lA6/o9bSMxt7P/3Tw82pkuQ3grxOtj01oE3yh85hTsMDde0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l+7c3zBweq0Hcbe9Bk1a9k6tRbB28VRMpMcBJHAnUEhdjJYSeT
 MCBZZv5TrpJcfRj0MEW579kcmBJ5FN8TDKC7GvMBB1MNoGCnTyEUvv0TtfxU/QTvjzy6p0FW8IG
 L1hoiLQTBa8ZQNrltUvuMHLrNnXUO9XYah7XirdYLkjJsZyepEKggWChF8DukGs8BGiLiJOM=
X-Gm-Gg: AYBFou3FOPK4PQn/I0ohRIwD8KSvKzng6Gb7iLKxdNpCRFj2TEynQ5kJUuPkLhSa68O
 ao0hWRSglu49VCEY0tDT0OJHHFpK0GVIo99jBAvLPNJ4yVbTnK4loarujrCsaXL3dJd16VxOR17
 jgQcgT7uF21IZ8RZamTNjAdOp6bMmtV8PVW+DB//T9+m8+5xaBH1H7vBb5pxMkiCY1NrLugiZ0w
 sjsR0UdcnsXuVagmYvD67rYR6nglQBmYSSdIu6nbLrdxfKmB+nxvKjAh657lZcOOz+hi/qTVcVm
 /pP2jk75meSx9U3456TnYyWQ/HRb3yst4YdqflwKqIhRT04BeqsXhB8S2HS4gfpOexF/Knn4g1N
 kB5PByDsJ8tEbhCFS+WGx2w==
X-Received: by 2002:a05:620a:1723:b0:939:288a:8a30 with SMTP id
 af79cd13be357-93980cc6996mr1727370085a.6.1788766926640; 
 Mon, 07 Sep 2026 00:42:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1723:b0:939:288a:8a30 with SMTP id
 af79cd13be357-93980cc6996mr1727366785a.6.1788766926220; 
 Mon, 07 Sep 2026 00:42:06 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262ccca940sm266442166b.18.2026.09.07.00.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 00:42:05 -0700 (PDT)
Message-ID: <648cd3a6-653c-45f3-98c1-8608f599f941@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm: fix repeated words in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260904120601.18363-1-hemanth.selam@gmail.com>
 <20260904120601.18363-3-hemanth.selam@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260904120601.18363-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MiBTYWx0ZWRfXzo3lq7adwxOD
 +Wc3DGiOe7FffrzCECSk3amWEDcduhstD6AWgJ9GBshsmCXVRSpvB/00jT4aRmJL0goGRdAQiZs
 EClqMseezKf6ROr8y7jLvw7XHMTK8ud3QmF0nuUxVHBDN+OlFHwzhUc5EkAxztvn8su6zqx2fSQ
 /3QaS4+OyjKsWTWFPW5CgwVv1GiiEHu38S2GgyQt4RxNFuad6yWuwKv1EVYrHOojhc/pEp995Wf
 ivxEDLwQhezE8NQaE2btcXsoRL8GEu0+en2oIR+TW0tnWhddzqNd7AtgmCQG0x5FV8ZZiYEXz4G
 EYoqeHC3JwlZEJ7OfkGvx13NhpspKSvF7HkQcnHGPvbJcitKWM/6L1DZ6MFqjZv4OCZkFs48uCM
 HPbobNRw4BD3f5g5OGXZB53QyzZ2K5gNgVQAzpnezy3gVqoLUBjzFgDkEr8ysFdvsWS9sAfH6je
 G0l+Y/HAkQwbOEEOj3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MiBTYWx0ZWRfX0ttmqJpV5CZ9
 G1w6xOK1Mc6PKgQxRhRV3JsLovGX/FkKOt24tzFauB/nvfo1HStCIO0tgxmxkGFd7dokvtJ252F
 OAxU8GtPxP7pjuf+X073i43MW+1iwIQ=
X-Proofpoint-ORIG-GUID: TMVTP2JmSI6Z68X85WgAGE6H4Yn1PESA
X-Proofpoint-GUID: TMVTP2JmSI6Z68X85WgAGE6H4Yn1PESA
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9e6acf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=E85TfxCPf-EkNVdhPEkA:9 a=QEXdDO2ut3YA:10
 a=UzISIztuOb4A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070082
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

On 9/4/26 2:05 PM, Hemanth Selam wrote:
> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
