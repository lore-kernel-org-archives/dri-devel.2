Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A32CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537C210F51C;
	Tue, 13 Oct 2026 07:27:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D312E10F51C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:27:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D6CUl6949467
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DvokiBRaiti5Y+UDOubxiXcM9bfVFYj7J+MMf4KQ2L4=; b=gVEOvMuJ29Cd8Tk8
 E5fUCLBmjwGvP9eU7uoGzTempBz9i2mM6p0m4Uylu0RyfK1u7JiOpFhl7oD15R53
 vV+eCkljybWYkfQQ9cFhdj/SMO1mu0oiUqOWr2cNK/HytSaovAYl/Rr0qALmOY7M
 eYW4oe05hKpSvZ4B5PN70nhyFSeBkZ6aOOWeFm+jXrk7YycsYyRuEXS44IrU7/Zn
 02uY9OWZy5iVEfmQ6Bnol8fvVNaanVP0eeAGF4v/x+e0e/QibwCWAQNYe3Y5uDqU
 iFE/KIGxwzpslCoSkdszLbPJM+2dWuyNuzRxHPO/omGfk/43KNxscIR9k5XmCkQ0
 sLGMwQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f6289g8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:27:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so1978440a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791876449; x=1792481249;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DvokiBRaiti5Y+UDOubxiXcM9bfVFYj7J+MMf4KQ2L4=;
 b=fPfjb2s4CH90gZMgXaEZX5euo+L8TtHPerUgQhO+g2zigArw0P4u39b87gYoMSNF4N
 IwoezNYdToNc+t76ZK82DmAZVxC6ynDOcciYNaZPyGMnvdPkdnVmtchL/jziVbQWXf44
 g31bkechNzrDT16/Hw33mQiAdewH+XrLcD6dcosTIJF/UgXWhnsrKQdXBbSZos+4skHt
 F5j/yTYIW7Ijn4BQJx4jfnK4uQnEZxKh8cIgueff7mghuk13jlcD4ZoJ8UBmpOeHipN4
 6olTIa54gqsrn44k7ZjcJhJVZvs3GRfI2RN/DfxyUnmZoIsYTM20MaqF4ppgOK86/gqw
 1WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791876449; x=1792481249;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DvokiBRaiti5Y+UDOubxiXcM9bfVFYj7J+MMf4KQ2L4=;
 b=CFfhmXrEoKwzKAWskk6IqtRb9RVI7uWksNaoXuXsftnOqtXoqU3oTFkMGGMe6H38lx
 jQ5vBXe3c+kXwkKqY3WKUylv8ym72Totgqxtz5F7pFQCAAprO64Rvcj9Ho50kM8IIU+1
 DZu9MQV/mC/vqHj6Iigumw6g2FagfaxfQ0E1OG5XRZLtSmARmTTg71pXj4rQLUafxKor
 FyJ0UNt3KIlHC3VT5rhbg5/G6BJcOZfucDXKur43mrIeRv35WgLJAZtzCFlKFhEbGsRb
 qmPR1MgYpd/tiFuOJHfb1KrvoVAkzub9rfCCJHupv3bOUW4XfvysGm+SS56pNspNAdgO
 EaYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz69NTQ6u2SibgY9eTBlU+DfrjngGuEh3P7p4oW2PK47P8B3/KKZoDtQvep5RCQa9ibHHmKSSOv1h4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIHq+2paYkmkDml9WgpxSKTPqwgbq4bT+6DytFL5n0ZxP1zdUYy
 AxK7q2BSvprqLaI0dQGlQjTTnoxV89IHgiAN41LXYE2ddbOTEHXxeS65HJ83rdRyjb0TN3os03W
 0y10gXqppqvKXyvXDs8y+gsx+bDXq2frRrniCVnoXCFaDd7DW2wtd/1Z4doDY6M1c3aA+6dU=
