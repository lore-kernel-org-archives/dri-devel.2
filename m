Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D313606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mg/YKwDX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=akfvZlyv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817A410E25C;
	Fri, 30 Oct 2026 19:43:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D990810E1EF
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 19:43:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIhxnL4119664
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 19:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bGx6qJiXLm21UoHQs+MxjhyCVQP4Uyn4ufhGO58Vffk=; b=mg/YKwDXjNT4sPSS
 zHJ/KjhTajfRCuh8o7XnjdPQKkn8VSnYjnIsnbyIEhg94zmXDIKiOPQJlUhTlE6K
 2JhR6X/Cbjws4VEztAiUqalx0ofpe/DOi9JcvImPuxNn2IO3nP6Hieu+c+OJGwWp
 PS7i2yXjr2YyK2VM27vAVwD62WF0pyNU+YfYk5fgyOH6Eke8mCha8F7yF+OHx2TB
 bDNO4IgKFiJv0cG2kfQES8MJs8kXeOfxaeiDG3qtoZ/U5I8+iB0BAx40hUEl06bt
 NdF8TYkbdzHL91dV2SH917+kOcWvaie72JboesjUDflH4Kc7SBlu9ozhsfGd+cJT
 GfmSzg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0sb85md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 19:43:43 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-193b5eb133eso1217660c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793389422; x=1793994222;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bGx6qJiXLm21UoHQs+MxjhyCVQP4Uyn4ufhGO58Vffk=;
 b=akfvZlyvLy+y/LfDhRDOpAWNwM7zqet5NrZmiSo2QG17xcjwRtJjA9GiI18GX/hw53
 Tl6VsqWe/J/9kq7ps+a8TFOcpOJtDLhnIUFhSQzlbacu7Jol9o1cJ/91YaGxa5ZH2zgg
 GcBycKWVu9M3LIifmcjpPh1RG874SWaxAUXr21pWuD3JSBLNUcJGfvQoaKYBXJ82YPuE
 k68PJyR5Mj5899Uuj/yi0ZQVTNyCGGgwh65Zf3jXGhGFMLo6WovkAgIoqJUXib4PIPa4
 I9T2/41eOElzzUsAQJkaSV64tc25hKz+7bc/qmWhQ8Up5APa3uNGZD+MY58xUj7L7pQn
 KzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389422; x=1793994222;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bGx6qJiXLm21UoHQs+MxjhyCVQP4Uyn4ufhGO58Vffk=;
 b=Jrahif5qWfTegtpRFaurTE8Yspu5fQUoCxKiW52gKce9/0nITkjsWNNRmrkI+E1wk8
 zOaY2AWbntAqhAkLLO9IIirf3vCGbdnBZZybBZZ8VP/U5LlxSAGAl81lzRnRvkoX5ogS
 PNSLvLk67vyo54MYnzal0+hT69f/coHrMbZEPgF+W6vNPiosIb+k3z+uqKYy02ew7FKq
 Z90QHuZjoLTinTCNHcyye80DtS3TNd14JD5B2y4dV8vO1m4dNnH3HKnZ6BOHP/mZmFUV
 dJlfW79OnzQs5xfHZtKcEJfQ0W5bMLfH6jrhh+s667PUbchw/KKG2q8wRcGUiOElxe4p
 lqcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRqr8nYJr24bGplvbRvN5ym6UmtUM6zu1Yv4pbS/mGjwIg2a9+1ysnZ1QB4xRwNtVhZmJDGkaBAIY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLiuDWsviRkBZOfGqmdLrWTHlIVebhqh1VfqnpQHEwgwUr6Z/Ed
 D7KqdINtOQZI/TT9IlCdbln9w2HN1sn6FK9kGMekcibV49llqpMrUNYoS5u4iPI0XFIxCW19/lk
 oZvD2wEA0U9N/cDzSDM3pdxKdOZLpHvJ0ZN79Vscqg0bZqeOzbeK4tO9x7zBKjv/M3ZB3ZBs=
