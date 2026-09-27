Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C193C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F4E10E583;
	Sun, 27 Sep 2026 12:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K3XiDiAZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bqwJWztu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE5310E583
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:00:05 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QN0lLY3890290
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=rgW7SfWM+V9aC8/kbQ44Ln2IemFbLeuqMDrQH3Z8rLU=; b=K3
 XiDiAZQ9z3uIgtgbq60/938qY2qw9XW9HY15f5k+AaKdG178G6XTAbfxTp/knxsa
 /smkv8ipppbcrYbot/ty9hctKieF6GOuoAHytGUwEHdxBVgJj2kRccpXxnH4is18
 y6cPEsQz+DjCOVqiyQ4BApdcL9Qz0yEkjUGaUg6ZO3CAZ8w/7UyqMYLz6w9P4YfT
 Q01fFE9lPmUxxxHEXhC+4640Z8gay3HAm9a9Hvutxe1R7w3DxG2WvtAuPcRXfLOk
 PJWji9xkSzL2fS4VbCZIDlKa9E61z1PwXHVWvkmC98lpNVOlObrFnTXDbrrYIOQh
 ZeDK6sZ0UgfpnmFsDakQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jtrm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:00:04 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6d96256b185so21724eaf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 05:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790510403; cv=none;
 d=google.com; s=arc-20260327;
 b=NMxnfC/10SPbEQZ8f6aGZjKXPMByIMVg31tP2xi5TM5zJTx1cbyAiNh4CH/UpwJoWo
 ODx4XNQ1Vjp61n0/x2TucN1ERiU0W7WDxE9mKUyway/fWSa1y3hqwxjsHjEOpFK2Oydy
 1k5fb4j8AeuRvj2nmpyxB7y6UjW3wyLWV9nN1u18V1VAZ9O0CWJMqaW8Zv6Uoub/e3Ei
 MZfRgP9BZ+AehdRdrewXKfTyinzYrvUBlydbinHYNq5ssKPxVCkp0ALg28zPOGidQXp8
 AETb1el6eVt2D7vCkPIjtvB4zJcGIjJDDRobjFV7y63fyvdZuAZBO89ZPf2n4XXMuIxZ
 DmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=rgW7SfWM+V9aC8/kbQ44Ln2IemFbLeuqMDrQH3Z8rLU=;
 fh=h2z5Pwjy+5UgeQnKH1dCyzGQnCutfJVaZ76NIejo77M=;
 b=MrxOKH8PDUKJwmKR+wgMZpgbFlHejMxUjJw02p5ogzhNzoXnkNyWw/mLjFtVik2geo
 nEp//bZXs8876qchIMXoRPSQYZ6lov3B5srppi22dkRW/hqeOWd7wQWtwSU3cNyXy9PI
 GeZtzw1cQ7mKYm+Wxsk0rQoe6eZx/xh6XavyFncyycXXfHwu5n9EZtRArds2KaQyL5cm
 QAUT4f5gt+lep9cQ53gXYtmJQnOCSrnlPdw0uLPvh640rhGpbtQ38bSYeGBBCmAf2xsz
 3OKPDGYAOFLOPEhmubZb1OTymqpm727dLbcV4UwQAovO0GuNWRszfZnIVRNnVupq/fT4
 eleA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790510403; x=1791115203;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rgW7SfWM+V9aC8/kbQ44Ln2IemFbLeuqMDrQH3Z8rLU=;
 b=bqwJWztuSmiSyL2fXzxm8kExpQgR9OMmM5p1JJQvmcAJblPMXdFoaT4TW8nsEpymJt
 Ro4belVU1iUMGSfDh6DKEQQ2kupxL/GN1rXBQsn5tSgM3Izb3kREQjXhT+g1s21qSvGv
 G3QwYm8dIb5CxSP5kAmprJXY8Ie4yO0etMS3VGfqIGaI5hUh7tNpf7qc76y+4aHDfNTW
 0VTrmo3y0kiENBY8FQe6j1bU03/Xn+ql1dM72AcXojLE3GsaodSzMq1bD2hkF2mEmP5t
 GgemXb1YS2cLKlu6alKAwOygObR+UYdmW6Ed2Yfjt7iB/nEJ6RzX2/MALO3q1XsmlZeX
 F3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790510403; x=1791115203;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgW7SfWM+V9aC8/kbQ44Ln2IemFbLeuqMDrQH3Z8rLU=;
 b=H16ANyY0jJK/JKvyEAAJuQ8kgvGTKAj0YZrX5hfPV/9oFjdzCIlCG1BGwZpU67j0Tf
 yiFK+3994dg3rUhR7RGA4LgxPCIQyet2b+5ATQpuFlc8gBGRr75ypVJfJyFkqF3RWUIW
 p9h7caCcQ1AzgDuBAf34gZ0romYdOOa0bTMZZcJzddlLeHZjpjKdHNYxbmoHdpnTGd2o
 UvYSbIgxJy8dmoxskHdk/YWkir37JX2z4HvYFvE5dDrda30HLJGpO+cEMWvcQfzDDeh+
 ZyYA0uXI+U8DC2rRgwGPw1R3fnudU86OG28Ed6vV87NeQK9gY85Q9hXnqNRaPlyIrByl
 DijQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBweiKl9wlDi1f+EQ2qHSSMW6A4m2Bh2pvrDc5ztJZOmejeIy4L9WJ8t9SUN50qJY3NuU/X0DrE2/+c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kO3g8R3XOqeXWQoU2p+bmzPV9udQgCka3P5xfFw0cqa8fDZBoT
 8qQwEBGUQy3mEUOwWeF/oPZN7gMj/0jq+K0R9gb6jnEPOw4nippICs18AejSoCojObBIe9PKbh8
 GDu6psaTkDryGC5iM1NWQl3G+1rT4SiNhI4uwIfUXFZiZl7mW7rjBkEdrDIPJIDeexHvD8sKBeP
 xSvS41pgX8e1wZ12gT3fq11XFWaQIvBos0452C6ZWgKx16Ug==