X-Gm-Gg: AYBFou1vFxL2CGCrbd/RRTihT/5jNLhlfZ1MozXG9AsuzQGtWXIQprUa99ZW5XXA37i
 /dhxG85a4sQp9/FEk9iRcIFRLcK8IMZ3JTnPy1CJD3Y9ffZpYTyCXEeLoQt2GQrX/AjhxKKb21z
 jKMyXQ2aFUlpjxo7rKdL7ZQrcoUJ9HarVj9lYwNvkYG+n5iFWRhnkoMg/5ma6rVU+7AXojJ4dlo
 kz0+jVAbbuMw0mqnyN+9znWKvQ81W8MEgcvpHf/FNB22bSMce2VE3EyrJ+5gMQETOqhPsuWpjcL
 f1DzEpll9EmVVq9rJ37kuTdFSBaI/7h0mTJqbFYZnPWn81lZML7eTxnMohP3UKbmBMLBoU+1I1o
 1sbazJ8GtlAxoU+kxPQc8VAFrpuK4Z6g=
X-Received: by 2002:a05:6a21:a02:b0:3de:5ce4:9e72 with SMTP id
 adf61e73a8af0-3e16c07d2c3mr9113739637.56.1791876448591; 
 Tue, 13 Oct 2026 00:27:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:a02:b0:3de:5ce4:9e72 with SMTP id
 adf61e73a8af0-3e16c07d2c3mr9113720637.56.1791876448142; 
 Tue, 13 Oct 2026 00:27:28 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da05caaesm5050788a12.32.2026.10.13.00.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 00:27:27 -0700 (PDT)
Message-ID: <122f5f0b-6314-4b12-b9dc-8f983c9b5698@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:57:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-2-e12939d229a1@oss.qualcomm.com>
 <as1F08YNeWz_1bre@monoceros>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <as1F08YNeWz_1bre@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acddd61 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=qh2oGK4qJ8XON0oEHbUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyOSBTYWx0ZWRfX4kIF49J3VnQi
 J0xy4IJWz2IQHeffZmz1SGqx4Pa/pIZXFhIKSOE84ITSq8X5DwnTV1uEzwqEn5pAJ0dPpWO46Y5
 atwk9znOz+2aAQkShuUcWg4oJgQ2iI8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyOSBTYWx0ZWRfX71OD3Ed//7Cc
 5LKkNqqRHuXzEUVzCn4JvuZaGQnVJ5EPCHYYLpu3oaS/RhQ2HNlxMgyZF0Jugmna0Fv/SD/BNAI
 lomb552NVXtQb45pgAZX+TE/rsFZXiIzpd0B63TXT5/Uyi/HdagODl9/6ASAc4eu3EmwFDuxOkw
 Tig/OIf+rJt6xi+mAznPAY/jt4ILQjhRMstacIECAkELNc8nVE/Kc64naxpEs9KeVn4dndMfhRO
 +8Do2uT2x7J7uiSv8v/WXlqY3F3SjlahUzPQHbz53gYthC5xnNmK+3fQK+/QOLl7bANbwX5XX3q
 im2n9PBqg5GbyUCyp6BYos/jUJpWXp3bhHVcYK3ajMyjrwqqfhl6CMZbkBRL0G1bZXcvTjtm0OB
 0bo/Zhpo1hFGERDwLeW62qVwqUX2QxlJivKihJ4HJEe8dM1n5Q0s/p5dvqFAOHDqJxG91Z2dU6o
 +hb1L/M+PK/HmQbKXwA==
X-Proofpoint-GUID: Gjz_HDBiEzl5lJLQqmdif5v8iGpw96Qd
X-Proofpoint-ORIG-GUID: Gjz_HDBiEzl5lJLQqmdif5v8iGpw96Qd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130029
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


On 10/13/2026 2:13 AM, Uwe Kleine-König wrote:
> On Mon, Oct 12, 2026 at 11:48:00PM +0530, Kishore Batta wrote:
>>   #include <linux/devcoredump.h>
>>   #include <linux/firmware.h>
>>   #include <linux/limits.h>
>>   #include <linux/mhi.h>
>> +#include <linux/mod_devicetable.h>
> Why? There isn't even a (new) usage of any *_device_id. There is a
> mhi_device_id, please rely on linux/mhi.h to provide that. The main
> effect of including linux/mod_devicetable.h is that the driver grows
> many unneeded dependencies, so don't.
>
> Best regards
> Uwe


ACK. I will remove the redundant mod_devicetable.h include in the v9 
version.

