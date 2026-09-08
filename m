Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66935C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2DB10ECDF;
	Tue,  8 Sep 2026 15:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MNWX1qtY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KZ2gRL0o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B8510ECDC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:49:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdXO33964181
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uL3C6X92i3vnucRFu6eOOeXdI3jvIqfwUfDfb0dF6jE=; b=MNWX1qtY6ooLU0Kz
 yUoaIGny/nQtxaIuLcdFZcplNomrPDveZVAEa2EoAwYpGegeWrC+UDyX8UyqhGru
 yJqv/wlimM3IdBlFPrqHvGr2Ywd1keoyWgSI/6Rkrq5vGBS6NUeyDJgbx86mGypz
 f/1F2sQjjvwkiA+PnQ1cJZie2vKhTku8Fd0rboSF8i+o/BPSUPkPi2Xys2665QMo
 Vu6/wvWNm9SiYCFZyTTHbjlagH/XQs4Jjit8GnXeXelskYQlDFu6RoUGnAdEIIYs
 5V3Le4DH/mparl9K61MzAuq5SBuH3yqFEgLtWTAPD4Jbb74QJBDgTdFREZYv3JK6
 EKOvng==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp49kku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:49:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-754acc61c68so1404697137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788882549; x=1789487349;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uL3C6X92i3vnucRFu6eOOeXdI3jvIqfwUfDfb0dF6jE=;
 b=KZ2gRL0oIXVsRQrxGNI1j+12xUwJSknrNpwYCztoRVcXstr7r4v/wOk91WGNaZXr/4
 DExmLvjvkKRP0Z4gmpwG5o8m58jWs0Ki+WaVicmMHUwga5BNkvUv2r7/2YhuyVOdltew
 WmqJAI+/cp6rz1+BS9w4o7k3fm1dI0NN2S/mqYMoLw6uawb0+PgNETdDVlh4S5esV7b1
 y2KSXdLYkUN4Vi73UT3otlgUDHAxqD6DwNX94XimHQpJgViCKVcwjERV5nYNOP9zRdIr
 g5jDqnX+chOLn3OtHrgvWEdOMl82vS5VwTMXmRY1G5TNo8sq7fAcI/DhaX+2HGU511D9
 Utbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788882549; x=1789487349;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uL3C6X92i3vnucRFu6eOOeXdI3jvIqfwUfDfb0dF6jE=;
 b=YepM96hO03bSMRDvbZ1HYbfM6s49zhuVVpZQ7zpse2ZLstnEjyhzdkN2sl54Ryj2RQ
 02B7f2kyyLQ7NTYG/PuimOyzQqhZHrX3edrQ0C7NJRQdo3J3yjvs5VsJPxmX8i0DngTB
 Lj9FvQBy8JOiLYiTH2Zl8OMDHz0sKWIU8VDP6a/VTj8eAh6W4N4Ya6WWTk6rCO1nL80F
 J4RG5GFvsjp+7Mu7Zi+HfoUd8vfFfhLwC9mMGb6oIZXB6gAnlgVz70xh5TTl0qreuXPj
 GI9/xJOFaYm0xoASdbFfGM3xEeRXO3ec4mvNR1bzLmDttcnFDOYQ5l4KEOmiSA7oVqHt
 NhcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWffsJr6wb6IoDoEE/h+txmSRItlGusnQaTz2ixFAnCgnuyEMik/SA06kKgomNWtCIJhtV0p/MAZk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++llyAz7sawUawmteof4X82UGDjfR77Qa5plgAW1s2/xUzqE2zsS
 qm1CebY+DBPCCwXjt03DgrpqTzc6w+/jiBccLpl/x8rIhv2X10N+p7ZX6E9TYah4JD+E45K6v0X
 XBccr6zTkAojakRof71t5EoQloq6qZhhb6UWg0geL0YH94StZPrlRqVaLj0LwcCoKCrWuJ9o=
