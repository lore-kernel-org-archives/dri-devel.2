Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50204FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 02:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D01110E902;
	Tue,  5 May 2026 02:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gcJs2SOj";
	dkim-atps=neutral
X-Greylist: delayed 477 seconds by postgrey-1.36 at gabe;
 Tue, 05 May 2026 02:23:33 UTC
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9820110E035;
 Tue,  5 May 2026 02:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1777947333;
 bh=9Ha0x1iziaemk5qEGAzVk/tIiaPr9YK8E3ttBsGz63c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=gcJs2SOjfX3fhIwAapMqsfPIieDdEN8wuaIY0RMebl3OGYLr/sNipalu96Fl5MzwP
 AnhVFyP8Ljb+z/3LVuKhMP/D6WVuNtNfTndF++9oGmPb1t9771FTXig69sGMpSwXMR
 t+FaoxKbEGNJfVmjmv8FP6sq+W5Y9EVSoyePphSmjJo0ZfL2hSfquOKY3AdcXjarcw
 SVdI51OIEi0z0KkAQVZ5waAC8lU3oqSHK5JF3/4gXQEltm5OfFTKHmgJBP/QHqsftS
 /ydIQQrMKOK6RcPxL1C/xTLp+Dr4nWvPIPAabX47rRqf9VczQtfX8tokMKas8oIIrC
 AAenhf/EpMKCg==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au
 [210.10.213.150])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9685D60417;
 Tue,  5 May 2026 10:15:31 +0800 (AWST)
Message-ID: <9cee1c2102f53bb33e96c186c21ba6447d1db4cb.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH 0/1] Proposal for in-band firmware update over
 PLDM-MCTP
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Badal Nilawar <badal.nilawar@intel.com>,
 dri-devel@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Cc: rodrigo.vivi@intel.com, wojciech.drewek@intel.com,
 michael.brooks@intel.com,  heikki.krogerus@intel.com,
 michael.j.ruhl@intel.com,  thomas.hellstrom@linux.intel.com,
 michal.winiarski@intel.com,  anshuman.gupta@intel.com,
 jacob.e.keller@intel.com,  maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com,  anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com,  mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com,  singaravelan.nallasellan@intel.com,
 kelvin.gardiner@intel.com,  matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net,  edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, james.ausmus@intel.com
Date: Tue, 05 May 2026 10:15:31 +0800
In-Reply-To: <20260504193420.1232842-3-badal.nilawar@intel.com>
References: <20260504193420.1232842-3-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
MIME-Version: 1.0
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

Hi Badal,

Thanks for sending this RFC through! It's good to have some early input
on the structure here.

> Problem statement:=20

This is exceptionally verbose for "we would like to add a MCTP transport
driver". :)

> Option 1: MCTP Transport as Part of drivers/gpu/drm/xe Subsystem

This sounds like the best approach to me. The MCTP transport drivers in
drivers/net/mctp are intended to be fairly hardware-agnostic, and all
are spec compliant. I see no issue with having your own code do a
mctp_register_netdev() from elsewhere in the tree.

I'll also reply on 1/1 with some implementation comments.

> Note: This RFC is prepared with AI assistance (e.g. GitHub Copilot etc).

Then please ensure you have read
Documentation/process/coding-assistants.rst, as you are missing the
Attribution requirements from that.

Cheers,


Jeremy
