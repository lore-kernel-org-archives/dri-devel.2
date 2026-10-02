Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C482CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE3D10E62C;
	Fri,  2 Oct 2026 16:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqA5tpnY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H0ViClX/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C7310F91D
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:52:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692GioY81083617
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 16:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l6u0nay/jSeciAm4wqg+Nd8v2O6AJXxPELy5RFUthZo=; b=gqA5tpnY4WNs+KoV
 H9bj3vR3+ybk3+iW073FsRBt/qOXWa3GGEIESxrBBCLnkeLRCkp5RYxRu9VX7AIv
 +4tgQJ9yQW/m+jqN0e1eD/D6HA5Y//bMehk/BG8tcrjEGM1XIMMXqWHKb8Xr2qGF
 7E3ERoQdktySTBHMJCKySxhWBGq3dnaPZzuVX2ZziySj11aV/RakSBLOvZTZwysS
 yQs6ycS5SzRfZvQJPKh4gpdXbZBFGcBqWRGRJndt5BvgS0GHaSy/t4RU1UghfMfa
 7hIpnw19JuMRHPbvOFXpBSgOf3Vl5WkgAFvncb3NjM25vopkrFt9fomEQXzlRHiU
 O+Rf1w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v034ewx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:52:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so12286147eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790959929; x=1791564729;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=l6u0nay/jSeciAm4wqg+Nd8v2O6AJXxPELy5RFUthZo=;
 b=H0ViClX/xk80W9zEEIEL1QO2gf5oWfqyC7nbjGidv71Oh0io59r7sCEoQxFS71RiW5
 n9zseuk57fhhkNK7TnxNOiUBpXAO/4BWyfWLHiPmZpqgSAFki0EIDnFNkcEvmkv6yNat
 k1Avjoa5IkqppHcV5F/LKkSmArtKHsmo8GRwutcBX07tXRxNoPnnBrQ2ayuC6yC5EQVc
 3z8GAIPtOmsJr+/Pyd2YSmLUKOuNGXsCFee10gC4oBmgm9rDQuESWSan8APx3qfdR27X
 N26VtvOIrCPSPwae9WptwreECk2wM4O95g6WlFtGUJnW4fI2HveCv3JlECMdARe1lKLc
 kryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790959929; x=1791564729;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l6u0nay/jSeciAm4wqg+Nd8v2O6AJXxPELy5RFUthZo=;
 b=aaWLU0HbIysNgWLCvalXJO1cMgJLYkbTGmk/410PvgCfYcvrbe8T8m8cMeLNVyjvYm
 IN6DIz5yXtnsJQ+Uvr8MtiNCIpodbBToqhWXkE7RO3RKQRMAjKo+mLhgPlWYUuiWo2tX
 a7U12hO7JGwQ79v+RfGwf9ll41ap1YiNY+dEYmOjRS/0nVif8LkG1Hc4jIglAPgWQyjG
 0wxoawHcr7doQ3nShn4LGkcPtc3H1cio22U0QND2ujXkQyloy2BfhK8S1CUeqFIzj/G6
 IzjA6XvDOwrPYVz/IWGVXUpWcpJ0dS7dveK2xhSr+ivrnLUY1iY3ILj4BGeeLYcHaQdY
 s+CQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByp6Y+zbozKUaWGwhVcKTH+tgCibynJAxEZYapoLc12TlQmXYlhgsogRvf1YVU+eDSsu3nKoCyeAr0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL/wxtSScaA7Kk3T7xdnAylDBgj9Bn2M9U14FL+DOrwmTMlnboC
 ESkjvFIkGZJpD1SrS1+dV1//JezcMubx9a3ZC5mYveB5mDtDFrvYaI4GMaMoAu7cHZjLAOSR3JP
 cKB0BTkmRUBYu+t6U6bkKVH1iDG4APLG8E7XwUXDJm2M80yVEs/VA4YE9to4IEXEgU4c+/vs=
