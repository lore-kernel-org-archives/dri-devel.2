Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76449F3026E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 16:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DE810E276;
	Sun, 15 Mar 2026 16:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eOBOgDzT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VN/yf8/I";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0402A10E276
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 16:44:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62F6U2p43433604
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 16:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vlh0UMYtaMeioYXkM4rvp9tC++xOLzdzVq3WJDRWFcE=; b=eOBOgDzTeF8R6VY/
 FgyDDN9UUKFz/7hypVC0lkz6GfbY7/sEQ0LL10EmoLFVpTN34rfsyjEG541lHw28
 bOUBn2c2WpxcvFY+H0XJN0Ky4gioErWE+V0mODA7MQyUKxdkBP11fTFG6x+TT04F
 s//+PWtP4kkneFYC/hi9gVGxnfzY2NOlAci2yqhwcMsieRYgFDzV6oDV5Pi7OuqL
 H0OEjqc3fCJplLxiSGuY6AN6rpkntelAaYQ6rangtNY5IlQ4nO4F/Hot8obVbKEc
 lnPTSwtVidb3aYVGVuZm1+zyIuigTjdiOqalGhEdBufwGHkHJK5OhAtazQRrSfuy
 HCLp3w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00ak2k1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 16:44:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bea80a5849so53252633eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773593089; x=1774197889;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vlh0UMYtaMeioYXkM4rvp9tC++xOLzdzVq3WJDRWFcE=;
 b=VN/yf8/IQaO5NmXOXkCs9uLmTjYE0SM0BK8+vAg8SzlbsnZlJtsBzuWs/eT9ABSlHQ
 jbEz2eQOARx9pjHXStbGWhcOY/+F1E2GQZpSbyrpQu5LhDc6osmpSG18NHbQKe0aXtGe
 m6RSSSbHcfxNICZbSUF/1S9miLNHs8vH0hvYTY+K9qVur3zl/78v7p18WMaBjrEqK1Fi
 XhNPa+835vC/Ro7v7Fng4gZRQK8q+CysHFHBwha7Aye+Q3opG/2tZ/x32PrPMW0Ebc32
 IJAkY2DaIajRWmOBUAjbG51Nz2ivkjvo5qOZPi11fee1v+0N7zCG8l/Vu5jx6OyGmzbM
 AZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773593089; x=1774197889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vlh0UMYtaMeioYXkM4rvp9tC++xOLzdzVq3WJDRWFcE=;
 b=Ofhfm2bf3s4Amt6q0hGZvJXyO4lA7W1J0ZwOf5S0ts50gh4WMQ2copTSzRhQIImhjJ
 1WexkKu77GADGK63Kx0uS83wYQisGCFCV4edKw4Y9wxo4QJIZGxxb9KD4V2T5GO+iS1p
 I4OQF9qRUiluOxjC72bW8eF/CXH5U0QxvSE3fmyRa+ioJNqlSCb/VpX9TJyZHu1o14CM
 Vxg2Pz5NBeTh+s+MIUhLLai8LCVQ7yd5XcX4RjindtkAEgZHE8G5QJzgZgo66n/+xLd+
 hySJTviIez5MUD6U6O54nMGhPZ/LAohVUMTCYn88/kOuQNTPrDrjjoylzh1+v0JseGkN
 PSXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeyr7EDmtdTPkAA+siI0CaHR4Zv9q3iggj03U/ibhbCICnM5rncc5M2PmeudaIRs80K8TIDiKcGJI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOQ3DdH1E5mNx3cfByBiozMVORDddRBuLvQyVNFEMHN6/m+HSu
 6XgrnnlKr/n1PmvVAVUsrMIiM0TQBwN7fYfatN3lG5cvv0TXPMO1M3Au/wrzLwJ004Rd7Almmk6
 R5JM2K4yKdX35c1elwJI90KV/evpZ5OsNSAAxU4FX9BaEoIGMB0qfQFcCY4O03kHD2MVCNGY=
X-Gm-Gg: ATEYQzxXzJbJyU2f6zKs4LLAgYmgiuZLX/txqC/6+a4MHcISURubNVPMxnpMqys93cE
 kAJtlAn+LrUeXTNY2fq+J7drMH3cOdeeKoudZXkIUtetSnS619H920TUfApHO5+Y7Yu2ZkjX+Id
 WRtPqyND7+Apatb7YQCgb/T8rvjhoxXA1PePaGPFJodeyZeQmAjDV0cACmJOY8hlL6npMq/knqP
 aLmH4bNzLvhQW2SvSdP2aHTKBQT3MKbvvQrJRYFYKQ34nNw5f5mjZxaSOJnx6wIkOc0mKXFKuDK
 sMLnmRoTCSt8/gItfXXzb/anlGFoq+Zcso1cdIMs/k7P3qkijL3e8KvXUxf8mmwCwabOnZ750lQ
 CUMl6mRgh2s3qmKLeD0NTmJPeORI7ifmjWi3pfiqzjWKEivJqn9VUNtqklfWKFjEjMA+y5EKHs5
 Y=
