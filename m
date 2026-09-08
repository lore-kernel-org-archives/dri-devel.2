Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BCBC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D0210EB67;
	Tue,  8 Sep 2026 11:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EoqdOlb9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOK7ePXn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D07810EB67
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:41:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688BY7aX2874371
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 11:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QV+zIsOLcXKbaqJsaB3LhZDmxFIlCQEKE/EB4eMCTJw=; b=EoqdOlb9tpch7yFZ
 C54PVTVRxYWr6u7w+vdXvC8ojefp2+j8mJzcDsiC9r6fuMOlxigg+RmplSK61RYG
 odtFe6n2VW3/XYnklcXRORQzI3apZzXTIoJ6/ZFvwzjc+vG0TUQtTg0yPDjabfz2
 MY+hFq2ymJlcg9irGqEGBLVXG5ra9vTpyzWAA8EMUN15bwhaJ3caOrYbYGRRNh6n
 BR1FhxO391BBbu3nwy7mlHRX3rZdPyxiybEWDjbQ17LJh97jx5WG2GrNDPIiLL3M
 t21+U7AhOLPigN2syXVFcNqbv8PcIRtVOor05s5JF5RQBrLxBVQbIrxB3XilZeFZ
 xOuy3g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjhkj00x8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 11:41:55 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7819910f8adso3911326137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788867714; x=1789472514;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QV+zIsOLcXKbaqJsaB3LhZDmxFIlCQEKE/EB4eMCTJw=;
 b=dOK7ePXnE2kaheTmYZFqXYDlFutTPCrYHjaLdEhXjcAWWAAYzmd5YAzMZBaYU3IF5J
 oIBeDIsma1AKvs501P6nVDtG5gbsjAsl8Iuhy0WehOnyxhhLlFuLDyN8KK+u5Auizoey
 NaiaFKuJ4b4KXn6HuNQYZkBy+njU71ui6rgylL3DC0rl5tKYldEKJ3UKvGGd6GzQJPe3
 haYmkLdyAzELZ83ZmjshjhuGMjBDcbADk2gHXmLNJ/aOmd9LlcD/E3l0T+OBWGj6pIhI
 DxP7OJf8H9yZHXljXC7MPhpAP8LkK9sYELk4+S0/rwY20rHGYuY8ewL88f63uYAc95th
 NQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788867714; x=1789472514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QV+zIsOLcXKbaqJsaB3LhZDmxFIlCQEKE/EB4eMCTJw=;
 b=inLpYP7MwlPP0J26DGW7ro4POknxb8p/DI9+fDpEahnrtv8eNAkCn5JYzh3iZhVbny
 /hT0xajZCXErTzi3qtCRl8oKSDvCLy/YcACJYcQmJwnKlns4KpxJxiMTjPHoWxIqnTNn
 v/O1x+e2w4A/XIVKS4fEP5eoRhhmxfgvpt0POV3ZH9bwsbbhQnZyoJLIYko/YeMessqg
 oLaWO0/A6fdpTZieo68gcm2xFEaUYLtn6McQkbgF7z9slq//P543Vxlgze48K3ZwOX/L
 faWr6rfk7HdntsuJlT6JGcdLVXro6702e8np6tUr0nUaWDXQG9rdtkLwyCCQmN62ygpD
 l/0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdyzNtG7UsFD+7bwezEA8WuARUBhizmDECT1rDyXlHhU3eDfbQ5/MvFPcHqu2QbZYAJARajvmqomY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBnbjdMrIwUOoS4w8Eqa+U1uSqZCWHczmaofcK0Io38zTOtCIQ
 ++ku3BhsWom6oh3LlbWbJKEgKMo0jWEihKI0hY8c0y7JdDggvhGORP1JEOM75XpJ+1q3BAZnXKT
 iEb14Qde7ZpMWPWQgtvVsJc6AErWknr++KhQ+OEUMeo+WxOYS1MDMMN2ul6+XZD5DigldoJg=
X-Gm-Gg: AYBFou0aAVRc5SVVEVrMcBrDBjzE2o+KyMxzcScJ3FswZy47HbMeZMv4M0QhQSh69dT
 hWxq4+LrtVk319E4EC8QwiXrAg1eR1QGViOsXyd9CHP12BwCRjPQr1zt3fgrQgvMyxazR0CK8MF
 5XuKlWszYlIX8Z5ArIzLbRlNtgGQQJHHvVTWvK9uOLwL1FNaiHtPb/mzVjNbncaRfWAKwiNP9ot
 W6Kr3LLIheOdx0gKapG7mca8qxyfN8evmASkqcSFVQSxiSIWhXP1jGY2ms6U013muRpv4hgIQz8
 BtMqzevA3YVaXJj+19Z09n1oS3zIK1GrMBHrXFwaSELgYP92D3ZjoWBD1++KxKFhxp0r8aqYNPp
 s+dzAVIJADeNVztU/jtU20+BygoCYXotHKM/FO/VEYYY7CQPLFmuAU/hf65yYL+ZJ0E8MypiTyx
 AUW8h/MaVumTYj
