Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E4C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FFE10E15D;
	Tue,  4 Aug 2026 11:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EYNXCi6/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ma0QbIrV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A5F10E15D
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:05:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748Bskl3016113
 for <dri-devel@lists.freedesktop.org>; Tue, 4 Aug 2026 11:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SEAGrPimEHKTw1Kpbd6XZIudXgicxhiY0c8XhCSfyL0=; b=EYNXCi6/pebLxskk
 2k+9+1+e3q7sw4f0Gayb7A1RXpNyrx8ANCaLzBT+q+zFR8CGIU6muKBD8UoOSzUs
 MQv6HavyobpLTPfEG5RO6fsNEtI1a7jaftnFQSXoWesi2BqFPdt8bP+Q/nf2vgXG
 ldm+u7uoZlfGOC8GIiccWex2Lyt0EuMEqW/Aptd+EEBdfEbE9cwcK13r4/M/ILXE
 hthII4fy3Wnt8ae6iO0pCJuG1DJ/xSpm7v/0nEZ/fffII9NJpxBmyi8A4ojwRX3z
 2btOniUY4ktRwFhEmJaXQ5vZdVXS+lPwuvfzUXRxBZQXMcI4U6//QUp5nm815fm3
 5bqoBA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu727210b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 11:05:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so51436791cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 04:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785841501; x=1786446301;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SEAGrPimEHKTw1Kpbd6XZIudXgicxhiY0c8XhCSfyL0=;
 b=Ma0QbIrVjMmcstgFPOqcd3QocFwy0zKfsrXZ8kP+REFYyWNpclvlmfFdOVywfALZqF
 E4jpY0/CMoljHoWO8L81zTGpppaKWDkvuK5YW0RZA/fAJJON2YM3UK8TB/kcoOVGzSFT
 nPc429T3JLrdBwLoVbqjezIh4dIeSOUhrlmwbdbNWRcuFJ22dNAyDMAGeLGGL0vtlk54
 +Gz7izhdMqCvVKM+it6dvJTOMUlaKIAXloxKjeS26KY812cY9pXqJ+pp9xheSyiqzdS8
 KBTF+hjgjAm7blw3g0IZWVDrtFTycMbJK0sr1b1fflahiwuKpwisk0ZF6hEXnH5q0JHm
 FIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785841501; x=1786446301;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SEAGrPimEHKTw1Kpbd6XZIudXgicxhiY0c8XhCSfyL0=;
 b=Z6v2ky2EIpzHcV8JyBVwYO7Um40wcvQj/mQnGFgZd2J0bWe1mRD5ZQ1qFpJGaMkRu2
 TjDwTw9WwcC8tHQ1rhCVVe0bdZBpZUGVCv2FMbhg7Q8qYZIimZ81OoueHuHK8G0K1gmW
 STlFOb0es4J0oV9tHcvWJuC3SiRgz7oLHGHA0Mb1N5r8SdYUfSgOHoyUb8PRMAunvXEV
 aZSYuMj8Hep+73ryq6d4vF8UCGlyDD7EK2gLT46FTy12b7xJhtk9hx9G/ywB+j/szI+D
 mhNPkWOZENYpH4dNDzjlTO1sB81mfsXnDpoglGNDu+MiefRjT4STBQhJM5ypwdEkpL78
 ljPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoV+ICM7ZKa21KGMToiJGXYUJe62exWjo7fCvMWDI+TfZvMYKdMxqy/6ih+Qr+HV/6Riom9VGqiNMc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM4lNBrX01mpqMwh+fB2RV68c+4aEESkA3jflbrgOjTtNgG1Hm
 hvpy5BW2SxLaCRdRp33huGGTuB1EUXrMtCYdgl0JOyJj7PKt9sIEcEm2QVkc6S0TiOIrEeIVZlu
 Rqlhhvh6E/ektc1hfF0pUjzHhVVd4M/EYjx8i+K9T5vEyU6EtR8bOgmpRqIuqi7uD8AzTo3U=
