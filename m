Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE82EC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B3810E776;
	Mon, 17 Aug 2026 12:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NS2MZBAg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EelaUHVe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1371B10E776
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:06:54 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9di3O2278884
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 or4p8FHMDZFJR09NECDM1up3ClrEb6rUu4ZXWXV6Aww=; b=NS2MZBAgau3WBiQX
 WL4fNGkYZ+8CJgOsQHQsWKz1a8b5NsLT2nGDZNploUhD77ZmB+oxj82iIsqCrJbj
 k0OAL2Meyi0SAbztPWjk+TfIemKgiDRIQZLU2JPIQ2pJMB+JndBQ+CVzzpbUpgob
 qnj7VNiIDMORo/dVKSp2aL0RkcYRVoPgw3jP2QnL9hbnmP3YITdcZw765Vez9BZx
 9Uhx6NjygOXnxnnvuyO8D6XGJmkzAyKNEo1kAVDdP7zRENrBsyMIw2OnoqZlaOtO
 /5GBUgVaOpHiPsMsHzte+8KOAdZtcvDl9IlQK6qlPS5pslXaTsbbn5+vTP8ffvrR
 XWZHzA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y778q7c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:06:52 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-73761f92dd1so42445137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786968407; x=1787573207;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=or4p8FHMDZFJR09NECDM1up3ClrEb6rUu4ZXWXV6Aww=;
 b=EelaUHVe0Xiz/8QxlXcWhKO5IEqfYCgyhon8x43qaw+OfnOl7UaJ4/c2DZbQY0xDmf
 tCnQNrbtQHNBynBVLxbV1yTMnd3DP3dSraBdMdaGXNq3s5zrixgLftDsFutN+mBSo/2Q
 CfDgWAFx9rjm6Wz9gP1RtteJDGd924s9Xvx/crwkvnUrkASmEixuczO99h2olodPC2x7
 TYzwDPFQXoncEbSdlgPcqdYBwjR5lCsbLEzLsYb1pO2/iOqKe9xtkaWOK9bH3x0FavJx
 vLR4k0JAbqVX/seTYOrKuusv3ny1Qgk2fRDK46PqiLQspn285RJmLp8fLjnx0DJkZD+6
 KFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968407; x=1787573207;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=or4p8FHMDZFJR09NECDM1up3ClrEb6rUu4ZXWXV6Aww=;
 b=ZjcWHeg3peFNfeiinIhVmsqq7N/gDdfnLL1C/Zonh85gdk9x7jEJgez5NtoCHp2KVb
 T4mNfSwieFLe+1t87GexuMvDm2lR3dWKAb/ZzU/l+y6bozvf2QFcnX6jyrbkZDuYT9Em
 AK+vuagFDjV0IQKkPx7+4w9H2ruA2alko+d8XU3Rj1lNIbgifu2Yl4iHE/FjSKr0Tvxq
 5TTLEXoFcPvpeRG+w7VSswb4phpt+zEumu9AbisM28/kVlXk77eZUID5NQZ1ReAgTXob
 NzJ4//BTDz6yNkoyXnbjj98w42Pk9bWGN6dQsQpv0SsThqn0w+ylC6g4r1DTEqqTWEs1
 WBMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjQCgGGh232SYmsj5cCPJ31yJUVXSnZ12msA3E/hU9btTp6Xe602iJWkmvIxTjdKEgL5YFryG/ruk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTVEPOopYAAxal32C4+F4YplC/lU4EMNDIRw4FvWjiNgQNDoYH
 efRnPqeEJV4FHwqqVCY2N98IVYIYDRfY4/aaphAk6cT+ff4aEzqVbijm4AnaJkjitol5xU/W+Xd
 Lp8fnMSKTukzq64mdNGsK5XvJdnKMd/geNJmSIiOKIqYdcfpZ0H6a3H7mBmmMJLkpDpHwjDI=
