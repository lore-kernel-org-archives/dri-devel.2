Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AB1CD5BD5
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 10:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB5710E13D;
	Mon, 25 May 2026 10:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="N1v33egE";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5593710E05A;
 Mon, 25 May 2026 10:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1779703961;
 bh=+MxXb4nBc7rJZhFiYVaR3/C1CkpWdublLqUdpodHn/s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=N1v33egEjVp+yHxFpO90Oyz5Zz/AaLQNzN6kGfKTshEV0J/Zuam7/Yen0nMEjzcBf
 nwPqveqi7zQvjSwL93xqT3lZxYYMjyor4GOfILYHIn6D4ixMjmbcNomyE/AMvA1ixz
 MCoeMlyAMhMFnip/hTpDcp2R6QwbIQdw/dKUjFUGa2TdazTOcDdSDO6fk4fdmLJNDr
 X9MY6O62D0Ot5NSOgVLS0P/OO7CfIRvn8KM4gs8EKdRrPDdC7nCOy9UHwzUfIGZBDq
 rbiKHIgLJ0EZy6/A33Jkr/d4FsW8yNIm7g8lJK1EZ8fvttdAyJ3uOF/ZHjEGI2JIah
 fWyjsMOfMZc/w==
Message-ID: <f36a6be9-940f-4ad9-acef-5e192f0ed8fc@lankhorst.se>
Date: Mon, 25 May 2026 12:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/intel/display: Add support for pipe background color
 (v4)
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
 Chandra Konduru <chandra.konduru@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>
References: <20260505200133.636584-2-dev@lankhorst.se>
 <a734e41d-3665-402b-a56a-43fd4f8819ff@intel.com>
 <fef9056c-460e-4a49-bed8-f2882109e886@linux.intel.com>
 <090aca95-975d-4564-8b44-30df139800b5@intel.com>
 <f1f09a62-b36e-4ddf-b42c-dad300a72aef@lankhorst.se>
 <a24f9d8ecff945b2cdc032ae95bdc834ee9c248a@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <a24f9d8ecff945b2cdc032ae95bdc834ee9c248a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hey,

Den 2026-05-25 kl. 11:39, skrev Jani Nikula:
> On Fri, 22 May 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
>> Den 2026-05-18 kl. 12:47, skrev Borah, Chaitanya Kumar:
>>> I will leave the name change up to your discretion. The i915 CI needs a re-run, though.
>>>
>>> With the typo and checkpatch issues fixed, LGTM.
>>>
>>> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>>
>>
>> Addressed and renamed the functions.
>> Pushed!
> 
> Please do not change patches while applying.
> 
> It's only okay to tweak commit messages, whitespace and maybe comments,
> but function renames need a new version on the list. There are no
> exceptions.
> 
> Commit e2d57ceaa72d ("drm/intel/display: Add support for pipe background
> color (v4)") in the tree says it's v4 and references this patch, but
> they're not the same.

Thanks, I'll be more careful next time. I did compile test to ensure nothing would break,
but send a new version next time and wait for CI results.

Kind regards,
~Maarten Lankhorst
