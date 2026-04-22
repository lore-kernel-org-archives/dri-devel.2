Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3F7F94CBA
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645CF10E947;
	Wed, 22 Apr 2026 00:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mYX2TgIR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bAnJofe9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A140310E947
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:41:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZtxg2123735
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AWFZ6UPtBgUL1cM3Hkcd5gB9edDFjp543O1vZEAy9ec=; b=mYX2TgIR0PqYmd4j
 vaBIqX132I/5S70N9rb7N+1wbblqO6z5cgh2+h1Nfg7hW3PgPKpDmzVTDn8nx99Q
 9Abt6yxioPBvn+6Te185N8452UixmpHrMRaX+iamzqZyoLtq2NqibX9wAxKNDiqv
 rQPGNjjq9L3Q4Aws/UxdHCGN14RlFOB0AJAywDRmj2qZCKp0Dsacw9Z/+hBVtaoR
 Lj+nx7i1iAKs/afcoWpoTacrRXxZubCLaCXhqxNOsMs5C2r44hdv72jEhW/HaOoX
 g+sUASPu6us7zqCATCnl4vI9xpO8PpQmbY7zXUtYJu10SZgW1d6r2Vw3vVrUyYHs
 sx0BKg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfrx03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:41:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ae6aa148a7so38050366d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776818516; x=1777423316;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AWFZ6UPtBgUL1cM3Hkcd5gB9edDFjp543O1vZEAy9ec=;
 b=bAnJofe9t4AXqe0/RcMspzfPTxVhfO63ik92DzQB9CcOTjZvfa08/OFsMnIbx1NIWS
 3HxlV0TuQatkdBNpWEWYp1pCcavl9dW4TQ6npNQFRMEmQe/spCf6/2cqwO25sSJvexb3
 +JtUfijHgCEqza1Ahkoq1GZ0uurahKvU2UPueJ2KcygrGp2ctEy8WJO4qUnKABvABEzJ
 1HnP6CMUyLklapP6Y/diyYygNb2SmTyH4i1MovsqWz11rLpM9vX0S3O5cxgNtRedfDyk
 nToxEr3N+fE58giAjPGxS12cpgqllLxjgVs4uA996g1fnR/cJRgYIH2cgVA2DAaI89gE
 dHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776818516; x=1777423316;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AWFZ6UPtBgUL1cM3Hkcd5gB9edDFjp543O1vZEAy9ec=;
 b=gLyiDKQQ26q20ImROmws0uGWSa0QtwCM5wpWA8WEbokhe3rjao4SF//5SjziB+jOnY
 ctRdJpLzCPwkV3rtE6sZ6t6K6nCE+E+8x0jF3irJvi/lh5gA7WneoMRN2nFcJrziAs+3
 X5u1G7yzDT/t98LPifti6KHSfUgvbEYA4HRm1+X6YVqLxbrokptSigo/xB3IfnpLqOMX
 j655DAglm8BYwplUYypJoJUXRv/hhpK59Hw8vMng7gxB4toPsysm+51eIkik0H2BFRcM
 uCSL478qFP69f+vyqJogJjxW/GvvlbzrUp/4hhcfEahAt1pfKDFAi8qtoJzFQAlEquT6
 Iu5g==
X-Gm-Message-State: AOJu0Yx7LPs4oPCc7KXbi04cNBF/bGTRCljwTb8E2I+aV6WExn+KVlGz
 4roR4OTcbnFB5qIpI5PeGAMaEBgsVy7AeIzaiJjdMRTmp2QC3cIaYInoE65yW6GKiPKO1rFkUlA
 83CXmwjkinHk2T1MX3Cf7cIoCEi4h4RFdJ13tIaP3Yu7JnyOOhkTpNiHuNGCegs5U3QCOjHo=
X-Gm-Gg: AeBDievD/f/HlmdFIlcoBrQu5MFwT7OLauL+obQpq8M0Kd2SKDvERVdNVEQ2g5R5JAM
 XDcRJqle2SYPBOnwKBukgkVI2HBco8IK3Uvt0uNrtL5CCZwh0QSLmdPub7R1aJGsZ7sEkf95aMW
 N9JhXmtya+U1DxDfICIsbsiqmPbi7N2FHeztktfjPX1dyuSAcHJr1/8BSAk/jL9JPiJ10K0frSW
 inauiu+F7QQ7BumgpCc53pNnOC/h5FAkDTh7BVgHfPbkBCWT/4Ydd2LXHqFU4ADH02GXqacbHwa
 P9JocJvbYBoGUzqvdq+9s09rp83rrdarg/IYXZSkwH9U/oj+xd3YmDfz9JRrBsyEOcXjsE21OK/
 eZyn3W+W4uvdVi07Lg9TXKm9UlQ5SCRjsOdrGRjxn6b2OaD7k/N4ZoInCnxW7iTkVMDIqTcB5Rc
 pxPOZRFap8yVyiMJnAwVN4+DpPXK3DLbxnuN/aKptJSdpkLg==
X-Received: by 2002:a05:6214:2267:b0:8b1:f2e9:2996 with SMTP id
 6a1803df08f44-8b1f2e93452mr78549796d6.15.1776818516064; 
 Tue, 21 Apr 2026 17:41:56 -0700 (PDT)
X-Received: by 2002:a05:6214:2267:b0:8b1:f2e9:2996 with SMTP id
 6a1803df08f44-8b1f2e93452mr78549546d6.15.1776818515641; 
 Tue, 21 Apr 2026 17:41:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0adsm4035894e87.11.2026.04.21.17.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:41:53 -0700 (PDT)
