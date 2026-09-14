Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02230C88E6E
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496FA10EF5F;
	Mon, 14 Sep 2026 15:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f2NdKtfO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5AYV3iK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E1210EF5F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:50:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0Pp91514371
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YjWmSI9LLOuF7sYbpE+FB6ICXzIryi3249bljTKVuPY=; b=f2NdKtfOUYGVlnBz
 sKa5mCo4BlYuw5G9NPaKCRUph6mcjLxlgTV/yUZ63Zgjtse65IARtI1F/svI66CL
 /ghW6/jH4lFsw48ok1ZU9vHkqRKz0iujyibu9wfQI0s/E+04+1g0Jtw8wpb4ESYg
 qZM+AWEVG/qXdkrQ3n6YcLND9CgTiyCKK7LfyvudS9Ts5uFdj/wbWkG2kiedNwNM
 Z+rr9MaORAdx+i+X9v6bwaiAYk9q0zslcRum3IxbvFjcuOmJebg3QDDxEjDXGDOY
 Q+4RQ9bsdsi8cJP0BB9dJjqBVw1lpYVU06HnV+BLG5RUG0ImxqUkItD/UmfJ1DD5
 bz574A==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k0bc4k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:50:31 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so2932795241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789401031; x=1790005831;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YjWmSI9LLOuF7sYbpE+FB6ICXzIryi3249bljTKVuPY=;
 b=V5AYV3iKkhcpxBxPSyRQ7p71BniHyTe5DvSWvGV//tLATM8+aF5A7MeJJfKwICQ8uV
 tajS5j1M1tpDgMuFrDFZhpebfHys0EZBx0RrUPTfpKK6/WipibXM+bs9PvDcQ/b0QlDJ
 XZEiLn0Vta3NCC42dlfSZJa6iSQSZJfDQrj8c1zknSG4QuSdyV86vi22exg9lmJJmdy9
 iCKj9uIbxU0jB1CUk3+bTfi4JSWfJtalEpaDYqanliJuooxKO0rvOlifnI2x6IRorY/z
 H3bJCAWzA/3R+Wr/4Kia+ZKHjr82GHGv5FNdqRiEJMfadheOGpMTYJrTOvhtzxFmhskB
 kTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401031; x=1790005831;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YjWmSI9LLOuF7sYbpE+FB6ICXzIryi3249bljTKVuPY=;
 b=S7n5SWoU1I3CkueZQK7Ox0gw+DyKWfFpsl8IVYQwljbBUHid5/KvEUtTG8jlQNnaf2
 hXZ6yVG6PzeBxcGnAi1sgi7dqbFSUk0DJOn9p4NyczJ9feIyukDJID411JAJEerlhfy4
 9AT7e37GWi2YpT45UevVPGAbvw6bDF0rFAAowlFn9ayJLCruvUo5+Rnlj7yipTOpBbTu
 G4RHocwA/hOLrAe+daeeGJHJqBs2FA2fEa781mGgfIQEXYwqV6rgiOzxNBVW5DNrFCWC
 z3q1+QtzZzZms/wbbGyz8wRXifz93nD9H9afBcBIt2XWiaTaX2v0Pw9TpkOc1OzPslHE
 EkbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy4kGesy2V3E9cMT8bdr9pb3eT94DMi5IcbZO+nrRAcW0BV+KhrKVx0saw7NVDUHtCzuU/p3feupw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljsi0UaWvB4Lx5oVhogVhI/8N/sN6pnyK5RJw9F2P1tDfSE/EH
 CcOiVicVgfdp7BDvW73nNDpLay64L8rLfZCL2Db9ryfMVa8rmW4AN0+bw1FAJefblZaKYBmYI5g
 LgfL12PVLQmTUWFsuX4baiXh2TVvAV4PAO4yWNVIITP7twW+dslWXJfY7T7QM6+gLuDJhiMs=
