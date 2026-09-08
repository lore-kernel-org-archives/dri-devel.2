Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5957C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CA410EC88;
	Tue,  8 Sep 2026 14:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mk0HbjE8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZQUfmfgf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542D110EC37
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:51:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688EjBMT3835526
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 14:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=XoTk3qooOHe0cDF5Pvym6RNpK9/DQBvlzZmOWCAvRS0=; b=Mk
 0HbjE8oCx5M+xQXmdGUO7rwOhnAmK/xbe/aPcsPgNPzfxl24ZCe14/I57BnVLsE8
 noFbHwmCzdXp0L2RbbSWNZo8eV6m0ykWPvnomEfxIbPB4lkpXxAlPIy6Qhin0c1d
 ESiWE2O3oPd1b2GT/mr2CWikjxv8tCQ+hCZgs14Fhryy3HlR0ztEnTmvwU6aiu6p
 JCxbn1jo7gn+lF8ZT483Ltu9sIwHhdNh3NUCj76bInt4Ki1XTmSlGdA4ayoil73e
 RbuQxBdmsDMwEjyGIhcosRtWsACgj5Y4B75K9xHsOBUBMeLxgqYUb51Z/nbYaXnz
 Bfwz+n9fa2bEpqY00V9w==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp49b7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 14:51:01 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-47a8fd3b0e3so759461fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788879061; cv=none;
 d=google.com; s=arc-20260327;
 b=EASe5CytfqnRdE06gh3sYdj7ecI6jntlF+aVFyVvq0RAceYyuSg/SYUucztyQnEffH
 HOZvGdjg6XlNQqzg2mH5kU6AV3iuj2CaMMBNr9JelxxLWxxhBjP75kkNSChGHEuqnAv6
 wFoQyNuqZCs08bu4ST7gz+irrs0XkurMkOPgJC0LDBV9MdPFAl3H/2WhMIVcxCgkbZ1S
 m88cgrYpW9ezWpUOP46hsl4jfOAM+u+AIND/xGd8IjRvuFXjvuXGOWUXpe7Ahxqqocle
 /M3AMj0HGhHeEWPcnGmSIsnfZontKXIdCh8+Dnxnedz95iz5Bz6/AGxR8TNIgeiMiwXg
 COdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=XoTk3qooOHe0cDF5Pvym6RNpK9/DQBvlzZmOWCAvRS0=;
 fh=/okk6ThvJ6+oUi6ARXh+DJ4Y+YaKKOrbKTLJTygtEZ4=;
 b=KifotBv/VIeQx//LGFrkmtNdhakIG7pjz2LIrqqYn3pkHMVz7Kj/RutHZ+IBZJzejV
 f2VMpB/9i5/V9OiYXjBASaOglMTeCVjme/4CJfkz43kav6q9dBWmyoVVFLmBpU3A7SHe
 Nl2RUviFySRvLDL7jDtEHM8pxfCSRnzjbWG0T/IVTIBjmzYDBiIk1upkr6QmbEKelnLd
 SNzaVgIUMbcuJZ0K4AYf2IcT9fhpyX5nNZXdx/LXoENrb4DeDGESfDLEitY9AqFNhdZT
 5YS9pG6uKNJq6HeAGgTcAhnGCj1bkWeF4gXlXBfiiDUDrjh2cHtAStuQeZmx67YATZQ8
 8TOg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788879061; x=1789483861;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XoTk3qooOHe0cDF5Pvym6RNpK9/DQBvlzZmOWCAvRS0=;
 b=ZQUfmfgfYLlZffRvgFLcD4gayPz0uRxlXdN4I1xxULRGGBrTWu4ayKGk5BVbBy4PBp
 aADrFgB8PcZ/fAahOEXJoedtY83XZmYdmWT48QWGeROXH1GKOmP3+S5BK6lfh+M7MCwa
 7lZNyV/MIXS9P1cFAjl+qcGz7Z46TZBWz/sOMW2YQccdgSXEg2n7Ggqy9dSzaFgFyW9Y
 t7CV5kyIHDO3lTLcJLwr/pYjFHNyCdz97V0Z34AG86KfGh6g40RGQxghQfs0bS5jR3j/
 NLljVMY7uHSpaCMGAPuDRgwSfshx16k8/kgBNw7hgEMmxLSUco82mmTyg9mtMZLw+Ukn
 aBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879061; x=1789483861;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XoTk3qooOHe0cDF5Pvym6RNpK9/DQBvlzZmOWCAvRS0=;
 b=li9u0vRAkfPgurTE1kwi1nMc+GxndAZjPzgGI70ujizr1VySlCPOG/+S8+a2iNEVnv
 vbOu1k5j98R1CUD1L7sTYJ9zXJflgOMbzTeMFD6rHm5bnTn0edXYIgXpZX5PRtO9yE8a
 2eFkb8WVDBoE9nfggvHWLPgAg+CBWiDdmYzGZHOnDpr92b6EWil8/SRVw2EzuBnFPxSj
 vrZ3Xso+XCci/WilAryU6UB29j0AH/cL+hkX+wky2l8werdPqDEOmsXkKZSB4tZnvkAI
 7kfUQg6sXLsKFOkFYs3HWyn1Oo+cvNq8w/Zx68B6r10pAG12JAn3ZKeCs4yBcomXDszc
 ek7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVi/7wuiytHY9GlQ2Dot4k0tQ/Y2hR541jomt5/WiwcGpdopk+AIq7dAayL1JJTtMHkOEPJqjoR7w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ni7/iYoeWEV7O7ci2K5GA7oafwgMZInSZs4rV2GKk85OPVxOTG
 ylpYCOZ7YtzQF7+jR7uoxzrQ+g4lZtliRdYE9ijEVOiDmpFUNUgKOtV6usH2LukzKiHIhtolv/h
 QnIhUJ5DiXY0qJavWniiQ2MRDRmvtzcOIyDPsZCzRr2wYa1TE+lfMyA6t1IZAMjtqx2/onoHByv
 +0IaZpNKBgVCEmGdtPsI7txG2qy+pgCK+OJpHNe5cgZiyNhw==
