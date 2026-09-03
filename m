Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FFBC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6220A10F506;
	Thu,  3 Sep 2026 14:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBK842fY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJ690U8B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476A210F506
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 14:40:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DANO01314598
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 14:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PgPqH75E2Evg/LBzbjzhxHEEsoKS9CNve/6QYZ72/hU=; b=dBK842fY8gNu9XDN
 zoQ/UYkuTkfbiLqEi4fBQCgGl9oyBZdCDJmCFcVDFZFjvnJRgMY9MPDQhoNDCwbZ
 y0mHOy/k4LNRG+bpWh5Df1Wb1ArEMLzE5G4brP2JMUWle0O8Rtgjdhs19Jdfesqg
 cDG8Oer+Vn53UWUFfedl77YW5MjCY7LOzVoIvj7Xkos6DqbkOI0j/TOqTGcwsXs+
 chGCtnybaWc+PM7RscvWvIspRJZLCQ7v03uOvljsvfCrHxSLyBHccf188DZwK+DA
 gExti/F1jJGJsFNp6vObuyiy+HUdCU13YOHDqYuaMxhhi3kNU80Xv1yVmTw4g6PN
 XbUPMA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdnct02-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 14:40:53 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7530aaa7212so113147137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788446452; x=1789051252;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PgPqH75E2Evg/LBzbjzhxHEEsoKS9CNve/6QYZ72/hU=;
 b=EJ690U8B86z3W3LiVqQOFfgu5vweIWAbHCY9Z/hYwq0wKJmQBR30rWszwSBnYQvvAI
 8gDABybwm7XZOHKfAYrEfhRtWxIKw8zBVLHvjt//RIV3e0YGG3ymrq2y8rP5sVfZBVK+
 V9puIsJe6xUOFHBV1istIjv2w3CG2RvsrF3Elk1d/CHC+VLgFqiQmVkW6lp7xEjAtwbn
 3vwPOsyt61vAi68PAwUUgQt+hDIHuL48w5z6k7oJn7Wmz7l4P7X4sZX/y/HGXVCbm+lO
 4LPi3HBhf6BGA7iQKBrHb8XxvFV506L2SySGcHfSrZl5D1IXSKKz4nLId/Igjv3138vu
 jNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446452; x=1789051252;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PgPqH75E2Evg/LBzbjzhxHEEsoKS9CNve/6QYZ72/hU=;
 b=hLe7uOOOuIXD/0dOvjGQ/TlvcnlKxRPdMhEYXNOjWemK3CERBifc4G1g5nDTfffu4Z
 P6ixqU3BcoeCGTqBRtCrBSOYuvoksjWcigsCt+GrEGdxWeVaReV2HAXalTeP3LXHURcf
 dlGa1uwFV3Of0cxzbAlx9Hj2r8HzRV6mH+TcMqnGnPssMPIONL3lJ3MXnkipek/8tLPj
 lQ/GbxVYaAU+d+huE+XQD52Atld3EGtZ2ALn/BHrqduUndUNCLRsE7fS/w/y3yvMAZWo
 3lImTygFHCEcXgE+BHukCNGbNLrTA+tFyZJDhdIgiXsQR2vnuS3OuSOm5Z4TtC5hoQNN
 oj/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvo9QBoW1IgMyS07hi+hdRmvB/X56DiQh65Symimds46bPtLM/pVHByRJ4XN+ZmHkCOWxpWKR5VQ4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k69WxCvtRld0ThULghYV9OwWS7UWycGhWwUH2ZEoCgvGIKh/OB
 slMWdyU7e/Em+4aX4QmvOBuY5ZxWWpdxpT0ah1SxHNwarZAz2iWD2seGQQ41eW597sNBJLJOniC
 XszV0Vvh6elLIEjTSRKmjiP+zE2hJDREHHN+qSt+SNT0OgRdm3qSSBwc8xO08YEFOD3Qxz54=
