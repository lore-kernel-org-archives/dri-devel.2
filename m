Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D7C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF3110F930;
	Fri,  4 Sep 2026 08:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mvJGYIKj";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8412610F930
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:14:10 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-66c70f69d3fso613531d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 01:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788509649; cv=none;
 d=google.com; s=arc-20260327;
 b=Ksga13F/KAbdlGep/p4gJMP4q347RCCeOkUMvtLwT/GtliU9waCuIweTdjhWuHRqFp
 kyBhaymqLjZIrHPqS6LqO0fYCQLVURtgHxfCG/v+R4dwYFI01bWfSMUX9urRkjMwpXsH
 cpwW+EwMvmN1qUFBPK/o3ioEnTSBx4oXU9WhK32fAUW2zaJhuVkccGzOsq14iMMJNMpE
 AG3z+xJXyhDWVTtSPRTIma8t6weASCf+THQmHa6FMXKrB9hdPrUfEnGMRxh9NzcP+84Y
 86yUfuwY8MefhfVAX2tRSLeuHOYJ+zJSq1Qzj5VN6etpFnY7ZYoUymfwny+yhyiuBdC5
 gbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tBqFv7ZNVkf8/OWug/8l6emlj27SIx7U4VNemvpWjT4=;
 fh=4aVLc7Sw663qx1pCToEev2we4JaWqi3HCyHkCZlcuzU=;
 b=QISvfs5O4H3Zm1n4RwXtmqyjfdlN1D6ZgkoQRYBSPC0K3iQgHZlfAqczQAqGxHQgG3
 nRoKeOaPHeV4ayBqdCoqrvskesN02eEzUXzKyVXihs9G8g2OEUf7sWZKAK/YjnYbGOYC
 mCuo3Bt0qNuGIAcuJA+LO81go/EWW8Tvy77yH27TTLqnQRK9CS/1CTKB8vj4W2uki0ro
 hTG8cQgPrw+jCYlmqUjiSY6xYhpmAZxCvLdIHCCpHE+yqx1w7stVaMh0K2vyjEfUSS/2
 s68s4ASqtcAud3JdcA0PuK7EngHqXEogNhEvDNpkq49451mqpA6Jvsu82kwq+ZbzxlUc
 ha4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788509649; x=1789114449;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tBqFv7ZNVkf8/OWug/8l6emlj27SIx7U4VNemvpWjT4=;
 b=mvJGYIKj2AXji3ZE39lEP/h0QPQkewFXRX35LwnS6Qo50PB5X2XBGWbYGY7p4V5cEn
 Wzj5Ir6jXKyITQl/nKT7NYubvWHq7XtIMpIFAaz9TWMzb2etS6Tk0PKnB4w/r/xEijcY
 oHLdtr+E4K7s0LTwUYjZQI+hFZMp65joG1OeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509649; x=1789114449;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tBqFv7ZNVkf8/OWug/8l6emlj27SIx7U4VNemvpWjT4=;
 b=ckcU73rZ9nlu+Uu1TBF3N8pFTA6QZ60sqbwsU9qkCVkeON7xc5yzqMlBjew/KatD2+
 tGGxYXgmprvrFCgLxyvhJjER0eHvioOQ4glx8n48F3Hf2YwfKX11nNthDfXfb9Yuv4iU
 0YFKuW/9QhfDQe0rh15nrJNdymiEnLQidA0xdCh9a/i8YbGy4OAKC6VlfgaqcQFwc8LC
 QgVMiJbl+ESgbejrMRq2ONs+FQZrKg9hxH1H7GVAkZblWWUkQX1sadG3pISqp/RJFWxZ
 GLe7hsAR/1HIAS92QYrnTWZabOTx+QzsQTaTKK8KJBGiTI2Fr1XjuiaJ5sH2sLzLAdXu
 a6CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx02pezN3uSEUkuJsht3bErJL3DBENLvxdysuuiMfpvuNCc6kdtMxO4YMNL4EprkP4V1HTgXobVMk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgbA1s3ghZpJ0Vj/YPjMPVNNOKQjlbQ/vapOxFH8asrWlv9Uil
 o0F26oMYI/v5tYqV7WGjPetZyQ20FvNfmUdm0TsoyQqNLKgcHg/7o+tnltKvRcmXKNFMrLMCyYU
 ni1/n1SGi7d8kK+C4F39p+XCKFThdabI45RWLFfgr
X-Gm-Gg: AYBFou0FiRfjP913FZVi0kQoHkAXMMRcFUJ6Y5syglYbnnkeLnG3Ks8SgOPCxZnj/QL
 Fr7Y5t7ir4ILJ0Ty7cKnlQObrpK8dVncc/osbg9Bytsb8WiflcaEAQxpeUpjyUW89hXcE1hVqWr
 BlgSmBm4ubc+5ijlrOW8aseKYClF5pwB8UW6dyZ46x6mp0KX0yoKYHbKTZMSDINu6jMFg28G2uj
 aIe2MvMUtzZdxv3rosFMMOzrqT9/04ZpkVvQu2Acr2ianVgIa5pXjOkd57tP651KMx/0WTJYS3S
 2/RSN5ACeyE8mHv+Q6rlSabY9X5H6d48F6d9d+vkO4XHq4oRusFVF73NpJSmbOLiJ2jWSEo89yA
 cl49Y9BrU
