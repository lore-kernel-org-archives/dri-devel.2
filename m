Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF354FED9E0
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2030210E5B6;
	Tue, 17 Mar 2026 15:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="i8NtgZ/Y";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547F510E648
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:18:17 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b97e5956208so77555866b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773760696; x=1774365496; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLOIoVOvc3ULrd60PWM378GR2y4L4v7j9eb4/ygVlt8=;
 b=i8NtgZ/YoqJFe/ZU0nZys1MvmIRqdLUkw0zErawWDVTssyRUekf3yTVf9m4Nyc7ehW
 W+Xm3ry0yc1Z/c4V5Pap14ByiC0X/hGCdeVIdI0fsZKCrtmKUoUvFSd9Kgl9deYtWo2B
 VVBOS29iCEUOoHtLYXOvXdJ92XGx+RQfqiuFG5rCgwDX3kO4X0Wkq0lYnBcyQsXNCvE3
 5zTPXwkignUfmrAZuBBnwJZP62jK6P55r48UjpvB7QANSfZ7QY71rCjsxY4pE4N6s/xc
 EVhRjj60gcfETNo1dYruuaieFBQ62GRQVZTNJXKG0OxARyTm6m1C+aGzgHOL9bfd/R1x
 qyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773760696; x=1774365496;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tLOIoVOvc3ULrd60PWM378GR2y4L4v7j9eb4/ygVlt8=;
 b=iicuId6Pjb3R2tmwvrn+fskDyySpEOue2BL5LK2fG7a46R/+3g4xeXbLBIyTa3BspN
 qjcCMnojA7TQIAWOrJe4U/l9F/8j6MssdUn/D+KEPbF/O/6svEFgnvyoCAutOTk8mNwH
 Mi74aekeLdNZy356I3NaIJkLkoGcbYXh2nN/BR75U/+O/owJWd4li6xhFnSxXRxXWCzb
 vMQCX7lN0CXzOZYc+seevyzB6OUQrZNANNFZARiQEQU46ADv+bpAIxZiHBGJ6Ev5TO1N
 Qupulhxheu/9qeyw4U1Bs8+gueWQX9CNd1rGUs2ICC4B7pQkS+5Ue945yuP7BrLRk06s
 xIAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQiBCFiGE43cp4YswtjsN5nk14FAb5m7oMSHWGgRaExCivIDoJyKblhbvgX8eg9mZIpDDqoj5EnMI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz44EH3ldPdoq6S53IGN4LCrW5vkIOFit33T+b1XTt97kpv1Rnp
 /3HIYZvFLbw3aovycGffUqczjhkWaD/nylLwG6EfQTkRGgIJKPhF7slkoWyiNe4bBUg=
X-Gm-Gg: ATEYQzzN0jlK/FQf8Jv/deS6Apt92qgpJMlp+mdPYL7TUTIq991glyAbRaPJGb6y6hD
 MAivhgzZl7RVmOgOKYL4WSWCysXiDgNJc/VGTng58vNtJh2ri8xZU+oAkCrcGV9zsX6FpUz+Hj0
 BvjvmReubC7zuOZh8BMrS780mgN5DqYILZNoGEyPZpgs6O6hsaZrAQkSIrqpDufKZb1bsXMO5K/
 uNpCb1Gm7iZK9PXtnWyz2Gp3moFqJ29PFnmayGwXdHgXbtX5WlpoMyPhTzJZfBkhHURTeAsmrtz
 emSS1zoqgn2evYUFfDTULKX3aqTEQkIi4mqHJROCgqy9SQweC1aikvNtKkLiV2DJkyEdfBHYcYX
 VBf3JWGpEfyq9P6OW++KqP0qb/2IXo6R9gksyymX0FS4mLoHZnPJrygaUMi9sTmm566+8+JDxjk
 8yefEbtBNSh6t7w+G25TfxnIJbtrcBxTrROw7JTcjhkKkSuKjov/pDdyKZGiA6M5xBscpp
X-Received: by 2002:a17:907:8dcd:b0:b93:c5a9:a5e6 with SMTP id
 a640c23a62f3a-b976507af92mr1026443766b.2.1773760695505; 
 Tue, 17 Mar 2026 08:18:15 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-667aecbcc17sm115389a12.5.2026.03.17.08.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 08:18:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:18:13 +0100
