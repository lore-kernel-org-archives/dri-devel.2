Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75D606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fNVD3cgM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VUI7RmPI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A48710E685;
	Wed, 25 Nov 2026 09:07:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1E810E685
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:07:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP68Tbh3534167
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JbFjtNWWTKC1BbORibQeDjAoB7n26eQHzhKA8Pohz4w=; b=fNVD3cgM34B4gPxT
 E1UqbEwqyXMf9dZr+DGGozrZkWlcFONDD6cGM2JkGYqO9/bN3M64ZdxQ0+BARvyj
 XoczQLcRZRSqn+nGcdiYOg/KuvnLOs/A5sYUb5EN1z7a510KT60lCbOn7GoXZcTM
 TaNhZuaFdGpMdGaAXxaCim3lSN79hRU2/5mecKERJQ6sCXxl1ROK55hVV2D+g2ca
 qIQ/nu6tJB2cDnftA/Soz6CN4mibqYo27PkPA0wjIv1AjWioQwjQrjfMzunBsTlm
 nSnrfn2azHJTxjYXLnhEbnacrUKG41A0lu9e/jLl/Lm0m/Tb9I5vEK9//y48285x
 IVAu6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mqbhw1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:07:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b191f8a9b3so6687426a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795597665; x=1796202465;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JbFjtNWWTKC1BbORibQeDjAoB7n26eQHzhKA8Pohz4w=;
 b=VUI7RmPI63CaI1wHYtjE7GRpNPYrFt1KbCqfdsYh0I6K3y0NtF2rORpEbSNed4gSzi
 ktDza1Ukzd3NYw1FanTV1eF3rG8zzCdoJoJ8EWiRJm33UD8nk9bSF+bpsK6nVYs66u4B
 GIn/9MkUf/j6Leg6Z4+NUfuT6IyT1eT6G7gRAQ5VWXjWiWWVb1MOhVAO+XEh/PA+rPUI
 W9sXZnfIoWJf+ASHQlcN6ebt02qbtzNqdIpG3Wo3f8VvX34Utrl3Mt79lGat1PhGfiWp
 f/4100URYeC0flpI9PyouFAHYt5NMl3N6XELIZDk2xZuY+1MKMnuU2GVhLUFxJDPL+H0
 1PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795597665; x=1796202465;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JbFjtNWWTKC1BbORibQeDjAoB7n26eQHzhKA8Pohz4w=;
 b=xrPLzcnT0yXs78kop2t0DJX/87wSB+eTRcQIvSuPESkuuvRPurGQibmRzpqdejhEoA
 j7leFNA0BdGeVt+ZmwjMaOHdBhG+sVcJQFUiN04rZFR0qqromB8zJZkhnwreacAuz/UP
 0VTql2z9Kdvtd/M+ig6Lg2VahkS4cVG5RNkurHGFG/LqnMuzMZzjcvtrTY7YDt9wDYdx
 6c8nAQJd2wtUiJMtUffRX7LhXzc6V9+WtGSI1YIsfl+kgNuaweNO5czcVmuxsNSY5rmQ
 VNMvDXNuOHsKU9m46L07dVtnBUcVLvzWmyyEOzdCT4gt4qQWWF4B4scIZory70oEJuRs
 g9UQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEz3q9nerkC50Im+M+IqMzWESFdNxwHxK6HvlNk46BziMz3xoU4DQ+F0z92+eK3GsmZRNHi7dKM1rY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8qjcACkKLtYiAGaL2K+FQxWuC8JDkEFRYUxq3txp3hgisOBocI
 n9X6fO4QdDgz19t1ChqCALTHwkR97ygpCEZhK58NyaRI9/gEQGJb51hAenotZbsDLGBuX9ohw6Y
 VyxSUxCrFoR6KfmfHRNvrztAzfDwRNZc565W8X+MHYMFMP6vA7qE3NIaEruemUMwXum3Upzc=
X-Gm-Gg: AZFdTZfJ42Jdqz6mfxXN4w0r5Dpc+YWzOkN9J/QZE6h8rhICDo9FwGm+OSJU43dyJCh
 1v6TepQ7zQv9VKiy/IyR2i9GreFpHt7UinPV0DFOWmg/pmGKD+P859QLc3jtB0Ouz1+CmO99swi
 paxumwIEjJH9vBqJ1UPt1PUugQkpfnjPvkMd2OutQX8YedYMLrttNiDjUlGjp82HvlSEDOp6Y+v
 gX8AANZmrgRtnLlVYsIq46ak6uRfRSt7vu+vTxo+mY7v700zSky4X8YkjtchVGzvKnymiBdrD1t
 yc5k85OeNsqztBBUoD86oKsp+ffD7OALhR2rx5WKzDcdouyHf3HNr+RXPYH8W4ZfsYorgd9Xr5V
 6u979PzBG4hzx/Eej+6UPi+fp6a8tZF/k+EYiKqZLJp7DLD+r2t4yPmmsc5YG+wxEmOmWUBCrI2
 RW
