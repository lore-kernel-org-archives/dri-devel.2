Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E38C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB73410E00E;
	Sun, 27 Sep 2026 17:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WLyDTyic";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dgbUZ0qi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9B210E00E
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 17:13:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RGX2oh1329820
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 17:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VB3Pq/tX2cY81/H0fpS3ys8Gxm8NGlgIcdjzVRBuiEo=; b=WLyDTyic/e7d1S4p
 teiHEFWbEdelZHTmpBvFNeUM2WcWX/PTsRbb2mnkeZIK7ZoTrQsZpKlsgFgv+UC/
 Cm96VL7uCQBY6kB8mLSZTX4zvkZc1fDeaFjz7nJk2+fTc17BJXwIhWvzw5yB8e8W
 oE4lVcHINm0zKqYfwCMfZ+sV44fee6lEhp5cZ44BQWGyFDLG+V3jIUPyIPEOcTJm
 WcT+vSJc50LM1feCWNsbcUwWHY3fQVL8JL9K9uy48b0A8UuWIiB9HE0ifkK4fLF9
 AUZEs79GB4USOOc6mhHsrcJ6BBna7MHdavdGrNc8yZ9TnK4iLJUGE/B9h8yjgvmE
 vC886g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50sbhgj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 17:13:56 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7a8e3cc28e6so1961988137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 10:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790529230; cv=none;
 d=google.com; s=arc-20260327;
 b=Wv1vShpmf+iny8Gmp9oMFIZ5rXm9f6uerzzCVK5GsRp5ZxqHclZYm38u3IBu7p/d8v
 00uRZYpCSmGm8d78UYA75++Dyk/0QF56pH8IwgPn/gZ2iZnMWKIAwYa/nl11KKX6KRPf
 5DeMkeUUK1GZaUD+xcG/xJbE/ux2Pchu+QaI7CyIJCajIXzU5kZr+PYUMt6i6KOGnZyr
 Y0n6fF0ld7uLXgwcUbzsPIMUZ2NFcSM5IS08d4tL9Inlczmo32dRBpWMRYgBi+SvQ1+e
 FxpTgvJLHg6uYF4ZATBKARpmKlWbKDaLAHwkQ36N9QjsRK0W1MrB4+FmBn+qls4FWtuu
 xY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VB3Pq/tX2cY81/H0fpS3ys8Gxm8NGlgIcdjzVRBuiEo=;
 fh=TbfvOaVhdVxQSLIH9OZpVpg4epGMn2hzKicvfGqq6rE=;
 b=lw8QA902Bq/yZhHrV4LEibUbhD3xUTIjidcmRmURdpNfo2djLPFmB5+5A8RvVsuwOJ
 zb36labfx+gpSem+zZFN3b0UyOQb5DwAWDu5jhNw7jamtEB9vqFfebSwWguiooSXVbpH
 Od2JNSafS3tjiAXlkwIdwPb6HxPO4CPEugqXgeZk/K74NRhzY1KdIN97/p2m6fAJ+S1v
 OHm8PMpB6R1pXbIAUpyZq/mxAXyKXK+8OYrHgGwqYSTSL435x6b/4S16C0/tK7jWiuBP
 bPh9YB4Ofs5hGW/41bgStoz5DI1yMm66cQA7F6B7n/7pVwLMlLiLjqth8Ulx2DO0iGPg
 q8lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790529230; x=1791134030;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VB3Pq/tX2cY81/H0fpS3ys8Gxm8NGlgIcdjzVRBuiEo=;
 b=dgbUZ0qio1OOHkfJRZ+rGJInGrdJjD5CnfCcJzlibT6pYCdwn3ss3kXrySlajppTUg
 dvvRREy63yueW8mnJIxO4Oon2UVog7LRCAaBEA34PmTuagohFcNcSIlRxSm1MDhDB1Ly
 J6DEOHdriUOOKjaAGN25AcXYcwZNl74KGyTlBMiX1FmKitPhB1tkcFjsJEBh6LQQYZOp
 nUU3BnMokvToVcyrRXmo2aUCNoGnn5zfp0OKkGfDbW8rzbzfuGQWaFKOBdczYXM6pAtz
 ryT7ER1NxcPI6kx6+s1Eqq8KMA0k5XHlyczPmn5ymIL5nptVNIYk77QtdiYLWZ4Qdf9x
 2R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790529230; x=1791134030;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VB3Pq/tX2cY81/H0fpS3ys8Gxm8NGlgIcdjzVRBuiEo=;
 b=SQPcmau/EwsXt4gCcqnJQowXfyoWRUvOsvbtdjqcNHsUv5WGmaNsF9oZu3mB4z9TwX
 LAhkJbNGmIQBB2U2PUrfwwZpgG0EPUH8XWY2rO0ls3Ton82uUnJfaNxy4EpvK9P1syBn
 JApaNGrafcbT1LWLdBlFx2q2e0+fEunMKGHmuBfqx8ENTyxzaZigHckjNIQ0Bqj438jz
 mEzC/UwIFZ1WKLw2OeHS0MDWcfOPW/DhpdYNeOyaMnQxKSXGm/ZPQIqND8vO5jP690ZN
 EZdGhBDF/zAvx2f6w455nLLd4gwlPrenCcedO7u33/YXNsYzki7HCa9HL2KT/brh34ZL
 wf0A==
