Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255A810987AF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBAD10EBD5;
	Fri, 20 Mar 2026 16:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xV8pZhs2";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1618610EBD1;
 Fri, 20 Mar 2026 16:43:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 70E63C5668D;
 Fri, 20 Mar 2026 16:43:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EABEE600E0;
 Fri, 20 Mar 2026 16:43:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9099D10450CB2; Fri, 20 Mar 2026 17:42:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vV4gsNPs/+9oJCujqH6WyEcXzp6KiZjTy4v+hsMvZSs=;
 b=xV8pZhs2H7WaaIuTY8MSPDhT93IYjt5HFlfHkBkbpVFR1sWwOG3jaF+lDUd2WBADLqFZgY
 pYj2aJHhORLmUnqpYro8Kmm707edOh6ZllNAIqRW0G9DkR/hld41nj4eum/6enqWlGrhuq
 0hRAl8O2g5Wms3H0wzS/Rbw1aV0PUGEEPrllZI/P8zpvX71ffRhUu0ARNc32eoHafPSljX
 BVDOpueuvQWa9h8tahAApH+HmiOl+5bWl2072cyfOP/AUzVNtKryfqVBDzrthWMf+DV8U6
 1ud77E7rb4o7G8adqmRi3ZiQvskruXfUb+zpNejhUEJlIuOgxm9aYovgzShz7w==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 49/65] drm-dyndbg: add DRM_CLASSMAP_USE to gma500
 driver
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-50-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-50-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491465.6181.10368703694909553814.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=344;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=NgQ+B2TOXOBiCWB/97Ln87I4OJAQ1bvyhvRS8W82urw=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjacpucBdE65Nc9Qp8fLHET5D7QN/2/sOFpe
 YAEcdsDvQ2JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOIeeA/7BNGbotVtzRRztWjECeEH3ZjIHAmQf6y
 Hc0mG8BxjSsxBNC3PUZMEScQC38f7Qp3RapP0IRCB12EoiwnEoUq8nCkdXun/DNNgPWBk1Eahga
 RwmuJKHO7BOia6jgn3OWMiRLA3hqjAcxUaqMnmwn5Xf+IOWm+zkquR3wJSfV2yVnBWgQCtxLMv7
 6tNczTRsVNlrldLkQbmfKUkIib9IT6GINeUKrubq629l3lR7eutBuSCM0z7ysiA12urMDqn3U9O
 bmtjtVMu/sXEX1p7089KQ5SWUFwvfJSYroWHhdbIP1fIATAD1dcO+58UhhCwocAVzGMon8Sb3b1
 j07YD5GBYAzNJwABF381QDqwXP3BSfa+UjiqaUGg0ZKL6eIyP/kX6MdXfX4IgMBgNFkROOgAyzM
 lnJ1wfagMvqtmtrjPpzE41RPJwlJmFgQW/Mn1vo80mmyScTSIrkgYoVfJyCFILD8dVaS2Txw4lr
 zTCnfcKV0NqTWcbStfFMqH4fBeHGg1Wfhh3kiodNQRNiIUlQUst7UflH3gyF+B9TjxfFKwPrUuI
 ghwYLQCw4zvuyHF3Oo0ywFg3ZIs0usQ6VcbMU3xnaqmEmoHG/ROefp8IRFQZlNP83liBMiLevgA
 OT6g6ISddF5A/UWiGOTBB8UeGLcrKClX5aCgNBIzW5Gug1g6LtEE=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:20:14 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The gma500 has 126 DRM_UT_* debugs, make them controllable when
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
> class'd debugs.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
