Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C631061B23
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1F710E19E;
	Mon, 30 Mar 2026 21:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYbKyioH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxJRf7Eb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFE010E19E
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:34:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UFxRk01402660
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=3LlKiUEOpiPEoMZQb+uCcX+3SA93NAXe4enYwUSdS9s=; b=XY
 bKyioHQ8R74hcWfXN0BTumsSF/TlZ6OaI2GZNwfa3DAh+5Y30h9TwpewSAqqgBhf
 rAEssd2ewA32BjZ+ntX4EOG3kEmkg6BMe1N3GUJbXb+KyhvhP6XE+WW/o0kDKstJ
 kxKReJTfb7KfjrvAADJqn+JewSAJHbXy3vDHxGd+JJhf2DGjLmztH/DoQCXYBZzW
 NjmDjidJE3VsZ2hKi7f9vnV2kJhFFwVBhfTwJRgIMvXlH+5kVEpMic/2NUgauhoW
 SBlFbQnKdSyXKvC0gmOd9FCf2b4IyVI5Smlt+yv+TE9Igjz0DFjneX3nUrGBed/T
 U45r3Fx0E1e0u2BVXNuw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4hag0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:34:19 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-467b2af6710so13257502b6e.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774906459; cv=none;
 d=google.com; s=arc-20240605;
 b=e9CQnXsUfsS09j0isQaFYhBYl3WQr80oHtp+ZOjt1sdZWQM6x5kFIrZlfezR2AbS7p
 C+xZiaHpRhMXUHer+HHww5mX94HtzpzDZaX2bZE/ZzCkj7SUqPnbyjZ/bD+k3heTRPtC
 CEgp7FkLjZRdpePLez31VDAYPzhBwgJKLbnlmRZqZpOjt582V45YLWAAH+7mDxpb1Dop
 769ijT5+WeC3zC/Dbw5oebKKB9dAt9xxHN1Kt3y+3aAq+PyTbwcIbSOtjWOnb8IM/tpB
 xy8Bp8kJP/Rn/BqkayEWKRx2pLu67hjXx6xhSk+GVfsAo5EGEu9Q6iDVZBwrX/YplbcR
 byCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=3LlKiUEOpiPEoMZQb+uCcX+3SA93NAXe4enYwUSdS9s=;
 fh=DS0aOXqgPMgn2z/cJsSZXAT0IydHmnSeP9NZS4L/NI0=;
 b=dfhZ55RS3bWXD9T5UyZ5v1dFovWBRJ7OWwONjQNnWZ/R9fi2F6dCE41SwZPCBdJByq
 yZr8+5dcTV1rHOP3NvCtOtdkfEuVGTYLzKY+bTWQ/cE5JBTC+76jSVSxyOwp9homGURX
 fuoxP/pF700otyvitzXHMm4AV4EKehjL/api9FPO9cVI92sfstTw5o/7BmQPSB/eo25k
 eIN/l6EcAgR04NdtDQBciv9bQ+h5X0eFME4U8jVjr0wcGBmyQ9b390RZq/qlA/o40a2/
 cSt48XNn5xB6mI5kl0i/h8saZLJRvLnCzZSyeMx4SLxvH+4mERNOPi7RDqtKKDQx9w+i
 oR8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774906459; x=1775511259;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3LlKiUEOpiPEoMZQb+uCcX+3SA93NAXe4enYwUSdS9s=;
 b=CxJRf7EbVR8OEVvEefFdNau9a8//xbQzDfgjDI4AYaQYFviSB4UNvmtzlJctVE8Ro2
 EwK50dbx9d4Tw/vOeNTfH69a9ZHM/OWFGqCB5mll9ZKFg6uO77bYCx0lyhJAyJzlQ4ji
 dDua8wweNncq2FzF4MmnYzIOK7xuwCpeuh8dv52opLDl9birTAHIAImyUh9pILxVHHIG
 Q7MUmYXbJwtdAc3EZ3N6tyrs6qsBoSdo+tOlIXJRnCiGVTGxAO9tSmN5OEjim/9+XOUF
 glk4vu867vUXjJZiRx3saLVTwxHKcdlBW+l+26gSv3kbxAhcBP+qLalMXD8f3kp5W1Lk
 xSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774906459; x=1775511259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3LlKiUEOpiPEoMZQb+uCcX+3SA93NAXe4enYwUSdS9s=;
 b=NK+IL+G15RU7tRiiSAjT1tv2MEycUeUcG9KdDcTwxSCr2AKYRlRMvycLnQvyNMA6MX
 YazTqSvD82rPQH/Cbt25FpYFHVF/+NbGNQwB5SjcVRTrDq1sG3+VgE0dMLDratMs04x9
 nfTTTJEUVKZUeGhUjxarlbNae6bkEt78diQmlljJmY0w7OvU0H37+Ey/Jh8wxtoElO3V
 4JJbw0/pnRFnx1tfydt0Z+g/SOsAZHr4dmRmZLMG4YgFstx0tP/YVcyukEUfvmu+m5jZ
 F3BIqhAk2MWJe5FKnogBIMbYQBiIs9V+vilyuXVaX+9B088YKA90aWPWz0VXiLABU8jo
 o90Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA8zoVMtcc+NMVD6AMq3M4ItkKUxpFwsp45w3tm2MAKhgocY350IFCi2jAgGGUn/LA7Damt/3AKrc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHm42R8A5rsnDp7/fKUl+gtYxd2K+s7/c3kU426r22DCXSIdI8
 HoEiI7aeBNWxFTJX++vF3zKGcQGbkT0gHQTAO1nP1qi9bnkpOvioLp7nJWWtCNho1niDQNg4dkc
 Lg8hNhnPlbNBlFxAA+nVJeju7bbPcCshbkE3IfkXptX8VU5IiFuI2yTwjTHfFtokv+YuBn14m4N
 G52IadRbY1we/GfP/rX5EiboQ2kp44BtInhKzGyY4l5GOvLg==