X-Gm-Gg: AYBFou3bOe0VMvCk6TN3VLRDjbaELl81OfpYFTgUVrhMu5LZCnkTQ/ny/QPzQf8fKoi
 fp6NXbL+2xI67GtvHra0yni06zNvqyJzDVP+3HsQAw00geNOEYGQCl37sOj0sBYqD2EfbL2l0W5
 0U87VPwEifQgCnTS+gKjdXyYd4xMYBZvQYboiRvol1mHBgmHcka/edO/B7EF9pcHSdj8Zh/Nl8/
 IyrhgVAVXvreBxK9sjSo0enGoxPF3+aji+3FAdlX472g5WAdoa56E0bUoOSz6TmOvIMd7pVirfX
 c+IdrVoinWWE6jeEae0WNVTGfQqxEpVqpOHDVBOaMCXUyQJ+CAyPUgjoNw3m1nrtVSJRoOMLdqh
 +YvuIufJ1fH+2UV22cIeSGg==
X-Received: by 2002:ac5:c84a:0:b0:5c7:d15b:5f2a with SMTP id
 71dfb90a1353d-5c7d2809352mr1626567e0c.2.1788446449938; 
 Thu, 03 Sep 2026 07:40:49 -0700 (PDT)
X-Received: by 2002:ac5:c84a:0:b0:5c7:d15b:5f2a with SMTP id
 71dfb90a1353d-5c7d2809352mr1626554e0c.2.1788446449511; 
 Thu, 03 Sep 2026 07:40:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a3705866acsm147251fa.18.2026.09.03.07.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 07:40:48 -0700 (PDT)
Message-ID: <a5d83aa4-7065-47c0-bbda-35063034b0d6@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 16:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: sophon@radxa.com, Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
 <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
 <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a9986f5 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=z2R-DqfiRA8ArFDFZ6YA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfX+N333lbZrdtj
 NSrCeRo/nhL1SVr+D8tb6QDmmmX0Rb7CPZdJTQFzpOCOzKqaJf+w2yNGh8rdoGcCUlGGDh6zGc2
 noxVJhJ9zufOU0z64WLwEB1nilIhS60=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfX/rXvri/HJX2g
 v16Vrr+2UOGB+IiZUHLy3ZcLbKf8s/gcE0i/uBNlUW2ecO9mfh9D8jQzf5dZJZz3HnAHcDsbxmu
 sPWAWXL3VT+m6UKq4wJWTw5Yx0j+v9EpCg4xhimhBhz1bxCg5cGUjxGpSNXo84SQEQy52HbrQ/9
 n2DhHF213HueG58WT3AlpX4c7vCh03JG9CW4aDtOGDf6bt0ftEyo81Pg3tQ2zL3yshTH83Mce43
 pbNGTYgWba99kBwDMepDfUHu9JEfQOjUTSBy+b8Gx/Yyn2Jy1B5BsSVC8aSBNxuW1w3sRsXG7fg
 23lNhz/wbTvvG3Mkjl6SgTZpgI9/31h+uk1TS2+1YWAJ4jXEor5axJlHr7jwzrNo2b9AzP2VmQF
 qlk0UYdYiIK2CvOAN/92XQs2XS2w2fiO0ZaOk1aH7tfJdGk5lkCBx/WjWsrJTFe1E+/XBbKUBJd
 2+zLR5i+ItX1e+/Le7Q==
X-Proofpoint-GUID: sTWR7NuVH3loJ3rpUYEIU3koAY6ok1po
X-Proofpoint-ORIG-GUID: sTWR7NuVH3loJ3rpUYEIU3koAY6ok1po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030127
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

On 9/2/26 11:31 AM, Xilin Wu wrote:
> On 9/2/2026 4:43 PM, Konrad Dybcio wrote:
>> On 9/1/26 10:47 AM, Xilin Wu wrote:
>>> The TC9563 PCI power-control driver powers off external downstream ports
>>> whose device tree nodes have status = "disabled".
>>>
>>> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
>>> powered-off port functions during PCI enumeration raises an Arm SError
>>> instead of returning an all-ones PCI error response. This prevents the
>>> board from completing boot.
>>
>> I agree with the premise of the patch, but I'd like to understand why
>> that happens - do you have any details?
> 
> Unfortunately, I don't have further details. The downstream kernel also includes a similar workaround, so I suspect it's related to how the TC9563 chip is designed.

I'm curious in why the port is still advertised on the bus if
the i2c interface writes some magic bits to "disable" it on the IC
side.. but perhaps that's just how that IC behaves and we can't
do anything about it?

Konrad
