Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F0606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VTI+T6L4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bKfXDl8t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D1D10E5F4;
	Wed, 28 Oct 2026 11:08:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C521610E5FE
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:08:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S8K8gX253377
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 apv/d7It0m52vyv2iaiTrqLt1NFywEuHxYM+YrQheps=; b=VTI+T6L4Z9CiZiQF
 rw+rxOjjh/WXgmJqhzDU0iNumlGEaKCjHx8hm/nyMgBV/SbIPdc3rfDPZvzwZYrg
 LBGKwxV/EvH6oCffX5UeZxrjy/XkE15aNiaERvUelJSKGfxz8/0Yw5rajqh22Uu9
 YIltgvVvJe8k0mh3NuxOJ0RrsSFh08oJEc3YvsX7UOZ+hobzEKSaERniKcDOncyX
 mEfBafKgGtDqkxrFVFze/76pP6sJxzWOhVwLXUSMMTJORi/TlvUHIM/OhZPOdmbw
 YKEXQhGcdNWWCiKhHbWD7hroVXp7UXicw3mKUiTXsMpAQBItoNRQ2sPbDLH+47Yh
 F11rPQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be24w8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:08:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a59717b0c0so808329b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793185721; x=1793790521;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=apv/d7It0m52vyv2iaiTrqLt1NFywEuHxYM+YrQheps=;
 b=bKfXDl8tj/BHqVsRKRs2QhShuPeczYPkHTSkYNTbo3tHjqsk8Pu2t1kmUYNSzTsvZO
 N3LvBGS1lngr0XcxiJeFm5MxtCJDkqrMnJ6rqq2fdEj2NxnjEnlAOfHCHE7uj8d/JRWv
 QHceTxtZ+a15SYiHrr2Ki5AfsmcuwUhhcYNwrL6yYTBP0oGRjZfIAG0SmS9KAhIhPmqy
 /I5c4393CUpOGeQtxod32PNxzb5DBr15zSO5yDc/CACfhcOJCBHFau/owJughcsI9bue
 YCfSRdNF0f+G8jLz59p7Yr1N9/iwmaExMj+tsJzTCbvfKYvcTyUuS14HhkohgbrcQObi
 o6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793185721; x=1793790521;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=apv/d7It0m52vyv2iaiTrqLt1NFywEuHxYM+YrQheps=;
 b=lw3FfamldaO9Qh235QvEhHxFRNAnREkw3mc+T5EjA3ppbVGEqzgFu9na09JyUX2kAg
 rCdGieSuSOUTxh/kl/CtaUYdJ2iFlo8yQJ6SM7hWotsjSno5q3fj/yq2d+pZENomky2p
 T706petJPbWDdycgkyJ3znsFH9+EdsA7mi0x5CQj5jxOPX+N6ibZBDyZ8Qrbsl9ijtXk
 wInCARvcUMmrzxVdyJSsK1IGkbqnSYlCKdLa/CxYONZQ+a56gu/TpcgqbbEJbUe+c4a6
 4ELcbfoNrzXQUWUJ2EKdNnCKn63wy6kCfyZBkqaETdicY5SlbdN2GTgspgrPzBTZIlIw
 rjbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBys28aZ6lzqAP32TLc1Y1EAPZxOf05GaHq0l8w/wpk+Jk56btZKlLiOWVpIeRMXiaI0p0nodc/YbBs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLdB3l9Yr7kWekUS+jePFzEKSm2MOFTv5qCJllfMs6XySnR69TI
 lmhD69DlJvuBwtY5fPi1Ymsa4UX+6QKHYij1F6AxQxmoATqut7l+4shOVgAt6PGIqmXBE4etq4a
 TRiwAhCHn/jXhRWbX81UnpyaRFctanzDJ4mcZ1aET6tpx1cZFjhqod/B9AGomsT9QyQ1cwkQ=
