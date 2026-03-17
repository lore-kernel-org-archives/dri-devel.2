Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD84F3380B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D3A10E40F;
	Tue, 17 Mar 2026 08:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="g+PSCokc";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0183B10E40F
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:07:42 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-662b5bf4b10so9792530a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773734861; x=1774339661; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+kMPw7ty1babIH+2VdsDBPhsex7KSzHrl7kUwLhU5A=;
 b=g+PSCokcvs2n8qw4E9YI4JpnbNThUc1/XaRLlNXuhaNUnT4QXEmUlt5Mhz8GNBNnln
 mE9n468APJi9vQAhcX2HN4pP+wITRXnK7Cw2VYUEtdGcQtZ01hRIEszAjKATWyk8pwGJ
 h6qceHihzg5bQefGDqAg9JMyUX7bv9P0Fazw0zX4CbZldNK+h14YI5/qa3ULoySAYH5S
 CB6HWD6Jg+cjPgUfue03VIk93Xusid8+/IViuQg8JymFgV5WTzAu8eqhjv6ohFXP3Tjp
 XhhlaBsxOSwRG6QpEOwAEaXacjefqt2idX1R6HZsSZd/eJQgVGRImk7aIuFvMfsD0KSA
 8CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773734861; x=1774339661;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+kMPw7ty1babIH+2VdsDBPhsex7KSzHrl7kUwLhU5A=;
 b=jLHwEjiI36jaANCkqsSlG7RRA5zWnWF1Oop1ylkb6EVqN0lI2KKNwheFR9vWHaOEk5
 SCkiThesS3GU4cq4Gnunhc3JGLblvgFCxwWISvnGY0DxAqOgrcNmmBQ6tKbFPsrTSrOu
 +dCcp7z71SAruZz7OZH2Zt9Dra84saqX10xvXehBr76BM9kc1TfprALdTnHPXgavZdmL
 w3ATQDxvGAM1cOKphDWlM1BgXd4nR0ypmdETFIX1JvGPadwBL2lVnn/bgHwXB1mNhfhg
 Ny3SCYq4qENBTvqjC1vkLj61+2dWU4JSturrwQNirsRutJEDVg4gwMxeZ3Nl0zcwzCCV
 Xz5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpg+5xB+wiYjFHo/fF1FkJApKFUHG7QeEItIRo8SDlr9SAagaA+YzqBCofpMO7QJSbJwvssonhdbw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQENOqhvmgq0M0szeKaB1OS6fu332TIXGCq/m2XmXC3QA+EU51
 VKopO8knn7u54OwrI0ytN7X5Yaufi5qF6fxj6R5hbAhp69nrsxXFcRKUY2H0ATVKkc4=
X-Gm-Gg: ATEYQzxCcauoR19mvEEKiX1vsX7xn/BLDtFQlzL6wIc539+N+aPa9CE6jg7aJlZcEtX
 vxd2Fv1/kanEnels9JoedHEILbA99sQ8YQRwLchyOzGF5HLrrKo7TPm5/X5USyAuW2a0zKDGbHB
 muii0kMVOP+7UK8TZH1QZ48ctwfGvkc9IW0MnSf/Jp2L002h1pSAq9G1NKurfTWdDnp0okTtD9/
 CL96Q7I7mpGKpblGn3i3CTFwk6Py9aW5XZ+weWa9o9ue8ZY+MZJHz4DqjVvvJNFy2DSRCYCgjuk
 ULU+35wgs2I90YW5xMzo4V6EcABzNu+AOoQKTXDuDd4vJ03KsB7vSuDsy9QDabMgM+LlzUfTA/y
 KOnNuyGrREeBvpWrIYIimMayvDpqK1RnsO9AxmwnEPhZntRNtgyMtuqED1w5ELGLQhrPbHvQJ29
 LXXt6oMTRw95dNAfuD2lrd3CoUZKcGxqT9NILZgsZaTilSOwFTLCAWcvTh+xa3D+n7UrKgjfn5w
 xxLBRA=
