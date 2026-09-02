Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D253C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3BF10E4C2;
	Wed,  2 Sep 2026 17:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="NV8zzXWu";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B675110E4C2;
 Wed,  2 Sep 2026 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1788368680; x=1788973480; i=w_armin@gmx.de;
 bh=XdTeL4w9sItZDWxLzNlYAS96zZLVs0/e9yL+LaUwBGM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NV8zzXWue9bn3o3bHlCs/XXh863PFqmElx2CcPmPNIPGEyEJX7I0tKOf60PRgxUa
 QOcXKWQOi85uDgNFy/qFE5REL2vbfu3OUDhtDgufB25yTa1wHFdBEFSAazybi5kod
 b6VsOuzicceRFMibx7dcVCJ9odCKE2Tra2JIlL8Egu3Ayi4YYpId2Y2T5tbcYFSAV
 EyqpYykRvnVHXC3ACChwAKRVdvkxIvTKtxupjbaj0Y78Sh+EKhL6DyzRHT1+JVg4H
 PHY4K8NGAv4mzsIplMxHbpSb6WUNGRQsMPkTjqyAtZ9mNqrwkO8sfR21pETEGigkC
 uVehauezs3hgTl4RvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1wQFpN2k3r-00qNLa; Wed, 02
 Sep 2026 18:58:50 +0200
Message-ID: <8c70d6af-8dd7-4ffa-81a9-1cb2c5e54101@gmx.de>
Date: Wed, 2 Sep 2026 18:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] platform/wmi: Add aarch64 support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux@weissschuh.net,
 "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
 linux-acpi@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 intel-xe@lists.freedesktop.org
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <59aadf0f-953c-4b7c-8c92-9dd9bc4f89de@gmx.de>
 <46bd3385-4bd8-4a98-8ef3-57c29d00361c@gmx.de>
 <c8445c2e-6799-7856-610c-0742248e1c07@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <c8445c2e-6799-7856-610c-0742248e1c07@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z/gDDHvci+vpk+iACKyBGTnzKq12E5jtYwOptwUOMAqvPwIP1UJ
 b1ic2sNs9tFUN9CWors4BX2gLrNtJRe1McMS1sLXaWc1i2x/h58D4aX1HX2SzLjm0O8BsiE
 xBF5RLnzVmaNyMYbE3OqCHtKN11X8oVuEOGNR+jPessBi6lRN/s2VDdLkbfZA4pGK4m3E5f
 JD5YKjNee8b1Lw6A4g4jw==
UI-OutboundReport: notjunk:1;M01:P0:BeuF/l2r5pg=;pBkz2qmqqGxbDptYasIrXcwcDzn
 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
 tDPV8g31L3XaQ5HBg==
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

Am 02.09.26 um 11:27 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 1 Sep 2026, Armin Wolf wrote:
>
>> Am 07.08.26 um 23:03 schrieb Armin Wolf:
>>
>>> Am 24.07.26 um 04:59 schrieb Armin Wolf:
>>>
>>>> The aarch64-laptops project found out that some Windows-on-Arm
>>>> notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
>>>> exactly like on x86. Those devices however are currently not
>>>> supported by the WMI driver core due to only supporting x86.
>>>>
>>>> The first patch removes this restriction and allows the WMI
>>>> driver core to run on all architectures that support ACPI.
>>>> The second patch updates the acpi-video driver to take advantage
>>>> of the improved support for architectures other than x86, and
>>>> the last patch enables the generic WMI BMOF driver to support
>>>> aarch64 as well.
>>>>
>>>> All patches have been tested on a ACPI-based aarch64 VM and
>>>> work just fine.
>>> Any thoughts about this series from the GPU driver people?
>>>
>>> Thanks,
>>> Armin Wolf
>> Can i assume that the silence means "looks fine to me"?
> Hi,
>
> Those subjects may be too generic for the GPU people to realize we're
> waiting for their Acks.
>
> I suggest you send non-ML email (private) with a more descriptive subjec=
t
> to the relevant maintainers asking for them to take look at this series
> (I'd have done that myself later this week but you can do it as well).
> Such an email is more likely to be caught in their radar.

Good point, i will try this.

Thanks,
Armin Wolf

>>>> Armin Wolf (3):
>>>>  =C2=A0=C2=A0 platform/wmi: Remove dependency on CONFIG_X86
>>>>  =C2=A0=C2=A0 ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi=
_ec_supported()
>>>>  =C2=A0=C2=A0 platform/x86: wmi-bmof: Move to generic WMI code
