Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA7310987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF4B10EBE7;
	Fri, 20 Mar 2026 16:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="j3VG00Hg";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318E010EBDD;
 Fri, 20 Mar 2026 16:43:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 252E81A2F12;
 Fri, 20 Mar 2026 16:43:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EE91D600E0;
 Fri, 20 Mar 2026 16:43:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E496110450CB3; Fri, 20 Mar 2026 17:43:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cK5z8htdUygMYl0eTZqHZsYRcDJdePwB8qacryqOx1Y=;
 b=j3VG00HgAJtx9HdZYZ+cyUt39lP3U0MxwOQxixln+kWYs9AqI5je0lJKArXWE1TQGTMfLq
 eY5Ty+u65805OGrgPN8VASBkBxvz9PLOmCRv1jAxkd/BsrU6+Fdp3pOCQypPfiM05ahhlR
 7FJfkSA0hT0XM9MjFVz8hZNJG5twmi3tbkLCLhbkIA6vQf3tlKHy3+qrlwEuZaxFXJNZKa
 o8ov4ESoa0TSsgdt2IlsYRfOk1IvpN8e5qcGwQrblV+sFRBguePK6N1+AxYEllFYRXs8B7
 He28hpsyoiuWiW4qXv4Uuu8WYbrebEm1nqiEDfvzkmdiMgfwQ+Hco/XXQBigUA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 53/65] drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
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
In-Reply-To: <20260313132103.2529746-54-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-54-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491469.6181.8846320095094404944.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=347;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=PKzHlKjEmotcsWlpXN/SSQtmbQyrQ/QGvE0m7NThays=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXja5SPLZOTKBXIoRBW/ljksJBjmyIpMzIFe4
 8VYLOdymsCJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOKUqRAAp32ySuLeq0RyxzbtwW6tK7yYbLVi+Es
 mMcXZbB0ysAdTzNfwZcMfG9M5rulI6MkZVrXYBaqghxKHHf0n1YgHqqdpu5sDO+6zVYfoZfxSKk
 /ZCntgwl2hHzV66YHV9JUvJAAR1fh8uB/X4o4m6DAKW5sIfYycQs+UVMaCZSEL52uOLmOHOW2/v
 43U/HIyPh/MDoNfmhJAEtLxyP0duriSWc+HZ1M72WKvlAqr8ColZE4Qia6BTPTbknmFSdM+PQcq
 Pw++OD+U8TDxalTtlQHjMyJ6ucvZ8l0gKssJwVnTpBPA7Hh0mGlinhsYepnX4sHG8760el2Nrah
 077Teguu3eq6aptD+3YRsSuJpnK3p1/C5Yxh02HlWheeSJ53HYsCjQ1nd1FL4f0VCFCjGRLEtOK
 ltpdjjJhl622oaPvv6DULmrC4cfnVwDxMfjocnaEpbL0xq3qwDOjZI5wSQHKscxWgIfXPxvA8Sf
 MpZr8Tal+AAyh+59dG8F5XmH1Fdrn+gmkeKlurlj2ot/YwNXRXlHSwbB+V+2YOviT1+Whv4fWPx
 waZLEIEHXBENBziwrQQls2HDOjW668PGcx6vyPNrGF1xRD3gQW2f1RWDlbdcwwl8f19hBLmTdzG
 0BzcRJMf3L4A35zkd4KrGM7OrD7S6NMT+KQL6+Y0cDpAymfpqu6Q=
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

On Fri, 13 Mar 2026 07:20:18 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The udl driver has a number of DRM_UT_* debugs, make them
> controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
> that the module uses them.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
