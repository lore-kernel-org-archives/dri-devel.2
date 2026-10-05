Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485B5CA5FE2
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D17B10E22A;
	Mon,  5 Oct 2026 07:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LYOhN/Hp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACD410EBB0
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791184100; x=1822720100;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TmgddlM5UD8JDlYGHNPMLMCYiIvxeOi7OBcY0y8dd48=;
 b=LYOhN/HpS8sVmkDsRrXPtYkLbB2uMRcPbQo+jqledprJ+yU2x+UNfFHH
 UuHheiKe8doeIwDSupu+CSOX7m4MjpxqMuoS/JgGbTPh4dt+oXvfjw/Xn
 OV9ppBq+HTMQGUZhv+3vLuriElTDRiAMGw87lCb/lGce5NDu7+ZvGpUHj
 L0jDf5whB0Q87F92c82tX96S8wpy/m7hg/TpBlsPrGtejd0p2+tm3Ck1z
 G7uFEC4i65Nc704b8UoCsSdkCSLuSVVOgU5COn3FdsX4bHLLqNLXXXnx3
 AvNrGYlEiBef9QNEvjEPcGK7HB3bHdhCyGoZ3Mhsjk3yETOodbxG+2nmA g==;
X-CSE-ConnectionGUID: c6lYmUmUSOCL7S8HHMdAaA==
X-CSE-MsgGUID: eeI+KkJJRY2H8Huv2/jMjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="108225164"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="108225164"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 00:08:20 -0700
X-CSE-ConnectionGUID: HQfbZUZeScC6Q7hRYDZqag==
X-CSE-MsgGUID: RdbAZaVkQ86bfmt5siuuoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="273143283"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 00:08:18 -0700
Message-ID: <e0f70d42-cc26-43af-b2cc-8044a7ec36e3@linux.intel.com>
Date: Mon, 5 Oct 2026 09:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Drop MTL interrupt clear-with-zero workaround
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com,
 lizhi.hou@amd.com, dawid.osuchowski@linux.intel.com
References: <20260930160348.1562800-1-andrzej.kacprowski@linux.intel.com>
 <eaa7b598-24be-45c5-9ab4-27bc87085d10@oss.qualcomm.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <eaa7b598-24be-45c5-9ab4-27bc87085d10@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 02-Oct-26 17:22, Jeff Hugo wrote:
> On 9/30/2026 10:03 AM, Andrzej Kacprowski wrote:
>> Early MTL steppings needed a runtime check for BTRS interrupt status
>> registers that cleared by writing 0 instead of the usual write-1-to-clear
>> flow.
>>
>> Those pre-production steppings are no longer supported. Remove the
>> workaround flag, probe helper, and conditional IRQ clear path, and always
>> clear handled MTL BTRS interrupt status bits by writing the interrupt
>> status value.
>>
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Applied to drm-misc-next.
