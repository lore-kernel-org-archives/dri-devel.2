Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C75CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8B710E353;
	Mon, 15 Jun 2026 11:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hc6VJmRd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A6610E353;
 Mon, 15 Jun 2026 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781522072; x=1813058072;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=LibXhyMWEbKvNHjik8IFLmy2/nZh6PunuZu7k3YS+z0=;
 b=hc6VJmRdPgj8TN5o6bc4r215ASX+04hSiGNOp5loTH1DXg9ifOokqmjT
 ez+sjMRL5ugzzBr9oGrWdtAhd3foLPRQXXeUeTBQguT4wJ9bmfue3zmoG
 b16YbO+fMO8YBUJPoBRJkU2v0yOSguuR3Z2iNTwLAkF7sy7odF4NVw4IF
 OQOZTwXIJWy6RtORL0xkKfTbflidVgFPjTTnvT1JmmOMNTYfRbIdXNauk
 pwb5rEnKd6z8m/4Il6uNOnHK8NsvMUKLZSoK0LhGKYL5RY1LNNbRIQx7y
 IylYCnhx7X5yL0Q8xrCFmcbuNjLaF8U1tqN7XSFxdzx7BtWhcJ6Kh8sdV Q==;
X-CSE-ConnectionGUID: oK3BTEeiSFCG6OY+0dzzpw==
X-CSE-MsgGUID: HY8n2NHrRGKbdByZ4cBgsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82158850"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="82158850"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 04:14:32 -0700
X-CSE-ConnectionGUID: iKcVKx5yR8+DuAT4tOIruQ==
X-CSE-MsgGUID: htb7nWH5SkSRTdP0bB6xIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="251363199"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.28])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 04:14:30 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/displayid: fix Tiled Display Topology ID size
In-Reply-To: <CAMwc25ow-MehYN8u0EFkEW-JB2CYL+od9xja0WBK0-msWMHOww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260610141549.555605-1-jani.nikula@intel.com>
 <CAMwc25ow-MehYN8u0EFkEW-JB2CYL+od9xja0WBK0-msWMHOww@mail.gmail.com>
Date: Mon, 15 Jun 2026 14:14:27 +0300
Message-ID: <dcce02bcee216f44cbbd4e597a2a0b3e4e9977e4@intel.com>
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

On Thu, 11 Jun 2026, David Airlie <airlied@redhat.com> wrote:
> On Thu, Jun 11, 2026 at 12:16=E2=80=AFAM Jani Nikula <jani.nikula@intel.c=
om> wrote:
>>
>> The Tiled Display Topology ID of a DisplayID Tiled Display Topology Data
>> Block consists of three fields:
>>
>> - Tiled Display Manufacturer/Vendor ID Field (3 bytes)
>> - Tiled Display Product ID Code Field (2 bytes)
>> - Tiled Display Serial Number Field (4 bytes)
>>
>> i.e. a total of 9 bytes, not 8.
>>
>> The DisplayID Tiled Display Topology ID is used as the tile group
>> identifier.
>>
>> Update both struct displayid_tiled_block topology_id member and struct
>> drm_tile_group group_data member to full 9 bytes.
>>
>> The group data was missing the last byte of the serial number. I don't
>> know whether there are known bug reports that might be linked to this,
>> but it's plausible the last byte could be the differentiating part for
>> the tile groups, and fewer tile groups might have been created than
>> intended.
>
> I pulled out my spec, and indeed I can confirm this is the correct readin=
g!
>
> Reviewed-by: Dave Airlie <airlied@redhat.com>

Thanks for the review, pushed to drm-misc-fixes.

BR,
Jani.


--=20
Jani Nikula, Intel
