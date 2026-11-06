Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7B606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AbJ9Wy+B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeWDA7AC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926A010E1F9;
	Fri,  6 Nov 2026 08:09:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F18010E1E5
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:09:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RQJ52933687
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 08:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3FN098lze/WreTU28PCuTM35
 o6JS53fRURS5tMMldcw=; b=AbJ9Wy+BGWSUUH9wM7T+vApfarg2d5aL2VfAHDWj
 GhUMKfrdKJ86TPGiMyH04IssKqbRH94JUhqG3Dw3RLpQdIi5mrg3/TKtjcR7YIkv
 76n2JttdfT4dE3IY6H1CeBA5znPQQH1w+HV8O2TMvmV3QM8I19301b8J3Svf/Jg8
 Zt2XDBTOqJhy4CYjdnMaqwjaea9pJXcUclsD71pOcHnJXeWOxN14faTP2Xw6E2dR
 sqS2I9k0CrzYh0Fq04HwIsNi8znH0/OHcPAzoqchi2oBCVaArDIfVufgsO0vqI8y
 JbqhazuSXwZC51WG1VA4lHvCO2DQAJL+AqRsMixPQZ2YUQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa1sjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 08:09:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8812a952ef9so3555b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 00:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793952542; x=1794557342;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
 b=NeWDA7AC49+RGSnwJwki9IEGfnUf3Go8D2dJg/+lMCH9mMzhpM0BWiW2kVTgaHEn6S
 rlG5nrbQwT4uUSmGh0fDvact0icRcKPTX+n20ELb5Nn6Rv14oz/8mUrTAlDdaEymg42t
 VLu5ZJk8D7aF2TkRIwQPpi50SihQW7qD4oH9F18t3hW6014uH7VwUOkT2cjDBxtOrbG8
 ycGHHg++JVJ6Txkp+JYyvVrrUQV/uZN+F90ZjiekijrX4RuxT5z6Htx9wUca2hKasWbW
 diXq803LoSCmQfaFHaV+szTJaQPg4nHhtujydtjxoVoHK6lWfKTGb5ITz5Wrv/OarT0L
 R9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793952542; x=1794557342;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
 b=nW698Nwt295IFFbhPOd8lP2eyYmd68p5P/8xJEltzNQKQJz8qjGL5riciDTEIxD/Js
 ZLpOQUQeUfOKxk9nkdJ/PxT8oxrGsP3i1avAoyZnf82Hvx7NePnrwdGB87MGwQAlhhoA
 AQd/0nDPpJB/jY1LtzLiSrcsI6q6rmZN/JYMMZA2U3EvWQY2ikVSe4CbDsL3cGA3CK0+
 TbQhF1nOAzNfAvtpMlnWdWYvPe03Qi2rfElN2z0Wm7UlMc1QvNeT4OFHtJxF2eZOlJRz
 LpxZWvEi63H+zpqiYAcxaRjXDiqK4+/qGR5tPBdBNhiQRaS8MKw7L3g73RLKb05lynos
 JgXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6NByAQHi80H9c7Z1C7lBbyC4bfjl8y7bMDqSNn5D7Z2+4LyxC4Gmzd9s+aPBkRhb5yMV5foGyQ2Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/sq/CljvzNXULZ9MrSmgORmfE4H6svWm5rrxJwYqQ/uVugDpIE
 BQY39244VAb2NQsK7hO4nFhvPr1W0f25iiHgYkZO1cYe8AE9M2i6C2bn4HawXbvfKpCfNlNouNT
 5eWi70QdGGJH/bGJSfsEoEhI7xzmyomuq0gmIV89tbEDXjwC/mtgz4fW4IcVAmzVvvOXncbI=
X-Gm-Gg: AYBFou2W4sZ3aOpSGj+3V6BMqldePLgHxlRZn3j6hl42vXcQvsHf4b4mzO/rtJqvOTi
 TCWS20xCVwqkAQ89uMv5Uo7fU/Osm5V/ikE49phrgNSv5iMeQX0dnU6TEEJUnBUwbNMym3WYFXH
 Y25hjCzjQqnGD8yzP9qcchilDVSjv6hxnGZ3MvLPdnS3dVCmAayfnwqoB2cpoPT63/BIuuuJU0S
 9ybwr+EZwPSuouLnlC766UuhPuP6rvPqeOptqolwwijPQtnEkijeJIDwyFB9U5H2WMPU1oKGnhC
 ZaNUho8txrgla21QdCxFIiGWtYig31bRC27rgCZ9C0sVMmkbOclgixiYZtdlg1wFjeo+hRk+42C
 NfNpYjolKSGVsD8KPhxp2RpButUDagle+BWxRurVAU9DaYNWuFTBdODkYlEm3+ZaBi3PyIXFw7g
 0srDw00gUYUut81sM6dp6KpHfD/RTJ/FE+eU7vgPhntPGCWbTELMatFw/I0YCNna1NlrJWe9vI1
 tLbv0H85Js5P/ZoZAny7M0/YrOP
