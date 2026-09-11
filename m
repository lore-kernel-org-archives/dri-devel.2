Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45625C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4355C10F589;
	Fri, 11 Sep 2026 12:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjK7fcb6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LOpL01wo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D57010F59B
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:44:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BApuxl3433264
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hs3C87rUc37Br7hDul2xSyhF
 h9hB6GXOl4E84myixsI=; b=NjK7fcb6JPtbo5k6auGunh1/s6S8cSB7/2xfUCb0
 geBR6XfxyIyAv/YgcP8Y+c9tuKr9gYAo3B6JafTG8Heot7v1jkoHq+1UeI5/8ix4
 uIuXBf3NIewBEGLANgLEDH4Iv91nN3YQ4OrelX0svTbAYm0QAF7onmGlMv1xOTv2
 pqTqXF1qOaUn2TSkn2Zx+Zy+UlzWsOMcW6qV/pxCY0hCDp6ut9jyKGe+oY6sv/Jx
 mJYOXFPLWKjH6vg1XX2p8L37maNfpKt26iRisfXiPNpqJvnAdB1w7P207DHsAOw9
 m9cW25yCDc132GIie1OvaXAGaotgkwZaoA4TdtHSVtUrIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmfbbgp3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:44:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e4cf4f9f1so91094b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789130655; x=1789735455;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hs3C87rUc37Br7hDul2xSyhFh9hB6GXOl4E84myixsI=;
 b=LOpL01wo7DcAt2pgD9R4wu7S62oJU5Vf/AdE2FXCyXpMgzOY+vEIFvlBKMDzuBfgFi
 UVs2F2CXh6HSM0/91WB+nIckedU9eW5ywWl5mPNKDKpCiGYqv6LmfDZEND9Ww8G71I9h
 fhYqkUOs6evs8LNboKQ4T5VjrPAMzHU5cYxo28ms0O6mkXxnL+xCsr1Y20/Q6ik5aPuZ
 7CzO2jCPZ4z+M0onuN5tylY1amlcx7QRr5TAQN27I1XMmsrjvPjDYOfeReDt1Q4wm7UT
 cDHVcgANwN1mLSCiS+shpycqjTaQSDLvhjs23zmYVo5mJW6nQbM8YaCdCjmrV0MFxSR2
 ++gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789130655; x=1789735455;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hs3C87rUc37Br7hDul2xSyhFh9hB6GXOl4E84myixsI=;
 b=oZ5k06x+pRBX7sexrfqQ8HTXofMSrC34KHJ7xjwaQV2tdkYSQ59RKvaR7CoMLEJ+mV
 Hfx4qbvtD7GmDP4MUPatQC3X8rXrz+UiV9sXC3yI/wk9PNZUxWSxaoY2HIDOpdTO7sxT
 OXUJJrPxb7JfXyHQYrs8+GJ8hxLUjcCav4Q5HA5JIsCJiEFLLPeNlYuwwLCn+zOgJxmW
 URmLk6okl3HGBAeodmDS04+22OMFJeFB5QuRwCRYu1rfoQxuffzTLjbo7Omv3BH9BNnX
 IWW0vSsWHmPR/9oLyxrM4cqkxoxooQSs7nXPwyIrWO4AkilBFtF0w5mDeYXH8AoHk7T1
 jXlw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKoAXmhQJHZDlv2f4+c0AScuqE929Mzc4TJVWkAEsHVUV95DZdxCuWikQqujXT7chGSh4Cg9bmWG4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nx9S0Aqz4rvXoEWQdle36YBGpX6MD7KUfhNODfvgPK5ry5lyU5
 P+eQURIZCC8wEr+5V9/dcKrOTSY35ZW2Vv5sOKVojItsA//uamo71F0vYT9N6tZ2wCEXMg4XSF3
 MsnDWX8BGsAeKwcsdelZ6pKmMEyTwnA9qFNYX8/2E5NHBCNteADuu1qcVKBgGM6bmRmvoRFI=
X-Gm-Gg: AYBFou3njiOIRox5OhmFlcE99Z3Xxl4mSMPSN57hBuHzCvb049yA2ZJJ+J/WcvnfjHA
 SzyBXyKaV0ODFVj94QMJ1NLvfcr/8A7krUL3nH25ygtAjw4OZg49zI8OUfy3PSmwWMWRjuFoRdg
 rVQR6VMqwh/IIbecOB/Twv5YUBij5HXtEihUL+h7ETuRassEwPbbG0et5z2HBM2u0BFcfHRyOd7
 HCHVB0O3oFOjCryE0rsek0P4ep6LiXdDDtrDADlnpouu6c88oDoyQjwMvHjq36QM0GOXCbap9g3
 ErLBy1eCR5kDBzlRa+dLnG9SAfEQyL2S5BIYW5z86LvyrqRqOIWRkBXhz5js418Y7pwJD01AOnU
 rTtu6xoZmYMSmeQ9e4PVZ7qnA18H2vWFZ41UJtzj560naTEweGNz5gmfuE4ONPwcXV4vxXERdan
 s5EYxxAdOw0b84/ZIJz41v
X-Received: by 2002:a17:902:ce12:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2dd29e0eb11mr52067515ad.0.1789130654993; 
 Fri, 11 Sep 2026 05:44:14 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2dd29e0eb11mr52067185ad.0.1789130654445; 
 Fri, 11 Sep 2026 05:44:14 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd3f0faf19sm3636485ad.12.2026.09.11.05.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 05:44:13 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:14:04 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Archit Taneja <architt@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 venkata.valluru@oss.qualcomm.com,
 Naman S Thaker <namathak@qti.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
Message-ID: <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
 <20260910064723.pbZP3vic@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910064723.pbZP3vic@linutronix.de>