X-Gm-Gg: AYBFou1O2lzV1XKk6Ij4ScdjEz83X/3WwmihcRcb/1kdVDZzSfs5kHT6C243YMyoyXb
 6hSBPhX8JH8XAsr8h7zAIi6Ut1bry2z4DZlMEpJWxn1crIXbFGQ8hXQhfPbllX+mFiBAtfQn4qW
 5rLBo2CeVuUKfNKS4C8lZGeJs1rXCcOEPp5F7MpMDfIg9G1T8BDZPxuh4a
X-Received: by 2002:a05:6820:1515:b0:6cd:3fdc:6007 with SMTP id
 006d021491bc7-6d441c7b872mr9885811eaf.88.1790510403194; 
 Sun, 27 Sep 2026 05:00:03 -0700 (PDT)
X-Received: by 2002:a05:6820:1515:b0:6cd:3fdc:6007 with SMTP id
 006d021491bc7-6d441c7b872mr9885784eaf.88.1790510402601; Sun, 27 Sep 2026
 05:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR02MB6866E35A2B4241CF3A728A99D3D22@BY5PR02MB6866.namprd02.prod.outlook.com>
 <5f90bb35-994e-48bd-bf49-3001dcefa2ee@amd.com>
In-Reply-To: <5f90bb35-994e-48bd-bf49-3001dcefa2ee@amd.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 04:59:51 -0700
X-Gm-Features: AclHuK8rcs-qn2ZpLt0jVNsqHetW2nhbpradp0Cqnes4b71suV9Y7FFS9Jo-lt8
Message-ID: <CACSVV00oBPN=rw1yVBjNm2TMHuQ+3iv84jKP4djQcnKRxcvWCQ@mail.gmail.com>
Subject: Re: Synx : global synchronization framework
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Pravin Kumar Ravi <pravinku@quicinc.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Faith Ekstrand <faith@gfxstrand.net>, Simona Vetter <simona@ffwll.ch>,
 "linux-accel@vger.kernel.org" <linux-accel@vger.kernel.org>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "andersson@kernel.org" <andersson@kernel.org>,
 "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
 "konrad.dybcio@oss.qualcomm.com" <konrad.dybcio@oss.qualcomm.com>,
 Rajesh Sastrula <vrajesh@qti.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA0NyBTYWx0ZWRfX0fm0H0SOA06H
 dg4e7J+i4xDvQxPbsi0DtCjxqnkEZIb3F0EjqGYUmVFiiVFZ4sXNmmPvHkIRXmDRghI6oSz4rKg
 SvCcQ94r2rZPpc4Dbro1uc2/mI9JAPk=
