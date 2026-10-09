Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D24FCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5264610FEA4;
	Fri,  9 Oct 2026 06:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QDY11cet";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C8910FEA4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791526848; x=1823062848;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vGkY4dMV0KTS9y6ID2FHGSXyiGGjTuPau7tUpMwn9sQ=;
 b=QDY11cetoZJ3/ak/VFEGV5anpq8IP8xJZUFKQL0ssGALNbTVoGUZ/0yw
 kzDUsfcv+tmJRr5hr4hkxIFvDtwRqoOVc96OH1lfJ1tEz7gR6zUvisu5s
 Dcnxw68AJPg1V3JHdhGCu7Rx5V8evWtVpIx0jLTL7Pm4EOAFu+Xn8eGAA
 Dg2y73IU/TWgizOBHV13p8KXRQiZXZPqyUjO5+DsPwB0k/4eIy1WWrLJH
 zWqKe6wtssDmMabuvqyC0KExMNq2uFHdQ96qqNukLg9IW6xoz5k3f6ixa
 7lxI1wk7NKxhHjCB+b1yCIeLjtUurmcs9hPwUzHrP9watWvWsblgDdpth w==;
X-CSE-ConnectionGUID: v+pDfqPuRxugsqUreGb7ew==
X-CSE-MsgGUID: UP5jQUaEQIGIDIXJYQK2Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="321994"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="321994"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 23:20:48 -0700
X-CSE-ConnectionGUID: EfnHqO/tRrSiJ9Dy/kK4tA==
X-CSE-MsgGUID: bt+RJOYwSEi/RUZL9/jw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="342523"
Received: from unknown (HELO [10.94.255.201]) ([10.94.255.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 23:20:47 -0700
Message-ID: <e7c8236c-4ccf-4c14-8a67-3b5d6f4a2b62@linux.intel.com>
Date: Fri, 9 Oct 2026 08:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com, dawid.osuchowski@linux.intel.com
References: <20261008100013.3006983-1-andrzej.kacprowski@linux.intel.com>
 <70101d6b-8851-416c-9cc4-f4737304638a@oss.qualcomm.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <70101d6b-8851-416c-9cc4-f4737304638a@oss.qualcomm.com>
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

On 08-Oct-26 17:46, Jeff Hugo wrote:
> On 10/8/2026 4:00 AM, Andrzej Kacprowski wrote:
>> In FW_TEST mode, boot the firmware but skip the ready wait and all
>> subsequent firmware communication. The firmware test reports its
>> results through the firmware log.
>>
>> Disable driver timeouts in this mode so timeout handling does not
>> interrupt the firmware test.
>>
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Thanks, applied to drm-misc-next.
