Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26804C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FE210E109;
	Fri, 14 Aug 2026 19:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bS/7k04i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XCPX6cHm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4485B10E109
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:16:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EGhjVG2210040
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K3K1UtnTIooNfwxe0CoLAE5m27qkcblQuiHmrpFYzqs=; b=bS/7k04i/xMvmFJy
 DuabdEtrnD9QD7GtmGclFbYDsgf8HJmzD4s4TVcYv7s0DLSlJizYHpCD39zXLc9p
 2Mxa6gVeEu0kdx1jTnQoX3Av8Z1ZX1RAlMNf3RX3clinqjPsrwo+jgvfdhZoRCDx
 j//s4ShUc5X80BvEVa7NGuNo6hs35pypO/ffUeHWf7zmWnW2pXuKnF01bPUh0Es1
 vkolZG5wHFo5icFCcdSu0E20LZZ9RtiZf9F2RQfgyiR0gmotP0rdVCArnHgAzbbj
 TygAQFFKWv8PpUftWbmgs5SoC5pgZ3e2Z8FtI/ZbUApA+fq7OX3mnyCbBKAZFrS3
 hZ2nVg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2063ag23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:16:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb835525b10so1553940a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786734981; x=1787339781;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K3K1UtnTIooNfwxe0CoLAE5m27qkcblQuiHmrpFYzqs=;
 b=XCPX6cHmxXEeRlGGgoV2/Xf3gcsY38WY7xadxjWex4LZ1kTf6RD966UQpNqs6o+uFF
 45e2EHn2+jzlhPS0yYHHAl/RmJ7amOcJDGbSuv5sAZkhoERzbdsfN81IkVf8KdxGBoaB
 bx05Q3/IHov+MoazCcmaTCQKlc64/EQuSOUl8caYxUgpZ7M+sagtiWNejwU3KwHH1yb7
 Vfar0TDr8eHci8KZTBmfmyJKZ8L60wuoeeDii5vQ3iYcMfIHme//efXg7Cf0u+tz0DU2
 xh8Bpjh5Z0gYmQ9SYnmK5TTStl0etqkchFAwETRAI72vnJCMFKWIN6YblxJSltb/JkZv
 PQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786734981; x=1787339781;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K3K1UtnTIooNfwxe0CoLAE5m27qkcblQuiHmrpFYzqs=;
 b=rzcWRE+OdP14HJTcEElaajvkaUd1C8M7n1IOR0Vyg8638isRCbI4WbUIf2iHSMegcK
 xRBHB4I9aHdE4KwqmI2kAAhQpN/A4Tn2GWKsiP28Sm2qKuh2XFQVNhEJ33+jOSzfHl+v
 wIjxBumLtksKkSKfm8gq0UxBrQ9pDOahFaaln2bzKgAp9JxTm1hIxbaGriJ3wh94efcA
 lm2klpPHc0k3TcaW2F+5Wml53mWZo/G9G2bb90qzWmjx3ktwOkyyqli7NmswZTW7wEWz
 XRpAYaPHi2R6oFvCUvBAP6jaICLiBY7sSyWZZIi3+zmtiXCwbHAocqpP9XUJQD8ka3hl
 FKVA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpf9WVRLijbpFifk5KjWQ1QxYd93HDpurtbC8ylUbcYkA2AAcccqz49KyIVOgz2mMbSSCCpPSOJWqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9DynAnSPRPs2rCXVEmFalOx+45eqS75DCxwoMIdg1kv52771Z
 nsD5KHffgIgkoDsc3s+aAB8rLzqL8XrLdvP59Q12r8018x//X4FCN4Jl4LV02Eunj+8CiYNgMvx
 JA6shEFrizvwNS483Fi6qxinvyE+Lh5TvOehDXrmYX8JdnkQWQPMBu7iQS80+1IO1t7hUSYk=
