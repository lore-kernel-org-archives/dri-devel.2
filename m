Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6741EFDEE27
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB15D10E14A;
	Thu, 23 Apr 2026 16:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XPWle9fg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFB110E14A;
 Thu, 23 Apr 2026 16:29:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DBF16014C;
 Thu, 23 Apr 2026 16:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE7C2BCAF;
 Thu, 23 Apr 2026 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776961764;
 bh=1dP9r6KsChftBuI2JpeBlTGZwoiAP3vqscR1wZR1+t8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XPWle9fg+rCRf4fF10a5hmPtRkHDlPtsJk0d2bKNI3S/eU3sMeys6exToKvbxp3hv
 l//Xrk5c+s28itVvpa0KD1DMBbnc9y3EuW0MKA2HUey+bLMd/UGRX8j003VF8jZDPA
 X6xR6MAnFR2sa76Vq/VWl4y+xhPtAcrimXWxVvD/oO3nCeFI5AmD55cu1XzEcWzNe5
 KFGlkQ8mI0imyo72pzgze1PAsGMAvnJR1NdjFUmy1XmZESypiGmVdLDojdV/QvQk2O
 rEYfOwCFwAOcQNLH26jMxw0zZjUzJmpsCjmVl1sqMrsWrbvAmKqr9EBTQjkduHeUz3
 tq1LKhFX6jRwg==
Date: Thu, 23 Apr 2026 09:29:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <anshuman.gupta@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
 <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, Zack
 McKevitt <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar
 <lijo.lazar@amd.com>, "Hawking Zhang" <Hawking.Zhang@amd.com>, "David S.
 Miller" <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
Message-ID: <20260423092922.6c527d75@kernel.org>
In-Reply-To: <65c6839f-a92d-4122-b347-a1250dde961d@intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
 <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
 <adc6hTz-xMopiJsc@black.igk.intel.com>
 <69c061b4-eb40-4e2d-aeaa-5dfa47b2db8c@intel.com>
 <65c6839f-a92d-4122-b347-a1250dde961d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 23 Apr 2026 11:22:45 +0530 Tauro, Riana wrote:
> We had some questions regarding events in netlink
>=20
> 1) According to netlink spec, "Events are considered less idiomatic for=20
> netlink and notifications should be preferred."
> Since we currently don't have a response that matches a get operation to=
=20
> use notify. Would using an event be acceptable?

I have only glanced at previous messages but would it not work to
include the counter values into the "event" as if it was it was a
counter get?

If it makes no sense - it's fine. We have been adding events in some
places, too, in networking. The thinking is basically that when the app
that does the user space monitoring starts it will often want to know
the state of the world. So we end up with "get state of the world"
and "notify about state of the world" which should really be the same
format.

> 2) Is there a way to check if there are subscribers to a group before=20
> creating the event message?
>  =C2=A0 =C2=A0Currently the subscriber check happens in=20
> netlink_broadcast_filtered, but a reviewer suggested we could
>  =C2=A0 =C2=A0optimize by skipping message creation if there are no subsc=
ribers.

Yes, genl_has_listeners()
