Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B30DC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56A410E094;
	Wed, 15 Jul 2026 14:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SSdaH7Ji";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4587910E094
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:24:58 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39c94d4fdb9so33002391fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784125496; x=1784730296; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ACfTUsYc5cSIDcygJYvmfOEuoTU9YLmEZsn/dlKjqbk=;
 b=SSdaH7JiV1nAVTOSBjMK0mVSdhdER6XFmX8xtFZP0AlG1GQBRKdb6ai/3jpWA+tZO6
 usPgsmtOeAVOga+uFHdua0VlshYKqmMkHLklSb48eXBUhQYIykBbKQfjtYYrPQFmSi/t
 lo57xZfpDvnXiujNIGPaIMTUkHWnZz6EdQMSSownv8tnjGOn9gb3mMGZ8rK0a7W9ODLm
 QvJBet0BwyQp7bUH2C7ISvYYHv88hXCa2UppRbTggipu9mGAkWSafrrB0Jw+IfnOXgPs
 H4/lSrkO5ZeLSSd90lrauFgxwEcdUQHyN/O2rXW8f45GQqh9xM6ZpjiJ13BxEaQwl0xp
 m7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125496; x=1784730296;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ACfTUsYc5cSIDcygJYvmfOEuoTU9YLmEZsn/dlKjqbk=;
 b=RMWNdDdwIyNSgMKOlmrxN1LgeoYoR7ig3YSqEi0an+6idP9DTMRNLHqZRKzNbl1Mcy
 NJMviTntaxCc67ljzOUbGosIggYL31Xv1GhCqxLmsNslI9ceytnfcB3qyiYueYsBocsJ
 1Va83cqROuSohDQS1LpNkvzoPLqO38EdW2Ux5lFE1tSFFq4GEi+jyeJeYERJ/BTGwelk
 gNL63nJSEn4rtk0sxQ2Tzi4/VtZU0P5WOrOfVYfb0wKAwgB5BAraYsHFB3+CnfKxpgMZ
 vjORNQZDvXmnlXv0+2mIQOmIEEV6QN8G7uwKrzy2BzLjLcE5robZAW3HNxItW7Ei4n2b
 9c/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqv55avZhICxocNxtuJlWSzgXDPMwp9yfczy8a0ShrTVXNbJf9usdInoInl5+feRlc6sYZ9wBq7emI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5W3kWcrYMenXvEaizv/wC/2uO11T8JH8vfbvsgWQzLegxWYFU
 6peJO4l7W1CmgCqiUe07IKafwdFcBC3vEevhtpTg9Zmr7KJvJh7iVqyg
X-Gm-Gg: AfdE7cliIeb5s2ksGcfhL7J0MRI5PISyT2XQ6AcCEqsfAe2s8xQ2zcVk8rla9diVbW7
 lszx58PS4QtqpNxCouUAvlLefrYyyqshbDHQxqwbc/Nb/otq2om7VSeqUgEd0G3aJqD9E7Nx353
 W9EMXtHHdXocP5kTkXG5+wfYHqn9mkDfw1rj8LP3cHfglnjN3N0S867ac2Hoi+CTIj/Veq2UfpG
 ELRkRfkuDElP/yEk/MTYGRL3OFKdM+yN4l1d+XpCK5l/VfrLVE/sXc0yOr9HrHmkE1MUHDC+qaX
 wfifJ0MxE0v5wKjw1qdT1D3/3Bhg+HVof2/TnhIS9yMmZNNUVDXWT3TiU1jEW+8KQu5hDlFffq3
 z4qgF/0NXdEw3l7LZglkxez9vz2eWJBnrBUDl9GZM196vzrF4uyVsKrnWZC+NGvmWHcZ2SpgUpw
 ybLXIRpB1K+NX1HY9cooYKz8TDcRuUIIjI26eXDMbCSlEoIs2W/M/O
X-Received: by 2002:a05:651c:b28:b0:39a:fef1:ad7 with SMTP id
 38308e7fff4ca-39c94cde536mr48470341fa.21.1784125496005; 
 Wed, 15 Jul 2026 07:24:56 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c849180f3sm36977811fa.4.2026.07.15.07.24.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2026 07:24:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v7 00/19] media: meson: vdec: Fix lifecycles, race
 conditions, and stability bugs
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CANAwSgSz+e483m9VKkFZzSKzB1Tsd8kS20UcB3ON-cZ=J8gX+w@mail.gmail.com>
Date: Wed, 15 Jul 2026 18:24:39 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:DRM DRIVERS FOR AMLOGIC SOCS" <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVERS FOR AMLOGIC SOCS" <linux-amlogic@lists.infradead.org>, 
 "moderated list:ARM/Amlogic Meson SoC support"
 <linux-arm-kernel@lists.infradead.org>, 
 open list <linux-kernel@vger.kernel.org>,
 "open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS"
 <linux-media@vger.kernel.org>, 
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 Doruk Tan Ozturk <doruk@0sec.ai>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DCA30D7-46DA-41A3-BB05-4C841D20BC0F@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <CANAwSgSz+e483m9VKkFZzSKzB1Tsd8kS20UcB3ON-cZ=J8gX+w@mail.gmail.com>
To: Anand Moon <linux.amoon@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
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