X-Gm-Gg: AR+sD11R9ZO8uOFEbl7wYDw6EPM1VELhtAi2n3iLN2RU3AEhde6yINvEHczcQ6HAVsp
 YNRZnZIM27vhJDbmOJCcQ9sOPVG6uKDf6TbQYXbonKsw1wjn6cpEGr9MygjN9szOSNKptLViH/f
 Wm3ztJNLdUWFFBDVPQdURYH7NgUb7D6B4gklA7raCrRl8sqYH2mFeXVNJI1v9zyF2gFSnDg4lbl
 ZXQW/7rV+jM2JJW5b9Dd3wNZ9CVBoAtiB8PTOLMlTQw/B0m+F90UYUQGB2iTchWdWdz1OTroSlX
 fldyGWrmfYQ49qLw/aUByh6aroOK78nUw/2Dh61f9JEl8SQt0j5CqSUa2TSzZuhI6kRbi/zpWZ1
 jfn9FtjHTxNgY3bft5oy47A81
X-Received: by 2002:a05:6102:570c:b0:73a:322d:1bb3 with SMTP id
 ada2fe7eead31-76f2d481b12mr1268832137.3.1786968407336; 
 Mon, 17 Aug 2026 05:06:47 -0700 (PDT)
X-Received: by 2002:a05:6102:570c:b0:73a:322d:1bb3 with SMTP id
 ada2fe7eead31-76f2d481b12mr1268823137.3.1786968406932; 
 Mon, 17 Aug 2026 05:06:46 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2185b73c4esm14434466b.33.2026.08.17.05.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 05:06:46 -0700 (PDT)
Message-ID: <4bd69f6a-e014-44a8-bd65-2c1c8c81d71e@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8750: Add GPU and GMU nodes
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-3-207ad1fac1c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-3-207ad1fac1c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfX6jA0X0o+F4AV
 DKGQuS2/4DO8sthLZwB/1ZP/KpDNzYOS4U/j5yxNcss5htKDj5EMditWiymeJJKT8n/Vn/+VBot
 PnlDqstbgp2uwOV1VWXHOWC/cO/YtKzrwd8/5wm0pNoDm9JtA9oXiqdGTe+qsrIG9laHDuhHWde
 e/DoAQEFDd+cr9B3Xua8t10jrjEPBoFjbR5a4wX9QzznIOgrXRvm3OTBECZAkteuakWyI29JIoU
 o7pCMbu34mcAqQXwjBT/BeAfayrcs6yP2VxOhZGJfeKipJZNWbeRfN34Ogyoyn8vVBZDGhnheA0
 l1qjDA3BoIMT1lJTQoDgobvq2BtgLpMkK7Vg9tgL/nVDGJLND0lh2cE1p1HEWkU638G6kMjgWVu
 J0kOCo63UPBJ0W7AgmEBAx3Zyuvss3pMYy6zKrVvU1+6AgyHuDIAZ0uPsDfawG27XYHFC8crAav
 3uHbteSHF+6LibKgcoQ==
X-Proofpoint-ORIG-GUID: AXGEpy7vG4B06_Gav6oPLmk-F0LmGIHJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfX3EejyS8ILeKr
 at1MHDu237x1C0OnH7rYXMhB/JUtVO3Eml8ivca8Bs4fW6gvJ1AHNFP+Iw9/WaNNWdU7Ur0Q7JJ
 1SyLIEMoudamDK6zkXbG+1IEhSq9QLg=
X-Proofpoint-GUID: AXGEpy7vG4B06_Gav6oPLmk-F0LmGIHJ
X-Authority-Analysis: v=2.4 cv=WNhPmHsR c=1 sm=1 tr=0 ts=6a82f95c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=OtVmU76MxArhZ2K7wnQA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170091
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

On 8/8/26 10:23 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Adreno 830 GPU present in SM8750 chipset belongs to the A8x family of
> Adreno GPU. It is similar to Adreno 840 GPU with some meaningful
> differences like GMEM size, register file size etc.
> 
> Describe A830 GPU and GMU nodes in SM8750 devicetree. Also, add the
> qfprom node to describe the GPU speedbin fuse register.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