Message-Id: <DH55OTHPTVD0.3CEOFJJRR8A12@fairphone.com>
Cc: "Luca Weiss" <luca.weiss@fairphone.com>, "yuanjiey"
 <yuanjie.yang@oss.qualcomm.com>, <robin.clark@oss.qualcomm.com>,
 <lumag@kernel.org>, <abhinav.kumar@linux.dev>, <jesszhan0024@gmail.com>,
 <sean@poorly.run>, <marijn.suijten@somainline.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <krzysztof.kozlowski@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <tingwei.zhang@oss.qualcomm.com>, <aiqun.yu@oss.qualcomm.com>,
 <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] drm/msm/dpu: fix mismatch between power and frequency
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
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
 <necpphuujv4cyc33sf6eaaamh2hnub2poch7rjgvxzu6id62zw@rxotgr3rtbsb>
In-Reply-To: <necpphuujv4cyc33sf6eaaamh2hnub2poch7rjgvxzu6id62zw@rxotgr3rtbsb>
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

On Tue Mar 17, 2026 at 4:16 PM CET, Dmitry Baryshkov wrote:
> On Tue, Mar 17, 2026 at 09:59:28AM +0100, Konrad Dybcio wrote:
>> On 3/17/26 9:07 AM, Luca Weiss wrote:
>> > On Mon Mar 2, 2026 at 4:17 PM CET, Dmitry Baryshkov wrote:
>> >> On Mon, Mar 02, 2026 at 03:35:36PM +0100, Luca Weiss wrote:
>> >>> On Fri Feb 27, 2026 at 8:05 PM CET, Dmitry Baryshkov wrote:
>> >>>> On Fri, Feb 27, 2026 at 12:34:04PM +0100, Konrad Dybcio wrote:
>> >>>>> On 2/27/26 4:48 AM, Dmitry Baryshkov wrote:
>> >>>>>> On Thu, Feb 26, 2026 at 02:35:52PM +0100, Konrad Dybcio wrote:
>> >>>>>>> On 1/12/26 9:25 AM, yuanjiey wrote:
>> >>>>>>>> On Mon, Jan 12, 2026 at 09:38:41AM +0200, Dmitry Baryshkov wrot=
e:
>> >>>>>>>>> On Mon, 12 Jan 2026 at 08:23, yuanjiey <yuanjie.yang@oss.qualc=
omm.com> wrote:
>> >>>>>>>>>>
>> >>>>>>>>>> On Fri, Jan 09, 2026 at 05:22:37PM +0200, Dmitry Baryshkov wr=
ote:
>> >>>>>>>>>>> On Fri, Jan 09, 2026 at 04:38:07PM +0800, yuanjie yang wrote=
:
>> >>>>>>>>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>> >>>>>
>> >>>>> [...]
>> >>>>>
>> >>>>>> Please correct me if I'm wrong, if we drop dev_pm_opp_set() from
>> >>>>>> dpu_runtime_suspend, then we should be able to also skip setting =
OPP
>> >>>>>> corner in dpu_runtime_resume(), because the previously set corner=
 should