X-Gm-Gg: AYBFou2M7TwAVbzEgcslEms8TW78CB35DlCAojjyaki7gVVYEdSx3pf0OvAlu5BNetQ
 vvKvAqFnv3ZUX6UHgzqMEKUii3mltuUJCFRU5sVrzyZsGeDuEKKHu4hCYEOw2MLtQOO4FrLhCCz
 4lYALAXpr8QuMgzSBwnGcIp4vl8flNT8FlU6ud2L1bFVsjuFx1JKhGXSjRAZduQ5lsHLHuIMnBU
 kyS1wwAIsnDWV1ODqc+JZWItYiMVEmO1h6yZwN8csN3k97g8W1ssB6jX0EDMmWeENmzBiHvv68r
 /EWQcAn/qdrMWhwrP16YDCsUlE1+gBEt/Ffk3iBf8UbUud/El634gCc60WkLjLpXQs/a1gGj+2F
 2m0X34p9DKAyHSTY71WdLwMvOPirzF74UeixrAPUjW4IPPzHgRA==
X-Received: by 2002:a05:7301:348f:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-34f150c7a93mr3401182eec.18.1790959929079; 
 Fri, 02 Oct 2026 09:52:09 -0700 (PDT)
X-Received: by 2002:a05:7301:348f:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-34f150c7a93mr3401142eec.18.1790959928495; 
 Fri, 02 Oct 2026 09:52:08 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f8e9c7sm8444985eec.14.2026.10.02.09.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 09:52:08 -0700 (PDT)
Message-ID: <7dcf709c-94ff-4492-8290-3525d8200284@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 10:52:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Abort pending jobs on file close
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com
References: <20260914082929.892437-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260914082929.892437-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX4eLpCaNrOJER
 l8av/TwD/T5cefKQzlFzg1t5GIpx5ro3C8q6SZfxr6gdI6z2I+xl2aipamaUc3NbM7Y2mAz/wsI
 uVW/1K+lUCndWQCotLmAYMqj4pB86FI=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abfe13a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Hj_Ly7DI9-WRdEB1V2YA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: bRsHOxV5Lak44O94BmEDRbOWAvjwvOKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfXx8w562RpPA1k
 +AtVAX6uqJO8UBe6Pwo02+3h/+FeI04w8cM7MUjCM13iqRbY8nkeJjAJyaK0fhc68lMGtTDIJCN
 +kfYNIfvCiFn6V07Fo+fGhudBHO+7qgaidWYwVFSqiSrHzurNMzaVOZLjeYAuPbEuSST3qmCnnm
 +sStysaKMCeQPiUtdqwJ6My93o1IVgMq1616itBs7+6ANcpHLu9ptz4ngD/45HDhzetGEZbvpmY
 OgDAXxjOno7Zsw5LKlbeVA36go19sKpBr3i0fmu9OeLd7bHWEg32vmDIyhNBMh+2inC6pDX7pVj
 2dzChQvYuy/M+vvKyUIgR6UCrDrNGV+p1lGk88XBNGZ72wJlIPiiK9Vo1PViUvb6Ibms3zmBnjo
 4ccSWtEtzicBOu6PfqEwGl+2voTDXFTvnvv+qQViUrm3QsqTGfiH2rfNNNGqeD5HS3QVwJD9hUp
 aSOcGRCMZCBQLbKlhjQ==
X-Proofpoint-ORIG-GUID: bRsHOxV5Lak44O94BmEDRbOWAvjwvOKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020067
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

On 9/14/2026 2:29 AM, Karol Wachowski wrote:
> Closing a file only dropped ivpu_postclose()'s own reference on
> file_priv; the context and command queue teardown happened later in
> file_priv_release(), once every in-flight job completed and dropped
> its own reference. Since nothing explicitly canceled a context's
> command queues or jobs on close, any job still in flight kept running
> in the background after its owning process exited, until it completed
> on its own or the device's own TDR intervened. Make ivpu_postclose()
> explicitly abort the context's command queues and signal and destroy
> all of its pending jobs via the new ivpu_context_abort_all_jobs().
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
