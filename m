Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D01CCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92ED710F5A5;
	Fri,  8 May 2026 18:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="pIgbwFFe";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA8410F5A1;
 Fri,  8 May 2026 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=1567wLgcWwhaW/ksGAvGq1qWNhKhan595OO6OdhsyWQ=; b=pIgbwFFeaq0r/CRz28UrtI9MDK
 MlJgiMh4J1SsbU55eRQUvMlVZ9QZJB/C5cVafdawaWp9uVI2s8qiVPWrKtx2HAmJvjNFFyPUTpq/7
 uQozFs2lr6tSuSVXUE4VEIXvhDqxKRxoykPmTGKN55tcnpV6IJt0n3J8G5rGCjksAPBWLFFMfdABd
 DXfLiETzfATSTYxohnVBtOWyeNBGY9Vnxm4VlqGC1FW+6pvu4HMNobWdQqtyPKyfdyjyMMMVwK9G8
 AAvYMfL8Ul/cOBSUxDum0xBbx5z/SJj2K2kXXOXZzCmDji2bM2wg+gx9uTgjTIkhUywpWr4j/PMGZ
 Jrjdb/EA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wLPqW-00000007FW4-1htp; Fri, 08 May 2026 18:22:44 +0000
Message-ID: <8b57be01-2811-414b-a18b-d5bf619e5ad1@infradead.org>
Date: Fri, 8 May 2026 11:22:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Documentation/gpu: use === for Intel display section
 heading underlines
To: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Cc: rodrigo.vivi@intel.com, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net
References: <cover.1778235406.git.jani.nikula@intel.com>
 <f49968792220ca3ff24efde813550850340d092e.1778235406.git.jani.nikula@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f49968792220ca3ff24efde813550850340d092e.1778235406.git.jani.nikula@intel.com>
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



On 5/8/26 3:20 AM, Jani Nikula wrote:
> Prefer to use === instead of --- for top level section heading
> underlines to allow using the latter for sub-headings later.
> 
> While at it, fix the underline lenghts where needed.

                                 lengths

> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

 
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