X-Gm-Gg: AYBFou1AJmDgtIOOqhlFulB+Kg4PdhEvBsyayCkTgv5kdxqTl5uq4OvYZVQ/fowfbds
 jql2urM7cwiO7UXmpLp/dLF87cm+85O4Ge/D57t9ZAGj/dY13BeMTdnjUXwoyxifGJhuc8PM8TB
 o/T+yXAPT+c2Ya8GzsM2tSu7lO4MecT49MLKTpXtK43ciQAQVMgqYZ+waHs29ZWkgNuzXgF0oA3
 FNtgrjLVoQqBFRn1gezmCb1HfNT+WmmIN3k5m5on3D8Q9d5/WzJet0hqBjCLogZyUSSSK5DbAUz
 fpwfqghpH3SmqWZJ+MGX2wIIdMRLYKx9zz8AxbpK1GM1fAUPYB62BeV6RaPAx2R/7I1VTzwefep
 qONvIDBpVSdYr30p+UCaThIA5yh79WTdfqbFzvXnCrgMeYXwLxCX5nlCF5YBFBlVqup7o5Qohbh
 nxsUQ14xV3Y276f/PrUz6clZR5jefCyVyMpwa+45lTj1GLhU/XEAz1vrpYkByLiQW1YsrBpRf91
 aSd
X-Received: by 2002:a05:6a21:46c4:b0:3e1:d43e:3675 with SMTP id
 adf61e73a8af0-3e9020e8011mr1722667637.2.1793185720656; 
 Wed, 28 Oct 2026 04:08:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:46c4:b0:3e1:d43e:3675 with SMTP id
 adf61e73a8af0-3e9020e8011mr1722630637.2.1793185720153; 
 Wed, 28 Oct 2026 04:08:40 -0700 (PDT)
Received: from [10.149.108.218]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a662e3a4sm1000512b3a.28.2026.10.28.04.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 04:08:39 -0700 (PDT)
Message-ID: <7b2ff0ec-74c8-472c-9ea4-1195bbf04e1a@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 16:38:30 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/msm/a8xx: Add Mahua GPU support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BAcp2MKQHciXlVe09QZbLcmaUidYJiHM
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae1d7b9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VMI7CB12i6EQ-IQ_HUsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfXxruD7vE7lMFW
 fUuk6LxuFC1qLSVha1Ktr5lBmFUVU5t4s2SkOdBIlRDG1Xui/rGMdUufSn6knyqs/jQHLoteAIF
 hDO9UdpShZXcVnldU/Lzt5GFMfWI2Es=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX0m8Kf7TSeWxB
 tMAmFDtEwjh+4llcknOxW99p4aa83sIcd+u099n1Z0HaWkNFsMwxohrPZq/f/QIOObqcFS/QX4f
 UprBGKxbLXBSAxgegZ5QHIipa3eO+ToVUT5l1Wh6n1Q4C/Ls4yxCN86g44XquYwEHcApN7i50hI
 CS0nmV39ckgI5g/dY6mD3IQbp4wkxnncgrUTS32268JTKdY65ChOwc6beHR0InxuJhLPIKvAHPJ
 aaBD8lNpXCV3/Ofb9zuiNZn8BAIqCBEvQDfkPP/A3VBpTruev/EdTIY+dk0Y3HMaCU+FJqmdNyX
 jXgdNb8bhXTHEO2rnnzV6c1uC1WWwMMt9oRTz2QJJGpS3K4wtUYlIwkr6b5jlp8+XRQlc1Rw7at
 W7dE2WpKAo5Stxln++oZiUkq1Cyzu0qfW5/FVuqHWMGY45k0DVSrNXsCUVhGA1f7uwekZH4SCzr
 UI0woL1qSqkAdnplplA==
X-Proofpoint-GUID: BAcp2MKQHciXlVe09QZbLcmaUidYJiHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280044
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



On 9/25/2026 2:44 AM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Add support for Adreno X2-85 GPU present in Mahua SoC. This GPU is a
> smaller version of Glymur GPU with fewer slices and smaller internal
> memories, but shares the same register layout. Also, the GMU chipid is
> different when compared to Glymur's GPU. Add a new catalog entry to
> support this GPU.
> 
Tested on the Microsoft Surface Laptop 13.8" (8th Edition), GPU/GMU 
enabled in the board DTS on top of next-20261026.

Tested-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com> #
Microsoft Surface Laptop 13.8" (8th Edition)


