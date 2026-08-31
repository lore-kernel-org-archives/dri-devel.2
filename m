Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C055C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F8B10E378;
	Mon, 31 Aug 2026 14:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RNo5dLP3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y3rDyKJl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7B310E378
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:59:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VET8qI772430
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wg0JqqCSPSCZp/i8yYOWVkckv8WI7h3iPOxiOF8q4I4=; b=RNo5dLP3hOIk5Y67
 DuUCFYBfTeqD8IVSbibfex3eUWG3dGAVZkRRpZZB5RVRVwOaOx64pzGEmQtz7NXV
 ofsMDmGyE2+LY2AcMpTj/lGd2AljYUtRZGAiaMe3o8x/mtOPD1h5pIVYSXqlNAys
 UjlcUOHxNQomCcwKgPs22A1DqUTWJPS45w0urJKogvFWlTByo7p2FicOtEPQ+m/t
 XNmAZ9/We57PY+82jgilhZ7fOF7iJP5ca/CRwamMA2/qWajw0ctl93ETxhCOo6tG
 5P0vjmYqvgD70FqJvEJbI2Br4u9uut+NbNDSKUMCwxj6hrbzmI8sOiys06glGRJj
 vhVqjg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd8cvrycm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:59:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce7dfd33ffso51406895ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788188341; x=1788793141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wg0JqqCSPSCZp/i8yYOWVkckv8WI7h3iPOxiOF8q4I4=;
 b=Y3rDyKJlUNlptInICKcWylrujvDEHV+EQ3cngop+JfRJCGckM4sV+tU6QLaDhB5n23
 FM7CAdvSVwKFIwsJIQjlIOK9lYD75dPBukWR1Cc38ls17inJ8c/3T4cDxkCiPaxHMHu/
 j602GrNiJXxhVSYaCs0AAZw0Vd1kbcNaNHThQyuyz4TZcEwcjNbAJks4aW4fOw0Pf0pe
 J8q5PGiHzCk9dxHnwBDzbU6sEDTpxTKqKrjVBJev2UlLAjrHErEhvFyipjFe6P5pf/4W
 cPxF5jYxiKVgdMPDuuBiqCH2cXT2Pb4SSpqcfJRv/DtwNRNS7r+zHSmPMGa8WfqhIT8Y
 1y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788188341; x=1788793141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wg0JqqCSPSCZp/i8yYOWVkckv8WI7h3iPOxiOF8q4I4=;
 b=F4iplb4n/i57R61kFZDNB+nC5gCW/Q5yJYPqWqUufrrK7CkseeyCgD69MVjKXRaWgo
 Owinu1egtTpCa9sE/9J9LbqgMaEy4WXKCr8Fpag/5T3CtIyZ6GZ3XIc/stqpAKdrD3DB
 ByqaSUoJuAF9zZ/upsJyBK3NtfFs3lv8SyV4e/sfCJKa2sGcxAtI3YZiFyccP2QV1u+d
 ovmDP/NAJjfNOjMLSdgXnI9c20bAuym/myUUpV/Mdw/WmQyc0+faCNRGIw4Tg6NnrcOX
 9Ie00Wpy5ZftR7FuB8PZLPo1wJ8KJgqKCZ2WXS1W9D3sHXWj2Y/BbisKZfo+46z+yKvq
 wGTA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCN8oTrx2/sNT/Mx1bOr9k4JKh1a5VVs4zhQe1IS9Vy37WQ6QiR7CKGwOVSqok1EnIcvDM/ucPIXg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ldCJhqVI7xatX3ePmcffLJ7E6snoKcxUqUtO37zuW5XW4ELKZr
 RXDzugA1gEQaHR6NFKBsfo8tZkRpD/+Ycy7dTDiX2iMehFHeggiP5cniNUhKl4mYquMA+uafodU
 RAKBbahUQBAaTMXCq6YxLE6AvmT20AxkCyVplHNCqwePaL6oSL+tr8yoEWid/lPwsgTqo9Os=
