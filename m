Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575C7C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC8210E4D4;
	Tue, 18 Aug 2026 05:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nrbmFUAA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jeqM6Y2s";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E05110E4D4
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:54:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I52odM3464514
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TbCaoRP4jgmLhzxgTcurQvCQNdUxxOfgWCAkLYtazKo=; b=nrbmFUAASt8pesrB
 u6WXz3wMqamtjyeAym9VEQ30v6hrhOpqNHLRXUYW1z69xos7AnS5/aaIr4VCSczG
 2hUyBz7eu41USoVjZRxHSV1xEdUrpHXsUMerp0kOsHW3MKOd8F7PuiLIRmdfdFMF
 tEzdmZDbZOx/GPAPsRbBnqRa+7Ju90vC2pfkQfnj76wXlM+/ZF4vXSCDIcFsbfVu
 ruQQdsAJ8IFCQ5EA450ikk6EUspdIKiobXhzSvQCBGFerd0bZfdwoHz4Hb6k+3mK
 2JmbjRf6C8qC9vAorkSv/A42ODwkMaZRZWjXqkTjUwHinLZysyNdsyl0lxFjjXSi
 MwL3vQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4611ayqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:54:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbe77d6864dso7216534a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787032454; x=1787637254;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TbCaoRP4jgmLhzxgTcurQvCQNdUxxOfgWCAkLYtazKo=;
 b=jeqM6Y2s3mqKxVDNFeeUOmr5ptIhrYtD3VmyuBTSmm3uq8dAHk9rA0astB0FmCkyC+
 8iWfxs1esjcOZdPKf3LFZI2vR8FlMVbDynfWsme4JqvHbEwDxpW8zBh99lVwBbeWgw1j
 JDSEz928ztLNYITkAKsQCdJ0q9Ct4C0BXugqN+dm425QzOWaffDsYfhUmgSK3ar8NZxE
 +p6HBluW0ts9VVvXnkdEaeSJbSPOOwlf43/xXefZz0GkUm24nTltiFmLnXJf7JHSEUMf
 Y9uXGpYlA7rLtBgXDLSOp9QEpQ+PMzPko1yRDfUGXr9+vCpHytu+3E3A1pqwqhcVioXO
 87qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787032454; x=1787637254;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbCaoRP4jgmLhzxgTcurQvCQNdUxxOfgWCAkLYtazKo=;
 b=cEtxfUENtQxSyJ/rpSPiuwxFFKiIlYNUr4SvTFaEPEjX/C0SRaTepe3drQlr0dypCx
 HeuXm98EQOeifYWF+D1TpjMelq/DjxhKQZlHKcmfHaTDOEk0q5EHAuuLWY8t/xtMwft4
 GGbHY4l6yTsDXRF4+neKmrTmvoA6SokTAf/IvfpNm4a1etV2Oz0T3UM3OCyxJSdkYahY
 s4o6NTZ9uvOhi2q7I9VSxBIYfv7S2/XZXFhGf8IL578q4KwFmgRg72QunPZaUhMoVGXj
 92HrhBSMlpxH+hE4DpEdzTy7hOAQ1FGvcjNIzw94ZD3vuURzxdKQV4n8xWAv6VZLKxEJ
 JB4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiQoDxl/34GLL40Kr97COHmt6+y6LjNvIvN/8A1wqTN/OGfkqx5D2569Gcp9ZIT/JcSoL26FSJ5Hk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycNr9NJXRZWF5/KXloyuZU8Fkb6nUH4Eye7SkaGe8doeDiFxNh
 rrJrwgSJAGbyO9vyoLeJ2XbA2v9FUToiJcVuCCgDAZZJXh515daGMe2zlyp43zoVFPriS4P+O+C
 +cSiiUcXIjdaMzDCLdkp1YW8ayePLwnm9dcYdJfbtPet3KmgOWOwMP5bOSktAo1Vk6pXG0to=
X-Gm-Gg: AR+sD114ygycfIg8ycXMsix973+vBbZDPI+POXZtwGaAcykmmDJOUU94ZlcLSNSYRuc
 DDm3dJEO/05dYaCKCrpFU4cAbsnORPrIl+I0UE94DiLT459NaXkn6tmkCIqYo0xycl08TzabRRo
 /76x0fMSXwXMbYF3rGerEuyOlVZHfaiiRTiMLm8acJm1vYPy8PDWqt9r184RdFfMSAXQUgxt62n
 l8pNJsR93duJi5nobGQyqBAPC9ulDd6dCTopteijl3l6MBHuWRua4oU7bBK1QeiPcrxxrFNV+T6
 DGHHSBXXgYPEzgq685/vbl8fu+kohbrCD9+nxuYdQMm8QJT8Jxy5IQ/8VT7GMyjI66/Ro/Od8/Q
 vRUKYg3Wm05CPwKZa2/mufnk3A7JeQA==