X-Received: by 2002:a05:6102:2c8e:b0:785:b0ac:54bb with SMTP id
 ada2fe7eead31-78a4a9eebcbmr11094435137.7.1788867714005; 
 Tue, 08 Sep 2026 04:41:54 -0700 (PDT)
X-Received: by 2002:a05:6102:2c8e:b0:785:b0ac:54bb with SMTP id
 ada2fe7eead31-78a4a9eebcbmr11094401137.7.1788867713514; 
 Tue, 08 Sep 2026 04:41:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166ecfbcsm3048299e87.13.2026.09.08.04.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 04:41:52 -0700 (PDT)
Date: Tue, 8 Sep 2026 14:41:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
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
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
Message-ID: <fl5uoffoh3gyod3f6jxgze33ut4jj4ttmgivtyoa5oykbt2aqp@rkktjz4yh4ll>
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
 <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX/Gt2udjYMxQW
 cRa6K4ZsFhR+TEVBQUQ8Kw/7yxYWv57f/DG4D2/clU8Pn19KFs6YlkF1yd8BqEL8UNS9I7zQLOd
 IBrxW8FufH7TZT95InYMmbA0WnEwEuk=
X-Proofpoint-GUID: N6z9qJ8JtCPKG_ERJZyitchs27eC8w_d
X-Authority-Analysis: v=2.4 cv=VYjH+lp9 c=1 sm=1 tr=0 ts=6a9ff483 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=NK-yGmZRxCvKOhKFziUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: N6z9qJ8JtCPKG_ERJZyitchs27eC8w_d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX1uLMXosC0aQW
 9CKX7DbAmZ00iIqEwhBJisCNFEhgzKp0mD2Aurfi3TuACWM7DnYCTh7eD1Nwzxdti7llobkwTFd
 7NbR9BVWb3P0Jrqb6O2VTM5uT1HXDdi49ICfFVV21jcwYC9MYuBStgYzBYewLCL6SOX1SpMZJjH
 4JetsWkEzmVRsKA47GtRbu2L1hO8qhUgerLMtLHaMI7fQUG5+VzoJwEtm0sAvk9WTlaTOOE8VtD
 QpjjYIBozao8c4illOl87Du6g6eVp3W4t+ZjNr54ZvQDYY/O7G2NZr7UEi4/167DpeOqTeTh6ry
 dI8wg0ScN77KiGr75NsKoEgXAhCxCcn0EHpjjHAiVfumxeSuvmYpqGG6qZAItaY8FRbjThdsfFz
 9UzFINAMwBPmCmz0czP1xBPiKpCt7pLbhvFH/URFPVmKnpXlMHoVB8NFxz0fKvJgSRr3ydAEbjE
 Oa6wEmnHO4sSkYOAqBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080125
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

On Mon, Sep 07, 2026 at 04:20:43PM -0700, Rob Clark wrote:
> On Thu, Aug 27, 2026 at 9:07 PM Connor Abbott <cwabbott0@gmail.com> wrote:
> >
> > On Thu, Aug 27, 2026 at 7:13 PM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> > > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
> > > zero whenever the GPU is powered up again and the timestamp reported to
> > > userspace jumps backwards. On an a702 six reads three seconds apart all
> > > land in the 500..1200 tick range, stepping backwards twice, and on an
> > > a530 the OpenCL device timer conformance test fails because
> > > clGetDeviceAndHostTimer() returns an end time below the start time.
> > >
> > > Save the counter in the suspend path of the affected generations, while
> > > the GPU is still powered, and add the accumulated ticks to the value
> > > reported to userspace.
> >
> > This is useless because the entire point of clGetDeviceAndHostTimer()
> > (and the similar thing in Vulkan) is to match what the GPU itself
> > returns, and now you've broken that by adding an offset.
> 
> Just to clarify, the timestamp needs to match what UMD reads directly
> from hw in various different ways (timestamp queries, shader_clock,
> etc)..
> 
> If we can _restore_ the value (ie. write the hw reg) on resume, that
> would be ok.. but it doesn't look possible.

Yes, a quick check shows that all relevant registers are write-ignore.

> Otherwise I guess we need
> some scheme where an offset value is stored in memory somewhere, and
> some coordination with userspace to add the offset in various
> different paths.  But the kernel shouldn't be adding the offset to
> what it returns to userspace itself.

Ack, thanks for the explanation. I tried to match what kgsl was doing.
It reads the GPU timers directly from the GPU, but for the CPU timers it
reads the value from KGSL driver which accumulates the offset.

If I understand you correctly, we need to export the offset to the
userspace via some extra page (like vdso) and let Mesa read it. Correct?

-- 
With best wishes
Dmitry
