Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B66C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C60310EF0B;
	Wed, 12 Aug 2026 10:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/0bpBRo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ifJooN3+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C25110EF0B
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:06:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C9fb2H384798
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t/SOUpUwjDpAt++MVooTOPUKZjfOYijo38yy35xnxnE=; b=P/0bpBRoYv1osyh4
 EAkk8kxe2DJERN5N3w78B5e/+lesGS5HMl8vMkcvIwuiGa/Ahn327h+p4QMv2rc4
 SxeYZPEM1DymwEsgBin2TL34WUV5fPAjmygLIFgxTqLiNNGZEx8IBiiwNiolRDS/
 Y1fTd8ET0ui5cFVH9j56O5mDWkndWU/NU4pG8pdTGPJInpKpUByIOxTmFG7Kxt23
 C37rEApB3vYvqzcXkzjQszX/GfZ90nnYsUw6gWyYcAcCU5scrGEyRxLoKZcHhdGB
 bXweSN1dJ8RadevfMuDptwwsH3QVi6cdQtf9URG9tEeu4I+WdRei4VBYGcP75Dr5
 J67yvg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut889k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:06:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso8290206d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786529205; x=1787134005;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/SOUpUwjDpAt++MVooTOPUKZjfOYijo38yy35xnxnE=;
 b=ifJooN3+Yl4GxYm98HaWRKEdPS+iajodJ1mmXj9CBooq99mZfOot0OgUQCAZMuhWgk
 /m1NBykB8tkkeomnf/5V+Hpu8kI1yOEQVOynCbrHCKhO3hi4rLtZ9aZr+awxw/8BZl7B
 aYbiqr2Z7YgpfQ9WwLlHq8eXCCCUF2gxc3w2Wgx+9VL8pr3MrFcboFXwZ+Tbmpk/0Mpb
 pU9PJkch2tVomLg2/VWBRdz2rmQAFYxv7tgXTzi7a4x1w175uMlMmQjfT1WAZaiJQWuD
 eSl4S1EgqnfOC/XBEWyzd3F1rxXCvH+/qFiq5VvM89hGUlusX1iOTvKg4iXflEvNOKPK
 PI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786529205; x=1787134005;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/SOUpUwjDpAt++MVooTOPUKZjfOYijo38yy35xnxnE=;
 b=F//oEx6ujwxlDuGeZIRKBCgtF5fw0m238fh98PDoLVqDZPuJ6FrCCBYOq1RLgaanE3
 XaQk/iSyfhjqtglQ8EFTFA2S3mz1oRakJb5TvQQz5jGyuQEVPRAWW7yMr10Akc1U9tdY
 yxZ2un4HVRDh4apS7XAdulE62AoKX2iu3X0ZtyVgCIawxB8rOf9oiVnZQ3SiqTEza7x3
 SSKUD33uD3Z6tcrXhk52dI6AxiSB+B0aFmcyPOdlghew35RtVSSI+xfSWP0/OQ+9hqm1
 OGoMkKGwBD/vr5zIlIc0lqW7wMKjXbPbfh6K48okj5hqtnAOAf3MjFPMx+NIa/uHfF/D
 qmmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+7n+LG4G4IFNLe4D7iuVdrgBQ3sqPCTp9jbowNar5yRnwlpS0oVMEkFslukzjMefXrysPvjvhtbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8WSZACO+PEI+FV0TKDbPKGhycNPvZbXXkjtVtp6ml7ObBSWul
 afagcms4h1057lndaEKqLOsRwr6f+DO9rYnG2B1Qr+wZWtbv3BEgyu0sN6DmWd+iKttFucKrS0n
 xTuL7xfoE/bUUqSnNmJI75Kr2qQLstLR+oCzCjms0wBDtuKKdLXYtnw+w4KICDnPmb5+OwdQ=
X-Gm-Gg: AR+sD1037vhwUfiWJLcH3lb4WP4n9yC4EQrKJPl8dI/dXjR8g1ZgMbxYnjTlQsP0Pob
 SHVLbA/Mnc+/kObvl6bTwa9EvVRx2DCslwgmUkptynIR10jqIK+32uHRF1QhL7sia00UVh4Y2Xb
 XM4Yzz3BgfHHQiL+FdIYbTJgYc/zRgT5SqLh2To+gNFpA0om05ESWIdyf69hC7RtOKmylQbfcBN
 bpxXWVlEG68QUGSnoI+3k9hJLKWGSwbe+a+AXCXAxImSMKFzLrfZZjNH/CAJhC0yPMqSYvfbBbZ
 cJcY69IVMzZv8Utqty4bFvEZYJ+tu/pbfN94CyB8kByvx+yRSXppIc+FzuNV7PSwmZ6LqXLMyWg
 eopxctYhu332PP0/aGrnkZ6ZHObB6eg==
