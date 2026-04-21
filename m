Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C125F55805
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9740510E71A;
	Tue, 21 Apr 2026 05:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rouq8wys";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QfJavGxI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167FC10E176
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 05:09:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L2B3MJ084436
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 05:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 10Q3G+V9ehfOUUDW/m71updYpbuE6B32wIfyLJjFPFg=; b=Rouq8wysxdRS2xJw
 L1N9LuO5ezMtjd08IOol2WATC4R6WN2xP7Wf08S0mEPV5PbIG4RsPQqRlKXKKs9m
 A4rdtxv6uZV+kKGb9WUGzIDAyIIt2MuLtKuf/39jr0DlGMEYZY0x/4zA1aS2kMAq
 IJb+rwCh+wqFFrBtW5NIrsh9yEoLt5rQki4wd8Rm8gCUcZc0AWJLufW47/9a4uI6
 vcFLJivhtwlWwzOX7DnjdqL1hExGAn/NjHk/JkwxnHm+hdZXFWSbZnpJgwQ7wYU5
 leHWnrFtoQ/1skx6DK85NPw8vLWuZ2NN3m+BWHEaz1xNdscKhztW7wEJCBPkvggV
 GDpg7g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81ksq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 05:09:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b461b36990so39317195ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776748181; x=1777352981;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10Q3G+V9ehfOUUDW/m71updYpbuE6B32wIfyLJjFPFg=;
 b=QfJavGxIUxizfe/DSTciPI4aSIbMoc7tkfSFi6yB1pMcq94IvVATVgZClHTUGaz/Kx
 k6TpSPW2JNWuWJgHm9tbeS8wVkq6G2o//rWkCmisf9lUHuXHBZQfU+JTP6T4qOMGvn8B
 N+ya0qHDlMximjNgjP8Jfi2eNjghRLFPifoViNqV5MVW6ACtuAZlJvoGxukKQHDB6BCo
 IX9XVe83yo60pxBBoXVv057lueA7b0LGSVffHfHn/0e6OSyIfO99ylUOfgXPjrP5uGk6
 WDqjGJw3uxMZVqm3u+NBViXoXPkbWEUyiMbLr21Yuoj2GWm+ak/gll43L9JrjcuB5MsZ
 kFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748181; x=1777352981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10Q3G+V9ehfOUUDW/m71updYpbuE6B32wIfyLJjFPFg=;
 b=r4JD/d8SBIHFqx9bt6W5UM/VcbFAyhFRc5qIJDf2izGarHIBg0nviWTMqj2gesJk41
 XwVBIMq6pImOZ6N5Z0CsrnuEAAHWolFw36NKFMv3peTO5e/ozG/cmQaEFyx7JoKO1rgr
 uR+MTvIJRMae3snbFPjnUCzkcXPK+RDatPwo0jBlHGGdhVIvNsrVIBB+EsNOAjfoQ7aO
 qFJfKwQEwhUGZ2obb5UeHPsmYUAcnVBR4N0/Drud+mYQ2CS4BmszUztlC9s56n+YPhJY
 8uhDmZ9IyeztYAqLwsct6aGqXm8Ondsn0TuSIWGoeLFHItR3dvrg8kn7VA7WWeYABqYw
 ysKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+viF5e2FIRuarlA18KAoMa8sP//NV2GMq21OSOBSC+LdwCWda5RLLqLoWQHQr7Z/eqfP/eGgVoNJY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGwPRzQRaTTVLsBTPYXPdTprl8Vv3xTZVeoxqTKiy19GB3OqMa
 PTvZunTn2OnSQNiYONwizxQWfUGp+hscEFNb+VCrUR0FFoRZO6/6RrZrD4rLJQQl26FzkihSjlu
 E7TfFsTKfxBDed/rDlukrqBsAzmLcmx6t59sWe5IF+BtCLlnwe53JzE13w/BNaQIZIyzJews=
X-Gm-Gg: AeBDiet39iwU0XWBQSXuUe4HaLS6v9cXporKXDbZbbBE7viHBLgxyUQBgbeIoq4r3fB
 GZ5aUKHa+FW7fS+82nfjp1fG9YPz+rt+VOlKvjNLXhFScYALWF9xWdw/l7gYG4JBilUdH2RP8ud
 zFNu636P+zzQdnW7fn8992pXtLlDRFEYGqGjfIl5I7KtbSht7nMB3Pl5leuklty7VwLNjSKXeP9
 yNU13UJBKe1ILMBKoD61ivj7uV1yiHh59QvLum+kgTpZKQ5VOm6vsGveatFVkizPYQ/hw2xeetB
 g8ZWykhjvR6R7I8kIOEnRm/KXdFfZiPZQ8KIZp8J/pZGXXRMZ8+AXM+y9vsVtBF5wVxSdzzcHJ9
 cCagZuFmrWY39OXyq/wR1X8gebt6CayLEDzKCcD/GMl5a3GLWQ+8l6XCiE/6zQycCHqXNGWr6KH
 1QO0HiIP4Ds1XQOguLihdnh1v85OI=
