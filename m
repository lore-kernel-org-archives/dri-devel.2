Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D093C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB76310E661;
	Tue,  4 Aug 2026 11:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bAYlkwkT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ef1onPlI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871F010E661
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:28:51 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748CX6o3531720
 for <dri-devel@lists.freedesktop.org>; Tue, 4 Aug 2026 11:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mUv2doTcB2KgzQLoxafx4RHjj4cI//KwVl9sabgS/aA=; b=bAYlkwkTUdWwAann
 qho0NpK2qHNsX8QcruRCnRYdzvsvTQYXi3DmTrPv3lNOxIZv21nj//tAHX/ZxXQZ
 ObH/d/Xzh4DUkzUXACYog/kr5jZHNlMjqxCBCPLuLaSswQtbLhpF8CqMMYaohwCW
 Qtf/B6HxcUzRFXCKuDkY0W3fOrpSW9+ejkBihU9j9I0KsqsR3rET0/gADFT6144W
 xyCmHtKKTVn2IZJgsFWG/96ab+j1PZcxoUJOYDyMOeB/9UxcSlnQfT3aUHpeE8J4
 xsieTqeR6M3K2vtijqZH2RK3u6A6Hir98iFoP3yMnbxXe6JAe7EzWrCbG91Qt/Db
 oMxZRQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3sm21a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 11:28:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso50355381cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785842930; x=1786447730;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mUv2doTcB2KgzQLoxafx4RHjj4cI//KwVl9sabgS/aA=;
 b=Ef1onPlIUhku+3IYi039XUCSgg0GeasEss/tcCghkb8BPw/RbcNaxG+7XYMQVLx6d5
 9EDc0rm8FkxWN1JG/dUbVujCEG5pI2cKaVChv+96V3T3ee/5UGdRaLqtUTVgFbGxgb4H
 urc2+vXEtIqC6yC+wYIxrIw5o+s3I1mWamConl77w0nUB0jc1jF7iEX5XBxvSO40lKJl
 lCLGcFnvIDNEErgZx0sDeb+QO+G+q+1VGdr02HmqpeU5GAPNFedpWT1mcMUGIrSxSCXO
 /eXZRIUjSS35NTIMGyoiiz1hfZKgKYFTKv2dE10EP+TVm15QukMJSR9G6Bw5QICWC8G4
 7Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785842930; x=1786447730;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUv2doTcB2KgzQLoxafx4RHjj4cI//KwVl9sabgS/aA=;
 b=NeBDx5qRaIBIha5Yj1MO+bB6VR8QVH33mIzacujc4fOJPhhJRG9GahbkMCAjVxz1+x
 erm2N9hgpMs6i4ew2nUdS8tGxPbtQ144jCvvK5eByg3rpL8/xWMKlVRzvX7LcMbWUNd5
 HIZi7V89HlZlQZOpcYp4HipC+CJmdmjk7FWMcQM3G78HjXfqkOYub7O3Jegq2colNT5L
 c8P4kxUIfq9vBigPvKWEmNReAYrPPhfUqTvmVYqERccN2v0YCe8M0OSUtdBzCfhty2OT
 l/euDJXFOQWXKpSEjxNJBdbfMPrlwdKlrtgN5JC5bodztnZTSQnoBcEDZTX5cUqPW7E9
 Q0BQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlbPTnwn7mDm1omQsejU6Ge2k7S2tbzMDRneAxG0FmjYlcYQSqgaMV97ziln9pAzZLlWKdobMcopU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3K9wSq6FAo5jaxYM0bMp5MNYqgnk8nYIsT1GkfNW1/LHtBn1V
 tIuTAOK0E444+NEyWlspaDyjBdGk0aZ4c4z/RDwjaVsf6mcaMSZzlr/HpKRz6aG8eu6x/nQuFAP
 ShCmhq85h10ZUirUdaXCBZkZTqog9ihBRAdXxTUkb3+PD4jOetclchut1qOa1XuEGNFzDsJ0=
X-Gm-Gg: AR+sD10TU2ZE6/L7aA+Zns9FFaidpqEibqlXRyemTlE+AHvTX2Wwx48W40xJHR596Uq
 G6TyDs0kcFkPIFFLqS5aK6tF/fKGd+1x2+vcOQ4jYI/GoUMiOp+5EFKPc0dTQx9oYHRo96SibRb
 V+gjpx3kf6AMRIwLsl1++oJ5T6Aqgs8Ycce/H93y421ERDtEERSpgrDMSlB2qq9oDHKzWKmDBRi
 D+/QixzShhK+86++QLJWkCxGEtMvYBDeRESLVErschbAAPGVX2qk4m3OdnyWvIqrQo9jUsTtAfP
 XRmJ9B5EIy2CBG0L7va2g353X4mfZQgRJn5kvM0al/M95W18qnwmdj6mR5FG16BeAmjyLZVR3xD
 EHCRsWxr9Sh3BFlSKqSdsncwDY3rLVw==
