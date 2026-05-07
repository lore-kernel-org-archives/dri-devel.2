Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6803FCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45D810E0F9;
	Thu,  7 May 2026 15:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LATo3EpI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EbG2VMuR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73DB10E25D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:59:41 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647C5cqw1971798
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 15:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gGu2wFTIajaPBghQ0FihXQpYUWio1degOPuerHJdNKs=; b=LATo3EpI9rT6o28r
 KCoPbI3+MQtZievPhb720w5ihgtyGXjJZKsB69pAmEbfuCcRR8V+7lLuUTZZo99q
 lsRjkZmMwSxGPNcNZb8QJ/h/bM/DGv4/26XhxIxFvf1mi4/ep/5/xDGhe5mEvxat
 WsF8q0rOfUc9eaY+UXkzfbdtSYhjXWwjoxcym5g0nQwIzuuQicoGDzONhVtndOjM
 Y89yNz6vhdtitpewPXX3ZiudNR1QY9rb3VGesJm6SNyeXWj+WLZJWPkb1IOTm5UY
 rNmIRkOEA2rszmMvaE5MHz84IG3o2832IOAIzTckyjRuOMLnzoyllHVlQo8HYrRW
 8uNfuA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej902k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 15:59:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba268cb5e6so12761585ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778169580; x=1778774380;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gGu2wFTIajaPBghQ0FihXQpYUWio1degOPuerHJdNKs=;
 b=EbG2VMuRZ5NRL6k72oGw89QrFbsgyFOtMsiuVHSGw0JyoG3oPYnKNakT4le8Zt74CB
 U3HJf5nx59bmAihKSCX/Kec4Kza9SADNMUrsJzC2Ord1U0alVcHaiGx6kXz1zVjM/p6v
 OG1G07dFDrJBDYVcAPGSKodCOqS+45KBXiqXxyBL8MbJHsAjrYejrBWQpaGmHyrIhM5m
 1sncfpE+E1uMl9Sxgh7D+rDUihyvda1yzmB5otBzb2atp4Q5vvG8TlQjTABKQSjNyLJ8
 eNcfmmhqWwT+rnhq7o+5Dl2Lc978uX4fh7sITFKq5GPqxd2xu599CR+xZbON7pKp2wa/
 GqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169580; x=1778774380;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gGu2wFTIajaPBghQ0FihXQpYUWio1degOPuerHJdNKs=;
 b=mPutZtiA8I2mmIwOQWiXgICbJIBFWISLWkwyLLRThOVuYQ1O2QWc0a5JElUcCQD2Ks
 +/DRkBBxYPUlT/c4gLHGh4q5tE2ry8CNaIqVx57CT7tWthDHxrguWELQ1qs5mvKKERCg
 tFJEMvsLDH4MPE0uSxVCpgq4tkPVkDZRSsajb34CKHr/CEcVOCIFseZll8E1boTYpjZa
 h9q7WTg/Ut0UXYphcmFWhNLIJ6omXW+odULwOlgmoU40/7aZbRnGyU9AsaHDgZNUs5PD
 1p+Q4RHb91lqboS33X7gtgjYSj8IxqExMtxjzNLEZ7NZKfZvVaZAaWn1+w07MyKlwlaW
 7+5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ksJd5ee3gx9fnDNbzIKqkXh3xPNbay+WUeIXx619o1YVIMMseg3JiKTl+ubU5dEl4+ttRNgrwIXk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywj22yV6BOMnz1RZ2SZ7KWOifjJtUBbhk8EzjWpjnA3dkz9iVab
 VlrNUBjizjnfoB78B0Y8UlCG5ywhBAUIygtSMLZEuJTHPTs0zcNTyTR7QpQSktZK4x5w45fT9ze
 mQn6grYJoXQukMhGYNxbfqgIGZ24aVruFbaKo7hPBVFSEE3anOl7UnTQMI69xsIjrlkxxI6I=
