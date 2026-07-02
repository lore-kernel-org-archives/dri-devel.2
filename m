Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D20C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 00:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B5910E248;
	Thu,  2 Jul 2026 00:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GKuf9TPd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E5A10E248;
 Thu,  2 Jul 2026 00:48:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BA3B41FDB;
 Thu,  2 Jul 2026 00:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B307C1F000E9;
 Thu,  2 Jul 2026 00:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782953282;
 bh=BrXmYfiq8X94mS/qnS8FEVmwl0FSazp4G6SU7BCEJZ0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=GKuf9TPdYjBwd4WPDF0Mut7aeIb7YaoH7Ythf/mbW117DlfRaksxaXPKMUKk2diLe
 d+C+gqsfS4hkEW3JL+34ZF5vIJgxffCIxITeEj7i+sBeEln4iYjmpnWq1cIYHZyer7
 9lHzz/AXiW7frh+7o6drEztCG6SEClGBhls+sYOp65FSsHIoAtXlg1MeJBP22GA2x5
 8qUW/lrRxxBoDELysx3fMNevPZCd2UVb92C5hicc51PFQWvu5Ic9fL7zwrTGQVMwY/
 LXB/JfZQ73w9PC4t5GryFtPLhWv42B2VMRN1MIhibFpqI2mp0ozExdXRNHBfamhVOp
 98CmF6igche8A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 02:47:58 +0200
Message-Id: <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
Cc: "Lyude Paul" <lyude@redhat.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Timur Tabi" <ttabi@nvidia.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Kees Cook" <kees@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Maxime Ripard" <mripard@kernel.org>,
 "Mel Henning" <mhenning@darkrefraction.com>, "John Hubbard"
 <jhubbard@nvidia.com>
To: "David Airlie" <airlied@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-3-lyude@redhat.com>
 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
In-Reply-To: <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
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

On Thu Jul 2, 2026 at 2:30 AM CEST, David Airlie wrote:
> On Thu, Jul 2, 2026 at 10:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> (Cc: John)
>>
>> On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
>> > It turns out that the only reason our previous fixes looked like they
>> > worked for this was because we would occasionally set the Gcoff state =
to 0
>> > in the normal S3 path, which fixed suspend/resume on desktops - but no=
t on
>> > machines using runtime suspend.
>> >
>> > The proper fix is to just never set this flag. Our current guess for t=
he
>> > reasoning behind this is that Gcoff likely coincides with GC6, and not
>> > literally power off.
>>
>> I don't think GcOff coincides with GC6, it should actually be a power of=
f.
>>
>> From a quick glance in OpenRM, it seems that with bEnteringGcoffState =
=3D 1 it
>> also saves off buffers flagged as MEMDESC_FLAGS_LOST_ON_SUSPEND.
>>
>> My guess would be that with bEnteringGcoffState =3D 1, GSP's resume path=
 expects
>> certain kernel-driver-allocated buffers to still be in place that nouvea=
u didn't
>> save off, or rather never had in the first place.
>>
>> John, do you have some details about this?
>>
>
> In nouveau we have the INST_SR_LOST target, for buffers that aren't
> preserved, I wonder did something change between 535 and 570 around
> what needs to be kept around.

The r535 code never set bEnteringGcoffState in the first place. In r535 Ope=
nRM
seems to do the exact same thing.
