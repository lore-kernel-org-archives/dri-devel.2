Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32688E9A75D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9874B10E654;
	Tue, 24 Mar 2026 10:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h91XH7rc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kT3ER5bh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB7E10E0B0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:19:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O4k6FW1910825
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CKixAeLWoJLGVNQVekhuVvT5gS+Oyk19qzq72tM18NE=; b=h91XH7rcJHqPCAfu
 G+pY189rLDu1muW8+dnKCceVhZDdEi07XOOGUr4aoR9W0Fc2laZ/V4qaCoSE/yOY
 2XG34b+eEbouMjFVJT2zXsQA8whL2wSzULTlbPytNdFmI57Ps4P0gZ8w2SVJc23h
 3PErbHOGsLmKk1ef58AgMoSKremKyvATuUvvDQrtGAYZusbe12JG45TeFUdYKwi8
 X+CKLOzN3EcjEGVFGPOLd+3wZ2pnTTSKJZVxCG64nUCaBE7auuiqOivJqX/TGTTr
 GDwjpd7TMnC5bMU5f6BDQG7ECg7M+6nAqbFila2H6pimyRN7IovXyBcIbtXnDlSX
 3L0/vA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3awytxye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:19:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b2d15c360so40088551cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774347576; x=1774952376;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CKixAeLWoJLGVNQVekhuVvT5gS+Oyk19qzq72tM18NE=;
 b=kT3ER5bhOzX1ge2QaNAckzpXXBqzU8DuBvsw5FVlYBOCVTqVwzy1EZA/4h9W91wadG
 rkt4Nw3oJhv9hh8XL4pFaiqGFqGPUTus4SsJzFOQ0uyy7UMBVxAsi0JIB3drrIvUXkIn
 Ap8IN04IEmKDQG6fwb6dddgqidIcpFeNcljlQd9zLg3wZ10roGIm4/ChWbf0xoWAflYr
 Yoz7q7UyFLygUiziPW6xJOktY+TZqa3n2g66Hd42TF1v1uG0HIUWR2w7f5eYWZLL9jy1
 psdSWsZMF5zNEyzak2tNvX6yfiUb/Qp0+cVz36iozviji7HC2zJjsIVMpUi2uVmU0L5L
 MRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774347576; x=1774952376;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CKixAeLWoJLGVNQVekhuVvT5gS+Oyk19qzq72tM18NE=;
 b=IUNM/GQ2nN4sKqvIV8Xz+G3e560m/hthDbHCoTVhmJFB+eaWspiimVnfWn5iJIFJ7J
 mXk0V8vO3OSJ+O2nNDsssDiVDiofmOK0qK5SgTC4swsaiNXrAT10EOGwex12AM1wMSYv
 NEh/SVt/Hoylt3JxjT+pmRpLElv3xO8VgGkJ+hC7+R8obfYVE6WymBLNI6kss1GsZvOo
 wsHuF173rLoY3XCkIKYlrpBKX4WOSJvGzPjLXrS/6BlS672wp6+QXB7NOfYRAisDezQ3
 mBNT/2ro5OBuOCth+8qBSHmbiLxcalyDv8jbt/xTlZEZ0hXGH2E7G3JtKsDM1OgIkv4S
 11bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE8PksbaVBIzJj16BfryAE6ErnkC567JVUDyRLcgrv1g2QodH6zt4lRPnssudrc8cww/DLB3kC0do=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzthKjDiHZBpVATXaPJ2M8Gdw5KUEguhoRkT1yQvz+AUczPMvwr
 wHn08vN/zilncZMvvKUV+Njn2vEFe2d6zilyYBSPLmV6EjJGQy6Er5jAb3TR190fSMRuiao/tM8
 nGlHs+0qN0q2wwnnU13SnFI+HdkOlNcsfIoSDD7dJ4pIhULBuxqiGPtSGCYrRaQFLK4db6fk=
