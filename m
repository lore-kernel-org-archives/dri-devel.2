Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904D2ED7B93
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AB410E5C5;
	Tue, 14 Apr 2026 09:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Suhm7e8m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jaM/nXvA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991B610E2AE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:45:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E6ZQFh3505309
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uoVEP8DtEXDmzrfxPRtDx5EueSkuJ2pFu6DjvKwz08U=; b=Suhm7e8mZGqcGosW
 9je+YigAKvzd5Q8YTF4XfC0yZ2BfpxQDLqaGpSJaampK3812YalnqDcGBVxYko5U
 GdFwsqe20bLeA3OPm+cN2L4EUjHsQ8tRdbwkm6M0ZcvHZQ4xrn6Qkf6o2/pfx67l
 c5yrVPdjEwnkN+vj687HmoRA1WNgQsAPMznaIxgBUuziNpKFurLiOqR/gYRHwGcD
 FkzKSI8t9EgVsN3DdxNg2Lx68yyoEgN9ZsfaydMw9GJ5e4n+dyJqqLLj6Y4mC6uV
 bNuqLLyaqwuhQKbXPYFI1YYJm0/F/yI+K26XxOKZuQDUqmaZ+8IgA8SJmWWxl6DK
 WMonVg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870j6ju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:45:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b241be0126so105168065ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776159933; x=1776764733;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uoVEP8DtEXDmzrfxPRtDx5EueSkuJ2pFu6DjvKwz08U=;
 b=jaM/nXvAmHpqCnXEMhmCZq3cBOrdQMDYeXZ0O+gTYvP7cPMNy+YlMn97dZf2xkFAg2
 rb69J0meh79a0QzpsrAUzk88uLTAYQhwW+Z3W/PAG9vkTqf9E6iuhpszgpNbILRztilD
 fcopVGcepZUn8pgA8y6BULAk+NlcnxyH67kwqkGPpM8QdZIFSsh3IrxGkAcgRtwa1jJ0
 CZBO9kbcn/0VCN/cVyElCo0IIufsUVyPnQmEWhYNQ5VCtENcIXH9VUvnQLJzwc67r9tn
 Ox0To6e2heZ38oZDcfP2dOqPb6qh5Nm6Q8gTgRFvHKefQJG7avpxtvEF2wk1UXAP1FI9
 NvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776159933; x=1776764733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoVEP8DtEXDmzrfxPRtDx5EueSkuJ2pFu6DjvKwz08U=;
 b=NH4c1I0YwNI+rpVb3hBfXanCqJY5QTHzRQ8jM2B9CygbUzglaPlwEmYhxebXpEO179
 6wMzRG2QsVQlJMWSJQtg/4enO141trEtazHcdls9/pLgl+IjxqrxB1xt7VbVDxXqlw1I
 zySyl1ScBa8gB6XPGAWX26JNHcaVIzRuMI+P70/0vyorMlUDOlPYa2ixPiMlH8jp/MCN
 sA+6avGTZXACAwBZn9BHOao5hvBy+r3fkVoInLp4PysKA9dEMm3Z/I2E/O2lFciYHRAS
 fpy7OBzxZIjfFXpfUueC/TVjZoa9oG+TJt6Totn4Yk/ygBHBOEZILtcBpUKfyfSjNo6g
 Wheg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HY/GZ0aisPq5pGEe0mur2RxwjmZy5dyn485pRne/RW8WEYFLwGjV9D4KV98fEB+FnmPKIZ+E6NNM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywlsfz8Y8E6en5sB7XM/lwSAfVEbrZ7AYEIfsB0N7FpLgGksLuH
 K4kjCxmvFULiROX9rslMLDQljyxWJWHylrtUtBByyM0eQ6toWH1tYhR8vHszJBu1ivuMMpASW8d
 KRtBvIsuX7BPhpPa9dWto0VtJyg6g8D6mRQqK9w8ljhSz9Ni7m6q7N0eJuhk4CgT45nY4ESM=
X-Gm-Gg: AeBDiev41YLyCZPIctHKCeNJl0mGDlUcJUGDTQv74wEmbyNUXkU+wphV83cvER2NPBd
 pvG8A3kWul5OaDhiyxDu5oSQ5/Hjn4e8Qsg9PGQABlXgHylSWqIW9vKZ2VotCY9I6sZLLX4Rr0N
 kHi5CnuUJP/1OtGZzrt4mQbHVYVAFQffAbX0lkUIEpUAyjxPBMlxAOTdTjH544pTDVQBdskjB+L
 z28Wzt1GSwovTXs76U4FTAzIycHfBriB3cJTzIN0W/OCLLaHTqQTPRrUTyX4bDqW0uCye7YuphH
 zN/O7X/adE7LsbB4O0iAYu/hO25lY4G/Q8YOKacCZ5rhHG+yUiyaS9Ao4fRbSNKRcJNxZhpXOFd
 oE0XZtmJNhIun9NbYc9KnqfRuHjoKG3+CyY1oNDvSqd1I60GRqVvL8Q==
