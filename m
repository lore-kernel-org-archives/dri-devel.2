Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DAFC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C1B10EA9F;
	Tue,  8 Sep 2026 07:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="meyDObDd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uey48Xja";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F71810EA93
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:45:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M2mT2712388
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vjCdleB62PQ5+3oSfJm6THWjJHXQHO2Cei/sEBlVgJo=; b=meyDObDdxg1onozh
 BTIfrgJw9Bf20bmpFLWeHyZoqdWL8TX8jZKczZ2pE6krABotoKHevESc6wzTBOzl
 OAwYrON/e3Pl7RsZxRn/C14fZyu4VRBSt3xnJLQHdwXsh88S9DC5l9GiZmPVa8hA
 eT3Vm7Xv/6RxHAs66hv7XBakFwk2uRVloSq8Bl9hzR6PEnOgqphhTOHN2EUHNvJq
 MqXXrISTRFOLQnXj5HCjf2dsYwA1yuMoVHaaoTwJGFlGxGn9AsLUQL4zxmYGCj/X
 DkfS9JacTTbaF9b8B28tcXEN5zSj37ztLWzdNQWA+CbGZVik/3TZUBGHipETto+C
 bV2gbQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqm46q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:45:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so5396876a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788853543; x=1789458343;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjCdleB62PQ5+3oSfJm6THWjJHXQHO2Cei/sEBlVgJo=;
 b=Uey48XjaTUt+qGScpSFcvYNUjJk9jGO00w3jsCnGSLCCjzAECBcrN+rigGaANB3BgT
 mLlP5R5ySNC+JpFJoruuS2oPBEmYk8MWQ6w7wYZnssexsgdEpVfxDhwUA8CY8ldW8xuc
 YojpkmPcf6Act6cMv8Hdn7L8W6J7P6TzbnjAAOm3A7iEsjT2/NfSCxtHSfImCfLGi++4
 1vuu0HKGQJ/pM3beZ0g0bQiyNllzNHoCG4N3HHZZvAe/RWn4buJAum6oe6h06PqnrEu7
 Hi+gwu3eDF766rnsNBYVCtkLl+uUDtPoRAqyqeiTUYo2KtsZhfLv7z/RB/fIScQUPr9Q
 r4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788853543; x=1789458343;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjCdleB62PQ5+3oSfJm6THWjJHXQHO2Cei/sEBlVgJo=;
 b=ksYba44x79zo6z5ceKjp0J50PHoG/MQpoB02Eqo6nv/kJpYkuafaGWF7hDP99T0Eb6
 WasHKzMs3KkE9UtdTVmW7KeLqtECNRfIqM82/hg1kYWMyH6diyvRr4OT0RrnNNeqG2Rx
 PCcQwqfS+yQUYNBv+6HkCFjZZkw4VcLvh1WkPz08SiRRZ6YOvqPW+euHeHFNkurjtGVY
 vE5/n1CPTEF0LKNDFFYGUXRmTCWXxI9P9iaxEYKxW/65bxXpYbQzw9YFJu0OBjTrcEVt
 dGqKKc8BGoGSErYPn12riB0iT5WkhzLpeb+JvVKXH7111+tmnanmKX/k731vlKhwMca2
 C62Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5J5PWsg52daXLv0XuLJkXothI0NZFwZriDcXSbj0vNOn38mqHi6z6/rNw43kKiWyW0aWmBGJoRGI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nEFAhWcFTGOWy6bqskmXLLLBEKMKh9h1VNT/7Vn23gx1sM9hXx
 jQ6SEsk1dRQNVOMyyeDUbmF+gDkh7o38oOCrQ3hhe4UnV1nUZWXxaJIUBCRM27gQdFVdd7u1DNZ
 07OuiJ66aCVv5IPW1qf9fBYxbnFexOJPzBAiFMl9+j6eBUFFA0R4hXXVu3+BMWnX91ijq5TM=
