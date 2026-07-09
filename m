Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E724BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1779410E58D;
	Thu,  9 Jul 2026 18:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="HDNHPzPk";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC09D10F2EE;
 Thu,  9 Jul 2026 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=YnqarTgy0D0htDBKBMRAk90GEEctz896WdQ3FnbljDo=; b=HDNHPzPkoyRv41XVzG+0pPFbJr
 0vgwd4aQfN1IkANAY/KCtBQwgjDUr1ERCm7TLpNk1FUBxMuRHTORGi3waQsLFsTl6sVvUKR4aAGeb
 XroE4oYVnzSaFG1C8nqKAIJZ7UrzsFyo3i63OpIanzwHD2bndkOjmbhLzIeog10vtT7jOGFH1n/3R
 JnRFVjofwFHzSxlDNAj7Tn/WRUUWH/JLECjHrzsoKjmdeX1rih1oFxwUWruGAAZQmJag5W8PRej7s
 4BSUXz8CRe4IR8ChGLaXKc047t14odzEvoOtA2K6haWpOPnpshdoV77yqdGFCpXTTsNkd83s/I73N
 LLikkWXg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1whtPc-00000003DZO-3G8l; Thu, 09 Jul 2026 18:23:52 +0000
Message-ID: <54f6efe8-cab8-4fc8-bf00-f012b3224e54@infradead.org>
Date: Thu, 9 Jul 2026 11:23:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: amdgpu_dm_plane_test.ko fails to
 build due to modpost "too long symbol"
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 george.zhang@amd.com, bhawanpreet.lakha@amd.com,
 LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, broonie@kernel.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <fde3656e-9e22-4e4c-937f-7e8cb918da6b@linux.ibm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <fde3656e-9e22-4e4c-937f-7e8cb918da6b@linux.ibm.com>
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



On 7/7/26 10:05 PM, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> linux-next is failing to build for me with:
> 
> ERROR: modpost: too long symbol
> "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
> [drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_plane_test.ko]
> 
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [Makefile:2165: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> The failure occurs during modpost while building:
> 
> drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.ko
> 
> This appears to be a regression in the AMD display KUnit test code.
> 
> Could someone please take a look?
> 
> 
> If you happen to fix this, please add below tag.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Hi,
I cannot reproduce this when using gcc v15.3.0.

Which compiler & version are you using?


-- 
~Randy

