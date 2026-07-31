Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5712AC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B1910E1FD;
	Fri, 31 Jul 2026 13:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XbBG/v+e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB53710E1FD
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:04:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5E3F600AF
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBE01F00A3A
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785503073;
 bh=CjVcHniSLBRKWrFsvh8Ah11kb/c0CCbICSTiExfKTL4=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=XbBG/v+e3BvTNDCNxdKpg6TNXjDLxka2Y4glY2ioV47hedJg9JRav8XZFl3F8pxz4
 6G1Zdzbuzx5VUPvLVrkdCJCr+roKBvKso0KENSfwZRlw5Ei5ay4/KFlQ1ws5YKi2QC
 STYOXvUxwQXyGSBGLIKdL6yofxnWIWsgTmIBGQ/QgwyIRDSRtc/1l/Vx1/APWA7LXi
 qtVPDUCkdUwkQX239xW7hfQfir8WJ7JL+ohNxOksFk4OeiW1Tz6fZ53oelvb8lm8qr
 Y8uTndwFSGJJ5TXIpsijiOJOLJ7bFvUPOqPlDII6rKJR6P43FEAWRVkv6ZvvXF4/dn
 MAx2HwqH9WBDg==
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-39f75e0a2f1so7313261fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:04:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpNsetLy+NMCABwhCP0G64SrTnGD58jvNDOEm2vXqllo/pYzYryLiBwpck4dWsTGImt2PevpTaRczU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjJA8LOjiie8nft8f0ifHo8xuQ4+j/yKC343fEBKgTFZJ4qRMb
 x/4jVA4X1sMazFvqkyZ9A4K+RubMoc9xjzPKcaQAIPli/4XL/QxwxcNRnOiueAQsZoFI5S2SF+y
 ADR2erfyoqEFH7KE+MDPnpI7Zl+Kz24Wz38364HciaA==
X-Received: by 2002:a05:651c:4396:20b0:39c:a06f:12ba with SMTP id
 38308e7fff4ca-39f7e44b426mr2905841fa.40.1785503072391; Fri, 31 Jul 2026
 06:04:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 08:04:30 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 08:04:30 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAFEp6-3X+PCXZdEy1p47XUDs7cT16JDjt0=928Jjkeik_haaQw@mail.gmail.com>
MIME-Version: 1.0
References: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com>
 <CAFEp6-3X+PCXZdEy1p47XUDs7cT16JDjt0=928Jjkeik_haaQw@mail.gmail.com>
Date: Fri, 31 Jul 2026 08:04:30 -0500
X-Gmail-Original-Message-ID: <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
X-Gm-Features: AUfX_my34O5ZqodmTjdz_FwlJrp9NnalnGl6Ep4FvspsE7xopR-UD4qRTMMPUOE
Message-ID: <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
Subject: Re: [PATCH v2] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_enable/disable()
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jeff Johnson <jjohnson@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
 linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-pci@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

On Fri, 31 Jul 2026 10:43:19 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> On Fri, Jul 31, 2026 at 10:29=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@oss.qualcomm.com> wrote:
>>
>> The way power sequencing works means that a call to pwrseq_power_on()
>> does not necessarily result in the pwrseq target being powered-on at
>> that time: it may have already been powered on before. Similarly: a call
>> to pwrseq_power_off() does not have to result in an actual powering off
>> of resources: there may still be other users that requested a power-on
>> before.
>>
>> We will also introduce the concept of "non-controllable" pwrseq targets
>> soon which further increases the disconnect between the naming
>> convention and the actual semantics.
>>
>> What consumers of pwrseq descriptors actually do is: they *vote* for a
>> powering on of a given target or retract that vote. These operations
>> could be called get/put in line with runtime PM but this could become
>> confusing since we already provide pwrseq_get/put() for a different
>> purpose. pwrseq_vote_on/off() also have been rejected as unusual in
>> the tree.
>>
>> Change the name of the two functions to pwrseq_enable/disable() which
>> better reflects their purpose and semantics and also mirrors other
>> enable-counted resources like regulators and clocks. No functional chang=
e
>> intended.
>>
>> If at any point users need to know *when* the exact power event happens,
>> we can provide that information in the form of a notifier.
>>
>> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>> ---
>> I've floated the idea to rename the two pwrseq functions from "power
>> on/off" to "vote on/off". I've sent a patch but the overwhelming
>> consensus seem to be that enable/disable naming is preferred.
>>
>> I'm doing it in a single commit that should go through the pwrseq tree
>> with Acks from subsystem maintainers.
>>
>> [1] https://lore.kernel.org/all/CAMRc=3DMefxn81d0VUwmQgwFtffkL1=3DEr_1VQ=
ZCbC1Sa-Qph4t1w@mail.gmail.com/
>> ---
>> Changes in v2:
>> - Change the naming convention to enable/disable
>> - Link to v1: https://patch.msgid.link/20260727-pwrseq-vote-rename-v1-1-=
a2029aeeac65@oss.qualcomm.com
>> ---
>>  Documentation/driver-api/pwrseq.rst      |  4 ++--
>>  drivers/bluetooth/hci_qca.c              |  4 ++--
>>  drivers/gpu/drm/imagination/pvr_power.c  |  4 ++--
>>  drivers/net/wireless/ath/ath10k/snoc.c   |  6 +++---
>>  drivers/pci/pwrctrl/generic.c            |  4 ++--
>>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  4 ++--
>>  drivers/power/sequencing/core.c          | 16 ++++++++--------
>>  include/linux/pwrseq/consumer.h          |  8 ++++----
>>  8 files changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/driver-api/pwrseq.rst b/Documentation/driver-=
api/pwrseq.rst
>> index ad18b2326b689a41471216f3889480b11768ca82..0c315ab1138b02540fae60b3=
9928c580027c0f7c 100644
>> --- a/Documentation/driver-api/pwrseq.rst
>> +++ b/Documentation/driver-api/pwrseq.rst
>> @@ -50,9 +50,9 @@ Consumer interface
>>  The consumer API is aimed to be as simple as possible. The driver inter=
ested in
>>  getting a descriptor from the power sequencer should call pwrseq_get() =
and
>>  specify the name of the target it wants to reach in the sequence after =
calling
>> -pwrseq_power_up(). The descriptor can be released by calling pwrseq_put=
() and
>> +pwrseq_enable(). The descriptor can be released by calling pwrseq_put()=
 and
>>  the consumer can request the powering down of its target with
>> -pwrseq_power_off(). Note that there is no guarantee that pwrseq_power_o=
ff()
>> +pwrseq_disble(). Note that there is no guarantee that pwrseq_disble()
>>  will have any effect as there may be multiple users of the underlying r=
esources
>>  who may keep them active.
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 345f602e9ce233a0934a73a85d1e7c17c4f3210d..e713fc06b73402ae3d57794e=
d0870df8394a796a 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2259,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
>>         }
>>
>>         if (power && power->pwrseq) {
>> -               pwrseq_power_off(power->pwrseq);
>> +               pwrseq_disble(power->pwrseq);
>
> Nit: s/pwrseq_disble/pwrseq_disable ?
>

Ah dang it, how did I miss it, I test-built it. :/

Thanks for catching it.

Bart
