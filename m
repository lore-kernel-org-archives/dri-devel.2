Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B0ECCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1E210EA86;
	Mon, 19 Oct 2026 11:19:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 856DD10EA55;
 Mon, 19 Oct 2026 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792408737; x=1823944737;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=OjjfwwLZbDqlnlqqnl+VhPdVOwG66obu/ngPBAEEJ60=;
 b=FYXtzA46uunxo6PJ6yY9DdiMkwbV2RhJlLvP+vGR77Z7Qwd/Bp28cMLz
 c5V4EKfpJGzO8ilDHow7ZDjRTvSuhQYwwMs73iLlOdTe8VIvPA+sZZD+7
 EZNCcamUHicEk3xIwXY4ksdtOHKvzOpuSZI5LyuS1aM+y5d/LGl8HXkCG
 yvwPE+apuxmUz7GcLZRPuB71nOFpUvVC0WyDwWuf3rVS2fem8Q5GpgNKB
 092aRqjvxMmbHgYLzgPnAYnGBcsEClOC/tdzG8S4GZZoWRqfczZokp/sz
 RJUVdM+TgR46g7rE0+anPwlfZTVQUFGHEtg4cBRZ82Diy90+jGA30hOMi Q==;
X-CSE-ConnectionGUID: NNa2n/ihSUWlb6/9KFAE5g==
X-CSE-MsgGUID: PX2p+8inQyGDnBDmrMJm1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="993083"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="993083"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:18:56 -0700
X-CSE-ConnectionGUID: 2EQXLQQ7Q3Wkw2XbewmDww==
X-CSE-MsgGUID: 34XvGfjIT8a4JiB7DgQHWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2570954"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.209])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:18:53 -0700
Date: Mon, 19 Oct 2026 14:18:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Anderson <mwwa919@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hans de Goede <hansg@kernel.org>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV
 MIPI sequences
Message-ID: <atX8mpg19_WkIa27@ashevche-desk.local>
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
 <atXp2NSPKZUPj8sq@ashevche-desk.local>
 <CAL-Wm=O-Gr3CuvCn8iSQceQMhu=LGFz0SPhmWeFL=RiVnoprdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL-Wm=O-Gr3CuvCn8iSQceQMhu=LGFz0SPhmWeFL=RiVnoprdw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

+Cc: Bart (as GPIOLIB maintainer and author of the reset-gpio rework).

On Mon, Oct 19, 2026 at 07:03:57AM -0400, Michael Anderson wrote:
> Thanks for looking at this. I'd like to make sure I understand before
> doing a v2.
> 
> Here both users of pin 10 are i915 itself: intel_dsi_vbt_gpio_init()
> takes it as the "backlight" enable GPIO (soc_panel_gpio_table,
> PPS_BLC_SOC), and the VBT MIPI sequences on this tablet then toggle the
> same pin as the panel reset (low in ASSERT_RESET, high-low-high in
> DEASSERT_RESET). Do you mean describing pin 10 with a software-node
> "reset-gpios" reference and having both paths go through
> reset_control_*(), or something else?
> 
> One concern: the VBT drives explicit pulses on the pin, and shared reset
> controls are refcounted, so a pulse from one path wouldn't reach the line
> while the other holds it deasserted. Would an exclusive reset obtained
> once by i915 and used by both paths work instead, or am I missing how
> reset-gpio handles this?

But then it sounds like the request-by-demand?
Bart, any ideas how to address this case?

> On Mon, Oct 19, 2026 at 5:58 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrote:
> >
> > > On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> > > backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> > > itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> > > GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> > > sequences also request their pin through gpiolib, so when a sequence
> > > toggles one of these two pins the request fails and the toggle is
> > > dropped:
> > >
> > >   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY)
> > >
> > > Before that commit the pad registers were written directly, so the
> > > sequences could still drive the pins i915 owned.
> > >
> > > The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> > > panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> > > MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> > > failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> > > during takeover and stays black, even though the backlight PWM and both
> > > enable GPIOs read back as on. The tablet only has a usable display
> > > with nomodeset.
> > >
> > > When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> > > corresponding descriptor, set it through that descriptor instead of
> > > requesting the pin a second time.
> >
> > Ah, nice, this should be solved via using reset-gpio, which is exactly fixed
> > for the reset shared lines case.

-- 
With Best Regards,
Andy Shevchenko


