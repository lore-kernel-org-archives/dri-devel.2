Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEA3C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA0210ED4F;
	Wed, 22 Jul 2026 10:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aWLbumm6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hgmkV5lJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A97310ED4F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:59:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M9Dloa049586
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wH1sjaQosPgv7pAlBebSAlXiiHkmqfdSdHCV2kzhWcA=; b=aWLbumm6ygFLVY4r
 8w3MmrM8pnm1TWIgpO+xdWgsyz3aDj0/O5BBXcQ/XEl7wbhSsoVhGwZL7CF9o2Cw
 PBEgQXfencPRliSNr3zSTVuig+TbHyPrEt9S/77KdXpjAjdercwq4+k+VtelNFxU
 BwGOsJyeoOOEbfE5rsPGs3xuaFcL0C7kz5TEUqNRZgCgVc6QvcHIhePfBUJUmjw/
 uoyGOYgJM3U23otDP33GtchfnIgtAYDWlKxj34PzOStWeTrs9TJVF93kU8PB4tn7
 dhq4w1/dRx7vSpo5QEqPprl/TYw15AeUZlAzudvvaw37dkafl84rlalXEbTnR2Fw
 kn+mRA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fju228dt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:59:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8fc6b670b4bso101269286d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717964; x=1785322764;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wH1sjaQosPgv7pAlBebSAlXiiHkmqfdSdHCV2kzhWcA=;
 b=hgmkV5lJ8YmNVDBvs7BMXQKaWyL8IkkPBG9iv7rwwUGFeL/wmRIzMUNv+5v9rAHzY+
 P2gPmBg25EXjzj02oKChwzkQUHkcDnUqoEei694Te+k9WiBkeqBu9FTPWrBh+3UqQvPW
 CvJtAnN0Vxk2/daW05lqX/qGemNIT07+ZEh8gqiQvzcKB59eo/INaeVLwJVBK8KxZMtO
 JQZhcBAwbQb8OkR9J9IkCXQPgTAlPSLJ4ZuhPPd3dB9x6gdqE0BweFtYAGzhoaEba1n7
 16PgsqUuGsvC0d8kuNUOhpIJkPFlThPtI19GNxKeuRIyYfrGy29IDXMWnTht4ESmoI/A
 7P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717964; x=1785322764;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wH1sjaQosPgv7pAlBebSAlXiiHkmqfdSdHCV2kzhWcA=;
 b=PfdPwIpD/t+rOuaZ8/nQzxLWmqoZGVe6scahWnZkcwtrjE+8W2FZW9+LYK5LTVpB+x
 RytxKA/kZMY9qfIdBfFT17Ksl8NF9LiYXJus2ugBNdu0ty5pCdC4qO4wnn5f+7jboRZ4
 eLnFj8UrrPEm8fF23j6ARMIddLv5N91DrVIUTEJ9s5tPrUGJ4OXLNM4gJAkoYCtZ2/2W
 959uQbL1BtHQG+ZGTCidLCn4pd5NVM8bffT+x4KEaMWlNP9dmtAPlyQ4y2MccwUyhgcK
 INWP3Na7YWi1Q0VWwZBmqht7BtcoIRUKzcSPrHwFkuJingFZOJ0qgKfVC2zNG4j6vYvV
 Eemw==
X-Gm-Message-State: AOJu0YytnESZmy90mYQ9gfBWTqd5pgsgykfvBcR2j3biJZTOkOSnBuk5
 tu9UaQPHlCW5cgWRXPnHxlb+/ht/ZRXiNmGwaa2cL9q8il3n9GhtneBP9qCoYnS5FWlbo6uBC7G
 JCkm94RrK4ElVPlgyXsJySZJdIO6T4fpL4zHuhafcvqnEcOeiQyEHt3L531LO+JUnW01z17c=
X-Gm-Gg: AR+sD11RusCnCroKmbqp0C2eHykchSWtu6DMUB5dA2yuwXb1ICaFMKkeHXs/mWkXtu7
 q2HNqrQKKBQ8xcdhRIOetK1RrzoA4Tzj4J/GUTqhRxXI6aPkGUvpB1+b/AJPFQyqgcE0KmE0P6/
 go9dxw1wFIwUD1CP3L5mCL2bB62fMATsaNbFFWAhHd+oxRwJCplNaAQ+vvvez3STISG3RNkB/c1
 eQoUmfJWykIZ099nuVHGoqRp1El7iWP2VWDCKSOOSHBIi1HQD68dLojs5skVIX5v1g/LA3HaXo1
 QVjGIJSi7bFMm6S2Z+PYKao+nfXgPafG8hqXBkjVlkyOs9RPKaGKB2nT0tfA59FY2DTFSjObxBW
 bQj7EiUMjAX8MggKpfOW2LuLS9AmItX8VvNXQuzIYm/G3zV326h0XsPemYcqKVRrOug==
