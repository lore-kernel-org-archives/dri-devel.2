Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A056C54EFC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3943F10E30B;
	Mon, 27 Jul 2026 07:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="TRMneZbQ";
	dkim-atps=neutral
Received: from va-2-46.ptr.blmpb.com (va-2-46.ptr.blmpb.com [209.127.231.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B3910F39D
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1784948931;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=t5p4wUGLZvJdime7uAuRBuagJTt4QSVuUVEw9brtHGM=;
 b=TRMneZbQH+oPJJ5EjKiS+6cu+z36SLZjw/ULrk6rakRjQHLr0vKRctd0xPyV+DEU4XMSTq
 c/pC0lcPNkdjvDDKXVQRq00M7PblQsApoTaayFU+GC0p/f2Z7Vnkn8BFDZjlGxGacHCVaA
 EOpxYTkAywIxCRGX1FjUjB6KxPnoxbwFZCWR5zjOyeVHVEl4hTXukqDLYd2NICyo+yUPBv
 rR07/QYODqt1sIVgvv2gklIfo+NRJ/hX2wTunt0PmVmP2SW7dpOrrnqDZXfIYZOyMsFw/w
 Ff9iKWqI+DJoY6F7mWLdQyTGRXM8rdXIx3lVKj5I72toGv4JqpLl4+9Xwa+A0w==
Cc: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, 
 "Tvrtko Ursulin" <tursulin@ursulin.net>, 
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
 <oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Mime-Version: 1.0
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Subject: Re: [PATCH] drm/i915/quirks: Disable PSR2 on Lenovo ThinkPad P15 Gen 1
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Lms-Return-Path: <lba+26a6428c1+70869e+lists.freedesktop.org+oliver@liuxiaozhen.dev>
In-Reply-To: <20260717124728.11394-1-oliver@liuxiaozhen.dev>
To: "Jani Nikula" <jani.nikula@linux.intel.com>, 
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>
Date: Sat, 25 Jul 2026 11:08:39 +0800
Message-Id: <af187437-11b9-46b7-89f6-314b5d533fb6@liuxiaozhen.dev>
References: <20260717124728.11394-1-oliver@liuxiaozhen.dev>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit
Received: from [172.16.0.2] ([104.28.158.228]) by smtp.feishu.cn with ESMTPS;
 Sat, 25 Jul 2026 11:08:48 +0800
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Just following up on this patch.

The CI job could not be executed automatically, but I have not seen
any other feedback yet.

Please let me know if additional testing information is needed.

Thanks,
Oliver