X-Received: by 2002:ac8:5854:0:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-52d646b85b6mr26390721cf.9.1786529205488; 
 Wed, 12 Aug 2026 03:06:45 -0700 (PDT)
X-Received: by 2002:ac8:5854:0:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-52d646b85b6mr26389931cf.9.1786529204950; 
 Wed, 12 Aug 2026 03:06:44 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c946ce1sm34512735e9.5.2026.08.12.03.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 03:06:44 -0700 (PDT)
Message-ID: <c8e4a3d3-a96d-4fd1-85a6-881e68385c83@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] firmware: Rename google firmware directory to
 coreboot
To: Julius Werner <jwerner@chromium.org>
Cc: Sean Rhodes <sean@starlabs.systems>, chrome-platform@lists.linux.dev,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
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
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
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
 <64d82edc-87a0-47c7-8a17-f0d1c806a294@oss.qualcomm.com>
 <CAODwPW8B2-i4Ne-ZTVUM_H-EZwn2hoaC4joRhxNM=CREDd_aUg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAODwPW8B2-i4Ne-ZTVUM_H-EZwn2hoaC4joRhxNM=CREDd_aUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MSBTYWx0ZWRfX89BiLTnqPauL
 NY7SblVVGkMlqL6eu6jYreVBksDZcwa/Fpsbah53ymfCFQN674ac1lUSOlextQPn9B6kzBEaFie
 qpoluYEaTPGKbYTsTIqfFB+S4sfuHbY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MSBTYWx0ZWRfXyp058eavL9nH
 oItu/uFltSrfWMHlhK8JSUIT6tz0hlRfrT9JBKQylhHydCW8yjmjYzvXB30IP519DUGZZDKK+Zq
 8sx97qxGKEnSMsX8TanD94qNjq9VJJQsIFq8Ai1fwNEswU98oCLFkKxuqfilDR598mp+pfMiuH2
 +ZW61z1KxCX4Us6J+e85nTVl7zn1HmyS76vsTvuIaY3wMw+1ek4Yi1DrjQoS46/mvZ3yC5UX47y
 UvQFBvEPuaF7/EF1ysUHveE4F6XPzlxVr7oBQYf8x3rgXcu33NTQ6/f0DyJzQbq1yu/i3EMu1kZ
 TgWdQ1G5TK9srl1HzxBP18y0MxtmjyQqTtuuG5M5gAS3aBEDGTQclS7LzcNdjxZP+8t71MbukZV
 daVS+UwAWFusV7XDD1m5tVChMq4LLlCQrwoQ/LU/m8PhfzMPz/RHlTiTu9VlApM3znQlOCl+ZOT
 tUL60yLctLcSGSnckhw==
X-Proofpoint-ORIG-GUID: 5yoHiWnYfkJ1EQz4-au4ifG05TWeBn6I
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c45b6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=WubhEmtZWPFaE_0rBY8A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 5yoHiWnYfkJ1EQz4-au4ifG05TWeBn6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
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

On 11/08/2026 22:21, Julius Werner wrote:
>>>>> Do not change this.
>>>>
>>>> I am surprised that such change appeared at v10.
>>>>
>>>> Changelog is quite incomplete and I do not see any explanation for this.
>>>
>>> Sorry, don't follow - so put the names back, or split it into its own patch?
>>
>> I did not find explanation of this in the changelog. It cuts at v9, so
>> maybe that's the reason, although lore pointed me the v10 as the first
>> version introducing new CONFIG symbols.
>>
>> Anyway, IMO renaming is really not worth if the sole reason is Google
>> name is disliked now.
> 
> Krzysztof, the idea with this change was to introduce the new Kconfig
> symbols that more accurately represent the new directory structure
> while keeping the old symbol names available as fallback symbols for
> people who continue using old .config files. Doesn't that avoid the
> pain to users you're concerned about? I thought doing renames like
> this cleanly was the whole point of the `transitional` feature in the
> Kconfig language. Why do we have that lever if we don't want to use it
> for the kind of cases it was meant for?

To me 'transitional' is when you actually make changes to drivers, their
dependencies or to whatever Kconfig hierarchy is there.

I do not consider marketing or pure "I do not like this name" as valid
reasons, because this is developer string (or kernel/distro
configurator) not end-user visible thing. And for us, the developers,
this marketing does not matter.

Anyway, defconfig change must be separate because it goes via different
tree, unless this is non bisectable. Keeping it here initially confused
me into thinking you are actually breaking use cases (which you are not).



Best regards,
Krzysztof