X-Received: by 2002:a05:6a00:890d:b0:8a0:646e:7e16 with SMTP id
 d2e1a72fcca58-8b37bc5ead6mr1669820b3a.2.1793952541857; 
 Fri, 06 Nov 2026 00:09:01 -0800 (PST)
X-Received: by 2002:a05:6a00:890d:b0:8a0:646e:7e16 with SMTP id
 d2e1a72fcca58-8b37bc5ead6mr1669777b3a.2.1793952541282; 
 Fri, 06 Nov 2026 00:09:01 -0800 (PST)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b35921dc8bsm375950b3a.10.2026.11.06.00.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 00:09:00 -0800 (PST)
Date: Fri, 6 Nov 2026 13:38:50 +0530
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
Message-ID: <au2LEsJjuOgKit1j@hu-vishsain-blr.qualcomm.com>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
 <20260910064723.pbZP3vic@linutronix.de>
 <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
 <20260915073614.nvT9zW3S@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915073614.nvT9zW3S@linutronix.de>
X-Proofpoint-GUID: u7gldpOUSswKmtGK_i3uQdFkJN7Sq_h3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfX7R73v5gIMf1x
 eVG2dVgdlC7d8izmDxlubCnDrf6f8rXKMHWALR1gHNWwNbOc0S/EfiJ+bw/Wd+8OjhIy7w6Xqpv
 Q9W96cK8wDM1mHgpYr3wXIPcuzMCwvC8qql8488KSxerISUh6vVSK+/EIuy5/4W/UnUrodX+oZI
 BMzqqv0JDIf9iRuzE75K8wfQXE9XXNks6G20r3ss6yEdA41iqn6/moSyRJvulRBlqh+KHNyIcOO
 w3rtnGiq6tN9XdK60Z7G/bfKDg2wgw01xTnXrhWVD5hQsCqE8z6pRP0oZ3q3Mux831o3WY10TBO
 E0rHEvK7iO10Spfb60jCBNTvPWCYl3emTSrwWCFdNbnec/sUHeVoj4GL28JFhrATZMLdJKZMCiu
 wp/ClGGSz24DxdDVbDOF/38xPGJLaqEoKlK8mjoWAAppoXSgT0Va7o632h1XQ72v4WTBs7eDeli
 wHRYXtY9x3guTXwJS7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfX/77xvpQUDIp/
 BlVPj4LGK76MNqNOi23oofwFNoUrOHnwJPIP6nrsS/2AoTiUBzm6EbOF6pwINFKmNUAP9sOSJtS
 +xPNKudng3IIFbdjZu6Uwjo3qeD29kQ=
