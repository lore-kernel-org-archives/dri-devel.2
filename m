Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1564FCD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB9C10E27E;
	Wed, 13 May 2026 08:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IW556iMo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559D110E27E
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778660438; x=1810196438;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=mrdlhu4L+5Fb+HroFyhZzTheHKDHNYLLO+UYk14lJiU=;
 b=IW556iMon2EOhC9ezdryalhuoxKUvi1boKW7Pn9RrHlMhSq6iETd2x5c
 6EfKrjKM21ZjUE837XJym9EWPXkHt/nLA2znsl13SOgBpSRbhrWAeuVI8
 v94wV/nO2kLHuwpLeAPAZkaROCkEpwO8z+dFUkoHKWpo73f9BaN6Q6WzX
 QczEh7VVrdzJGWuiFCUn4hPS+jVfvUWwQwaxxky11eYO8iU+KhASVxCly
 JHXHOQhDLYaCa7qjFSV0au9FR27BPDj1YY4lOoGjZVb2bLw9+DXLVKil7
 MXRQiHlZYmIkvr8X+K1bzPFNjZuXS7OjgQ+Tgzvw0jdQTdllwbZkSu98x Q==;
X-CSE-ConnectionGUID: 4e5P6bVFQEyU49c/fMBomw==
X-CSE-MsgGUID: Bx0e2rmSR/afKtwXfN+TRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90964834"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="90964834"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 01:20:38 -0700
X-CSE-ConnectionGUID: aCCnmUyiQVS60myjFC3GXw==
X-CSE-MsgGUID: srWToqpPQKCZ43MRgj/5Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="233743494"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.61])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 01:20:36 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, Maxime
 Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/3] Documentation/gpu: tables of contents cleanups and
 fixes
In-Reply-To: <875x4uw3bo.fsf@trenco.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1778238671.git.jani.nikula@intel.com>
 <ad1be55a146a3680ad920588a7cfdbc154b8a4fc@intel.com>
 <875x4uw3bo.fsf@trenco.lwn.net>
Date: Wed, 13 May 2026 11:20:33 +0300
Message-ID: <12f1a26615464dcdf0c0f08872ac2deb8aefa947@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 11 May 2026, Jonathan Corbet <corbet@lwn.net> wrote:
> Jani Nikula <jani.nikula@intel.com> writes:
>
>> On Fri, 08 May 2026, Jani Nikula <jani.nikula@intel.com> wrote:
>>> Make the GPU documentation slightly easier to navigate.
>>
>> Maxime, Thomas, Maarten, Jon -
>>
>> Any preferences which tree to merge this through? I'm thinking either
>> drm-misc-next or docs-next.
>
> Usually I stand back from DRM docs, expecting them to go through the DRM
> tree.  I can certainly pick up this set if that's best, but I wasn't
> expecting to.

Thanks. Since I got no reply from the others, and thought this was
benign enough, I went ahead and pushed this to drm-misc-next.

Also thanks Randy for having a look at it!

BR,
Jani.


-- 
Jani Nikula, Intel