X-Received: by 2002:a17:902:7592:b0:2b2:4029:d77c with SMTP id
 d9443c01a7336-2b5f9f51fddmr113101355ad.23.1776748180976; 
 Mon, 20 Apr 2026 22:09:40 -0700 (PDT)
X-Received: by 2002:a17:902:7592:b0:2b2:4029:d77c with SMTP id
 d9443c01a7336-2b5f9f51fddmr113101115ad.23.1776748180458; 
 Mon, 20 Apr 2026 22:09:40 -0700 (PDT)
Received: from [10.133.33.243] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cdbbsm118563945ad.48.2026.04.20.22.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 22:09:40 -0700 (PDT)
Message-ID: <b2a5ef92-f312-4e0a-9772-4d430b80a46e@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 13:09:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add LT9611C(EX/UXD) DRM bridge driver and device
 tree
To: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com
References: <20260420061644.1251070-1-syyang@lontium.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20260420061644.1251070-1-syyang@lontium.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA0NyBTYWx0ZWRfX0Bz63uBleN+C
 ukoLJbB9T0FWabyB+tZENP9cFAv7qcOx8zj7BtngCWsgcYbQLl+Vs7uppF7pyevL8QY4fDTJERC
 AAieC4lAgJLohkMNkVoxpiK6nRHGEKI3VKQ3D9r6z3lihLIoYNDEs/pgqIJ7WiY1pAoBaQtlObn
 dp67ZRM67YA6serw4CA7YrueKzqmrNNtOTu3PUEKeG4XQCzYgZcsMj0G8yfJ2LDHoaV5kS7e07b
 X3lVHwEcX2ZkFQs809pzAHx+BSOAglfw8PJZMtuRJ/nyQ2PhlBtFVDSyD6fUjio+wxRBBP8ch3m
 igHDFj2h79yUc++imm8ROZ5Pt1eptdzLVlAtTO7KlueRJp+sSTpdGXWX3CgBZKC0dYGKL4UxE5y
 wZLZimjBXyMTuX8rTu6Ka+jaUtnUocJYa+APg/2bPdPpwxh+bfTppAhfP1VmUbTUMKixP36XfV3
 x0ZaZQ/Pgcm+G4KmADg==
X-Proofpoint-GUID: WNUz378XqnXCdc2CECFjhcMpvNCRo1-w
X-Proofpoint-ORIG-GUID: WNUz378XqnXCdc2CECFjhcMpvNCRo1-w
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e70695 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8 a=vv69z5vQd5diBoytfGwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210047
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



On 4/20/2026 2:16 PM, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> This series adds support for the Lontium LT9611C(EX/UXD) MIPI DSI to HDMI
> chip:
> 
> -dt-bindings: bridge: This patch adds new content to the lontium,lt9611.yaml
>   binding file.
> -drm/bridge: This patch add new DRM bridge driver for LT9611C(EX/UXD) chip.
> 
> Signed-off-by: Sunyun Yang<syyang@lontium.com>

"This patch" should be avoided in the commit msg, begin with "add" will be enough.

Thanks,
Jingyi

> ---
> Changes in v3:
> -dt-binding:
>   1. lt9611c(ex/uxd) content merged into lontium,lt9611.yaml
> -drm/bridge:
>   1. Drop the licence text, only use SPDX header
>   2. Sort the headers
>   3. Use library functions for crc8
>   4. Drop i2c_read_byte and i2c_write_byte
>   5. Lowercase all hex values
>   6. Use paged writes as implemented for LT9611C(EX/UXD)
>   7. Drop dev_info, use dev_dbg
>   8. Modify lt9611c_get_edid_block, don't store EDID in the long-term structures
>   9. Use HDMI audio helpers.
>   10.Remove unnecessary flags,Implement proper cleanup path, unwinding resources
>      one by one.
>   11.Replace devm_kzalloc with devm_drm_bridge_alloc.
>   12.Remove extra kthread.
> -Link to v1: https://lore.kernel.org/lkml/20250903123825.1721443-1-syyang@lontium.com/
> 
> Changes in v2:
>   1. Forget modify code, operation error, Please disregard this submit.
> 
> Changes in v1:
> -dt-binding:
>   1. Submit the first version of the code.
> -drm/bridge:
>   1. Submit the first version of the code.
> 
> ---
> Sunyun Yang (2):
>    dt-bindings: bridge: This patch adds new content to the
>      lontium,lt9611.yaml binding file
>    drm/bridge: This patch add new DRM bridge driver for LT9611C chip
> 
>   .../display/bridge/lontium,lt9611.yaml        |    8 +-
>   drivers/gpu/drm/bridge/Kconfig                |   18 +
>   drivers/gpu/drm/bridge/Makefile               |    1 +
>   drivers/gpu/drm/bridge/lontium-lt9611c.c      | 1365 +++++++++++++++++
>   4 files changed, 1390 insertions(+), 2 deletions(-)
>   create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c
> 

