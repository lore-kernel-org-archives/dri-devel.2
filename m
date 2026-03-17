Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE64FED9E0
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E9E10E6B2;
	Tue, 17 Mar 2026 15:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e+b1Uv+V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ci8Z+HlO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FBE10E5B4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:16:16 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H9IRjc3101961
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4Qx75OcTdKKbO2u0Tb+ZEYBltpkIMr0354q5+lyHzwk=; b=e+b1Uv+VJzl39APO
 dfA8aRZx9R2OGadJOI+K1Q1ph1oSzaojd6BX7Ld7YDS+ZK9ZIjKh3Bcp6FBqCjD2
 xSQOMZiekl6cE+sjybk9NhHt1Qc8V/DhVd/+ApT842CY9J6At/cYnWZaz7tohD9r
 19efcOJGgvUXzM1bzHpOFZkBB0BtzwuvfDQeamuziiTzxZhsUjhSpX5bI2g5teKx
 sgp4TQgWLFCOj3PYSWK9Vp/m4dImU6zUCzeVY0247bob3FXSrjKXQhWinUMpXbYD
 qvvgDpqk5TztJqGH+fFt7+zQ5JF/YBqLpxQjLk9f+i8lHKw4SFfAygPX7ArIwjVW
 Czpg5Q==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxnb7cccn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:16:15 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-67ba64650d9so101395011eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773760575; x=1774365375;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Qx75OcTdKKbO2u0Tb+ZEYBltpkIMr0354q5+lyHzwk=;
 b=ci8Z+HlOsHE4O/3sxsJJTgMTyy4CZVyU42uxJ58ulIcaFwp/eeBhgw4NphebZr9EB8
 uNECtxDZJLVzjqIl0MvqAAUnMme3lisqJeFM3qL14Y0FewJn9PAtdQyFTO62Zngxn1PY
 peAcbiQ2YVvFClDnZEofWBa/gS/nJ4/Dfv3Tq0OU0NAGCushLGquJlktJ69sJvs21wXE
 LPwAOGoI+e/94MwJSckqTOA9iQLTMLwHEFTpWLw0GFL6PlgN08jLiQ58ycLmfLICl445
 NMDiAV5pXwvef+fq3XvJ1wvktGBhZ66A1wHxi691tPbkUPGi6FAC4c/KMXfQWRfVPRfV
 pZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773760575; x=1774365375;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Qx75OcTdKKbO2u0Tb+ZEYBltpkIMr0354q5+lyHzwk=;
 b=gqTQcfHlucViSeHZ7jLcE0euAwNtgUxhxFeS11p+z5O6wpO9/KSB3zXgU2yv5YyoK3
 b+j2B6NtmailTKMyjsU4ktty3eZ4O6Cq5tOzC8BxoGTL+yw4n2lJAWluAddCwfRCrfSx
 MncIav2k7XAXEEEEeN6qS7nwlcfhPx1E7h4+9HZlxTELQtEOiDFex8d1DKnc+C7MG6+R
 O2S4N5MbnEsg2x+pd56fMybXi3/vlhDu5toGxh9sNsr/ahj3adsOI/sr5qsXlSxvlfre
 EesaRgYxB22XIk+Z3j9qaX5woiGTHY+vdXIffHY9fmxw0B+hrdctRyEw9CPdfTzr+RH5
 4tcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfuaW51n7vFAKN3wdZupIwX+62OYDH4A98ARD9Gq6dFnde2XCtwa5HoslnpqiRM6mNzpKeWvbdmCY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yysptt9xUjm8K+WxBARM3YeuBZ07Bx+FhdVQnODpz5lYhiGPP6V
 abNmDVzAU7fg3LbUDP8vKhdcfG2B5h75/AH09WVoUv8i6ee3R7r9uR0W1r3NuOJAnMza6ZXzGrm
 hAJh9yJnTl9SeFSq2MOUu0C7G204MLCuHI0B2I7T2eG4vlq4d3bm5uLVv/n2o/gwdskkLZNq8KX
 uPymY=
X-Gm-Gg: ATEYQzzxxuwr09RDQHy3Xy6vzi9PBJIwb2SevLFay6kSvIyykSUy4qInKGcX86RvqUQ
 lnokjZMCOQ2yDxj2Fdn7ZtmXvjXesF/HX3qHsf2Ajpxmj7+HZGOO8xFSWRzjutxF5rdCO4uBy0R
 s0riRnFb0IT1by2K3SKmOOyKSStYsmBxN0gx8+h6+VrA8twk8ZusqxAPU2MIMlrDW1HX9rkYdxE
 10KUUs0sFdogV5ZbyUeqgXYmDmRt0GpPEECCZVeI4JU5R5tZqKo98+bg7Xf8R0tlfdLiDfEZoBd
 3zPaGqe4QgPJoTbVzwvVBqyNc9kqN0eGGRua3ocTwpcC7D5rVASfSfHlzYV3tyN1j1cdqJ6cK4k
 w55G6M9TWR0D3iNXZtZL6YLgmkdOUW5IOZenpsJR7QWIWUvULjTTWcHy04wbSkYyqbm7PIOle+y
 H/hqmSl8lRIkedQcVxBQizUo6kbOueHDeaZM8=
