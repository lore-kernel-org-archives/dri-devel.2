Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DA9C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20CA10E834;
	Mon, 31 Aug 2026 13:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AaIRhcwV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7492C10E834
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788183168; x=1819719168;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=vxZm/tRDZyNZQcA5cU5ZQNQgkb9Y9quu5/0wsDyUHOg=;
 b=AaIRhcwVXLrOWMJq648jIViUtPynt1u4YjKx92kHqYW7I3m9mnLI9jCC
 h3iGFHONuHWyTK3tHbs8XFTdm72BA5nJ3y6Ss0ovc3JumRrc9OU+UvCAi
 bUd1AqD0+zJUiQk6DEoeENnZWfjNChX2YRtNWgek46x0XSUJfHYxoJOBN
 NXE1ojCY1o4IwX7cQ93R8OHzGsGD92k1Zs0wpfFqpEyx1BDCd6P/K784R
 Fi4EYV30UHASwTlMU4iqCJabgEDo8M5vcH4PaaAXCH3eOTaE7WWKaF4/e
 w1wxV2DHe2QSOYI22dThxhaRNGJEo+nSf/JicQ73WRL14DmqcbA91+FvG w==;
X-CSE-ConnectionGUID: YyuSJvVEQr6EiudYFZq88Q==
X-CSE-MsgGUID: BDytc3FxSLOffcRamNizOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99940761"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="99940761"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:32:47 -0700
X-CSE-ConnectionGUID: I9e9ZFCQS6K606NT3ndNZg==
X-CSE-MsgGUID: utGvlpgGTLaGxtI619LODQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="269389954"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:32:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 ardb@kernel.org, ilias.apalodimas@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 1/3] firmware/sysfb: Remove rotation quirk for Lenovo
 D330
In-Reply-To: <88e53706-d237-46e3-afc3-deff5e372725@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260831093020.494701-1-tzimmermann@suse.de>
 <20260831093020.494701-2-tzimmermann@suse.de>
 <5f8aceb5b36607877509995550d6dbbfad675ba7@intel.com>
 <88e53706-d237-46e3-afc3-deff5e372725@suse.de>
Date: Mon, 31 Aug 2026 16:32:39 +0300
Message-ID: <5211e49433f3483266bb10fce786fccd154f84b6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Mon, 31 Aug 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 31.08.26 um 14:49 schrieb Jani Nikula:
>> On Mon, 31 Aug 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> The Lenovo D330 is a notebook with unmountable display. The display
>> Please elaborate on what you mean by "unmountable display".
>>
>> No comments on the patch itself, I just haven't heard that before.
>
> Sorry, that word doesn't exist; maybe "mountable".=C2=A0 I think "detacha=
ble"=20
> is the correct word.=C2=A0 The notebook's display can be removed from the=
=20
> keyboard to act like a tablet.

Ah, *lightbulb*. :)

Though arguably it's the keyboard that's detachable, as the display is
the main part that keeps working without the keyboard, not the other way
round.

BR,
Jani.


--=20
Jani Nikula, Intel