X-Gm-Gg: AYBFou1J0NY7hU6e5VmQyG3BOdtUzUqolObBZPy9jlobsxxXR93/v2lykzb+ZtoP5hB
 lp1KXUVEr96CGE3v7q0VE8VomqHhc/cr5sWit2VFqnCjFgLh1Dtfe6M1Bn7EafGSnEtUEomRwBv
 KwxrS9rf/Vw0ZZwsovaiApk92zrES1d97PkwVUXKPUiHvyJmNzS6kgH/puxsd9ObjLHBzXFRrRd
 P4zPeFA7TgaSVWtZ9nfeUT1s2KqcCz0bbEYvd39S6zivzmggdohRGOv+oK63MrQXMff6RtXCkF1
 kFJGzlsWfNyjJH/DiLGu5/UfNTvS7D3yo7B/wmkASuZUQKiRKO6LgK3i6WlkgBB9xh0OE/fBx2N
 K33Tb79yXFaQRnBdrZU+2BkMPdWk6VQ==
X-Received: by 2002:a17:903:3845:b0:2cf:4339:aaa with SMTP id
 d9443c01a7336-2d94a8d4c2fmr16521485ad.12.1788188340994; 
 Mon, 31 Aug 2026 07:59:00 -0700 (PDT)
X-Received: by 2002:a17:903:3845:b0:2cf:4339:aaa with SMTP id
 d9443c01a7336-2d94a8d4c2fmr16518755ad.12.1788188338939; 
 Mon, 31 Aug 2026 07:58:58 -0700 (PDT)
Received: from [192.168.1.9] ([171.61.213.165])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be440sm35296218eec.7.2026.08.31.07.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 07:58:58 -0700 (PDT)
Message-ID: <c806d7c5-98f8-4b0b-9d00-969e1917a8e4@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 20:28:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator driver
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
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <59aa182d-1b4c-4bdc-a1d5-e76cc9c88ed9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX/9C8iXSpX2a1
 snb312S3gb0Yv8oSuDgstdp/3H9aZoRKDwTgg5AhWmhgxDgiUrqnOyIN5QgD9KxydaM2CAVO/AN
 lL7eUFZ3wM7nWPzb7oKaJFgnM4XH3S4=
X-Authority-Analysis: v=2.4 cv=JtnBas4C c=1 sm=1 tr=0 ts=6a9596b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=wNR32fmSmbAooUEeK+VsOQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=zzkdEwteAlqJkH2fiosA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXyp6/Ky1F5gV7
 dgT9taeioQQFxV3PzDD2HdyJDq6+LbAB2vNjHbe4OOwX+7kI5x8owjM9P/F692KSdFjsoVk+Pda
 FfzLqdD95tyuWODkvZ89k9Ns24KO+EMCpEt1+NcNicSmFXXjghND9qSw/FMiIMUEqfcfGt2KHGX
 LjHcHRnZj3xxBD0lf0Lq+VtiOYp2g/B6tHol9oducb5g4mmOlC3klqKwJyroiHHPTt/A94rkykm
 b2rZtQma02xb43oeKnORt2F8BUzC3PCXMEt+i+BHlJi1fC2QE27AL/ZZWbpQmDP8XbReNQVnucC
 j3182jAVHYtSkyS9dYH6kJS19jT+IyM7i/dhA+ATmqJErIku83Y8lMsY8dAadW1tKgfL3W8hek/
 9mjFTfgBOGZZue8dszKkhHmtBkJfFX24xnKO7oT0aBkrJwgCO0PnRVGAEp289s+BxNTW2xM6iOL
 xrhAWttXt9apnJI/R+Q==
X-Proofpoint-GUID: XEU22qUlk0xnRzR1LvR_0VgiU2cBmChh
X-Proofpoint-ORIG-GUID: XEU22qUlk0xnRzR1LvR_0VgiU2cBmChh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129
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