X-Received: by 2002:a05:622a:14d:b0:51c:1241:3b09 with SMTP id
 d75a77b69052e-52b567f58acmr239416521cf.39.1785842929524; 
 Tue, 04 Aug 2026 04:28:49 -0700 (PDT)
X-Received: by 2002:a05:622a:14d:b0:51c:1241:3b09 with SMTP id
 d75a77b69052e-52b567f58acmr239416081cf.39.1785842929012; 
 Tue, 04 Aug 2026 04:28:49 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fec606sm95734265e9.14.2026.08.04.04.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 04:28:47 -0700 (PDT)
Message-ID: <64d82edc-87a0-47c7-8a17-f0d1c806a294@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 13:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] firmware: Rename google firmware directory to
 coreboot
To: Sean Rhodes <sean@starlabs.systems>
Cc: chrome-platform@lists.linux.dev, Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
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
 <e0d2a22e-a0cd-4a71-82c4-b88abcc7456e@oss.qualcomm.com>
 <04db0ee0-a8d5-4f30-a494-5c7f8ac757c8@oss.qualcomm.com>
 <CABtds-35m_cfT=Vm4MZkJYRe=dOPAKR6HYO_fu3SnwkdVQE0nQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABtds-35m_cfT=Vm4MZkJYRe=dOPAKR6HYO_fu3SnwkdVQE0nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5MSBTYWx0ZWRfX57upnGyeQE1f
 bxiF5xEeafcs6EpdY0c+gRcmqzkiu4ImSxZxUSvxyYaKDpFCafJXbbPnvwTQz++40Bp0ZVKk9kX
 m+dfOy4oH6dfOCrSfWbloXGds5l4uQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5MSBTYWx0ZWRfXz1kB8UOeYJd8
 YkFt4LVKpatwIPAG2D+HIKNKt0ko7JG6jEF4qIT+yaHAWSVm5RzJ51TG9aFobMq8tDW9MP7BZqw
 C9Kp5l6NXkkM55SCzybOOgBxSSh5JmK7vbvNTCejBbGqWk2btRZumOFPWNJDtXahLjfiP8NGHOZ
 Kax05nFjVqKVvPAOvcDh3yT4U//Hbal4BO9MmaCRD1RwoSpcMfNOtFpiPX4BtC6RoCvMiu3d74N
 2/Uxgs19ods2QmYeguGzdECfaU+/YQvH3g+NvW4g4f3AGnC+WvNKhp/QaVwbKR+cS7sRnVjH2+9
 BuRIlGTOkbW5/FhUPUZTsGb4yzJQeMVgAbxIWrneYRwrjOIeAghP7jCZg5xiio873ycGiASQ8dR
 LrmxVvcDbQLEhB4W37QOJ7EEYwcZcaSUQLvNU3TGHxfnX5cLYC2P59TZRrvPjMNehgui0Kz0br6
 Sz4w0bHYDX15owO3mwg==
X-Authority-Analysis: v=2.4 cv=Nu3htcdJ c=1 sm=1 tr=0 ts=6a71ccf2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=HHStz9QFAu1F9MAjIKUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: HbYAPXO5q_iott7X6FTJluVK1a6xKXsL
X-Proofpoint-GUID: HbYAPXO5q_iott7X6FTJluVK1a6xKXsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040091
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

On 04/08/2026 13:24, Sean Rhodes wrote:
> On Tue, 4 Aug 2026 at 12:05, Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>
>> On 04/08/2026 13:02, Krzysztof Kozlowski wrote:
>>> On 04/08/2026 12:13, Sean Rhodes wrote:
>>>> rename to drivers/firmware/coreboot/Kconfig
>>>> index b78c644fa253..d273bd836245 100644
>>>> --- a/drivers/firmware/google/Kconfig
>>>> +++ b/drivers/firmware/coreboot/Kconfig
>>>> @@ -1,13 +1,16 @@
>>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>> -menuconfig GOOGLE_FIRMWARE
>>>> -    bool "Google Firmware Drivers"
>>>> +menuconfig COREBOOT_FIRMWARE
>>>
>>> As pointed out by defconfig change, which is supposed to be separate
>>> commit, this will affect users of the kernel for no real gain.
>>>
>>> Do not change this.
>>
>> I am surprised that such change appeared at v10.
>>
>> Changelog is quite incomplete and I do not see any explanation for this.
> 
> Sorry, don't follow - so put the names back, or split it into its own patch?

I did not find explanation of this in the changelog. It cuts at v9, so
maybe that's the reason, although lore pointed me the v10 as the first
version introducing new CONFIG symbols.

Anyway, IMO renaming is really not worth if the sole reason is Google
name is disliked now.

Best regards,
Krzysztof