X-Gm-Gg: AYBFou2j6vfNgMVSA4NyfCzGn96nIDtxRqxnYv8S+M49cGlkdCUfpCujOEWG9i0NVty
 o+pYSAhW5WtkdL1cK2qHqJUnumKS6OFPASL++l3x8eSYSgd0PTBqHSOW3LBxh+txZ5FKaWATdrf
 K3xq5V+AQ8kemihMM9ORsh/xvpZFYVO9eRCeFSIHGnLVcb2eW2v3cxUZTV
X-Received: by 2002:a05:6870:9124:b0:45e:d529:40ba with SMTP id
 586e51a60fabf-4755158f2f5mr19089676fac.4.1788879061175; 
 Tue, 08 Sep 2026 07:51:01 -0700 (PDT)
X-Received: by 2002:a05:6870:9124:b0:45e:d529:40ba with SMTP id
 586e51a60fabf-4755158f2f5mr19089618fac.4.1788879060667; Tue, 08 Sep 2026
 07:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
 <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
 <fl5uoffoh3gyod3f6jxgze33ut4jj4ttmgivtyoa5oykbt2aqp@rkktjz4yh4ll>
In-Reply-To: <fl5uoffoh3gyod3f6jxgze33ut4jj4ttmgivtyoa5oykbt2aqp@rkktjz4yh4ll>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 07:50:49 -0700
X-Gm-Features: AcwNN1XMi8Pi6r5G72nQXPV504KYen-57fgrLczceh4tvG6Q5zpbewONJu0ggJA
Message-ID: <CACSVV03ShOw8D8d-5gDPYdzH3_Hp7EMz2CdfA3x08pCKAtw57g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Connor Abbott <cwabbott0@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6aa020d5 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=gJJ0UDS9VYZS2QgkKrkA:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: vizekuqDAxO-6hZJkizxEb8hsYMRrsA2
X-Proofpoint-GUID: vizekuqDAxO-6hZJkizxEb8hsYMRrsA2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX/hCFhR1BoDxL
 r5KyB09uCVGZLdoqIvKlIrTcEl0T+qBtbywwdyr08wT5tugVxscsDiChZZWQgSsFhnfZQDy+BOU
 Zq83nXP0D9q1cz61Qzu0n7u4Eal+2RHSKw42WWilHnbgagqgPhmZhIVz+78PWb1V7oFkXKRpixq
 ZASw2Z+XVgoNB2S4/oKeJvLQI0gnByVaCjtf+0NtrAC8f0GjqPjGbZeBYLUSoR5GDJdMoorCfPA
 yjhlAV5+pxlBjza8wxrBuQrVwsO/TD08jMFe+N+Emsd8sK3TRTmOXP8zbqjQU+Wit697NcV1Vak
 wbIKNjVGfX59fJ28tT6EE5Em6cXkmK55jdoh00V0r8lfSSuy2XxnnCEdGMwlAmixTf4+9DcGfxf
 iEEd8icp63Smwuc88xojqjtjbx54nnKAJABU7o6lZbo7zEzUhzrC7pYFXC5PEwJJbqlEXYAK1Rm
 UdbI40YuTGjdsnmmKfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX0deTRBrVPSgx
 nqTOIzQ/vgq5iS8aP97YuA65NxKMePnMW3kiz7SF3A5v/XJF4/ih7LnL069elOqWptinOuKax9f
 F95HrfxE621vKNliWAOiAYCkT6rGfAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080158
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

