Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B045EC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1014D10F4C2;
	Thu, 10 Sep 2026 14:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvUNUCO2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VMQKyH/f";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13DB10F49C
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:35:17 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AC7XGQ215989
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=SyGRoRxzrS9S8txyYHsaj+mP8c0hLvS0zXlhKlwEOiU=; b=kv
 UNUCO2klR7aLImxRdmF3Z15bCCdCU5EZ044eyqPngnL+uZc2RhgiuUz+oYZSZdZk
 56VBbETrEa6iL7EveTRjlur3uW1cPUR8TpFbH7ux3fULnwgdH73Eq66jGz3uedIH
 S1eDkBNwgvZwelMdRg0X4ppMObzYbdzHa2mwMkXbwBHnwKeIPrdPCU01MpdUXHst
 Ln7z+MenafPgon1Jf/YeZUwTfBGQiw9QBJyW9zcPPwm5ciwljTxyDM52S/YgctM0
 CJI6nyL6EDCtDa0jFBe4jaLWzRO7reSWTqPHMDPiMLA2eyOaXleFZqmYKKhlvMeY
 erm7mCpzN+ly0WgiLwpw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrdn9n6x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:35:16 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4959c49e054so5116881b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789050916; cv=none;
 d=google.com; s=arc-20260327;
 b=emU1d5zXz3Yt+xcLVXPy31bgXVgibD0zjXz7dz7h98TqY3scsun5z9LZVQLWRVkszh
 uYt+t5ymk33rFAEJmf9gmV1hl4UOL+EsDWri7rem1wkjjaVConcOZNghd1zRjOzskHuU
 arkE3mF8/FS9nnOOeEfKnOwHMli5W+LazggpMknlO76TtyWsCrvCc1ykE+/cJRNfQD9b
 OLta7GhKCfxXVoOcYi+Gh2l8kg1YkQuEp5/oEFzym3VXua3XhhAaku4J7CnJSC5h1CVw
 zxQJof1iqKvRAI1ZKIDUPEXZk5FRV5bcM3I1aOipQub0Amxa3xYBFywqB1L0Zt16bJEA
 Tajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=SyGRoRxzrS9S8txyYHsaj+mP8c0hLvS0zXlhKlwEOiU=;
 fh=RW/2axyPWY7e5KXFI3/BUi8nRK7yX8XMlZr2c/LY2uA=;
 b=Dm7Eb38tIXfx0PbO+pNgPFQYPQoqDNDaKvwhbNdAr4ri8XOWK/Py4IsIIhlWGXBKHT
 +zVMb3sP2iT64F7z7BEQVCjNSlF4XQn0qEFW0Ldf1xuTqwHi8fg4kvVLOal622MbACdo
 AoCzJeR65ZYBbF/kYNM3yh9Q25V/Fqe7Pa95IMuJHpyGCp80dJwYNn2lRPnLtvu3Pxbg
 MHF1/i64S089SOWLXs0OQ+wzTGZCnNH9RTAGbEXX/Crt4f5lm8ZwXVszlgOQZO8aFweS
 oDMYWbQ4M6KDbDo1i0/kvgKDEKizV5LhY4CjEipsPmONKVhL+ZDa5SKQstZLG4MTQngh
 spzQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789050916; x=1789655716;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SyGRoRxzrS9S8txyYHsaj+mP8c0hLvS0zXlhKlwEOiU=;
 b=VMQKyH/fPof4HkxHG6hpqTCIR4BRg8Cl+O/XO8YPPujycuoHOfGmRmXd6eF1ql9sNS
 qMyeoWERLrTJR+b4RgGl6n1mlzfa5XDVfwF4AdZ55KSmUQbUMoN5tuHq0xlg8I86MUQ2
 QAPdZcVMGod7FPvOpIviGIuJG9kL3s1RbZH0JTnzvj11wLZhtPGlsAjFAqhC+Vk49sR/
 a+rgIBEFVtE4xfb1Itk+eEBZ/gsAHknlbg561O10n5dbQTNNIgzu3QxO2DE+Tb2vXzPM
 vXbXzDJ0TmuXnIUGqlgy0KuTVrVi5cNeX9FjGYsIsy1HjyQhI0vfDWlJLueEL7KevgMN
 6diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789050916; x=1789655716;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SyGRoRxzrS9S8txyYHsaj+mP8c0hLvS0zXlhKlwEOiU=;
 b=jE3h3fnTtOqqEWRpec+u7Lge5E5kAGhV6IJ8cY51WtnO4ouXx7Dd3On2ibC9qmkD+x
 555F+vSZa7SXrMCWh0WvALeD17AA+m0tJk9NCLgBHlZGcscVy357YDwDAjkcFV8bPKJV
 Z0j1qWWUlMb4rBa8BLdy931cCe99Ds6v5pcMmy28RLsm9VzoB674duHLjxIe2Aabj0OU
 /PDg27UX0+PvdvzGsF4RBmPVXqdnDj+2rVMZULW9omp05GySaJl8LCgOqml5ztqOhvCX
 V2enV7Dwt7Kx8+PHQDsq6uxvEcDOutmoeNbiEJYx9ZOP2sG3SxUTG2Zu63CUOfrIiMEs
 Umsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhgL/uY6FHSHBS4C4wKph1lMSitl0AmYkVfpvJXhSiuIX12G/IhkuJeuJVo3I9iregaTCgkyl0rog=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nETWyJuN1uLwmJBlH+2jrI2ux8OLVQTv9XZgFcAf6TZWmc+KyK
 hPluOb9+ICRzs5cZtF1NYZ+rN+KyTh6ShXaj34d5WuwLAQq/LJrXnnxWekXIdBAVgMZ86gqnP3Z
 C4RnBOhk95q2hFlvhUopbflB1kAhlYq0voIJ8PTqVLXIX5//YPw/lBSDRD2nt0ZeTr9kgB7t8Ul
 bqtU/uLsdEgiNSn6qWmTxaGM6FBn+jMuowbWK/hWDbtVIDSQ==
