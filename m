Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8616210987B0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B974510EBFF;
	Fri, 20 Mar 2026 16:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ehHFLJme";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69A210EBFB;
 Fri, 20 Mar 2026 16:43:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D93331A2F12;
 Fri, 20 Mar 2026 16:43:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B0214600E0;
 Fri, 20 Mar 2026 16:43:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 62B8A10450CB3; Fri, 20 Mar 2026 17:43:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025023; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lRME75nZ5IjiOQqvGi2z388Xo/P305LX3Jwfh4O+I9Q=;
 b=ehHFLJmePtppOLvir1UeZHE7ZOVuRdohtwtjK6sXBNCNZFHdAlJSEdIaf4zIQpfs1Rcwjb
 HYKTEfcOhZdxiXITSxX6i0CiBE2RsZ/HlQ/SqTMVODTLHJ0xYgBdZwcBKiMpdWhCXK3Wfb
 GswA8h4lzEOw/9XwARsEtkOd2iWAhrHgq9BV4tTR6sOMIacNxslcsJejOtCEywPoRad1G0
 n9bGSLIohD4W+hnY+rfIaHIoXbCG45qscwJnlzK1NgZbH8+GTyPVc3gnpjZ1mkP108wzsO
 hrCrDr/x8Ok1l9YETg2d0qkLSN3H4OJ9gNXde7FgCXrN9a6DXD3q300T+P4DHg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 61/65] accel/ethosu: enable drm.debug control
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
In-Reply-To: <20260313132103.2529746-62-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-62-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491480.6181.6449203113049115438.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=426;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Csz2VdFCLeQS26BklNvMRkpRSthxwjNTh1RVfmFt3vY=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjbq2Lr+ZM0ltkVBCGSBbNvtCYdoPoZjCeJP
 kBRzm/YilKJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOJntA//dlpI87c2vbu2NJahx9hriOxl/4D+3c2
 lvCikyh3gxfokOwsMCXtx8TEdvWaxdTpo//LKZxQOzqoz2B+LPPG8ebDPRdQTm865oOJj0GF+RQ
 I9StFK42pawzoi7/+dMI1/m5j0h4ChczQPkiq7jMQUV8zA9EjLMpbZytOMlGTq/CQo+X1xJjNAy
 LzZHPoYS1ygDoUVjQz0/k0pmQD6JYw5uowk6kSdpSKe6udvf0x/kqS3tuJdl8XlSZtRbkKwPrDo
 xoVF7WFWNRmDazbitdkF/UDL5Dyab8UkWEis+WRwFUXA7dVBLgt/jn+bJCQpX6za35iegAOMUCb
 qoPI4MLUCEQ/hqZLWkoTwdMMXvJTwa1acf815LUoBNBSGoD0R/7Ez+Ov3CvoMZSb2kPFpGU7iA/
 Ir+swIFrIbslJ7zPDW9wqNOuqhGb7VjsQ8swjGrcEZOduqqAn9rB39K9SEdqPxyo8lGCG1MTlNV
 VSq3Sk0QTqFv+WA8HFBn7GcncjvM4vOVKnLax9/ZDnIVLYsD0oPGsuY8Ewr//WPoY1uKDoMG7kx
 WO8cOjs9JRhl2xmcBUfD6a32rQeI+LSqP7miUIKa1qpmlMXOdoTMHOlFlraQf4xmQyTsOG39WVh
 o8iyrMEQlTilideaNTv0D1/VWz7knyfXZr+u/whKE5/z01tg738o=
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

On Fri, 13 Mar 2026 07:20:26 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> ethosu.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
> to tell dynamic-debug what classmap enables them.
> Also include drm/drm_print.h explicitly.

Can you move this with all the other DRM_CLASSMAP_USE commits?

>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
