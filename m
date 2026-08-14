Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25226C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A8B10E2F0;
	Fri, 14 Aug 2026 20:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDtbUOMp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f8x8ipqU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA9A10E2F0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:01:22 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EJh2Wd2509909
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N/HNCXReZAADEJUWfRzTrqJYptVDzlytOwMcdNySHiQ=; b=mDtbUOMpqWwlT5cz
 KMqdvaFb+kNYPsa4MiY0bpDueDmvuDbfF8XS2FLW5zyJXRt5LRfO15ve9+DEU3C4
 9MLB708jQYGYV3e0UVVb08ua9qsZg4ZF6wIq1uMj9Y5HonMINR2dzksZiGaLXcjR
 3pxZ7voqekWGfimOCXRTXfsb0IxOZ5jscvVdcTV/YLhG2uSYEoouvdvP9CgokFTG
 mUTlN9bura1Ga2qRvDYiZFdIxm5v23CuJY7ejQUxCTY8m4TmuxYor4CiROaBBWcv
 ADAPyxxoNH6Tc1iPFaJepEz+9J92GqXZYUzpT/clbSq/Hom33vyJ4S9QqEB1pcG4
 Urr7pg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g21d9jaxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:01:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso1785533a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786737681; x=1787342481;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N/HNCXReZAADEJUWfRzTrqJYptVDzlytOwMcdNySHiQ=;
 b=f8x8ipqUpe71z9X36a2o1wXYQYfNtynrQHL3r90VG/51NSgLNHfSyHzezumhLlMWmN
 4tjGwcEgSnG/ascvAngTJq5XHLTfBkNE35z9ALa1eBpnmqVQ5u2QG1N+Yb71eUH7HgMs
 VOP4IKfMIifXJkxPBgc9X7KcO3MUetrG2IZ2+dVDPILgcV7jFyvPX+pg+7tA4vteVxZN
 lHWmwo/HW1u0cC+vSZ8HFSNIrbl3ZsHDEhoQlto959RwPu50+/aNV6g7ed0/gtJtyqqG
 O665hooxeqxytc0sDtLZBbJyNCox47tAJTj8t+3/rrorU/PgwAbCotgr4w4yJgd9dXyp
 ohzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786737681; x=1787342481;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N/HNCXReZAADEJUWfRzTrqJYptVDzlytOwMcdNySHiQ=;
 b=b8bSCad2+TTGBoaQ7Uh2Rf+hwswS+nk22KV8DPW4vfOWo9ul7HOg2MrMI8u9xVbJbm
 dtesDIxvC805OQ8or78sOzwP1U61neTJ3HzHZ/mKdSG5eerU3y/CYvWxCqTmPBbrfBe4
 ZmBvt3f7UH//y1R+Dy1FumllxXKoalUhVAfZjDNM+SnAjUztyf/IevGhMT5KplmNEdm4
 ttu8sn1uznkKNaWN0eVXSOoouIoBxPX7ZFTCDQI4/MHQfQ2Reak/I6104xWqasebmhLP
 NZ8as564/ApkFb/vJSrAf51EVO57CSrQ6uleYTeZbzI7dqBFDul205ziBOMij2qNiaki
 LIdw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxtDPEIcyRY8duEefvj7gw5SSDNPvUcf5lyP2pQbLFw9PDW0wxrJ6BLP1kxMJI3lUcxond+Mc91Fg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYoCM//CAt/QD+P8iDZf4rrdpeHNJDpRlY1ZslzOh5iL/MV+uD
 dOYEZtD4mSERUzA0pVqFTStcjC3ooN2ddoDVwLtbh7dvM31OaWDbqYKbSk+IevhQw2lTAArqQpG
 MVuq1zquuE6JH1tB9uui3A1X1glsGmYf/Ib4UF6H38l6s8PFJF5d6KfxCTE39C9+LnAasZ2o=