X-Proofpoint-GUID: vDiVX9azTzagkj--9Lwf3wwqu9npLQq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE3NyBTYWx0ZWRfX+e0fJwYrSBu5
 y1pfPD8tHmWORAU+rJKn274kcMOD6rwmIzkOlYnSIqzKRRniw+JJHIrF7fw172ZqMWu/aOa8Scg
 YpTE2sPbE2hQNk3GBBkTdjuleThOcn5bfDBOv0gMcP2Kd7CqgI5H+I1QxnS2ADeaaXDMWzNWYaU
 vk9DvaRuEyPASb+xGMap/d+PwtjKu7iVwutLa6dPnrvo7st3L2ewYRfhmVK7mgdWs0XbCakCuUD
 tvURCrcdlJnAQQWOuUH3AFuFRC2YNkVlEDb2GqWGgt0V7Z6yWjqlz8QT1Q2k405/DEB4FtvyqS7
 WX0xvIyLt+BPJd2HAx/a92dy6yFOyg6BqKxI3X3M1+HIgk6lyqjzmvspgsvuJwUxkimUNAuv1Jg
 JA2+Mo7xPqgHP3Hj0y5ZU3vMxtbK3eBub6cUcX35atAxmDdOEBroJnygjnU9il3gOfxNfhUS7v9
 rcuVdhTKSB6M/NALdqg==
X-Authority-Analysis: v=2.4 cv=X6jHu2Te c=1 sm=1 tr=0 ts=6aa3f79f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=p8fm3qIaiwJ8G5vN5j0A:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE3NyBTYWx0ZWRfX7iYe5emExe35
 mTY/CDyYIgg+XKJdThwuChijZV/upynkSQW+tvpL1lFbzNjLfkdOmltEhnVsVaGbFvTQRoOm+Li
 esvIGi/3YyrPoskfP98TKVYdf2ecJkE=
X-Proofpoint-ORIG-GUID: vDiVX9azTzagkj--9Lwf3wwqu9npLQq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110177
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

On Thu, Sep 10, 2026 at 08:47:23AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> > From: Naman S Thaker <namathak@qti.qualcomm.com>
> > 
> > On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
> 
> *why* is this the case. The code you replaces adds some ifdefs around
> request_irq() with 0 as flags. This does not make it run has hardirq.
You are right, the statement is incorrect, i will update the commit msg.
On RT kernel, the dpu_core_irq() runs in threaded context by default.
This behavior is changed in the commit by calling devm_request_threaded_irq with
IRQ_ONESHOT flag only for RT kernel using the ifdefs.

The irq is now split into two parts for RT,
1: primary handler which does not use sleeping locks, and
2: secondary threaded handler which can use sleepable locks.
For normal kernels, the request_irq() with 0 flag is still used as-is.

 
> > but it dispatches per-encoder callbacks that take sleepable locks
> > (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> > through vblank/CRC/writeback handling are sleepable as well). Sleeping
> > inside a hardirq handler is not allowed and eventually crashes the
> > display, which is what happens after running GLMark2 for a while.
> 
> That is correct. That is the irq handler are threaded by default and
> only non-threaded if explicitly requested.
> 
> I suggest to stick with non-threaded by default.
> There is only one request_threaded_irq() as far as I can tell and this
> msm_dp_display_request_irq():
> 
> |         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> |                                        msm_dp_display_irq_handler,
> |                                        msm_dp_display_irq_thread,
> |                                        IRQ_TYPE_LEVEL_HIGH,
> |                                        "dp_display_isr", dp);
> 
> and its primary handler will be threaded on PREEMPT_RT, too. So you end
> up with two threads here.
You are correct about the primary handler in msm_dp_display_request_irq() being threaded.
But the request_threaded_irq function in msm_dp_display_request_irq() is not modified in this commit.
The issue fixed by the current commit relates to msm_mdss_irq crash stack below.

[  152.108462] Call trace:
[  152.108465]  show_stack+0x18/0x30 (C)
[  152.108477]  dump_stack_lvl+0x60/0x80
[  152.108484]  dump_stack+0x18/0x24
[  152.108489]  __report_bad_irq+0x4c/0xec
[  152.108496]  note_interrupt+0x340/0x394
[  152.108502]  handle_irq_event+0x94/0xa0
[  152.108508]  handle_level_irq+0xd8/0x16c
[  152.108513]  handle_irq_desc+0x34/0x5c
[  152.108518]  generic_handle_domain_irq+0x1c/0x28
[  152.108522]  msm_mdss_irq+0x68/0x144 [msm]
[  152.108654]  handle_irq_desc+0x34/0x5c
[  152.108660]  generic_handle_domain_irq+0x1c/0x28
[  152.108664]  gic_handle_irq+0x4c/0x140
[  152.108669]  call_on_irq_stack+0x30/0x48
[  152.108673]  do_interrupt_handler+0x80/0x84
[  152.108678]  el1_interrupt+0x38/0x58
[  152.108685]  el1h_64_irq_handler+0x18/0x24
[  152.108690]  el1h_64_irq+0x70/0x74
[  152.108694]  __schedule+0x6c/0xc9c (P)
[  152.108701]  schedule_idle+0x20/0x40
[  152.108705]  do_idle+0x17c/0x2c0
[  152.108710]  cpu_startup_entry+0x38/0x40
[  152.108714]  rest_init+0xd8/0xe0
[  152.108719]  console_on_rootfs+0x0/0x6c
[  152.108726]  __primary_switched+0x88/0x90
[  152.108732] handlers:
[  152.108734] [<000000000cabe59c>] irq_default_primary_handler threaded [<00000000779fd542>] msm_irq [msm]
[  152.108859] Disabling IRQ #246

> Sebastian
