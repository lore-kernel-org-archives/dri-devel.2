Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5836C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A3E10E7CA;
	Mon, 29 Jun 2026 10:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GsP5MDk0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnBE3DfS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7107210E7C8
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:03:42 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T6sKBE2143092
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PYHNWcfl+oUcCDN6S/9Tc9R1TgjQaE4yesMb6v+V/Qc=; b=GsP5MDk0mqHQMzqj
 N9852vyZKCbZIehNPASb9xBdchuJObEM5NdxqOgwSw5ATSuvVXbR+ogtNdsFpbTT
 oYMk35j4nYHgQGiCVw28/H5USPQ400fnMTT9hCusy9lHHQ7UeDuCAWnuaBBFarY7
 8qIRGvTMFpKpzCIzKcULapv+h5wyv2iqsjbGVfj9STEqBwkszIIx7qFmUAcWEFvW
 J0orUNGfr/8+ZsIDciYFmmj/KscDNx17HflWmyhe/JnZG59k9J/gvNMbKcq5Jkb6
 KTDnf+bUJOhkYMGBCno7zS2Ifw1b6DrKcRuQk4gS3kpOUTar8QfZn+sM/32zeeK7
 N+HXNA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8nxsy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:03:41 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73966c839bfso11214137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782727420; x=1783332220;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PYHNWcfl+oUcCDN6S/9Tc9R1TgjQaE4yesMb6v+V/Qc=;
 b=WnBE3DfSF3hwWA1g41KvE1qKlcgtBpFGb6D53Hj12/mIJGjDHpVRf9NjEnRyO84EQO
 WQSSCtP65CpnWP9k/XRSWS4UcQpzBLTSIaicoEerUw2mmJunNv/5lC1+vD/SsIkUlzO6
 HpjT00YMlgStNMC1+Uall6osVFWNWLEvuJabBjUsbi8+SHRa/uJLxvNoGVjYj9+qRYQM
 Hl2fqQjmjRKjfHtL/MB2QBf2tSfGzb7Uls+Q3V8/GUdeyQto8PwY0Q6Goh5lIpoARv3K
 0udo/UVunvbmyuzfSs29581RUC1WPNCSsO+nT8HYbKAaQyl3dAkXfgiUhSyzlDG5YhbN
 A6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782727420; x=1783332220;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PYHNWcfl+oUcCDN6S/9Tc9R1TgjQaE4yesMb6v+V/Qc=;
 b=oxBeAM1PlUYCkyfWLeMsH4+R42b+Fl4wP5TxsbXbn73+u/3Q6tjBxch2VrAEo75u58
 CCAQeJTnrBgIAcztECOyxPKzVZcPoO/5OqtYvUy3JMUbQk1u421+LvIFDY4oaoVvERRP
 85PB1c0jjPUPiq1gUWKgEDnShy8G4rjBhVXAVVHf/jEYKRlk59Kq0RtfJTYe0MpdLHo+
 BjCYLdfTZyHKecMA8ELOz2fNPCyXqmTAgmwU+hQuW+VE98iLhzFW+gCHa2hCEG91Q92/
 wDW7rXV2ReyzTLeF5h05WBwN2++I/7fdWEyjQonMTx9qarWXvPm3UWIPqpHIHdw+APHz
 Gc8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqqqpm7lZZXnykC3ZUHbriCp96cTNczo/FwdGse/JyX5qoO1EDvOPWJA9B9IdEqh2TJyDFyOq+dR3I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc6Z/deHsMqqdDDHR4rgjiOpk4Le+uvtHvRWYtviLfriqytR4D
 vQ6aLRMNXVG5qsvsQmKc1lf/LDQcUDM9AY1wt0OHvuq/7MPhM245i3NHFNHN+UwHziJSKAKam0K
 4g0FWuhn4bsjPvilhdbHNOmaRdUYcPlEc6pmEBLfH3361MgS9eeR04tRBNDbu2byFcBOxmIk=