X-Gm-Gg: AR+sD11T5lIEhZxX15sHFhZB/Rl1Id0E1sIbzhS7t9shh7KOrf/+tehuMa7ppgjcuWY
 rQVH5Dbk3DFAiGo/XzmLKLdM8ipW7uQs6mgLrCsrh6EYfg9ZCgD06w/MQqGocqDg5r+JEGpKCf1
 nZ1vPMzQ0ybcjFZX1sx00KGyo7r83DzwwTVlp2jhxxatlsxazKdGMly1BJMHYFRAei7TvuP49eY
 StNH1wU+vfFD4y4ayBPUgcsLcqecVGJHTLyF6/D3GHHt7RQDdt6reiZbX/4jT+N9z55gqhuXxU8
 MsOuAzwbU31tOLpbodOKb5Z/6RC3UGj8xDLkSkPny0ZTzTIwi/NBSFA9U+CAGu+ecoG3/7KlcyZ
 GnhAYqZoZdi6vurLJE/QlHeej0aqWVA==
X-Received: by 2002:a05:622a:5916:b0:51c:15c5:2bf7 with SMTP id
 d75a77b69052e-52b56695898mr286919751cf.12.1785841501133; 
 Tue, 04 Aug 2026 04:05:01 -0700 (PDT)
X-Received: by 2002:a05:622a:5916:b0:51c:15c5:2bf7 with SMTP id
 d75a77b69052e-52b56695898mr286918941cf.12.1785841500668; 
 Tue, 04 Aug 2026 04:05:00 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807eb1256sm159296705e9.2.2026.08.04.04.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 04:04:59 -0700 (PDT)
Message-ID: <04db0ee0-a8d5-4f30-a494-5c7f8ac757c8@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 13:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] firmware: Rename google firmware directory to
 coreboot
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 <e0d2a22e-a0cd-4a71-82c4-b88abcc7456e@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0d2a22e-a0cd-4a71-82c4-b88abcc7456e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NyBTYWx0ZWRfXzKAaZjqRblrB
 hh2qQrSYhYjmbGZ2HtE42QetKK8qSob5mnzsyKloSSgf23dKFHx6MFayFDMmgi1Hss+rKurinv9
 o4RV9617FoY0XhkskvaLGrXAfPB6qyI=
X-Authority-Analysis: v=2.4 cv=Z6Lc2nRA c=1 sm=1 tr=0 ts=6a71c762 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=fqswe53bbStJ6VhJXE8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: KknhPG_Y4NbDbDhg3Ng2A4qJy8WHIWt4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NyBTYWx0ZWRfX38XkzDNym3Af
 RQPJ6swMIqXNftOIsh+HzplNNJhM5DoiTgZe41CXoP/2WYJIcSq/IJINCNLoxuo3SmsBb5944Vt
 837S0FxcOCxjdzO1+GITtwVEyWxoHmxuQhd3otPaLrt9r9JoC/n7QiWFsu446QUSix/9AHJSvqF
 6t13Mkk+wc+s/xbW6XsN8+bA43nHaOHErDR5y7UlPqVz/oz8iv6EJ0BO2cal/J4+OfP19t0MH/c
 b5hWOBqVN0p6bGtHZIOJc/W2x6GOjKj8J9JbXmmI2HMAgQBUcB8JoEGDGTE8w19TA+XaAlmfADk
 CQUC7/nlJoNqNWeCJ/J0gyxYCdIKm2JlS9PbqGG/4nIsPXDm8LgSAOYByPPvwnswecbYWTwxShC
 zc0Hu7LwvYh9SdynfbTx1sZ7lu27DccFJuD9LIaUQ09vixhUSD6U9a16fumvyGeqdzHnlTeBuQw
 B9NPg9kNUgS+BfH19KQ==
X-Proofpoint-ORIG-GUID: KknhPG_Y4NbDbDhg3Ng2A4qJy8WHIWt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040087
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

On 04/08/2026 13:02, Krzysztof Kozlowski wrote:
> On 04/08/2026 12:13, Sean Rhodes wrote:
>> rename to drivers/firmware/coreboot/Kconfig
>> index b78c644fa253..d273bd836245 100644
>> --- a/drivers/firmware/google/Kconfig
>> +++ b/drivers/firmware/coreboot/Kconfig
>> @@ -1,13 +1,16 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> -menuconfig GOOGLE_FIRMWARE
>> -	bool "Google Firmware Drivers"
>> +menuconfig COREBOOT_FIRMWARE
> 
> As pointed out by defconfig change, which is supposed to be separate
> commit, this will affect users of the kernel for no real gain.
> 
> Do not change this.

I am surprised that such change appeared at v10.

Changelog is quite incomplete and I do not see any explanation for this.

Best regards,
Krzysztof
