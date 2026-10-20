Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831B606A322
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nlRDOa8t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PVZ2P1pk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1BC510F2C9;
	Tue, 20 Oct 2026 07:35:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A020610F2C9
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:35:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tOKV3807210
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DZRPJySHmg1AbHi/1VKM5kCKJJzzQaHn48CduryjPiU=; b=nlRDOa8t9Hgr9vm8
 Exp0+O4d+Xq/xMzvPrNn5DYCcsjtKzuLCyw20nRs4FePtAY6GbdMW7zyWxPDL6bA
 19+GeiCCMFgoBnkaw3ePKddjvKYbPqPNXbu8ei0HeNVbwvIi1SO+PETvFZQFjxNQ
 90t9Z0t4j496eyQ5YcbChZ2d8i6fEGd5Jz0onMYlMQssopqHIIzOzde02sfCmQlV
 WmvmbtI42ccAuZLXFPFdj/VNRrIWZtmgYr2is7Q4x+lxqCfA2qu/swuxyGatNtmN
 iqXiRQr1EpvjbRrSbglaH8GdJEzxYHGMU4zEbCcEGENoFD62C48b7mC0nNqgBUUW
 PZKQKg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p9dnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:35:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53568f05f8bso9211701cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792481726; x=1793086526;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DZRPJySHmg1AbHi/1VKM5kCKJJzzQaHn48CduryjPiU=;
 b=PVZ2P1pkXaC+ltt4I3HQxIy7MBfGEK4wZct64aBaW5qxfd1LqW8u4/NYlUsM9CUFjz
 YBcgcxD7qBW/9eFxHbahX5qi854vQxOATqCyz+VXjxffqOr7elb4REOIQHFbHLt9+BpK
 lcdp5+SwFSekuT3M98ydg4NuB9pJNupytFN8CAG//uuZOFpTyVpVj4KfRsDsT8Atqgi6
 Rx4An2Awqjto3bGN9xJaI4hkbhhxTm8rGrDtm00dw1lLmcBT3ErAUjylFMhgUM6RIWEB
 yLmwghpIkHOTlqq6+kfyTEhbXB8SRjEfnLCP97Qsj2hgCVrpvDfeOPsX2o+PA9tSlN/M
 w0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792481726; x=1793086526;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DZRPJySHmg1AbHi/1VKM5kCKJJzzQaHn48CduryjPiU=;
 b=E/ccSLWrT//2aDFsY1itzZyypxVAUc0Do2m4kyWdrYEIuI+xm8f7nnvbxbOMDvsrIq
 HalQogCsv1Pz6ucMVpP2utWM7gfzafp/PqpnuohS6VRTUcKJQPVv7p8Rw6a/ReQ+2EY5
 pwyqZKG2wMvbTLhQQDCj+7mBMYmjeRbpNme4SueRg/Kgs+qD8gCAhF+expepuJoydzEO
 GASWLIKwM8YXLGUX+l9GDdMa/XLwI2EjY3cxVhnrUHi9QCIgbUPEwO5XRwROCHzksNWC
 R2tfv2p/GatHReoY3RxRtlYitkzyDBaTCtFXrOCFFJXPBMbgqQedBRTjPwaQ1VP78Hcx
 /zWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkMVA8tslD9m14VSObjvc7tPwgy/qJZsgO8R/dqcnSTaUZwAhapuvotpFeEyJ6z5qIU2kImFDqpns=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLZ5C1xNtEvr5mLTBxnZok2Y+I5uixgsfT7PIYNQJdNVDqvp8z/
 rZT04Ki4XIiWN2koOjiPQNh/5ldNKJnCxeU1k2mr2Mxv9DJvuPQ69T0PKCKd1a5xUh3uN9+IvZ6
 dCp21SI8vwOvZYPJ3BdDOKZJizWebnpSJEllJaWGXis3sCfxQd+qRfv0ttqjwyxsH1hGHuzc=
X-Gm-Gg: AYBFou0sjRZvRUPUZbphNuZ9F3NyeWjtzi8tMMo6YVuQZllxq7hxsdtHmo7iewfsDD2
 sTg5Gf1Tt6HeTE2vZE4olKy5CmtxgxY8U8UhtiLshb5Uh47+ftNjIdku0sPkgM7YSCbPh860p3M
 4Ix9Xop9S++/dn90daq4rVUSwKPXt3zi8UX1xRVjT7lysTumruVoQ/qxJp31zCqeKepvERoCtjz
 KuilnPNEOG6wMWtPe4uCFI0kmc/Igt3wu+n/+XeGVJ3D5pn4jUKiHiY8LI/Oa1SIo79Gyu2bNzo
 Zt+uSViWVigjwj0yZ6anF5UvxDoOhBaOXipthxSyqnexcmdeV2ew2YIp1s2SzDdaHpOYxQoEaRO
 fKAvUGbD7mVndgxpUk0e6ww==