X-Proofpoint-ORIG-GUID: u7gldpOUSswKmtGK_i3uQdFkJN7Sq_h3
X-Authority-Analysis: v=2.4 cv=CaKdd7rl c=1 sm=1 tr=0 ts=6aed8b1e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ZNqZZCZIVyXZx7ky4tIA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060032
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 15, 2026 at 09:36:14AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-11 18:14:04 [+0530], Vishnu Saini wrote:
> > On Thu, Sep 10, 2026 at 08:47:23AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> > > > From: Naman S Thaker <namathak@qti.qualcomm.com>
> > > > 
> > > > On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
> > > 
> > > *why* is this the case. The code you replaces adds some ifdefs around
> > > request_irq() with 0 as flags. This does not make it run has hardirq.
> > You are right, the statement is incorrect, i will update the commit msg.
> > On RT kernel, the dpu_core_irq() runs in threaded context by default.
> > This behavior is changed in the commit by calling devm_request_threaded_irq with
> > IRQ_ONESHOT flag only for RT kernel using the ifdefs.
> 
> The why would be interesting. Usually things stay threaded to avoid
> locking issues down the road.
> > The irq is now split into two parts for RT,
> > 1: primary handler which does not use sleeping locks, and
> > 2: secondary threaded handler which can use sleepable locks.
> > For normal kernels, the request_irq() with 0 flag is still used as-is.
> 
> If the split is properly done for RT, the non-RT variant should be able
> to use the same without any ifdefs.
> >  
> > > > but it dispatches per-encoder callbacks that take sleepable locks
> > > > (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> > > > through vblank/CRC/writeback handling are sleepable as well). Sleeping
> > > > inside a hardirq handler is not allowed and eventually crashes the
> > > > display, which is what happens after running GLMark2 for a while.
> > > 
> > > That is correct. That is the irq handler are threaded by default and
> > > only non-threaded if explicitly requested.
> > > 
> > > I suggest to stick with non-threaded by default.
> > > There is only one request_threaded_irq() as far as I can tell and this
> > > msm_dp_display_request_irq():
> > > 
> > > |         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> > > |                                        msm_dp_display_irq_handler,
> > > |                                        msm_dp_display_irq_thread,
> > > |                                        IRQ_TYPE_LEVEL_HIGH,
> > > |                                        "dp_display_isr", dp);
> > > 
> > > and its primary handler will be threaded on PREEMPT_RT, too. So you end
> > > up with two threads here.
> > You are correct about the primary handler in msm_dp_display_request_irq() being threaded.
> > But the request_threaded_irq function in msm_dp_display_request_irq() is not modified in this commit.
> > The issue fixed by the current commit relates to msm_mdss_irq crash stack below.
> 
> Why is it the way it is? What is the issue in the stack trace below?
> This is not described, is it? Your cleared the top of the report.
> Now, msm_dp_display_irq_handler() ors the return value which is wrong.
> You can't return IRQ_WAKE_THREAD | IRQ_HANDLED and expect the thread is
> woken up. It appears the handler is fires over and over which implies
> that something is wrong with your primary handler.
> 
> The way this is requested you supposed to have threaded handler and a
> secondary-threaded handler. While msm_dp_display_irq_handler() is
> invoked as threaded the IRQ chip masks the interrupt source. If it
> returns IRQ_WAKE_THREAD it supposed to mask the interrupt source because
> the IRQ-chip unmasks the interrupt while the secondary-threaded handler
> is run. It seems this does not work as intended.

Thank you for the inputs, we are further debugging this issue. The crash accur because of
increased unhandled IRQs on RT kernel, will share update once we have root cause of
increased unhandled IRQs.
> > [  152.108462] Call trace:
> > [  152.108465]  show_stack+0x18/0x30 (C)
> > [  152.108477]  dump_stack_lvl+0x60/0x80
> > [  152.108484]  dump_stack+0x18/0x24
> > [  152.108489]  __report_bad_irq+0x4c/0xec
> > [  152.108496]  note_interrupt+0x340/0x394
> > [  152.108502]  handle_irq_event+0x94/0xa0
> > [  152.108508]  handle_level_irq+0xd8/0x16c
> > [  152.108513]  handle_irq_desc+0x34/0x5c
> > [  152.108518]  generic_handle_domain_irq+0x1c/0x28
> > [  152.108522]  msm_mdss_irq+0x68/0x144 [msm]
> > [  152.108654]  handle_irq_desc+0x34/0x5c
> > [  152.108660]  generic_handle_domain_irq+0x1c/0x28
> > [  152.108664]  gic_handle_irq+0x4c/0x140
> > [  152.108669]  call_on_irq_stack+0x30/0x48
> > [  152.108673]  do_interrupt_handler+0x80/0x84
> > [  152.108678]  el1_interrupt+0x38/0x58
> > [  152.108685]  el1h_64_irq_handler+0x18/0x24
> > [  152.108690]  el1h_64_irq+0x70/0x74
> > [  152.108694]  __schedule+0x6c/0xc9c (P)
> > [  152.108701]  schedule_idle+0x20/0x40
> > [  152.108705]  do_idle+0x17c/0x2c0
> > [  152.108710]  cpu_startup_entry+0x38/0x40
> > [  152.108714]  rest_init+0xd8/0xe0
> > [  152.108719]  console_on_rootfs+0x0/0x6c
> > [  152.108726]  __primary_switched+0x88/0x90
> > [  152.108732] handlers:
> > [  152.108734] [<000000000cabe59c>] irq_default_primary_handler threaded [<00000000779fd542>] msm_irq [msm]
> > [  152.108859] Disabling IRQ #246
> 
> Sebastian
