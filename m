Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF45606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=grRu29bG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XwXdOKvb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8CB10E11A;
	Mon, 23 Nov 2026 21:45:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3783110E11A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:45:46 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANLC9O3188784
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=f8CTs4H0e4+xV/JFm+XfAOVDKNKiSc6f11sR45iH4HU=; b=gr
 Ru29bGUeD20KN15hfdTn/v0tDcsuI0iM4aVP34KjIOqVlJ589XfwK0rRJ9PRxYhg
 j/oQV/f4gL+HRYAx75aI7FJrTvxi3/PrY0LLPXMwFPR8zWzNnySCrt84iVe2Latp
 slWABwSdOefa0MzvVtR+BIyPkFUlROB2RKAE+5icheqxjRYxJPep/me+ukfClyj7
 aNh+4VpO1/Ecoco+CGRKaaVIBej+gEZdAQo8ZyIBUpueTJrT3F6nQncdjdDqiPL0
 VuBFXnVIhvDU3y3iMcjlWw7vgyYYYUErrM7iJQGubIrkwyUsRqj9ewqz5EzCEUCC
 fCePHonyWP62mxUs4lew==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6sr3hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:45:45 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-47b7f5b898aso1850821fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795470344; cv=none;
 d=google.com; s=arc-20260327;
 b=e8z+kAkNH+OmAiDWxR0w0/D2PSWOfwcDhZiR26c6Uai9tKaM9KkY7pajFLg1G2s5vK
 hQ8y5sSjfVqLwj/d70kniz4E8laGRCR3fgTrGVQuGXjXzvKW0NnlPn5KPik7Egy6m3Fv
 wV8VsaSQsCtYJ8s6YyJoClJ1iwcgYJnECAYeyGMg+VbRs52K9TtQs1pX7N8CrKPAq7jZ
 eimAj0xhc6gAY2My6YVHIw7bI+40cSPM6IXvVrcWtBxIFMjXB4bkf9z/8OybWun95t0o
 n1kl5IWmLmyjpu2r8cz+gMM7XCX0w1CUis00O5mO9XSTzUkmJe95ET4Kvq9QNqHNNXjA
 i1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=f8CTs4H0e4+xV/JFm+XfAOVDKNKiSc6f11sR45iH4HU=;
 fh=m/uydOHFgo8lRqx43hE5UlTe2ryrWfBdYSmkSanUvf8=;
 b=iX+Zpn8TjdIJNgYwxINgK7fZ0WIEGXB7q7oDAwWGjoT1rOTwVnjG+phdqRFJBqCqco
 j1uYxaeasQrFNsGA5rOIzC1VzJprPMe0yMoGN0NqN/KmgDTR8L3V18gMIQVMgPWzq+/E
 go6bjKMIVSmiu1YwkIyn+gp4k+Pxrk5kDN4joKwZ1oV/6MiKRQ+DD1DZZFG/jvZVMBir
 7cE54XgfldGeoeQtgJc3ZFSLMHh8DDGcIOGJN1Uy3cCC57ZL4wjZ79gOXiUuuJ0meXg4
 pI4dRo87TCT0QmOxOlZskaiw6lEb+QLUhakJ1U3VpkMDG6S4ceJBpAfI4evxQ+afal4P
 JmLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795470344; x=1796075144;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f8CTs4H0e4+xV/JFm+XfAOVDKNKiSc6f11sR45iH4HU=;
 b=XwXdOKvbsGgoAXy8J90A+ePMx4tAWz4Lr22C3EYXdShLrs4J6FUtVqazhm1Ypc5WZw
 /FPjuILBnZZnO2PHV/zZD/7K6Z1f2Ru/4KIzbhP8AX+d9TUj5Y4+kQpeBWulKHwHp43z
 hT/qbOYLtBoKKjahCrJ2G3/OHEFYgiC2UwF5jbMl5xLG9nPwVfD1PTDypUoWMI83cOKt
 iCiBa6OO/MTeJb5fGjupuzAuHganfTJXRG2xSWOtw/8IfHoKNwPHYj7c2G2HdSvgUzZw
 IaoxCkZ4n3bZC1IXFVBMzSDqPlk9VZ/CKIDZcT/9kWdJqkYnDhmFfDGU6+4webZgMY32
 J6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795470344; x=1796075144;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f8CTs4H0e4+xV/JFm+XfAOVDKNKiSc6f11sR45iH4HU=;
 b=eF/YnxjNvUc1iZBsvHqZ8KC7vnA1uyHJXM4WyTqcPb/BrZk+J/eYmw+wFmfmDdhJ5I
 BWljH21T0ngSsZd8bYJi3Mr0qRRkWvNzqqlQ1c2KluvkY1RsBm14sanlq2716Ct9BuOQ
 JZKRKtnPWZSMNmRDXBrA97Y3tsCKU2qSbavhqSQZM7LQSDk2OmaE+GGM9AP7cGWMAc7B
 zbqhfBOgBaXzkwvOwmwvBjNaJIW7alJ7Lv4UXG1b2JWzgelQg31TmXa6pXdRM4xHWZcW
 LtcygGPzGc2IKzoREp67Q9Ib7Qlh3BtFhQRrWkjxgUaEuVIAF8CSrUzDAH9H/5ZCqsyF
 UeZw==
X-Gm-Message-State: APuU4Z9StPfqc+WdP9nvKOJ8bhakLThAm5pMNaUMAAt+baUKStwUQGBG
 9fS0VmGuWqmmtpyI1jXhIP9GC9TSs7eb6MoTe2bQZAvlkX1Ti7dYSW1yRIfe9GxN23tE0et8xIH
 ieZqZTtdSw/XK0Ath8Il4t9pcfFuyIP40Lh6aoMc9QVzOMAKx0iHleXVczjpho7Imrq/KTUdAig
 0jKx5bXa9O08RLvd4HS7WwDs1M77vSDrHSGxR8yT9g8lTS+Q==
