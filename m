Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F29C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5647610EFA2;
	Wed,  9 Sep 2026 08:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHYMzPk6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KiJfcPMh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B6410EFA2
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:02:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6892UAe1639556
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 08:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XSMHZUD2b2UJe3yPgP/kY+F7XMMhsGVvoGqYP6DBmQ4=; b=PHYMzPk6+E474nh3
 z524YrgoQy4kEv7pHq1xxG4rAulORuiyo9L3UgMBT+OZtyExRTBfPC4xfnQ08uES
 iDOKWmz6W7//m9Lg+K4aEbKAyXB8TmZRRHTTBUsyn6eKR/OEaHcASA/A4B6AtWxO
 KrCMVrNk0H7p864zRSVJDm9HRNF21hZ7piVivW4J82MeAVj0IKnt0z3WhKG++8n+
 vhiUtWWtpa7P71MrSCUKCdFSBc5RE7/Pt8hzDT3VuPbWWJ+Qz+8SQwWDak9yh7eM
 XQe9ABJvPVPOZ7wt1dcGj/WXzPldVlxK1JfnlvOUZ6YhdB7eQ3ADI/rl4EhP3DDH
 +XcvDg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqj95x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 08:02:33 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-980b637ed69so197352241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788940952; x=1789545752;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XSMHZUD2b2UJe3yPgP/kY+F7XMMhsGVvoGqYP6DBmQ4=;
 b=KiJfcPMhRQZUtL+9VUQ6omZ0AKzGLf2Y6HSNh8eDsd3Y4fOYY60kugYpL/m3uBouGz
 cvQzGt3Q2xZIa988N/PG+a//72NxLRR2MDqPrcRtHODcR4uD44ypfEcz3QVf6D3nAsZB
 RELkrY6T16K/BIqZLWUxB4LEhspWDACiUkY4cxmooaJNWG60G2bRD94R6hRrTVlJe+Yu
 zp6PhXPJ9SqC3WaZdczaUOgciJjX6R9MvW5m2IktIAqw74cm/+MN5OASkHW+RWRwQ4ja
 LbR4D9IAE+F52qo8NhG3p/+2bhE4OiY08rTjdn7alKsBLtb9ou8NL5z+yW7cMKjCW2X3
 3Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788940952; x=1789545752;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSMHZUD2b2UJe3yPgP/kY+F7XMMhsGVvoGqYP6DBmQ4=;
 b=oB3ki4Su8WN0Q3LOnI077lxEu8K8wRnocY9IYU+PfHj6GZY92atMpMUEiJmg3yuZSJ
 Uq475+DzbaUUfwU1ZWDLqz3dKcLTuUXfTpslsKumIFxAvRStMVOYSTOZocLjZNnDH0BI
 S+nDlPGpb27YZXe6jckIVPuoTjRhJxb5Q7FC2GQweQjb4ayXGeOfi6mRK6mVKipKO9k/
 nbEMqZnWsuf+oCQWZri1MWnk8h9XgbmE6e6R8oshGTqMqZcw2hYKMvvxcRP3mRpRUiPo
 jRwMwfxA93LxPqML7fSzInGMsHqtLSVWmhQj1Z64PVJAPD+IQkML5hTKKao7UqFsFPTv
 x0Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5etqiu7BRibGyAB4jLF4hjlLp2Zqvw5O6Th4ExGszShypaX/nJITtkpZGmY0HHkTgvX768xD8FTU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nBJAljsuRYkXCGsjIsXdg3MChtV6/EPj/AXchXb+GV9rhbo6pr
 bq0QR06P/ScxDtLjh8/C1dTc+S4QyistudwpDB3cs7X7o3sexPhXqt9qdybbKdJntBZxvN+3FsM
 N768+lBxB59agER0SNlUAvDHPaX8SpbTl+iCO1bfPjGKeA3J2PGnTDeB2bZyqwkQfMbLDy/0=
X-Gm-Gg: AYBFou1nexKKK9cgFWHdkKBi+8+dzgEj0EdxkmJrX14J+gbHRzOe9esaUyXRGCROQTg
 3scyICo6cdmWxRnbwZGo+TXapf/LJ8aiWlLtmEsr8qO8Do+H4HNP5qTisTY9s9Fbu1M6gUmWjmF
 0wxLc4mdmuSplUSxqurSA51pwgTD0d3RGMGvdHUIhc0tEvlHEf0WNbnnGViFQq0BQ1oPHV7PS67
 tX7pSS+nV5QqwttfhvTbKxX+fSChH3H8DmNaf9KrEgR0UANATE03WLAl41zuIMQwx053wQxnfiY
 H8XUQhtBy1VSaJILzA/P2zbbsL0NgugpalGlyTBA0Y5YHYXZkXwNu1YY8oI5yd9Htb12Nl9P+Oh
 h9IezAqerPW9yCCrzZTyygGmuN7Y=
X-Received: by 2002:a05:6102:a218:10b0:78f:f234:75b9 with SMTP id
 ada2fe7eead31-78ff234864emr445500137.0.1788940952055; 
 Wed, 09 Sep 2026 01:02:32 -0700 (PDT)