X-Gm-Gg: AYBFou3u5yCkOx3Vf4OD5/upXnAJ7Lzc22Mgln6iJBbeOw1DBTn2mAjyA7gYrzJqf5u
 IkDBP0HfUdiCezmvFCPcJK5HY2aKytTBzSmx/Ll5wKHlRkEPAGl8hqaWdKVeui18meqHwijZNqI
 NovHIMsru384VGKcQPyg7UTYw+asQGl+3EapmkFBv2mJioDB1cgEBzzxo7B/wiwCx5K6SJ0txf9
 Fp6dlOKapOSXVn6QUuABoSphXdrPgoqP19c0J/VLvzZvsjrJGMrj22W+Bsxw0GMDsMPsyNvmfZ7
 ixXwHdUhmqtoo4SGSHOtGrY7WayUTmTa+l3WgkHAK8zwedLGEXwsuJxhX7+lmUoGrHy10o/0veL
 ONtv2snTa0VxSFWfBiwTiBpTP2+IR
X-Received: by 2002:a05:6102:160b:b0:781:1ac:8232 with SMTP id
 ada2fe7eead31-79b58393a7amr2922909137.5.1789401030266; 
 Mon, 14 Sep 2026 08:50:30 -0700 (PDT)
X-Received: by 2002:a05:6102:160b:b0:781:1ac:8232 with SMTP id
 ada2fe7eead31-79b58393a7amr2922808137.5.1789401029651; 
 Mon, 14 Sep 2026 08:50:29 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d6a9d1dsm717375e9.10.2026.09.14.08.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 08:50:28 -0700 (PDT)
Message-ID: <c4eb78c2-ec82-4246-9050-74c59acf0615@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: Use consistent indentation in
 the example
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260913122910.99457-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260914123106.44CC81F000FF@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260914123106.44CC81F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX5cjscbj530PM
 YhZgP5Z11a38QbeGof882vGttN2CM7UEOOU+LLqBf860SbTmXu/kXms1/PT5FzxZCSvmj2xTyUu
 f4PYDQM/PXemKixWNF9zkbv6Xv/U+lE=
X-Proofpoint-GUID: JKKjjAJELFVAA_Z6_9jDMUljBrNV4F7G
X-Proofpoint-ORIG-GUID: JKKjjAJELFVAA_Z6_9jDMUljBrNV4F7G
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa817c7 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NWQlD2WTGmgqaikU65gA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX1q8zyOPFd2fI
 UOWvCua6t5lAM4fS26s/zn9ayYoh3N7txhjrv51SurH8lgLsrhyRI9YiGUoRzzwZ8iXaftBcrmh
 wXh8WS+3cCrnvRYUSwGRsxpTPS1YdDIdzNIA4F1NP+COtkPCCBsxN6a7OWE5xP9qWm925h7Ln9y
 GfelVz/Nvjd1Gw0cp9zH33u/WBlebCT+eWh/B9XNIuwQeuc38KqlKWqTs8OSXS4HdiFqvI/30tI
 OKFfThS8FIx+Oa9U2A3yV+F1kcpE7RZhRyBfURu4f9fjiKExiubaZWgeM8RyYI84ieIb/TdOnhl
 zYJ3sbEEX2stxjPTEYYZhLNzEvThomPHWy/DCwh483mLoYKabCagexGiE0dl9xHVCbbcKRfXVYc
 yeV0EX+mPFsAcqYuFb/7tuvmKZmkK6mz0UsHwVt4NQ5QNQDnlUOfx3nIHI5bOv0NyJI2Z55n+f0
 u+si3V97me5s0s2i5rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140226
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

On 14/09/2026 14:31, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `mdio0` block containing the `phy0` and `phy1` node definitions was accidentally deleted during indentation cleanup, resulting in unresolved phandle references.
> --
> 
> commit 3067fd6538b78515dc2a63a2028de505854e6496
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> dt-bindings: net: Use consistent indentation in the example
> 
> This patch corrects the indentation in various device tree binding examples
> to conform to a consistent 2- or 4-space indent style. It aims to resolve
> dt-check-style warnings across multiple net and wireless bindings files.

That was intentional, just forgot to write in the commit msg.


Best regards,
Krzysztof
