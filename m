Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48192C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B5A10E0D8;
	Tue, 11 Aug 2026 21:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b68pZujF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E244310E0D8
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:39:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB91C600AE;
 Tue, 11 Aug 2026 21:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377761F000E9;
 Tue, 11 Aug 2026 21:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786484394;
 bh=ZqTcN1PasVGnl8221zLotA+HhEu2DCh+PLsghGoWCs8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=b68pZujFiZYFHUcUQl7v6ZjfdltHLBQAWYuK5gTsX/tWvQW9PIKECY3o3upboO4L7
 FfUn/p21RmxqrHFoKcwId6jNgEjJT7EHGf5BOcPr+TGWH81qTKzv5HrcSIUSwFusW1
 xpcQclNMu+Hi0NjzXIJvS+obFJ7kkxGVPxPOQU6+pPpiEw385WOUMLhweDnjD92dkF
 SWFTZoQS5Vocg2LBitnFMumZ+SY5in2epQfc/OikANwglrD/GBIGDvsqFRW4xuxTKu
 RuG0WMgre9/I3kwO7MbcqqIBp115DZAZA0YaaVvS7wTTmK5EcCNoupqqdoqPUCwpk9
 gmWpjYSqcAqBA==
Date: Tue, 11 Aug 2026 14:39:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Simona
 Vetter <simona@ffwll.ch>, "David Airlie" <airlied@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for drm_ras
Message-ID: <20260811143953.01329a4e@kernel.org>
In-Reply-To: <anuCGPAUpJTs7Ztz@intel.com>
References: <20260805094949.536651-2-rodrigo.vivi@intel.com>
 <anMeN5B8LbaM41jz@black.igk.intel.com> <anuCGPAUpJTs7Ztz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 11 Aug 2026 16:12:08 -0400 Rodrigo Vivi wrote:
> > > +M:	Riana Tauro <riana.tauro@intel.com>
> > > +M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > +R:	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > > +L:	dri-devel@lists.freedesktop.org
> > > +S:	Supported
> > > +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > > +F:	Documentation/netlink/specs/drm_ras.yaml  
> 
> Net maintainers, ack?

Makes no difference to us FWIW (even with a more specific entry
the files still fall under the overall YNL entry).

But the M's match the authors so why not:

Acked-by: Jakub Kicinski <kuba@kernel.org>
