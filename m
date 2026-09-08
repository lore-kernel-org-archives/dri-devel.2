Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA02DC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A8810E3EC;
	Tue,  8 Sep 2026 15:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XgpGuMTX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8sun6ZU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7424610E3EC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:26:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FOaij3372351
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z1k3p4OIFm+h9nzyCxBdy+R7myG1VF21hu//4us9owU=; b=XgpGuMTX/3XUUqln
 BUJSH69miBAkjwPYpjg4EH/4H0o5zdOYwgXBmzf4rIo89zE2dHRziqzqHu2bwgfM
 tJrk3mJgKF5OpjDAFu3wnklpB91zlVE02Ijs+VfEvGurk67Bg1WNgxsGPxtYiH/e
 qxKdEHThOhz9uYWKpjqiqOJUjn3VZMrVtSjufQsiSHegx6jMczakq14pNUXOAh13
 47ccPLRLhGZeLX4DRyc/9+Y0EXgU30LDezjNTZHty/Esheh+qUMUF2FP60vvOn3g
 QxCT8qwHakXhNX3O7KskPSvUAE4rIa0jZ+KVLRW9GUVKZPTFcDgqlbmYk/t2kP+o
 E8kl9Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwm8tp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:26:27 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e9e2deaa4so3476725241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881187; x=1789485987;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z1k3p4OIFm+h9nzyCxBdy+R7myG1VF21hu//4us9owU=;
 b=X8sun6ZUt0C1eH7Q1PCYbde1Y9Cl67gwZovsiaO2TEiCv8ZmmPAk5AsG+cBGHpt9vR
 KCVQSVdMC8WOoSBaHyZk1dpp9ZI8pON/ncm7m+T/RGQ1dHp90WVPgQyBHwCtlpMcxze7
 BrL1gG1bmOKX8YbeC3jPKkDzfeX29nDef+NDPC6fdj+hB5gA345TrMiltKdhA1tL5uvU
 YnGVv+K7Hx15udrwXMDFePBuf3A2+wkSvOg25v+Ne6ZclBnDgJKelA2xdqrNPuYs/Hdt
 G2fKYv5hafnJvRWvewN5Bykc0xVd7M77DYbyArr/NN/eUKgb/KQjry89CTCRSGTY3xhz
 ZdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881187; x=1789485987;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z1k3p4OIFm+h9nzyCxBdy+R7myG1VF21hu//4us9owU=;
 b=Aq11yvRdt4PMXcg5laLxTpFe/VUi3pOxEBBOUu650LDIcIcWQnEOaqZrvlkIl/0Or4
 QKab1QDGMoJzXVDMyhxyNJ+m/LT9oYHTIb3ju965c2xk87jqdr/zycTSagPvyrnlayAO
 vRR6TkUs+kO8LM2kTaisCKl/b8Id62l3NsulzVL/H+gMWWH+Qg4QZ+uFV1vw7NqoIljQ
 1+WDGMrMkodk3lk1gff0uCak7KnkZVm8WV9X/o1kpKUEy3dBo5jOQI1UVWyp9qriJPrn
 1ocbn4AOd3rA8a3BFcGDfucw+CdSdQP3K6CDoRJ2gH9vwWhsIxyg8X4enqqTG2ndcVMj
 6pxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSGXVp/ROEIT8jJyN7rJA6JTNSq3vVMgX92L724OZbCutv1pcqQ9kQDH7PEo3lT7Xg4QYQ9NA+C/Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n2ozz9HuwWF3b9sun/nX2TDBAyYfhf/OfQRWlv0TYnytFhUeu3
 +mzBrYy4m9msUdkoXPHat97kt65df9/2UxqHFuf/ZU6NaxaRbwTlymG7Hkf/k2jNye+mXdaBKT2
 bVG5BntJ4Mv2HGHha4efHJrh/lLeyi5TQ9t6tIX2eW3LstuVCuonIqyLQRcsjcWL0mnD+RVU=