X-Gm-Gg: AZFdTZdMNipvFb9DdlRtG+ZfwTjqDkg00gdXejc96ek+kg0vi1xiA0zq/YtOtbizrT/
 OYHMUmUdEpBKBMW1yMi/H2lfXJ6jC0+5qDj3Htjp5wJI5e4npbqWI+FRDiBvqdkGipgynYP6HuZ
 anCP8NUjmD1MsqlWcToAz0k+6E1fWXtVcczLRIgPPamn3bXiYFNUAthtsuQwZSQjP8/EXDybDDy
 pMsn9Hmkn1EDgpf9YS4Ug==
X-Received: by 2002:a05:6870:5b9a:b0:4b4:8c0f:40b6 with SMTP id
 586e51a60fabf-4bc821920bcmr11250546fac.20.1795470344137; 
 Mon, 23 Nov 2026 13:45:44 -0800 (PST)
X-Received: by 2002:a05:6870:5b9a:b0:4b4:8c0f:40b6 with SMTP id
 586e51a60fabf-4bc821920bcmr11250511fac.20.1795470343685; Mon, 23 Nov 2026
 13:45:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123181306.420017-1-robin.clark@oss.qualcomm.com>
 <e4ecc291-026d-4ae1-a391-5f3856df8ce1@oss.qualcomm.com>
In-Reply-To: <e4ecc291-026d-4ae1-a391-5f3856df8ce1@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:45:32 -0800
X-Gm-Features: Aa3M54rCKbnTmosWYAIUHrhm3070EypXS245eQnX6lbW45gG_2uvaZLev6Ye9i8
Message-ID: <CACSVV021qzsi-s+9GfOqx4syzb0=eAtv5nTV7u3thOqLrRa63g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/a8xx: Add missing preempt_record_size
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Connor Abbott <cwabbott0@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Ys6kDZ85KVrkzzTQP4avpbrUonOO-BAB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4NiBTYWx0ZWRfXwRgE9tJ2nD0u
 lYbWuIZnq/1HqQts3kyM+QBPr4fnHBDgbvbZuEiSo+KtnXSdIi6dmsyU/770KdVaCUCQFfb2VjX
 Sg92XZ0iLtXmrg/IqRO0xGXVnerpLwc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4NiBTYWx0ZWRfX/dX6E14qkJFZ
 a3i/vjH9+6C+BJe3fCovPWi2fgt2a1NLiiMmBkBTj3wQvSt7aOsKC8MlwAK4nL22EcRlRYOSbQh
 R/8q2gJ2WfKTwu6rwdmPqFmirC8KocHM8vNmb5gThbyutQd0k4uxslFKGUgA1ZX7jLiSC3nsDEC
 XIdtR/NLfc9XTpnwIS1j4dEmwVpMTkOi9C9RWnedD/FeNJy5IrhtbL28/coDKcY+ILHoAt2rCSp
 D7eqspDF43wVPhz6TZ9dn150oOwiuhgpwacJDP9XSY8T3kCCwDoDXPMrO8XCmbXjc1HQtp4oYnC
 0LL6NzFv9eGv43IP3npTG7nMIeoejuYC9SkHiYiDrXZXP3BDrrnoVuTvKXo1ZNhUW4thKlI6SwQ
 WhbGkDm3KN5LowvQzLSPw7nidyJBYFGHVby88rzJYYPyuSiu/OcLSMi+46tAObfsX2J6WMFE/Wa
 3Pmq3sBX1v/dpq096KQ==
X-Proofpoint-ORIG-GUID: Ys6kDZ85KVrkzzTQP4avpbrUonOO-BAB
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b04b409 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=OkJ-WEULEOmYfeJtPDwA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 12:02=E2=80=AFPM Akhil P Oommen
<akhilpo@oss.qualcomm.com> wrote:
>
>
>
> On 11/23/2026 11:43 PM, Rob Clark wrote:
> > Somehow this got overlooked, and Glymur/Mahua were falling back to the
> > default 4MB.  Which is way too small for the amount of GMEM on these
> > devices, causing faults in cases where preemption needs to save GMEM
> > contents.
> >
> > Reported-by: Connor Abbott <cwabbott0@gmail.com>
> > Fixes: 7fad33097e67 ("drm/msm/a6xx: Enable Preemption on X2-85")
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>
> I think it is a good idea to add a WARN_ONCE when the default size is use=
d.

More generally, we should probably just warn if the preemption record
size is less than gmem size.. (we could probably also make the
preemption record size smaller on ring0, I think?)

BR,
-R

> -Akhil.
>
> > ---
> > v2: Fix typo in commit msg
> >
> >  drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_catalog.c
> > index 0c6dde3cbea9..20fe93b83c0b 100644
> > --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> > +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> > @@ -1337,6 +1337,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
> >                               { /* sentinel */ },
> >                       },
> >               },
> > +             .preempt_record_size =3D 23088 * SZ_1K,
> >               .speedbins =3D ADRENO_SPEEDBINS(
> >                       { 0,   0 },
> >                       { 388, 1 },
> > @@ -1469,6 +1470,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
> >                               { /* sentinel */ },
> >                       },
> >               },
> > +             .preempt_record_size =3D 17712 * SZ_1K,
> >               .speedbins =3D ADRENO_SPEEDBINS(
> >                       { 0,   0 },
> >                       { 388, 1 },
>