X-Gm-Gg: Acq92OFq+SMUlfzQZPSR0id24PVqqVrglnsdR6vn+VXT/qlvEszEgJ7UFsVrWIcNfE0
 qdBb1JwFyxVgJ1rKbMx4y4GVGz7oP1a5Qzn+WQDoMdl9Jz2PZET469nDGdLnov2DkJe7gLwThNH
 Rz60KZC2beT3ADbc2fUtf6vOFtjvIGvHGgvKH+bDbGtn8RGX6xKXCu44X7bNq+GdWRcLN5Gh69F
 +4mq71lto6YUz/ukhAt81xdw0k9uxLSJzUYJcZF1hgg81hZeufx7i0EC5A7cep0TuH8KUEe1gB5
 GVTUEFVdI64CIu2LXlrXgo7QL+VhdB60njXwY4wxyqq/f1fiiSzeiSfnVtjaC0JZvWF1SoOU+9C
 ofQlrzHKIEEH2hXoxhviyHc50H7nZfOSR1yx3X2DRP2gj1r/TG4cJrrw=
X-Received: by 2002:a17:903:38cd:b0:2ba:be5f:cabc with SMTP id
 d9443c01a7336-2babe5fcdd5mr36392265ad.32.1778169580376; 
 Thu, 07 May 2026 08:59:40 -0700 (PDT)
X-Received: by 2002:a17:903:38cd:b0:2ba:be5f:cabc with SMTP id
 d9443c01a7336-2babe5fcdd5mr36391845ad.32.1778169579854; 
 Thu, 07 May 2026 08:59:39 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bae7854891sm1194865ad.57.2026.05.07.08.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:59:39 -0700 (PDT)
Message-ID: <2efe667a-c3fa-45de-88fc-ecded1f34543@oss.qualcomm.com>
Date: Thu, 7 May 2026 21:29:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: display/msm: gpu: Document Adreno
 X2-185
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
 <20260501-glymur-gpu-dt-v2-1-2f128b5596bb@oss.qualcomm.com>
 <20260503-resourceful-walrus-of-bloom-3ec6f4@quoll>
 <1136c1e1-749d-455b-9176-5e71fc1fe18c@kernel.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1136c1e1-749d-455b-9176-5e71fc1fe18c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2MCBTYWx0ZWRfXzwYOgB37VQF9
 wxMWAmSabZWi0Qmf981iqdwhIAvkb4eTDc/w/Lsh279tFJBVXXBc/hXykGdhix2UaXhzSuXF7+z
 DInZohIAi1U+P6nsscSTPjX6bdC/SKDPSgvzbamILgyHg7cNcf9vPs7tiJSmMWcohHL9LCoRRdS
 JazX1aPcvoSKS1H7s344uUrAFbHvnVDVHPevrXTD3X99ZiQeZ8juy9Ah37q2ec+/T98ob8K3UOg
 pDBTbgsM8QMig82wpdI6VT3UWxWazL5kMWlbhCwDFBY0XNu6XK4Gf9L4GzbOd8vfVRCZmyOAUZy
 R5SjfbXm7J36IRtWeyob/HpUp0ES7qcxmrNUR1E7q6bGyvXHQphmf3NR5QULyEcLku7TzHx48Wq
 5nlS9C8TTxVMlB3CbcB6lVEL8+Y9xPi2HNUGWL7fDvdSOEmRryOHNOH3lRL6AnaE56V/TJmEaBM
 d80uIzYMvkkquZ+n6NA==
X-Proofpoint-GUID: nhQbWhfKiw-ktF74Mzw2xPE6C5Ub-MIK
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fcb6ed cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=i7vGOPbq9zpShFDyuUEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: nhQbWhfKiw-ktF74Mzw2xPE6C5Ub-MIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070160
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

On 5/3/2026 7:43 PM, Krzysztof Kozlowski wrote:
> On 03/05/2026 16:10, Krzysztof Kozlowski wrote:
>> On Fri, May 01, 2026 at 10:40:37PM +0530, Akhil P Oommen wrote:
>>> Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
>>> It features a new slice architecture with 4 slices, significantly higher
>>> bandwidth throughput compared to mobile counterparts, raytracing support,
>>> and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
>>> other improvements. Update the dt bindings documentation to describe this
>>> GPU.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> I was a bit too fast and did not notice that this is only one if out of
> two required. Where are the constraints for the rest of flexible properties?
> 

I will add a new entry under 'allOf' for Glymur to describe a constraint
for the 'reg' property.

-Akhil


> Best regards,
> Krzysztof

