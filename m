Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD91C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481A310EF45;
	Wed, 12 Aug 2026 10:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/tu1/Vl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ges3xHPO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FD710EF3A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:08:55 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C9fluh3082816
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mpmAQvf63WFWZ8A0PHDHvJxNSfZra1rqR63BiUT7B0E=; b=W/tu1/VlrSvlae9j
 HXVw2pO+K0bPd6C4A89ekThl6N4CzpnsWPQtZg0mLfT4a/G7WYJlP44emaSvhNjP
 5p7cZYNEinl2M2vQAh+jyYdY21xcLxFYf+VqeZNzO6C5nzcXzhWcG2wSYvQha8Yj
 0+QPBPSTR317GqqBHpkjEZIyh/feeba3o/suvjQh7I3/g8QTFlTv+ddqqZj80x3e
 BCoBlLkGab0BQTXoOB8j+HewEh8e8FsEQOcVYFYltBaxXiaY5si7+W0SfjYMGvhe
 eCvcLPfjDNsztY2tcTB3luWUtC+sIWitQo8BFL2FGg0fsmp7o8dsR8Lr0QibjFA7
 dr8dAQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrk9up-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:08:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so7460821cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786529334; x=1787134134;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mpmAQvf63WFWZ8A0PHDHvJxNSfZra1rqR63BiUT7B0E=;
 b=ges3xHPOeXpqL68NCVWuqExi/3+/+kh8kUX6DdlWZMs/MEBtHUVsqPuS/xLOETQLIh
 7l+3GuHtKJKcbWmqfm0NfoUMYkuLSpsGeZytpazyWzqTD0KAm1A+QstLYZiCqgXRT3MV
 8YGcwzIaB5GPnbxEwdgSI2IpBoNj1KHS0vqpG9N9osIUajFu7wOTTrHXeKqvC4A3Os31
 rZsiySFjpfu0NL/46qi8kD/UxibBNYOpX+6CzB1UFBUtdUL/27u+jKuhneGyvjIWw3qo
 k9yG22xaCcGTliPFRLgV75usaKAzoTHnlHKNPZUiASTz6Ggr/Y1LKnWmnzz96qp0y/mk
 3CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786529334; x=1787134134;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mpmAQvf63WFWZ8A0PHDHvJxNSfZra1rqR63BiUT7B0E=;
 b=Q/zSGUX15/fDG+oAP0kQEDcjsw5mMqJepjIOjpiWA+eOyp+6eYwueN3oIHJNgrs0RE
 SCOx/+AlJO93/IaWgmRjCP9wWbdCiojAQ88bciVNNTv9r9KyFonoytVJ1/El8vM8aZAm
 4F/J+ErzOmKfDTAmQ2tLSXcd6m3opJ8Xa1zKjqX6pK4LN3Wd+2kaxcq/Zy6yt2d1xCAb
 uMoKLAj1xfSDpfCsJ/oqDHp+tmIP95S1wApEjr+ulqz+u++JAvxrJ1XHWRRRqiPVg7/I
 WtkFLzVY492vTfrYZdXnwoErzsL2zNgNl80i5Q4EGOHBIPSk0mhqr6jUw8rRj2ahOfj5
 s30A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwhbfhLXChnlHnuAXCWJ0qHARIR1i2wOR4sGU5/qpz+8QaywOaRu7BxO/B6ZJMurzGixoJyr+m1iM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCtH+vchXtkruOWvFCWRJxM3Op3pfaRfDB1vI7jNbKCRkobXfI
 rEnlFSdZTA6D0KRb7sXNMi9C44hys7zc3YU5CjSM0najCu8Xyv90i/MiBSuOBRY9mBsNJx4ypI+
 1/6uZX4M7bD543ibzIV9MJYGTm2YyP5KDkJjmFJgr6eKG2ZWiP9ZUX6HlmgJfktLPGncazXk=