On Tue, Sep 8, 2026 at 4:41=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Sep 07, 2026 at 04:20:43PM -0700, Rob Clark wrote:
> > On Thu, Aug 27, 2026 at 9:07=E2=80=AFPM Connor Abbott <cwabbott0@gmail.=
com> wrote:
> > >
> > > On Thu, Aug 27, 2026 at 7:13=E2=80=AFPM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU po=
wer
> > > > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts fr=
om
> > > > zero whenever the GPU is powered up again and the timestamp reporte=
d to
> > > > userspace jumps backwards. On an a702 six reads three seconds apart=
 all
> > > > land in the 500..1200 tick range, stepping backwards twice, and on =
an
> > > > a530 the OpenCL device timer conformance test fails because
> > > > clGetDeviceAndHostTimer() returns an end time below the start time.
> > > >
> > > > Save the counter in the suspend path of the affected generations, w=
hile
> > > > the GPU is still powered, and add the accumulated ticks to the valu=
e
> > > > reported to userspace.
> > >
> > > This is useless because the entire point of clGetDeviceAndHostTimer()
> > > (and the similar thing in Vulkan) is to match what the GPU itself
> > > returns, and now you've broken that by adding an offset.
> >
> > Just to clarify, the timestamp needs to match what UMD reads directly
> > from hw in various different ways (timestamp queries, shader_clock,
> > etc)..
> >
> > If we can _restore_ the value (ie. write the hw reg) on resume, that
> > would be ok.. but it doesn't look possible.
>
> Yes, a quick check shows that all relevant registers are write-ignore.
>
> > Otherwise I guess we need
> > some scheme where an offset value is stored in memory somewhere, and
> > some coordination with userspace to add the offset in various
> > different paths.  But the kernel shouldn't be adding the offset to
> > what it returns to userspace itself.
>
> Ack, thanks for the explanation. I tried to match what kgsl was doing.
> It reads the GPU timers directly from the GPU, but for the CPU timers it
> reads the value from KGSL driver which accumulates the offset.
>
> If I understand you correctly, we need to export the offset to the
> userspace via some extra page (like vdso) and let Mesa read it. Correct?

Yeah, it doesn't look like there is an existing GPU_READONLY && !APRIV
BO we could re-use, so I think we need to create a new global (TTBR1)
"vdso" BO which is read-only to the GPU but otherwise accessible to
IB1+, along w/ MSM_PARAM_VDSO for UMD to query the address of this BO.
(And update msm_mapping test in igt to validate that it is read-only.)

(I'm not married to the name "vdso" but not creative enough this
morning to think of something better)

I'm a bit curious if kgsl handles this differently.. maybe there is
something I'm missing.  But somehow timestamps need to agree between
what is read on the GPU and what is read on CPU.

BR,
-R


> --
> With best wishes
> Dmitry
