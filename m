Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B83EE98FA8
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5ADB10E200;
	Thu,  9 Apr 2026 05:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O1ALvW5I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7182310E192;
 Thu,  9 Apr 2026 05:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775712912; x=1807248912;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7npnzABvqfg2jz0cdMpucuiHpYVl7AsGFV3xItDNmN0=;
 b=O1ALvW5IC8xfA1h62WrOnHGsH2xPLAK7a8mB2Cq1OAhB3zhys44pOnIl
 TP65lkxydco8bWStowhbQxGnD4B03Z71uvAB604/iHktupsb92jvoTnQf
 IeWoouU9FdoLa4/6IIQ3KD1SOmV/OyAnSXkq9/dfKDs1QnmqUa0PCNzEH
 sRPqKd7yiNks7tE//dSjbbr7wsTwtX10j+ecAF+XgvoGlOrKmsG3aOHk3
 jbaxQ8HPEMImiftNspca4EXGs7yVyZwmqnbGJ6xe/9X003GbjkoII0Hgm
 /lff/cpkFFYOAcJZM3GgNufmors41BVedfRpnyYVv8ysyPFmHlQcIHcr6 A==;
X-CSE-ConnectionGUID: wIYjqtbHQomiOs5mXEAFgg==
X-CSE-MsgGUID: C3MZHqTMRGKpZZohtt4dkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87786557"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="87786557"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:35:12 -0700
X-CSE-ConnectionGUID: gniwR4MZR928eHdSjeG6YA==
X-CSE-MsgGUID: VjNMsctqTh2nSkTBfIR0/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="230338182"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:35:04 -0700
Date: Thu, 9 Apr 2026 07:35:01 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: aravind.iddamsetty@linux.intel.com, rodrigo.vivi@intel.com,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, anshuman.gupta@intel.com,
 joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
Message-ID: <adc6hTz-xMopiJsc@black.igk.intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
 <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
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

On Wed, Apr 08, 2026 at 07:59:33PM +0530, Tauro, Riana wrote:
> On 3/25/2026 7:01 PM, Raag Jadav wrote:
> > On Wed, Mar 11, 2026 at 03:59:17PM +0530, Riana Tauro wrote:

...

> > > +Example: Listen to error events
> > > +
> > > +.. code-block:: bash
> > > +
> > > +    sudo ynl --family drm_ras --subscribe error-notify
> > > +    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
> > Can we also have error-name and node-name? I'd be pulling my hair off
> > if I need to remember all the ids.
> 
> Yeah makes sense. We can add the node_name, error_name.
> Adding device_name would also be more useful in the event.
> 
> @Rodrigo/@aravind thoughts?
> 
> > 
> > On that note, I think it'll be good to have them as part of request
> > attributes as an alternative to ids (also for existing commands) but
> > that can done as a follow up.
> > 
> We cannot use names as alternative because it won't work for multiple cards.
> example in xe: Suppose there are 2 cards and each has 2 nodes. We cannot
> query using node_name+error_name.
> Also most of the netlink implementations use id's as unique identifiers.
> 
> $ sudo ./cli.py --family drm_ras  --dump list-nodes
> [{'device-name': 'bdf_1', 'node-id': 0, 'node-name': 'correctable-errors',
> 'node-type': 'error-counter'},
>  {'device-name': 'bdf_1, 'node-id': 1, 'node-name': 'uncorrectable-errors',
> 'node-type': 'error-counter'},
>  {'device-name': 'bdf_2', 'node-id': 2, 'node-name': 'correctable-errors',
> 'node-type': 'error-counter'},
>  {'device-name': 'bdf_2', 'node-id': 3, 'node-name': 'uncorrectable-errors',
> 'node-type': 'error-counter'}]

This means they don't persist the user needs to figures out all the ids before
anything can happen. In device node world we have /dev/dri/by-path/<bdf> which
makes it much easier.

Also, I'm not much informed about the history and it's still unclear to me what
problem did netlink solve here that cannot be solved by anything else? But we're
too late for that discussion, and again, not my call.

> > Also, what if I have multiple devices with multiple nodes. Do they need
> > separate subscription?
> > 
> No, we subscribe only to the group not the nodes. In this case the group is
> 'error-notify'
> 
> $ sudo ./cli.py --family drm_ras --subscribe error-notify
> {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
> {'msg': {'error-id': 1, 'node-id': 3}, 'name': 'error-event'}

Hm, perhaps I need to spend some time wrapping my head around the new concept.
Let's catch up sometime this week.

Raag