X-Received: by 2002:a05:7300:5383:b0:2be:3f:307c with SMTP id
 5a478bee46e88-2bea55ef0c8mr4689030eec.29.1773593088884; 
 Sun, 15 Mar 2026 09:44:48 -0700 (PDT)
X-Received: by 2002:a05:7300:5383:b0:2be:3f:307c with SMTP id
 5a478bee46e88-2bea55ef0c8mr4689026eec.29.1773593088389; 
 Sun, 15 Mar 2026 09:44:48 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab55541fsm12945850eec.24.2026.03.15.09.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 09:44:47 -0700 (PDT)
Message-ID: <42d61f90-bbfe-49c0-ae09-cb6738ec7014@oss.qualcomm.com>
Date: Sun, 15 Mar 2026 10:44:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic Fix HELLO_RESP mode sourced from wrong rx field
To: Alok Tiwari <alok.a.tiwari@oracle.com>, jacek.lawrynowicz@linux.intel.com, 
 andersson@kernel.org, ogabbay@kernel.org,
 carl.vanderlip@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com
References: <20260301091214.171263-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260301091214.171263-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k6d68di-j_Z4rxUbmLOEPNOIU_Ac6SxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDEzMiBTYWx0ZWRfX7JBH/2LXLyrm
 oTrJuoP0LSnVo2yCQsvf9shvPQ+9kfzeRW3oI4frvt/23hCvp5zD4LPcTmOkxc22p3Z12+Qx6y5
 zHIwFA66BEPMc9pGAwy4mrum/OU8KGEpuxsWjD00k2H9WtbMInUKtGsx68IB6wE/lSLn0DoXagy
 9YA0inadbFHd2zV8ndl/xe9iE+n/Rz3XuJ3sATsL0wHCoAb7mZA0lYjcUt4jcsvCWwAibDlOKIn
 nwGn1nlBaqFN+D5XmSfghERNAqUuQjaJBSfNWBKZAEdVo2AxL4GpxyElo7Yj6XfSFVUTgF34BTV
 RJLostCNoflENrMxOThFT5RV6qlvMvVKgo989UDjbWwgKJxnoBh2laLqYlS+duLdaUwxrubl4em
 hVNDxEXcEbQO8Y1cIJsmibANuTic4kBp0KtDR1UKn5nj+VUy5vVyTDrAGGI5HljQSwVv8kgts4A
 dPyC6d4qIqq8QoMre+g==
X-Proofpoint-ORIG-GUID: k6d68di-j_Z4rxUbmLOEPNOIU_Ac6SxK
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b6e201 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=yPCof4ZbAAAA:8 a=Wz-czTzbEKbp6fIjhE8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150132
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

On 3/1/2026 2:12 AM, Alok Tiwari wrote:
> sahara_hello() handles SAHARA_HELLO_CMD and validates fields from
> context->rx->hello. When building the HELLO_RESP, copy the mode from the
> received HELLO request (rx->hello.mode) rather than rx->hello_resp.mode.

This does not explain why, nor what is broken (since you have listed a 
fixes tag).

rx->hello.mode == rx->hello_resp.mode

Also, care to explain how you discovered this?

> Fixes: 76b801aa2198 ("accel/qaic: Add Sahara implementation for firmware loading")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/accel/qaic/sahara.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qaic/sahara.c b/drivers/accel/qaic/sahara.c
> index fd3c3b2d1fd3..99bf832e2825 100644
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/accel/qaic/sahara.c
> @@ -325,7 +325,7 @@ static void sahara_hello(struct sahara_context *context)
>   	context->tx[0]->hello_resp.version = cpu_to_le32(SAHARA_VERSION);
>   	context->tx[0]->hello_resp.version_compat = cpu_to_le32(SAHARA_VERSION);
>   	context->tx[0]->hello_resp.status = cpu_to_le32(SAHARA_SUCCESS);
> -	context->tx[0]->hello_resp.mode = context->rx->hello_resp.mode;
> +	context->tx[0]->hello_resp.mode = context->rx->hello.mode;
>   
>   	ret = mhi_queue_buf(context->mhi_dev, DMA_TO_DEVICE, context->tx[0],
>   			    SAHARA_HELLO_LENGTH, MHI_EOT);