X-Proofpoint-GUID: aIKFQuw1hktMeXPZXfYSVsO6Syf1NCOM
X-Proofpoint-ORIG-GUID: aIKFQuw1hktMeXPZXfYSVsO6Syf1NCOM
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab90544 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=zd2uoN0lAAAA:8 a=pYcsTS5lAcjY3ai0WdIA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA0NyBTYWx0ZWRfXwgO9PxnpOesP
 tjH5aZdnlupR/p8fOi4ZXEhFWTwNfImalKMW+7d1b0GP8dS+uv5E/1rl4T3wZKRVwzfSB4mt4id
 nAgw//vgm+NRpSSh7cqwSu/aBj6xaFQHgzITVbP382C3Ykxt7FqD0PFzprJ+6cHrThXY9jjhvSV
 Ufcoc1Cu8Ccx3gq3GCqqjn3ipWp5lGa3ZZhPJTurTD72h1Xh3W4oQg3wV5CRI3OhQJazxUR8Nyb
 OdcffGI/SBM2M8uxfqH+jrUFv0FGNXVApexlJ0luJz9AG63VPUP8BbITFc/FB4FnYIiCJ8PzJnO
 Epq4ftLZxB6qwRuqyWOkyOmll/LMq/gtVbu7Q0n3KxqFrQHLq5zyERJ08azKvee9ocS49He8hOj
 Ka3m5XPKCs3ThJJRisXwutwVtVYuWQRUK+aSSDcbQFSRSh524MqCVXosudZZkgaei0zh4f7bDo/
 6oXBC319KqzPZubcHUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270047
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Aug 6, 2026 at 4:52=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Oh, well history repeats itself.
>
> On 8/6/26 06:30, Pravin Kumar Ravi wrote:
> > Hi all,
> > This RFC is intended to start a design discussion around Synx, a SoC-wi=
de synchronization framework used to coordinate fences between Linux-hosted=
 clients and non-Linux execution environments such as remote processors and=
 firmware.
> >
> > The intent of Synx is not to replace dma-fence for existing in-kernel G=
PU/display style synchronization. Rather, provide a global synchronization =
mechanism spanning multiple subsystems and processors, while still integrat=
ing with existing Linux primitives such as dma-fence and sync_file where ap=
propriate. The solution has shown significant power and performance benefit=
s in the last few generations of Qualcomm mobile and XR chipsets, and is ga=
thering more use cases. Also, the solution is SoC-agnostic, so other vendor=
s can adopt it in the future if interested.
> >
> >
> > *Motivation*
> > Many multimedia and accelerator pipelines on modern SoCs are no longer =
strictly host-centric. Work may be produced, consumed, waited on, or signal=
ed by multiple execution environments, including Linux drivers, userspace c=
omponents, DSPs, ISPs, NPUs, video firmware, camera firmware, or other remo=
te processors.
> >
> > dma-fence is a good fit when the fence state, callback list, and lifeti=
me are owned and progressed by Linux kernel participants. However, for cros=
s-processor use cases, a synchronization object must satisfy properties tha=
t dma-fence does not currently provide:
> >
> >  1.
> >     *Cross-subsystem visibility*: A fence created by one subsystem must=
 be importable, waitable, and signalable by other subsystems, including non=
-Linux processors. struct dma_fence is local Linux kernel state and is not =
directly visible to remote processors or firmware.
> >
> >
> >  2.
> >     *Point-to-point remote signaling*: One subsystem should be able to =
signal another subsystem without interrupting the Linux host CPU every time=
 in the signaling path. Since dma-fence maintains all waiters in the Linux,=
 remote-to-remote synchronization has to unnecessarily interrupt or involve=
 the Linux host.
> >
> >
> >  3.
> >     *Distributed lifetime management*: References may be held by Linux =
and non-Linux participants. Any subsystem must have authority to create and=
 clean up fences. This requires lifetime state to be tracked in a shared/gl=
obal table, rather than being owned solely by a local Linux object. dma-fen=
ce lifetime is centered around Linux references, which does not naturally m=
odel references held and released independently by remote processors.
> >
> >
> >  4.
> >     *Race-free global synchronization*: Registering a waiter and observ=
ing signal state must be atomic across participating subsystems to avoid mi=
ssed wakeups/signals. Atomicity between remote waiter registration and remo=
te signaling needs a protocol-level guarantee, not just local callback hand=
ling.
> >
> >
> >  5.
> >     *Subsystem restart recovery*: If a remote processor or firmware sub=
system restarts, references held by the crashed subsystem must be released,=
 and waiters that depend on that subsystem must be completed or failed in a=
 well-defined way. Subsystem restart cleanup is outside the dma-fence model=
.
> >
> >
> >  6.
> >     *Global composition*: It should be possible to compose fences that =
were created by different subsystems or processors into a single aggregate =
synchronization object. dma_fence_array can compose Linux dma_fence objects=
, but it does not by itself solve the composition of globally visible synch=
ronization handles created by different processors.
> >
> >
> >  7.
> >     *Transport abstraction*: Remote signaling should be independent of =
the underlying transport, for example rpmsg, mailbox, GLink or another SoC =
transport.
> >
> >
> >  8.
> >     *Linux integration*: Linux clients should be able to interoperate w=
ith dma-fence and sync_file where that is the right ABI or in-kernel interf=
ace.
> >
> >
> >
> > *Proposed model*
> > Synx introduces a globally unique synchronization handle. The handle in=
dexes an entry in a global synchronization table that is accessible to all =
participating subsystems. Each entry tracks: a global handle ID, current fe=
nce state, the set of waiting and subscribed cores or subsystems to allow p=
oint-to-point remote signaling, a distributed reference count, and parent/c=
hild relationships for composed fences.
> >
> > The design is organized around four components:
> >
> >  1.
> >     *Handle and session management*: Any subsystem, Linux or remote, ma=
y create or import a Synx handle and hold a reference counted against the g=
lobal table. Handles are destroyed by the subsystem which releases the last=
 reference, regardless of which subsystem it is.
