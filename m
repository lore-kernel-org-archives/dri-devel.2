Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAEE10ED65C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8561510EDAD;
	Fri, 27 Mar 2026 11:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FdpUeDhH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K1/+eeG+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC5B10ED9A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:16:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6vnow3713693
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 39M0iU/FwlQ8YQkgSi9icpJ8JQpEnxIpD9a2Onoqisg=; b=FdpUeDhH40V/SjWq
 E0Woyd3uNalX4EiMswBgp2o6ylOq8SovNur7UB5pIZlcVx6oA7yEma897m86vt54
 OvDSR595QnjEmGM3rFEsadMPuHt7dTHgPDoGXXsPvn2h4iWV71scH9YPR4fuJUvT
 BQfvJfQS1YXHDduijTRR8y32wlPIEipFF2/Upz4va3ZAd+rd3SuQrfGU8Hl+NtAg
 WoYoMXtCUGsmPgth94l6TVM65+C1jv9wqwV77uCTDY1N0mEqd4+ZVECZS4dcqSr1
 8e8yhEFzI3YUYJmsG/sbABomsBX4S9xs9Mfrr4q0aJFwso3cs+tAKezDe+dz/3ek
 BdNq7Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5hapsucy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:16:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89cd0f68ed4so6446856d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774610188; x=1775214988;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39M0iU/FwlQ8YQkgSi9icpJ8JQpEnxIpD9a2Onoqisg=;
 b=K1/+eeG+S1qSNXTATzeeewjL4YLjTVOtrq67ywJSUZTN2aIAGCqImeRJuE/Uds0mkZ
 seZFFuM9ZtcGOgIKeXh/fqdwIdD8bMDs3gBjGdgtV6+l1MDd3RNfRTwlNph3DmViXZK3
 T8vmi6XnqlnZMYO7/Oc9F39+CceEtQfga1ueBokY0tG7kw/BVf+f5iRENm2JAFsOUq1d
 e8dFK3LdesNrEcpj7h+RP0OA+noro5h93d/LYg+DVXlZe75OLaYtujiE+WKhcrDsa8fn
 Ly9SLdb4tcZKOeopS3Ir2V/ywKblnxYi0pdhTV5koSQ3aJiVaMQJq+1d5oseARWJI3l4
 VahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610188; x=1775214988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39M0iU/FwlQ8YQkgSi9icpJ8JQpEnxIpD9a2Onoqisg=;
 b=PIHjsMO9Kg+45WDgN3v21GsXpTeIZ7c4GaExIythfWQeTrHarLiEyHnqpBQsrXyFlO
 5vZ3NzDRveBq9dJ72JqejrUcUn9vkyiRCBz6AKbQq+/19nCjT97fIXvUS9B6kxYVj4pF
 BdDYJK+pMby9f0vh7HbTj9sqQS4Bjz7IIuP5bppyNJuGSs4WZp8DPE6WulrOgbMbdtpv
 L535VElaSmmzXnXW5K9CSmM9Uv6epA1h4F5G4hDRucfCnXQ1WvOANzR673/+paLL/5Sb
 YWbNYuk31Vsx9ybkGXXlE+mCGYVXnWPEKb9VmlFO7C/m0TcDfDBkZBkCKgaPV/YoAhKZ
 KgJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvApNH7agKQF25PRYP8VHvtvYgt4wT/G/UQpv/HqAbOiWaTAq+ORlkdvs3afEYenU62pdFM1iOGiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNIumBVEQSMm0NCOn+oj/LloghCqf679Qs7ULXJVNeS8WKYhEt
 iGrp49HIvr1SU5F7hRyR8a05UuEmoWkXdEz2erdyOj0ofstWDxJye0UOrvKegNY91tKUkz9wfYn
 Q/TTLuxuZkpGkY84m430LJ24ZMzbr5UYr76ehhbas028JQoQfYCo/vWEboCmJQzjqyinS4mQ=