X-Gm-Gg: AR+sD13HVKRdtAMHGIC3RrgP27rz4jv3bLe9KPD0NyKyxCSJg8vQ54OO+OYhJ+N5vYk
 JraWmySRyOZOSqFYfOcK1iU7IVSvm65nPEM17NQP9IE5qxPBgawXFvyk0eDjY5j4cHsDtSL1M3K
 pmx0Pg4m7ZqRhzhPZEakmIBADLZadOczK9IZHvNwuTSnh4ws916VDzjc4adx1OTamLPXOpB1hFk
 cfZXaPF5L2R3jgHtKuLwQv2iHNKoZeQegsewybhijctk/Rvmm8zaCb3Adt/zk5hMOEkNlfADXde
 PXQhrZ84r4NaxpYuX8FLVUz0b8jKgCEBremX+FZyXalTE5skRR2cB0xm7yjQ+Gg81OXQJVWmDJ7
 BxEG9JgEXrQpqsIOXg9oYZQFIfKs4xw==
X-Received: by 2002:a05:622a:5c09:b0:517:6d6c:187f with SMTP id
 d75a77b69052e-52d64719ec8mr31153791cf.14.1786529333717; 
 Wed, 12 Aug 2026 03:08:53 -0700 (PDT)
X-Received: by 2002:a05:622a:5c09:b0:517:6d6c:187f with SMTP id
 d75a77b69052e-52d64719ec8mr31153361cf.14.1786529333276; 
 Wed, 12 Aug 2026 03:08:53 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5dfadsm6433746f8f.29.2026.08.12.03.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 03:08:52 -0700 (PDT)
Message-ID: <c2bc1b2d-1191-4f1d-a627-626513993b6d@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/4] firmware: Rename google firmware directory to
 coreboot
To: Sean Rhodes <sean@starlabs.systems>, chrome-platform@lists.linux.dev
Cc: corentin.chary@gmail.com, luke@ljones.dev, denis.benato@linux.dev,
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, prasanth.ksr@dell.com,
 jorge.lopez2@hp.com, mpearson-lenovo@squebb.ca,
 derekjohn.clark@gmail.com, josh@joshuagrisham.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com, florian.fainelli@broadcom.com,
 chenhuacai@kernel.org, mst@redhat.com, wenst@chromium.org,
 tzungbi@kernel.org, briannorris@chromium.org, jwerner@chromium.org,
 tzimmermann@suse.de, javierm@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, andersson@kernel.org,
 geert@linux-m68k.org, dmitry.baryshkov@oss.qualcomm.com, arnd@arndb.de,
 ebiggers@kernel.org, luca.weiss@fairphone.com, michal.simek@amd.com,
 sven@kernel.org, u.kleine-koenig@baylibre.com, bhelgaas@google.com,
 dakr@kernel.org, o-takashi@sakamocchi.jp, titouan.ameline@gmail.com,
 kees@kernel.org, dri-devel@lists.freedesktop.org, oliver@liuxiaozhen.dev
References: <CABtds-3MAA8y5ksGcps6s-iLx8dOF7EoJEJH9079Y_E+-bJB4A@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABtds-3MAA8y5ksGcps6s-iLx8dOF7EoJEJH9079Y_E+-bJB4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -Tdq5YM_LrUW-0b_SPw4QI5UYvLxXsEq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MSBTYWx0ZWRfX2oxLBCc/VVSf
 w4ey/ttVst3mmEYlQmGT1fJ1vRNjzSNspg1fk7nVGaoXIQ9RuAC2pswK96H81NhME725U0i3AUd
 4HFMQUwyStKt1e1laMXfbks1b9I3zl8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MSBTYWx0ZWRfX8TBEuUfAhlLd
 6HYhKgYff5uskJVGjJRq7xI0i2hXdj9qf31EGgyx1G8ruiUVgSX5PWQ6Y+7Tq5svVD0+qlh6duO
 SVtWUHnTeXzP4COQLlUk+I0IsYyb5FqgT5vuqMioRWwFJcgKPuj9pGxTW+4Hq7XA9GmUTi+hlH4
 UwIZFn+wbl/m1EEokCpUsFC8wrzvJypD0IZ99/+M4deMdCE4FRl3FIKSogUa1wo2C14k6NEEPJB
 Zrtd/E7megKS5YJOfyNpLRSxhKCB8I3tEYtN7V5AhzbozKfCfyqOLTbK8vmmyB2OwQyePe8yr5B
 voXWxdIv7Eniav66uF5ACDYpzP47/bEhLUBpz7mfMfaDLM7+GQMgxjja0ezR/cEfv9JCjwzZvoM
 +O9mOTh7CQm3Hx8TbhFEo9O+6KeeB1e1CagProgP296UGknRHIws8JEx6ETNfcnSpNQ/PVIzIrF
 j42eJjStjoNChEbs3hg==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c4636 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=nDlYxSoMtbksMSfX03oA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: -Tdq5YM_LrUW-0b_SPw4QI5UYvLxXsEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120081
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