X-Received: by 2002:a17:902:cf0d:b0:2b0:5cb3:e4bc with SMTP id
 d9443c01a7336-2b2d59ae7cemr166707605ad.16.1776159933038; 
 Tue, 14 Apr 2026 02:45:33 -0700 (PDT)
X-Received: by 2002:a17:902:cf0d:b0:2b0:5cb3:e4bc with SMTP id
 d9443c01a7336-2b2d59ae7cemr166707295ad.16.1776159932546; 
 Tue, 14 Apr 2026 02:45:32 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f2f8e7sm134928975ad.65.2026.04.14.02.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:45:32 -0700 (PDT)
Message-ID: <5a2fa53c-a895-4c39-9670-c6d383ca17a6@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 15:15:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] bus: mhi: Move sahara protocol driver under
 drivers/bus/mhi
To: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, andersson@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-2-47ad79308762@oss.qualcomm.com>
 <0a2af0d1-27da-4f60-952a-409a5abc5647@oss.qualcomm.com>
 <sab2tgxtiftme5gscknsl7cfifpshtlrnnihbm2g56ppbowcit@bg4bzwuta6a6>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <sab2tgxtiftme5gscknsl7cfifpshtlrnnihbm2g56ppbowcit@bg4bzwuta6a6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfX1pHyYc760vEM
 8+QJ5e0QTByj48S0npUC9dwY4Sg7J1fhwfIPZ8pjFteuHqIB8HelmtaiBqz/pBC3evja5Q9OcLu
 o0rHLEAR7kJeBtkr/U3tkG/AZgUkKs5tOLP9P3e5rrZImulIocC/BY+870LvuTKp0OFavUSqTfj
 LKqvoxIJH+y5e5za7BE0EdHjcFjerAOdaDn7LbAzOIp9h3rKaMHwSO9BJqe2YcyCTfyAN4qHAsb
 qVzCk9KJgBCpUFylhsSm6Qy81LiEF+bKWiUVc2FtofZsJORuaxzm62WIE+qil2LWsQiiz2sZVVB
 GhFXMS/KOuhvDbRzFaFGJsFJqtUT7N4SejPwJyWxHbPi47FKMH3bVnxrNeACLL4RmQ6CixYyK05
 GZdu3QqxZyGcgu8nEY8pCP8hiDoGeKic15oJ4aG9X4QNcIpv7vsnVj7RZLTAZJnyVFhd0V4gyB8
 yBwZdG/AhoJgnuudDyw==
X-Proofpoint-ORIG-GUID: l6HQcI-1L0hmDtwLizlPLF0jsuZ3rObC
X-Proofpoint-GUID: l6HQcI-1L0hmDtwLizlPLF0jsuZ3rObC
X-Authority-Analysis: v=2.4 cv=btZ8wkai c=1 sm=1 tr=0 ts=69de0cbd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=W_4NKV7oC5Mk2jKmMQsA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091
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


On 4/13/2026 4:34 PM, Manivannan Sadhasivam wrote:
> On Thu, Apr 09, 2026 at 02:20:02PM -0600, Jeff Hugo wrote:
>> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>>> The Sahara protocol driver is currently located under the QAIC
>>> accelerator subsystem even though protocol itself is transported over the
>>> MHI bus and is used by multiple Qualcomm flashless devices.
>>>
>>> Relocate the Sahara protocol driver to drivers/bus/mhi and register it as
>>> an independent MHI protocol driver. This avoids treating Sahara as QAIC
>>> specific and makes it available for reuse by other MHI based devices.
>>>
>>> As part of this move, introduce a dedicated Kconfig and Makefile under the
>>> MHI subsystem and expose the sahara interface via a common header.
>> I don't think this belongs under MHI. Mani needs to confirm that he agrees
>> with the concept of moving this there.
>>
>> The Sahara protocol as defined by the spec does not require MHI. We know
>> that there are Sahara implementations over USB. I don't see a dependency or
>> relationship to MHI other than the current in-kernel implementation uses
>> MHI, but there are plenty of things that use MHI (qaic, mhi-net, ath12k,
>> etc) which are not a part of the MHI bus.
>>
> Since Sahara is a MHI client driver, it is OK with me to place it under
> drivers/bus/mhi/host/. We do tend to host the client/controller drivers if they
> also bind to separate top level subsystems like Net, WWAN... but for the pure
> protocol drivers like Sahara, MHI can provide asylum.
>
> - Mani
Thanks for the confirmation Mani. I will keep the Sahara driver under 
driver/bus/mhi/host/ and also move the Sahara documentation under 
Documentation/mhi/ directory.