X-Gm-Gg: AYBFou3FTfnCwlAllu1DelNgArml7tpTc8sbjatQb6afuY62hxqebdNjZ2jbPpjsFyQ
 wAlMC3Eux+TAZL+liwdeVwEpzCiTwbRh25/b+/JNUNqp7yvniOE+teHlViqp6FKj2dYWoMDfA59
 LtYfexbL3W9KgchAhFzDFk3egzbIJYAyQEqijYz6ewKOVNEtty5DZdSQKK
X-Received: by 2002:a05:6808:1c0b:b0:4b9:a88b:8890 with SMTP id
 5614622812f47-4b9a88b9027mr20758218b6e.38.1789050916074; 
 Thu, 10 Sep 2026 07:35:16 -0700 (PDT)
X-Received: by 2002:a05:6808:1c0b:b0:4b9:a88b:8890 with SMTP id
 5614622812f47-4b9a88b9027mr20758168b6e.38.1789050915578; Thu, 10 Sep 2026
 07:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
 <rh5ufacfap4x63rjmgd76wlwgn3n2wuelpe4sqwy4yda27nsiq@lg4ltoqwz7ba>
 <aqK3QiR3nsXtHTwL@baldur>
In-Reply-To: <aqK3QiR3nsXtHTwL@baldur>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 07:35:04 -0700
X-Gm-Features: AcwNN1WgxDRKonbfwtEs2Ayl__oXzThTnTjcC11fJE9LIXFOVR04lHCeSd6EFRM
Message-ID: <CACSVV0273TW2Ws8KfcT0BUS9O7ERWo7YUnpwgVndFYHjE6_yWw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
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
 linaro-mm-sig@lists.linaro.org,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfXzYZpDUGbvd7K
 4vODZNjjZr0n0dGr7Od7KsMsMvtH57g5PmidvS+nvVMGMICWksiESKQ4lqF1xXouk1gmcXgf0nV
 cJnyUyIDK3YfvfLfRIh5HLiQD2Uo2Hv/SICfwApD/C+4i8EitDh/Edzuqd3++aZRJPt35moLiw4
 RwAo/vcTO4KxsASCY3VmtojeE73F5K7U423CEzVrRUsDW65czc0wwqzQFYOJAmBxGHJdK6elVqF
 O/VCbk+V1eEP/kpvB/UNvcCbWGH6EnrLDSscrqc8bVpo1DfaEFPGW5zmKPoEskPslN7t8MHr4vE
 sLPo0fnnCn8Gr6vA98Sfja0mdFO7QonNb0itURx5/1tPpi7ACg/3HSAEj1yJk5BS4o6LKTSzLJi
 8ER4coEX0TLGEXcPfGW/v1e5UCYOvi+VibQixu4u+NBWHofb1wIM0cxJUU9XRlvCdFXg3jpocgb
 UON6G9O/KEZKqPw852Q==
X-Proofpoint-GUID: nejIa722W1dO-GerQYhtHosozrs0GoV0
X-Proofpoint-ORIG-GUID: nejIa722W1dO-GerQYhtHosozrs0GoV0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfX+U4SVnyUqbP2
 UxqeypzMTEnFowZG0OItTIqs5LIobhik42Kzg4QP0Fu1a/GuuE11WSNMkh6nF4CAWY+sgt/3RsX
 DOqYqzYL39s6o4JXSLNKExoFQadoOJo=
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6aa2c024 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=r1Mlh0iZuFWrlC140wkA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100176
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

On Thu, Sep 10, 2026 at 7:25=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Wed, Sep 09, 2026 at 02:48:17PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Sep 08, 2026 at 05:44:10PM -0500, Bjorn Andersson wrote:
> > > On Wed, Aug 26, 2026 at 06:37:00PM +0530, Ekansh Gupta wrote:
> > > > On 20-08-2026 20:17, Rob Clark wrote:
> > > > > On Wed, Aug 19, 2026 at 11:15=E2=80=AFPM Krzysztof Kozlowski <krz=
k@kernel.org> wrote:
> > > > >>
> > > > >> On 19/08/2026 17:48, Rob Clark wrote:
> > > > >>> On Wed, Aug 19, 2026 at 8:27=E2=80=AFAM Krzysztof Kozlowski <kr=
zk@kernel.org> wrote:
> > > > >>>> The rule of usptream development is that we do not accept dupl=
icated
> > > > >>>> code, just because a vendor wants to write something new. This=
 is