X-Gm-Gg: AYBFou0xshadTNmZpfy1VQVWPrxzylX5tvTLFawkF8wklxws+W9xFwtjML7sYImKCkS
 7SKkQFPhuXgJmZWECOovhrPd7z5+qTDr2rkbYmadsMfuuae7vZCMlmzBwHDKzWrmVxFE2PWAVMM
 rtsvCGlBmfI/pd1Peg9+2e/dZV2CAlKtUiUluGMrzP8pGiRhWEylmjJiZ26dxevWKPlDnL4WXkj
 INU9sPwJx3yKwzPEbbrQD/P59zbmnAuotNrmKHGBw+v28BHYh1iQTDSL3jSOHYpBppOm7mhvHl0
 4EmWWYAWmWDbotrGJj1rwWFNFaU1DXLzBVi6GCAOvv76TStJBiQ5IP/CcMINFruxqFc5MiR0qk4
 yYqa2egcVO2z70ixfhWDDYmsYzwC/NBSFnuV/QWkdyf9Th7d+yvlqqxXjrMJkcxqqR8LxLIPZ2v
 TOroEwU+b9NCA2YskhSJtSzOY=
X-Received: by 2002:a05:701b:2052:20b0:18e:5292:2670 with SMTP id
 a92af1059eb24-1ac5d88cae8mr4358379c88.23.1793389422494; 
 Fri, 30 Oct 2026 12:43:42 -0700 (PDT)
X-Received: by 2002:a05:701b:2052:20b0:18e:5292:2670 with SMTP id
 a92af1059eb24-1ac5d88cae8mr4358362c88.23.1793389422005; 
 Fri, 30 Oct 2026 12:43:42 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm10965340eec.26.2026.10.30.12.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 12:43:41 -0700 (PDT)
Message-ID: <0f57c001-4c0a-4b35-8864-d83ed51d0abe@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:43:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-2-dc9f24357c4a@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-2-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tpzc2nwRWsZi5AMf1ZnPJo-NjeXK_mXu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3OCBTYWx0ZWRfXwj4P1aSygKmW
 mQ8KZKOO/fRH4LWxt+IEUU0i8yEoVCtXaGULE+3d7SxSNVrP8Z+piVkm0ozLUY+DWv6Q5rth1Dh
 0vv0f+KUeDzToQ1buOJBeiMghjly3k0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3OCBTYWx0ZWRfX3esvJT4BtfWG
 Tfx/MdxqLRdupdb7RQhL8GWJ4LVg1eOXk+mp9Pk/VWKCJyfEBjqX9zn6U9hw2ZN5o312ZYPR3a4
 P5iOiqO/1O1JfbZoehd4KDb4ZCDP/TMRYvCsH39dYc7zla+ds8WF7tAlN8ZgZ+IlvWEw8XI15Fn
 iAOzIU0RiMybJcUOgVQpBHYDwKbuLgHu60hhW6g7EuxkeNmHkw28jKlLPK68D94kK86ZyOVmXFJ
 pauWGsg5AnFCaTt44rcqYzypfe/IuTKDT3a83a1lGXRBkfkgdVyp/vzfQhrcXcBvN0EAGu1b9qH
 5tYY7Axa8NEJDk5Z6tJctzhfSJGQmEj1HTMG8el1XpECHhVzANfhq5EcCDMFE03IrJq7ctC5Gbh
 87r4ezn2HojAZ9eQX924pAzZkoNiGScr6YhhiX8VhDOLRG32Ol74Ya1jf61FjQ/19yf1cVREIAS
 Ovay0/mR6Nfq2QPXQ/A==
X-Authority-Analysis: v=2.4 cv=JNKuIMKb c=1 sm=1 tr=0 ts=6ae4f36f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lJNEF0nvcUjEJBKM1O0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: tpzc2nwRWsZi5AMf1ZnPJo-NjeXK_mXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300078
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/2026 2:45 AM, Kishore Batta wrote:
> +mhi_sahara-y := sahara.o
> diff --git a/drivers/accel/qaic/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
> similarity index 99%
> rename from drivers/accel/qaic/sahara.c
> rename to drivers/bus/mhi/host/clients/sahara/sahara.c
> index c7c0b3eb4b65fb7776a6c724cb3105046cf6f7eb..75c0cf6010e1506fe661cfd110112bbb37465880 100644
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -
> -/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */

You've been told multiple times (on v4 and v8) not to touch copyright, 
yet here we are on v9 and you continue to do so.

I'm stopping my review here. Between public and private versions this is 
the 15th version? The 20th? I've looked at the majority of them and I 
see you continue to make the same basic mistakes over and over. It does 
not appear to be worth my time to continue to point out the same basic 
issues version after version, and thus I think I've concluded there is 
no point in continuing with this series as is.

For the entire series: Nacked-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

To proceed, I think someone else needs to take over ownership of this 
series and address the open comments.

