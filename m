Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549FDCD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 20:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8FA10E0AE;
	Tue, 19 May 2026 20:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="OT0e1kZE";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="Rvj5pUE6";
	dkim-atps=neutral
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60C810E0AE
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=; b=OT0e1kZEf/G0gsee1vE6CaU3OW
 QQUEMFWLNqFY3n/9emT1ZTy30Gj3nyTS/yuKEtjLlEvH+cMNRgbApGckp9hjPCLszf9M8lruTRNeW
 0DO8ECcpQHs/vtpwZY9hUFIOBX1heowYhoTZLA/DE7RbKQ8ieG1qo6lFuKbVBGSA6It8svCiX8KjL
 8i7OBZlmDtAfwP2nFVWZpN8dSOsGHBVJwav/4Za8zBHtfZYDB5EVTkMh/u7/4XcOWqnrolXyIdsWa
 1KsmUUdL0kQk16c1mpikE5hjKNzuibWYrpfXYJWGAzXv4kBKx+0Yln7wQw8XDtVLCAXVgXaSa96L+
 lLtOBdUg==;
Received: from localhost by mail-01.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wPQxk-006C1k-3B;
 Tue, 19 May 2026 20:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222160; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=;
 b=Rvj5pUE6tHPJ3n0nyeD0Fp3ujd5kmVRngnjzkaEezd0bQPFlbutxxGuCrsf3ekWep6fO9
 K1cOYwFHraDH6dUpUY5+rCTetFVSwhtG87knG2I2XrIqNt+RRJJ5VOrvC4QnGckST2uc0FC
 KdZceiq8DBmhZKpbGuZmQCX+DdmmSNjJ3UMI+ifdRk+x/aq6m/6c8qyYvT3oN7hYXvG24X3
 r/gX89jObgGr9YQ2XejSQtn0JylfvwUpsqsv2YyG8SATxthKlVcL+wNEtTZ2w2l+7Ra8XTc
 D6n618ojpAlWKRVnCIkbOlNOim2Kde5iY9rCVYrxajng6ignKqsrkeTqq3ww==
From: Berkant Koc <me@berkoc.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 K. Y. Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden
 VSP request paths
Date: Tue, 19 May 2026 22:20:28 +0200
Message-ID: <v3-reply-03-reply1.1779222028@berkoc.com>
In-Reply-To: <SN6PR02MB4157D595B990A321BFA85B40D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-cover-v2@berkoc.com>
 <20260517-drm-hyperv-patch1-v2@berkoc.com>
 <SN6PR02MB4157D595B990A321BFA85B40D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

Hello Michael,

Thanks for the CoCo context, that lines up with what is in
vmbus_devs[] for the framebuffer device. The piecemeal approach is
what I am aiming for here.

v3 is on the list and addresses your three concrete points:

> This change should probably be a separate patch, as it's not really
> related to the bounds checking issue.
> [...]
> All that notwithstanding, I don't think your fix is needed in its
> current form.

Dropped from v3. You are right that the negotiate-version and
update-vram-location timeouts let hyperv_vmbus_probe() bail out and
free the device, so the stale-completion path is only reachable from
hyperv_vmbus_resume() after a get_supported_resolution() timeout.
That is a narrower fix and belongs in a separate patch against the
resume path, which I will send afterwards.

> Is there a separate problem here in that preferred_width and
> preferred_height are not set in the pre-WIN10 case?

Yes, separate problem, and I missed it in v2. The pre-WIN10 branch
in hyperv_connect_vsp() sets only screen_*_max and leaves preferred_*
at zero, which is inconsistent with the WIN10-failure path.

> Also, having to duplicate the fallback code is distasteful. Instead
> of having an "else" clause, maybe have a follow-up test for
> screen_width_max [...] being zero as an indicator [...]

Adopted in v3. The else branch is gone; the WIN10 path runs the probe
and the post-probe block applies the WIN8 defaults whenever
screen_width_max is still zero. One source of truth, both paths
converge on it.

> In my view, your commit message is a bit too detailed.

Rewritten in v3. The bounds check and the WIN8 fallback are now one
short paragraph each, focused on the "why".

Series: <cover.1779221339.git.me@berkoc.com>

The v3 patches carry an `Assisted-by: Claude:claude-opus-4-7
berkoc-pipeline` trailer per the kernel coding-assistants policy.
Code, analysis and review responses are mine; the model is used as
a structured reviewer under human verification.

Thanks,
Berkant