X-Received: by 2002:a05:6820:468b:b0:67b:bf87:739f with SMTP id
 006d021491bc7-67bdaa7e5a6mr10382342eaf.65.1773760574584; 
 Tue, 17 Mar 2026 08:16:14 -0700 (PDT)
X-Received: by 2002:a05:6820:468b:b0:67b:bf87:739f with SMTP id
 006d021491bc7-67bdaa7e5a6mr10382310eaf.65.1773760574041; 
 Tue, 17 Mar 2026 08:16:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15636668dsm4186512e87.70.2026.03.17.08.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:16:12 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:16:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
 yuanjiey <yuanjie.yang@oss.qualcomm.com>, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, krzysztof.kozlowski@linaro.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tingwei.zhang@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
 yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 1/2] drm/msm/dpu: fix mismatch between power and frequency
Message-ID: <necpphuujv4cyc33sf6eaaamh2hnub2poch7rjgvxzu6id62zw@rxotgr3rtbsb>
References: <CAO9ioeVrQ_TfU5-auxNHG=dL8VmeWtBaC_NE09UECodkYrFv-w@mail.gmail.com>
 <aWSv+kVV3G18I/NJ@yuanjiey.ap.qualcomm.com>
 <e5ebc660-e30e-4fcd-ace6-5a6c889e9a8a@oss.qualcomm.com>
 <4g6fyehdc3fejx3pzeysmghigazfei3jz2vmnvxrnqkkbtbxdb@bdlcddxlvbhl>
 <cb22367a-678c-431f-9f52-33663f4af9d7@oss.qualcomm.com>
 <jr4h4sx42dbxpknm5nkgj7ydpkivm4nglfz7ui4bjpom7wf6ub@spqb27d3ov2z>
 <DGSDE0ID17DQ.XQZNKZH5UKPO@fairphone.com>
 <g3dclilgoee6a2dyfqdvk67asjb4ptur5nc52iqqeqpiiourpv@46xstae5zsy3>
 <DH4WJ5KZ39MS.AHLMLFB8E0JW@fairphone.com>
 <3e5f80a6-d9bc-46ee-89ca-b1b2ba744493@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e5f80a6-d9bc-46ee-89ca-b1b2ba744493@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzNCBTYWx0ZWRfX3sZMbx1loFjZ
 s3Hjrb/7UL7LOO595gklWe76jOiqHBk2zCYS/ttoa+I9MzPAxYMlYb5e9JhP9cuT6IwlX3XBOIQ
 mzJP2y7x+FzMKDNQ8cEjZtLri9IvW6/3Rzz7ZvzRzWqcj4Aam+VNQph/aiVAjWLdnTv0iqHAjsX
 KhDb8Khfgyx4odnECgI25EglaoyucFyAPWoqeaqUuqrOWO6qZ/Eise4gBZ06wHol3zRXykLDPWH
 IuQSLQ9L25AncOWKGnI4sidrn2Rik0nm4FB3kUvxaj9s9KRQjhq7hUMDboQVzKy17fl88QgTlaQ
 dGZvJkorNcnE1DpxLMxFN+n8W2yuQWnTgVHtrbV8ZUtGoJSKYAZ1g9HJ6nPv9GVrEoG/dA3qx0y
 cpJ5loubOV7qyhlSKlDv6L9FVNanW7YGIbYfV1l8n1wSp+SvLtONPElma1SVQqqekgtAuj44lkT
 DcZctcAlSoMAjRkMleA==
X-Authority-Analysis: v=2.4 cv=D7pK6/Rj c=1 sm=1 tr=0 ts=69b9703f cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Lq8GIy_tig5i-ImUSOUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: ujfpHZR-5ky3bVXxaI_uxhWbflU8o1TH
X-Proofpoint-GUID: ujfpHZR-5ky3bVXxaI_uxhWbflU8o1TH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_02,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170134
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

