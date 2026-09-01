Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0177BC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A0010E1DF;
	Tue,  1 Sep 2026 07:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="RfRQzq0k";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B7F10E1DF;
 Tue,  1 Sep 2026 07:16:28 +0000 (UTC)
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hYxx61pq6z4L0S;
 Tue,  1 Sep 2026 09:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1788246986;
 bh=giw57R9vlBUvdZcHVtCqaZU3VT7zse1sdsnLh6IZMKI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RfRQzq0k+tK14PKK0cWEq+Evv1fArAtVU3IBC7L7K0w/J2URAACguBsycYQKbtO4o
 t20tc/HpcQBIs09PpoBkVePn1w7IL7/LCXgUUwVeMRu9tWD8c4AFoQkvTg1CQYhQWy
 Fspr6+qyTavrPb16TktyE3y9HPFcS6YF8I5NR+SQ76OuK+h2MaS6Fs8ciDrS7CBxVp
 7KiFSwq03vzcbQIcHHoR4VLsO9Y8W56r8ckNWSA2NUYaxtpkrVNKGzE4zczj+3na5p
 rJteLfOvaj4jduz/nN7ebF2hGyzhlHkcUeAhN0jZZuLDtpMAN1bZRtpER38MyGPnSS
 hFZKEYqxGOzjw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hYxx61781z4KyJ;
 Tue,  1 Sep 2026 09:16:26 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hYxx51SMxz8svJ;
 Tue,  1 Sep 2026 09:16:25 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 379E95F98C;
 Tue,  1 Sep 2026 09:16:19 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <83f89e11-b265-4d12-97c0-f158e0b5b82d@leemhuis.info>
Date: Tue, 1 Sep 2026 09:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] amdgpu: "pixel format with alpha exposed but blend
 mode not setup" warnings introduced in v7.3-rc1
To: Robson Candido dos Santos Alves <robsonalves.us@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: regressions@lists.linux.dev
References: <CANkdJ2VvJQSBzyOq=LgSW1=Z8-YiN_r9Py2iJ0UJDo55+dbfuA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CANkdJ2VvJQSBzyOq=LgSW1=Z8-YiN_r9Py2iJ0UJDo55+dbfuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178824697950.2731295.11196110282821243794@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 379E95F98C
X-NC-CID: MAf1tU9bgCNGZE5oosB4AquQ/DfiCaYaM4iKe1TZEy+AgA+ArtA=
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

On 8/31/26 15:46, Robson Candido dos Santos Alves wrote:
> 
> After updating from kernel v7.2.2 to v7.3-rc1, several DRM plane
> warnings regarding unset blend modes for pixel formats with alpha
> channels started appearing in dmesg during initialization.
> 
> Good Version:
> - Kernel: 7.2.2-070202-generic
> - Display Core: v3.2.384
> - Result: Driver initializes cleanly without plane/blend mode warnings.
> 
> Bad Version:
> - Kernel: 7.3.0-070300rc1-generic
> - Display Core: v3.2.392
> - Result: Driver emits the following warnings in dmesg:
> 
> [drm] [PLANE:44:plane-0] pixel format with alpha exposed but blend
> mode not setup. Please fix.
Thx for the report. Not my area of expertise, but I guess that is caused
by 9813e158d13d ("drm/drm_blend: allow blend mode property without
PREMULTI") and will be fixed by the patch set "drm/atomic-state-helper:
fixes for blend-mode-prop warning":
https://lore.kernel.org/all/20260826104143.39077-1-mwen@igalia.com/

That patches are afaics scheduled for inclusion in 7.4 -- but afaik the
the warning is safe to ignore.

Ciao, Thorsten

#regzbot introduced: 9813e158d13d