X-Gm-Gg: AR+sD11ETPJiehHj5JVlzj/uvy/PWirZ1v8iEqI8CUoCvQjDr9D2mDqpGA6ob9GxhHl
 wlDxvTGS0NJCMPXHdJUs/rruzRFK+1IGNCKGIXrYgYsDsXXnsetNFMBvw1jAmoBl5A6BVP/xYq+
 RvygHAM51ufBc4S08jvpg3u7enR0UGfW7zoDhRY26PbGTlrIGWNxebq11UCiHenxzt/0iZIdAo1
 WUeob6JeqyY9qD/fFGsGQhNqWzqQ5b6mo2PdSZsQYF8oh3ziEmts4KSM+nJPR8DXAzwhbv3T0nK
 0+9HuvCGK4xfacvzi9gDBkxsQ3UH2SrsxeEUGurH8WoFSj4rWOgaf02y0b1k7gwWfXiID87Xl11
 WYGuEdfJbD59LnKGW/ex4YLiwRu0fSENukud3AikcCKUwKZCuzY6cCA==
X-Received: by 2002:a05:6a21:4ccc:b0:3c3:94a8:7c18 with SMTP id
 adf61e73a8af0-3cc71fce889mr10317254637.37.1786734981028; 
 Fri, 14 Aug 2026 12:16:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:4ccc:b0:3c3:94a8:7c18 with SMTP id
 adf61e73a8af0-3cc71fce889mr10317200637.37.1786734980542; 
 Fri, 14 Aug 2026 12:16:20 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d5bd918fsm7110853eec.2.2026.08.14.12.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 12:16:20 -0700 (PDT)
Message-ID: <e046aaee-2da0-462a-a72d-f2d65273d0ec@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:16:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel/qaic: Add missing <linux/device-id/mhi.h> to .c
 files
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE0NyBTYWx0ZWRfX0180yULrY5fZ
 g6bS/hc055l7oP7b04ou3Ju72XLpeIpTOw2pLzP7HB2RUUOxbe7uZcNBhiuMWTJvRMznnLBgMoo
 QvAiw+Y0FlcEI4GhEz9ltzWsG8m0bzc=
X-Authority-Analysis: v=2.4 cv=Z/Hc2nRA c=1 sm=1 tr=0 ts=6a7f6986 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=8xJ19RJQd52KcKUxID0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: sa_5WrbMXTRDElQZdr38U8hg0EaTz6yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE0NyBTYWx0ZWRfX9qDaW8oe3ecC
 hopeEAwF8/7fArg8QEwSqvcjdrXZXh/OpSfxSDafCKdZz6+UkqgXuyKtWy8KnGAiIl0mrHiK7yl
 6vvb67sQ0Cu/GeAglLKmPMZOpOOvss/vas5PSgSOLusGwAeEokHFpu/WWlikxo6iIBkkUt9K2jm
 Hy4q9cVv1fM++niZiYZbShyO0qLQm9nqOBw0kEr7SaOCGtQZtQdu+ue9Ps6AWZNltffS0mMbhOV
 TqUl1O+GtMXYIsbn6ys8NracdGH6X//Vx5i04CAJZJmUa7Y9O5luo++9TWWlqyAl1jGFyMC6U6x
 WhqVbIFMYVcqW8FISCzTTixjEk6Sa39peC/7Pu3Qjqph/iqvoPr+LvEL4YFK4NixDBVwaHtBKAt
 4G6xLwkIJR6NavEVu0cizPhXNepJxTlT+jCgurL7wYyvNHAsYyMpSHBP4cqXANoV/rdLK8MHser
 /4GO9knnCRlx17XWTNg==
X-Proofpoint-GUID: sa_5WrbMXTRDElQZdr38U8hg0EaTz6yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140147
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

On 7/27/2026 11:33 AM, Youssef Samir wrote:
> Although the qaic driver is using MHI, it is missing the inclusion of
> <linux/mod_devicetable.h>, or the more recent <linux/device-id/mhi.h>,
> in some of its .c files.
> 
> This series adds the missing includes to the relevant .c files.
> 
> Youssef Samir (5):
>    accel/qaic: Add missing <linux/device-id/mhi.h> to sahara and timesync
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_debugfs.c
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_ras.c
>    accel/qaic: Add <linux/device-id/mhi.h> to qaic_ssr.c
> 
>   drivers/accel/qaic/qaic_debugfs.c  | 1 +
>   drivers/accel/qaic/qaic_drv.c      | 1 +
>   drivers/accel/qaic/qaic_ras.c      | 1 +
>   drivers/accel/qaic/qaic_ssr.c      | 1 +
>   drivers/accel/qaic/qaic_timesync.c | 1 +
>   drivers/accel/qaic/sahara.c        | 1 +
>   6 files changed, 6 insertions(+)
> 

For the series:
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