X-Received: by 2002:a17:90b:4d89:b0:3b4:3c33:3e5d with SMTP id
 98e67ed59e1d1-3b43c334caemr8256708a91.67.1795597664796; 
 Wed, 25 Nov 2026 01:07:44 -0800 (PST)
X-Received: by 2002:a17:90b:4d89:b0:3b4:3c33:3e5d with SMTP id
 98e67ed59e1d1-3b43c334caemr8256260a91.67.1795597651179; 
 Wed, 25 Nov 2026 01:07:31 -0800 (PST)
Received: from [192.168.1.12] ([223.230.5.36])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b420e1307csm25769550a91.7.2026.11.25.01.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 01:07:30 -0800 (PST)
Message-ID: <42920cf2-1587-47a9-a53d-d604bfb22b76@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 14:37:19 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/25] accel/qda: Add DSP capability query
To: Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Srinivas Kandagatla
 <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, rob.clark@oss.qualcomm.com,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-23-88f2f24a5f0b@qti.qualcomm.com>
 <23d04f27-dd2d-414b-acc1-27e46538bfcb@app.fastmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <23d04f27-dd2d-414b-acc1-27e46538bfcb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNiBTYWx0ZWRfX2SS6i+CkzuOF
 wxDU+7H3cr1BOerX5HyddLSEAbt1AJx+nxvXJ90oAat5SWSWp+FJYWcXrFv5n+/ejeFlyGLKSlM
 FxQKgfd8vSzkRF/U+19SwcGHM12RKvM=
X-Authority-Analysis: v=2.4 cv=Bb9NQbt2 c=1 sm=1 tr=0 ts=6b06a561 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=7CQlB+x2kvO/AZ184d7fkw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Uvs7DDoz1aZytBm4-AQA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNiBTYWx0ZWRfX8qXYeOu4C4xA
 utZGqetbB1rTLdsaLWWUiB8NNZy9R63qses5iZ+aQo72jkC8VEkgJQUjGlXHKIndXm8jOvdN9Pd
 sJjFPhuI2LFOArPBbT6nYSj6bcdlboDRGlbK747qMHCLg1pl8SgRi44RGL0N76nzOTiAuL3aIRu
 TYtwjuY8C2m5K9PUYKvLuIZKM1DcEPQl9Lz0KV+VYIK/sUzTC+V9WIM8PE36vpidSnbI12J9aY7
 pNZO2TX7qH7LL06geFyVGwaWaxEuL5b9bBTYu8+48KYm7m4ZpJ3AZadPVSfwa9F3/GDROQErjXA
 sY2l99+Voj53ZPNH73SP6eRVvtqPo03J8nBmN78F6hT7YZe5RLn3zpWdNVPSYpn0HcUCRNceSMM
 yv95alquE+WSe5n0ukLGetAaWgMEBUJEQV7fPYokfssGrpQh1BQjhIFF8ayQV1ooQMtmdxR7k69
 qSPyxRfFs66+l9xkfIA==
X-Proofpoint-ORIG-GUID: GTZc1PO_eEy-babPpqTTzgNW_GenPBVD
X-Proofpoint-GUID: GTZc1PO_eEy-babPpqTTzgNW_GenPBVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250036
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02-11-2026 14:16, Arnd Bergmann wrote:
> On Sun, Nov 1, 2026, at 23:21, Ekansh Gupta wrote:
> 
>>   *
>>   * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
>> - * based on @query_type.
>> + * based on @query_type. @dsp_name and @cap share storage, as only one query
>> + * is made per call.
>>   */
>>  struct drm_qda_query {
>>  	__u32 query_type;
>> -	__u8 dsp_name[16];
>> +	union {
>> +		__u8 dsp_name[16];
>> +		struct {
>> +			__u32 attribute_id;
>> +			__u32 capability;
>> +		} cap;
>> +	};
>>  };
> 
> I think it would be better to make this separate ioctl commands
> instead of a multiplexer for each thing you query. ioctl numbers
> are cheap, but complexity is not.
> 
>     Arnd
Apologies for the delay in responding.

I'd prefer to keep a single query ioctl, and likewise a single
SET_OPTION ioctl, for these reasons:

1. Precedent:
A selector-based query ioctl is the established DRM/accel pattern, e.g.
DRM_IOCTL_AMDGPU_INFO, DRM_IOCTL_AMDXDNA_GET_INFO,
DRM_IOCTL_IVPU_GET_PARAM and DRM_IOCTL_PANFROST_GET_PARAM.

2. Extensibility:
More queries and options are expected. With one ioctl, each is just a
new selector value. Separate ioctls would mean a new ioctl number, uapi
struct and shim mapping for every small addition.

3. Safe evolution:
Unknown selectors return -EINVAL, so userspace can detect an older
kernel and fall back. I'll also keep the struct size fixed (padded
union) so adding a type never changes the ABI.

To address the complexity concern, v5 will document each query type's
payload in the uapi header, and fields unused by a type must be zero.

Thanks,
Ekansh
