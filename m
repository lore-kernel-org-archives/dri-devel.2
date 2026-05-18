Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C89BCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4F410E92D;
	Mon, 18 May 2026 17:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0+NDR23";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IhbhyZjk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20F010E92D
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:51:54 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IDYvfQ2891952
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=W24vIOGiSP4y29K9PfNEC3xc
 hhMtUW4j//8Nr4NBCog=; b=D0+NDR23gr0Hf9uN9SsTR97Wpa/hUSXks34Z4fPc
 ytW9M2nokM2oR6fqX+mL0I7KfQtCXwXCPHUcUkqZD/006ngkEKbeFTjSa7fMsvE+
 zMcUWUNuiDLB6MoFr2ooNeHmcPFtHDRWif+cRlWyXrPY7kF+XcEJkk178y4MIBoD
 BKZaBrXwe+FzmKeExjDx3GfI/Ad+KCq3L2djYW9f0nAMwRf2u+KeRlzn8jNfS8Y2
 wNlU3Sk4kcWZjh3yXvVxWYRT+b0yjz+SHKYU6MeX156S0Qwqz2UpnwHtTztCQTSK
 OjHRfa4h4faErBt85SDg+UUaIMe9cH/6tBIowaAbxvSaVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk1afdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:51:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so83626901cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779126713; x=1779731513;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W24vIOGiSP4y29K9PfNEC3xchhMtUW4j//8Nr4NBCog=;
 b=IhbhyZjkKwqo1ar4wULzwRSXCEQI6nVcqU3w0TsRA21ffzXsX6sewTeQbshVS+WCXP
 raX+ryw2X8cxnW837NFyBavNdOY3XRit8rzBH65jfndEW9ss6L4lFukB4DJS8IUJhubn
 f3hgFw4D0OFMpTwqaVH9YcRq34Dv5A69FSvxeeAyGBH3wX36GUWJBFXfRaxP/L5FIEMw
 eZjuVQW9qBy9J0jbNiMuOMevn4bXyYBEqpVIHX+NilHIux5SZF3gDv//A8nqFJweiJjP
 t2czyrCUUg5ywaJpZBuUFJqFh4enRx3N/4ONQlRKr+9fjG9fsCoIahXt1zp4YJl7gH43
 JpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126713; x=1779731513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W24vIOGiSP4y29K9PfNEC3xchhMtUW4j//8Nr4NBCog=;
 b=LRKny1Vftcre+7VXXCd0TEm3qfG1Xroteee/fHYMeCBc54xjZ+/RAXE4ZGtv3mSFKh
 6pvzrBXSZ48HsNHOtZ2S7VwQ5q/lZfTgIl3pM606aupeHPxae8vNNn6hzrGBmpw5dDY9
 rs8oGPmBAhiq/TplvuqorhdrGtWNj3WBUxCSiR8LVRxGy2/RhaJiBxh+sNIN3bUh4III
 BIkSH7IlvfIcEsz/L9QKzVLohRR8hPuSswWjd6f+K2o9eIP17ti7f+dAHYI7sme6+ivk
 wNBfGG74JYCYTuMMXA+6Hj+JRdf7diqVIJTNPZKFz+XLEJfjtKw6H6/FgQHj8pa1ZS65
 vqag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yAq6O9A2m9n3P5I0gOB8KaxJfYudNufqUrQkhRkDipi+VSv21hvKiTChSznYHu8guzxBzIcPRfZI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpzD8JVQ6am123z2vQefnSs+J9wAXyAyD251Z1klAvxE0efCkA
 Iqz3+H+wuxmNl7UJX7SvCwdTvR081/Zerr3DV2iqF7k5QTcS0SrYClYEvEB2UWLAhftv0rgKRF7
 iAePrceMv+l7G2MNspvmC2jxhkShQwzkkLnNO1qBgT/h5Ec3Ojqi8tbrwlmDVyGVC+3w8l0g=