X-Gm-Gg: AYBFou2zhsL+FHdsvtDKfPxmhp/QRbRYW1b6sHvJ0ts0xmuvJVX657DheEJKvceLCzi
 FUU6S1cB3mT+pQJ5GZzMxsrubtF+8ugn6IxbbqgT8BXp2iHBvGZOO3nxDQ4pIheZQxxFzdpRj+a
 hHZnzxscDQuOWuVlKuRCG4g33rpkpk5GTTYGAySEi1MdT5EyC3HqpZp9g6jCcZblu97NmBmx2nt
 j0vlAC04hNLm99uctzSb/vgzNAdboB03FBKuLINVBi8PsQ3KTwvd6fCRKfmZCbIm1aLs7yHjaYj
 R0eTY33EAHrwd0IM5P1V0az5d5UwdYEQreNCzAvkOds/X3fGesgvZ/lGewBl3rrGQ+z+zy7dioZ
 tjhTttTCxaO1q6xRML9Xgb9Xz5hObTQ==
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id
 98e67ed59e1d1-39b260dda6emr38832011a91.4.1788853543396; 
 Tue, 08 Sep 2026 00:45:43 -0700 (PDT)
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id
 98e67ed59e1d1-39b260dda6emr38831975a91.4.1788853542891; 
 Tue, 08 Sep 2026 00:45:42 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm14719241eec.25.2026.09.08.00.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:45:42 -0700 (PDT)
Message-ID: <a3b73723-9522-40da-806a-643093b1b227@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 13:15:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator driver
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
 <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
 <3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com>
 <4ef74e14-8433-4619-ac97-62868c8799d1@kernel.org>
 <g5orcvzjbwww27vwcsxl3ehrek6lvznxptd7jutifoiuicjnm6@iqq2pus6omsl>
 <a642833b-f22a-4bea-8a20-0debc47e1895@kernel.org>
 <4xcyqqrqbvgxojfcmnpwbi2uqk5tvhts52l6sxetltcgb7mo75@lfsgfoq4npz3>
 <59aa182d-1b4c-4bdc-a1d5-e76cc9c88ed9@kernel.org>
 <c806d7c5-98f8-4b0b-9d00-969e1917a8e4@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c806d7c5-98f8-4b0b-9d00-969e1917a8e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfXz7nNq6CnY30R
 l/H11bm+KRPl5vlWvi2+RaXQ5lvKXuLeFREtwUnNsyYpPXqq84MzmM0yJvFUoIK51WTrZ4sztST
 LfNEA5lNRUjRAvM/LiIV5upsrKEOxXDTJtnp73pxPH5jISTQAyme04wD5+4YfFH6YbW/mUZgAgs
 7CWSC4cHWbhu8NHbRfYYZBoGabL/aYzj19XaObRPnYFlAhzM2frum41bMVyVmTTy1ChFisEvFl6
 GSsWqTP0I80n7KozPqUjJgwEmUeh5AwP82WrRU4U59Oq1JzV/2wH34sdosyKEx4VIqZcJ+oBuEA
 C0nqBwS1V5gOiWf6GX5FD6yySn7szowXWFw/IgUeEV7lQEcVfKLtQ4/ktg0iGLBmUlDiqLaZ7o3
 iI5tXaeWEi0eZ2v5CAqa7N/yuU4sYb8Cm4JhHa/5faCXmvzQGiQZ8CkYJVbDAXXDNYOEx/Ze8Ze
 hkpxOVSd42gjLuuC6tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX5IiWWIyQ4otS
 pFxq+d4j11Ng0H57gvICmMqSzaD88yLGzc1SvyAvknvL/L0Zlmtebj2PNdf1D8rT2TpVIWXEq0J
 3yGK0hlO4m789dhJJLG005EUJoHSkY0=
X-Proofpoint-ORIG-GUID: gMCYvMkdjYf3d7R-uwC4oem_3JGhqgtp
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9fbd28 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wP88gyHQT0P6k6tIFBAA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: gMCYvMkdjYf3d7R-uwC4oem_3JGhqgtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080078
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

