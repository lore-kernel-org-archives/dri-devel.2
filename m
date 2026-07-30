Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E75BC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F01410E6B0;
	Thu, 30 Jul 2026 08:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LJC65jgF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EA910E6B0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785400721; x=1816936721;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=ymVu4xx50BgWNM0vGJbFCoGjLrqx4ktDs+kmUwAWAtg=;
 b=LJC65jgF9Z+SqJXcqMcBlobWDNrGqYrQIYUXwPrSsNBreJBldHVdePbp
 to1mktAhzD4emEWDzF3Uc+ZXj46F/anWzCr8eeYSim8LOFAOI0LMyXqL2
 DYT84Koc/oaTtlxXBjrXIxEDv3PNSPU3PdgF2t4Qy5lS3pvX4Em1P8uBF
 gOBin/qV6fAAGw0UWQpXxgfFraaup6R4OEYaR6Rvv2W6la+w6tbHJfvVg
 DMXYxTYeslu0mXGdRF4HtEC5vh4qvRD25UiLOZv26yXztqEc7mHNAdRuq
 0IM+Dx3deJx2coJy4/2FKWK+UYr/v4Vr6aR96nu1S6HDxKCM9Hz5+n9tP A==;
X-CSE-ConnectionGUID: PppXFzS7QIGI2hQyFl6BxQ==
X-CSE-MsgGUID: yvS78uS7Q+axRsjFGAwxgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85778220"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="85778220"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 01:38:41 -0700
X-CSE-ConnectionGUID: vzuzgr2ZSiKF3WiWYj6b4A==
X-CSE-MsgGUID: EZvh6iSqRtqTB/7gSgDRGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="264513009"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.160])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 01:38:37 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: ps8640: propagate AUX transfer register
 errors
In-Reply-To: <CAD=FV=Wo-ps+aStGn5vCvb08tKx-rKDeu-r0bRVABL8zgg4Lhw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260723103509.2-ps8640-v2-pengpeng@iscas.ac.cn>
 <c1cfe79fabe97b3d1603a4fa064a18afb7d6810b@intel.com>
 <CAD=FV=Wo-ps+aStGn5vCvb08tKx-rKDeu-r0bRVABL8zgg4Lhw@mail.gmail.com>
Date: Thu, 30 Jul 2026 11:38:33 +0300
Message-ID: <b962d68e6640787a539690edf022b338a9b47bbe@intel.com>
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

On Wed, 29 Jul 2026, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Mon, Jul 27, 2026 at 4:40=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
>>
>> On Thu, 23 Jul 2026, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
>> > ps8640_aux_transfer_msg() programs the AUX address registers, starts t=
he
>> > AUX transfer, waits for SWAUX_SEND to clear, and reads the AUX status
>> > register. Several of those regmap operations have return values, but t=
he
>> > function only checks a stale ret after the status read.
>> >
>> > Propagate failures from the address write, transfer start, completion
>> > poll, and status read. This avoids returning a transfer length when the
>> > bridge register transaction or AUX completion wait failed.
>> >
>> > Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX c=
hannel")
>> > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> > ---
>> > Changes since v1: https://lore.kernel.org/all/20260623060635.16064-1-p=
engpeng@iscas.ac.cn/
>> > - include the AUX address and length in the address-write diagnostic
>> > - describe poll failures without assuming that every error is a timeout
>> > - add the Fixes tag suggested by Doug
>> > - rebase onto the current drm-misc-next tree
>> >
>> >  drivers/gpu/drm/bridge/parade-ps8640.c | 27 +++++++++++++++++++++----=
--
>> >  1 file changed, 21 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/=
bridge/parade-ps8640.c
>> > index 96332721cb69..56b48f8feab6 100644
>> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
>> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
>> > @@ -257,8 +257,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm=
_dp_aux *aux,
>> >       addr_len[PAGE0_SWAUX_LENGTH - base] =3D (len =3D=3D 0) ? SWAUX_N=
O_PAYLOAD :
>> >                                             ((len - 1) & SWAUX_LENGTH_=
MASK);
>> >
>> > -     regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
>> > -                       ARRAY_SIZE(addr_len));
>> > +     ret =3D regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
>> > +                             ARRAY_SIZE(addr_len));
>> > +     if (ret) {
>> > +             DRM_DEV_ERROR(dev,
>>
>> DRM_DEV_ERROR() is deprecated in favour of drm_err() or dev_err().
>
> Good point. I'm inclined to land this anyway, though, since this is
> nominally a bugfix and it matches the error printing in the rest of
> the function. Any objections? It would be a nice future cleanup to fix
> the error printing in this driver overall to use the non-deprecated
> functions...

Up to you.

BR,
Jani.


--=20
Jani Nikula, Intel
