Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395B0C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7631A10E455;
	Mon,  7 Sep 2026 06:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JU3rRnaN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1698110E422
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788761625; x=1820297625;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WyZEOe/8WNcKzx++GrjP+DxTVk00+yCxjVvWmuGeoCQ=;
 b=JU3rRnaNEO2scN5Yoeq0kWx2ReGdtJbwrErjHm0Xw53kZm9f8HAQOEsK
 78yBqBnDgyERJiCThW1Gi8cngYvbzBhnvVCJbTiTdoM5cqa5vzHszYuoc
 ExrBsnGs/E+L5OHlZ9unauxZIuxzu2bi4rQ6zTUoEOsgm8BUzhnuSNlXd
 LNIm2T53j6HgRLPsAI/ZdZ9pFYp7dd7AMfI6K8aGptK8drQfiQuuUqP/K
 irJnlDDVNxHPiRnwenxyruJWlVcPl+5an+D/R3PQJ/sKZoOzYkCDm0WtH
 FDa8XLWKzWL+RAeTJStP603yVjwEAA0jAiDobFGYj7uaNKY3aDgtn7iGV w==;
X-CSE-ConnectionGUID: UhyG+KaWQE+0mMJMbMrj5Q==
X-CSE-MsgGUID: 0Jv4oakzQ66n89b22yAFHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="111935090"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; d="scan'208";a="111935090"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2026 23:13:44 -0700
X-CSE-ConnectionGUID: cGkTo/f4S2mCotsuEtKA9Q==
X-CSE-MsgGUID: /6hvQOk/RFWVh3PBXpIROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; d="scan'208";a="268882536"
Received: from unknown (HELO [10.217.180.22]) ([10.217.180.22])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2026 23:13:42 -0700
Message-ID: <96771f7b-e3cd-44b3-921d-9d8e8bc1a5fa@linux.intel.com>
Date: Mon, 7 Sep 2026 08:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] accel/ivpu: Harden parsing of firmware-shared
 buffers
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
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

On 01-Sep-26 14:57, Dawid Osuchowski wrote:
> The IPC and firmware tracing buffers live in memory shared with the NPU
> firmware, so every field the host reads from them is untrusted input.
> This series fixes places where the host trusted such input and could
> end up dereferencing addresses outside the underlying BO.
> 
> All patches are tagged for stable.
> 
> Changes since v1:
>   - Added a new patch ("accel/ivpu: Limit firmware log name prints to
>     field size") after Sashiko pointed out that log->name was still being
>     printed with an unbounded "%s" conversion. The field is fixed-size
>     and expected to be NUL-terminated, but a firmware bug could drop the
>     terminator; harden the host against that case.
>   - No changes to the other two patches.
> 
> Dawid Osuchowski (1):
>    accel/ivpu: Limit firmware log name prints to field size
> 
> Magdalena Schulfer (2):
>    accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
>    accel/ivpu: Validate firmware log buffer metadata
> 
>   drivers/accel/ivpu/ivpu_fw_log.c | 87 +++++++++++++++++++-------------
>   drivers/accel/ivpu/ivpu_gem.h    | 14 +++--
>   drivers/accel/ivpu/ivpu_ipc.c    |  7 +--
>   3 files changed, 67 insertions(+), 41 deletions(-)
> 

Thanks,
Applied to drm-misc-fixes.

Karol
