Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A84CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CF710E3D1;
	Tue, 19 May 2026 14:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="GANpHPK1";
	dkim-atps=neutral
Received: from dormouse.ash.relay.mailchannels.net
 (dormouse.ash.relay.mailchannels.net [23.83.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF2010E3D1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:37:27 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 59FA1720588;
 Tue, 19 May 2026 13:59:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com
 (trex-green-3.trex.outbound.svc.cluster.local [100.109.25.249])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id D270272188C;
 Tue, 19 May 2026 13:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1779199196;
 b=UICybyjvqK+9gv0mHnr3Gqt5yyQ41AwfyFNKuaHyAFZWBjzY1S0GSmM/PqEqyP0Wxk1lyl
 HR8GoiGWWIWNtNL4IAbEZtqV9YDqRxIbPBVsd8NzdXSpJXqRYrSB3Qn3cz1KvGrMzI5sP0
 HW6WsRGmSn32tjN4zawvVHJPtxef3NCbwmahK92Z34fbnfEQykVza6QIgBVkHHmlbiegq3
 2/kvmQ1+nGdBXfyVNLPgIUfAHy+H/WMTA5DZfOCgid+tooIxytYPPUsrV4PxImjL7j/CVj
 50rwhj9Fiw7+HIiQEDaMnaPU4ec7L1z5np2n2Onju1RVMpeyREKsJSU32UBwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1779199196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 dkim-signature; bh=jFxOgosKVa9ofCbZHaIOL9XiRrG91n8Kyi+HJW0U5gA=;
 b=YF3O6HTiBeYsDs9TAua0xzSKfBmq1jG8uMce47Vd9uiFSM757zdeqv8cOqLOcn4rK0CmTN
 4zW+O2m8puIPFMWbWz86EkFniUyIbOguINu3GrROIxdQQHnlzDu9x7UJd8kCs+9K3a1O2C
 WPFerDcfhmOxzTNyyRoS5PJZo51XaW4WOpfJ6mRS+voqrbkJarySzfB6rC6tkAwembWxAp
 bkMEXDz8B8gYKI8e8TYpmyzJvxADZXr5/lPunHy8E7dP3Hq/pRoaHxPEU9IJrd+vEdlObC
 txdVKoJXBPxipiS/TkdXA+Q96r+JQCWo7PDBMS0LN6vfRkKrRW9Mx9DtDe/E/A==
ARC-Authentication-Results: i=1; rspamd-54674b4cbd-brtcq;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Hysterical: 249efd135791aa8f_1779199197226_80967156
X-MC-Loop-Signature: 1779199197226:4283785261
X-MC-Ingress-Time: 1779199197226
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.25.249 (trex/7.1.5); Tue, 19 May 2026 13:59:57 +0000
Received: from offworld (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4gKbs82NT2z106M;
 Tue, 19 May 2026 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1779199196;
 bh=jFxOgosKVa9ofCbZHaIOL9XiRrG91n8Kyi+HJW0U5gA=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=GANpHPK1WffqqXdiP/4KXPQp/S+JFICRzsVSrF+yDVEy3EuzL+K48e96dZc7EYbvk
 eF2c1F0bdwKRhSnyIjy8n1R6KpmRZCv1Z8pHdHrbgmzuo6RaODvbOQlpQU39ysefMq
 5rICplTx/G8jRW72YZWANehMuhiQ4dlxJRg9Iw8y+hJvI4EG5lhBTpd7RrilwN7V+p
 83mwfMOnP3HEn20Ln5MET6xzu3I2xSO/xnS105QjFksVslvms+gOkTTTmGED0PKQbk
 ABx67NMAeMMfzgzCEmybcHUrio06+UM6VFY/jV/KLjDK6mpVc7TV0vnYaAgoc+49I1
 rYHSPdJlNSCPQ==
Date: Tue, 19 May 2026 06:59:53 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: djbw@kernel.org, jic23@kernel.org, dave@stgolabs.net
Subject: [ANNOUNCE CFP] Linux Plumbers 2026 Device Memory Microconference
Message-ID: <20260519135953.v74dnpyi4i62diyr@offworld>
Mail-Followup-To: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
 djbw@kernel.org, jic23@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20220429
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

Hello,

Linux Plumbers Conference will be held Oct 5-7 2026 in Prague, Czechia,
and will host the Device and Specific Purpose Memory microconference[0] for a
second year in a row. Co-lead by Dan Williams, Jonathan Cameron and myself.

The call for proposals and topic submissions is now open. Please submit
your proposals by July 24th at:

        https://lpc.events/event/20/abstracts/

and select "Device and Specific Purpose Memory MC".

Examples of topics relevant to this microconference:

- NUMA vs Specific Purpose Memory challenges
- Core-MM services vs page allocator isolation
- CXL use case challenges
- Hotness Tracking and Migration Offloads
- ZONE_DEVICE future for Accelerator Memory
- ZONE_DEVICE future for CXL Memory Expansion
- PMEM, NVDIMM, and DAX "legacy" challenges
- Memory hotplug vs Device Memory
- Memory RAS and repair gaps and challenges
- Dynamic Capacity Device ABI
- Confidential Memory challenges
- DMABUF beyond DRM use cases
- virtiomem and virtiofs vs DAX and CXL challenges
- Peer-to-peer DMA challenges
- CXL Memory Pool Management
- Device Memory testing

You can get an idea of the format and accepted topics from last year's
session[1].

We look forward to your proposals, discussions and seeing you in Prague.

Thanks,
Davidlohr

[0] https://lpc.events/event/20/contributions/2331/
[1] https://lpc.events/event/19/sessions/238/