X-Gm-Gg: ATEYQzyG96lz9obLA3ZAifiXVLVUWLjuMX0/8c3byt9i8Mv9BHD9TJuOmsCmEozYXDt
 4ijKDuCvUGpd6xMAy7OoHrwgN4PpRYkG8C1e4lEsA1VtEYy5kUXXbR7ZKMQGOB/tx8gVMOmjRK5
 cH5XDVOmi9jnjsTCF2qMixGz/DlV7Eak5a4IgtJTmIiiKk0k953WhLAU40BfeiXR3+EkrA4rPtN
 N4JOWO8bWi6pjD9GZSkL4LfJ7tmi9NMM7rSxTfG0IyL4OZBREigr7q6bzJGUI9fT0+qCQjJDgYo
 3YTCJjEQIUZ1pUQiwsvHgoSS2SDpZb4fpUFHLwWF+vJQNhzeSboSs5i4qGm9ccyE08iazz+cqi3
 UHD3AqTP0JFmdVkEo9RXwGYMpStr/z24YwuW+Cla8n07ZTkDxkQqYmMcTwA5pZA/8wFvcIOXYK/
 3IEr4=
X-Received: by 2002:ad4:5f09:0:b0:89c:d5f4:7b2c with SMTP id
 6a1803df08f44-89ce8e419femr19792266d6.5.1774610187848; 
 Fri, 27 Mar 2026 04:16:27 -0700 (PDT)
X-Received: by 2002:ad4:5f09:0:b0:89c:d5f4:7b2c with SMTP id
 6a1803df08f44-89ce8e419femr19791746d6.5.1774610187393; 
 Fri, 27 Mar 2026 04:16:27 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b203c2225sm231157166b.37.2026.03.27.04.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:16:26 -0700 (PDT)
Message-ID: <f7412989-5454-4877-836b-268ca27c5731@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:16:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] drm/msm/a6xx: Add soft fuse detection support
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
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-12-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-12-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqnrRTXh c=1 sm=1 tr=0 ts=69c6670c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mI-EeI66H-T0GO0KZ4wA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3OSBTYWx0ZWRfX4LHwrJ1quLli
 7LWFneU2LeGKwqVFPbbC9DSXjPOkpdSxnwSbZVFXfKwsnz2FsltLyT7TOm/x25bdLZ5KRbm4FSS
 nRlEIdBK4oOe3CCjhgdcbhR0Xa1LUur/yNxoQsvP7ktXnfUihWb7ScNLptKw5Jiap/kmy5dGT5X
 e5V1aJjAeK5MGFlT80aB0AK0URdB6zmLm95sYZUQq3ttI+8htcnmiQ0jM40PONvkttrpcZLJBiW
 ZsTZPkUn1tylLcHmISbOK3fsMAZHNXxaFGkusx8qtAUaiuxlbQye45diWrC2IDGoejyYTSJjdW0
 N5MMGCu1EcVBAabGOkXxz8aSx2Ss7UG45xymW6qNmcgd/xU371xTcqFNED+W4MG+TdFUHrl/k0j
 THpGoZ/cWihEG5E+AVGr0E0ZpcqriVnsRu2tVagG/79yAsHFlUkf6cpr0lvuejldGISN1YEmeCp
 9n0kDEw+CT3AujTCqog==
X-Proofpoint-GUID: xZfF1aF5xVrG4vIt2pyl7Xw5w64j257X
X-Proofpoint-ORIG-GUID: xZfF1aF5xVrG4vIt2pyl7Xw5w64j257X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270079
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

On 3/27/26 1:14 AM, Akhil P Oommen wrote:
> Recent chipsets like Glymur supports a new mechanism for SKU detection.
> A new CX_MISC register exposes the combined (or final) speedbin value
> from both HW fuse register and the Soft Fuse register. Implement this new
> SKU detection along with a new quirk to identify the GPUs that has soft
> fuse support.
> 
> There is a side effect of this patch on A4x and older series. The
> speedbin field in the MSM_PARAM_CHIPID will be 0 instead of 0xffff. This
> should be okay as Mesa correctly handles it. Speedbin was not even a
> thing when those GPUs' support were added.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

My comments here remain

https://lore.kernel.org/linux-arm-msm/20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com/T/#mc97f65496ba60ecfc977bce1b5bb6d3922711ae3

Konrad