X-Gm-Gg: AYBFou1C2VHgVgalmUBagdf2VN/R+gStetRJo8GMQULch1/rNuHsAV9AWAqxHYQQInz
 Un/xNyDdTD/QPD/ZZa/EOl+VBnnKuBTWGkG6Bzw5a/7LB3HTtzwk1DJPC7BcfkZ3Cr9TqdASwLM
 /z4y4PHcNozQEA1XGAmKjdWZ6wzkUHfWybgSR5jd0xBkKVoYSnldR/6VzGfslK+w2LmSyVOptng
 xozrH32IUsqwDuPXE6EFbWIfQG45+rDAOwrr5G2uzAkq7KQPmiRjt3M/vYv29lb1InlnS6l9H3G
 /b6GP9NJv83pLxH/+exwP/FG9q/MACMEOfHBMiHb7ojEf1JCjk7YzjwYmHj1M5+ngBgDwpMW9ks
 mHXIPnz/oDJRsGsvg3mdYK4YI/2E4kT16tyWFLY1C3dyjlu6cK7QZSvncQMhlS9q8Xa4RWdsvLY
 GvlHB4Y0pyUZFr
X-Received: by 2002:a05:6102:5e87:b0:77f:7df:ddd2 with SMTP id
 ada2fe7eead31-78a4a823596mr14049012137.1.1788881186702; 
 Tue, 08 Sep 2026 08:26:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5e87:b0:77f:7df:ddd2 with SMTP id
 ada2fe7eead31-78a4a823596mr14048884137.1.1788881185420; 
 Tue, 08 Sep 2026 08:26:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b616705bedsm3124430e87.67.2026.09.08.08.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:26:24 -0700 (PDT)
Date: Tue, 8 Sep 2026 18:26:22 +0300
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
Message-ID: <xq2q6jazk2a5atfthzwktn7qhrinxg4duhdxg22qrutgdycbwb@47nosxhcqloz>
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
 <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
 <fl5uoffoh3gyod3f6jxgze33ut4jj4ttmgivtyoa5oykbt2aqp@rkktjz4yh4ll>
 <CACSVV03ShOw8D8d-5gDPYdzH3_Hp7EMz2CdfA3x08pCKAtw57g@mail.gmail.com>
 <CACu1E7H9KsUU=dV+iwQPOOX62+V8S5xstFf2LXhzeE7oSb3V4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACu1E7H9KsUU=dV+iwQPOOX62+V8S5xstFf2LXhzeE7oSb3V4A@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6aa02923 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=oaW757hXQP8N7nSf2eoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX3VomuCd1FNMg
 Cw4fnyUxqs1p5Dpk+7ieL99JcnmjpKKBuwUrHatJtr6zONyvSsknIbb/mAZo28qfWBBD592n0Kr
 G0Vi3LFxNiTdNC3tbgpf4K1tgyM52SAyK7YI+93Br1LGap0ioTCMztc/CpkXi44gW9a7DJoTesB
 sxLJKND1klomiQ+c3WHmfKqOEf7+fEPiwtGAo44HgTGS8Y6Wt6vnFwprLvfJTlbRnVmPfa9MY9J
 ovLkZD58NJs66qJUGRPgshZL9by7TpIzxo7dcGUuqiJxU5il0zbLD6egsmgCk3vM4k7elLO7ecu
 tJq8tpqcoR8HAfueweEDl/y1KPO5NYhjn1FCggo2BfxkC09W+a1Vmuo2vGN7gCDRpmsGWmaALts
 tmbsJTcO77ByHU5yr/V5HN6mLwu6jjz7PtnBNcFaWv6ui8zJpVrN6qIQXVb7fGVO4GnHxfhPqFy
 Vnyd/6y743dUa5BJiBw==
