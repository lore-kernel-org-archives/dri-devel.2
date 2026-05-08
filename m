Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3291DCD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866D510F5CB;
	Fri,  8 May 2026 18:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="nz1Uvqxx";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A34610F5CB
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 18:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=nOnxCniMGpEQSI9yI2OLJhk/NMk10A2VEFF4N/EAb3Y=; b=nz1UvqxxGxTJGl/K3ewqyJJwQX
 RS2qgQCki0jw1uLfSTFK1mUabUro1rwLVKe5whpYjwp/6we/yA+a152R+c5Jd/uKYvKEDIVa8GLix
 F0dRq+MqHhbJXZ6QwUBapsCDpQ7VuQoI4kluZC/MNlVdWGjQheZF/dkXGqVUzY0Qm/m1tFSz338vj
 WHxQTAfe4wLa1M/Wx88KY+EY2g/HTpWA0NV+4y3uPqcRVgVOddWImEgNU26yqRWu3HAY9L8cdAn++
 VqkomR0csPsGsaLXQh2hwb0Qrydk+lhwqAirK3w09lVJB51hHeqg8259HReWUX/fdjvuw2JuAeZYM
 GvrUifCg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wLQ4T-00000007H44-0wCS; Fri, 08 May 2026 18:37:09 +0000
Message-ID: <8b9dc16b-ddb1-4da8-9c96-1f269b474cdc@infradead.org>
Date: Fri, 8 May 2026 11:37:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Documentation/gpu: limit main toctree depth to 2
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
References: <cover.1778238671.git.jani.nikula@intel.com>
 <cddd2d11c104132801510e3ab4e4b9ef3ea9cb6d.1778238671.git.jani.nikula@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cddd2d11c104132801510e3ab4e4b9ef3ea9cb6d.1778238671.git.jani.nikula@intel.com>
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



On 5/8/26 4:12 AM, Jani Nikula wrote:
> The main GPU documentation toctree has no limit to the toctree depth,
> which means the main GPU index page recursively includes all the
> headings in all of GPU documentation in the single table of
> contents. This makes getting any kind of overview of the documentation
> really difficult.
> 
> Limit the main toctree depth to 2 i.e. show at most two levels of
> headings.
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/gpu/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
> index 5d708a106b3f..65bf3b26e4f4 100644
> --- a/Documentation/gpu/index.rst
> +++ b/Documentation/gpu/index.rst
> @@ -3,6 +3,7 @@ GPU Driver Developer's Guide
>  ============================
>  
>  .. toctree::
> +   :maxdepth: 2
>  
>     introduction
>     drm-internals

-- 
~Randy