X-Received: by 2002:a05:622a:14cb:b0:51c:2324:666 with SMTP id
 d75a77b69052e-536460e29afmr170738911cf.3.1792481725990; 
 Tue, 20 Oct 2026 00:35:25 -0700 (PDT)
X-Received: by 2002:a05:622a:14cb:b0:51c:2324:666 with SMTP id
 d75a77b69052e-536460e29afmr170737751cf.3.1792481724319; 
 Tue, 20 Oct 2026 00:35:24 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091eb14a7sm471411166b.76.2026.10.20.00.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:35:23 -0700 (PDT)
Message-ID: <a69738f1-1c6a-4476-9c0c-8443650d1f6a@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:35:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
To: Luca Weiss <luca.weiss@fairphone.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Jasper Korten <jja2000@gmail.com>,
 Federico Amedeo Izzo <federico@izzo.pro>, Luca Weiss <luca@lucaweiss.eu>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
 <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
 <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
 <emdm463llmoi6vsv3zmfjddqrfaf2iubdnydsqye2n6ui56oae@frsvj6el3zvq>
 <DM4DIJZOLJC0.2KAZET8VYUDY0@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DM4DIJZOLJC0.2KAZET8VYUDY0@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1JUY6dyTRhE8hdPswEsLo3GwGDVBZAEQ
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad719bf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=b7wq30jk4QowdIX3xroA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX07AU6RoTdlMe
 lGAE2dMhBYsC6EWR649yZ+8jf+Dhnq9MOJKC0anp43UxCUhfkX6XrUJiBn1ITUM43lspbigq6V7
 WESYvHSdr45OCWMgZVIX+IwJ2vwNJ3YcrEYj5PcD8nyN2aXkA0I0+3RjfVZ7eSxGgKwCaCihR8i
 Cu1QZorgZeMUc0AmZncgbiJXnKQLwVorET+v9Gxg1v6C51RJPeVKUKH6tG9szhf9YLtyg21Pbok
 Ti29i1xHvmFzVvT4qwIxDLXyYo5HKQNW+3A2fM61J7kB2XT5mbnsjV7mF4XkGehHD566U2n3+YR
 FNxhHqVrJ609NTCsXSwzUR9FgEKbWSr2rChJP8WUeMiUapgS7wKNdg/5gsi+gGTItOy9L9h8Mud
 3ir5SmokCuPZgyIednH6COfm0GUUNVw30P65pfq1QhorIpGGtRfUtxk6Y+BttTqVeD7Mv2LsqfJ
 qWRTNQXaxvHEaXPvFsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX+TVWIbkJ4kJb
 bVhBCYAegWM2szdbb3TCnfePwBADv8q+CxwBhVGDGUnXcmlPKseeLPIaUhnEuF1xwQy9pGBrLjD
 kQOQAGgKo1YTfGDeEv6JIIyecLUuKhI=
X-Proofpoint-ORIG-GUID: 1JUY6dyTRhE8hdPswEsLo3GwGDVBZAEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 9:13 AM, Luca Weiss wrote:
> On Wed Oct 14, 2026 at 3:28 AM CEST, Dmitry Baryshkov wrote:
>> On Tue, Oct 13, 2026 at 12:17:05PM +0200, Luca Weiss wrote:
>>> On Tue Oct 13, 2026 at 12:10 PM CEST, Konrad Dybcio wrote:
>>>> On 10/12/26 8:11 PM, Luca Weiss wrote:
>>>>> From: Jasper Korten <jja2000@gmail.com>

[...]


>>>> I'm assuming there's no pmic-glink on this device?
>>>
>>> I'm not quite sure yet how the USB stuff works. For sure from
>>> observation, USB-C only works when stuff was plugged-in at boot time
>>> (UEFI?), and charger also only supplies any power (but not actually
>>> charging) when plugged in at boot time.
>>
>> This means that something is not 100% correct, for example, missing EC
>> support.
> 
> For sure some bits are missing. This laptop doesn't have an EC per-se,
> it's got a "EMEC" - Emulated EC, where on Windows there's just a bunch
> of drivers handling EC-like functionality.
> 
> So e.g. already for battery, we just talk with the sbs-battery directly.
> I assume this will be the case for the other components on this laptop
> as well.

I guess sweeping the i2c busses would be a good start. The other day
we got a contribution for a SM8550-based Samsung tablet which also
didn't have pmic-glink, but used a SM5714 IC instead:

https://lore.kernel.org/linux-arm-msm/f7ba4d5a-0e8c-417d-a1fd-5b5e392df71a@dxdmail.cc/

Konrad