X-Proofpoint-ORIG-GUID: 0hgyDgi9jyFSAlsBtyaaaiyRb1CEIDNi
X-Proofpoint-GUID: 0hgyDgi9jyFSAlsBtyaaaiyRb1CEIDNi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfXy81JME58t+HB
 I1xAIYu7myU6HzVAyRkrIJGLPBCWGJ2vNrnMV2l5dyxMMqWHj4jr0kZ+/gT7uLaMwO5VJAKZy+l
 dfvVKPUiK9ec3F0XOYKBWB8wcW2lcRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080167
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

On Tue, Sep 08, 2026 at 11:09:17AM -0400, Connor Abbott wrote:
> On Tue, Sep 8, 2026 at 10:51 AM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> >
> > On Tue, Sep 8, 2026 at 4:41 AM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Mon, Sep 07, 2026 at 04:20:43PM -0700, Rob Clark wrote:
> > > > On Thu, Aug 27, 2026 at 9:07 PM Connor Abbott <cwabbott0@gmail.com> wrote:
> > > > >
> > > > > On Thu, Aug 27, 2026 at 7:13 PM Dmitry Baryshkov
> > > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > >
> > > > > > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> > > > > > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
> > > > > > zero whenever the GPU is powered up again and the timestamp reported to
> > > > > > userspace jumps backwards. On an a702 six reads three seconds apart all
> > > > > > land in the 500..1200 tick range, stepping backwards twice, and on an
> > > > > > a530 the OpenCL device timer conformance test fails because
> > > > > > clGetDeviceAndHostTimer() returns an end time below the start time.
> > > > > >
> > > > > > Save the counter in the suspend path of the affected generations, while
> > > > > > the GPU is still powered, and add the accumulated ticks to the value
> > > > > > reported to userspace.
> > > > >
> > > > > This is useless because the entire point of clGetDeviceAndHostTimer()
> > > > > (and the similar thing in Vulkan) is to match what the GPU itself
> > > > > returns, and now you've broken that by adding an offset.
> > > >
> > > > Just to clarify, the timestamp needs to match what UMD reads directly
> > > > from hw in various different ways (timestamp queries, shader_clock,
> > > > etc)..
> > > >
> > > > If we can _restore_ the value (ie. write the hw reg) on resume, that
> > > > would be ok.. but it doesn't look possible.
> > >
> > > Yes, a quick check shows that all relevant registers are write-ignore.
> > >
> > > > Otherwise I guess we need
> > > > some scheme where an offset value is stored in memory somewhere, and
> > > > some coordination with userspace to add the offset in various
> > > > different paths.  But the kernel shouldn't be adding the offset to
> > > > what it returns to userspace itself.
> > >
> > > Ack, thanks for the explanation. I tried to match what kgsl was doing.
> > > It reads the GPU timers directly from the GPU, but for the CPU timers it
> > > reads the value from KGSL driver which accumulates the offset.
> > >
> > > If I understand you correctly, we need to export the offset to the
> > > userspace via some extra page (like vdso) and let Mesa read it. Correct?
> >
> > Yeah, it doesn't look like there is an existing GPU_READONLY && !APRIV
> > BO we could re-use, so I think we need to create a new global (TTBR1)
> > "vdso" BO which is read-only to the GPU but otherwise accessible to
> > IB1+, along w/ MSM_PARAM_VDSO for UMD to query the address of this BO.
> > (And update msm_mapping test in igt to validate that it is read-only.)
> >
> > (I'm not married to the name "vdso" but not creative enough this
> > morning to think of something better)
> >
> > I'm a bit curious if kgsl handles this differently.. maybe there is
> > something I'm missing.  But somehow timestamps need to agree between
> > what is read on the GPU and what is read on CPU.
> >
> > BR,
> > -R
> 
> I think the kgsl timestamp offset stuff was only added for the new
> A750+ CX GMU counter which is not read-only. We do need to port that
> over to drm/msm. If the offset is applied for older GPUs, it's
> probably another case of kgsl not bothering to keep support for older
> GPUs in newer branches.

I've been looking at the kgsl drivers from msm-3.18 / 4.4 as those
kernels targeted MSM8996/98.

-- 
With best wishes
Dmitry