X-Received: by 2002:a05:6402:274b:b0:65f:9809:7abe with SMTP id
 4fb4d7f45d1cf-663babfaa12mr9698736a12.16.1773734861223; 
 Tue, 17 Mar 2026 01:07:41 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6634fdb6225sm6466300a12.9.2026.03.17.01.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 01:07:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 09:07:39 +0100
Message-Id: <DH4WJ5KZ39MS.AHLMLFB8E0JW@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "yuanjiey"
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
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260109083808.1047-2-yuanjie.yang@oss.qualcomm.com>
 <kusxzlezvsuwcwwdtm7yqwnqea6gdeolkepxpx3estabaiqymo@edj7pgccli3y>
 <aWSTcI6H6+7AXkEN@yuanjiey.ap.qualcomm.com>
 <CAO9ioeVrQ_TfU5-auxNHG=dL8VmeWtBaC_NE09UECodkYrFv-w@mail.gmail.com>
 <aWSv+kVV3G18I/NJ@yuanjiey.ap.qualcomm.com>
 <e5ebc660-e30e-4fcd-ace6-5a6c889e9a8a@oss.qualcomm.com>
 <4g6fyehdc3fejx3pzeysmghigazfei3jz2vmnvxrnqkkbtbxdb@bdlcddxlvbhl>
 <cb22367a-678c-431f-9f52-33663f4af9d7@oss.qualcomm.com>
 <jr4h4sx42dbxpknm5nkgj7ydpkivm4nglfz7ui4bjpom7wf6ub@spqb27d3ov2z>
 <DGSDE0ID17DQ.XQZNKZH5UKPO@fairphone.com>
 <g3dclilgoee6a2dyfqdvk67asjb4ptur5nc52iqqeqpiiourpv@46xstae5zsy3>
In-Reply-To: <g3dclilgoee6a2dyfqdvk67asjb4ptur5nc52iqqeqpiiourpv@46xstae5zsy3>
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

On Mon Mar 2, 2026 at 4:17 PM CET, Dmitry Baryshkov wrote:
> On Mon, Mar 02, 2026 at 03:35:36PM +0100, Luca Weiss wrote:
>> On Fri Feb 27, 2026 at 8:05 PM CET, Dmitry Baryshkov wrote:
>> > On Fri, Feb 27, 2026 at 12:34:04PM +0100, Konrad Dybcio wrote:
>> >> On 2/27/26 4:48 AM, Dmitry Baryshkov wrote:
>> >> > On Thu, Feb 26, 2026 at 02:35:52PM +0100, Konrad Dybcio wrote:
>> >> >> On 1/12/26 9:25 AM, yuanjiey wrote:
>> >> >>> On Mon, Jan 12, 2026 at 09:38:41AM +0200, Dmitry Baryshkov wrote:
>> >> >>>> On Mon, 12 Jan 2026 at 08:23, yuanjiey <yuanjie.yang@oss.qualcom=
m.com> wrote:
>> >> >>>>>
>> >> >>>>> On Fri, Jan 09, 2026 at 05:22:37PM +0200, Dmitry Baryshkov wrot=
e:
>> >> >>>>>> On Fri, Jan 09, 2026 at 04:38:07PM +0800, yuanjie yang wrote:
>> >> >>>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>> >>=20
>> >> [...]
>> >>=20
>> >> > Please correct me if I'm wrong, if we drop dev_pm_opp_set() from
>> >> > dpu_runtime_suspend, then we should be able to also skip setting OP=
P
>> >> > corner in dpu_runtime_resume(), because the previously set corner s=
hould
>> >> > be viable until drm/msm driver commits new state / new modes.
>> >>=20
>> >> That matches my understanding.
>> >>=20
>> >> > The only important issue is to set the corner before starting up th=
e
>> >> > DPU, where we already have code to set MDP_CLK to the max frequency=
.
>> >> >=20
>> >> > Which means, we only need to drop the dev_pm_set_rate call from the
>> >> > dpu_runtime_suspend().
>> >>=20
>> >> I concur.
>> >>=20
>> >> >> For MDSS, we're currently generally describing the MDSS_AHB clock,=
 the
