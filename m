Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038B610987B2
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43E510EB7C;
	Fri, 20 Mar 2026 16:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="N00QLdSd";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B193210EB7B;
 Fri, 20 Mar 2026 16:41:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 999CD4E4274C;
 Fri, 20 Mar 2026 16:41:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6F72E600E0;
 Fri, 20 Mar 2026 16:41:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CC19410450CB3; Fri, 20 Mar 2026 17:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eh77EuwoDIAn83QDMOVMLcEg6HxjeY8oda8hPWbgOus=;
 b=N00QLdSd5XpxjdMwdQdIaqp2FAzEjq22XCtYlIBiP4VPmDzw0D5bn2NHjDhKm4FmldPuqd
 L0gXIklwnT8JNBecTSFn39+Fmd7jjsAVieiKONugV3feaCKrPER5lxZ+LYgpeTFIJDxN1j
 HwvPlDmigPd3jLyElnTTIIFAx1I0DCrCuvKMHBfuSjKw9fIa2+mbiC5kyzM2k5M9hUlgz6
 1QTAQiUyWyQWJoTMZPFrdNSTP+X6y4lUqohiUGhjUfJBPbZDA87YYsdjuz7TWtNqAcKmjp
 6xlmrSJSsTEBQQFChEL7mvItopobDIRZnJU396Xmkj53l9zaENziY+Nn/Uxv9A==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 17/65] dyndbg: hoist classmap-filter-by-modname up
 to ddebug_add_module
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
In-Reply-To: <20260313132103.2529746-18-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-18-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491433.6181.524572822074430485.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=571;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Z3OSfSV+JlcQP8oSdE9xs854dk0KsNRyeB4V0xIm+Lo=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjXe6hAK5x2nY1wm7oDb6qiRn1X+XrHRgAZ3
 afaQhwSkzmJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab141xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOLFwBAA1yyp58R7pkYB0lCMwhIjSCLXxjN1z+X
 bjE67YAXk0ORfVQWfC/JYCCTdSqq/+AYTLzFfULJOiJcXrN4SQ66i0khwyioqDKna+2ffilQKKo
 m53jV1EVn7HZNq1YUw0txNc+j8QkpkhE0lk5fdDT48CN1J++om+oYBKrQcyiBsearD2PFFI+eMI
 mSKpazZ+sVsXB2TyaN9rLsDm89cdmWX+zqaizxLx7Rjp+SsS5yASBpnFqoSHG6nYsrEgWUmHdm3
 00E0Aa5E6XiixMP2RAx8Fa7geUBz3T2haJCSUm0Xn65ZaI45d+d6h4x89aqyzXZ7DzdaJOvodu/
 RaZC22RCl+J73N7RqfuJH2JhVN0xAHFmFgnQ+h56fMQukQjlgZWRy5VTfel+luPOgaq8gt6qNRN
 /7NfnCt8XHMBNT5TMXNelayPuwUtpm3O0MbGeOH3gTCuKK2IJxvVwzx05+4z97OvGhxNJgc4bdr
 WS272vfr4NVmekFVulxtzb9KKdm1AlRzUnTwIyQAfBl77mhrwOiP78tOTDMk8yiXvWuFCv3q4Rj
 rCmhr58uqqUYO5RPBGSrJIVbAV+745WXr1slckV2GI/HL8QV7d9LiViEVgPA6LzQqJZ9LB98FL1
 /Jt4sMt8+ljydvzSkMNv5cFb62jGVpqLjCgc/dsSwG8rQ6u5H/j8=
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

On Fri, 13 Mar 2026 07:19:42 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The body of ddebug_attach_module_classes() is dominated by a
> code-block that finds the contiguous subrange of classmaps matching on
> modname, and saves it into the ddebug_table's info record.
> 
> Implement this block in a macro to accommodate different component
> vectors in the "box" (as named in the for_subvec macro).  We will
> reuse this macro shortly.
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