> > > > >>>> basically the concept applied all over the drivers tree, where=
 we pushed
> > > > >>>> back against all sorts of duplications all over the vendors.
> > > > >>>>
> > > > >>>> What I miss in this thread is why would there be any exception=
 here. We
> > > > >>>> do not grant exceptions from standard practices on "I want" re=
asons.
> > > > >>>
> > > > >>> I agree that we should not have duplicated drivers just for ven=
dor
> > > > >>> lolz.  But when it comes to adopting common frameworks and inte=
grating
> > > > >>> better into the ecosystem, this doesn't seem like something we =
should
> > > > >>> actively discourage.  I don't think this is a case of vendor lo=
lz, but
> > > > >>
> > > > >> No one discourages it. Following standard Linux kernel practices=
 and
> > > > >> requirements is not discouraging, do not twist the narrative her=
e.
> > > > >> Again, it is standard upstream review telling that we do not dup=
licate
> > > > >> drivers. Ever, unless there is serious exception needed.
> > > > >
> > > > > I wasn't trying to twist the narrative, just trying to come up wi=
th a
> > > > > path forward that isn't "no" or "improve existing driver", since
> > > > > neither of those gets us towards a future using common frameworks=
.
> > > > >
> > > > >> I asked why there should be an exception granted? Is the reason =
for
> > > > >> exception following:
> > > > >> "We want to adopt common framework"
> > > > >> ?
> > > > >
> > > > > Possibly?  But I don't think we want two drivers to be any sort o=
f
> > > > > long term solution.  (Ie. as long as venus/iris have co-exist.)
> > > > >
> > > > >>
> > > > >>> rather reacting to drm/accel emerging as the standard framework=
 for
> > > > >>> this sort of driver.
> > > > >>>
> > > > >>> So how do we get from here to there?
> > > > >>
> > > > >> What is wrong with my proposal?
> > > > >
> > > > > Maybe I missed something, my understanding was your proposal was
> > > > > "Grow/replace/improve existing driver instead of coming with a
> > > > > duplicate"..  grow or improve doesn't move us toward common
> > > > > frameworks.  Maybe "replace" is a valid option.  If there is some=
thing
> > > > > I missed, then I apologize.
> > > > >
> > > > > Options I can think of are:
> > > > >
> > > > > 1. Hardware cutoff.. new hw gets new driver, existing hw gets exi=
sting
> > > > >    driver
> > > > > 2. Backwards compat chardev registered by new driver, providing e=
xisting
> > > > >    UABI.  I'm not 100% sure about the feasibility/drawbacks of th=
is..
> > > > >    AFAIU the fastrpc folks where planning a backwards compat laye=
r in
> > > > >    userspace, so maybe it is possible.
> > > > > 3. exception?
> > > > >
> > > > > I'd like to know what the feasibility of #2 is, since at a high l=
evel
> > > > > that sounds like the best option.  Possibly limit exposure of leg=
acy
> > > > > UABI to existing hw so we don't get into a place of needing to ex=
tend
> > > > > the legacy UABI for new hw?
> > > > >
> > > > > But #1 sounds like a non-controversial place to start regardless.
> > > > > Possibly with #2 coming as followup and necessary step before eve=
ntual
> > > > > migration to new driver for existing hw?
> > > > >
> > > > > Even if we start with #2, how do we handle first-merge-window
> > > > > bugs/regressions without reverting addition of new driver and rem=
oval
> > > > > of old?  It seems like we'd need a window of a couple release cyc=
les
> > > > > where both drivers exist?
> > > > >
> > > > > Maybe others have other/better options in mind?
> > > > To all, I'm seeking on the approach I should follow to go ahead her=
e. I
> > > > can work on implementing #1(as per Rob's list) with hw specific
> > > > compatible for v4 if it's acceptable.
> > > >
> > >
> > > I don't see any reason for you to define a "hw specific compatible",
> > > because as you have shown in this series (and as Rob point out), ther=
e's
> > > no difference in the "hardware".
> > >
> > > The only reason for your "hw specific compatible" is to make a softwa=
re
> > > selection in Linux - and that's not what DeviceTree is for.
> >
> > That's not exactly true. There are protocol differences. For example,
> > polling mode is supported only since a certain timeline in the history.
> > Likewise other interface features are not supported on all the FastRPC
> > devices. For the polling mode support we were already beaten by the lac=
k
> > of SoC-specific compats.
> >
>
> I can see the benefit of capturing some of the generational features in
> a compatible, like the changes related to address width. But for pure
> software features that doesn't have an actual bearing in the hardware,
> I'd prefer if we relied on dynamic discovery.
>
> But none of that applies to the question of "can I use compatible to
> select if we should use the new or old Linux driver".
>

Nit, driver could still have an allow/deny-list of machine
compatibles.  Might be something to keep in mind if a phased
depreciation strategy was desirable..

BR,
-R