X-Received: by 2002:a05:6102:a218:10b0:78f:f234:75b9 with SMTP id
 ada2fe7eead31-78ff234864emr445466137.0.1788940951571; 
 Wed, 09 Sep 2026 01:02:31 -0700 (PDT)
Received: from [192.168.68.120] ([5.133.47.210])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c260d5277e6sm707351266b.27.2026.09.09.01.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 01:02:30 -0700 (PDT)
Message-ID: <c447c7ef-828c-4fda-8e82-6983a3d0eddc@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 09:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
 <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -S6Wx04_lxvM7H-cOLdDKxFMBl013Akf
X-Proofpoint-GUID: -S6Wx04_lxvM7H-cOLdDKxFMBl013Akf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA4OSBTYWx0ZWRfX3yijBWyLvzb6
 55a3D1eTGKfR308YDGhqTew+Fm2X/GOta3uq+/AKkByPAKq1OMSeT5/3aNUS0/OUQ7y9p7K1X69
 yhNRZh83+jtSfIEffYFM5Hhtxts/VSwzWbcgt+MGtQLujzqyLXZFF9KxFutb1wKHNfWWNjVJ43n
 +J4j4KgIxguzgaq3WmSHQovonnThqAtQ1t4y8fGEfk3VkaJNMyl95Rpn8rSfyUdgY7Q5xXZSK7S
 ca7L4bzWL8xEhxhySzq9Yoo3OtvSn9d889IslnqrHxg270Dfc/gPEarvIplKzRWh/sYu1S/1sJQ
 0LG4+fkefB4lFSdPbLPtUFub/RPN8Q0B1tFboCS0lIyc0wdB7yhaPquY5IEZP6rlDiDa7Caho8o
 ks9bJP/ZTUTvcL8LR/G92oxNOvnChxbuYHY8eZOu19Pr/l8/v2d4chRN+ToQy517gH3pMz4/9qG
 emGxUBn3cfQq2h1FI8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA4OSBTYWx0ZWRfXyyezATpKp6gG
 oCrj3aXOyBpx8oUJCOKERGB4pJQCALpjNztCbsBqGpAEAZlNshahvhrEUHFtoJSP3mdzEFdITDG
 yvpKtJSGxYQ0XwuhH0bO3JFq5Lolils=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa11299 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=RSJrEcLJ-t34lzZDKPUA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090089
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

On 9/9/26 8:53 AM, Ekansh Gupta wrote:
>> This is the actual problem!
>>
>> We have existing user space that depends on the ioctl interface exposed
>> by the current misc driver. You must not break these.
>>
>> Hardware cutoff is not a viable solution, because that's just a
>> declaration that we'll let the old platforms rotten - or alternatively
>> you commit to maintain two drivers to the very same feature and quality
>> level.
>>
>> So the only reasonable solution is #2; from there it's a valid question
>> if you reach that point my stepwise migrating the current misc driver
>> that solution, or if you present a new driver with the fully backwards
>> compatible interface, alongside the new ABI.
>>
>>
>> But this does bring to a question which the cover letter should explain
>> - but doesn't: what problem does this patch series actually solve?
>>
>> Regards,
>> Bjorn
> Agreed. I'll target #2: QDA implementing the existing fastrpc UABI
> alongside the new one, rather than a driver split by platform.
> 
> On how to get there: the blocker we hit in v1 was that legacy fastrpc
> buffer semantics appeared to need a drm_file, and there's no exported
> way to construct one outside the DRM core. I want to re-examine that
> constraint rather than treat it as final, since the legacy interface's
> own buffer model (a dma_buf fd as the buffer identity, no GEM
> involved) is not inherently tied to drm_file, that's how the existing
> misc driver implements it today. I don't have a concrete design yet
> and would rather work through it here than commit to one prematurely.
> If anyone has thoughts on how the legacy UABI could be served without
> requiring a drm_file per session or if I can somehow bind drm_file with
> chardev by exposing some APIs from DRM core, I'd welcome them.
> 
> On the cover letter: fair point, and I'll fix it. The problem this
> series solves is that a miscdevice interface requires us to hand-roll
> what the accel/DRM subsystem already provides as common
> infrastructure: GEM for buffer lifecycle and reference counting,
> PRIME for cross-driver import/export, per-file (per-open) context and
> handle-namespace isolation, and the existing debug and lifecycle
> tooling the DRM core already ships. Every accelerator driver added to
> drivers/accel (habanalabs, ivpu, qaic, rocket) has taken this path for
> the same reason, rather than each maintaining its own equivalent
> inside drivers/misc. Building QDA directly on this shared
> infrastructure, instead of extending fastrpc's own ad hoc buffer and
> session tracking to cover the same ground, avoids that duplication
Am sure you must have already tried this, but Can you not migrate
existing fastrpc driver to this shared infrastructure under the hood?

Can you elaborate on what are the blockers you hit in doing so?

This will ensure that UAPI is retained and still get benefit of QDA.

--srini
> going forward.

