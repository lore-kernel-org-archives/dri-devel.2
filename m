Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC344CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F60D10E095;
	Fri,  8 May 2026 18:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="2oVuIEaO";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D36710E095
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=6NMoLqHFyd73ffPyW0rx+cIGr/qHa00Gmqg55Y3BWCQ=; b=2oVuIEaOSc1+rFoRk1jvwl7Gd7
 3CYLzxXlAcsxUHbaZKY4hfuPukaEcJ33/3hMtEL4iWWnrC5ik5SfP4n99ZZ5c4P4tV89iiC/nf2KN
 k7E0GKuCJrQd7sKlLfPD0kyM8Pub6Sw0uIzgj8mV2O7Uq4ONsRX0+60Qj4OZRyKR3jrwYLzPvkFeb
 lrxU9HmWJ1q+DiwxjmozWau7EQ0aEmXVzzVA/R3IUZF0Zz9F15I8/LnZhs4Npc1+6pRt4/CcuqgoJ
 IKCmyqPowUXyx6J/dV4Eh4T0gyIEdsKaldRCYCFct94iTseNnpKR5Pj0xcE+iJfkpsQlMPtHLsDJt
 IioR0BcQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wLQ4D-00000007H39-0kCX; Fri, 08 May 2026 18:36:53 +0000
Message-ID: <b7b5c3d1-faec-4fc7-b018-8ede57214849@infradead.org>
Date: Fri, 8 May 2026 11:36:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Documentation/gpu/rfc: fix toctree
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
References: <cover.1778238671.git.jani.nikula@intel.com>
 <c9678a78749a71cf86941f37116232dbc7c23b5f.1778238671.git.jani.nikula@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c9678a78749a71cf86941f37116232dbc7c23b5f.1778238671.git.jani.nikula@intel.com>
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
> Just one toctree is enough. The .rst suffixes are superfluous in the
> toctree. Fix indent. Add missing newline at the end of the file.
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/gpu/rfc/index.rst | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/gpu/rfc/index.rst b/Documentation/gpu/rfc/index.rst
> index ef19b0ba2a3e..26a7ebe6fb44 100644
> --- a/Documentation/gpu/rfc/index.rst
> +++ b/Documentation/gpu/rfc/index.rst
> @@ -18,23 +18,9 @@ host such documentation:
>  
>  .. toctree::
>  
> -    gpusvm.rst
> -
> -.. toctree::
> -
> -    i915_gem_lmem.rst
> -
> -.. toctree::
> -
> -    i915_scheduler.rst
> -
> -.. toctree::
> -
> -    i915_small_bar.rst
> -
> -.. toctree::
> -
> -    i915_vm_bind.rst
> -
> -.. toctree::
> -    color_pipeline.rst
> \ No newline at end of file
> +   gpusvm
> +   i915_gem_lmem
> +   i915_scheduler
> +   i915_small_bar
> +   i915_vm_bind
> +   color_pipeline

-- 
~Randy
