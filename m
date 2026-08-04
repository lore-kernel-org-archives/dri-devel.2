Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71C4C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76BE10E9C4;
	Tue,  4 Aug 2026 11:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fmM9yrRg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AFaMfssM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E8010E137
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:02:21 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748CRT63546509
 for <dri-devel@lists.freedesktop.org>; Tue, 4 Aug 2026 11:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7VQIegxZjpPZ3YspDwqcWiPpjE3RowqNYy4IxabijtU=; b=fmM9yrRgfGUbBYc+
 GdXUwXlKzkpSpmM9aw1kTRMroowBL5dT1HzBFha2cgXrgzZk3d50a/R3NFiP5WU1
 F2GK9+BuXXUeJgVtVqZdwxOG9UGLetg+QKjvY0fD85aIw02RNTV6nK0AUHG0JkY1
 w7aS+7/iM7m+3nKfc350hlMyPywq1gviJNA2A3bvFj7b/ZJ7w0fT3oOCe90W0NUN
 mZawIlwhSBiS2yusR5s7OY+wQ9U0p5EUP9rJ+J63A/jHhfeVkG0u4GX+BUhb3A2m
 owEm3ZdRlryoTM7RsIt8e6P69rrMXL3v8K+9Nhr/jBlMyg8i6xLSqjAbp7qGRFVP
 WE/foQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu3vs2kjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 11:02:19 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c2e847a4c5so4870581e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785841339; x=1786446139;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7VQIegxZjpPZ3YspDwqcWiPpjE3RowqNYy4IxabijtU=;
 b=AFaMfssMUhHe9HcJEFDZpd7ARD/gKH5ldsm0DV99h9vbfZhJeX1lHKngUjgn5mXmbq
 3vArASs/CcfMAuPdrCLcYBJ/kj8y58gaO0BM1gzx5ghYBH9zAVb28vp6B/EnJBb+YUe3
 e5BNfWkNla4D9MgIR6pM3gn0/0QuqZqFE90kuPbnJiTHEzhZ6E2HiIMJx0o7/tPwHeM/
 pdj+Oz8jHNjLXgaBdyfxOdNbz3KLvnMH0Euc6td3K88ZfcZhf08QRT/xsBeofkC7lg9w
 6i7wQAEf9fKMNAIW5kcRb3LgBLEDmbu2A8qF41EPwgF6GnPZShb2Jrl5enUhmj0HUpOd
 RwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785841339; x=1786446139;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7VQIegxZjpPZ3YspDwqcWiPpjE3RowqNYy4IxabijtU=;
 b=QnOVBVGrGuYd8D4eoASc2/ZGoZ8C4kjomHdcMyn2imvcTjluPhZQE/jNM4bLcQdUuP
 t2XX8OdqrKZRiuY3OPlNguea3mUYNM8L/gt2kbKkNZ8aWw35bCW2cuFzTQ5JSqwk7i2C
 2VLFt9/MD/5u5SRjkTloSYCN4d5u2th8+2zC89jdPBOdYFs1x6u0tbHrHjEAN+uJHGKZ
 3q7ueq9JHXWL+krj5VTX17SsaG6TMk5OqIij9YshKd7DGfK2yhZ6s/fdElaukCp+trXw
 /G10X40hzUGb3dLWxzpX9383R6XBLUAZsOgRCCAOA5iEW++1NKf6Zq+WsvdVm0YaipdE
 yO/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJduY+EPbV/aW0UUkskhKRQmfFAZkDhZWVR1GJ9eWEs/Qy0cZKXtyBLeVVPQFcoxdE/YGUvEvFbJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwagQvuzI3WTmQslogb/8zFDbiXrIS52M1cvrOC7iCdyeSLN61X
 7EzqHB5TgZHei5fuXZ57d3Idplk6hxVTQEFlrksrq/+avTaIBTxm5T3u1aLGEvgV7m8Km1L5ir4
 PA0fywYcuFEOX6uhd5aHVWHI6XwpUNkPKcQcq1kjV/A5RILYSJ7sjg3aTY19MDFdkXco0rNk=