X-Gm-Message-State: AFq9FYIyqvr9HI+hGXXaFC7JPFOqjitPJxjgVSKxamJbwgw+I07utOfb
 DyM8wizvqjc/4HCtmLbdgcHKJawyOGMZFBpwNS16150jTRiZNa+8XxFvCbhsFJIU5Dk+S3dTNGe
 Fa4TWBmpyh4zWARSe1llrBpdDpKnRziZHgJ/NJPpTZAPynbbYJWp9IFHc5fb5uA+0oD1BXAVrdW
 Q8lkDSr18r2Dc01UTYuZe/8el+bVofRHNSTf71skt4NJgZ1Q==
X-Gm-Gg: AYBFou1Gz/aYEVpK52gJtB4rmZ5LDSqWXJja1vdGseu0aEj+b/sd3W/3x5lTLfdiZFK
 qK+YNMo/ZdRptpIsHXozyoHAioTQy+QgsFFdYgchbB7G0fLcnNoBvCpYNrkrBR7hqDXN6dUF60f
 KrQ5FhoR5HEoWe+i7oL1M2dj+XbjMBf49/J+TR8ZNsvScNuQLm9yZ/iLjhS0U=
X-Received: by 2002:a05:6102:3f47:b0:798:24e8:23f4 with SMTP id
 ada2fe7eead31-7af1cfa46e2mr3316288137.7.1790529230260; 
 Sun, 27 Sep 2026 10:13:50 -0700 (PDT)
X-Received: by 2002:a05:6102:3f47:b0:798:24e8:23f4 with SMTP id
 ada2fe7eead31-7af1cfa46e2mr3316275137.7.1790529229806; Sun, 27 Sep 2026
 10:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260806051915.2234481-1-pravinku@quicinc.com>
 <CAPd7Qn3QYyrzBFFjB4+M9Je7uykYgxHiM+vh-mNVJ16QaoPkJA@mail.gmail.com>
 <2140e7f2-d329-4726-b593-72e935fca4f4@amd.com>
In-Reply-To: <2140e7f2-d329-4726-b593-72e935fca4f4@amd.com>
From: Pravin Kumar Ravi <pravin.ravi@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 10:13:37 -0700
X-Gm-Features: AclHuK8PwoThA0mV-kKOw3eDm5hmBFXr8MOx4tYGbb0EL6wStiYs_DNf1J_IlbI
Message-ID: <CAPd7Qn3ecF7+TBp4xDUoukVaDCjLjcDjVg+BndhqPN89i=4dUQ@mail.gmail.com>
Subject: Re: [RFC] Synx: A global synchronization framework
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-accel@vger.kernel.org, sumit.semwal@linaro.org,
 andersson@kernel.org, mathieu.poirier@linaro.org,
 konrad.dybcio@oss.qualcomm.com, faith@gfxstrand.net, simona@ffwll.ch,
 simona.vetter@ffwll.ch, airlied@gmail.com, matthew.brost@intel.com,
 srinivasan.shanmugam@amd.com, rob.clark@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2OCBTYWx0ZWRfX2WkB0gyXV1WK
 UiCD3dstPV4n4EIrtyn2L97riwVMIFiFNl1P0EyEUeqbmz95+ZOG1ueOEIp6neugvF1rzvPAgMI
 Afr2KDkD+FfPH1SdgPJcOAGWMCnaT4w=
X-Proofpoint-ORIG-GUID: ggucdUvXqsab7GOKmkmYxHNjQ3Nof932
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab94ed4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=X73fn1zfpKsA7NX-Z3gA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2OCBTYWx0ZWRfX+CO1d67xp0xo
 z6fld5vesdMqakI5wfijpQ+ZNXnNe3KBRoUUJESMEFcge1MYLvKYORGRL46MUdZ1jHVBYRZS133
 Iys9R+zCUbViTGXqa4L/vWLJvfoLnW3cxu+2DHC27PijnkatshAjEDKUJr4iSbzuTrhZ2b5ODkD
 b6tvnY0h1c69YuwPBrImy4TWKIctiv0I+TMfEa0uT/JlOWHqZqNh+/QF6ap1AgUmwW4vH3+Vc+h
 CeldfjLXwzIe8LKPIIF3jrp5NT3LhViXQLF+7lqXrdfjvEj8osdIdYfoqJlzi8I0vlUlSERJtXq
 mv7aex8K/3DG2f2TKz+iAZIXNb5EHxhKc1M4WvRWC84LqvpBRlIcd3ScK/oOR27/RXUw9KLoX0y
 ZL9Ingux0mkc1IqA8NukJc1tRr1nGdNuESTVZ+6BD+fmOX6h6e+8y8lMDfR1NuznFfuRiw+4qwN
 WHlEck5VKESKds1kQDw==