X-Received: by 2002:a05:690e:168d:b0:667:770c:f88e with SMTP id
 956f58d0204a3-66fb5aeafe7mr1463610d50.45.1788509649151; Fri, 04 Sep 2026
 01:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGXv+5EgGYFVt4TJCysQgRqA1J5=Qz9c0oWY5YTxgc5PnNC_AQ@mail.gmail.com>
 <36f2775a-d332-4913-8e9e-ca0429c3f713@collabora.com>
In-Reply-To: <36f2775a-d332-4913-8e9e-ca0429c3f713@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 4 Sep 2026 16:13:58 +0800
X-Gm-Features: AcwNN1XC4LXAm1BwVIM4UDg-tlD1lttg9AE64QKW3tHBF46eVGyIPLVMv5NqRcM
Message-ID: <CAGXv+5FEx=H9r5MGequDpH3i62FAWbXdwkk66eBj8+ziT1fhMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Brian Masney <bmasney@redhat.com>, Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 YoungJoon Lee <getfeus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Thu, Jul 30, 2026 at 4:23=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On 7/30/26 06:51, Chen-Yu Tsai wrote:
> > On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> On 7/28/26 15:13, Chen-Yu Tsai wrote:
> >>> On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney@redhat.=
com> wrote:
> >>>>
> >>>> Hi Chen-Yu,
> >>>>
> >>>> On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> >>>>> Hi everyone,
> >>>>>
> >>>>> This is v4 of my MT8173 PowerVR GPU support series.
> >>>>>
> >>>>> This time around Mesa was ready for basic testing, using both vulka=
nmark
> >>>>> and glmark2-es2-drm (with Zink). Details below.
> >>>>>
> >>>>> Changes since v3 (all in the clk driver patch):
> >>>>> - Changed pm_runtime_put() to pm_runtime_put_sync()
> >>>>> - Added missing of_node_put() in remove function
> >>>>>
> >>>>> Changes since v2 (all in the clk driver patch):
> >>>>> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> >>>>>     - Needed since the driver implements PM domains using the gener=
ic PM
> >>>>>       domain library, which also depends on PM
> >>>>>     - Fixes build breakage (kernel test robot)
> >>>>> - Fixed "RST_DELAY_CNT" name (Brian)
> >>>>> - Dropped unused mfg_desc (Brian)
> >>>>> - Added check of clk_prepare_enable()'s return value in
> >>>>>     clk_mt8173_mfgtop_power_on() (Brian)
> >>>>> - Saved error value for return in IS_ERR(data->clk_26m) branch
> >>>>>     (Dan Carpenter / kernel test robot w/ smatch)
> >>>>>
> >>>>> Changes since v1:
> >>>>> - Adapted to changed DT bindings
> >>>>> - Dropped driver change
> >>>>> - Use same power domain for "a" and "b" GPU power domains
> >>>>>
> >>>>>
> >>>>> This series enables the PowerVR GPU found in the MT8173 SoC, found =
in
> >>>>> some Chromebooks.
> >>>>
> >>>> I'm making a pull for Stephen for the clk changes. Should patches 1,=
2,4
> >>>> go through the clk tree? Patches 3,5 go through the DRM tree?
> >>>
> >>> Only patches 1 and 2 should go through the clock tree.
> >>>
> >>> Patch 3, 4, 5 can all go through the soc tree if Angelo wants to pick=
 up
> >>> DT binding patches. Otherwise I can push patch 3 through drm-misc.
> >>>
> >>
> >> Not sure if I can really take the DRM bindings patch through soc.
> >>
> >> I will take the devicetree ones exactly right now, even though it's go=
ing to
> >> give warnings.
> >
> > Apologies for missing this, but the first DT patch depends on the clk D=
T
> > bindings patch for the clk ID macros. This is causing build errors in
> > linux-next right now.
> >
> > Not sure how we can fix this right now.
> >
> > Brian, would it be possible for you to split out that patch into a
> > separate immutable branch for Angelo to merge?
> >
> > Otherwise Angelo might need to drop the DT patches until the next cycle=
.
> >
> >
> Yeah, that's so bad.
> I'd be happy to be able to resolve this, but it's too late on my side.
>
> I should've checked the DT patches more carefully, my bad: I got a bit to=
o excited
> to finally see this PowerVR stuff working on MT8173 and going upstream.
>
> Sadly, I have to drop the devicetree patches :-(

This is a reminder to re-apply the device tree patches from this series.


ChenYu