On 20-08-2026 19:01, Krzysztof Kozlowski wrote:
> On 20/08/2026 12:07, Dmitry Baryshkov wrote:
>> On Thu, Aug 20, 2026 at 11:07:45AM +0200, Krzysztof Kozlowski wrote:
>>>>>>>
>>>>>>> Device node with this compatible is already populated, so this looks
>>>>>>> simply wrong or you are adding a duplicated driver.
>>>>>>>
>>>>>>> That's a no-go, you are supposed to work with existing drivers and grow
>>>>>>> them.
>>>>>> I'll bring the discussion again here, there was a discussion to move the
>>>>>> driver to accel subsystem if we want to support new features/uAPI
>>>>>> changes. Please read [1],[2] threads. The intention is to replace
>>>>>> fastrpc driver with QDA eventually.
>>>>>
>>>>> None of them address the problem. You want to grow fastrpc into user of
>>>>> dmabuf? So you move it from misc to here.
>>>>
>>>> It's not as easy and nice, so I think in this case it's better to repeat
>>>
>>> I disagree. The existing fastrpc driver is not that complicated. It's
>>> actually moderate amount of code, much less than Venus was (~7 times less).
>>>
>>> It easily can grow to support two interfaces and the only difficulty is
>>> how to manage these two interfaces simultaneously or exclusively, e.g.
>>> opening first one disables the second.
>>
>> I see the point here.
>>
>> Would it be acceptable if we add QDA support only on the new platforms
>> (e.g. via the SoC-specific compat), provide QDA for those platforms,
>> and, once it reaches complete API and feature parity, we remove the old
>> fastrpc driver, migrati old platforms.
> 
> The problem with this approach is that we have no guarantees that it
> will reach feature parity in respect of old interface, thus old driver
> might stay forever. If we agree for duplicated driver, contributors have
> no incentives to support old approach.
That's a fair concern. Let me lay out the sequence we have in mind and
then the concrete reasons parity is not optional for us.

The plan is staged. QDA is enabled first on new platforms, where there
is no existing userspace to migrate and the new UAPI can be exercised
properly. In parallel we close the remaining feature gaps against
fastrpc. Once parity is reached we migrate the older platforms onto QDA
and remove drivers/misc/fastrpc.c. The end state is one driver, not two.

On why parity will actually happen: the DSP firmware is not changing.
Both drivers implement the same base protocol against the same firmware
image, so the feature set is defined by that firmware interface, not by
what we feel like implementing. For QDA to support a feature at all it
has to implement the same protocol operations fastrpc already does.
Parity is a property of the interface rather than of contributor enthusiasm.

Other than the base protocol, there are some features(daemons,
capability, session sharing) that exist in fastrpc for performance etc.
but are not yet part of QDA. We want to implement them properly rather
than port them across as they stand.

The remaining question is how fastrpc can actually be removed once
parity exists, without breaking existing userspace. That needs a
compatibility path, and it is a deliverable we are committed to rather
than an afterthought. For that, we need to settle is whether that path
is a userspace shim in the library, an in-kernel translation layer
exposing the legacy device nodes, or a hybrid. We evaluated an in-kernel
shim during v1 and hit constraints around constructing per-client
drm_file contexts from outside the DRM core, so the approach is still
open. I'll come back with a concrete proposal, and it will land before
fastrpc is removed rather than after.

> 
> Much better is to refine the old driver, gradually adding new features
> while maintaining old stuff. This is the only way we can force
> contributors to actively work on minimizing duplicate parts.
> 
I believe you are suggesting we bring the new features we are developing
with DRM core utilities into the fastrpc driver. I don't think the two
interfaces can share one driver, though, and it isn't a question of code
size.

fastrpc is a miscdevice: it accepts raw DMA-BUF fds as arguments and
tracks buffers in its own per-file lists, with the fd itself being the
buffer identity visible to the DSP. QDA is a drm_driver whose buffers
are GEM objects in a per-drm_file handle namespace, with PRIME used for
import and the GEM handle being the identity. These are two different
buffer ownership models, and neither can be expressed on the other's
file type.

Supporting both from one driver therefore means carrying both models
simultaneously: two IOCTL surfaces, two buffer lifetimes, two teardown
paths, and a memory manager that has to serve both. That is two drivers
sharing a directory rather than one driver with two interfaces, and I
think it would be harder to review, and harder to eventually untangle,
than a separate driver with a stated removal plan.

There is also a positive reason for being in the accel subsystem rather
than misc. We can build on existing DRM infrastructure instead of
reimplementing it: GEM for buffer management, the device and file
lifecycle, and the debug infrastructure. It also positions us for work
we have planned around scheduling, drm_gpuvm, etc. Over time this should
mean less driver-specific code, not more.

I'll restructure the cover letter so the staged rollout, the
compatibility path and the eventual removal of drivers/misc/fastrpc.c
are stated properly.

If after this you still want to add or change anything, please let me know.

Thanks,
Ekansh> Best regards,
> Krzysztof