X-Proofpoint-GUID: ggucdUvXqsab7GOKmkmYxHNjQ3Nof932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270068
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

On Tue, Aug 25, 2026 at 5:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi Ravi,
>
> Essentially you can have two different modes of operation:
>
> 1. Preallocate resources on work submission to the HW. This is what the d=
ma_fence framework implements.
>
> The restriction here is that you don't have any dependency to userspace o=
r other device drivers, e.g. no page faulting, waiting for memory values et=
c...
>
> Background is that the core memory management depends so hard on the exec=
ution properties of the dma_fence that none of those advanced features are =
possible without breaking core assumptions.
>
> Inter device operation is only allowed if the device drivers "know" about=
 each other, for example between rendering and displaying pipelines.
>
> But we have intentionally rejected any approach of generalizing device to=
 device signaling in a framework because it makes dma_fence practically a r=
ecipe for trouble and we have more than enough evidence to confirm this now=
.
>
>
> 2. On demand resource allocation using PCIe functionalities like IOMMUv2/=
ATC/ATS/PRI or device specific page fault handling.
>
> The point is that you can do things like generating commands on the fly, =
long running jobs, device to device signaling etc...
>
> The only restriction is that you can't create a dma_fence with this as ou=
tput, you can only consume them as input to the operation.
>
> There was also an absolutely great presentation on the topic from Faith o=
n LPC a few years ago.
>
> Regards,
> Christian.
>

Christian and I discussed offline whether a fixed, kernel-controlled
pipeline could support this safely. The contracts and enforcement remain
open, and input from others working on these use cases would be welcome.

Mode 1 (preallocated): The kernel must guarantee completion or safe
termination so resources can be reclaimed when subsystems stop making
progress. Arbitrary cross-device dependencies can break that guarantee.
We discussed restricting the allowed pipelines as one possible approach,
but still need to figure out how to enforce the dependencies and recover
resources when a stage hangs.

Mode 2 (on-demand): Standalone signaling is fine but very few accelerators
fall under this category.


(Bringing Rob's September 27 reply from the parallel thread
CACSVV00oBPN=3Drw1yVBjNm2TMHuQ+3iv84jKP4djQcnKRxcvWCQ@mail.gmail.com/)
Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> So I'm just starting to think a bit about this, since it will be
> potentially relevant when we implement fwsched for adreno..
>
> Do we really need anything more than some sort of dma_fence signaling
> extension?  Ie. signaling on the CPU remains exactly the same as
> today, anything waiting on the CPU would see no change.  But if both
> exporter and importer support the same extension, that can be used to
> extract extra information to pass to fw.
>
> The fw might observe the fence getting signaled with lower latency,
> but that's fine, there isn't really any guarantee (other than timeline
> ordering) about the order that multiple waiters observe that the fence
> is signaled.  We've just pushed one of the waiters down to firmware,
> that is all.  Ie. something like
>
>    rcu_read_lock();
>    if (fence->ops->signaling_ext &&
> do_I_understand_this(fence->ops->signaling_ext)) {
>       fence->ops->get_magic_signaling_foo(fence, &magic);
>       ... pass magic to fw ...
>    } else {
>       ... same as before ...
>    }
>    rcu_read_unlock();
>
> If either the importer or exporter don't understand the same signaling
> extension, everything works as before.  For ex, external eGPU/dGPU
> sharing with say the on-chip ISP.  But if both do support it, the
> signaling extension provides a way to extract whatever magic thing is
> needed to do the wait in fw.
>
> BR,
> -R
>

Hi Rob,
For operations that already satisfy the dma_fence completion contract,
this looks worth exploring.

Christian, does this fit the case you described about known drivers,
provided the participating drivers preserve the resource-lifetime
and recovery guarantees?

Rob, could we have the shared signaling mechanism in an independent
and generic synx_global.c layer? dma-fence can tap into this
layer for the signaling extension you mentioned.

The reason for keeping this layer independent is that we have clients
who use reusable synx objects (signal same handle multiple times)
which don't interop with dma-fence. And we continue to get more feature
requirements from performance-critical clients around reusable objects
with timelines. Assuming this is where global synchronization is headed,
these clients should be able to tap into reusability via a route other than
dma-fence.

For existing dma-fence operations, your extension could expose the
information firmware needs for its wait, preserving CPU signaling
and the fallback you described. Other clients could use the synx
global layer under a separately defined resource-management contract.
Would such layering address your use case while also supporting
clients that need reusable remote synchronization?

Thanks,
Pravin