On Tue, Mar 17, 2026 at 09:59:28AM +0100, Konrad Dybcio wrote:
> On 3/17/26 9:07 AM, Luca Weiss wrote:
> > On Mon Mar 2, 2026 at 4:17 PM CET, Dmitry Baryshkov wrote:
> >> On Mon, Mar 02, 2026 at 03:35:36PM +0100, Luca Weiss wrote:
> >>> On Fri Feb 27, 2026 at 8:05 PM CET, Dmitry Baryshkov wrote:
> >>>> On Fri, Feb 27, 2026 at 12:34:04PM +0100, Konrad Dybcio wrote:
> >>>>> On 2/27/26 4:48 AM, Dmitry Baryshkov wrote:
> >>>>>> On Thu, Feb 26, 2026 at 02:35:52PM +0100, Konrad Dybcio wrote:
> >>>>>>> On 1/12/26 9:25 AM, yuanjiey wrote:
> >>>>>>>> On Mon, Jan 12, 2026 at 09:38:41AM +0200, Dmitry Baryshkov wrote:
> >>>>>>>>> On Mon, 12 Jan 2026 at 08:23, yuanjiey <yuanjie.yang@oss.qualcomm.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Fri, Jan 09, 2026 at 05:22:37PM +0200, Dmitry Baryshkov wrote:
> >>>>>>>>>>> On Fri, Jan 09, 2026 at 04:38:07PM +0800, yuanjie yang wrote:
> >>>>>>>>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>> Please correct me if I'm wrong, if we drop dev_pm_opp_set() from
> >>>>>> dpu_runtime_suspend, then we should be able to also skip setting OPP
> >>>>>> corner in dpu_runtime_resume(), because the previously set corner should
> >>>>>> be viable until drm/msm driver commits new state / new modes.
> >>>>>
> >>>>> That matches my understanding.
> >>>>>
> >>>>>> The only important issue is to set the corner before starting up the
> >>>>>> DPU, where we already have code to set MDP_CLK to the max frequency.
> >>>>>>
> >>>>>> Which means, we only need to drop the dev_pm_set_rate call from the
> >>>>>> dpu_runtime_suspend().
> >>>>>
> >>>>> I concur.
> >>>>>
> >>>>>>> For MDSS, we're currently generally describing the MDSS_AHB clock, the
> >>>>>>> GCC_AHB clock and the MDP clock (sounds wrong?) - there's not even an OPP
> >>>>>>
> >>>>>> No. As far as I remember, MDP_CLK is necessary to access MDSS registers
> >>>>>> (see commit d2570ee67a47 ("drm/msm/mdss: generate MDSS data for MDP5
> >>>>>> platforms")), I don't remember if accessing HW_REV without MDP_CLK
> >>>>>> resulted in a zero reads or in a crash. At the same time it needs to be
> >>>>>> enabled to any rate, which means that for most of the operations
> >>>>>> msm_mdss.c can rely on DPU keeping the clock up and running.
> >>>>>>
> >>>>>>> table.. The GCC clock is sourced from (and scaled by) the NoC, but the
> >>>>>>> MDSS_AHB one seems to have 3 actually configurable performance points
> >>>>>>> that neither we nor seemingly the downstream driver seem to really care
> >>>>>>> about (i.e. both just treat it as on/off). If we need to scale it, we
> >>>>>>> should add an OPP table, if we don't, we should at least add required-opps.
> >>>>>>
> >>>>>> I think, dispcc already has a minimal vote on the MMCX, which fulfill
> >>>>>> these needs.
> >>>>>
> >>>>> I have slightly mixed feelings, but I suppose that as we accepted Commit
> >>>>> e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain"),
> >>>>> we can generally agree that it makes sense that calling genpd->on() actually
> >>>>> turns on the power indeed
> >>>>>
> >>>>> What I'm worried about is if the clock is pre-configured to run at a high
> >>>>> frequency from the bootloader (prepare_enable only sets the EN bit in the RCG,
> >>>>> and doesn't impact the state of M/N/D at a glance), we may get a brownout
> >>>>>
> >>>>> This rings the "downstream really did it better with putting clock dvfs states
> >>>>> into the clk driver" bell, but I suppose the way to fight this would be to
> >>>>> simply set_rate(fmax) there too..
> >>>>>
> >>>>> I attempted an experiment with pulling out the plug. MMCX enabled with the
> >>>>> AHB clock off results in a read-as-zero. I tried really hard to disable the
> >>>>> mdp clock, but it seems like the "shared_ops" reflect some sort of "you
> >>>>> *really* can't just disable it" type behavior (verified with debugcc)
> >>>>
> >>>> I think, in 8996 it was possible to disable it. Not sure about
> >>>> 8998/630/660.
> >>>>
> >>>>>
> >>>>>
> >>>>> There's a possible race condition if we don't do it:
> >>>>>
> >>>>> ------- bootloader --------
> >>>>> configure display, mdp_clk=turbo
> >>>>> ------- linux -------------
> >>>>> load rpmhpd     |
> >>>>> load venus      |
> >>>>> set mmcx=lowsvs | mdp_clk is @ turbo
> >>>>>                 | brownout
> >>>>>                 | 
> >>>>>                 | <mdss would only probe here>
> >>>>>
> >>>>> *but* that should be made impossible because of .sync_state().
> >>>>
> >>>> Yep, sync_state should prevent MMCX or CX from dropping under the boot
> >>>> level.
> >>>>
> >>>>>
> >>>>> This may impact hacky setups like simplefb, but as the name implies,
> >>>>> that's hacky.
> >>>>>
> >>>>> Relying on .sync_state() however will not cover the case if the mdss
> >>>>> module is removed and re-inserted later, possibly with mmcx disabled
> >>>>> entirely but the clock not parked at a sufficiently low rate.
> >>>>>
> >>>>>
> >>>>> TLDR: reassess whether MDSS needs the MDP clock, if so, we should just
> >>>>> plug the MDP opp table into it and set_rate(fmax) during mdss init
> >>>>
> >>>> And what will drop it afterwards? MDSS will still vote on the MMCX / CX
> >>>> level even though DPU will change the clock freq.
> >>>>
> >>>>>
> >>>>>>> The MDP4/MDP5 drivers are probably wrong too in this regard, but many
> >>>>>>> targets supported by these may not even have OPP tables and are generally
> >>>>>>> not super high priority for spending time on.. that can, I'd kick down the
> >>>>>>> road unless someone really wants to step up
> >>>>>>
> >>>>>> I'd really not bother with those two drivers, unless we start seing
> >>>>>> crashes. For MDP4 platforms we don't implement power domains at all, no
> >>>>>> interconnects, etc., which means that the system will never go to a
> >>>>>> lower power state.
> >>>>>
> >>>>> Right. Might be that 2030-something arrives and armv7 is gone before someone
> >>>>> randomly decides to work on that!
> >>>>>
> >>>>>> MDP5 platforms mostly don't have OPP tables. (I'm not counting MSM8998 /
> >>>>>> SDM630 / SDM660 here). MSM8917 / MSM8937 have only DSI tables, MSM8976
> >>>>>> has both MDP and DSI tables (my favourite MSM8996 has none). Probably we
> >>>>>> should start there by adding missing bits adding corresponding
> >>>>>> dev_pm_set_rate() calls as required (as demostrated by the DPU driver).
> >>>>>
> >>>>> A bit off-topic, but:
> >>>>>
> >>>>> drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> >>>>>
> >>>>> 96 is in DPU. any other candidates that should be moved over?
> >>>>
> >>>> Let's go through them.
> >>>>
> >>>> All SoC except those currently supported in DPU require SMP (shared
> >>>> memory pool) support to be ported from the MDP5 driver.
> >>>>
> >>>> Most of the remaining platforms (except MSM8994/92) also had HW cursor
> >>>> implemented in a fancy way, in the LM rather than in a separate pipe.
> >>>> I'd really like to postpone those, possibly first completing migration
> >>>> of the other platforms and dropping support for them from MDP5.
> >>>>
> >>>> 1.0  - old MSM8974
> >>>>        I'd rather not touch it, it had bugs and I don't have HW
> >>>> 1.1  - MSM8x26
> >>>>        Probably Luca can better comment on it. Should be doable, but I
> >>>>        don't see upstream devices using display on it.
> >>>
> >>> I have at least two MSM8x26 (1x APQ8026 lg-lenok & 1x MSM8926 htc-memul)
> >>> devices working with MDP5 fine. I should've probably upstreamed panel
> >>> driver & dts but they haven't been high priority..
> >>
> >> I think I have been saying this: having a panel & dsi enabled in DT is
> >> the only way for me to know that the display is working on this
> >> platform. I'd really kindly ask you and other activists to get at least
> >> some panel drivers and corresponding DT bits upstream. It is really an
> >> important flag for me.
> >>
> >> I can propose some kind of bounty for those getting MDSS+panel supported
> >> in Qcom DT. (Beer at the next conf we meet? Some stickers for the
> >> laptops and phones? Mämmi?)
> > 
> > Hm I realized yesterday (through trying it), that also MDSS is broken
> > since the no-IOMMU codepath was removed from drm/msm. I thought this was
> > only affecting GPU but it's also affecting MDSS/MDP5 :(
> > 
> > So I guess no panel enablement anytime soon until the IOMMU situation is
> > sorted out, for both 8226 and 8974...
> 
> If you're sure the panel drivers are good (e.g. they worked on 6.whatever
> prior to drm/msm saying sayonara to carveout), I think no one would object
> to have them merged separately, so that you don't have to wait until
> who-knows-when and keep rebasing them by hand

+1. Please submit them and cc me so that I don't miss those.

-- 
With best wishes
Dmitry