On 06/08/2026 22:28, Sean Rhodes wrote:
> Most drivers in drivers/firmware/google are coreboot table drivers rather
> than Google-specific firmware drivers. Rename the directory to coreboot
> and update the Kconfig prompt, build path and maintainer entry.
> 
> Keep the existing CONFIG_GOOGLE_* symbols to avoid user configuration
> churn in this mechanical move.
> 
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  MAINTAINERS                                                 | 4 ++--
>  drivers/firmware/Kconfig                                    | 2 +-
>  drivers/firmware/Makefile                                   | 2 +-
>  drivers/firmware/{google => coreboot}/Kconfig               | 6 +++---
>  drivers/firmware/{google => coreboot}/Makefile              | 0
>  drivers/firmware/{google => coreboot}/cbmem.c               | 0
>  drivers/firmware/{google => coreboot}/coreboot_table.c      | 0
>  drivers/firmware/{google => coreboot}/coreboot_table.h      | 0
>  .../firmware/{google => coreboot}/framebuffer-coreboot.c    | 0
>  drivers/firmware/{google => coreboot}/gsmi.c                | 0
>  drivers/firmware/{google => coreboot}/memconsole-coreboot.c | 0
>  .../firmware/{google => coreboot}/memconsole-x86-legacy.c   | 0
>  drivers/firmware/{google => coreboot}/memconsole.c          | 0
>  drivers/firmware/{google => coreboot}/memconsole.h          | 6 +++---
>  drivers/firmware/{google => coreboot}/vpd.c                 | 0
>  drivers/firmware/{google => coreboot}/vpd_decode.c          | 0
>  drivers/firmware/{google => coreboot}/vpd_decode.h          | 0
>  17 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/firmware/{google => coreboot}/Kconfig (94%)
>  rename drivers/firmware/{google => coreboot}/Makefile (100%)
>  rename drivers/firmware/{google => coreboot}/cbmem.c (100%)
>  rename drivers/firmware/{google => coreboot}/coreboot_table.c (100%)
>  rename drivers/firmware/{google => coreboot}/coreboot_table.h (100%)
>  rename drivers/firmware/{google => coreboot}/framebuffer-coreboot.c (100%)
>  rename drivers/firmware/{google => coreboot}/gsmi.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole-coreboot.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole-x86-legacy.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole.h (82%)
>  rename drivers/firmware/{google => coreboot}/vpd.c (100%)
>  rename drivers/firmware/{google => coreboot}/vpd_decode.c (100%)
>  rename drivers/firmware/{google => coreboot}/vpd_decode.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e6a8c271e79d..62ddee473f55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11069,14 +11069,14 @@ S:	Maintained
>  F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
>  F:	drivers/net/ethernet/google
> 
> -GOOGLE FIRMWARE DRIVERS
> +COREBOOT FIRMWARE DRIVERS

This is incorrectly placed now. All the entries follow strict
alphabetical order.

BTW, only this patch reached mailing list (and me):
https://lore.kernel.org/all/CABtds-3MAA8y5ksGcps6s-iLx8dOF7EoJEJH9079Y_E+-bJB4A@mail.gmail.com/

Best regards,
Krzysztof