> On 14 Jul 2026, at 11:23=E2=80=AFam, Anand Moon =
<linux.amoon@gmail.com> wrote:
>=20
> Hi All,
>=20
> On Mon, 13 Jul 2026 at 17:38, Anand Moon <linux.amoon@gmail.com> =
wrote:
>>=20
>> This patch series addresses a collection of critical race conditions,
>> memory leaks, use-after-free bugs, and resource management issues
>> within the Amlogic Meson video decoder (meson-vdec) driver and
>> associated components.
>>=20
>> The primary focus is tightening session lifecycles, safely =
synchronising
>> the V4L2 m2m framework callbacks, hardening work queue operations
>> (esparser_queue_work), and correcting buffer validations to prevent
>> stability issues like KASAN out-of-bounds errors or stream-on =
timeouts.
>>=20
>> Summary of Changes:
>> * Race Conditions & Synchronisation: Fixes multi-threading and
>>  execution races across stream-on, stream-off, job abort, and
>>  teardown pathways.
>> * Memory Lifecycle: Eliminates memory leaks and use-after-free
>>  vulnerabilities by safely pinning, canceling, and sequencing
>>  device removals.
>> * VP9 & Buffer Hardening: Addresses payload handling bugs in the ES
>>  parser, properly tracks ongoing buffers via atomic counters, and
>>  prevents invalid memory writes.
>> * Platform/DMA Adjustments: Adjusts DMA segment configurations,
>>  canvas handling, and buffer sizes to match modern hardware demands.
>>=20
>> Note on an outstanding issue:
>> An execution deadlock occurs in the driver workqueue path during high
>> stress or long playback sessions. This stall is triggered when the
>> Amlogic hardware internal video FIFO buffer becomes completely full.
>> When esparser_queue_all_src runs, the capacity validation check is
>> tripped due to a design limitation in how buffer exhaustion is =
handled.
>> This blocks progress and leaves the workqueue worker waiting =
indefinitely
>> on a core mutex lock.
>>=20
>> The resulting hung task call trace shows the worker thread blocking
>> on the internal lock:
>>=20
>> Workqueue: events esparser_queue_all_src [meson_vdec]
>> ...
>> __mutex_lock
>> mutex_lock_nested
>> esparser_queue_all_src
>>=20
>> I have tried to address this issue, but the underlying deadlock =
persists
>> under extreme conditions.
>>=20
>> Any feedback on this new appock is welcome.
>>=20
>> Testing was done using v4l2-compliance and active decoding pipelines
>> on Meson platforms (like Hardkernel ODROID-N2+ and ODROID-C4) SBCs.
>>=20
>> The v4l2-compliance tests passed successfully via:
>> $ v4l2-compliance -s -v -d /dev/video0
>>=20
>> Pipelines were validated using the following GStreamer script.
>>=20
>> [1] =
https://gist.github.com/moonlinux/08295ba1f17ce7155550773f2d2cb6e5
>>=20
>> Previous changes:
>> v6: =
https://lore.kernel.org/all/20260530094326.11892-2-linux.amoon@gmail.com/
>>=20
>=20
> I will review Sashiko's feedback. I will look into these suggestions =
and
> work on incorporating them to improve the code quality

Hello Anand,

I=E2=80=99ve picked this entire series into a LibreELEC image using Kodi =
22 and
ffmpeg 8.1 (using the RPi source that improves v4l2_m2m behaviour) on a
7.2-rc3 kernel and run some tests on a GXBB/S905 board.

Without this series H264 plays and seeks well and the unmerged H265 =
codec
also plays well and seeks well but with minor artefacts (something that =
I
need to look into). The experience is not perfect (this driver has a few
flaws) but it=E2=80=99s consistent with the =E2=80=98usable=E2=80=99 =
behaviour of the driver in
the last 1-2 years.

With this series H264 plays but seek seems to hang everything with no =
logged
errors anywhere. H265 results in a black screen and again everything=E2=80=
=99s hung.

It=E2=80=99s possible that kernel changes need to be balanced with =
userspace? Can
you please share details of how you have been testing things (and on =
what
hardware)? - I will attempt to replicate and poke smaller portions of =
the
series to see if I can isolate which bits are problematic to the =
otherwise
usable current experience.

Christian