X-Gm-Gg: AR+sD118yisxo1DAsGhD8643HV+lTzcHBHda6BOnEYW88zkkTnYU7C4baakicEVWIWZ
 hLRW7p5l9KzpK9Xqb1WM1wobUqkmGkQ+iWzWYtnhP8g8ctNEmTBp47sYVJS4dEUpIIU4m1P27TC
 kYFJHDpJzRVGpsuLU70r9WcXonnqccv6RA+mSYzYMKQF1o/HH8I7SGHhzVnKSoz+MyEoeZRBzfX
 NxZ6ERtnB+UnoDbCYH8xHkhlG5xLwu4K9KMti8nw4MCRXIKn4XqCXMzIX24HhD0gwTMQQ1NB7S3
 zDc/rA08T8If5PuvzzAlqcK9wbG/S3Jes85pIsxZeDNds0aQ/tCogoNVvNf7P29XJKb/63StUFv
 Biycc+TYc3vToi2VzufRyTlxpaSHrpZQMqyTDAR0pPCeDdHC2eivwzQ==
X-Received: by 2002:a17:90b:5388:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-3933b8fc728mr9601313a91.10.1786737680585; 
 Fri, 14 Aug 2026 13:01:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5388:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-3933b8fc728mr9601261a91.10.1786737680062; 
 Fri, 14 Aug 2026 13:01:20 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d5bdc5c4sm7756763eec.5.2026.08.14.13.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 13:01:19 -0700 (PDT)
Message-ID: <c5b93907-6149-481a-afd1-4ee1d8440f5e@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 14:01:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Add support for AI200 virtual functions
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Troy Hanson <thanson@qti.qualcomm.com>
References: <20260814164125.3652876-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260814164125.3652876-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE1MyBTYWx0ZWRfX2qoiSI3rWfSS
 Yo1Dtqpsxj4dszvgthfgMP3tH9HkO1Sw+q5u1LIUOVSA8SIVYcFQhPW5z9QDnwFSvlYuAQeqLYo
 9OnD8m/8+bOVGj6+8Sg+saPACfLUivM=
X-Authority-Analysis: v=2.4 cv=eqzvCIpX c=1 sm=1 tr=0 ts=6a7f7411 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3CdRq_fta2TT3tACHWIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: nSufXjNJqUFGCNBJ_fUVl2_sl0mHNCXi
X-Proofpoint-ORIG-GUID: nSufXjNJqUFGCNBJ_fUVl2_sl0mHNCXi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE1MyBTYWx0ZWRfXzkoZzF/sNT1o
 Q7C3F7f7MrJ0SE/qSVwek++tZKDaZVG1PfwQEkHjnCEuk0xLaCBD/1SwdL7lbyajL5TbSF8gZYo
 AlXYI2+uSSOqrUUlhsesTRpPyQcyTjUtuIVhRxi2rt2kggWKS+0VXw/gsk40tRdvZbFDgNOgTUG
 /der6PoRWZU4c6nO3yEp0Cp2Z+e59uuWyj3B7HbLGJuKAN5QTGaN0HROOivrFDoXofeF2INihcA
 b8pXovtxLur3/JRaMhg5B5pgDEWoVKl/4xuQlaYMah9Ary3P6hytCX7T7RKeW8bo77Q6OHhAygY
 77yiLv74Z+/uHWLsI8vXaekBACfYISlx1Xjte+FyK4pdw4RLDOIWyc98bdGrqFZAKKgkWuKtr/h
 9TEMDkTuiO5DVV1nTk3rLVdEyonGDrozf/KfJ0sb0JrZQugFF+JsyJqD9kuVeCiAFuhfFcK5of8
 awec02JmLZh6h0H6+eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140153
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

On 8/14/2026 10:41 AM, Youssef Samir wrote:
> Register the qaic_pci_sriov_configure callback to allow VFs to be
> created through AIC200's sysfs numvfs entry. Additionally, define
> a new MHI family for the 5 channels supported by AIC200 VFs: NNC,
> Telemetry, IPCR, Loopback, and SSR.
> 
> Co-developed-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Zack McKevitt <zmckevit@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

I think you accidentally reset the author.  Looks like it should be 
Zack, but this is formatted as if Youssef is the listed author.

Looks like Sashiko has some valid feedback.  Please have a look.

-Jeff
