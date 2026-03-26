Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536FC10A62ED
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BD310E196;
	Thu, 26 Mar 2026 14:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="DoS9cECl";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A24310EA92
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1774535198; x=1774794398;
 bh=m+sNoheho1OrFl4QBII3exZTKJg8TKL0T5hDuECTkLo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DoS9cEClyno2/RZIqQZcV5U/T9aKFKlY15dR6v6FQZHcG9zhSQHsehnabaUTGwaAq
 d9QIqhI5KuvjDX1D1yjAT3tMexeWnm39VNsAOp8ZDZU+e8skfAdGY4AlPjbmtFHDMn
 Z94mydzAEX40tQmmKY9256ReGEfaZtk90UjabzM8YE+0lKaYcs26akbayYtHC/JPpg
 Rn6Zr0gbs1ACeh4FIPpq3Hyj8IgBrtkDX9dCR2d+493fuP+CB6y6qP1Tib/3tszJYB
 5CfcD0xx7LhP6rAn6z9Fd86YPKHnE/bO1hQWrrbPp2n7HtWyET2YfkSJRXAsXNyqj3
 013jZ0bte9flw==
Date: Thu, 26 Mar 2026 14:26:29 +0000
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
From: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v9 02/11] drm/fourcc: Add DRM_FORMAT_XV20
Message-ID: <aocdbgbLe5WhUEOGeLg3P7fRDM8i72H9zBuUnoAjjsuvBLfMPofrPtaUEjII_43KXf1wCbv1G9UutJKMkWLaEcBSnrlUV78Wrhu6l_Z0xi8=@emersion.fr>
In-Reply-To: <20260325-xilinx-formats-v9-2-d03b7e3752e4@ideasonboard.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
 <20260325-xilinx-formats-v9-2-d03b7e3752e4@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: d647f5d8f1d869e3931ef15cf27673cf762af5d1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Wednesday, March 25th, 2026 at 15:02, Tomi Valkeinen <tomi.valkeinen@ide=
asonboard.com> wrote:

> XV20 is 2 plane 10 bit per component YCbCr 2x1 subsampled format. XV20
> is similar to the already existing P030 format, which is 2x2 subsampled.

I don't know for sure the multi-planar YCbCr format name scheme we're
using, but here are my observations looking at P, Q and S formats:

- The first digit indicates sub-sampling. 0 for 2x2, 2 for 2x1, 4 for none.
- The two other digits indicate bits for the Y channel, one of 10, 12, 16.
  One exception: Q401 indicates reverse order for Cb and Cr planes when com=
pared
  to Q410.

P030 is a bit of an outlier here since it's the only one with multiple
Y samples. NV formats are also multi-planar but seem to use a completely
separate scheme.

Given the above I'd say what would make most sense to me is to use P230:
keep the last two digits and change the first one to indicate that the
only difference is the sub-sampling. Does that make sense to you?

Simon