>> >> >> GCC_AHB clock and the MDP clock (sounds wrong?) - there's not even=
 an OPP
>> >> >=20
>> >> > No. As far as I remember, MDP_CLK is necessary to access MDSS regis=
ters
>> >> > (see commit d2570ee67a47 ("drm/msm/mdss: generate MDSS data for MDP=
5
>> >> > platforms")), I don't remember if accessing HW_REV without MDP_CLK
>> >> > resulted in a zero reads or in a crash. At the same time it needs t=
o be
>> >> > enabled to any rate, which means that for most of the operations
>> >> > msm_mdss.c can rely on DPU keeping the clock up and running.
>> >> >=20
>> >> >> table.. The GCC clock is sourced from (and scaled by) the NoC, but=
 the
>> >> >> MDSS_AHB one seems to have 3 actually configurable performance poi=
nts
>> >> >> that neither we nor seemingly the downstream driver seem to really=
 care
>> >> >> about (i.e. both just treat it as on/off). If we need to scale it,=
 we
>> >> >> should add an OPP table, if we don't, we should at least add requi=
red-opps.
>> >> >=20
>> >> > I think, dispcc already has a minimal vote on the MMCX, which fulfi=
ll
>> >> > these needs.
>> >>=20
>> >> I have slightly mixed feelings, but I suppose that as we accepted Com=
mit
>> >> e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the d=
omain"),
>> >> we can generally agree that it makes sense that calling genpd->on() a=
ctually
>> >> turns on the power indeed
>> >>=20
>> >> What I'm worried about is if the clock is pre-configured to run at a =
high
>> >> frequency from the bootloader (prepare_enable only sets the EN bit in=
 the RCG,
>> >> and doesn't impact the state of M/N/D at a glance), we may get a brow=
nout
>> >>=20
>> >> This rings the "downstream really did it better with putting clock dv=
fs states
>> >> into the clk driver" bell, but I suppose the way to fight this would =
be to
>> >> simply set_rate(fmax) there too..
>> >>=20
>> >> I attempted an experiment with pulling out the plug. MMCX enabled wit=
h the
>> >> AHB clock off results in a read-as-zero. I tried really hard to disab=
le the
>> >> mdp clock, but it seems like the "shared_ops" reflect some sort of "y=
ou
>> >> *really* can't just disable it" type behavior (verified with debugcc)
>> >
>> > I think, in 8996 it was possible to disable it. Not sure about
>> > 8998/630/660.
>> >
>> >>=20
>> >>=20
>> >> There's a possible race condition if we don't do it:
>> >>=20
>> >> ------- bootloader --------
>> >> configure display, mdp_clk=3Dturbo
>> >> ------- linux -------------
>> >> load rpmhpd     |
>> >> load venus      |
>> >> set mmcx=3Dlowsvs | mdp_clk is @ turbo
>> >>                 | brownout
>> >>                 |=20
>> >>                 | <mdss would only probe here>
>> >>=20
>> >> *but* that should be made impossible because of .sync_state().
>> >
>> > Yep, sync_state should prevent MMCX or CX from dropping under the boot
>> > level.
>> >
>> >>=20
>> >> This may impact hacky setups like simplefb, but as the name implies,
>> >> that's hacky.
>> >>=20
>> >> Relying on .sync_state() however will not cover the case if the mdss
>> >> module is removed and re-inserted later, possibly with mmcx disabled
>> >> entirely but the clock not parked at a sufficiently low rate.
>> >>=20
>> >>=20
>> >> TLDR: reassess whether MDSS needs the MDP clock, if so, we should jus=
t
>> >> plug the MDP opp table into it and set_rate(fmax) during mdss init
>> >
>> > And what will drop it afterwards? MDSS will still vote on the MMCX / C=
X
>> > level even though DPU will change the clock freq.
>> >
>> >>=20
>> >> >> The MDP4/MDP5 drivers are probably wrong too in this regard, but m=
any
>> >> >> targets supported by these may not even have OPP tables and are ge=
nerally
>> >> >> not super high priority for spending time on.. that can, I'd kick =
down the
>> >> >> road unless someone really wants to step up
>> >> >=20
>> >> > I'd really not bother with those two drivers, unless we start seing
>> >> > crashes. For MDP4 platforms we don't implement power domains at all=
, no
>> >> > interconnects, etc., which means that the system will never go to a
>> >> > lower power state.
>> >>=20
>> >> Right. Might be that 2030-something arrives and armv7 is gone before =
someone
>> >> randomly decides to work on that!
>> >>=20
>> >> > MDP5 platforms mostly don't have OPP tables. (I'm not counting MSM8=
998 /
>> >> > SDM630 / SDM660 here). MSM8917 / MSM8937 have only DSI tables, MSM8=
976
>> >> > has both MDP and DSI tables (my favourite MSM8996 has none). Probab=
ly we
>> >> > should start there by adding missing bits adding corresponding
>> >> > dev_pm_set_rate() calls as required (as demostrated by the DPU driv=
er).
>> >>=20
>> >> A bit off-topic, but:
>> >>=20
>> >> drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
>> >>=20
>> >> 96 is in DPU. any other candidates that should be moved over?
>> >
>> > Let's go through them.
>> >
>> > All SoC except those currently supported in DPU require SMP (shared
>> > memory pool) support to be ported from the MDP5 driver.
>> >
>> > Most of the remaining platforms (except MSM8994/92) also had HW cursor
>> > implemented in a fancy way, in the LM rather than in a separate pipe.
>> > I'd really like to postpone those, possibly first completing migration
>> > of the other platforms and dropping support for them from MDP5.
>> >
>> > 1.0  - old MSM8974
>> >        I'd rather not touch it, it had bugs and I don't have HW
>> > 1.1  - MSM8x26
>> >        Probably Luca can better comment on it. Should be doable, but I
>> >        don't see upstream devices using display on it.
>>=20
>> I have at least two MSM8x26 (1x APQ8026 lg-lenok & 1x MSM8926 htc-memul)
>> devices working with MDP5 fine. I should've probably upstreamed panel
>> driver & dts but they haven't been high priority..
>
> I think I have been saying this: having a panel & dsi enabled in DT is
> the only way for me to know that the display is working on this
> platform. I'd really kindly ask you and other activists to get at least
> some panel drivers and corresponding DT bits upstream. It is really an
> important flag for me.
>
> I can propose some kind of bounty for those getting MDSS+panel supported
> in Qcom DT. (Beer at the next conf we meet? Some stickers for the
> laptops and phones? M=C3=A4mmi?)

Hm I realized yesterday (through trying it), that also MDSS is broken
since the no-IOMMU codepath was removed from drm/msm. I thought this was
only affecting GPU but it's also affecting MDSS/MDP5 :(

So I guess no panel enablement anytime soon until the IOMMU situation is
sorted out, for both 8226 and 8974...

Regards
Luca

>
>>=20
>> Btw IOMMU support is here missing as well, so no GPU support anymore
>> since 6.17 if I'm not mistaken.
>>=20
>> > 1.2  - MSM8974
>> >        I think it also had issues, no IOMMU support in upstream, etc.
>>=20
>> Plenty of 'issues' for sure ;) but apart from GPU driver having dropped
>> no-IOMMU codepath they should be fairly fine, for what's currently
>> upstream.
>>=20
>> I think also here, plenty of devices that do have panel support but not
>> much upstream. It's kind of all the same though, nothing exciting. Panel
>> driver with init sequence plus the same dts enablement bits.