> >
> >
> >  2.
> >     *Transport abstraction*: Remote wait and signal messages are delive=
red through a pluggable transport layer. The synchronization core is not ti=
ed to any specific backend (rpmsg, mailbox, GLink, etc.), enabling point-to=
-point remote signaling without involving the Linux host CPU when both prod=
ucer and consumer are outside Linux.
> >
> >
> >  3.
> >     *Linux interoperability*: A Synx handle may be associated with a dm=
a_fence or exported as a sync_file, allowing Linux kernel drivers and users=
pace to interact with Synx objects through existing interfaces.
> >
> >
> >  4.
> >     *Fence composition*: Aggregate fences are modeled as parent/child r=
elationships between global handles. A composed fence can span handles crea=
ted by different subsystems or processors, and its completion state is deri=
ved from the states of its children in the global table.
> >
> >
> >  5.
> >     *Subsystem restart recovery*: When a remote processor restarts, the=
 global table is walked to drop all references held by that subsystem and t=
o complete or fail any affected waiters according to the configured recover=
y policy.
> >
> >
> >
> > *Possible initial patch structure*
> > If the overall direction is acceptable, an initial RFC series could be =
split as follows:
> >
> >   *
> >     Documentation describing the cross-subsystem synchronization proble=
m and the Synx object model.
> >   *
> >     Code to manage Synx sessions and handle lifetime. And synchronizati=
on using wait and signal
> >   *
> >     dma_fence and sync_file interoperability layer.
> >   *
> >     Fence composition support.
> >   *
> >     Transport abstraction for remote wait/signal messages.
> >   *
> >     SSR/restart cleanup hooks for remote processors.
> >   *
> >     A minimal Qualcomm SoC integration backend and example client.
> >
> >
> > At this stage, feedback on the model and layering would be more useful =
than detailed code review. In particular, we would appreciate guidance on w=
hether this should be pursued as a Qualcomm SoC-specific driver first, or w=
hether the cross-processor synchronization pieces are generic enough to jus=
tify a common framework.
>
> Well to make a longer story short what you describe here was the original=
 dma_fence proposal from >10 years ago. We fortunately rejected it already =
back then.
>
> By now I think most people in the Linux community who have worked on dma_=
fences agree that stuff like that is an extremely bad idea.
>
> First of all some of the stuff you suggest here go strictly against docum=
ented dma_fence restrictions, especially no point to point remote signaling=
! dma_fences have a huge interaction with Linux core memory management whic=
h makes stuff like that impossible.
>
>
> What you can do is to do this in userspace with DMA-buf and user space fe=
nces, signaling points etc... Take a look at how user space waits in XE wor=
k, how eventfd works and ROCm events work for an overview and maybe some st=
arting ideas.
>
> We could certainly build a framework around that, especially eventfd soun=
ds like a common ground to most drivers already, but please stay away from =
dma_fences when you want to do something like that.
>

So I'm just starting to think a bit about this, since it will be
potentially relevant when we implement fwsched for adreno..

Do we really need anything more than some sort of dma_fence signaling
extension?  Ie. signaling on the CPU remains exactly the same as
today, anything waiting on the CPU would see no change.  But if both
exporter and importer support the same extension, that can be used to
extract extra information to pass to fw.

The fw might observe the fence getting signaled with lower latency,
but that's fine, there isn't really any guarantee (other than timeline
ordering) about the order that multiple waiters observe that the fence
is signaled.  We've just pushed one of the waiters down to firmware,
that is all.  Ie. something like

   rcu_read_lock();
   if (fence->ops->signaling_ext &&
do_I_understand_this(fence->ops->signaling_ext)) {
      fence->ops->get_magic_signaling_foo(fence, &magic);
      ... pass magic to fw ...
   } else {
      ... same as before ...
   }
   rcu_read_unlock();

If either the importer or exporter don't understand the same signaling
extension, everything works as before.  For ex, external eGPU/dGPU
sharing with say the on-chip ISP.  But if both do support it, the
signaling extension provides a way to extract whatever magic thing is
needed to do the wait in fw.

BR,
-R