X-Received: by 2002:a05:6300:141:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cc71b19c7emr37663923637.16.1787032453956; 
 Mon, 17 Aug 2026 22:54:13 -0700 (PDT)
X-Received: by 2002:a05:6300:141:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cc71b19c7emr37663839637.16.1787032453547; 
 Mon, 17 Aug 2026 22:54:13 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13bf26a0esm1592712a12.8.2026.08.17.22.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:54:13 -0700 (PDT)
Message-ID: <376e0fa0-c863-45ae-a8f8-6d4b74ef0b8b@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:24:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET
 IOCTLs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-10-69a02e9090d4@oss.qualcomm.com>
 <tjfcsz62is33iphcwtensnoiohhpfk2zh43qfe7ijd4b2324pk@v3piffq646ac>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <tjfcsz62is33iphcwtensnoiohhpfk2zh43qfe7ijd4b2324pk@v3piffq646ac>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DYWL-aNdQ1aGmzxOzsz2XYXHcG-nAL1X
X-Proofpoint-ORIG-GUID: DYWL-aNdQ1aGmzxOzsz2XYXHcG-nAL1X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX4m+KxOxNRWUV
 pqsZWXn4Ak7CpXpF90wR5J0OK0eNG5LY8TsBjb6ooHluCJS4N4z+kfNAP2h51amEJZn4Zb6+Npg
 X8crx77VxtyugRUoTbS6UtT9ThLbea8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfXwzbHIe0kVKtr
 FrNpZP9AmgG1KAUpHKKA2UVcDgd1ZENSAUAlhD7nSUiXhi9mXYBIh/XKiB13/AqPf8u/y7A9myF
 hrdYdSTeJP8YTTg6o6XkLA3WaFwbmLEmY/JAsMYPL96LXY+0tgl5e9URMLMc08l9MUuRQiZe1BD
 mNIzg3cZ9cR29D+7sjR+JMKv/EA9DwePowzSpQwiZ9S3TDnILNH9GVqF7qyuklDpw6FUXq/KVq9
 VmefJZaOyZf7R4ooPXb77N7ixbXxUzhYAg35V2lMlgPF+/S0qPWXIvynS9zpDTdYvmYfXBGhVN8
 OQHXkJOLVIXvkMl4ZwK6ccYIUVSezwq1aYtWJE1JCXBBeAP0PX2excmIRixRX0hjt4zohzSH6zt
 +/9+487YQHRVHsqXP+afCJ4h3OR0pqHzR2sBY5wcAXWJWFrYQ+nQPeENiA5585f/9y+5D8oHmp9
 2XQtquUPcHH0SbNOm9w==
X-Authority-Analysis: v=2.4 cv=UslT8ewB c=1 sm=1 tr=0 ts=6a83f386 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cA8Zc-eO91vsJqbwH70A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180042
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

On 18-08-2026 09:19, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:45AM +0530, Ekansh Gupta wrote:
>> Expose two new DRM IOCTLs that allow user-space to allocate DMA-backed
>> GEM buffer objects and retrieve their mmap offsets.
>>
>> DRM_IOCTL_QDA_GEM_CREATE (drm_qda_gem_create)
>>   Allocates a DMA-coherent GEM buffer of the requested size. The
>>   memory manager assigns an IOMMU context bank to the calling process
>>   on first use and performs the DMA allocation against that bank.
>>   Returns a GEM handle that identifies the buffer for subsequent
>>   operations.
>>
>> DRM_IOCTL_QDA_GEM_MMAP_OFFSET (drm_qda_gem_mmap_offset)
>>   Returns the mmap offset for an existing GEM handle. The offset can
>>   be passed directly to mmap() to map the buffer into user-space.
>>   Imported DMA-BUF objects are rejected by drm_gem_dumb_map_offset().
>>
>> DRIVER_GEM is added to driver_features now that GEM IOCTLs are
>> present.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/qda_drv.c   |  4 +++-
>>  drivers/accel/qda/qda_ioctl.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_ioctl.h |  2 ++
>>  include/uapi/drm/qda_accel.h  | 36 +++++++++++++++++++++++++++++++
>>  4 files changed, 91 insertions(+), 1 deletion(-)
>>
> 
> The patch LGTM. THe commit messages needs a rewrite
will fix to commit message, thanks.>