X-Gm-Gg: Acq92OEZL9NKZr0MfbmoB5yOHctw7Zc7pg24/TNvRWjrR+ofbSIFxEghg04YfiF6Nmt
 DRKUigmhdlOtOHuT7WiF4bSwc2wl3TSDp0FD6JqrabPQpi+gN9tc1th4NzK8G2EOj5PK0eDaYtm
 fFdQMnDsyFUalDM6OaalCBOto6aFL8/8kfPSbaPvQ7e9x/Hgz+24NZAqcdxPUOUClqM62v4xUtX
 t2EPCslmcJt8e3uS40B8eNAFW8+e783QmDDaE5Pzp52m2/nh2K1xsFNO8oP1y/+C//1RyDtSQ7M
 PcAXTBHJ2nN1nYU/nf+bbizAD/nF6OAgUdqBXhj0vIqNzkaAhjZ37H5ta+el9WDPC0K7EcXlmPf
 9WGMGfFyeMTAogFXsIRlEtwkLwi6G5Qkx9YH9Weit9dLz48I4GfLnngU1WF358o5G0qMdly4dyz
 TCcE0N8VX57P2nooIU7v8Lu3t6MozuR2FhiMk=
X-Received: by 2002:ac8:57d6:0:b0:50f:ca25:fb48 with SMTP id
 d75a77b69052e-5165a26b016mr236818331cf.55.1779126713025; 
 Mon, 18 May 2026 10:51:53 -0700 (PDT)
X-Received: by 2002:ac8:57d6:0:b0:50f:ca25:fb48 with SMTP id
 d75a77b69052e-5165a26b016mr236817891cf.55.1779126712506; 
 Mon, 18 May 2026 10:51:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958878a103sm13495791fa.29.2026.05.18.10.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:51:51 -0700 (PDT)
Date: Mon, 18 May 2026 20:51:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add support for the Microsoft Surface Pro 12in
 1st Edition (Snapdragon),
Message-ID: <qfoobb7xrqkc5ivs3v3wcymbhywwqe6albcijchdmkhwrvdatg@pbsnwdrawko6>
References: <177869930359.1496076.12020223802779537187.b4-ty@kernel.org>
 <cover.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
X-Proofpoint-GUID: l4xDBY0E86dozq7AXBarKHdeAULi35EB
X-Proofpoint-ORIG-GUID: l4xDBY0E86dozq7AXBarKHdeAULi35EB
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0b51ba cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=DHJDpsF2dBqhSPlo:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=9VIlvAo4FWx-UwQJ4rAA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NiBTYWx0ZWRfX3cbrheMxkPjG
 ZNEOJi5SVodjBlDIKFWdnJ0q2qrVfRyRoOFxaxfv3+GiLqPn0m74NA4oVBmBU/JgKP/oQZ+GlLq
 r6u6WHjs9sfAvrrqBpX3+jCFjMe9/S3FMheE5yspvv4ZY2u6NaHpbhbnuvp3GZGtxhUs5O/3B3Y
 IYvoB2QnniCnv9zvYv2Sqzj5jFHxJ7FNFl9DQrELoxdU+J2fkMPhzzT23oflVydQhc66Mh5geA9
 zuInL0pkaYUmk/ivH6BG4lN6TIqZCF0/S+ezP4IiEdbAA7MKEAOUD0MGFOvwyKi+xExjVRMy+lK
 scKcNLFWGBVVFNlACk4Zz0tHeP10dlFSRnKzE/dJBYVrhAcgfFaqbOUnOcBQO96QZv+yW8q2Kyx
 psarzL4/wsiZIEZMYByujHQtw/DyHdM0xhY3GjnonnjXPreKQzCEAwImbYmX8a5IEb6uJhJufZ+
 n1MtAvmU8/36yn8nIBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180176
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

On Fri, May 15, 2026 at 03:41:45PM +1000, Harrison Vanderbyl wrote:
> Changes in v2:

Please don't send new iterations as a reply to the previous iteration.
Always start new thread for the new iteration.

> Ice device tree: 
>  - Updated to use 0x0 formatting
> 

-- 
With best wishes
Dmitry
