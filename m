Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F95CCA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63CA10EAD4;
	Sun,  4 Oct 2026 17:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Lw6bDaXn";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14B410E029;
 Thu,  1 Oct 2026 11:12:45 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hwTlt6s1nz8vFB;
 Thu, 01 Oct 2026 13:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790853163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RElA5IDcBG9MjDWeL36bJyR6OvRK9Bk81H8oJWidKZI=;
 b=Lw6bDaXn4QChh2V3Lo+pqBq9SU7alIXImdTzWlXv4ywzC5z6e3Bt4FWvzN14mowk+umEgn
 JYxkxLSTyl5XnhLqdzsScjcr8Y/Qr2Jcy3C7StjXLMtUjqkaph1UTA+ISE1VkClmTDXK9T
 HLskPJunI4gYF1IlvKj0XzUvSmInvCCN1GXnxcTbllIdqphj7txMfUfQtUfcDjAZHykHo/
 S01v0jvPaWVeO9xFtOFgGRJMnspQtKn84xI6Zqt4G3PIXeIQAWxaZpsoOxm06CHiQunRxt
 /97nXmAB+ygnCKlQLSyfHVjwbYVlmwJ9Bc/+I5UDNDzaWt2O+1LGtqfAQ1v8lg==
Message-ID: <17aa0846-f46a-4e9a-a9d0-c32e2064fcfd@mailbox.org>
Date: Thu, 1 Oct 2026 13:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix stale replay_events after mod_power
 stream removal
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260917104234.18858-1-spolack+git@mailbox.org>
 <c5548cd7-c00f-49be-b031-c331bca4eefd@amd.com>
Content-Language: en-US
From: Simon Polack <spolack+git@mailbox.org>
In-Reply-To: <c5548cd7-c00f-49be-b031-c331bca4eefd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ge8zr7h63fq4po5awxw86kgd3n98ujo8
X-MBO-RS-ID: 119de60b7d0b5035d1c
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Thanks for the review.

Gentle ping on this one - I don't see it in any of the amdgpu trees yet.

Since the bug was introduced in 7.2 and leaves the internal panel black
after a DPMS cycle on multi-display setups, would it make sense to take
this through the fixes branch for 7.3 rather than waiting for the next
merge window?

Thanks,
Simon

Am 24.09.26 um 19:25 schrieb Leo Li:
> Reviewed-by: Leo Li<sunpeng.li@amd.com>
> 
> Thanks!

