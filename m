Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665DCC44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8CC10E691;
	Tue, 14 Jul 2026 15:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oztwX5PP";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C7510E691
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:46:15 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so494019a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784043974; x=1784648774; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nNt4aFBQBTeC6gh7XjshPB2bRqBQHmW7ChcRLsTBtjU=;
 b=oztwX5PPCy3FIDC/381yuzjqFrAtiy7JnrnZMmSeDSv3PS6Uu5O9uBvtkM7GJa0Fqh
 r+/wRRBr9dQ80Bm0ekdruwEiLu1SXW18ZRMtKIP6EXjVWO7oCXxSxI8oEV29hENh91yB
 cNKRKfKhCNwWeHWdpSQQ242a7X1coE2BFNvgT+F5QwITvzKB3v5mnkVEl6tFB2o9NodT
 ZDQvyQBaCd6Jqus43XJ08akyC9UIDACZnvhK+ksjBtaq1MEdiTxqupf3vLA49X6nvMhh
 WExzW+/W5qpNZfxlzTyG5PgN5vuHOFqhjmupIvk7CeaeNw2AatTvHd1s4qdP5E+u/Rnd
 2TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784043974; x=1784648774;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nNt4aFBQBTeC6gh7XjshPB2bRqBQHmW7ChcRLsTBtjU=;
 b=IEFPFjhkjPE5lshRpJ6MFQ1OBV5zWEGoLQqmuOykoIZFFxTWET3G3LGfpT1AlidV9H
 H4jPli0TFLDzjUmZdD1TMVpXgBtcABrG15tehRaP/OWBoZYk+eOv5Heija/ia+jNkt+9
 M4SotRdpI9N3bCOsNxzwFDC14f1OZr8JPI5mZK9KdB4jZJdFKJ4ijW5U5Klw/cDoMCWX
 RnBnAhrwIwNiBI3lPNqPejhSoTuYXWO0dJd0GbXMshX3HUW7BYphaOxaJBHrxtJRz6Kr
 xWpXQ/ide9safJfmJvne6gBdsD5t+C6TkfRJtqe2AKzaPalIUD/ZAvq7jDj2TSejMM7+
 C75Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ810ZD4Dq3OTYEzx19Mvw15cEqVvsyHvpx5Ha2CT1F3T6FgBaOJJbKo5Sw+7ui5k7jdGqEw1gQ2ouY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYhw+oRRQjxKzBFPuVNPez3wx9qV99dgVSDVEwOkkFqQrrfGmE
 +N4HdMfxpzsa4WnAxsxyuLwKtQg+xt9ytId3NNnfyMCtPkBaJ+75WBkf
X-Gm-Gg: AfdE7cmCTUc9Yuup/ujYiQxEcM98l5jL4Ii+QPQIlV7M0hZAwvZypq2H4s9Kx8d+o+2
 ftxiHjOc1kWnVD9uHB01XEHH8Ix8GlYFr9ANtAGUCIJzz5aZN8v3CRtME49ArD/0rvHXrpR3TXn
 nGe5CpKxwYvQQJVR5IKA5j8LPFzpzkuY+CJz7UDUAMDLxdTaNh4o0Uqlvvu7kPak/vWDx9twAIP
 zx3E+9boEguasjfch5wYLrUHTS61Ik0qT3Yws8Yb7y5zZuQ8sD5Kr4YcNhdf58PB1v7zmlthbcf
 xzb3iGBdA4QuYlB+zrIoaW9Huk46xUkGV/LrIwZEdTpc9tvzQvL2bpXqY2rUx8XM0cL8oilkBPK
 8ewOt/UlwFuPTbl7vIJrfZIZzyII2eWgnRbW/DDqd/1VeW+aJ9rLr2fOmQ6DStRR2oF5lXOYFG9
 nCdtS7kAPxMEZfhWE=
X-Received: by 2002:a05:6830:3108:b0:7e9:c76c:abe3 with SMTP id
 46e09a7af769-7ec096027a7mr9375213a34.6.1784043974139; 
 Tue, 14 Jul 2026 08:46:14 -0700 (PDT)
Received: from localhost ([74.80.182.78]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2bc241sm15641928a34.20.2026.07.14.08.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 08:46:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 18:46:06 +0300
From: Dan Carpenter <error27@gmail.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/i915/bios: Move a variable assignment behind a null
 pointer check in intel_bios_encoder_supports_dp_dual_mode()
Message-ID: <alZZviFT2jfABiZq@stanley.mountain>
References: <e81277a0-93f8-45e9-9fa4-7c2c2df9c311@web.de>
 <alZVl0o7uBoncUos@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alZVl0o7uBoncUos@intel.com>
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

On Tue, Jul 14, 2026 at 11:28:23AM -0400, Rodrigo Vivi wrote:
> On Mon, Jul 13, 2026 at 04:05:53PM +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 13 Jul 2026 15:56:46 +0200
> > 
> > The address of a data structure member was determined before
> > a corresponding null pointer check in the implementation of
> > the function “intel_bios_encoder_supports_dp_dual_mode”.
> > 
> > Thus avoid the risk for undefined behaviour by reducing the scope for
> > the variable “child” behind condition checks.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Fixes: 044cbc7a74c136f12a80c855cadd1b085084aef1 ("drm/i915/bios: Nuke DEVICE_TYPE_DP_DUAL_MODE_BITS")
> > Cc: stable@vger.kernel.org

Please stop adding Fixes tags to these and talking about "undefined
behavior" in the commit message.  Pointer math is defined...  It's
just a style preference on your part.

regards,
dan carpenter