X-Gm-Gg: AfdE7ckg+FrnfwyKcJx3I5FhkwDaeUPWflvVSrzBgd5+iOiKri1iKGKwvU1x5pALMZW
 tGKEgMQgBFjwBlY2uN85HmTn4RaialiaIXQMMMsoaPD9FtUXxCu9/cs1vt8Y9u8azjgwyD/7w29
 Z1fCmo5GAso299RD6zZ6mDsSLq8El9l1Sm2SCwWrcLYdrDhrwkK2OXBE7DelBnM6AbZUV/ip28L
 ZixqG4+5U9F98bnEpFbivI7nHnCHcfE2xaoeHmeSixl84qXhFYX3hNjqjDlS9ryRLm1pwjeG6M/
 GWjLVzzwjwjv9Bym9+k+Hg9IxwRcMSKFJPjoUemzsv6c8GpA4y2HJ6lzfixK+cvj0TPVsRPcqdE
 3E4z5GiydLsPdgj8fPDSL9jYPzYMkiWDu4PU=
X-Received: by 2002:ac5:c84e:0:b0:575:b506:43cd with SMTP id
 71dfb90a1353d-5bd912ea4ddmr711999e0c.1.1782727420540; 
 Mon, 29 Jun 2026 03:03:40 -0700 (PDT)
X-Received: by 2002:ac5:c84e:0:b0:575:b506:43cd with SMTP id
 71dfb90a1353d-5bd912ea4ddmr711997e0c.1.1782727420123; 
 Mon, 29 Jun 2026 03:03:40 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6985f30fb31sm2132833a12.21.2026.06.29.03.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 03:03:38 -0700 (PDT)
Message-ID: <1efac6e5-b4af-4c48-94a8-5e55cee0a864@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/msm/mdss: keep mdp1-mem interconnect alive during
 suspend on SDM845
To: me@samcday.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260627-rfc-sdm845-interconnect-collapse-workaround-v1-1-608a38de3715@samcday.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260627-rfc-sdm845-interconnect-collapse-workaround-v1-1-608a38de3715@samcday.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MSBTYWx0ZWRfX/hwWkb1HNhJm
 4/LMKJUKazbfgdt8iXj6Amzt4ZyuNSqRm3TWeO8Bv3lzIVxvRFc2Enr6vAFXE/eyIPqxScGUKB7
 wXvdc+Nrxt6XwD7p/0TqkmcVqrbZi1k=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a4242fd cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=lKQ-AihTAAAA:8 a=R-HWJY1cPxioPo3k6UQA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=K6G5NyU7usMl-irPePdK:22
X-Proofpoint-GUID: 6nThV0dUIQWW2VIVJeqD0tXQ1LuSrJPY
X-Proofpoint-ORIG-GUID: 6nThV0dUIQWW2VIVJeqD0tXQ1LuSrJPY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MSBTYWx0ZWRfX+yh1OIfdAbGS
 icO4TuNhqXOwRI9ZNwZl7qXF5ufPUY0l9CifKD3aRO3rJL6/tS1XTPY4rcXi3hzM1tsPfgMetc4
 QtqbZ+rKyk7mW/PvK5KUi5mi5rap/6VOGcZsSRFy8YgzpwNXQRFEe3BeuTQDB6SzdMnlnvyoFvD
 DW6ka/kHEH+ugcMc7sSOdB0EJTDhWrrsC+FgibiDSC68ysMu4WgdRUFOVlZ9wm5a/UPKUAR6C4Q
 ZLBT5oh2rjRVMkuCnOWlSEScb+I3EUzT5EwGwbpKASim6/Vw013tJnzECGnG8N/ykmUTLqd9zAa
 z6Qjh+aF5LlP1peonpAkC/Ix9ErXoOR+rL8XMFMziCVQUw6EpEICQSvQdOiRAwo+E0uE0EWavqe
 CrlzXpW8/n7nBI25qLoukU8puA9cwfxcZTNFKAKaoafoSKZOeteJlCU5BxfCBkVEMjHVbFkZ///
 ZAGH8MlMx2Fy8HRLFiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290081
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

On 6/27/26 2:18 PM, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> If the peak vote for mdp1-mem is allowed to drop to zero, it seems to
> cause the fabric to collapse that path entirely, which causes the device
> to bus stall and fatally reset.

Which fabric? MMSS_NOC?

Can you experiment with setting keepalive = true/false on bcm_mmX
in drivers/interconnect/qcom/sdm845.c?

Konrad