On 31-08-2026 20:28, Ekansh Gupta wrote:
> On 20-08-2026 19:01, Krzysztof Kozlowski wrote:
>> On 20/08/2026 12:07, Dmitry Baryshkov wrote:
>>> On Thu, Aug 20, 2026 at 11:07:45AM +0200, Krzysztof Kozlowski wrote:
>>>>>>>>
>>>>>>>> Device node with this compatible is already populated, so this looks
>>>>>>>> simply wrong or you are adding a duplicated driver.
>>>>>>>>
>>>>>>>> That's a no-go, you are supposed to work with existing drivers and grow
>>>>>>>> them.
>>>>>>> I'll bring the discussion again here, there was a discussion to move the
>>>>>>> driver to accel subsystem if we want to support new features/uAPI
>>>>>>> changes. Please read [1],[2] threads. The intention is to replace
>>>>>>> fastrpc driver with QDA eventually.
>>>>>>
>>>>>> None of them address the problem. You want to grow fastrpc into user of
>>>>>> dmabuf? So you move it from misc to here.
>>>>>
>>>>> It's not as easy and nice, so I think in this case it's better to repeat
>>>>
>>>> I disagree. The existing fastrpc driver is not that complicated. It's
>>>> actually moderate amount of code, much less than Venus was (~7 times less).
>>>>
>>>> It easily can grow to support two interfaces and the only difficulty is
>>>> how to manage these two interfaces simultaneously or exclusively, e.g.
>>>> opening first one disables the second.
>>>
>>> I see the point here.
>>>
>>> Would it be acceptable if we add QDA support only on the new platforms
>>> (e.g. via the SoC-specific compat), provide QDA for those platforms,
>>> and, once it reaches complete API and feature parity, we remove the old
>>> fastrpc driver, migrati old platforms.
>>
>> The problem with this approach is that we have no guarantees that it
>> will reach feature parity in respect of old interface, thus old driver
>> might stay forever. If we agree for duplicated driver, contributors have
>> no incentives to support old approach.
> That's a fair concern. Let me lay out the sequence we have in mind and
> then the concrete reasons parity is not optional for us.
> 
> The plan is staged. QDA is enabled first on new platforms, where there
> is no existing userspace to migrate and the new UAPI can be exercised
> properly. In parallel we close the remaining feature gaps against
> fastrpc. Once parity is reached we migrate the older platforms onto QDA
> and remove drivers/misc/fastrpc.c. The end state is one driver, not two.
> 
> On why parity will actually happen: the DSP firmware is not changing.
> Both drivers implement the same base protocol against the same firmware
> image, so the feature set is defined by that firmware interface, not by
> what we feel like implementing. For QDA to support a feature at all it
> has to implement the same protocol operations fastrpc already does.
> Parity is a property of the interface rather than of contributor enthusiasm.
> 
> Other than the base protocol, there are some features(daemons,
> capability, session sharing) that exist in fastrpc for performance etc.
> but are not yet part of QDA. We want to implement them properly rather
> than port them across as they stand.
> 
> The remaining question is how fastrpc can actually be removed once
> parity exists, without breaking existing userspace. That needs a
> compatibility path, and it is a deliverable we are committed to rather
> than an afterthought. For that, we need to settle is whether that path
> is a userspace shim in the library, an in-kernel translation layer
> exposing the legacy device nodes, or a hybrid. We evaluated an in-kernel
> shim during v1 and hit constraints around constructing per-client
> drm_file contexts from outside the DRM core, so the approach is still
> open. I'll come back with a concrete proposal, and it will land before
> fastrpc is removed rather than after.
> 
>>
>> Much better is to refine the old driver, gradually adding new features
>> while maintaining old stuff. This is the only way we can force
>> contributors to actively work on minimizing duplicate parts.
>>
> I believe you are suggesting we bring the new features we are developing
> with DRM core utilities into the fastrpc driver. I don't think the two
> interfaces can share one driver, though, and it isn't a question of code
> size.
> 
> fastrpc is a miscdevice: it accepts raw DMA-BUF fds as arguments and
> tracks buffers in its own per-file lists, with the fd itself being the
> buffer identity visible to the DSP. QDA is a drm_driver whose buffers
> are GEM objects in a per-drm_file handle namespace, with PRIME used for
> import and the GEM handle being the identity. These are two different
> buffer ownership models, and neither can be expressed on the other's
> file type.
> 
> Supporting both from one driver therefore means carrying both models
> simultaneously: two IOCTL surfaces, two buffer lifetimes, two teardown
> paths, and a memory manager that has to serve both. That is two drivers
> sharing a directory rather than one driver with two interfaces, and I
> think it would be harder to review, and harder to eventually untangle,
> than a separate driver with a stated removal plan.
> 
> There is also a positive reason for being in the accel subsystem rather
> than misc. We can build on existing DRM infrastructure instead of
> reimplementing it: GEM for buffer management, the device and file
> lifecycle, and the debug infrastructure. It also positions us for work
> we have planned around scheduling, drm_gpuvm, etc. Over time this should
> mean less driver-specific code, not more.
> 
> I'll restructure the cover letter so the staged rollout, the
> compatibility path and the eventual removal of drivers/misc/fastrpc.c
> are stated properly.
> 
> If after this you still want to add or change anything, please let me know.
> 
> Thanks,
> Ekansh> Best regards,

Gentle ping on this thread. Wanted to check if there's any update on the
compatible string and coexistence question above, since it's currently
blocking respin.

Thanks,
Ekansh

>> Krzysztof
> 