X-Gm-Gg: AYBFou0gGW8vEpx/pJr7EqruVFssFFoUAeLXKlbXrIMGDRA910KFzX/Fd9Km6Qd2azy
 7DcSEdxpObarwjQBGQcJiSCTHs/bEPmxzGTBeDY5iBs8jTDZZIydzpMUC/4Xv77B4FXlzkZI/53
 7e/U/IFpf79q35It2gFz1pSp4SklI1HYBgimgYS9MGwDrqVjFHYHtrr3ArBADw2VMXs6zKFYEyO
 4wj3/eAp2ybeifSFia/dcIkYu4YNtSokVoKuAvkOPqdGNDENsli2QEt7IHSQ8wPXBFiPYuksDzA
 LEoKVfEt62ftCCmB/hV83lBOvvhFMRtDMsuQm0oJLR2C+ikZCLwsAkPewxSmeoiujRsSESy3RzB
 f4D7oSvGm8Z668K5H6eBGdmN/F0susNqoZfFrvy/ESYiADKdJCb1BxKQRdK3jGbKR0LhcVIzU2s
 +W3CS998gfijUT
X-Received: by 2002:a05:6102:8697:10b0:784:5883:9cc4 with SMTP id
 ada2fe7eead31-78f75e026b4mr32267137.11.1788882548609; 
 Tue, 08 Sep 2026 08:49:08 -0700 (PDT)
X-Received: by 2002:a05:6102:8697:10b0:784:5883:9cc4 with SMTP id
 ada2fe7eead31-78f75e026b4mr32251137.11.1788882548074; 
 Tue, 08 Sep 2026 08:49:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b74cbfdfd7sm2648080e87.75.2026.09.08.08.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:49:06 -0700 (PDT)
Date: Tue, 8 Sep 2026 18:49:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Connor Abbott <cwabbott0@gmail.com>
Cc: rob.clark@oss.qualcomm.com, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
Message-ID: <6s7mwjzglv5slukj73glmshe4gwfyh6cvimxyeyn6l4r46lkpv@74mpfroj23xi>
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
 <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
 <fl5uoffoh3gyod3f6jxgze33ut4jj4ttmgivtyoa5oykbt2aqp@rkktjz4yh4ll>
 <CACSVV03ShOw8D8d-5gDPYdzH3_Hp7EMz2CdfA3x08pCKAtw57g@mail.gmail.com>
 <CACu1E7H9KsUU=dV+iwQPOOX62+V8S5xstFf2LXhzeE7oSb3V4A@mail.gmail.com>
 <xq2q6jazk2a5atfthzwktn7qhrinxg4duhdxg22qrutgdycbwb@47nosxhcqloz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xq2q6jazk2a5atfthzwktn7qhrinxg4duhdxg22qrutgdycbwb@47nosxhcqloz>
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6aa02e76 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=hDB9YrpZ_UtSDjAhP4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: hJbFbHJtoWlXhCbhb6Elit-5MUEDvmA8
X-Proofpoint-GUID: hJbFbHJtoWlXhCbhb6Elit-5MUEDvmA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MCBTYWx0ZWRfX0PQ+GBNDztmq
 fBXR9fDZnXq2NZ3XRwazeaTSnWVCEUIJnfZfG8vlIJ5bYuS2dSI6mg5U4cwPOxRQdIC0AVUut7Q
 xKPgOx0DMwAX5jJLgZum0rUvCUEwjYnfgec+TQ9dBT6gEvYCpRcnXAV0hW9Zu3s6p6ONWgBSPN1
 g/OePTKTDpNT7cQeyyIQVNDHhMi1w2HSTPA9OaM2cSYG8QJ3aor1e+m2NFrTipk5/1uGUN6nylV
 31DoUyfm7kGYKBfSe3V4gwsT7Zl92mp9fkTb2wg4kkfW7k0YzaCn79BCQ5agEq9UoPFA4ON2Moe
 AowQJdlq609Q662qk9F1PFnfBfG2+vToZYJj386aRYaCIbKUcro8KWs5XD7MYz4gLVr3jCYn0Wg
 FZtCNb57HgUlznjbVSehXPbHrLo90t7l1mFLDpVZ9Q1e165VjJJ0Ne/JAkCNNTnJoD9sWxeYQQB
 91P6CGVB/oacrmqltvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MCBTYWx0ZWRfX5PTCloWmYed/
 gKSHDo9t2xGsOOO+BglMs2ZOh3l0b8dLHMhGXLPi6Jr56qUUkDYpWP6x7IU58cEIbQhFG4Zs6Zl
 eQPiihRlHmQawpgvZRRzXM0igNoJTaw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080170
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