X-Received: by 2002:a05:6214:c4c:b0:8fd:6de3:dd84 with SMTP id
 6a1803df08f44-907784e0754mr238777786d6.58.1784717963705; 
 Wed, 22 Jul 2026 03:59:23 -0700 (PDT)
X-Received: by 2002:a05:6214:c4c:b0:8fd:6de3:dd84 with SMTP id
 6a1803df08f44-907784e0754mr238777596d6.58.1784717963199; 
 Wed, 22 Jul 2026 03:59:23 -0700 (PDT)
Received: from [10.111.173.228] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e18d4sm18435106d6.23.2026.07.22.03.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 03:59:22 -0700 (PDT)
Message-ID: <45f5a552-0365-4d33-8ba9-ce45d48ed3ba@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 18:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] drm/msm/dp: split link setup from source params
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 sashiko-reviews@lists.linux.dev, freedreno@lists.freedesktop.org,
 linux-arm-msm@umbar.lan
Cc: dri-devel@lists.freedesktop.org
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-6-bea261bf4e7d@oss.qualcomm.com>
 <20260720062728.89BAC1F000E9@smtp.kernel.org>
 <2ysoleroryfoh3tosv54iyq5t6556k4uf2hkp67fofy7gizkhp@3koilwev3czy>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <2ysoleroryfoh3tosv54iyq5t6556k4uf2hkp67fofy7gizkhp@3koilwev3czy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4Bi7mTe c=1 sm=1 tr=0 ts=6a60a28c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=k0yApWwVdG9Lq5E6IgkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: OXTNR6YI2cbvGUd-NbJttEm8qGHbuGow
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNiBTYWx0ZWRfXxVc9o5Io1bCn
 2hhdz+42k3Ry0KJmAmUVtxzbXyqDKXULZKl3TSldp/FX5yYl66atAy/alIgM0uEDTmNXrdzwFD/
 rZUiUkAKSUImlWZCg/cBadX1RYgWWbg=
X-Proofpoint-ORIG-GUID: OXTNR6YI2cbvGUd-NbJttEm8qGHbuGow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNiBTYWx0ZWRfXyNpnFWNIJTgG
 /R/F3/tOI5futTI6Gs9PKh2DBdLx0nWjaDogvronOFGOGwdUxQkshHUAYoDSfCdvfeJ1FRbwZnr
 LUVcqEwjG4h1qbPMfAZjiKFI8O3PJ36grvepprYlxgNnF3UZykk33R8Uk764RM2Ls+r9DKwIiTZ
 dAF5uzmhueUmh7x60wV/zuXtHV6xvwKEwCBHO/igGHfK7IgHc9nffx7ZErR2Q7ExMaVbOazZiO0
 GVK9xlbUabe/kN2rANFgF4xk4QhhFg3DHyKzRlVJjoIYNjbCwB7IoFhHJe4VkfNhtj3R0UByD66
 fGyOSkPQchhMEmhToBc2BwaM5file9AuXKBcupcLcI9WlgcfDNju2T6TVZxBy4Zq3B058m6LRfk
 O80PIlFeo0iYqNUfUrQ7jz7cpNejRjr+FQkUj848+YdOcmLgzaik1cBBRcopvCOcoIlt1Yas2NI
 ViAaAIzM8srRfL7PKbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220106
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



On 7/22/2026 2:50 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 20, 2026 at 06:27:28AM +0000, sashiko-bot@kernel.org wrote:
>> [Severity: Medium]
>> By splitting the link setup from the stream setup here, are we exposing an
>> incomplete read-modify-write in msm_dp_ctrl_config_ctrl_streams()?
>>
>> When MST programs the link and stream settings separately,
>> msm_dp_ctrl_config_ctrl_streams() will be called independently. Looking at
>> msm_dp_ctrl_config_ctrl_streams():
>>
>> drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_config_ctrl_streams() {
>>      ...
>>      config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
>>
>>      if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>>          config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
>>
>>      tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
>>                                            msm_dp_panel->msm_dp_mode.bpp);
>>
>>      config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
>>      ...
>> }
>>
>> Since this function reads the register and bitwise-ORs the new values
>> without clearing the existing stream-specific bitfields (like the BPC or
>> YUV bits), won't this cause bit accumulation and hardware state corruption
>> across multiple streams if the link isn't reset in between?
> 
> This deserves a comment or a fix.
> 
I'll add a clear-before-programming step for these three fields in the 
next revision.