>> >>>>>> be viable until drm/msm driver commits new state / new modes.
>> >>>>>
>> >>>>> That matches my understanding.
>> >>>>>
>> >>>>>> The only important issue is to set the corner before starting up =
the
>> >>>>>> DPU, where we already have code to set MDP_CLK to the max frequen=
cy.
>> >>>>>>
>> >>>>>> Which means, we only need to drop the dev_pm_set_rate call from t=
he
>> >>>>>> dpu_runtime_suspend().
>> >>>>>
>> >>>>> I concur.
>> >>>>>
>> >>>>>>> For MDSS, we're currently generally describing the MDSS_AHB cloc=
k, the
>> >>>>>>> GCC_AHB clock and the MDP clock (sounds wrong?) - there's not ev=
en an OPP
>> >>>>>>
>> >>>>>> No. As far as I remember, MDP_CLK is necessary to access MDSS reg=
isters
>> >>>>>> (see commit d2570ee67a47 ("drm/msm/mdss: generate MDSS data for M=
DP5
>> >>>>>> platforms")), I don't remember if accessing HW_REV without MDP_CL=
K
>> >>>>>> resulted in a zero reads or in a crash. At the same time it needs=
 to be
>> >>>>>> enabled to any rate, which means that for most of the operations
>> >>>>>> msm_mdss.c can rely on DPU keeping the clock up and running.
>> >>>>>>
>> >>>>>>> table.. The GCC clock is sourced from (and scaled by) the NoC, b=
ut the
>> >>>>>>> MDSS_AHB one seems to have 3 actually configurable performance p=
oints
>> >>>>>>> that neither we nor seemingly the downstream driver seem to real=
ly care
>> >>>>>>> about (i.e. both just treat it as on/off). If we need to scale i=
t, we
>> >>>>>>> should add an OPP table, if we don't, we should at least add req=
uired-opps.
>> >>>>>>
>> >>>>>> I think, dispcc already has a minimal vote on the MMCX, which ful=
fill
>> >>>>>> these needs.
>> >>>>>
>> >>>>> I have slightly mixed feelings, but I suppose that as we accepted =
Commit
>> >>>>> e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable th=
e domain"),
>> >>>>> we can generally agree that it makes sense that calling genpd->on(=
) actually
>> >>>>> turns on the power indeed
>> >>>>>
>> >>>>> What I'm worried about is if the clock is pre-configured to run at=
 a high
>> >>>>> frequency from the bootloader (prepare_enable only sets the EN bit=
 in the RCG,
>> >>>>> and doesn't impact the state of M/N/D at a glance), we may get a b=
rownout
>> >>>>>
>> >>>>> This rings the "downstream really did it better with putting clock=
 dvfs states
>> >>>>> into the clk driver" bell, but I suppose the way to fight this wou=
ld be to
>> >>>>> simply set_rate(fmax) there too..
>> >>>>>
>> >>>>> I attempted an experiment with pulling out the plug. MMCX enabled =
with the
>> >>>>> AHB clock off results in a read-as-zero. I tried really hard to di=
sable the
>> >>>>> mdp clock, but it seems like the "shared_ops" reflect some sort of=
 "you
>> >>>>> *really* can't just disable it" type behavior (verified with debug=
cc)
>> >>>>
>> >>>> I think, in 8996 it was possible to disable it. Not sure about
>> >>>> 8998/630/660.
>> >>>>
>> >>>>>
>> >>>>>
>> >>>>> There's a possible race condition if we don't do it:
>> >>>>>
>> >>>>> ------- bootloader --------
>> >>>>> configure display, mdp_clk=3Dturbo
>> >>>>> ------- linux -------------
>> >>>>> load rpmhpd     |
>> >>>>> load venus      |
>> >>>>> set mmcx=3Dlowsvs | mdp_clk is @ turbo
>> >>>>>                 | brownout
>> >>>>>                 |=20
>> >>>>>                 | <mdss would only probe here>
>> >>>>>
>> >>>>> *but* that should be made impossible because of .sync_state().
>> >>>>
>> >>>> Yep, sync_state should prevent MMCX or CX from dropping under the b=
oot
>> >>>> level.
>> >>>>
>> >>>>>
>> >>>>> This may impact hacky setups like simplefb, but as the name implie=
s,
>> >>>>> that's hacky.
>> >>>>>
>> >>>>> Relying on .sync_state() however will not cover the case if the md=
ss
>> >>>>> module is removed and re-inserted later, possibly with mmcx disabl=
ed
>> >>>>> entirely but the clock not parked at a sufficiently low rate.
>> >>>>>
>> >>>>>
>> >>>>> TLDR: reassess whether MDSS needs the MDP clock, if so, we should =
just
>> >>>>> plug the MDP opp table into it and set_rate(fmax) during mdss init
>> >>>>
>> >>>> And what will drop it afterwards? MDSS will still vote on the MMCX =
/ CX
>> >>>> level even though DPU will change the clock freq.
>> >>>>
>> >>>>>
>> >>>>>>> The MDP4/MDP5 drivers are probably wrong too in this regard, but=
 many
>> >>>>>>> targets supported by these may not even have OPP tables and are =
generally
>> >>>>>>> not super high priority for spending time on.. that can, I'd kic=
k down the
>> >>>>>>> road unless someone really wants to step up
>> >>>>>>
>> >>>>>> I'd really not bother with those two drivers, unless we start sei=
ng
>> >>>>>> crashes. For MDP4 platforms we don't implement power domains at a=
ll, no
>> >>>>>> interconnects, etc., which means that the system will never go to=
 a
>> >>>>>> lower power state.
>> >>>>>
>> >>>>> Right. Might be that 2030-something arrives and armv7 is gone befo=
re someone
>> >>>>> randomly decides to work on that!
>> >>>>>
>> >>>>>> MDP5 platforms mostly don't have OPP tables. (I'm not counting MS=
M8998 /
>> >>>>>> SDM630 / SDM660 here). MSM8917 / MSM8937 have only DSI tables, MS=
M8976
>> >>>>>> has both MDP and DSI tables (my favourite MSM8996 has none). Prob=
ably we
>> >>>>>> should start there by adding missing bits adding corresponding
>> >>>>>> dev_pm_set_rate() calls as required (as demostrated by the DPU dr=
iver).
>> >>>>>
>> >>>>> A bit off-topic, but:
>> >>>>>
>> >>>>> drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
>> >>>>>
>> >>>>> 96 is in DPU. any other candidates that should be moved over?
>> >>>>
>> >>>> Let's go through them.
>> >>>>
>> >>>> All SoC except those currently supported in DPU require SMP (shared
>> >>>> memory pool) support to be ported from the MDP5 driver.
>> >>>>
>> >>>> Most of the remaining platforms (except MSM8994/92) also had HW cur=
sor
>> >>>> implemented in a fancy way, in the LM rather than in a separate pip=
e.
>> >>>> I'd really like to postpone those, possibly first completing migrat=
ion
>> >>>> of the other platforms and dropping support for them from MDP5.
>> >>>>
>> >>>> 1.0  - old MSM8974
>> >>>>        I'd rather not touch it, it had bugs and I don't have HW
>> >>>> 1.1  - MSM8x26
>> >>>>        Probably Luca can better comment on it. Should be doable, bu=
t I
>> >>>>        don't see upstream devices using display on it.
>> >>>
>> >>> I have at least two MSM8x26 (1x APQ8026 lg-lenok & 1x MSM8926 htc-me=
mul)
>> >>> devices working with MDP5 fine. I should've probably upstreamed pane=
l
>> >>> driver & dts but they haven't been high priority..
>> >>
>> >> I think I have been saying this: having a panel & dsi enabled in DT i=
s
>> >> the only way for me to know that the display is working on this
>> >> platform. I'd really kindly ask you and other activists to get at lea=
st
>> >> some panel drivers and corresponding DT bits upstream. It is really a=
n
>> >> important flag for me.
>> >>
>> >> I can propose some kind of bounty for those getting MDSS+panel suppor=
ted
>> >> in Qcom DT. (Beer at the next conf we meet? Some stickers for the
>> >> laptops and phones? M=C3=A4mmi?)
>> >=20
>> > Hm I realized yesterday (through trying it), that also MDSS is broken
>> > since the no-IOMMU codepath was removed from drm/msm. I thought this w=
as
>> > only affecting GPU but it's also affecting MDSS/MDP5 :(
>> >=20
>> > So I guess no panel enablement anytime soon until the IOMMU situation =
is
>> > sorted out, for both 8226 and 8974...
>>=20
>> If you're sure the panel drivers are good (e.g. they worked on 6.whateve=
r
>> prior to drm/msm saying sayonara to carveout), I think no one would obje=
ct
>> to have them merged separately, so that you don't have to wait until
>> who-knows-when and keep rebasing them by hand
>
> +1. Please submit them and cc me so that I don't miss those.

Including dts?

The drivers themselves are bog-standard, I've generated them with
linux-mdss-dsi-panel-driver-generator like it's done for most qcom
phones/devices.

But I can work on it.

Regards
Luca
