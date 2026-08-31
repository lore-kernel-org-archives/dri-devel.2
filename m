Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE273C624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F8210E6DC;
	Mon, 31 Aug 2026 08:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="egHvMJhs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F5A10E6DB;
 Mon, 31 Aug 2026 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788163480; x=1819699480;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=Cl5NpPOdLVHO5bVj8nYOLe43QlryP/1zjbbrcAoNYp0=;
 b=egHvMJhsaPUTUCfsGpl4BSkpKNXqAnze1Z10phc2EsNIFQEpQI9coEOy
 UoCwOKtW1hHm0qol6sYVWajBZ7m8cJDiZy+Uy3J46Tre71any+mMbE42s
 /k9pvJ94IFKZratDJkCFux0k+tHOL34YkFpx8LwQrpAKVdPt8vmTpjqng
 xXf7nWqeaJjHa+HNXicdZYD32LqEYv00hjcMw2bhuG491tDwyhjlYHIE+
 8IRCVN8kr6nyGAZfOeWjp/OMbtYyS8/ZlmaAL6Jc+YM5QCSGdfEfXYiAF
 sjMniRelrR2YT/+jZVlzZ94fgOoN8CpmG+1BrqaxYjCglvnMuFvgGGszh g==;
X-CSE-ConnectionGUID: BfJEniWISIqBZlIVmVoa0Q==
X-CSE-MsgGUID: BX0a+lpkQrK5lFhR7bUNCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92251007"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="92251007"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:04:39 -0700
X-CSE-ConnectionGUID: VH6q6OATRrSq7aC9al69eg==
X-CSE-MsgGUID: mAIosUkXSSavDVXXFTNttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="268171932"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:04:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 krzysztof.karas@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
In-Reply-To: <CADhLXY4YXGWUi8JcfdYMJ4HhKMKS2RLg2WvnZnku_XK45m4-fQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260813064902.367504-1-kartikey406@gmail.com>
 <CADhLXY4YXGWUi8JcfdYMJ4HhKMKS2RLg2WvnZnku_XK45m4-fQ@mail.gmail.com>
Date: Mon, 31 Aug 2026 11:04:33 +0300
Message-ID: <79e8a3d71ca0e2cb7274aa1e5e053f934bc88333@intel.com>
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

On Sun, 30 Aug 2026, Deepanshu Kartikey <kartikey406@gmail.com> wrote:
> On Thu, Aug 13, 2026 at 12:19=E2=80=AFPM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
>>
>> pci_match_device() can return the dummy pci_device_id_any entry
>> when a device is force-bound via sysfs driver_override, in which
>> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
>> struct intel_device_info * unconditionally and dereferences
>> intel_info->require_force_probe, causing a NULL-ptr-deref.
>>
>> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Ddb96c5ff032f4292a8dc
>> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>> ---
>> v2: Drop Fixes tag, this isn't a regression from a single commit -
>>     the unconditional dereference of ->driver_data has always assumed
>>     it points into a MODULE_DEVICE_TABLE()-backed entry, an assumption
>>     broken by the generic driver_override fallback path, not by any
>>     i915-specific change. Add Cc: stable instead. (Krzysztof, Jani)
>> ---
>>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915=
_pci.c
>> index 82415af47d54..2f03f95945f1 100644
>> --- a/drivers/gpu/drm/i915/i915_pci.c
>> +++ b/drivers/gpu/drm/i915/i915_pci.c
>> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>>                 (struct intel_device_info *) ent->driver_data;
>>         int err;
>>
>> +       if (!intel_info)
>> +               return -ENODEV;
>> +
>>         if (intel_info->require_force_probe && !id_forced(pdev->device))=
 {
>>                 dev_info(&pdev->dev,
>>                          "Your graphics device %04x is not properly supp=
orted by i915 in this\n"
>> --
>> 2.43.0
>>
>
> Gente Reminder. Let me know the status of this patch .

Sorry about the delay. Thanks for the patch, pushed to drm-intel-next.

BR,
Jani.

>
> Thanks
>
> Deepanshu

--=20
Jani Nikula, Intel