Date: Wed, 22 Apr 2026 03:41:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] drm/msm: Remove obsolete perf infrastructure
Message-ID: <cczwmaecg7h5lpuw7mi6n6k2zu3lqisrkqybavxe4h6wlrofkg@qcmf7eq3siaz>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-2-robin.clark@oss.qualcomm.com>
 <sidcsgvqxddatwwflohsd6gjzm5ehbs4alwaejh3pnjnlhj7vm@nqxhdtxxxizs>
 <CACSVV01TK+iLiaCofFfPU2eeMGT5HX5iW0rf=m+gjojXsjrk8Q@mail.gmail.com>
 <puvvx2h2jnoxej42blcdx357uzx37ogwnqldcynklmm4acameg@4zvnrueodcon>
 <CACSVV01D388voqDxmfOm_qhV3=H+F3YW2oUjzZT7MfKYwjapDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV01D388voqDxmfOm_qhV3=H+F3YW2oUjzZT7MfKYwjapDQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e81955 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=UOJWCEE-UvdaTPQNjZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: quGCqMkdDFQwZMS8t18dDCyw7CHcRys-
X-Proofpoint-GUID: quGCqMkdDFQwZMS8t18dDCyw7CHcRys-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAwNCBTYWx0ZWRfXwnW0Gj3pRtsb
 sEim5sZAUskHY40ZkMtLDW42ZB/gA/DY3T6/+eqAel+UNXVmBNszwtpdcfqdOupckBMmqBg11Sz
 Ikvfo8HXAgFlNSqrieanxQBBX9txlnJLtxazAyHhbPU83C2OpnZslfryhm42TNphDhOYhxnNmRr
 NX7R/rkrWtKP4Can2CAl6upyoDX3hnAy2oC2E3+4+NcsMlbG2bD56xWnMu+BrGlUEgmIkESp4Hy
 dldb11HdYuXL0P9K4jyH51Npi+Tmtog2G8LwsdW8S1SpfFvTvdn3xkYALVAcEwZoBOHGXtjpej4
 Fw2VQuoRVQnXRfOvRtr7MizyxHNhVoGb9Y6LjiTx1MAYdGDZI1BlhhBSb/ZCtUq9mjDtWr6G30r
 ha4qffTUH7nphRJWZTHxbOjN8sALFubjwL5vgIl377oVfr7ynk4aYpQakMpHAn0tQG+DU2nZ+/f
 2RYiHKu2+d96Op9rntg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220004
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

On Tue, Apr 21, 2026 at 01:48:40PM -0700, Rob Clark wrote:
> On Tue, Apr 21, 2026 at 8:39 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 06:07:20AM -0700, Rob Clark wrote:
> > > On Mon, Apr 20, 2026 at 4:49 PM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > On Mon, Apr 20, 2026 at 03:25:23PM -0700, Rob Clark wrote:
> > > > > Outside of a3xx, this was never really used.  And it low-key gets in the
> > > > > way of the new perfcntr support (or at least it is confusing to have two
> > > > > things called "perf").  So lets remove it.
> > > > >
> > > > > This drops the "perf" debugfs file.  But these days, nvtop is a better
> > > > > option.  (Plus perfetto for newer gens.)
> > > >
> > > > Would it be possible to resurrect "perf" later? It was really useful.
> > >
> > > Nothing is impossible.. but I was having trouble naming things with
> > > both old and new perf stuff in parallel.
> >
> > That why I wrote about resurrecting it later, once the new stuff is in.
> >
> > BTW: do you plan to get perf counters for a3xx-a5xx back? I remember
> > that there was some issue with a2xx ABI.
> 
> So current state on userspace side is that only a3xx/a4xx are missing
> perfcntr support..  although it looks like we know the countable
> enums, so probably not hard[*]
> 
> In all cases, the existing userspace-only support will continue to
> work.  The main reasons I omitted a2xx/a5xx on the kernel side are:
> 
> a) Not really sure how to do the Makefile bits.. since they wouldn't
> be using a6xx.xml.  In meson I can use a table (2d-array):
>     https://gitlab.freedesktop.org/robclark/mesa/-/blob/fd/generate-perfcntrs/src/freedreno/registers/adreno/meson.build?ref_type=heads#L20

I saw the comment in the commit. I'll take a quick look.

> b) No good setup to test

We probably need to figure this out...

> c) They don't have IFPC
> 
> They could ofc be added later.  The main urgency is a8xx, since I
> don't want to add mesa perfcntr support without PERFCNTR_CONFIG (so
> that we don't have an older-userspace, new-kernel permutation on
> a8xx+).

Sure.

> 
> I don't remember about a2xx ABI issue.. but a2xx perfcntr stuff was
> added after I was already busy with later gens.

I might be completely mistaken, but I think the issue was that the
kernel didn't reserve one of the counters for its own usage.

> 
> BR,
> -R
> 
> [*] there are some counter groups that had some slightly different
> config programming, like separate clear/enable regs.. which I haven't
> dealt with yet.  For a6xx+ this only matters for some counter groups
> (VBIF/GBIF, maybe GMU?) that userspace doesn't care as much about.
> Idk if that was true for the earlier gens.  Eventually I'll add a6xx+
> support for these counters, but there are a few other things to deal
> with first.
> 
> > > Is it really adding value
> > > over nvtop?

And I skipped this question. Yes, there is a value, when developing /
performing early testing. Running tail is much easier than having an
extra tool in the initramfs (we don't have nvtop recipe in the OE, maybe
that should be changed).

-- 
With best wishes
Dmitry
