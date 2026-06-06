Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E37ACD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 20:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5439610E66F;
	Sat,  6 Jun 2026 20:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="l0ntZMmV";
	dkim-atps=neutral
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6049910E66F;
 Sat,  6 Jun 2026 20:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780777424; x=1781036624;
 bh=jcJgKWkR7ZYNXmZQ/2TOyoNRGSsz1U5CVTE5gVFMtwQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=l0ntZMmVSdi976sJnS4C2kwJM9vPX9wSGgidkLYyqcE5/fwfIivJKQXMnlxsoq5a3
 tpqk0+T1ARn9GLEBJQJHQu+xy/uYq8PPU+LdbV2zif4fP+ShqyBZiLph2/5RlIoOBj
 lW0QH8eSm8Z1k3JizogJTBTrN3+N6mMwrk9KJZOcOr5sb5Q3sJcsk6Jumf7EGAeB6b
 inIGaTwHah05V1VZei/w5LVISZjzaXyYkQOhq3lwTemmZQbnEH91BtRTP2rju55Ryx
 h9+Qp4sBWWaSD5AD+g1v9smdkrFiksB3gMire702GJhs0hSPKjgOu2zhYQpoCfPilK
 afMLsiViqBxZA==
Date: Sat, 06 Jun 2026 20:23:38 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add flag for sending all DSC slices
 in one packet
Message-ID: <C7NqucjdVmZMexR2CNQfB4x8PqX_18JqIePxmtHqS3jeL5U1CFSZIpNqfH7zERiD3tIbRshVpnmok7akJWPrUCaoSCU1QD-rdQjmQ8cEw-c=@pm.me>
In-Reply-To: <kxbtfiizjbprs4sqkmtotbaeqmm5e3draavlmdskhmws2l6ivq@73r3hnghmmrv>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-1-0a1b316f8250@pm.me>
 <rrgnyzpxo6g3ufjcnxnshexjotyq3riruc6wqjhirmcjo4qdta@gmwhs3mu2xld>
 <kxbtfiizjbprs4sqkmtotbaeqmm5e3draavlmdskhmws2l6ivq@73r3hnghmmrv>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: b52e804e0ff33d68455a5fb9bab237e0bf7a4299
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

On Monday, May 18th, 2026 at 2:02 PM, Dmitry Baryshkov <dmitry.baryshkov@os=
s.qualcomm.com> wrote:

> On Wed, Mar 18, 2026 at 12:33:45PM +0200, Dmitry Baryshkov wrote:
> > On Wed, Mar 18, 2026 at 09:54:04AM +0000, Alexander Koskovich wrote:
> > > The MIPI DSI v1.3 spec defines two modes for transporting compressed
> > > pixel data: one slice per packet or multiple slice widths in a single
> > > packet (Section 8.8.24 Figure 40).
> > >
> > > Add a MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag that panel drivers can
> > > set to indicate that all DSC slices for a line should be packed into =
a
> > > single packet. When unset should default to 1 slice per packet.
> > >
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >
> > As I wrote for v1, I'd prefer to get more opinions before applying
>=20
> Any comments? I'll apply it in a few days otherwise.
>=20

Hey Dmitry, is this series still able to go in for 7.2? Not sure if it's to=
o late.

Thanks,
Alex