On Tue, Sep 08, 2026 at 06:26:22PM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 08, 2026 at 11:09:17AM -0400, Connor Abbott wrote:
> > On Tue, Sep 8, 2026 at 10:51 AM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> > >
> > > On Tue, Sep 8, 2026 at 4:41 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > On Mon, Sep 07, 2026 at 04:20:43PM -0700, Rob Clark wrote:
> > > > > On Thu, Aug 27, 2026 at 9:07 PM Connor Abbott <cwabbott0@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 27, 2026 at 7:13 PM Dmitry Baryshkov
> > > > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > >
> > > > > > > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> > > > > > > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
> > > > > > > zero whenever the GPU is powered up again and the timestamp reported to
> > > > > > > userspace jumps backwards. On an a702 six reads three seconds apart all
> > > > > > > land in the 500..1200 tick range, stepping backwards twice, and on an
> > > > > > > a530 the OpenCL device timer conformance test fails because
> > > > > > > clGetDeviceAndHostTimer() returns an end time below the start time.
> > > > > > >
> > > > > > > Save the counter in the suspend path of the affected generations, while
> > > > > > > the GPU is still powered, and add the accumulated ticks to the value
> > > > > > > reported to userspace.
> > > > > >
> > > > > > This is useless because the entire point of clGetDeviceAndHostTimer()
> > > > > > (and the similar thing in Vulkan) is to match what the GPU itself
> > > > > > returns, and now you've broken that by adding an offset.
> > > > >
> > > > > Just to clarify, the timestamp needs to match what UMD reads directly
> > > > > from hw in various different ways (timestamp queries, shader_clock,
> > > > > etc)..
> > > > >
> > > > > If we can _restore_ the value (ie. write the hw reg) on resume, that
> > > > > would be ok.. but it doesn't look possible.
> > > >
> > > > Yes, a quick check shows that all relevant registers are write-ignore.
> > > >
> > > > > Otherwise I guess we need
> > > > > some scheme where an offset value is stored in memory somewhere, and
> > > > > some coordination with userspace to add the offset in various
> > > > > different paths.  But the kernel shouldn't be adding the offset to
> > > > > what it returns to userspace itself.
> > > >
> > > > Ack, thanks for the explanation. I tried to match what kgsl was doing.
> > > > It reads the GPU timers directly from the GPU, but for the CPU timers it
> > > > reads the value from KGSL driver which accumulates the offset.
> > > >
> > > > If I understand you correctly, we need to export the offset to the
> > > > userspace via some extra page (like vdso) and let Mesa read it. Correct?
> > >
> > > Yeah, it doesn't look like there is an existing GPU_READONLY && !APRIV
> > > BO we could re-use, so I think we need to create a new global (TTBR1)
> > > "vdso" BO which is read-only to the GPU but otherwise accessible to
> > > IB1+, along w/ MSM_PARAM_VDSO for UMD to query the address of this BO.
> > > (And update msm_mapping test in igt to validate that it is read-only.)
> > >
> > > (I'm not married to the name "vdso" but not creative enough this
> > > morning to think of something better)
> > >
> > > I'm a bit curious if kgsl handles this differently.. maybe there is
> > > something I'm missing.  But somehow timestamps need to agree between
> > > what is read on the GPU and what is read on CPU.
> > >
> > > BR,
> > > -R
> > 
> > I think the kgsl timestamp offset stuff was only added for the new
> > A750+ CX GMU counter which is not read-only. We do need to port that
> > over to drm/msm. If the offset is applied for older GPUs, it's
> > probably another case of kgsl not bothering to keep support for older
> > GPUs in newer branches.
> 
> I've been looking at the kgsl drivers from msm-3.18 / 4.4 as those
> kernels targeted MSM8996/98.

If I understand correctly, for those GPUs glGetInteger64v(GL_TIMESTAMP)
reads the ALWAYSON perf counter through IOCTL_KGSL_PERFCOUNTER_READ. The
perfcounters are all saved on suspend and summed towards the current
value read from HW.

-- 
With best wishes
Dmitry
