Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD99BC5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DFC10E62F;
	Mon, 10 Aug 2026 06:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=freenet.de header.i=@freenet.de header.b="iy9B403w";
	dkim-atps=neutral
X-Greylist: delayed 312 seconds by postgrey-1.36 at gabe;
 Sat, 08 Aug 2026 14:46:02 UTC
Received: from mout.freenet.de (mout.freenet.de [194.97.212.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2EC10E013
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:46:02 +0000 (UTC)
Received: from [2001:748:400:2319::3] (helo=sub2.mail.fnrz.de)
 by mout6.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port
 25) (Exim 4.98.2 #2) id 1wsiEB-00000007vHR-32Me
 for dri-devel@lists.freedesktop.org; Sat, 08 Aug 2026 16:40:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de; 
 s=mjaymdexmjqk;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
 MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=pklBzwPisfaINZFQGSEbGVPU9z5DjTP63E7z2cjQ8CI=; b=iy9B403wAmeTDKjMLWsW9eF123
 EZjDm2TDm5nKGBxzJjbY2KYAfVAFXxoU4VKhOHboYKI3ZE0BJeaFEkHDfLOVpRH6vBWmoa8X/KesK
 go2JLM+lBQOAu18JZK/7ZJzVdqxWA/Kb4z2GV9yB2nIyaYPSTLczd7RVt9Fcv/u4eZfiu2MiWSy8E
 q0AKiVioigDiuTES7LptTie4t5d4Ter2J6luRFTQjlJueqlYm21MOoaj0zDU9dRZN0Xru78hzwtgw
 4IsA6zvBh2oaHnsI+eLVRpS34XPN8aj8jVEmuoXJWhZWbDO4wcZ6BtyHLz7uJ9w6ISYpxMWnoaf9R
 dLdP24IA==;
Authentication-Results: freenet.de;
 iprev=fail smtp.remote-ip=2a02:8071:a85:f020:2272:9ada:5bb9:cee1;
 auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:2272:9ada:5bb9:cee1] (port=36090
 helo=[127.0.0.1])
 by sub2.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de)
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim
 4.98.2 #2) id 1wsiEB-0000000D8V0-2TAA
 for dri-devel@lists.freedesktop.org; Sat, 08 Aug 2026 16:40:47 +0200
Message-ID: <a7319e96-501d-42d4-ab4f-03df83f64eec@freenet.de>
Date: Sat, 8 Aug 2026 16:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dri-devel@lists.freedesktop.org
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
Subject: Strategy for merging drm-next into the mainline kernel
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 178620004719EF59571A0EO
X-Scan-TS: Sat, 08 Aug 2026 16:40:47 +0200
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi,

I tried to merge the drm-next branch from
https://gitlab.freedesktop.org/drm/kernel.git
into the mainline kernel by using
$ git merge <drm-next branch>
but I got several conflicts, so I aborted the merge.

In general, given that conflicts only appear in drm code, is using
$ git merge -X theirs <drm-next branch>
the correct way to resolve these merge conflicts when drm-next is merged
into the mainline kernel? Or is there no general conflict resolution
strategy, which means that each conflict has to be dealt with carefully?

Regards,
Viktor
