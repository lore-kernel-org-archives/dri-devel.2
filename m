Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339B610A88D4
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A386610E17E;
	Thu, 26 Mar 2026 15:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bq3aJp/9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4D810EAB2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=79PooYTcjpn0OJy43B3sHJHXWnuNr5NqSKvPV4Iqa8A=; b=bq3aJp/9M4xmm2rRxvb+0nsZoB
 zb3VkDcA+6eMCsnPFE8TK4aAa0DZZ1Y5WI7lxGoHOFqQ9H9O4gMr4h/p7keUwcg8NZ3rf4oKyf3jO
 0j56U/ngveTU3oY9fRAHG5B7phnzQo953qCPYcnIDN00Y5IqtK+Oj2GmnZkGUyL5LcVtiYgdxNECz
 PEAovblXf89PfnJdY4bN2nPomkwbI3ZlwWAej7XqRgA8fZ+WHhCwX1OcppaD5zujQK8xuJ93AvDNQ
 aNkn0GawVdV8bwkr6WmPAanE2WHe4dIdunneJNEydnrOGNNhpbRYlvF4Uv7waKhbcbWgDUwYR2beJ
 sOPaDTsQ==;
Received: from 179-125-71-253-dinamico.pombonet.net.br ([179.125.71.253]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w5mZJ-006OEU-Np; Thu, 26 Mar 2026 16:24:22 +0100
Date: Thu, 26 Mar 2026 12:24:15 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
Message-ID: <acVPnzeUS0jiUioj@quatroqueijos.cascardo.eti.br>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
 <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
 <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
 <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
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

On Wed, Mar 25, 2026 at 06:40:40PM +0100, Maarten Lankhorst wrote:
> Hey,
> 
> Den 2026-03-23 kl. 18:37, skrev Thadeu Lima de Souza Cascardo:
> > On Mon, Mar 23, 2026 at 05:46:28PM +0100, Maarten Lankhorst wrote:
> >> Hey,
> >>
> >>
> >> Den 2026-03-21 kl. 20:27, skrev Tejun Heo:
> >>> Hello,
> >>>
> >>> Generally looks okay to me. One comment on 3/3 — the naked xchg() in
> >>> set_resource_max() needs a comment explaining why it's used instead of
> >>> page_counter_set_max() and what the semantics are (unconditionally sets max
> >>> regardless of current usage to prevent further allocations, since there's no
> >>> eviction mechanism yet).
> >>>
> >>> Applied 1/3. Maarten, Michal, what do you think?
> >>
> >> Yeah probably drop 2/3 too since there is no longer a case where setting a limit may fail.
> >>
> >> Kind regards,
> >> ~Maarten Lankhorst
> > 
> > Actually, this can still happen if an invalid region name is given.
> > 
> > So, one could write:
> > 
> > echo -e 'region1 max\ninvalidregion2 max\n' > dmem.max
> > 
> > And even though setting the value for region1 would be applied, the write
> > would return -EINVAL.
> 
> Makes sense. It would be good to validate in advance then. If that's not possible we
> should at least not error when we try to update 2 regions simultaneously. Likely the
> best to do so anyway if we want to handle eviction, which may be handled in a blocking
> fashion.
> 
> Kind regards,
> ~Maarten Lankhorst

I have submitted only the last patch with the additional comment for now.

If it turns out that eviction is handled, you bring up a good point that
doing it in a blocking fashion may lead to an underisable effect where
setting the max and starting eviction for one region may be delayed by the
eviction of a previous region.

Is there any reason to keep the support for handling multiple regions in a
single write?

Thanks.
Cascardo.
