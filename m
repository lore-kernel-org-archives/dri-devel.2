Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0564CC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0B610E282;
	Tue, 18 Aug 2026 08:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gIHyN+m6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5AD10E282
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787042638; x=1818578638;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NY3IeYryUEk82RGOycc9xMIx85glSlGzJpLBvZbyy+E=;
 b=gIHyN+m61sWTEKp90AFFY1Xqauu3wVydkoRNQrjoU+ZlKB3mPhUdRy6b
 Cn/OGO9oBGUE8DU4/XIGLERJ4dbn1fo+WSoHzX/+F86bo9kiJpoVjW+8V
 UzZptIthc+SndvJFah9JFM3pAG1yNa4YjnDS1Mt5VSfoZEJoNOl6KCOJc
 SN5Gw05SlPepJG5KCibHMUYIzaztqq/kwK0oYeCL9T8iqCjIXd7bDj+iS
 KwLKkfCFiIEvGmtGO4Xi86TvtWOPt1YC+OcGYUC7RaJJXovw94wPgCaI/
 Q66VqLw77HFJdvRzdwR/UgBqPo4gjHyMjzyatAUDEubr5HTr+zlkDgJGK g==;
X-CSE-ConnectionGUID: JFguM991TASu3M5EW/4IzQ==
X-CSE-MsgGUID: XStiMK61Rhyd/QEQYzVGjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98682400"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="98682400"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:43:58 -0700
X-CSE-ConnectionGUID: ZPiuLXAGSJG5Ask3BQL+PQ==
X-CSE-MsgGUID: WNcbX40hQ5i8Pt0hGlpUdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="303390206"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.209])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:43:54 -0700
Date: Tue, 18 Aug 2026 11:43:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Piparo <holofermes@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] drm/ssd130x: Implement ssd130x_write_cmd() on top
 of ssd130x_write_cmds()
Message-ID: <aoQbR8lBza8kmar0@ashevche-desk.local>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-6-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818080626.30430-6-amit.barzilai22@gmail.com>
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

On Tue, Aug 18, 2026 at 11:06:25AM +0300, Amit Barzilai wrote:
> ssd130x_write_cmd() and ssd130x_write_cmds() each carried their own
> regmap_write() loop over SSD13XX_COMMAND, differing only in how the caller
> supplies the bytes.
> 
> Turn ssd130x_write_cmd() into a thin variadic wrapper that collects its
> arguments into a small stack buffer and defers to ssd130x_write_cmds(), and
> move the protocol comment onto the latter, which is where the loop now
> lives.
> 
> No functional change: the bytes sent and the bus transactions used to send
> them are identical for every chip on both the I2C and SPI transports.

...

> +static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
> +			     /* u8 cmd, u8 param, ... */...)
> +{
> +	u8 buf[8];
> +	va_list ap;
> +
> +	if (drm_WARN_ON(&ssd130x->drm, count > ARRAY_SIZE(buf)))

For byte arrays sizeof() is sufficient.

> +		return -EINVAL;
> +
> +	va_start(ap, count);
> +	for (int i = 0; i < count; i++)
> +		buf[i] = va_arg(ap, int);
> +	va_end(ap);
> +
> +	return ssd130x_write_cmds(ssd130x, buf, count);
> +}

-- 
With Best Regards,
Andy Shevchenko