X-Gm-Gg: ATEYQzwan4KaVqTaYV5hM5SF02eKsE0km2J0eejRjQywED+NtC7JvaGeP/akSlYxoqh
 luo+knsBSue3D6EITQvkmLVVdOoRmrE0gDM7JV6/W93gXONQjx/IzeB1RRNCfACGCqytvqwpDyu
 vo3gqVG3bJnwRG1eK9HvlkIGjzG6cxkU+4xclOw7ZlOXMMeFPaVQD6uFhtsJlFJ/JZGd3jtG/6P
 vybHhp6eU+Zpi9KOWDjXkay9s3aIi6dHqEZtDcc4p3RwQMXjZ/DtD7zn3xVdB147i7+l4mog0VB
 7ULtDPBNTpsVlM4yPyqrJ8yqClKinqpuBRvDd8UmG+WA6UTqs+MoSbKj55Dt2hSCfGZq4H/9Lsj
 +lZRR87zWs/JZaTQonnck5XCj4dwqNcLTxbg90eqzACDBJBiF6XismCzv83Spbpl3ZJgOAoEl68
 fsOuc=
X-Received: by 2002:a05:6214:2b06:b0:89c:534b:735b with SMTP id
 6a1803df08f44-89c859c0a39mr169030196d6.2.1774347576280; 
 Tue, 24 Mar 2026 03:19:36 -0700 (PDT)
X-Received: by 2002:a05:6214:2b06:b0:89c:534b:735b with SMTP id
 6a1803df08f44-89c859c0a39mr169029816d6.2.1774347575872; 
 Tue, 24 Mar 2026 03:19:35 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8dff5sm614789466b.24.2026.03.24.03.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:19:33 -0700 (PDT)
Message-ID: <f6f63df8-8e7b-43e8-a6a7-b561cf1b95fe@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] drm/msm/adreno: Expose a PARAM to check AQE support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-16-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-16-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MiBTYWx0ZWRfXywSe9AGdJF5I
 A0XLsSbbDGr3f5EJKPv/khVV0p6lkbcfX0DhfYjcIn7MpM6oueUtBX5zuaFd4hV2/4OagaHZdc6
 /ed6Dr+aSyYXaweDEoHV4iP78Q8Am9f4+9BW5zYwbbmMgeVMv8Yq6d1tmpHnyeC0Z2PwAMvuD9U
 AiCMP4pMcv4WwaAL2Yoh669icSYlc7T67ykasXrymACXUlPzIH2+TOm2WA9sp7wcZFn3PzPa9gO
 ZHjVdO2buMYpFUat1ITBajNIajdDwITTpuYfhYliHFR6cNO14ZPSM5GYG+ILGBumNoaN4W62YIh
 mfIOgfzY6WSiCaZjc3vZSKJ9mZl20yTOG5U8QUtaViGuqBM9WNKYsqqR3jY1e3iLAYkNzQLI4qo
 4gH/2/RpXz6zRgEunrvWU5IfH5NMEpxWjEMc89mU4rCvJlila/tpDWQVN8bD3Q66bvSUaOkEMe7
 EK43O4wm9GE8GQEHXgg==
X-Proofpoint-ORIG-GUID: MUbFAxFD5YlWFQN_r5XFSZstgglPWnkw
X-Authority-Analysis: v=2.4 cv=KuhAGGWN c=1 sm=1 tr=0 ts=69c26539 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jFzL61rkNVMoSztU-kMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: MUbFAxFD5YlWFQN_r5XFSZstgglPWnkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240082
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

On 3/23/26 9:12 PM, Akhil P Oommen wrote:
> AQE (Applicaton Qrisc Engine) is required to support VK ray-pipeline. Two
> conditions should be met to use this HW:
>   1. AQE firmware should be loaded and programmed
>   2. Preemption support
> 
> Expose a new MSM_PARAM to allow userspace to query its support.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	case MSM_PARAM_AQE:
> +		*value =  (adreno_gpu->funcs->aqe_is_enabled &&
> +			   adreno_gpu->funcs->aqe_is_enabled(adreno_gpu)) ? 1 : 0;

&& already makes this a boolean

Konrad