X-Gm-Gg: ATEYQzwvWDGMzwoiFTNLq84QkIjPFUd2TZLfO/EoNibuhoq2USLIp+HrPQB+xR0jcjM
 ecdQ3kjSwNNwQZJ62Cx3hNZlsiBMjdg741YJ2DwX4TUBhrrzPczrqGFDgzM7/gs7frRT0ckaxMC
 E1A5B6k6VMXIXYrbwXZ+D/6DXy3YLVFSGc2ofISqrtE+wwcXi1p1kqbHiquLDqQOUoOwIjhzh5T
 7KbER+vYxuUnrg6FAY/ruf6Lh16FJUbjYXXBw==
X-Received: by 2002:a05:6808:1184:b0:467:2a6e:adb3 with SMTP id
 5614622812f47-46a8a42e498mr6226470b6e.23.1774906459288; 
 Mon, 30 Mar 2026 14:34:19 -0700 (PDT)
X-Received: by 2002:a05:6808:1184:b0:467:2a6e:adb3 with SMTP id
 5614622812f47-46a8a42e498mr6226444b6e.23.1774906458873; Mon, 30 Mar 2026
 14:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-3-2b53c38d2101@oss.qualcomm.com>
 <2ddea137-bff2-4576-94ed-4f3a48aed386@oss.qualcomm.com>
 <6037882e-3716-47f9-9303-b448ab8fed79@oss.qualcomm.com>
In-Reply-To: <6037882e-3716-47f9-9303-b448ab8fed79@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 14:34:08 -0700
X-Gm-Features: AQROBzBlZc9G6qmr6Lv7xrF6Fx40xRoPwHxRj-mNzMX7XCK3aG0lTexXvjaa2wI
Message-ID: <CACSVV01WDDj+peMZ4qArDF0qe0A+o9UiKq27y4ab3XBK+aCWjg@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] drm/msm/a6xx: Switch to preemption safe AO
 counter
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE4MyBTYWx0ZWRfXxuvhxnhSZksy
 MUhRnniC02ug9XZxALru8o4HBp4klK66NLxS1rQ4T/IZfSKDHpFNXD3KypEsEWm4M7nzrkiufGW
 obarZOQp4+zKDD4UqXV1uJ2f8ZWTICdKfYFUUgcjXRXbJI0C8VjdL/hb2hkxqH6gGJBXE75OvtO
 A7ZEcTNhMx7kM6crqlXVG4M/Hoydc+1tcCfhorLHcqTt4BQZqeibCby4GexXBsHI1b75tJcb/Ny
 oki8Pg4JAztAkFLSELnQkjyDL2xLMVtbSmDt3kfGsETZDbML+bQ4zLWgYrUG/XS1L/LW4+Vey76
 OHeus2pXd1zuh46WtDOfufy9scbEz6xxSWhh7/1EBt5RuO+anQ+Q9hokG6ali3TkK76DVm5DqET
 h2pPb8efglZ8rCz/4ms+AiWOOTx8fE2TioEaXJkGReFLA/jC12w1Ul5BAkaIE2dBnewfNih/pfM
 aPEmZKYLVflo2BHUtWw==
X-Proofpoint-ORIG-GUID: R2Jw89wdFSj-29Q3WwrKIIFyhZpOI51w
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69caec5b cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=e9XDKlPaf5x7KOCXZO4A:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: R2Jw89wdFSj-29Q3WwrKIIFyhZpOI51w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300183
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

On Mon, Mar 30, 2026 at 1:51=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 3/27/2026 5:02 PM, Konrad Dybcio wrote:
> > On 3/27/26 1:13 AM, Akhil P Oommen wrote:
> >> CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won=
't
> >> provide accurate data about the 'submit' when preemption is enabled.
> >> Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.
> >>
> >> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targ=
ets")
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >
> > (this is not a blocking comment)
> >
> > would the _COUNTER counter be useful to keep for any other purpose?
>
> That is actually a good question. I was fixated on the fdinfo aspect
> that I missed that this is used in the submit_retire trace too. In the
> trace, I think it is preferable to use the _COUNTER (or keep both) so
> that we can visualize the order in which GPU processed the submits.
>
> Rob, what do you think? If required we can drop this patch from this
> series. Or I can send a fix up as this affect only the ftrace.

So.. there was some really old ftrace based gpu timeline visualization
in chrome ("catapult"), but that has been superceded by perfetto
userspace traces.  The latter uses RB_DONE_TS event to record
timestamps.

I guess being able to record a sensable duration is the main thing.

BR,
-R