X-Gm-Gg: AR+sD109TBm8UibVN5jTBnFf7djQciINqSgRPoTEIiLGplhffr6CzFTgcl1FPz68Gqs
 DyB5jmYmr7joAyt4IBkJeHTy5nlBQC1gCsLQpIaYETCIvEXE9cyrNamgMQJVXveGb4uU0a/8o8C
 IHfX08EFEnBCI8S7D+BLVJU+K9lJ+PR48JDspKfivA3OoYXCtRU41Ofvn5mIxQZMdHNAxUH6kfl
 JqkoZh0mjUTfFUoQ5I3PyAFXosn0T1xGIb4dW+gZHuemhlG0tgvHbdqxTP+2El9nWzH6DbUB4/J
 q5Vse2ppjOsRuNYXemGbmgk6eTL5ScRF94AYBemRg/YK+etPuVfqBICOt/hG5ZndNYTDVxgIkBe
 g/3yBK7vMCaPUxXTSfMF7piL+1qQnuQ==
X-Received: by 2002:a05:6122:c94:b0:5c2:c0de:d291 with SMTP id
 71dfb90a1353d-5c3878dbb3amr4934742e0c.9.1785841338519; 
 Tue, 04 Aug 2026 04:02:18 -0700 (PDT)
X-Received: by 2002:a05:6122:c94:b0:5c2:c0de:d291 with SMTP id
 71dfb90a1353d-5c3878dbb3amr4934622e0c.9.1785841337942; 
 Tue, 04 Aug 2026 04:02:17 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b9441csm311773765e9.4.2026.08.04.04.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 04:02:16 -0700 (PDT)
Message-ID: <e0d2a22e-a0cd-4a71-82c4-b88abcc7456e@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 13:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] firmware: Rename google firmware directory to
 coreboot
To: Sean Rhodes <sean@starlabs.systems>, chrome-platform@lists.linux.dev
Cc: Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Florian Fainelli
 <florian.fainelli@broadcom.com>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org,
 Oliver Lin <oliver@liuxiaozhen.dev>
References: <cover.1785838269.git.sean@starlabs.systems>
 <6f65c9869714188539f2890aef6cf30e7bd2edcb.1785838269.git.sean@starlabs.systems>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6f65c9869714188539f2890aef6cf30e7bd2edcb.1785838269.git.sean@starlabs.systems>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NyBTYWx0ZWRfX5Ptroqoh4dib
 YTJHL09uUS72OgbyzSf2Mq5zJXfTm9/yf+ZjcJyphTCfl3jsvJDYmwCbJZ7Pry9dPkC8EInO+3h
 314wRc283W0twVIM6ecsOIW5EmSLLVIZLZ3RJ5Zzc/mSI80+KyRJmMYQw8Fww1ymJtcReVi3+tj
 j+W7KvmpDrYrjmP/V+ocqubDr/D/lk+ENP5A3nzNjNkgrUMZbjngYL4ofcTheAhEXXdMifUjvDe
 qUQBb5zUZUBU/99yR3w1XRnNT72QEJvC3L+SNQK0Ja8KaqRVabHaqm8147XrHk9iSnYl8Mf5tG2
 31O8A6AiVi5nHew3Tq8yCW0HUvgTf61CunWcyLxdK+A1zvGLlXbmSqq68b/rongzDSK6oV3eeaO
 zrD9HogWAf9B1Ilia+V6h00HNJ7Hbc9msjfQvhF6mOzRWWLWO+hGhlIs1WcplTrGQEkfOnksqSE
 6tDKXhyLzcd+zQj74Wg==
X-Proofpoint-ORIG-GUID: Fl1jDIfR8RDLdhbGeyV9MLI4yMZvL5cG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NyBTYWx0ZWRfXzKNTzu7Q+HO0
 3pkb/IGzQFYE2VO1nYL7ApNzX0mLh0QdbJCFjSa30QaBBy8mu5xAz32YKWiQHYJXTkge/oVzy5T
 K1BtInTjMUZ3WPWKJV2zfWFLRq47PW0=
X-Authority-Analysis: v=2.4 cv=EK82FVZC c=1 sm=1 tr=0 ts=6a71c6bb cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=oilz1mZvSc2HNm1MEWQA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: Fl1jDIfR8RDLdhbGeyV9MLI4yMZvL5cG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040087
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

On 04/08/2026 12:13, Sean Rhodes wrote:
> rename to drivers/firmware/coreboot/Kconfig
> index b78c644fa253..d273bd836245 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/coreboot/Kconfig
> @@ -1,13 +1,16 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -menuconfig GOOGLE_FIRMWARE
> -	bool "Google Firmware Drivers"
> +menuconfig COREBOOT_FIRMWARE

As pointed out by defconfig change, which is supposed to be separate
commit, this will affect users of the kernel for no real gain.

Do not change this.

Best regards,
Krzysztof
